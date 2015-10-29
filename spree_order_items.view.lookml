- view: spree_order_items
  derived_table:
    sql: |
      --
      select 
        a.spree_timestamp,
        a.completed_at as order_tstamp,
        b.order_id as order_id,
        a.customer_id as customer_id,
        a.order_code as order_code,
        c.sku,
        b.price,
        b.currency,
        b.quantity,
        d.max_selling_price,
        d.max_selling_price/a.exchange_rate as max_selling_price_gbp,
        (d.max_selling_price - b.price) as discount,
        coalesce(e.items_returned, '0') as items_returned,
        case when e.return_reason like 'Other%' then 'Other' else e.return_reason end as return_reason,
        e.return_tstamp,
        a.exchange_rate,
        a.tax_rate,
        a.item_total as order_total,
        a.adjustment_total,
        pre_sale_prices.pre_sale_price,
        case when pre_sale_prices.pre_sale_price is null then 0
             when b.price < pre_sale_prices.pre_sale_price then 1
             else 0 end as product_on_sale_flag
        
        from

        ${spree_orders.SQL_TABLE_NAME} a
        inner join
        (select * from daily_snapshot.spree_line_items where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_line_items)) b
        on a.order_id = b.order_id
        left join 
        (select id, sku from (select * from daily_snapshot.spree_variants where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_variants)) group by 1,2) c
        on b.variant_id = c.id
        left join
        (select variant_id, currency, max(amount) as max_selling_price from daily_snapshot.spree_prices group by 1,2) d
        on b.variant_id = d.variant_id
        and d.currency = a.currency
        left join
        (select order_id, sku, min(created_at) as return_tstamp, count(*) as items_returned, max(name) as return_reason from ${spree_returns.SQL_TABLE_NAME} group by 1,2) e
        on a.order_id = e.order_id
        and c.sku = e.sku
        left join
        (select variant_id, currency, max(amount) as pre_sale_price from daily_snapshot.spree_pre_sale_prices where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_pre_sale_prices) and deleted_at is null and amount > 0 group by 1,2) pre_sale_prices
        on pre_sale_prices.variant_id = b.variant_id
        and a.currency = pre_sale_prices.currency
        
        where a.state not in ('canceled')

        
    sql_trigger_value: SELECT max(spree_timestamp) FROM ${spree_orders.SQL_TABLE_NAME}
    distkey: order_id
    sortkeys: [order_id, order_tstamp]

  fields:

#################################################################################################################################################################################
############################################################ DIMENSIONS #########################################################################################################
#################################################################################################################################################################################


###########################################Order dimensions######################################################################################################################

  - dimension_group: order_time
    type: time
    timeframes: [time, date, hour_of_day, week, month]
    sql: ${TABLE}.order_tstamp
    hidden: true

  - dimension: order_id
    primary_key: true
    sql: ${TABLE}.order_id
  
  - dimension: customer_id
    sql: ${TABLE}.customer_id
    hidden: true
    
  - dimension: order_code
    sql: ${TABLE}.order_code
    hidden: true
    
  - dimension: currency
    sql: ${TABLE}.currency
    hidden: true
    
  - dimension: exchange_rate
    sql: ${TABLE}.exchange_rate
    hidden: true
    
