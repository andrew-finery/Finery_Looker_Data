- view: product_impressions
  derived_table:
     sql: |
          SELECT (SELECT MAX(collector_tstamp) FROM atomic.events)
          AS max_timestamp,
                 events.domain_userid,
                 events.domain_sessionidx,
                 events.collector_tstamp,
                 events.event_id,
                 impressions.currency_code,
                 impressions_context.brand,
                 impressions_context.category,
                 impressions_context.id,
                 impressions_context.list,
                 impressions_context.name,
                 impressions_context. "position",
                 impressions_context.price,
                 impressions_context.sku,
                 impressions_context.style
          FROM atomic.com_finerylondon_product_impression_1 impressions
            LEFT JOIN atomic.com_finerylondon_product_impression_context_1 impressions_context ON impressions.root_id = impressions_context.root_id
            LEFT JOIN atomic.events events ON impressions.root_id = events.event_id
          WHERE events.app_id = 'production'

          
     sql_trigger_value: SELECT max(collector_tstamp) from atomic.events
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
    
     - dimension: position
       sql: ${TABLE}.position

     - dimension: category
       sql: ${TABLE}.category
    
     - dimension: style
       sql: ${TABLE}.style
       
     - dimension: list
       sql: ${TABLE}.list