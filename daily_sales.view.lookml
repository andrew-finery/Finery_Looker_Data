- view: daily_sales
  derived_table:
   sql: |
          select
            matrix.calendar_date,
            matrix.year_week_number,
            matrix.sku,
            coalesce(closing.closing_stock, '0') as closing_stock,
            coalesce(sales.items_sold, '0') as items_sold,
            coalesce(sales.items_returned, '0') as items_returned,
            coalesce(sales.items_sold, '0') - coalesce(sales.items_returned, '0') as items_sold_after_returns,
            coalesce(sales.gross_item_revenue_gbp_ex_vat, '0') as gross_item_revenue_gbp_ex_vat,
            coalesce(sales.net_item_revenue_gbp_ex_vat, '0') as net_item_revenue_gbp_ex_vat
            
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
            sum(items_returned) as items_returned,
            sum(price_gbp * quantity*5/6) as gross_item_revenue_gbp_ex_vat,
            sum(price_gbp *5/6 * (quantity - items_returned)) as net_item_revenue_gbp_ex_vat
            from
            ${spree_order_items.SQL_TABLE_NAME}
            group by 1,2) sales
            on sales.sales_date = matrix.calendar_date
            and sales.sku = matrix.sku
            
            where matrix.calendar_date > date '2014-11-17'
            
   sql_trigger_value: |
                      SELECT max(closing_stock_date) FROM ${daily_closing_stock.SQL_TABLE_NAME}
   distkey: sku
   sortkeys: [sku, calendar_date]



  fields:

#################################################################################################################################################################################################
########################################################## DIMENSIONS ###########################################################################################################################
#################################################################################################################################################################################################

  - dimension_group: calendar_date
    type: time
    timeframes: [date, dow, dow_num, week, dom, month, month_num]
    convert_tz: false
    sql: ${TABLE}.calendar_date

  - dimension: year_week_number
    sql: ${TABLE}.year_week_number
    
  - dimension: sku
    sql: ${TABLE}.sku

#################################################################################################################################################################################################
########################################################## MEASURES #############################################################################################################################
#################################################################################################################################################################################################

# Item Measures 

  - measure: sum_items_sold
    type: sum
    sql: ${TABLE}.items_sold

  - measure: sum_items_returned
    type: sum
    sql: ${TABLE}.items_returned
    
  - measure: sum_items_sold_after_returns
    type: sum
    sql: ${TABLE}.items_sold_after_returns

# Value Measures

  - measure: sum_gross_item_revenue_gbp_ex_vat
    type: sum
    sql: ${TABLE}.gross_item_revenue_gbp_ex_vat
    format: "£%0.2f"
    
  - measure: sum_net_item_revenue_gbp_ex_vat
    type: sum
    sql: ${TABLE}.net_item_revenue_gbp_ex_vat
    format: "£%0.2f"
  
  - measure: sum_return_item_value_ex_vat
    type: sum
    sql: ${TABLE}.gross_item_revenue_gbp_ex_vat - ${TABLE}.net_item_revenue_gbp_ex_vat
    format: "£%0.2f"

# Margin Measures

  - measure: sum_cost_gbp
    type: sum
    sql: coalesce(${product_lookup.total_landed_cost_gbp}, 0) * ${TABLE}.items_sold
    format: "£%0.2f"

# Stock Measures

  - measure: closing_stock
    type: sum
    sql: ${TABLE}.closing_stock

  - measure: closing_stock_yesterday
    type: sum
    sql: ${TABLE}.closing_stock
    filters:
      calendar_date_date: 1 day ago for 1 day
  
  - measure: closing_stock_last_week
    type: sum
    sql: ${TABLE}.closing_stock
    filters:
      calendar_date_date: last week
      calendar_date_dow: 0

  - measure: closing_stock_week_before_last
    type: sum
    sql: ${TABLE}.closing_stock
    filters:
      calendar_date_date: 2 weeks ago
      calendar_date_dow: 0
     
    
  
    
    
    