########################################Product Dimensions###########################################################################################################################
  - dimension: sku
    sql: ${TABLE}.sku
    
  - dimension: price
    type: number
    decimals: 2
    sql: ${TABLE}.price
    value_format: '#,##0.00'

  - dimension: pre_sale_price
    type: number
    decimals: 2
    sql: |
          case
          when ${TABLE}.pre_sale_price is null then ${TABLE}.price
          when ${TABLE}.price >= ${TABLE}.pre_sale_price then ${TABLE}.price
          else ${TABLE}.pre_sale_price end
    value_format: '#,##0.00'
  
  - dimension: retail_markdown
    type: number
    decimals: 2
    sql: case when ${pre_sale_price} = 0 then 0 else (${pre_sale_price} - ${price}) / ${pre_sale_price} end
    value_format: '#0.00%'
  
  - dimension: retail_markdown_tier
    sql_case:
      0%: ${retail_markdown} = 0
      0 - 7.5%: ${retail_markdown} < 0.075
      7.5 - 15%: ${retail_markdown} < 0.15
      15% - 22.5%: ${retail_markdown} < 0.225
      22.5% - 30%: ${retail_markdown} < 0.3
      30% - 37.5%: ${retail_markdown} < 0.375
      37.5% - 45%: ${retail_markdown} < 0.45
      45% - 52.5%: ${retail_markdown} < 0.525
      52.5% - 60%: ${retail_markdown} < 0.6
      else: '60% +'
    
  - dimension: on_sale_flag
    label: Sale Product Flag
    type: yesno
    sql: ${TABLE}.product_on_sale_flag = 1
  
  - dimension: pre_retail_markdown_price_gbp
    type: number
    decimals: 2
    sql: coalesce(${pre_sale_price}, ${price}) / ${exchange_rate}
    value_format: '#,##0.00'    
  
  - dimension: price_gbp
    type: number
    decimals: 2
    sql: ${price} / ${exchange_rate}
    value_format: '#,##0.00'

  - dimension: max_selling_price
    type: number
    decimals: 2
    sql: ${TABLE}.max_selling_price
    value_format: '#,##0.00'

  - dimension: max_selling_price_gbp
    type: number
    decimals: 2
    sql: ${max_selling_price} / ${exchange_rate}
    value_format: '#,##0.00'

  - dimension: selling_price_tiered
    sql_case:
      £0 - £20: ${price_gbp} < 20
      £20 - £40: ${price_gbp} < 40
      £40 - £60: ${price_gbp} < 60
      £60 - £80: ${price_gbp} < 80
      £80 - £100: ${price_gbp} < 100
      £100 - £150: ${price_gbp} < 150
      £150 - £200: ${price_gbp} < 200
      £200 - £300: ${price_gbp} < 300
      else: '£300 and over'

  - dimension: quantity
    sql: ${TABLE}.quantity
  
  - dimension: landed_cost_per_unit_gbp
    type: number
    decimals: 2
    sql: ${product_lookup.total_landed_cost_gbp}
    value_format: '#,##0.00'
  
  - dimension: discount_level_tier
    sql_case:
      0% - 7.5%: ${price}/${max_selling_price} > 0.925
      7.5% - 17.5%: ${price}/${max_selling_price} > 0.825
      17.5% - 27.5%: ${price}/${max_selling_price} > 0.725
      27.5% - 37.5%: ${price}/${max_selling_price} > 0.625
      else: '37.5% and over'
  
  ####################### REVENUE DIMENSIONS ##########################################################################################################################################
  
  - dimension: gross_item_revenue
    type: number
    decimals: 2
    sql: ${TABLE}.price * ${TABLE}.quantity
    value_format: '#,##0.00'
    hidden: true

  - dimension: gross_item_revenue_pre_retail_markdown_gbp
    type: number
    sql: ${pre_retail_markdown_price_gbp} * ${TABLE}.quantity
    value_format: '#,##0.00' 
    
  - dimension: gross_item_revenue_in_gbp
    type: number
    decimals: 2
    sql: ${price_gbp} * ${TABLE}.quantity
    value_format: '#,##0.00'

  - dimension: gross_item_revenue_ex_voucher_discount_gbp
    type: number
    decimals: 2
    sql: case when ${TABLE}.order_total = 0 then 0 else ${gross_item_revenue_in_gbp} * ((${TABLE}.order_total + ${TABLE}.adjustment_total)/${TABLE}.order_total) end
    value_format: '#,##0.00'
    
  - dimension: gross_item_revenue_ex_discount_ex_vat_gbp
    type: number
    decimals: 2
    sql: case when ${TABLE}.order_total = 0 then 0 else (${gross_item_revenue_in_gbp} * ((${TABLE}.order_total + ${TABLE}.adjustment_total)/${TABLE}.order_total) * (1/(1+${spree_orders.tax_rate}))) end
    value_format: '#,##0.00'

  # Margin Dimensions
  - dimension: landed_cost_gbp
    type: number
    decimals: 2
    sql: ${landed_cost_per_unit_gbp} * ${quantity}
    value_format: '#,##0.00'

    
 #################################### Returns Dimensions #########################################################################################################################
 
  - dimension: items_returned
    sql: ${TABLE}.items_returned
  
  - dimension: return_reason
    sql: ${TABLE}.return_reason

  - dimension_group: return_time
    type: time
    timeframes: [date]
    sql: ${TABLE}.return_tstamp
  
  - dimension: days_to_process_return
    type: int
    sql: ${return_time_date} - ${order_time_date}
    
  - dimension: return_item_value_gbp
    type: number
    decimals: 2
    sql: ${price_gbp} * ${TABLE}.items_returned
    value_format: '#,##0.00'
    hidden: true
    
  - dimension: net_reveune_after_returns_gbp
    type: number
    decimals: 2
    sql: ${price_gbp} * (${TABLE}.quantity - ${TABLE}.items_returned)
    value_format: '#,##0.00'
    hidden: true

