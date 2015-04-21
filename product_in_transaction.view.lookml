- view: product_in_transaction
  derived_table:
     sql: |
          SELECT trans.event_id as root_id,
          convert_timezone('UTC', 'Europe/London', trans.collector_tstamp) as root_tstamp,
          product_context.id,
          product_context.price,
          product_context.quantity,
          product_context.variant,
          trans.order_id,
          trans.revenue as order_revenue,
          trans.net_value as order_net_value,          
          COALESCE(SUM(adj.amount),'0') AS total_adjustment
          FROM ${transactions.SQL_TABLE_NAME} trans
          LEFT JOIN atomic.com_finerylondon_product_2 product_context ON trans.event_id = product_context.root_id
          LEFT JOIN atomic.com_finerylondon_order_adjustments_1 adj ON adj.root_id = trans.event_id
          group by 1,2,3,4,5,6,7,8,9

  fields:
  
  - dimension: event_id
    sql: ${TABLE}.root_id
    hidden: true
  
  - dimension: product_id
    sql: ${TABLE}.id
    hidden: true
       
  - dimension: variant_id
    sql: ${TABLE}.variant
    hidden: true
  
  - dimension: quantity
    sql: ${TABLE}.quantity
    hidden: true
  
  - dimension: net_product_revenue_per_item
    sql: ${TABLE}.price / (${TABLE}.order_net_revenue - ${TABLE}.order_total_adjustment) * ${TABLE}.net_value
    hidden: true
  
