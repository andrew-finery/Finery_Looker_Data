- view: identity_stitching
  derived_table:
     sql: |
       SELECT events.domain_userid,
               COALESCE(id_stitch_lookup.user_id,events.domain_userid) AS blended_user_id,
               min(collector_tstamp) as first_touch_time
        FROM atomic.events events
          LEFT JOIN (SELECT domains_with_user_id.domain_userid,
                            events.user_id
                     FROM (SELECT domain_userid
                           FROM (SELECT domain_userid,
                                        COUNT(DISTINCT user_id) AS distinct_users
                                 FROM atomic.events
                                 WHERE app_id = 'production'
                                 GROUP BY 1)
                           WHERE distinct_users = 1) domains_with_user_id
                       LEFT JOIN atomic.events events ON domains_with_user_id.domain_userid = events.domain_userid
                     WHERE events.user_id IS NOT NULL
                     AND   events.app_id = 'production'
                     GROUP BY 1,
                              2) id_stitch_lookup ON id_stitch_lookup.domain_userid = events.domain_userid
        WHERE events.domain_userid IS NOT NULL
        AND events.app_id = 'production'
        GROUP BY 1,
                 2

     sql_trigger_value: SELECT COUNT(*) FROM ${page_views.SQL_TABLE_NAME}
     distkey: domain_userid
     sortkeys: [domain_userid]
     
  fields:

    #################################################################################################################################################################
  #################################################################  DIMENSIONS  ##################################################################################
#################################################################################################################################################################
  
  - dimension: domain_userid
    sql: ${TABLE}.domain_userid
  
  - dimension: blended_user_id
    sql: ${TABLE}.blended_user_id


