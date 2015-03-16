- view: product_in_checkout
  derived_table:
     sql: |
          SELECT checkout.root_id,
          checkout.root_tstamp,
          checkout.checkout_step,
          checkout.customer_id,
          checkout.delivery_method,
          checkout.currency_code,
          checkout.gift_wrapping,
          checkout.promo_code,
          product_context.id,
          product_context.price,
          product_context.quantity,
          product_context.variant
          FROM atomic.com_finerylondon_checkout_1 checkout
          LEFT JOIN atomic.com_finerylondon_product_2 product_context
          ON checkout.root_id = product_context.root_id

  fields:
  
  - dimension: event_id
    sql: ${TABLE}.root_id
    hidden: true
  
  - dimension: checkout_step
    sql: ${TABLE}.checkout_step
  
  - dimension: product_id
    sql: ${TABLE}.id
    hidden: true
       
  - dimension: variant_id
    sql: ${TABLE}.variant
    hidden: true
  
  - dimension: quantity
    sql: ${TABLE}.quantity
    hidden: true