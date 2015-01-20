- view: product_quick_views
  derived_table:
     sql: |
          SELECT events.domain_userid,
                 events.domain_sessionidx,
                 events.collector_tstamp,
                 events.event_id,
                 events.collector_tstamp,
                 quick_view.currency_code,
                 product_context.brand,
                 product_context.category,
                 product_context.id,
                 product_context.list,
                 product_context.name,
                 product_context. "position",
                 product_context.price,
                 product_context.sku,
                 product_context.style
          FROM atomic.com_finerylondon_product_quick_view_1 quick_view
            LEFT JOIN atomic.com_finerylondon_product_impression_context_1 product_context ON quick_view.root_id = product_context.root_id
            LEFT JOIN atomic.events events ON quick_view.root_id = events.event_id
          WHERE events.app_id = 'production';

  fields:
  
     - dimension: domain_userid
       sql: ${TABLE}.domain_userid

     - measure: domain_sessionidx
       sql: ${TABLE}.domain_sessionidx
    
     - dimension: session_id
       sql: ${TABLE}.domain_userid || '-' || ${TABLE}.domain_sessionidx
      
     - dimension: product_id
       sql: ${TABLE}.id
    
     - dimension: position
       sql: ${TABLE}.position

     - dimension: category
       sql: ${TABLE}.category
    
     - dimension: style
       sql: ${TABLE}.style
       
     - dimension: list
       sql: ${TABLE}.list