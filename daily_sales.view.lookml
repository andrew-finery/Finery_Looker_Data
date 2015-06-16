- view: daily_sales
  derived_table:
   sql: |
          select
            matrix.calendar_date,
            matrix.year_week_number,
            matrix.sku,
            coalesce(option_availability.full_option_availability_flag, '0') as full_option_availability_flag,
            first_option_sales_date.first_option_sales_date as first_option_sales_date,
            coalesce(closing.closing_stock, '0') as closing_stock,
            coalesce(sales.items_sold, '0') as items_sold,
            coalesce(sales.items_returned, '0') as items_returned,
            coalesce(sales.items_sold, '0') - coalesce(sales.items_returned, '0') as items_sold_after_returns,
            coalesce(sales.gross_revenue_gbp, '0') as gross_revenue_gbp,
            coalesce(sales.gross_revenue_gbp_ex_vat, '0') as gross_revenue_gbp_ex_vat,
            coalesce(sales.gross_revenue_gbp_ex_vat_ex_discount,'0') as gross_revenue_gbp_ex_vat_ex_discount,
            coalesce(sales.net_revenue_gbp, '0') as net_revenue_gbp,
            coalesce(sales.net_revenue_gbp_ex_vat_ex_discount,'0') as net_revenue_gbp_ex_vat_ex_discount
            
            from 

            (select aaa.sku, bbb.calendar_date, bbb.year_week_number from
            (select sku from ${daily_closing_stock.SQL_TABLE_NAME}
            group by 1) aaa
            cross join
            (select calendar_date, year_week_number from finery.calendar)bbb
            where bbb.calendar_date < current_date) matrix
            
            left join
            
            ${daily_closing_stock.SQL_TABLE_NAME} closing
            
            on closing.closing_stock_date = matrix.calendar_date
            and closing.sku = matrix.sku
            
            left join
            
            (select
            date(order_tstamp) as sales_date,
            sku,
            sum(quantity) as items_sold,
            sum(price*quantity/exchange_rate) as gross_revenue_gbp,
            sum((price*quantity/exchange_rate) * (1/(1+tax_rate))) as gross_revenue_gbp_ex_vat,
            sum(((order_total + adjustment_total)/nullif(order_total,'0')) * price * quantity * (1/(1+tax_rate)) / exchange_rate) as gross_revenue_gbp_ex_vat_ex_discount,
            sum(items_returned) as items_returned,
            sum(price*(quantity - items_returned)/exchange_rate) as net_revenue_gbp,
            sum(((order_total + adjustment_total)/nullif(order_total,'0')) * price * (quantity - items_returned) * (1/(1+tax_rate)) / exchange_rate) as net_revenue_gbp_ex_vat_ex_discount
            from
            ${spree_order_items.SQL_TABLE_NAME}
            group by 1,2) sales
            on sales.sales_date = matrix.calendar_date
            and sales.sku = matrix.sku
            
            left join ${online_products.SQL_TABLE_NAME} online_products
            on online_products.ean = matrix.sku
            
            left join
              (select
              online_products.product_id, closing_stock.closing_stock_date,
              case when cast(sum(case when coalesce(closing_stock.closing_stock,'0') > 0 then 1 else 0 end) as decimal(8,2))/cast(count(distinct closing_stock.sku) as decimal(8,2)) = 1 then 1 else 0 end as full_option_availability_flag
              from ${daily_closing_stock.SQL_TABLE_NAME} closing_stock
              left join ${online_products.SQL_TABLE_NAME} online_products
              on closing_stock.sku = online_products.ean
              where online_products.ean is not null and online_products.size not in (18)
              group by 1,2) option_availability
              on online_products.product_id = option_availability.product_id
              and matrix.calendar_date = option_availability.closing_stock_date
            
            left join
              (select
              online_products.product_id, min(date(order_items.order_tstamp)) as first_option_sales_date
              from ${spree_order_items.SQL_TABLE_NAME} order_items
              left join ${online_products.SQL_TABLE_NAME} online_products
              on order_items.sku = online_products.ean
              group by 1) first_option_sales_date
              on online_products.product_id = first_option_sales_date.product_id
            
            where matrix.calendar_date > date '2014-11-17'
            
   sql_trigger_value: select sum(value) from (select * from (SELECT sum(closing_stock) as value FROM ${daily_closing_stock.SQL_TABLE_NAME}) union (select extract(epoch from max(spree_timestamp)) as value from ${spree_order_items.SQL_TABLE_NAME}))
   distkey: sku
   sortkeys: [sku, calendar_date]



  fields:

