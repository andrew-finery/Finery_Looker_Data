- view: sessions
  derived_table:
    sql: |
      SELECT
      
        s.domain_userid,
        s.domain_sessionidx,
        s.session_start_ts,
        id.blended_user_id,
        s.session_end_ts,
        s.number_of_events,
        s.interaction_events,
        s.distinct_pages_viewed,
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
        pg.site_progress
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
      LEFT JOIN (select domain_userid as domain_userid, domain_sessionidx as domain_sessionidx, max(site_progress) as site_progress from ${page_views.SQL_TABLE_NAME} group by 1,2) AS pg
        ON s.domain_userid = pg.domain_userid AND
        s.domain_sessionidx = pg.domain_sessionidx
      LEFT JOIN ${identity_stitching.SQL_TABLE_NAME} AS id
        on s.domain_userid = id.domain_userid
    
    sql_trigger_value: SELECT COUNT(*) FROM ${visitors.SQL_TABLE_NAME}
    distkey: domain_userid
    sortkeys: [domain_userid, domain_sessionidx, session_start_ts]
    
  fields:
  # DIMENSIONS #
  
  # Basic dimensions #
  
  - dimension: user_id
    sql: ${TABLE}.domain_userid
    hidden: true
  
  - dimension: blended_user_id
    sql: ${TABLE}.blended_user_id
    hidden: true
    
  - dimension: session_index
    type: int
    sql: ${TABLE}.domain_sessionidx
    hidden: true
  
  - dimension: session_id
    sql: ${TABLE}.domain_userid || '-' || ${TABLE}.domain_sessionidx
    hidden: true

  - dimension: session_index_tier
    type: tier
    tiers: [1,2,3,4,5,10,25,100,1000]
    sql: ${session_index}
    hidden: true
  
  - dimension: start
    sql: ${TABLE}.session_start_ts
    hidden: true
  
  - dimension_group: start
    type: time
    timeframes: [time, hour, date, hour_of_day, day_of_week, week, month]
    sql: ${TABLE}.session_start_ts
    hidden: true
    
  - dimension: end
    sql: ${TABLE}.session_end_ts
    hidden: true
    
  # Session duration #

  - dimension: session_duration_seconds
    type: int
    sql: EXTRACT(EPOCH FROM (${TABLE}.session_end_ts - ${TABLE}.session_start_ts))
    hidden: true

  - dimension: session_duration_seconds_tiered
    type: tier
    tiers: [0,1,5,10,30,60,300,900]
    sql: ${session_duration_seconds}
    hidden: true

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
    
  - dimension: bounce
    label: BOUNCED SESSION
    type: yesno
    sql: ${TABLE}.interaction_events < 2
  
  # New vs returning visitor #
  - dimension: new_vs_returning_visitor
    sql_case:
      new: ${TABLE}.domain_sessionidx = 1
      returning: ${TABLE}.domain_sessionidx > 1
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
    sql: ${TABLE}.landing_page_urlhost
    
  - dimension: landing_page_path
    sql: ${TABLE}.landing_page_path
    
  - dimension: landing_page
    sql: ${TABLE}.landing_page_host || ${TABLE}.landing_page_path
    
  # Exit page
  
  - dimension: exit_page_host
    sql: ${TABLE}.exit_page_host
    
  - dimension: exit_page_path
    sql: ${TABLE}.exit_page_path
    
  - dimension: exit_page
    sql: ${TABLE}.exit_page_host || ${TABLE}.exit_page_path
    
  # Marketing / traffic source fields

  - dimension: acquisition_channel
    #sql_case:
    #  Referral: ${campaign_medium} = 'referral'
    #  Email: ${campaign_medium} = 'email'
    #  Facebook - Paid: ${campaign_source} = 'facebook' and ${campaign_medium} = 'paid'
    #  Paid Search: ${referer_url_host} = 'www.googleadservices.com'
    #  Organic Search: ${referer_medium} = 'search'
    #  Email: ${referer_medium} = 'email'
    #  Social: ${referer_medium} = 'social'
    #  Referral: ${referer_medium} = 'unknown'
    #  else: Direct
    sql_case:
      Facebook - Paid Marketing: ${TABLE}.mkt_source = 'facebook' and ${TABLE}.mkt_medium = 'paid'
      Paid Search:  ${TABLE}.refr_urlhost = 'www.googleadservices.com'
      Email: ${TABLE}.mkt_medium = 'email' or ${TABLE}.refr_medium = 'email'
      Social: ${TABLE}.refr_medium = 'social'
      Search: ${TABLE}.refr_medium = 'search'
      Affiliates: ${TABLE}.refr_medium = 'unknown'
      Other Marketing Source: ${TABLE}.mkt_source is not null or ${TABLE}.mkt_medium is not null or ${TABLE}.mkt_campaign is not null
      Other Referral Source: ${TABLE}.refr_source is not null or ${TABLE}.refr_medium is not null or ${TABLE}.refr_urlhost is not null
      else: Direct
      
  
  - dimension: referer_medium
    sql_case:
      email: ${TABLE}.refr_medium = 'email'
      search: ${TABLE}.refr_medium = 'search'
      social: ${TABLE}.refr_medium = 'social'
      other_website: ${TABLE}.refr_medium = 'unknown'
      else: direct

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

  # Device fields #
    
  - dimension: device_type
    sql: ${TABLE}.dvce_type
    
  - dimension: device_is_mobile
    sql: ${TABLE}.dvce_ismobile
    
  - dimension: device_screen_width
    sql: ${TABLE}.dvce_screenwidth
    
  - dimension: device_screen_height
    sql: ${TABLE}.dvce_screenheight
    
  # OS fields #
    
  - dimension: operating_system
    sql: ${TABLE}.os_name
    
  - dimension: operating_system_family
    sql: ${TABLE}.os_family
    
  - dimension: operating_system_manufacturer
    sql: ${TABLE}.os_manufacturer
    
  # Browser fields #
  
  - dimension: browser
    sql: ${TABLE}.br_name
    
  - dimension: browser_version
    sql: ${TABLE}.br_version
    
  - dimension: browser_type
    sql: ${TABLE}.br_type
    
  - dimension: browser_family
    sql: ${TABLE}.br_family
    
  - dimension: browser_renderengine
    sql: ${TABLE}.br_renderengine
    
  - dimension: browser_language
    sql: ${TABLE}.br_lang
    
  - dimension: browser_has_director_plugin
    sql: ${TABLE}.br_features_director
    
  - dimension: browser_has_flash_plugin
    sql: ${TABLE}.br_features_flash
    
  - dimension: browser_has_gears_plugin
    sql: ${TABLE}.br_features_gears
    
  - dimension: browser_has_java_plugin
    sql: ${TABLE}.br_features_java
    
  - dimension: browser_has_pdf_plugin
    sql: ${TABLE}.br_features_pdf
    
  - dimension: browser_has_quicktime_plugin
    sql: ${TABLE}.br_features_quicktime
    
  - dimension: browser_has_realplayer_plugin
    sql: ${TABLE}.br_features_realplayer
    
  - dimension: browser_has_silverlight_plugin
    sql: ${TABLE}.br_features_silverlight
    
  - dimension: browser_has_windowsmedia_plugin
    sql: ${TABLE}.br_features_windowsmedia
    
  - dimension: browser_supports_cookies
    sql: ${TABLE}.br_cookies
    
  # site progress  
  
  - dimension: site_progress
    sql_case:
     1 - Home Page/Other: ${TABLE}.site_progress = 1
     2 - Category Page: ${TABLE}.site_progress = 2
     3 - Product Page: ${TABLE}.site_progress = 3
     4 - View Cart: ${TABLE}.site_progress = 4
     5 - Checkout - Enter Address: ${TABLE}.site_progress = 5
     6 - Checkout - Delivery: ${TABLE}.site_progress = 6
     7 - Checkout - Payment: ${TABLE}.site_progress = 7
     8 - Order Completed: ${TABLE}.site_progress = 8
     else: Error
  
  #temp order placed dimension   #
  - dimension: order_placed_temp
    type: yesno
    sql: ${TABLE}.site_progress = 8
  #end#
     
  # MEASURES #

  - measure: count
    type: count_distinct
    sql: ${session_id}
    
  - measure: count_running_total
    type: running_total
    sql: ${count}
    
  - measure: count_percent_of_total
    type: percent_of_total
    sql: ${count}
    
  - measure: visitors_count
    type: count_distinct
    sql: ${user_id}
    hidden: true
    
  - measure: bounced_sessions_count
    type: count_distinct
    sql: ${session_id}
    filters:
      bounce: yes

  - measure: bounce_rate
    type: number
    decimals: 2
    sql: 100.0 * ${bounced_sessions_count}/NULLIF(${count},0)::REAL
    format: "%0.2f%"
    
  - measure: sessions_from_new_visitors_count
    type: count_distinct
    sql: ${session_id}
    filters:
      session_index: 1
  
  - measure: sessions_from_returning_visitor_count
    type: number
    sql: ${count} - ${sessions_from_new_visitors_count}
  
  - measure: new_visitor_percentage
    type: number
    decimals: 2
    sql: 100.0 * ${sessions_from_new_visitors_count}/NULLIF(${count},0)::REAL
    format: "%0.2f%"

  - measure: returning_visitor_percentage
    type: number
    decimals: 2
    sql: 100.0 * ${sessions_from_returning_visitor_count}/NULLIF(${count},0)::REAL
    format: "%0.2f%"
    
  - measure: events_count
    type: sum
    sql: ${TABLE}.number_of_events
    
  - measure: events_per_session
    type: number
    decimals: 2
    sql: ${events_count}/NULLIF(${count},0)::REAL
    
  - measure: events_per_visitor
    type: number
    decimals: 2
    sql: ${events_count}/NULLIF(${visitors_count},0)::REAL
    
  - measure: average_session_duration_seconds
    type: average
    decimals: 2
    sql: ${session_duration_seconds}
    filters:
      session_duration_seconds: < 3600
  
  - measure: average_session_duration
    type: string
    sql: cast(${average_session_duration_seconds}/60 as int)||':'||right('0' || mod(cast(${average_session_duration_seconds} as int), 60), 2)

    
  - measure: page_view_count
    type: sum
    sql: ${TABLE}.distinct_pages_viewed
  
  - measure: pages_per_session
    type: number
    decimals: 2
    sql: ${page_view_count}/NULLIF(${count},0)::REAL
  
  # Geo measures

  - measure: region_count
    type: count_distinct
    sql: ${geography_region}
    
  - measure: city_count
    type: count_distinct
    sql: ${geography_city}
      
  - measure: zip_code_count
    type: count_distinct
    sql: ${geography_zipcode}
    
  - measure: campaign_medium_count
    type: count_distinct
    sql: ${campaign_medium}
    
  - measure: campaign_source_count
    type: count_distinct
    sql: ${campaign_source}
    
  - measure: campaign_term_count
    type: count_distinct
    sql: ${campaign_term}

  - measure: campaign_count
    type: count_distinct
    sql: ${campaign_name}

  - measure: referer_medium_count
    type: count_distinct
    sql: ${referer_medium}

  - measure: referer_source_count
    type: count_distinct
    sql: ${referer_source}

  - measure: referer_term_count
    type: count_distinct
    sql: ${referer_term}

  # Technology measures 
  
  - measure: device_count
    type: count_distinct
    sql: ${device_type}
  
  - measure: operating_system_count
    type: count_distinct
    sql: ${operating_system}
  
  - measure: browser_count
    type: count_distinct
    sql: ${browser}
    