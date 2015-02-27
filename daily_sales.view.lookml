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
            coalesce(sales.gross_revenue_gbp_ex_vat_ex_discount,'0') as gross_revenue_gbp_ex_vat_ex_discount,
            coalesce(sales.net_revenue_gbp, '0') as net_revenue_gbp,
            coalesce(sales.net_revenue_gbp_ex_vat_ex_discount,'0') as net_revenue_gbp_ex_vat_ex_discount
            
            from 

            (select aaa.sku, bbb.calendar_date, bbb.year_week_number from
            (select sku from ${daily_closing_stock.SQL_TABLE_NAME}
            group by 1) aaa
            cross join
            (select calendar_date, year_week_number from lookup.calendar)bbb
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
            sum(((order_total + adjustment_total)/order_total) * price * quantity * (1/(1+tax_rate)) / exchange_rate) as gross_revenue_gbp_ex_vat_ex_discount,
            sum(items_returned) as items_returned,
            sum(price*(quantity - items_returned)/exchange_rate) as net_revenue_gbp,
            sum(((order_total + adjustment_total)/order_total) * price * (quantity - items_returned) * (1/(1+tax_rate)) / exchange_rate) as net_revenue_gbp_ex_vat_ex_discount
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
            
   sql_trigger_value: SELECT max(closing_stock_date) FROM ${daily_closing_stock.SQL_TABLE_NAME}
   distkey: sku
   sortkeys: [sku, calendar_date]



  fields:

#################################################################################################################################################################################################
########################################################## DIMENSIONS ###########################################################################################################################
#################################################################################################################################################################################################

  - dimension_group: calendar_date
    label: CALENDAR
    type: time
    timeframes: [date, day_of_week_index, week, month, month_num]
    convert_tz: false
    sql: ${TABLE}.calendar_date

  - dimension: year_week_number
    label: YEAR WEEK NUMBER
    sql: ${TABLE}.year_week_number
    
  - dimension: sku
    label: EAN
    sql: ${TABLE}.sku
    
  - dimension: count_on_hand
    sql: ${TABLE}.closing_stock
    hidden: true
  
  - dimension: items_sold
    sql: ${TABLE}.items_sold
    hidden: true

  - dimension: after_first_option_sales_date_flag
    label: AFTER FIRST SALES DATE FOR OPTION FLAG
    type: yesno
    sql: ${TABLE}.calendar_date >= ${TABLE}.first_option_sales_date
      
  - dimension: full_option_availability_flag
    label: FULL OPTION SIZE AVAILABILITY FLAG
    type: yesno
    sql: ${TABLE}.full_option_availability_flag = 1

#################################################################################################################################################################################################
########################################################## MEASURES #############################################################################################################################
#################################################################################################################################################################################################

# Item Measures 

  - measure: sum_items_sold
    label: UNITS SOLD
    type: sum
    sql: ${TABLE}.items_sold

  - measure: sum_items_sold_as_percent
    label: UNITS SOLD MIX
    type: percent_of_total
    sql: ${sum_items_sold}

  - measure: sum_items_returned
    label: UNITS RETURNED
    type: sum
    sql: ${TABLE}.items_returned
    
  - measure: sum_items_sold_after_returns
    label: NET UNITS SOLD
    type: sum
    sql: ${TABLE}.items_sold_after_returns
    
  - measure: first_sale_date
    label: FIRST SALES DATE
    type: date
    sql: MIN(case when items_sold > 0 then ${calendar_date_date} else null end)
    convert_tz: false

  - measure: last_sale_date
    label: LAST SALES DATE
    type: date
    sql: MAX(case when items_sold > 0 then ${calendar_date_date} else null end)
    convert_tz: false
      

# Value Measures

  - measure: gross_item_revenue_gbp
    label: GROSS REVENUE
    type: sum
    sql: ${TABLE}.gross_revenue_gbp
    format: "£%0.2f"

  - measure: gross_item_revenue_gbp_ex_vat_ex_discount
    label: GROSS REVENUE EX. VAT, DISCOUNT
    type: sum
    sql: ${TABLE}.gross_revenue_gbp_ex_vat_ex_discount
    format: "£%0.2f"

  - measure: sales_mix
    label: SALES MIX
    type: percent_of_total
    sql: ${gross_item_revenue_gbp_ex_vat_ex_discount}
    
  - measure: net_item_revenue_gbp
    label: NET REVENUE
    type: sum
    sql: ${TABLE}.net_revenue_gbp
    format: "£%0.2f"

  - measure: net_item_revenue_gbp_ex_vat_ex_discount
    label: NET REVENUE EX. VAT, DISCOUNT
    type: sum
    sql: ${TABLE}.net_revenue_gbp_ex_vat_ex_discount
    format: "£%0.2f"

# Margin Measures

  - measure: sum_cost_gbp
    label: COST OF GOODS SOLD
    type: sum
    sql: coalesce(${product_lookup.total_landed_cost_gbp}, 0) * ${TABLE}.items_sold
    format: "£%0.2f"

# Stock Measures

  - measure: closing_stock
    type: sum
    sql: ${TABLE}.closing_stock
    hidden: true

  - measure: closing_stock_yesterday
    label: CLOSING STOCK YESTERDAY
    type: sum
    sql: ${TABLE}.closing_stock
    filters:
      calendar_date_date: 1 day ago for 1 day
  
  - measure: closing_stock_last_week
    label: CLOSING STOCK LAST WEEK
    type: sum
    sql: ${TABLE}.closing_stock
    filters:
      calendar_date_date: last week
      calendar_date_day_of_week_index: 6

  - measure: closing_stock_week_before_last
    label: CLOSING STOCK 2 WEEKS AGO
    type: sum
    sql: ${TABLE}.closing_stock
    filters:
      calendar_date_date: 2 weeks ago
      calendar_date_day_of_week_index: 6

# stock value @ cost

  - measure: closing_stock_value_cost
    type: sum
    sql: ${TABLE}.closing_stock*coalesce(${product_lookup.total_landed_cost_gbp}, 0)
    hidden: true
    
  - measure: closing_stock_value_cost_yesterday
    label: CLOSING STOCK YESTERDAY @ COST
    type: sum
    sql: ${TABLE}.closing_stock*coalesce(${product_lookup.total_landed_cost_gbp}, 0)
    filters:
      calendar_date_date: 1 day ago for 1 day
  
  - measure: closing_stock_value_cost_last_week
    label: CLOSING STOCK LAST WEEK @ COST
    type: sum
    sql: ${TABLE}.closing_stock*coalesce(${product_lookup.total_landed_cost_gbp}, 0)
    filters:
      calendar_date_date: last week
      calendar_date_day_of_week_index: 6

  - measure: closing_stock_value_cost_week_before_last
    label: CLOSING STOCK 2 WEEKS AGO @ COST
    type: sum
    sql: ${TABLE}.closing_stock*coalesce(${product_lookup.total_landed_cost_gbp}, 0)
    filters:
      calendar_date_date: 2 weeks ago
      calendar_date_day_of_week_index: 6

# closing stock @ retail

  - measure: closing_stock_value_retail
    type: sum
    sql: ${TABLE}.closing_stock*coalesce(${product_lookup.current_price},'0'
    hidden: true

  - measure: closing_stock_value_retail_yesterday
    label: CLOSING STOCK YESTERDAY @ RETAIL
    type: sum
    sql: ${TABLE}.closing_stock*coalesce(${product_lookup.current_price},'0')
    filters:
      calendar_date_date: 1 day ago for 1 day
  
  - measure: stock_mix_retail_yesterday
    label: STOCK MIX YESTERDAY
    type: percent_of_total
    sql: ${closing_stock_value_retail_yesterday}  
  
  - measure: closing_stock_value_retail_last_week
    label: CLOSING STOCK LAST WEEK @ RETAIL
    type: sum
    sql: ${TABLE}.closing_stock*coalesce(${product_lookup.current_price},'0')
    filters:
      calendar_date_date: last week
      calendar_date_day_of_week_index: 6

  - measure: closing_stock_value_retail_week_before_last
    label: CLOSING STOCK 2 WEEKS AGO @ RETAIL
    type: sum
    sql: ${TABLE}.closing_stock*coalesce(${product_lookup.current_price},'0')
    filters:
      calendar_date_date: 2 weeks ago
      calendar_date_day_of_week_index: 6


### Number of sku's in stock measures
  
  - measure: skus_in_stock_last_week
    label: SIZES IN STOCK LAST WEEK
    type: count_distinct
    sql: ${TABLE}.sku
    filters:
      count_on_hand: -NULL, -0
      calendar_date_date: last week
      calendar_date_day_of_week_index: 6

  - measure: skus_in_stock_week_before
    label: SIZES IN STOCK 2 WEEKS AGO
    type: count_distinct
    sql: ${TABLE}.sku
    filters:
      count_on_hand: -NULL, -0
      calendar_date_date: last week
      calendar_date_day_of_week_index: 6
  
  - measure: skus_in_stock_yesterday
    label: SIZES IN STOCK YESTERDAY
    type: count_distinct
    sql: ${TABLE}.sku
    filters:
      count_on_hand: -NULL, -0
      calendar_date_date: yesterday
    
    
    