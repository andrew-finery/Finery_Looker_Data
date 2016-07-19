- view: visitors
  sql_table_name:  web.visitors
  fields:
  
  # DIMENSIONS # 
  
  # Basic dimensions #
  
  - dimension: blended_user_id
    sql: ${TABLE}.blended_user_id

  - dimension: email_address
    sql: case when ${TABLE}.blended_user_id like '%@%' then ${TABLE}.blended_user_id else null end

  - dimension_group: first_touch
    label: First Touch
    type: time
    timeframes: [time, hour, date, day_of_week, week, month]
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
    sql: ${events_during_lifetime}

  - dimension: number_of_visits
    type: int
    sql: ${TABLE}.number_of_sessions
    
  - dimension: number_of_visits_tiered
    type: tier
    tiers: [1,2,5,10,25,50,100,1000]
    sql: ${number_of_visits}
  
  - dimension: visits_after_first_purchase
    type: int
    sql: ${TABLE}.visits_after_first_purchase
  
  # Landing page dimensions #
  
  - dimension: landing_page_url_host
    sql: ${TABLE}.page_urlhost
    
  - dimension: landing_page_url_path
    sql: ${TABLE}.page_urlpath
    
  - dimension: landing_page_url
    sql: ${TABLE}.page_urlhost || ${TABLE}.page_urlpath  
    
  # Referer source dimensions #

  - dimension: acquisition_channel
    label: First Touch Acquisition Channel
    sql: ${TABLE}.acquisition_channel

  - dimension: traffic_source
    label: First Touch CRM/Brand/Paid
    sql_case:
      CRM: ${acquisition_channel} = 'CRM'
      Paid: ${acquisition_channel} in ('SEM Non-Brand', 'Affiliates', 'Facebook - Paid Marketing')
      else: Brand

  - dimension: channel_grouping_3
    label: First Touch Search + Direct / Facebook / Other
    sql_case:
      Search & Direct: ${acquisition_channel} in ('SEM Brand', 'Search', 'Direct')
      Facebook (Paid): ${acquisition_channel} in ('Facebook - Paid Marketing')
      else: Other
      
  - dimension: referer_source
    sql: ${TABLE}.refr_source_ga
    
  - dimension: referer_term
    sql: ${TABLE}.refr_term_ga
    
  - dimension: referer_url_host
    sql: ${TABLE}.refr_urlhost_ga
  
  - dimension: referer_url_path
    sql: ${TABLE}.refr_urlpath_ga
    
  # MKT fields (paid acquisition channels)
    
  - dimension: campaign_medium
    sql: ${TABLE}.mkt_medium_ga
  
  - dimension: campaign_source
    sql: ${TABLE}.mkt_source_ga
  
  - dimension: campaign_term
    sql: ${TABLE}.mkt_term_ga
  
  - dimension: campaign_name
    sql: ${TABLE}.mkt_campaign_ga
      
  # Measures #
      
  - measure: total_visitors
    type: count_distinct
    sql: ${blended_user_id}
    
  - measure: total_events
    type: sum
    sql: ${events_during_lifetime}
    
  - measure: events_per_visitor
    type: number
    decimals: 2
    sql: ${total_events}/NULLIF(${total_visitors},0)::REAL
    
  - measure: total_visits
    type: sum
    sql: ${number_of_visits}
    
  - measure: sessions_per_visitor
    type: number
    decimals: 2
    sql: ${total_visits}/NULLIF(${total_visitors},0)::REAL

  - dimension: total_visits_after_first_purchase
    type: sum
    sql: ${visits_after_first_purchase}

  - dimension: avg_after_first_purchase
    type: average
    sql: ${visits_after_first_purchase}

    