#################################################################################################################################################################################
############################################################ MEASURES ###########################################################################################################
#################################################################################################################################################################################
  
  - measure: count_orders
    type: count_distinct
    sql: ${TABLE}.order_id
    
  - measure: count_customers
    type: count_distinct
    sql: ${TABLE}.customer_id  
    
  - measure: distinct_skus_sold
    type: count_distinct
    sql: ${TABLE}.sku
  
  - measure: total_items_sold
    label: Items Sold
    type: sum
    sql: ${TABLE}.quantity
  
  ########################################### Returns Measures #################################################################################################################
    
  - measure: total_items_returned
    label: Items Returned
    type: sum
    sql: coalesce(${items_returned}, 0)

  - measure: total_items_returned_size
    label: Items Returned - Size Issues
    type: sum
    sql: coalesce(${items_returned}, 0)
    filters:
      return_reason: It's too small, It's too large

  - measure: total_items_returned_too_big
    label: Items Returned - Too Big
    type: sum
    sql: coalesce(${items_returned}, 0)
    filters:
      return_reason: It's too large

  - measure: total_items_returned_doesnt_suit
    label: Items Returned - Doesn't Suit Me
    type: sum
    sql: coalesce(${items_returned}, 0)
    filters:
      return_reason: It doesn't suit me

  - measure: total_items_returned_too_small
    label: Items Returned - Too Small
    type: sum
    sql: coalesce(${items_returned}, 0)
    filters:
      return_reason: It's too small

  - measure: total_items_returned_not_as_pictured_not_as_described
    label: Items Returned - Not as Pictured or Described
    type: sum
    sql: coalesce(${items_returned}, 0)
    filters:
      return_reason: It's not as described, It's not as pictured

  - measure: total_items_returned_not_as_described
    label: Items Returned - Not as Described
    type: sum
    sql: coalesce(${items_returned}, 0)
    filters:
      return_reason: It's not as described
      
  - measure: total_items_returned_not_as_pictured
    label: Items Returned - Not as Pictured
    type: sum
    sql: coalesce(${items_returned}, 0)
    filters:
      return_reason: It's not as pictured

  - measure: total_items_returned_other
    label: Items Returned - Other Please Specify
    type: sum
    sql: coalesce(${items_returned}, 0)
    filters:
      return_reason: Other 

  - measure: total_items_returned_faulty
    label: Items Returned - Faulty
    type: sum
    sql: coalesce(${items_returned}, 0)
    filters:
      return_reason: It's faulty/in a poor condition
  
  - measure: items_sold_after_returns
    type: sum
    sql: ${quantity} - ${items_returned}
    
  - measure: return_rate
    type: number
    decimals: 4
    sql: ${total_items_returned}/NULLIF(${total_items_sold},0)::REAL
    value_format: '#0.00%'
    
  - measure: sum_return_item_value_gbp
    type: sum
    decimals: 2
    sql: ${price} * ${items_returned} / ${exchange_rate}
    value_format: '#,##0.00'
    hidden: true
      
  - measure: sum_return_item_value_gbp_ex_vat
    type: sum
    decimals: 2
    sql: ${price} * ${items_returned} * (1/(1+${spree_orders.tax_rate})) / ${exchange_rate}
    value_format: '#,##0.00'
    hidden: true
    
  - measure: return_rate_value
    type: number
    decimals: 4
    sql: ${sum_return_item_value_gbp}/NULLIF(${sum_gross_item_revenue_in_gbp},0)::REAL
    value_format: '#0.00%'
  
  ######################################################## GROSS Revenue Measures #######################################################################################################

  - measure: sum_pre_retail_markdown_item_revenue_in_gbp
    type: sum
    sql: ${gross_item_revenue_pre_retail_markdown_gbp}
    decimals: 2
    value_format: '#,##0.00'
    
  - measure: sum_gross_item_revenue_in_gbp
    type: sum
    sql: ${price} * ${quantity} / ${exchange_rate}
    decimals: 2
    value_format: '#,##0.00'

  - measure: sum_gross_item_revenue_ex_voucher_discount_gbp
    type: sum
    sql: ${gross_item_revenue_ex_voucher_discount_gbp}
    decimals: 2
    value_format: '#,##0.00'
    
  - measure: sum_net_item_revenue_gbp
    type: sum
    sql: ${price} * (${quantity} - ${items_returned}) / ${exchange_rate}
    decimals: 2
    value_format: '#,##0.00'

  - measure: sum_gross_item_revenue_ex_discount_ex_vat_gbp
    label: Gross Revenue
    type: sum
    sql: ${gross_item_revenue_ex_discount_ex_vat_gbp}
    decimals: 2
    value_format: '#,##0.00'
  
  - measure: sum_gross_item_revenue_in_gbp_ex_vat
    type: sum
    sql: (${price} * ${quantity} * (1/(1+${spree_orders.tax_rate}))) / ${exchange_rate}
    decimals: 2
    value_format: '#,##0.00'
    
  - measure: sum_net_item_revenue_gbp_ex_vat
    type: sum
    sql: (${price} * (${quantity} - ${items_returned}) * (1/(1+${spree_orders.tax_rate}))) / ${exchange_rate}
    decimals: 2
    value_format: '#,##0.00'

  - measure: count_days
    type: count_distinct
    sql: ${order_time_date}
    hidden: true
  
  - measure: revenue_per_day
    label: Revenue per Day
    type: number
    decimals: 0
    sql: ${sum_gross_item_revenue_ex_discount_ex_vat_gbp}/nullif(${count_days},0)::REAL
    value_format: '#,##0'
  
  ########################################################## GROSS Margin Measures ########################################################################################################
  
  - measure: sum_gross_landed_cost_gbp
    type: sum
    sql: ${product_lookup.total_landed_cost_gbp} * ${quantity}
    decimals: 2
    value_format: '#,##0.00'

  - measure: sum_gross_margin_gbp_ex_vat
    type: number
    decimals: 2
    sql: ${sum_gross_item_revenue_in_gbp_ex_vat} - ${sum_gross_landed_cost_gbp}
    value_format: '#,##0.00' 
  
  - measure: gross_margin_percent_ex_vat
    type: number
    decimals: 4
    sql: ${sum_gross_margin_gbp_ex_vat}/NULLIF(${sum_gross_item_revenue_in_gbp_ex_vat},0)::REAL
    value_format: '#0.00%'
    
  ########################################################## NET Margin Measures ########################################################################################################
  
  - measure: sum_net_landed_cost_gbp
    type: sum
    sql: ${product_lookup.total_landed_cost_gbp} * (${quantity} - ${items_returned})
    decimals: 2
    value_format: '#,##0.00'

  - measure: sum_net_margin_gbp_ex_vat
    type: number
    decimals: 2
    sql: ${sum_net_item_revenue_gbp_ex_vat} - ${sum_net_landed_cost_gbp}
    value_format: '#,##0.00' 
  
  - measure: net_margin_percent_ex_vat
    type: number
    decimals: 4
    sql: ${sum_net_margin_gbp_ex_vat}/NULLIF(${sum_net_item_revenue_gbp_ex_vat},0)::REAL
    value_format: '#0.00%'