#################################################################################################################################################################################################
########################################################## DIMENSIONS ###########################################################################################################################
#################################################################################################################################################################################################

  - dimension_group: calendar_date
    label: Calendar
    type: time
    timeframes: [date, day_of_week_index, week, month, month_num]
    convert_tz: false
    sql: ${TABLE}.calendar_date

  - dimension: year_week_number
    label: Year Week Number
    sql: ${TABLE}.year_week_number
    hidden: true
    
  - dimension: sku
    label: Ean
    sql: ${TABLE}.sku
    
  - dimension: count_on_hand
    sql: ${TABLE}.closing_stock
    hidden: true
  
  - dimension: items_sold
    sql: ${TABLE}.items_sold
    hidden: true

  - dimension: after_first_option_sales_date_flag
    label: After First Option Sales Date (Yes/No)
    type: yesno
    sql: ${TABLE}.calendar_date >= ${TABLE}.first_option_sales_date
      
  - dimension: full_option_availability_flag
    label: Full Size Availability (Yes/No)
    type: yesno
    sql: ${TABLE}.full_option_availability_flag = 1
  
  - dimension: product_on_sale_flag
    label: On Sale Flag
    sql: case when ${online_products.on_sale_date} <= ${calendar_date_date} then 'On Sale' else 'Full Price' end

#################################################################################################################################################################################################
########################################################## MEASURES #############################################################################################################################
#################################################################################################################################################################################################

# Item Measures 

  - measure: sum_items_sold
    label: Gross Units Sold
    type: sum
    sql: ${TABLE}.items_sold

  - measure: sum_items_sold_as_percent
    label: Units Sold Mix
    type: percent_of_total
    sql: ${sum_items_sold}

  - measure: sum_items_returned
    label: Units Returned
    type: sum
    sql: ${TABLE}.items_returned
    
  - measure: sum_items_sold_after_returns
    label: Net Units Sold
    type: sum
    sql: ${TABLE}.items_sold_after_returns
  
  - measure: return_rate
    label: Return Rate
    type: number
    decimals: 4
    sql: ${sum_items_sold}/NULLIF(${sum_items_returned},0)::REAL
    value_format: '#0.00%'
    
  - measure: first_sale_date
    label: First Sales Date
    type: date
    sql: MIN(case when items_sold > 0 then ${calendar_date_date} else null end)
    convert_tz: false

  - measure: last_sale_date
    label: Last Sales Date
    type: date
    sql: MAX(case when items_sold > 0 then ${calendar_date_date} else null end)
    convert_tz: false
      

# Value Measures

  - measure: gross_item_revenue_gbp
    label: Gross Revenue (pre Discount)
    type: sum
    decimals: 2
    sql: ${TABLE}.gross_revenue_gbp
    value_format: '"£"#,##0.00'
    
  - measure: gross_item_revenue_gbp_ex_vat
    label: Gross Revenue (pre Discount) ex. VAT
    type: sum
    decimals: 2
    sql: ${TABLE}.gross_revenue_gbp_ex_vat
    value_format: '"£"#,##0.00'

  - measure: gross_item_revenue_gbp_ex_vat_ex_discount
    label: Gross Revenue ex. VAT, Discount
    type: sum
    decimals: 2
    sql: ${TABLE}.gross_revenue_gbp_ex_vat_ex_discount
    value_format: '"£"#,##0.00'

  - measure: sales_mix
    label: Revenue Mix
    type: percent_of_total
    sql: ${gross_item_revenue_gbp_ex_vat_ex_discount}
    
  - measure: net_item_revenue_gbp
    label: Net Revenue (pre Discount)
    type: sum
    decimals: 2
    sql: ${TABLE}.net_revenue_gbp
    value_format: '"£"#,##0.00'

  - measure: net_item_revenue_gbp_ex_vat_ex_discount
    label: Net Revenue ex. VAT, Discount
    type: sum
    decimals: 2
    sql: ${TABLE}.net_revenue_gbp_ex_vat_ex_discount
    value_format: '"£"#,##0.00'
  
  - measure: return_item_value_gbp
    label: Return Item Value
    type: number
    decimals: 2
    sql: ${gross_item_revenue_gbp} - ${net_item_revenue_gbp}
    value_format: '"£"#,##0.00'
    
  - measure: return_item_value_gbp_ex_vat_ex_discount
    label: Return Item Value ex. VAT, Discount
    type: number
    decimals: 2
    sql: ${gross_item_revenue_gbp_ex_vat_ex_discount} - ${net_item_revenue_gbp_ex_vat_ex_discount}
    value_format: '"£"#,##0.00'

