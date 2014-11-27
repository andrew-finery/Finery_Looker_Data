- view: spree_order_items
  derived_table:
    sql: |
      select

        a.completed_at as order_tstamp,
        b.order_id as order_id,
        a.customer_id as customer_id,
        a.order_code as order_code,
        
        c.sku,
        b.price,
        b.currency,
        b.quantity
        
        from

        ${spree_orders.SQL_TABLE_NAME} a
        inner join
        spree.line_items_snapshot b
        on a.order_id = b.order_id
        left join 
        (select id, sku from spree.variants_snapshot where deleted_at is null group by 1,2) c
        on b.variant_id = c.id
         
        
    sql_trigger_value: SELECT COUNT(*) FROM ${spree_orders.SQL_TABLE_NAME}
    distkey: order_id
    sortkeys: [order_id, order_tstamp]

  fields:

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

  - dimension: sku
    sql: ${TABLE}.sku
    
  - dimension: price
    type: number
    decimals: 2
    sql: ${TABLE}.price
    format: "%0.2f"
    
  - dimension: currency
    sql: ${TABLE}.currency
  
  - dimension: quantity
    sql: ${TABLE}.quantity
  
  - dimension: gross_revenue
    type: number
    decimals: 2
    sql: ${TABLE}.price * ${TABLE}.quantity
    format: "%0.2f"
    
  - dimension: price_in_gbp
    type: number
    decimals: 2
    sql:  |
          case
          when ${TABLE}.currency = 'GBP' then ${price}*1.00
          when ${TABLE}.currency = 'USD' then ${price}*0.64
          when ${TABLE}.currency = 'CAD' then ${price}*0.56
          else ${gross_revenue} end
    format: "£%0.2f"
  
  - dimension: gross_revenue_in_gbp
    type: number
    decimals: 2
    sql:  |
          case
          when ${TABLE}.currency = 'GBP' then ${gross_revenue}*1.00
          when ${TABLE}.currency = 'USD' then ${gross_revenue}*0.64
          when ${TABLE}.currency = 'CAD' then ${gross_revenue}*0.56
          else ${gross_revenue} end
    format: "£%0.2f"
    
    
  # MEASURES #
  
  - measure: count_orders
    type: count_distinct
    sql: ${TABLE}.order_id
    
  - measure: count_customers
    type: count_distinct
    sql: ${TABLE}.customer_id  
    
  - measure: distinct_skus_sold
    type: count_distinct
    sql: ${TABLE}.sku
  
  - measure: items_sold
    type: sum
    sql: ${TABLE}.quantity
    
  - measure: sum_gross_revenue_in_gbp
    type: sum
    sql: ${gross_revenue_in_gbp}
    format: "£%0.2f"

