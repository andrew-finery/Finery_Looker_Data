- view: sessions
  derived_table:
    sql: |
      SELECT
      
        s.domain_userid,
        s.domain_sessionidx,
        id.blended_user_id,
        s.session_start_ts,
        s.user_id,
        s.session_end_ts,
        s.number_of_events,
        s.interaction_events,
        s.distinct_pages_viewed,
        s.free_gift_click_events,
        s.accounts_created,
        s.newsletter_signups,
        s.products_added_to_cart,
        s.product_removed_from_cart,
        s.cart_events,
        s.checkout_progress,
        g.geo_country_code_2_characters,
        g.geo_region,
        g.geo_city,
        g.geo_zipcode,
        g.geo_latitude,
        g.geo_longitude,
        l.page_urlhost AS landing_page_host,
        l.page_urlpath AS landing_page_path,
        l2.page_urlhost AS exit_page_host,
        l2.page_urlpath AS exit_page_path,
        s2.mkt_source,
        s2.mkt_medium,
        s2.mkt_term,
        s2.mkt_campaign,
        s2.refr_source,
        s2.refr_medium,
        s2.refr_term,
        s2.refr_urlhost,
        s2.refr_urlpath,
        s2.mkt_source_ga,
        s2.mkt_medium_ga,
        s2.mkt_term_ga,
        s2.mkt_campaign_ga,
        s2.refr_source_ga,
        s2.refr_medium_ga,
        s2.refr_term_ga,
        s2.refr_urlhost_ga,
        s2.refr_urlpath_ga,
        t.br_name,
        t.br_family,
        t.br_version,
        t.br_type,
        t.br_renderengine,
        t.br_lang,
        t.br_features_director,
        t.br_features_flash,
        t.br_features_gears,
        t.br_features_java,
        t.br_features_pdf,
        t.br_features_quicktime,
        t.br_features_realplayer,
        t.br_features_silverlight,
        t.br_features_windowsmedia,
        t.br_cookies,
        t.os_name,
        t.os_family,
        t.os_manufacturer,
        t.os_timezone,
        t.dvce_type,
        t.dvce_ismobile,
        t.dvce_screenwidth,
        t.dvce_screenheight,
        rank() over(partition by id.blended_user_id order by s.session_start_ts asc) as session_index
        
      FROM ${sessions_basic.SQL_TABLE_NAME} AS s
      LEFT JOIN ${sessions_geo.SQL_TABLE_NAME} AS g
        ON s.domain_userid = g.domain_userid AND
        s.domain_sessionidx = g.domain_sessionidx
      LEFT JOIN ${sessions_landing_page.SQL_TABLE_NAME} AS l
        ON s.domain_userid = l.domain_userid AND
        s.domain_sessionidx = l.domain_sessionidx
      LEFT JOIN ${sessions_last_page.SQL_TABLE_NAME} AS l2
        ON s.domain_userid = l2.domain_userid AND
        s.domain_sessionidx = l2.domain_sessionidx
      LEFT JOIN ${sessions_source.SQL_TABLE_NAME} AS s2
        ON s.domain_userid = s2.domain_userid AND
        s.domain_sessionidx = s2.domain_sessionidx
      LEFT JOIN ${sessions_technology.SQL_TABLE_NAME} AS t
        ON s.domain_userid = t.domain_userid AND
        s.domain_sessionidx = t.domain_sessionidx
      LEFT JOIN ${identity_stitching.SQL_TABLE_NAME} AS id
        on s.domain_userid = id.domain_userid
      
    sql_trigger_value: SELECT COUNT(*) FROM ${visitors.SQL_TABLE_NAME}
    distkey: domain_userid
    sortkeys: [domain_userid, domain_sessionidx, session_start_ts]
    
  fields:

    #######################################################################################################################################################################
  ################################################################ DIMENSIONS ###########################################################################################
