- view: sessions_basic
  derived_table:
    sql: |
      -- rebuild comment
      SELECT
        domain_userid,
        domain_sessionidx,
        MIN(collector_tstamp) AS session_start_ts,
        MAX(collector_tstamp) AS session_end_ts,
        count(*) AS number_of_events,
        COUNT(DISTINCT page_urlpath) AS distinct_pages_viewed
      FROM
        atomic.events
      WHERE domain_userid IS NOT NULL
        AND domain_userid <> ''
        AND app_id = 'production'
        AND domain_sessionidx IS NOT NULL
      GROUP BY 1,2
    
    sql_trigger_value: SELECT MAX(collector_tstamp) FROM ${events.SQL_TABLE_NAME}  # Trigger table generation when new data loaded into atomic.events
    distkey: domain_userid
    sortkeys: [domain_userid, domain_sessionidx]
    

  fields:
  
  # DIMENSIONS #
  
  # Basic dimensions #
  
  - dimension: user_id
    sql: ${TABLE}.domain_userid
    
  - dimension: session_index
    type: int
    sql: ${TABLE}.domain_sessionidx
  
  - dimension: session_id
    sql: ${TABLE}.domain_userid || '-' || ${TABLE}.domain_sessionidx

  - dimension: session_index_tier
    type: tier
    tiers: [1,2,3,4,5,10,25,100,1000]
    sql: ${session_index}
  
  - dimension: start
    sql: ${TABLE}.session_start_ts
  
  - dimension_group: start
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.session_start_ts
    
  - dimension: end
    sql: ${TABLE}.session_end_ts
    
  # Session duration #

  - dimension: session_duration_seconds
    type: int
    sql: EXTRACT(EPOCH FROM (${TABLE}.session_end_ts - ${TABLE}.session_start_ts))

  - dimension: session_duration_seconds_tiered
    type: tier
    tiers: [0,1,5,10,30,60,300,900]
    sql: ${session_duration_seconds}

  # Events per visit and bounces (infered) #

  - dimension: events_during_session
    type: int
    sql: ${TABLE}.number_of_events
    
  - dimension: bounce
    type: yesno
    sql: ${TABLE}.number_of_events = 1
  
  # New vs returning visitor #
  - dimension: new_vs_returning_visitor
    sql_case:
      new: ${TABLE}.domain_sessionidx = 1
      returning: ${TABLE}.domain_sessionidx > 1
      else: unknown

  # Pages visited #
  - dimension: distinct_pages_viewed
    sql: ${TABLE}.distinct_pages_viewed
    
  - dimension: distinct_pages_viewed_tiered
    type: tier
    tiers: [1,2,3,4,5,10,25,100,1000]
    sql: ${TABLE}.distinct_pages_viewed
  
  - dimension: history
    sql: ${session_id}
    html: |
      <a href=events?fields=events.event_detail*&f[events.visit_id]=<%= value%>>Event Stream</a>
  
  

  
  # MEASURES #

  - measure: count
    type: count_distinct
    sql: ${session_id}
    detail: detail*

  - measure: visitors_count
    type: count_distinct
    sql: ${user_id}
    detail: detail*
    hidden: true
    
  - measure: bounced_sessions_count
    type: count_distinct
    sql: ${session_id}
    filters:
      bounce: yes
    detail: detail*

  - measure: bounce_rate
    type: number
    decimals: 2
    sql: ${bounced_sessions_count}/NULLIF(${count},0)::REAL
  
  - measure: sessions_from_new_visitors_count
    type: count_distinct
    sql: ${session_id}
    filters:
      session_index: 1
    detail: detail*
  
  - measure: sessions_from_returning_visitor_count
    type: number
    sql: ${count} - ${sessions_from_new_visitors_count}
    detail: detail*
  
  - measure: new_visitors_count_over_total_visitors_count
    type: number
    decimals: 2
    sql: ${sessions_from_new_visitors_count}/NULLIF(${count},0)::REAL
    detail: detail*

  - measure: returning_visitors_count_over_total_visitors_count
    type: number
    decimals: 2
    sql: ${sessions_from_returning_visitor_count}/NULLIF(${count},0)::REAL
    detail: detail*
  
  - measure: average_session_duration_seconds
    type: average
    sql: EXTRACT(EPOCH FROM (${end}-${start}))
    
  - measure: average_session_duration
    type: string
    sql: cast(${average_session_duration_seconds}/60 as int)||':'||mod(cast(${average_session_duration_seconds} as int), 60)
      