# ASP

  - measure: asp
    label: Average Selling Price
    type: number
    decimals: 2
    sql: ${gross_item_revenue_gbp}/NULLIF(${sum_items_sold},0)::REAL
    value_format: '"£"#,##0.00'
    
  - measure: asp_ex_vat
    label: Average Selling Price ex. VAT
    type: number
    decimals: 2
    sql: ${gross_item_revenue_gbp_ex_vat}/NULLIF(${sum_items_sold},0)::REAL
    value_format: '"£"#,##0.00'
    
  - measure: asp_ex_vat_ex_discount
    label: Average Selling Price ex. VAT, Discount
    type: number
    decimals: 2
    sql: ${gross_item_revenue_gbp_ex_vat_ex_discount}/NULLIF(${sum_items_sold},0)::REAL
    value_format: '"£"#,##0.00'
    
# Margin Measures

  - measure: sum_cost_gbp
    label: Gross Cost of Goods Sold
    type: sum
    decimals: 2
    sql: coalesce(${product_lookup.total_landed_cost_gbp}, 0) * ${TABLE}.items_sold
    value_format: '"£"#,##0.00'

  - measure: sum_net_cost_gbp
    label: Net Cost of Goods Sold
    type: sum
    decimals: 2
    sql: coalesce(${product_lookup.total_landed_cost_gbp}, 0) * ${TABLE}.items_sold_after_returns
    value_format: '"£"#,##0.00'

  - measure: gross_margin_percent
    label: Gross Margin %
    type: number
    sql: (${gross_item_revenue_gbp_ex_vat_ex_discount} - ${sum_cost_gbp})/NULLIF(${gross_item_revenue_gbp_ex_vat_ex_discount},0)::REAL
    value_format: '##.00%'

# Stock Measures

  - measure: closing_stock
    label: Closing Stock Units
    type: sum
    sql: ${TABLE}.closing_stock

  - measure: closing_stock_yesterday
    label: Closing Stock Units - Yesterday
    type: sum
    sql: ${TABLE}.closing_stock
    filters:
      calendar_date_date: 1 day ago for 1 day
  
  - measure: closing_stock_last_week
    label: Closing Stock Units - Last Week
    type: sum
    sql: ${TABLE}.closing_stock
    filters:
      calendar_date_date: last week
      calendar_date_day_of_week_index: 6

  - measure: closing_stock_week_before_last
    label: Closing Stock Units - 2 Weeks Ago
    type: sum
    sql: ${TABLE}.closing_stock
    filters:
      calendar_date_date: 2 weeks ago
      calendar_date_day_of_week_index: 6

  - measure: closing_stock_end_of_week
    label: Closing Stock Units - End of Week
    type: sum
    sql: ${TABLE}.closing_stock
    filters:
      calendar_date_day_of_week_index: 6

# stock value @ cost

  - measure: closing_stock_value_cost
    label: Closing Stock Value @ Cost
    type: sum
    decimals: 2
    sql: ${TABLE}.closing_stock*coalesce(${product_lookup.total_landed_cost_gbp}, 0)
    value_format: '"£"#,##0.00'
    
  - measure: closing_stock_value_cost_yesterday
    label:  Closing Stock Value @ Cost - Yesterday
    type: sum
    decimals: 2
    sql: ${TABLE}.closing_stock*coalesce(${product_lookup.total_landed_cost_gbp}, 0)
    filters:
      calendar_date_date: 1 day ago for 1 day
    value_format: '"£"#,##0.00'
    
  - measure: closing_stock_value_cost_last_week
    label: Closing Stock Value @ Cost - Last Week
    type: sum
    decimals: 2
    sql: ${TABLE}.closing_stock*coalesce(${product_lookup.total_landed_cost_gbp}, 0)
    filters:
      calendar_date_date: last week
      calendar_date_day_of_week_index: 6
    value_format: '"£"#,##0.00'
    
  - measure: closing_stock_value_cost_week_before_last
    label: Closing Stock Value @ Cost - 2 Weeks Ago
    type: sum
    decimals: 2
    sql: ${TABLE}.closing_stock*coalesce(${product_lookup.total_landed_cost_gbp}, 0)
    filters:
      calendar_date_date: 2 weeks ago
      calendar_date_day_of_week_index: 6
    value_format: '"£"#,##0.00'
    
  - measure: closing_stock_value_cost_end_of_week
    label: Closing Stock Value @ Cost - End of Week
    type: sum
    decimals: 2
    sql: ${TABLE}.closing_stock*coalesce(${product_lookup.total_landed_cost_gbp}, 0)
    filters:
      calendar_date_day_of_week_index: 6
    value_format: '"£"#,##0.00'
    
