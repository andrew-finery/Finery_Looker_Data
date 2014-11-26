- view: order_items
  derived_table:
    sql: |
      SELECT
          a.order_tstamp,
          a.order_id,
          a.user_id,
          a.customer_order_code,
          a.domain_userid,
          a.domain_sessionidx,
          
          b.root_id,
          b.sku,
          b.price,
          b.quantity
  
        from ${orders.SQL_TABLE_NAME} a
        left join atomic.com_finerylondon_product_in_order_1 b
        on a.event_id = b.root_id
        
    sql_trigger_value: SELECT COUNT(*) FROM ${orders.SQL_TABLE_NAME}
    distkey: domain_userid
    sortkeys: [domain_userid, domain_sessionidx, order_tstamp]

  fields:

  - dimension_group: order_time
    type: time
    timeframes: [time, date, hod, week, month]
    sql: ${TABLE}.order_tstamp
    
  - dimension: order_id
    primary_key: true
    sql: ${TABLE}.id
  
  - dimension: customer_id
    sql: ${TABLE}.customer_id
    
  - dimension: customer_order_code
    sql: ${TABLE}.customer_order_code
  
  - dimension: domain_userid
    sql: ${TABLE}.domain_userid
    
  - dimension: session_index
    type: int
    sql: ${TABLE}.domain_sessionidx
  
  - dimension: session_id
    sql: ${TABLE}.domain_userid || '-' || ${TABLE}.domain_sessionidx  
    
  - dimension: sku
    sql: ${TABLE}.sku
    
  - dimension: price
    type: number
    decimals: 2
    sql: ${TABLE}.price
    format: "£%0.2f"
  
  - dimension: quantity
    sql: ${TABLE}.quantity
  
  - dimension: gross_revenue
    type: number
    decimals: 2
    sql: ${TABLE}.price * ${TABLE}.quantity
    format: "£%0.2f"
    
    
    
  # MEASURES #
  
  - measure: count_orders
    type: count_distinct
    sql: ${TABLE}.order_id
    
  - measure: count_customers
    type: count_distinct
    sql: ${TABLE}.user_id  
    
  - measure: distinct_skus_sold
    type: count_distinct
    sql: ${TABLE}.sku
  
  - measure: items_sold
    type: sum
    sql: ${TABLE}.quantity
    
  - measure: sum_gross_revenue
    type: sum
    sql: ${gross_revenue}
    format: "£%0.2f"
    
    
    