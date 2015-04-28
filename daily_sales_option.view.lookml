- view: daily_sales_option
  derived_table:
     sql: |
            select
            daily_sales.calendar_date,
            online_products.product_id,
            sum(closing_stock) as closing_stock,
            sum(items_sold) as items_sold,
            sum(items_returned) as items_returned,
            sum(gross_revenue_gbp) as gross_revenue_gbp,
            sum(gross_revenue_gbp_ex_vat) as gross_revenue_gbp_ex_vat,
            sum(gross_revenue_gbp_ex_vat_ex_discount) as gross_revenue_gbp_ex_vat_ex_discount,
            sum(net_revenue_gbp) as net_revenue_gbp,
            sum(net_revenue_gbp_ex_vat_ex_discount) as net_revenue_gbp_ex_vat_ex_discount
            
            from ${daily_sales.SQL_TABLE_NAME} daily_sales
            
            left join ${online_products.SQL_TABLE_NAME} online_products
            
            on online_products.ean = daily_sales.sku
            
            where daily_sales.calendar_date < current_date
            
            group by 1,2


     sql_trigger_value: select sum(closing_stock + items_sold) from ${daily_sales.SQL_TABLE_NAME}
     distkey: product_id
     sortkeys: [product_id, calendar_date]

  fields:
# #     Define your dimensions and measures here, like this:
#     - dimension: profit
#       type: number
#       sql: ${TABLE}.profit
#
#     - measure: total_profit
#       type: sum
#       sql: ${profit}
