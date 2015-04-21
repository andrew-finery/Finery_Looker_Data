- view: visitors_basic
  derived_table: 
    sql: |
      SELECT
        domain_userid,
        MIN(convert_timezone('UTC', 'Europe/London', collector_tstamp)) AS first_touch,
        MAX(convert_timezone('UTC', 'Europe/London', collector_tstamp)) AS last_touch,
        COUNT(*) AS number_of_events,
        COUNT(DISTINCT page_urlpath) AS distinct_pages_viewed,
        MAX(domain_sessionidx) AS number_of_sessions
      FROM atomic.events
      WHERE domain_userid IS NOT NULL
        AND domain_userid <> ''
        AND app_id = 'production'
      GROUP BY 1
      
    sql_trigger_value: SELECT max(max_tstamp) FROM ${transactions.SQL_TABLE_NAME}
    distkey: domain_userid
    sortkeys: [domain_userid]
    
  fields:
  
  # DIMENSIONS #
  
  - dimension: user_id
    sql: ${TABLE}.domain_userid
    
  - dimension: first_touch
    sql: ${TABLE}.first_touch
    
  - dimension_group: first_touch
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.first_touch
    
  - dimension: last_touch
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.last_touch
    
  - dimension: number_of_events
    type: int
    sql: ${TABLE}.number_of_events
    
  - dimension: number_of_events_tiered
    type: tier
    tiers: [1,5,10,25,50,100,1000,10000,100000]
    sql: ${number_of_events}
    
  - dimension: bounce
    type: yesno
    sql: ${number_of_events} = 1
    
  - dimension: distinct_pages_viewed
    type: int
    sql: ${TABLE}.distinct_pages_viewed
    
  - dimension: distinct_pages_viewed_tiered
    type: tier
    tiers: [1,2,5,10,25,50,100,1000]
    sql: ${distinct_pages_viewed}
    
  - dimension: number_of_sessions
    type: int
    sql: ${TABLE}.number_of_sessions
    
  - dimension: number_of_sessions_tiered
    type: tier
    tiers: [1,2,5,10,25,50,100,1000]
    sql: ${number_of_sessions}
    
  - dimension: session_stream
    sql: ${user_id}
    html: |
      <a href=sessions?fields=sessions.individual_detail*&f[sessions.user_id]=<%=value%>>Session Stream</a>
      
  - dimension: event_stream
    sql: ${user_id}
    html: |
      <a href=events?fields=events.individual_detail*&f[events.user_id]=<%=value%>>Event stream</a>
      
  - measure: count
    type: count_distinct
    sql: ${user_id}
    detail: detail*
    