#######################################################################################################################################################################
  
  # Basic dimensions #
  
  - dimension: user_id
    sql: ${TABLE}.domain_userid
    hidden: true
  
  - dimension: domain_session_index
    sql: ${TABLE}.domain_sessionidx
    hidden: true
  
  - dimension: blended_user_id
    sql: ${TABLE}.blended_user_id
    hidden: true
    
  - dimension: session_index
    label: SESSION INDEX
    type: int
    sql: ${TABLE}.session_index
  
  - dimension: session_id
    sql: ${TABLE}.domain_userid || '-' || ${TABLE}.domain_sessionidx
    hidden: true
    primary_key: true
    
  - dimension: session_index_tier
    label: SESSION INDEX TIER
    type: tier
    tiers: [1,2,3,4,5,10,25,100,1000]
    sql: ${session_index}

  - dimension_group: start
    label: SESSION START
    type: time
    timeframes: [time, hour, date, hour_of_day, day_of_week, week, month]
    sql: ${TABLE}.session_start_ts

  - dimension: start
    sql: ${TABLE}.session_start_ts
    hidden: true
    
  - dimension: end
    sql: ${TABLE}.session_end_ts
    hidden: true
    
  - dimension: session_duration_seconds
    sql: extract(epoch from ${end}) - extract(epoch from ${start})

  # Events per visit and bounces (infered) #

  - dimension: events_during_session
    type: int
    sql: ${TABLE}.number_of_events
    hidden: true
    
  - dimension: events_during_session_tiered
    type: tier
    tiers: [1,2,5,10,25,50,100,1000,10000]
    sql: ${TABLE}.number_of_events
    hidden: true
  
  - dimension: log_in_flag
    label: SESSION LOGGED IN FLAG
    type: yesno
    sql: ${TABLE}.user_id is not null
  
  - dimension: free_gift_click_flag
    label: SESSION INVOLVES FREE GIFT CLICK
    type: yesno
    sql: ${TABLE}.free_gift_click_events > 0
    
  - dimension: bounce
    label: BOUNCED SESSION
    type: yesno
    sql: ${TABLE}.interaction_events < 2 and ${TABLE}.distinct_pages_viewed = 1
 
  - dimension: engaged_session
    label: ENGAGED SESSION
    type: yesno
    sql: ${session_duration_seconds} > 239 or ${distinct_pages_viewed} > 6
#    |
#        case
#        when (
#        ${register_success.event_id} is not null
#        or ${newsletter_subscriptions.event_id} is not null
#        or ${transactions.event_id} is not null
#        or ${product_in_checkout.event_id} is not null
#        or ${product_in_cart.event_id} is not null
#        or ${sessions.distinct_pages_viewed} > 6
#        or ${sessions.session_duration_seconds} > 239
#        ) then ${session_id} else null end
 
  # New vs returning visitor #
  - dimension: new_vs_returning_visitor
    sql_case:
      new: ${session_index} = 1
      returning: ${session_index} > 1
      else: unknown
   
  # Pages visited #
  - dimension: distinct_pages_viewed
    sql: ${TABLE}.distinct_pages_viewed
    hidden: true
    
  - dimension: distinct_pages_viewed_tiered
    type: tier
    tiers: [1,2,3,4,5,10,25,100,1000]
    sql: ${TABLE}.distinct_pages_viewed
    hidden: true
  
  - dimension: event_stream
    sql: ${session_id}
    hidden: true
    
  # Geo fields #
  - dimension: geography_country_two_letter_iso_code
    sql: ${TABLE}.geo_country_code_2_characters
    hidden: true
  
  - dimension: geography_region
    sql: ${TABLE}.geo_region
    hidden: true
    
  - dimension: geography_city
    sql: ${TABLE}.geo_city
    hidden: true
    
  - dimension: geography_zipcode
    sql: ${TABLE}.geo_zipcode
    hidden: true
    
  - dimension: geography_latitude
    sql: ${TABLE}.geo_latitude
    hidden: true
  
  - dimension: geography_longitude
    sql: ${TABLE}.geo_longitude
    hidden: true
    
  # Landing page
    
  - dimension: landing_page_host
    sql: ${TABLE}.landing_page_host
    hidden: true
    
  - dimension: landing_page_path
    label: LANDING PAGE PATH
    sql: ${TABLE}.landing_page_path
    
    
  - dimension: landing_page
    label: FULL LANDING PAGE
    sql: ${TABLE}.landing_page_host || ${TABLE}.landing_page_path
    
  # Exit page
  
  - dimension: exit_page_host
    sql: ${TABLE}.exit_page_host
    hidden: true
    
  - dimension: exit_page_path
    label: EXIT PAGE PATH
    sql: ${TABLE}.exit_page_path
    
  - dimension: exit_page
    label: FULL EXIT PAGE
    sql: ${TABLE}.exit_page_host || ${TABLE}.exit_page_path

