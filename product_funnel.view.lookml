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
        
        union
        
       SELECT
        'Product Added to Cart' as event_type, domain_userid, domain_sessionidx,collector_tstamp, event_id, cast(id as integer) as product_id
        from ${product_in_cart.SQL_TABLE_NAME}
        
        union
        
       SELECT
        'Product Purchased' as event_type, domain_userid, domain_sessionidx,collector_tstamp, event_id, cast(id as integer) as product_id
        from ${product_in_transaction.SQL_TABLE_NAME}
      
      
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
       
     - dimension: product_id
       sql: ${TABLE}.product_id

     - dimension_group: time_period
       type: time
       timeframes: [time, hour, date, hod, dow, week, month]
       sql: ${TABLE}.collector_tstamp

    ###########################################################################################################################################
  ####################################################  MEASURES  ###########################################################################
###########################################################################################################################################

     - measure: count_users_temp
       type: count_distinct
       sql: ${domain_userid}
     
     - measure: product_impressions
       type: count_distinct
       sql: ${TABLE}.domain_userid||${TABLE}.product_id
       filters:
         event_type: Product Impression, Product Quick View, Product Page View, Product Added to Cart, Product Purchased
    
     - measure: product_quick_views
       type: count_distinct
       sql: ${TABLE}.domain_userid||${TABLE}.product_id
       filters:
         event_type: Product Quick View, Product Page View, Product Added to Cart, Product Purchased

     - measure: product_views
       type: count_distinct
       sql: ${TABLE}.domain_userid||${TABLE}.product_id
       filters:
         event_type: Product Page View, Product Added to Cart, Product Purchased
        
     - measure: product_added_to_cart
       type: count_distinct
       sql: ${TABLE}.domain_userid||${TABLE}.product_id
       filters:
         event_type: Product Added to Cart, Product Purchased

     - measure: product_purchases
       type: count_distinct
       sql: ${TABLE}.domain_userid||${TABLE}.product_id
       filters:
         event_type: Product Purchased
