- view: spree_order_items
  derived_table:
    sql: |
      select 
        a.spree_timestamp,
        a.completed_at as order_tstamp,
        b.order_id as order_id,
        a.customer_id as customer_id,
        a.order_code as order_code,
        c.sku,
        b.price,
        b.currency,
        f.exchange_rate,
        b.price*f.exchange_rate as price_gbp,
        b.quantity,
        d.max_selling_price,
        d.max_selling_price* f.exchange_rate as max_selling_price_gbp,
        (d.max_selling_price - b.price) as discount,
        (d.max_selling_price - b.price)*f.exchange_rate as discount_gbp,
        coalesce(e.items_returned, '0') as items_returned,
        e.return_reason
        
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
        (select order_id, sku, count(*) as items_returned, max(name) as return_reason from ${returns.SQL_TABLE_NAME} group by 1,2) e
        on a.order_id = e.order_id
        and c.sku = e.sku
        left join lookup.exchange_rates f
        on date_trunc ('day', a.completed_at) = f."date"
        and a.currency = f.currency
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
    timeframes: [time, date, hod, week, month]
    sql: ${TABLE}.order_tstamp
    
  - dimension: order_id
    primary_key: true
    sql: ${TABLE}.order_id
  
  - dimension: customer_id
    sql: ${TABLE}.customer_id
    
  - dimension: order_code
    sql: ${TABLE}.order_code

  - dimension: currency
    sql: ${TABLE}.currency
    
  - dimension: exchange_rate
    sql: ${TABLE}.exchange_rate