################################ MARKETING #################################################################################################

  - dimension: acquisition_channel
    label: ACQUISITION CHANNEL
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
  
  - dimension: traffic_source
    label: TRAFFIC SOURCE
    sql_case:
      CRM: ${acquisition_channel} = 'CRM'
      Paid: ${acquisition_channel} in ('SEM Non-Brand', 'Affiliates', 'Facebook - Paid Marketing')
      else: Brand

  - dimension: paid_unpaid_traffic_flag
    label: PAID MARKETING FLAG
    sql_case:
      Paid: ${acquisition_channel} in ('SEM Brand', 'SEM Non-Brand', 'Affiliates', 'Facebook - Paid Marketing')
      else: Unpaid

  - dimension: referer_medium
    label: REFERRER MEDIUM
    sql: ${TABLE}.refr_medium_ga
    
  - dimension: referer_source
    label: REFERRER SOURCE
    sql: ${TABLE}.refr_source_ga
    
  - dimension: referer_term
    label: REFERRER TERM
    sql: ${TABLE}.refr_term_ga
    
  - dimension: referer_url_host
    label: REFERRER HOST
    sql: ${TABLE}.refr_urlhost_ga
  
  - dimension: referer_url_path
    label: REFERRER PATH
    sql: ${TABLE}.refr_urlpath_ga
    
  # MKT fields (paid acquisition channels)
    
  - dimension: campaign_medium
    label: CAMPAIGN MEDIUM
    sql: ${TABLE}.mkt_medium_ga
  
  - dimension: campaign_source
    label: CAMPAIGN SOURCE
    sql: ${TABLE}.mkt_source_ga
  
  - dimension: campaign_term
    label: CAMPAIGN TERM
    sql: ${TABLE}.mkt_term_ga
  
  - dimension: campaign_name
    label: CAMPAIGN NAME
    sql: ${TABLE}.mkt_campaign_ga

  # Device fields #
    
  - dimension: device_type
    label: DEVICE TYPE
    sql: ${TABLE}.dvce_type
    
  - dimension: device_is_mobile
    label: MOBILE DEVICE FLAG
    sql: ${TABLE}.dvce_ismobile
    
  - dimension: device_screen_width
    sql: ${TABLE}.dvce_screenwidth
    hidden: true
    
  - dimension: device_screen_height
    sql: ${TABLE}.dvce_screenheight
    hidden: true
    
  # OS fields #
    
  - dimension: operating_system
    label: OPERATING SYSTEM
    sql: ${TABLE}.os_name
    
  - dimension: operating_system_family
    label: OPERATING SYSTEM FAMILY
    sql: ${TABLE}.os_family
    
  - dimension: operating_system_manufacturer
    label: OPERATING SYSTEM MANUFACTURER
    sql: ${TABLE}.os_manufacturer
    
  # Browser fields #
  
  - dimension: browser
    label: BROSWER
    sql: ${TABLE}.br_name
    
  - dimension: browser_version
    label: BROSWER VERSION
    sql: ${TABLE}.br_version
    
  - dimension: browser_type
    label: BROWSER TYPE
    sql: ${TABLE}.br_type
    
  - dimension: browser_family
    label: BROSWER FAMILY
    sql: ${TABLE}.br_family
    
  - dimension: browser_renderengine
    sql: ${TABLE}.br_renderengine
    hidden: true
    
  - dimension: browser_language
    sql: ${TABLE}.br_lang
    hidden: true
    
  - dimension: browser_has_director_plugin
    sql: ${TABLE}.br_features_director
    hidden: true
    
  - dimension: browser_has_flash_plugin
    sql: ${TABLE}.br_features_flash
    hidden: true
    
  - dimension: browser_has_gears_plugin
    sql: ${TABLE}.br_features_gears
    hidden: true
    
  - dimension: browser_has_java_plugin
    sql: ${TABLE}.br_features_java
    hidden: true
    
  - dimension: browser_has_pdf_plugin
    sql: ${TABLE}.br_features_pdf
    hidden: true
    
  - dimension: browser_has_quicktime_plugin
    sql: ${TABLE}.br_features_quicktime
    hidden: true
    
  - dimension: browser_has_realplayer_plugin
    sql: ${TABLE}.br_features_realplayer
    hidden: true
    
  - dimension: browser_has_silverlight_plugin
    sql: ${TABLE}.br_features_silverlight
    hidden: true
    
  - dimension: browser_has_windowsmedia_plugin
    sql: ${TABLE}.br_features_windowsmedia
    hidden: true
    
  - dimension: browser_supports_cookies
    sql: ${TABLE}.br_cookies

    ##########################################################################################################################################################
  ######################################################## MEASURES ########################################################################################
