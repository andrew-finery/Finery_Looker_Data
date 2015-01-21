- view: product_funnel
  derived_table:
     sql: |
       SELECT 
       'impression' as event_type,
       domain_userid,
              domain_sessionidx,
              collector_tstamp,
              event_id,
              currency_code,
              brand,
              category,
              id,
              list,
              name,
              "position",
              price,
              sku,
              style
              from ${product_impressions.SQL_TABLE_NAME}
              
        union
      
        SELECT 
         'quick_view' as event_type,
          domain_userid,
              domain_sessionidx,
              collector_tstamp,
              event_id,
              currency_code,
              brand,
              category,
              id,
              list,
              name,
              "position",
              price,
              sku,
              style
              from ${product_quick_views.SQL_TABLE_NAME}
      
      
  fields:

     - dimension: event_type
       sql: ${TABLE}.event_type

     - measure: count_users
       type: count_distinct
       sql: ${TABLE}.domain_userid
