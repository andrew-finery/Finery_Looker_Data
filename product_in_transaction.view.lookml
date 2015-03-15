- view: product_in_transaction
  derived_table:
     sql: |
          SELECT trans.root_id,
          trans.root_tstamp,
          product_context.id,
          product_context.price,
          product_context.quantity,
          product_context.variant
          FROM atomic.com_finerylondon_transaction_1 trans
          LEFT JOIN atomic.com_finerylondon_product_2 product_context
          ON trans.root_id = product_context.root_id


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
  