##########################################################################################################################################################

  - measure: count
    label: VISITS COUNT
    type: count_distinct
    sql: ${session_id}
    
  - measure: count_running_total
    label: VISITS RUNNING TOTAL
    type: running_total
    sql: ${count}
    
  - measure: count_percent_of_total
    label: VISITS PERCENT OF TOTAL
    type: percent_of_total
    sql: ${count}

  - measure: bounced_sessions_count
    label: BOUNCED SESSIONS COUNT
    type: count_distinct
    sql: ${session_id}
    filters:
      bounce: yes

  - measure: bounce_rate
    label: BOUNCE RATE
    type: number
    decimals: 2
    sql: 100.0 * ${bounced_sessions_count}/NULLIF(${count},0)::REAL
    format: "%0.2f%"

  - measure: sessions_from_new_visitors_count
    label: NEW VISITS COUNT
    type: count_distinct
    sql: ${session_id}
    filters:
      session_index: 1
  
  - measure: sessions_from_returning_visitor_count
    label: RETURNING VISITS COUNT
    type: number
    sql: ${count} - ${sessions_from_new_visitors_count}
  
  - measure: new_visitor_percentage
    label: NEW VISITS PERCENTAGE
    type: number
    decimals: 2
    sql: 100.0 * ${sessions_from_new_visitors_count}/NULLIF(${count},0)::REAL
    format: "%0.2f%"

  - measure: returning_visitor_percentage
    label: RETURNING VISITS PERCENTAGE
    type: number
    decimals: 2
    sql: 100.0 * ${sessions_from_returning_visitor_count}/NULLIF(${count},0)::REAL
    format: "%0.2f%"

  - measure: visitors_count
    label: VISITORS COUNT
    type: count_distinct
    sql: ${blended_user_id}
    
  - measure: events_count
    label: EVENTS COUNT
    type: sum
    sql: ${TABLE}.number_of_events
    
  - measure: events_per_session
    label: EVENTS PER SESSION
    type: number
    decimals: 2
    sql: ${events_count}/NULLIF(${count},0)::REAL
    
  - measure: events_per_visitor
    label: EVENTS PER VISITOR
    type: number
    decimals: 2
    sql: ${events_count}/NULLIF(${visitors_count},0)::REAL