# closing stock @ retail

  - measure: closing_stock_value_retail
    label: Closing Stock Value @ Retail
    type: sum
    decimals: 2
    sql: ${TABLE}.closing_stock*coalesce(${product_lookup.current_price},'0')
    value_format: '"£"#,##0.00'
    
  - measure: closing_stock_value_retail_yesterday
    label: Closing Stock Value @ Retail - Yesterday
    type: sum
    decimals: 2
    sql: ${TABLE}.closing_stock*coalesce(${product_lookup.current_price},'0')
    filters:
      calendar_date_date: 1 day ago for 1 day
    value_format: '"£"#,##0.00'
    
  - measure: stock_mix_retail_yesterday
    label: Stock Retail Value Mix - Yesterday
    type: percent_of_total
    sql: ${closing_stock_value_retail_yesterday}  
    value_format: '"£"#,##0.00'
    
  - measure: closing_stock_value_retail_last_week
    label: Closing Stock Value @ Retail - Last Week
    type: sum
    decimals: 2
    sql: ${TABLE}.closing_stock*coalesce(${product_lookup.current_price},'0')
    filters:
      calendar_date_date: last week
      calendar_date_day_of_week_index: 6
    value_format: '"£"#,##0.00'
    
  - measure: closing_stock_value_retail_week_before_last
    label: Closing Stock Value @ Retail - 2 Weeks Ago
    type: sum
    decimals: 2
    sql: ${TABLE}.closing_stock*coalesce(${product_lookup.current_price},'0')
    filters:
      calendar_date_date: 2 weeks ago
      calendar_date_day_of_week_index: 6
    value_format: '"£"#,##0.00'
    
  - measure: closing_stock_value_retail_end_of_week
    label: Closing Stock Value @ Retail - End of Week
    type: sum
    decimals: 2
    sql: ${TABLE}.closing_stock*coalesce(${product_lookup.current_price},'0')
    filters:
      calendar_date_day_of_week_index: 6
    value_format: '"£"#,##0.00'
    
### Number of sku's in stock measures
  
  - measure: skus_in_stock_last_week
    label: Sizes in Stock - Last Week
    type: count_distinct
    sql: ${TABLE}.sku
    filters:
      count_on_hand: -NULL, -0
      calendar_date_date: last week
      calendar_date_day_of_week_index: 6

  - measure: skus_in_stock_week_before
    label: Sizes in Stock - 2 Weeks Ago
    type: count_distinct
    sql: ${TABLE}.sku
    filters:
      count_on_hand: -NULL, -0
      calendar_date_date: last week
      calendar_date_day_of_week_index: 6
  
  - measure: skus_in_stock_yesterday
    label: Sizes in Stock - Yesterday
    type: count_distinct
    sql: ${TABLE}.sku
    filters:
      count_on_hand: -NULL, -0
      calendar_date_date: yesterday

