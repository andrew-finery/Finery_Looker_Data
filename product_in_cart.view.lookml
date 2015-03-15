- view: product_in_cart
  derived_table:
     sql: |
          SELECT cart.root_id,
          cart.root_tstamp,
          product_context.id,
          product_context.price,
          product_context.quantity,
          product_context.variant
          FROM atomic.com_finerylondon_cart_1 cart
          LEFT JOIN atomic.com_finerylondon_product_2 product_context
          ON cart.root_id = product_context.root_id

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
  