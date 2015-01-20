- view: product_full_views
  derived_table:
     sql: |
          SELECT events.domain_userid,
                 events.domain_sessionidx,
                 events.collector_tstamp,
                 events.event_id,
                 events.collector_tstamp,
                 pv_context.page_type,
                 pv_context.prod_brand,
                 pv_context.prod_category,
                 pv_context.prod_id,
                 pv_context.prod_name,
                 pv_context.prod_price
          FROM atomic.com_finerylondon_page_view_context_1 pv_context
            LEFT JOIN atomic.events events ON pv_context.root_id = events.event_id
          WHERE pv_context.page_type = 'products/show'
          AND   events.app_id = 'production'

  fields:
  
     - dimension: domain_userid
       sql: ${TABLE}.domain_userid

     - measure: domain_sessionidx
       sql: ${TABLE}.domain_sessionidx
    
     - dimension: session_id
       sql: ${TABLE}.domain_userid || '-' || ${TABLE}.domain_sessionidx
      
     - dimension: product_id
       sql: ${TABLE}.prod_id

     - dimension: category
       sql: ${TABLE}.prod_category