- view: visitors
  derived_table: 
    sql: |
      select blended_user_id,
      min(first_touch) as first_touch,
      max(last_touch) as last_touch,
      sum(number_of_events) as number_of_events,
      sum(distinct_pages_viewed) as distinct_pages_viewed,
      sum(number_of_sessions) as number_of_sessions,
      page_urlhost,
      page_urlpath,
      mkt_source,
      mkt_medium,
      mkt_campaign,
      mkt_term,
      refr_source,
      refr_medium,
      refr_term,
      refr_urlhost,
      refr_urlpath
      FROM
      (SELECT
        v.domain_userid,
        id_stitch.blended_user_id,
        v.first_touch,
        v.last_touch,
        v.number_of_events,
        v.distinct_pages_viewed,
        v.number_of_sessions,
        first_value(l.page_urlhost) over (partition by id_stitch.blended_user_id order by v.first_touch asc rows between unbounded preceding and unbounded following) as page_urlhost,
        first_value(l.page_urlpath) over (partition by id_stitch.blended_user_id order by v.first_touch asc rows between unbounded preceding and unbounded following) as page_urlpath,
        first_value(s.mkt_source_ga) over (partition by id_stitch.blended_user_id order by v.first_touch asc rows between unbounded preceding and unbounded following) as mkt_source,
        first_value(s.mkt_medium_ga) over (partition by id_stitch.blended_user_id order by v.first_touch asc rows between unbounded preceding and unbounded following) as mkt_medium,
        first_value(s.mkt_campaign_ga) over (partition by id_stitch.blended_user_id order by v.first_touch asc rows between unbounded preceding and unbounded following) as mkt_campaign,
        first_value(s.mkt_term_ga) over (partition by id_stitch.blended_user_id order by v.first_touch asc rows between unbounded preceding and unbounded following) as mkt_term,
        first_value(s.refr_source_ga) over (partition by id_stitch.blended_user_id order by v.first_touch asc rows between unbounded preceding and unbounded following) as refr_source,
        first_value(s.refr_medium_ga) over (partition by id_stitch.blended_user_id order by v.first_touch asc rows between unbounded preceding and unbounded following) as refr_medium,
        first_value(s.refr_term_ga) over (partition by id_stitch.blended_user_id order by v.first_touch asc rows between unbounded preceding and unbounded following) as refr_term,
        first_value(s.refr_urlhost_ga) over (partition by id_stitch.blended_user_id order by v.first_touch asc rows between unbounded preceding and unbounded following) as refr_urlhost,
        first_value(s.refr_urlpath_ga) over (partition by id_stitch.blended_user_id order by v.first_touch asc rows between unbounded preceding and unbounded following) as refr_urlpath
      FROM
        ${visitors_basic.SQL_TABLE_NAME} AS v
        LEFT JOIN (select domain_userid, blended_user_id from
                  (select first_value(domain_userid) over (partition by blended_user_id order by first_touch_time asc rows between unbounded preceding and unbounded following) as domain_userid, blended_user_id from
                  ${identity_stitching.SQL_TABLE_NAME}) group by 1,2) AS id_stitch
        on id_stitch.domain_userid = v.domain_userid
        LEFT JOIN ${sessions_landing_page.SQL_TABLE_NAME} AS l
        ON v.domain_userid = l.domain_userid
        AND l.domain_sessionidx = 1
        LEFT JOIN ${sessions_source.SQL_TABLE_NAME} AS s
        ON v.domain_userid = s.domain_userid
        AND s.domain_sessionidx = 1)
        group by 1,7,8,9,10,11,12,13,14,15,16,17
        
    
    sql_trigger_value: SELECT COUNT(*) FROM ${visitors_basic.SQL_TABLE_NAME}
    distkey: blended_user_id
    sortkeys: [blended_user_id, first_touch]
  
  
  fields:
  
  # DIMENSIONS # 
  
  # Basic dimensions #
  
  - dimension: blended_user_id
    sql: ${TABLE}.blended_user_id
    
  - dimension: first_touch
    sql: ${TABLE}.first_touch
    
  - dimension_group: first_touch
    type: time
    timeframes: [time, hour, date, week, month]
    sql: ${TABLE}.first_touch
    
  - dimension: last_touch
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.last_touch
    
  - dimension: events_during_lifetime
    type: int
    sql: ${TABLE}.number_of_events
    
  - dimension: events_during_lifetime_tiered
    type: tier
    tiers: [1,5,10,25,50,100,1000,10000,100000]
    sql: ${TABLE}.number_of_events
    
  - dimension: bounce
    type: yesno
    sql: ${TABLE}.number_of_events = 1
    
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

  # Landing page dimensions #
  
  - dimension: landing_page_url_host
    sql: ${TABLE}.page_urlhost
    
  - dimension: landing_page_url_path
    sql: ${TABLE}.page_urlpath
    
  - dimension: landing_page_url
    sql: ${TABLE}.page_urlhost || ${TABLE}.page_urlpath  
    
  # Referer source dimensions #

  - dimension: acquisition_channel
    label: ACQUISITION CHANNEL
    sql_case:
      Facebook - Paid Marketing: ${TABLE}.mkt_source = 'facebook' and ${TABLE}.mkt_medium = 'paid'
      Paid Search: ${TABLE}.mkt_source in ('GoogleSearch', 'GoogleContent')
      Paid Search:  ${TABLE}.refr_urlhost = 'www.googleadservices.com'
      Email: ${TABLE}.mkt_medium = 'email' or ${TABLE}.refr_medium = 'email'
      Social: ${TABLE}.refr_medium = 'social'
      Search: ${TABLE}.refr_medium = 'search'
      Referrals: ${TABLE}.refr_medium = 'unknown'
      Other Marketing Source: ${TABLE}.mkt_source is not null or ${TABLE}.mkt_medium is not null or ${TABLE}.mkt_campaign is not null
      else: Direct

  - dimension: referer_source
    sql: ${TABLE}.refr_source
    
  - dimension: referer_term
    sql: ${TABLE}.refr_term
    
  - dimension: referer_url_host
    sql: ${TABLE}.refr_urlhost
  
  - dimension: referer_url_path
    sql: ${TABLE}.refr_urlpath
    
  # MKT fields (paid acquisition channels)
    
  - dimension: campaign_medium
    sql: ${TABLE}.mkt_medium
  
  - dimension: campaign_source
    sql: ${TABLE}.mkt_source
  
  - dimension: campaign_term
    sql: ${TABLE}.mkt_term
  
  - dimension: campaign_name
    sql: ${TABLE}.mkt_campaign
      
  # Measures #
      
  - measure: count
    type: count_distinct
    sql: ${blended_user_id}
    
  - measure: bounced_visitor_count
    type: count_distinct
    sql: ${blended_user_id}
    filter:
      bounce: yes
    
  - measure: bounce_rate
    type: number
    decimals: 2
    sql: ${bounced_visitor_count}/NULLIF(${count},0)::REAL
    
  - measure: events_count
    type: sum
    sql: ${TABLE}.number_of_events
    
  - measure: events_per_visitor
    type: number
    decimals: 2
    sql: ${events_count}/NULLIF(${count},0)::REAL
    
  - measure: sessions_count
    type: sum
    sql: ${TABLE}.number_of_sessions
    
  - measure: sessions_per_visitor
    type: number
    decimals: 2
    sql: ${sessions_count}/NULLIF(${count},0)::REAL
    

    