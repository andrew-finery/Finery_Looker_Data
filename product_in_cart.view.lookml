- view: product_in_cart
  derived_table:
     sql: |
          SELECT events.domain_userid,
                 events.domain_sessionidx,
                 product_context.id,
                 product_context.variant,
                 MAX(cart.root_tstamp) AS last_cart_timestamp,
                 MAX(product_context.quantity) AS added_to_cart_quantity
          FROM atomic.com_finerylondon_cart_1 cart
            LEFT JOIN atomic.com_finerylondon_product_2 product_context ON cart.root_id = product_context.root_id
            LEFT JOIN atomic.events events ON events.event_id = cart.root_id
          WHERE events.app_id = 'production'
          AND   product_context.id IS NOT NULL
          GROUP BY 1,
                   2,
                   3,
                   4

  fields:
  
     - dimension: domain_userid
       sql: ${TABLE}.domain_userid

     - measure: domain_sessionidx
       sql: ${TABLE}.domain_sessionidx
    
     - dimension: session_id
       sql: ${TABLE}.domain_userid || '-' || ${TABLE}.domain_sessionidx
      
     - dimension: product_id
       sql: ${TABLE}.id
       
     - dimension: variant_id
       sql: ${TABLE}.variant

     - dimension: quantity_in_cart
       sql: ${TABLE}.added_to_cart_quantity