########################################Product Dimensions###########################################################################################################################
  - dimension: sku
    sql: ${TABLE}.sku
    
  - dimension: price
    type: number
    decimals: 2
    sql: ${TABLE}.price
    format: "%0.2f"

  - dimension: price_in_gbp
    type: number
    decimals: 2
    sql: ${price} * ${exchange_rate}
    format: "£%0.2f"

  - dimension: max_selling_price
    type: number
    decimals: 2
    sql: ${TABLE}.max_selling_price
    format: "£%0.2f"

  - dimension: max_selling_price_gbp
    type: number
    decimals: 2
    sql: ${max_selling_price} * ${exchange_rate}
    format: "£%0.2f"

  - dimension: selling_price_tiered
    sql_case:
      £0 - £20: ${price_in_gbp} < 20
      £20 - £40: ${price_in_gbp} < 40
      £40 - £60: ${price_in_gbp} < 60
      £60 - £80: ${price_in_gbp} < 80
      £80 - £100: ${price_in_gbp} < 100
      £100 - £150: ${price_in_gbp} < 150
      £150 - £200: ${price_in_gbp} < 200
      £200 - £300: ${price_in_gbp} < 300
      else: '£300 and over'

  - dimension: quantity
    sql: ${TABLE}.quantity
  
  - dimension: landed_cost_per_unit_gbp
    type: number
    decimals: 2
    sql: ${product_lookup.total_landed_cost_gbp}
    format: "£%0.2f"
  
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
    format: "%0.2f"
  
  - dimension: gross_item_revenue_in_gbp
    type: number
    decimals: 2
    sql: ${TABLE}.price_gbp * ${TABLE}.quantity
    format: "£%0.2f"
    
  - dimension: gross_item_revenue_ex_discount_ex_vat_gbp
    type: number
    decimals: 2
    sql: (${gross_item_revenue_in_gbp}/(${spree_orders.item_total}*${spree_orders.exchange_rate})) * ((${spree_orders.item_total} - ${spree_orders.discount})*${spree_orders.exchange_rate}*5/6)
    format: "£%0.2f"
  
  # Margin Dimensions
  - dimension: landed_cost_gbp
    type: number
    decimals: 2
    sql: ${landed_cost_per_unit_gbp} * ${quantity}
    format: "£%0.2f"

    
 #################################### Returns Dimensions #########################################################################################################################
 
  - dimension: items_returned
    sql: ${TABLE}.items_returned
  
  - dimension: return_reason
    sql: ${TABLE}.return_reason
    
  - dimension: return_item_value_gbp
    type: number
    decimals: 2
    sql: ${TABLE}.price_gbp * ${TABLE}.items_returned
    format: "£%0.2f"
    
  - dimension: net_reveune_after_returns_gbp
    type: number
    decimals: 2
    sql: ${TABLE}.price_gbp * (${TABLE}.quantity - ${TABLE}.items_returned)
    format: "£%0.2f"


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
    type: sum
    sql: ${TABLE}.quantity
  
  ########################################### Returns Measures #################################################################################################################
    
  - measure: total_items_returned
    type: sum
    sql: coalesce(${items_returned}, 0)
  
  - measure: items_sold_after_returns
    type: sum
    sql: ${quantity} - ${items_returned}
    
  - measure: return_rate
    type: number
    decimals: 2
    sql: 100.0 * ${total_items_returned}/NULLIF(${total_items_sold},0)::REAL
    format: "%0.2f%"
    
  - measure: sum_return_item_value_gbp
    type: sum
    decimals: 2
    sql: ${price} * ${items_returned} * ${exchange_rate}
    format: "£%0.2f"
  
  - measure: sum_return_item_value_gbp_ex_vat
    type: sum
    decimals: 2
    sql: ${price} * ${items_returned} * ${exchange_rate}*5/6
    format: "£%0.2f"
  
  - measure: return_rate_value
    type: number
    decimals: 2
    sql: 100.0 * ${sum_return_item_value_gbp}/NULLIF(${sum_gross_item_revenue_in_gbp},0)::REAL
    format: "%0.2f%"
  
  ######################################################## GROSS Revenue Measures #######################################################################################################
    
  - measure: sum_gross_item_revenue_in_gbp
    type: sum
    sql: ${price} * ${quantity} * ${exchange_rate}
    format: "%0.2f"
    
  - measure: sum_net_item_revenue_gbp
    type: sum
    sql: ${price} * (${quantity} - ${items_returned}) * ${exchange_rate}
    format: "£%0.2f"

  - measure: sum_gross_item_revenue_ex_discount_ex_vat_gbp
    type: sum
    sql: ${gross_item_revenue_ex_discount_ex_vat_gbp}
    format: "£%0.2f"
  
  - measure: sum_gross_item_revenue_in_gbp_ex_vat
    type: sum
    sql: ${price} * ${quantity} * ${exchange_rate} * 5/6
    format: "£%0.2f"
    
  - measure: sum_net_item_revenue_gbp_ex_vat
    type: sum
    sql: ${price} * (${quantity} - ${items_returned}) * ${exchange_rate} * 5/6
    format: "£%0.2f"
  
  ########################################################## GROSS Margin Measures ########################################################################################################
  
  - measure: sum_gross_landed_cost_gbp
    type: sum
    sql: ${product_lookup.total_landed_cost_gbp} * ${quantity}
    format: "£%0.2f"

  - measure: sum_gross_margin_gbp_ex_vat
    type: number
    decimals: 2
    sql: ${sum_gross_item_revenue_in_gbp_ex_vat} - ${sum_gross_landed_cost_gbp}
    format: "£%0.2f" 
  
  - measure: gross_margin_percent_ex_vat
    type: number
    decimals: 2
    sql: 100.0 * ${sum_gross_margin_gbp_ex_vat}/NULLIF(${sum_gross_item_revenue_in_gbp_ex_vat},0)::REAL
    format: "%0.2f%"
    
  ########################################################## NET Margin Measures ########################################################################################################
  
  - measure: sum_net_landed_cost_gbp
    type: sum
    sql: ${product_lookup.total_landed_cost_gbp} * (${quantity} - ${items_returned})
    format: "£%0.2f"

  - measure: sum_net_margin_gbp_ex_vat
    type: number
    decimals: 2
    sql: ${sum_net_item_revenue_gbp_ex_vat} - ${sum_net_landed_cost_gbp}
    format: "£%0.2f" 
  
  - measure: net_margin_percent_ex_vat
    type: number
    decimals: 2
    sql: 100.0 * ${sum_net_margin_gbp_ex_vat}/NULLIF(${sum_net_item_revenue_gbp_ex_vat},0)::REAL
    format: "%0.2f%"
    
  ############################################### TW, LW, L4W, MTD, STD
  
  - measure: gross_rev_ex_discount_ex_vat_tw
    type: sum
    sql: ${gross_item_revenue_ex_discount_ex_vat_gbp}
    format: "£%0.2f"
    filters:
      order_time_date: last week
 
  - measure: gross_rev_ex_discount_ex_vat_lw
    type: sum
    sql: ${gross_item_revenue_ex_discount_ex_vat_gbp}
    format: "£%0.2f"
    filters:
      order_time_date: "2 weeks ago"
  
  - measure: gross_rev_ex_discount_ex_vat_l4w
    type: sum
    sql: ${gross_item_revenue_ex_discount_ex_vat_gbp}
    format: "£%0.2f"
    filters:
      order_time_date: 5 weeks ago for 4 weeks

  - measure: gross_rev_ex_discount_ex_vat_mtd
    type: sum
    sql: ${gross_item_revenue_ex_discount_ex_vat_gbp}
    format: "£%0.2f"
    filters:
      order_time_date: this month
      order_time_time: before this week
      
  - measure: gross_rev_ex_discount_ex_vat_std
    type: sum
    sql: ${gross_item_revenue_ex_discount_ex_vat_gbp}
    format: "£%0.2f"
    filters:
      order_time_date: after 2014/11/20
      order_time_time: before this week

  - measure: pc1_profit_tw
    type: sum
    decimals: 2
    sql: ${gross_item_revenue_ex_discount_ex_vat_gbp} - (${product_lookup.total_landed_cost_gbp} * ${quantity})
    format: "£%0.2f"
    filters:
      order_time_date: last week
      
  - measure: pc1_profit_lw
    type: sum
    decimals: 2
    sql: ${gross_item_revenue_ex_discount_ex_vat_gbp} - (${product_lookup.total_landed_cost_gbp} * ${quantity})
    format: "£%0.2f"
    filters:
      order_time_date: 2 weeks ago

  - measure: pc1_profit_l4w
    type: sum
    decimals: 2
    sql: ${gross_item_revenue_ex_discount_ex_vat_gbp} - (${product_lookup.total_landed_cost_gbp} * ${quantity})
    format: "£%0.2f"
    filters:
      order_time_date: 5 weeks ago for 4 weeks

  - measure: pc1_profit_mtd
    type: sum
    decimals: 2
    sql: ${gross_item_revenue_ex_discount_ex_vat_gbp} - (${product_lookup.total_landed_cost_gbp} * ${quantity})
    format: "£%0.2f"
    filters:
      order_time_date: this month
      order_time_time: before this week
 
  - measure: pc1_profit_std
    type: sum
    decimals: 2
    sql: ${gross_item_revenue_ex_discount_ex_vat_gbp} - (${product_lookup.total_landed_cost_gbp} * ${quantity})
    format: "£%0.2f"
    filters:
      order_time_date: after 2014/11/20
      order_time_time: before this week