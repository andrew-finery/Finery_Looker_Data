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
      Facebook - Paid Marketing: (${TABLE}.mkt_source_ga = 'facebook' or ${TABLE}.refr_source_ga = 'Facebook')  and ${TABLE}.mkt_medium_ga in ('paid', 'unpaid', 'Paid')
      SEM Non-Brand: (${TABLE}.mkt_source_ga = 'GoogleSearch' or ${TABLE}.mkt_source_ga = 'GoogleContent' or ${TABLE}.mkt_source_ga = 'bing') and not (${TABLE}.mkt_campaign_ga in ('313295483','390136763','330829240','271429360','451879332','271994683','382391172','311393283','249190494','262208533') or ${TABLE}.mkt_campaign_ga like '%Brand%' or ${TABLE}.mkt_campaign_ga is null)
      SEM Brand: ${TABLE}.refr_urlhost_ga = 'www.googleadservices.com' or mkt_medium_ga = 'cpc'
      CRM: ${TABLE}.mkt_source_ga = 'crm' or ${TABLE}.mkt_medium_ga = 'crm' or ${TABLE}.mkt_source_ga = 'newsletter'
      Email: ${TABLE}.mkt_medium_ga = 'email' or ${TABLE}.refr_medium_ga = 'email' 
      Social: ${TABLE}.refr_medium_ga = 'social' or ${TABLE}.mkt_source_ga = 'facebook' or ${TABLE}.mkt_source_ga = 'instagram' or ${TABLE}.mkt_source_ga = 'fb'
      Search: ${TABLE}.refr_medium_ga = 'search'
      Affiliates: ${TABLE}.refr_urlhost_ga = 'www.shareasale.com' or ${TABLE}.mkt_medium_ga = 'affiliate' or ${TABLE}.refr_urlhost_ga = 'www.polyvore.com'
      Referrals: ${TABLE}.refr_medium_ga = 'unknown'
      Facebook - Paid Marketing: ${TABLE}.mkt_medium_ga in ('paid', 'unpaid', 'Paid')
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
    

    