####################### Weekly/Monthly Measures

  - measure: sum_items_sold_yesterday
    label: Units Sold - Yesterday
    type: sum
    sql: ${TABLE}.items_sold    
    filters:
      calendar_date_date: 1 day ago for 1 day

  - measure: sum_items_sold_same_day_last_week
    label: Units Sold - Same Day Last Week
    type: sum
    sql: ${TABLE}.items_sold    
    filters:
      calendar_date_date: 8 day ago for 1 day
    
  - measure: sum_items_sold_last_week
    label: Units Sold - Last Week
    type: sum
    sql: ${TABLE}.items_sold    
    filters:
      calendar_date_date: last week

  - measure: sum_items_sold_week_before
    label:  Units Sold - Week Before Last
    type: sum
    sql: ${TABLE}.items_sold    
    filters:
      calendar_date_date: 2 weeks ago for 1 week
  
  - measure: sum_items_sold_last_7_days
    label: Units Sold - Last 7 Days
    type: sum
    sql: ${TABLE}.items_sold    
    filters:
      calendar_date_date: 7 days ago for 7 days 

  - measure: sum_items_sold_week_to_date
    label: Units Sold - Week to Date
    type: sum
    sql: ${TABLE}.items_sold    
    filters:
      calendar_date_date: this week

  - measure: gross_item_revenue_gbp_ex_vat_ex_discount_yesterday
    label: Gross Revenue ex. VAT, Discount - Yesterday
    type: sum
    decimals: 2
    sql: ${TABLE}.gross_revenue_gbp_ex_vat_ex_discount
    value_format: '"£"#,##0.00'
    filters:
      calendar_date_date: 1 day ago for 1 day

  - measure: gross_item_revenue_gbp_ex_vat_ex_discount_last_week
    label: Gross Revenue ex. VAT, Discount - Last Week
    type: sum
    decimals: 2
    sql: ${TABLE}.gross_revenue_gbp_ex_vat_ex_discount
    value_format: '"£"#,##0.00'
    filters:
      calendar_date_date: last week
      
  - measure: gross_item_revenue_gbp_ex_vat_ex_discount_week_before
    label: Gross Revenue ex. VAT, Discount - Week Before Last
    type: sum
    decimals: 2
    sql: ${TABLE}.gross_revenue_gbp_ex_vat_ex_discount
    value_format: '"£"#,##0.00'
    filters:
      calendar_date_date: 2 weeks ago for 1 week
      
  - measure: gross_item_revenue_gbp_ex_vat_ex_discount_last_7_days
    label: Gross Revenue ex. VAT, Discount - Last 7 Days
    type: sum
    decimals: 2
    sql: ${TABLE}.gross_revenue_gbp_ex_vat_ex_discount
    value_format: '"£"#,##0.00'
    filters:
      calendar_date_date: 7 days ago for 7 days

  - measure: gross_item_revenue_gbp_ex_vat_ex_discount_week_to_date
    label: Gross Revenue ex. VAT, Discount - Week to Date
    type: sum
    decimals: 2
    sql: ${TABLE}.gross_revenue_gbp_ex_vat_ex_discount
    value_format: '"£"#,##0.00'
    filters:
      calendar_date_date: this week

  - measure: sales_mix_last_7_days
    label: Sales Mix - Last 7 Days
    type: percent_of_total
    sql: ${gross_item_revenue_gbp_ex_vat_ex_discount_last_7_days}
  
  - measure: weeks_cover_yesterday
    label: Weeks Cover - Yesterday
    type: number
    decimals: 2
    sql: ${closing_stock_yesterday}/NULLIF(${sum_items_sold_last_7_days},0)::REAL
    value_format: '#.00' 
    
  - measure: weeks_cover_last_week
    label: Weeks Cover - Last Week
    type: number
    decimals: 2
    sql: ${closing_stock_last_week}/NULLIF(${sum_items_sold_last_week},0)::REAL
    value_format: '#.00' 
    
  - measure: weeks_cover_week_before_last
    label: Weeks Cover - Week Before Last
    type: number
    decimals: 2
    sql: ${closing_stock_week_before_last}/NULLIF(${sum_items_sold_week_before},0)::REAL
    value_format: '#.00' 
    