###################################################### DISCOUNT STUFF ##################################################

  - measure: avg_retail_markdown
    type: number
    decimals: 4
    sql: (${sum_pre_retail_markdown_item_revenue_in_gbp} - ${sum_gross_item_revenue_in_gbp})/NULLIF(${sum_pre_retail_markdown_item_revenue_in_gbp},0)::REAL
    value_format: '#0.00%'
    
  - measure: avg_voucher_discount
    type: number
    decimals: 4
    sql: (${sum_gross_item_revenue_in_gbp} - ${sum_gross_item_revenue_ex_voucher_discount_gbp})/NULLIF(${sum_pre_retail_markdown_item_revenue_in_gbp},0)::REAL
    value_format: '#0.00%'
  
  - measure: avg_total_discount
    type: number
    decimals: 4
    sql: ${avg_retail_markdown} + ${avg_voucher_discount}
    value_format: '#0.00%'

  - measure: total_retail_markdown
    type: number
    decimals: 2
    sql: ${sum_pre_retail_markdown_item_revenue_in_gbp} - ${sum_gross_item_revenue_in_gbp}
    value_format: '#0.00'
    
  - measure: total_voucher_discount
    type: number
    decimals: 2
    sql: ${sum_gross_item_revenue_in_gbp} - ${sum_gross_item_revenue_ex_voucher_discount_gbp}  
    value_format: '#0.00'
    
  - measure: total_discount
    type: number
    decimals: 2
    sql: ${total_retail_markdown} + ${total_voucher_discount}
    value_format: '#0.00'
    
    ####################################################################################    
  ################################################# TW, LW, L4W, MTD, STD #######################################################################################################################
