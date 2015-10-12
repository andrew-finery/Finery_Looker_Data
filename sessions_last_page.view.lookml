- view: sessions_last_page
  derived_table:
    sql: |
              SELECT
                domain_userid,
                domain_sessionidx,
                page_urlhost, 
                page_urlpath,
                dvce_created_tstamp 
                FROM (
                SELECT
                domain_userid,
                domain_sessionidx,
                LAST_VALUE(page_urlhost) OVER (PARTITION BY domain_userid, domain_sessionidx ORDER BY dvce_created_tstamp, event_id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS page_urlhost,
                LAST_VALUE(page_urlpath) OVER (PARTITION BY domain_userid, domain_sessionidx ORDER BY dvce_created_tstamp, event_id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS page_urlpath,
                LAST_VALUE(dvce_created_tstamp) OVER (PARTITION BY domain_userid, domain_sessionidx ORDER BY dvce_created_tstamp, event_id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS dvce_created_tstamp
                FROM atomic.events
                WHERE app_id = 'production') AS a
                GROUP BY 1,2,3,4,5

    sql_trigger_value: SELECT COUNT(*) FROM ${sessions_landing_page.SQL_TABLE_NAME} # Generate this table after the sessions_landing page
    distkey: domain_userid
    sortkeys: [domain_userid, domain_sessionidx]

  fields:
    
  # DIMENSIONS #
  
  - dimension: user_id
    sql: ${TABLE}.domain_userid
    
  - dimension: session_index
    type: int
    sql: ${TABLE}.domain_sessionidx

  - dimension: exit_page_host
    sql: ${TABLE}.page_urlhost
    
  - dimension: exit_page_path
    sql: ${TABLE}.page_urlpath
    
  - measure: count
    type: count
    
  