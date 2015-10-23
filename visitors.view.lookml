- view: visitors
  sql_table_name: website_data.visitors
  fields:
  
  # DIMENSIONS # 
  
  # Basic dimensions #
  
  - dimension: blended_user_id
    sql: ${TABLE}.blended_user_id

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
    label: First Touch Acquisition Channel
    sql_case:
      Facebook - Paid Marketing: ${TABLE}.mkt_source_ga = 'facebook' and ${TABLE}.mkt_medium_ga = 'paid'
      SEM Brand: ${TABLE}.mkt_campaign_ga = '313295483'
      SEM Non-Brand: ${TABLE}.mkt_source_ga = 'GoogleSearch' or ${TABLE}.mkt_source_ga = 'GoogleContent' or ${TABLE}.refr_urlhost_ga = 'www.googleadservices.com'
      CRM: ${TABLE}.mkt_source_ga = 'crm' or ${TABLE}.mkt_medium_ga = 'crm' or ${TABLE}.mkt_source_ga = 'newsletter'
      Email: ${TABLE}.mkt_medium_ga = 'email' or ${TABLE}.refr_medium_ga = 'email'
      Social: ${TABLE}.refr_medium_ga = 'social' or ${TABLE}.mkt_source_ga = 'facebook'
      Search: ${TABLE}.refr_medium_ga = 'search'
      Affiliates: ${TABLE}.refr_urlhost_ga = 'www.shareasale.com' or ${TABLE}.mkt_medium_ga = 'affiliate'
      Referrals: ${TABLE}.refr_medium_ga = 'unknown'
      Other Marketing Source: ${TABLE}.mkt_source_ga is not null or ${TABLE}.mkt_medium_ga is not null or ${TABLE}.mkt_campaign_ga is not null
      else: Direct
      
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
    

    