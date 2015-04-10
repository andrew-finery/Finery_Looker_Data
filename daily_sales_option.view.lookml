- view: daily_sales_option
  derived_table:
     sql: |
            select
            date(order_items.order_tstamp) as calendar_date,
            online_products.product_id,
            sum(order_items.quantity) as items_sold,
            sum(order_items.price*order_items.quantity/order_items.exchange_rate) as gross_revenue_gbp,
            sum((order_items.price*order_items.quantity/order_items.exchange_rate) * (1/(1+order_items.tax_rate))) as gross_revenue_gbp_ex_vat,
            sum(((order_items.order_total + order_items.adjustment_total)/nullif(order_items.order_total,'0')) * order_items.price * order_items.quantity * (1/(1+order_items.tax_rate)) / order_items.exchange_rate) as gross_revenue_gbp_ex_vat_ex_discount
            from
            ${spree_order_items.SQL_TABLE_NAME} order_items
            left join
            ${online_products.SQL_TABLE_NAME} online_products
            on order_items.sku = online_products.ean
            where date(order_items.order_tstamp) < current_date
            group by 1,2

     sql_trigger_value: select max(spree_timestamp) from ${spree_order_items.SQL_TABLE_NAME}
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
