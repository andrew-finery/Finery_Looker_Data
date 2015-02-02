- view: product_in_transaction
  derived_table:
     sql: |
          SELECT (SELECT MAX(collector_tstamp) FROM atomic.events)
          AS max_timestamp,
                 events.domain_userid,
                 events.domain_sessionidx,
                 events.event_id,
                 events.collector_tstamp,
                 product_context.id,
                 product_context.variant,
                 trans.root_tstamp,
                 product_context.quantity
          FROM atomic.com_finerylondon_transaction_1 trans
            LEFT JOIN atomic.com_finerylondon_product_2 product_context ON trans.root_id = product_context.root_id
            LEFT JOIN atomic.events events ON events.event_id = trans.root_id
          WHERE events.app_id = 'production'
          AND   product_context.id IS NOT NULL
          
     sql_trigger_value: SELECT MAX(max_timestamp) from ${product_in_cart.SQL_TABLE_NAME}
     distkey: domain_userid
     sortkeys: [domain_userid, domain_sessionidx, collector_tstamp]

  fields:
  
     - dimension: domain_userid
       sql: ${TABLE}.domain_userid

     - dimension: domain_sessionidx
       sql: ${TABLE}.domain_sessionidx
    
     - dimension: session_id
       sql: ${TABLE}.domain_userid || '-' || ${TABLE}.domain_sessionidx
      
     - dimension: product_id
       sql: ${TABLE}.id
       
     - dimension: variant_id
       sql: ${TABLE}.variant

     - dimension: quantity_in_cart
       sql: ${TABLE}.quantity