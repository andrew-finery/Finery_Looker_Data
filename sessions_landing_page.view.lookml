- view: sessions_landing_page
  derived_table:
    sql: |
            SELECT
                domain_userid,
                domain_sessionidx,
                page_urlhost, 
                page_urlpath,
                dvce_tstamp 
                FROM (
                SELECT
                domain_userid,
                domain_sessionidx,
                FIRST_VALUE(page_urlhost) OVER (PARTITION BY domain_userid, domain_sessionidx ORDER BY dvce_tstamp, event_id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS page_urlhost,
                FIRST_VALUE(page_urlpath) OVER (PARTITION BY domain_userid, domain_sessionidx ORDER BY dvce_tstamp, event_id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS page_urlpath,
                FIRST_VALUE(dvce_tstamp) OVER (PARTITION BY domain_userid, domain_sessionidx ORDER BY dvce_tstamp, event_id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS dvce_tstamp
                FROM atomic.events
                WHERE app_id = 'production') AS a
                GROUP BY 1,2,3,4,5

    sql_trigger_value: SELECT COUNT(*) FROM ${sessions_geo.SQL_TABLE_NAME} # Generate this table after the sessions_geo table
    distkey: domain_userid
    sortkeys: [domain_userid, domain_sessionidx]

  fields:
    
  # DIMENSIONS #
  
  - dimension: user_id
    sql: ${TABLE}.domain_userid
    
  - dimension: session_index
    type: int
    sql: ${TABLE}.domain_sessionidx
    
  - dimension: landing_page_url_host
    sql: ${TABLE}.page_urlhost
    
  - dimension: landing_page_url_path
    sql: ${TABLE}.page_urlpath
    
  - dimension: landing_page_url
    sql: ${TABLE}.page_urlhost || ${TABLE}.page_urlpath
    
    
  - measure: count
    type: count
    
  - measure: landing_page_count
    type: count_distinct
    sql: ${landing_page_url}