####################################################################################

# Revenue

  - measure: gross_rev_ex_discount_ex_vat_tw
    type: sum
    sql: ${gross_item_revenue_ex_discount_ex_vat_gbp}
    decimals: 2
    value_format: '#,##0.00'
    filters:
      order_time_date: last week
 
  - measure: gross_rev_ex_discount_ex_vat_lw
    type: sum
    sql: ${gross_item_revenue_ex_discount_ex_vat_gbp}
    decimals: 2
    value_format: '#,##0.00'
    filters:
      order_time_date: "2 weeks ago"
  
  - measure: gross_rev_ex_discount_ex_vat_l4w
    type: sum
    sql: ${gross_item_revenue_ex_discount_ex_vat_gbp}
    decimals: 2
    value_format: '#,##0.00'
    filters:
      order_time_date: 5 weeks ago for 4 weeks

  - measure: gross_rev_ex_discount_ex_vat_mtd
    type: sum
    sql: ${gross_item_revenue_ex_discount_ex_vat_gbp}
    decimals: 2
    value_format: '#,##0.00'
    filters:
      order_time_date: this month
      order_time_time: before this week
      
  - measure: gross_rev_ex_discount_ex_vat_std
    type: sum
    sql: ${gross_item_revenue_ex_discount_ex_vat_gbp}
    decimals: 2
    value_format: '#,##0.00'
    filters:
      order_time_date: after 2015/02/01
      order_time_time: before this week

# Profit

  - measure: pc1_profit_tw
    type: sum
    decimals: 2
    sql: ${gross_item_revenue_ex_discount_ex_vat_gbp} - (${product_lookup.total_landed_cost_gbp} * ${quantity})
    value_format: '#,##0.00'
    filters:
      order_time_date: last week
      
  - measure: pc1_profit_lw
    type: sum
    decimals: 2
    sql: ${gross_item_revenue_ex_discount_ex_vat_gbp} - (${product_lookup.total_landed_cost_gbp} * ${quantity})
    value_format: '#,##0.00'
    filters:
      order_time_date: 2 weeks ago

  - measure: pc1_profit_l4w
    type: sum
    decimals: 2
    sql: ${gross_item_revenue_ex_discount_ex_vat_gbp} - (${product_lookup.total_landed_cost_gbp} * ${quantity})
    value_format: '#,##0.00'
    filters:
      order_time_date: 5 weeks ago for 4 weeks

  - measure: pc1_profit_mtd
    type: sum
    decimals: 2
    sql: ${gross_item_revenue_ex_discount_ex_vat_gbp} - (${product_lookup.total_landed_cost_gbp} * ${quantity})
    value_format: '#,##0.00'
    filters:
      order_time_date: this month
      order_time_time: before this week
 
  - measure: pc1_profit_std
    type: sum
    decimals: 2
    sql: ${gross_item_revenue_ex_discount_ex_vat_gbp} - (${product_lookup.total_landed_cost_gbp} * ${quantity})
    value_format: '#,##0.00'
    filters:
      order_time_date: after 2015/02/01
      order_time_time: before this week

# Units Sold

  - measure: items_sold_tw
    type: sum
    sql: ${TABLE}.quantity
    filters:
      order_time_date: last week
      
  - measure: items_sold_lw
    type: sum
    sql: ${TABLE}.quantity
    filters:
      order_time_date: 2 weeks ago

  - measure: items_sold_l4w
    type: sum
    sql: ${TABLE}.quantity
    filters:
      order_time_date: 5 weeks ago for 4 weeks

  - measure: items_sold_mtd
    type: sum
    sql: ${TABLE}.quantity
    filters:
      order_time_date: this month
      order_time_time: before this week
 
  - measure: items_sold_std
    type: sum
    sql: ${TABLE}.quantity
    filters:
      order_time_date: after 2015/02/01
      order_time_time: before this week
      
      