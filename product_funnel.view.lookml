- view: product_funnel
  derived_table:
     sql: |
       SELECT 
        'Product Impression' as event_type, domain_userid, domain_sessionidx,collector_tstamp, event_id, cast(id as integer) as product_id
        from ${product_impressions.SQL_TABLE_NAME}
              
        union
      
       SELECT 
        'Product Quick View' as event_type, domain_userid, domain_sessionidx,collector_tstamp, event_id, cast(id as integer) as product_id
        from ${product_quick_views.SQL_TABLE_NAME}
        
        union
        
       SELECT
        'Product Page View' as event_type, domain_userid, domain_sessionidx,collector_tstamp, event_id, cast(prod_id as integer) as product_id
        from ${page_view_events.SQL_TABLE_NAME}
        where prod_id is not null
        
        union
        
       SELECT
        'Product Added to Cart' as event_type, domain_userid, domain_sessionidx,collector_tstamp, event_id, cast(id as integer) as product_id
        from ${product_in_cart.SQL_TABLE_NAME}
        
        union
        
       SELECT
        'Product Purchased' as event_type, domain_userid, domain_sessionidx,collector_tstamp, event_id, cast(id as integer) as product_id
        from ${product_in_transaction.SQL_TABLE_NAME}

     sql_trigger_value: SELECT MAX(max_timestamp) from ${product_in_transaction.SQL_TABLE_NAME}
     distkey: event_id
     sortkeys: [event_id]
      
      
  fields:

    ###########################################################################################################################################
  ##################################################  DIMENSIONS  ###########################################################################
###########################################################################################################################################

     - dimension: event_type
       sql: ${TABLE}.event_type

     - dimension: event_id
       sql: ${TABLE}.event_id

     - dimension: domain_userid
       sql: ${TABLE}.domain_userid
    
     - dimension: domain_sessionidx
       sql: ${TABLE}.domain_sessionidx

     - dimension: blended_user_id
       sql: ${identity_stitching.blended_user_id}
       
     - dimension: product_id
       sql: ${TABLE}.product_id

     - dimension_group: occurred_at
       type: time
       timeframes: [time, hour, date, hour_of_day, day_of_week, week, month]
       sql: ${TABLE}.collector_tstamp
    
     - dimension: product_user_id
       sql: ${blended_user_id}||${TABLE}.product_id

    ###########################################################################################################################################
  ####################################################  MEASURES  ###########################################################################
###########################################################################################################################################

     - measure: distinct_product_impressions
       type: count_distinct
       sql: ${product_user_id}
       filters:
         event_type: Product Impression, Product Quick View, Product Page View, Product Added to Cart, Product Purchased
    
     - measure: distinct_product_quick_views
       type: count_distinct
       sql: ${product_user_id}
       filters:
         event_type: Product Quick View, Product Page View, Product Added to Cart, Product Purchased

     - measure: distinct_product_views
       type: count_distinct
       sql: ${product_user_id}
       filters:
         event_type: Product Page View, Product Added to Cart, Product Purchased
        
     - measure: distinct_product_added_to_cart
       type: count_distinct
       sql: ${product_user_id}
       filters:
         event_type: Product Added to Cart, Product Purchased

     - measure: distinct_product_purchases
       type: count_distinct
       sql: ${product_user_id}
       filters:
         event_type: Product Purchased
    
     - measure: product_conversion_rate_from_view
       type: number
       decimals: 2
       sql: 100.0 * ${distinct_product_purchases}/NULLIF(${distinct_product_views},0)::REAL
       format: "%0.2f%"