########################################################################################################################
########################################## REPORTING MEASURES ##########################################################
########################################################################################################################

  - measure: units_sold_wow
    label: Units Sold - Week-On-Week
    type: number
    decimals: 2
    sql: (${sum_items_sold_last_week} - ${sum_items_sold_week_before})/NULLIF(${sum_items_sold_week_before},0)::REAL
    value_format: '#.00%'
    html: |
        {% if value < 0 %}
        <font color="#D77070"> {{ rendered_value }} </font>
        {% elsif value > 0 %}
        <font color="#3CB371"> {{ rendered_value }} </font>
        {% else %}
        <font color="#000000"> {{ rendered_value }} </font>
        {% endif %}
    hidden: true

  - measure: units_sold_yest_vs_lw
    label: Units Sold - Yesterday vs Last Week
    type: number
    decimals: 2
    sql: (${sum_items_sold_yesterday} - ${sum_items_sold_same_day_last_week})/NULLIF(${sum_items_sold_same_day_last_week},0)::REAL
    value_format: '#0.00%'
    html: |
        {% if value < 0 %}
        <font color="#D77070"> {{ rendered_value }} </font>
        {% elsif value > 0 %}
        <font color="#3CB371"> {{ rendered_value }} </font>
        {% else %}
        <font color="#000000"> {{ rendered_value }} </font>
        {% endif %}

  - measure: gross_revenue_wow
    label: Gross Revenue - Week-On-Week
    type: number
    decimals: 2
    sql: (${gross_item_revenue_gbp_ex_vat_ex_discount_last_week} - ${gross_item_revenue_gbp_ex_vat_ex_discount_week_before})/NULLIF(${gross_item_revenue_gbp_ex_vat_ex_discount_week_before},0)::REAL
    value_format: '#0.00%'
    html: |
        {% if value < 0 %}
        <font color="#D77070"> {{ rendered_value }} </font>
        {% elsif value > 0 %}
        <font color="#3CB371"> {{ rendered_value }} </font>
        {% else %}
        <font color="#000000"> {{ rendered_value }} </font>
        {% endif %}
    hidden: true
    
  
  - measure: units_sold_l4w
    type: sum
    sql: ${TABLE}.items_sold    
    filters:
      calendar_date_date: 5 weeks ago for 4 weeks
    hidden: true
     
  - measure: units_sold_mtd
    type: sum
    sql: ${TABLE}.items_sold    
    filters:
      calendar_date_date: this month
    hidden: true
           
  - measure: units_sold_std
    type: sum
    sql: ${TABLE}.items_sold    
    filters:
      calendar_date_date: after 2015/02/01
    hidden: true
           
  - measure: gross_rev_l4w
    type: sum
    decimals: 2
    sql: ${TABLE}.gross_revenue_gbp_ex_vat_ex_discount
    filters:
      calendar_date_date: 5 weeks ago for 4 weeks
    hidden: true
           
  - measure: gross_rev_mtd
    type: sum
    decimals: 2
    sql: ${TABLE}.gross_revenue_gbp_ex_vat_ex_discount
    filters:
      calendar_date_date: this month
    hidden: true
           
  - measure: gross_rev_std
    type: sum
    decimals: 2
    sql: ${TABLE}.gross_revenue_gbp_ex_vat_ex_discount
    filters:
      calendar_date_date: after 2015/02/01
    hidden: true
           
  - measure: cost_tw
    type: sum
    decimals: 2
    sql: coalesce(${product_lookup.total_landed_cost_gbp}, 0) * ${TABLE}.items_sold
    filters:
      calendar_date_date: last week
    hidden: true
     
  - measure: cost_lw
    type: sum
    decimals: 2
    sql: coalesce(${product_lookup.total_landed_cost_gbp}, 0) * ${TABLE}.items_sold
    filters:
      calendar_date_date: 2 weeks ago for 1 week
    hidden: true
    
  - measure: cost_l4w
    type: sum
    decimals: 2
    sql: coalesce(${product_lookup.total_landed_cost_gbp}, 0) * ${TABLE}.items_sold
    filters:
      calendar_date_date: 5 weeks ago for 4 weeks
    hidden: true
    
  - measure: cost_mtd
    type: sum
    decimals: 2
    sql: coalesce(${product_lookup.total_landed_cost_gbp}, 0) * ${TABLE}.items_sold
    filters:
      calendar_date_date: this month
    hidden: true
    
  - measure: cost_std
    type: sum
    decimals: 2
    sql: coalesce(${product_lookup.total_landed_cost_gbp}, 0) * ${TABLE}.items_sold
    filters:
      calendar_date_date: after 2015/02/01
    hidden: true
    
  - measure: pc1_tw
    type: number
    decimals: 2
    sql: ${gross_item_revenue_gbp_ex_vat_ex_discount_last_week} - ${cost_tw}
    hidden: true
    
  - measure: pc1_lw
    type: number
    decimals: 2
    sql: ${gross_item_revenue_gbp_ex_vat_ex_discount_week_before} - ${cost_lw}
    hidden: true
    
  - measure: pc1_l4w
    type: number
    decimals: 2
    sql: ${gross_rev_l4w} - ${cost_l4w}
    hidden: true
    
  - measure: pc1_mtd
    type: number
    decimals: 2
    sql: ${gross_rev_mtd} - ${cost_mtd}
    hidden: true
    
  - measure: pc1_std
    type: number
    decimals: 2
    sql: ${gross_rev_std} - ${cost_std}
    hidden: true
    
  - measure: units_sold_for_returns
    type: sum
    sql: ${TABLE}.items_sold    
    filters:
      calendar_date_date: before 2 weeks ago
    hidden: true
    
  - measure: units_returned_for_returns
    type: sum
    sql: ${TABLE}.items_returned
    filters:
      calendar_date_date: before 2 weeks ago
    hidden: true
    