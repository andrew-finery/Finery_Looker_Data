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
        s.referrals_sent,
        s.accounts_created,
        s.newsletter_signups,
        s.products_added_to_cart,
        s.product_removed_from_cart,
        s.cart_events,
        s.checkout_progress,
        s.product_impressions,
        s.product_clicks,
        s.product_views,
        s.sale_link_clicks,
        s.successful_logins,
        s.unsuccessful_logins,
        s.unsuccessful_registrations,
        s.sale_events,
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
        s2.mkt_content,
        s2.refr_source,
        s2.refr_medium,
        s2.refr_term,
        s2.refr_urlhost,
        s2.refr_urlpath,
        s2.mkt_source_ga,
        s2.mkt_medium_ga,
        s2.mkt_term_ga,
        s2.mkt_campaign_ga,
        s2.mkt_content_ga,
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
  
  - dimension: domain_user_id
    sql: ${TABLE}.domain_userid
  
  - dimension: domain_session_index
    sql: ${TABLE}.domain_sessionidx
  
  - dimension: blended_user_id
    sql: ${TABLE}.blended_user_id
    hidden: true
    
  - dimension: session_index
    label: Visit Number
    type: int
    sql: ${TABLE}.session_index
  
  - dimension: session_id
    sql: ${TABLE}.domain_userid || '-' || ${TABLE}.domain_sessionidx
    hidden: true
    primary_key: true
    
  - dimension: session_index_tier
    label: Visit Number Tier
    type: tier
    tiers: [1,2,3,4,5,10,25,100,1000]
    sql: ${session_index}

  - dimension_group: start
    label: Visit Start
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
    label: Session Duration Seconds
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
    label: Login Flag
    type: yesno
    sql: ${TABLE}.user_id is not null
    
  - dimension: bounce
    label: Bounce
    type: yesno
    sql: ${TABLE}.interaction_events < 2 and ${TABLE}.distinct_pages_viewed = 1

  - dimension: accounts_created
    type: int
    sql: ${TABLE}.accounts_created
    hidden: true

  - dimension: newsletter_signups
    type: int
    sql: ${TABLE}.newsletter_signups
    hidden: true

  - dimension: products_added_to_cart
    type: int
    sql: ${TABLE}.products_added_to_cart
    hidden: true

  - dimension: product_removed_from_cart
    type: int
    sql: ${TABLE}.product_removed_from_cart
    hidden: true

  - dimension: cart_events
    type: int
    sql: ${TABLE}.cart_events
    hidden: true

  - dimension: referrals_sent
    type: int
    sql: ${TABLE}.referrals_sent
    hidden: true

  - dimension: checkout_progress
    type: int
    sql: ${TABLE}.checkout_progress
    hidden: true

  - dimension: product_impressions
    type: int
    sql: ${TABLE}.product_impressions
    hidden: true

  - dimension: product_clicks
    type: int
    sql: ${TABLE}.product_clicks
    hidden: true

  - dimension: product_views
    type: int
    sql: ${TABLE}.product_views
    hidden: true
    
  - dimension: engaged_session
    label: Engaged Visit
    type: yesno
    sql: |
          ${distinct_pages_viewed} > 6
          or ${accounts_created} > 0
          or ${newsletter_signups} > 0
          or ${products_added_to_cart} > 0
          or ${cart_events} > 0
          or ${checkout_progress} > 0
          or ${transactions.order_id} is not null
          or ${session_duration_seconds} > 239
 
  # New vs returning visitor #
  - dimension: new_vs_returning_visitor
    label: New vs Returning Visitor
    sql_case:
      new: ${session_index} = 1
      returning: ${session_index} > 1
      else: unknown

  - dimension: referral_sent_flag
    type: yesno
    sql: ${referrals_sent} > 0
   
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
    label: Geo - Country Code
    sql: ${TABLE}.geo_country_code_2_characters

  - dimension: geography_region
    label: Geo - Region
    sql: ${TABLE}.geo_region

  - dimension: geography_city
    label: Geo - City
    sql: ${TABLE}.geo_city

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
    label: Landing Page Path
    sql: ${TABLE}.landing_page_path
    
    
  - dimension: landing_page
    label: Landing Page Full
    sql: ${TABLE}.landing_page_host || ${TABLE}.landing_page_path
    hidden: true
    
  # Exit page
  
  - dimension: exit_page_host
    sql: ${TABLE}.exit_page_host
    hidden: true
    
  - dimension: exit_page_path
    label: Exit Page Path
    sql: ${TABLE}.exit_page_path
    
  - dimension: exit_page
    label: Exit Page Full
    sql: ${TABLE}.exit_page_host || ${TABLE}.exit_page_path
    hidden: true

 # Sale tracking dimensions flag

  - dimension: sale_link_clicked_flag
    type: yesno
    sql: ${TABLE}.sale_link_clicks > 0

  - dimension: successful_registration_flag
    type: yesno
    sql: ${TABLE}.accounts_created > 0

  - dimension: successful_login_flag
    type: yesno
    sql: ${TABLE}.successful_logins > 0

  - dimension: unsuccessful_logins_flag
    type: yesno
    sql: ${TABLE}.unsuccessful_logins > 0

  - dimension: unsuccessful_registrations_flag
    type: yesno
    sql: ${TABLE}.unsuccessful_registrations > 0
    
  - dimension: viewed_sale_flag
    type: yesno
    sql: ${TABLE}.sale_events > 0
  
  - dimension: sale_interaction
    sql_case:
      Clicked Sale Link - Viewed Sale - Already Logged In: ${TABLE}.sale_link_clicks > 0 and ${TABLE}.sale_events > 0 and ${TABLE}.successful_logins = 0 and ${TABLE}.accounts_created = 0
      Clicked Sale Link - Viewed Sale - Signed In/Created Account (Non-Bounce From Modal): ${TABLE}.sale_link_clicks > 0 and ${TABLE}.sale_events > 0 and (${TABLE}.successful_logins > 0 or ${TABLE}.accounts_created > 0)
      Clicked Sale Link - Did Not View Sale (Bounced From Modal): ${TABLE}.sale_link_clicks > 0 and ${TABLE}.sale_events = 0
      No Sale Links Click - Landed on Sale Page: ${TABLE}.sale_link_clicks = 0 and ${TABLE}.sale_events > 0
      No Sale Link Click - Non-Bounce: ${TABLE}.sale_link_clicks = 0 and not(${bounce})
      No Sale Link Click - Bounce: ${TABLE}.sale_link_clicks = 0 and ${bounce}
      else: Other
  
  

################################ MARKETING #################################################################################################

  - dimension: acquisition_channel
    label: Acquisition Channel
    sql_case:
      Facebook - Paid Marketing: ${TABLE}.mkt_source_ga = 'facebook' and ${TABLE}.mkt_medium_ga in ('paid', 'unpaid') ## take unpaid out once issues sorted
      SEM Brand: ${TABLE}.mkt_campaign_ga = '313295483' or ${TABLE}.mkt_campaign_ga like '%Brand%'
      SEM Non-Brand: ${TABLE}.mkt_source_ga = 'GoogleSearch' or ${TABLE}.mkt_source_ga = 'GoogleContent' or ${TABLE}.mkt_source_ga = 'bing'
      SEM Brand: ${TABLE}.refr_urlhost_ga = 'www.googleadservices.com'
      CRM: ${TABLE}.mkt_source_ga = 'crm' or ${TABLE}.mkt_medium_ga = 'crm' or ${TABLE}.mkt_source_ga = 'newsletter'
      Email: ${TABLE}.mkt_medium_ga = 'email' or ${TABLE}.refr_medium_ga = 'email' 
      Social: ${TABLE}.refr_medium_ga = 'social' or ${TABLE}.mkt_source_ga = 'facebook' or ${TABLE}.mkt_source_ga = 'instagram' or ${TABLE}.mkt_source_ga = 'fb'
      Search: ${TABLE}.refr_medium_ga = 'search'
      Affiliates: ${TABLE}.refr_urlhost_ga = 'www.shareasale.com' or ${TABLE}.mkt_medium_ga = 'affiliate' or ${TABLE}.refr_urlhost_ga = 'www.polyvore.com'
      Referrals: ${TABLE}.refr_medium_ga = 'unknown'
      Other Marketing Source: ${TABLE}.mkt_source_ga is not null or ${TABLE}.mkt_medium_ga is not null or ${TABLE}.mkt_campaign_ga is not null
      else: Direct
  
  - dimension: traffic_source
    label: CRM/Brand/Paid
    sql_case:
      CRM: ${acquisition_channel} = 'CRM'
      Paid: ${acquisition_channel} in ('SEM Non-Brand', 'Affiliates', 'Facebook - Paid Marketing')
      else: Brand

  - dimension: paid_unpaid_traffic_flag
    label: Paid/Unpaid
    sql_case:
      Paid: ${acquisition_channel} in ('SEM Brand', 'SEM Non-Brand', 'Affiliates', 'Facebook - Paid Marketing')
      else: Unpaid

  - dimension: direct_session_flag
    label: Direct Session Flag
    type: yesno
    sql: |
          ${TABLE}.mkt_source is null and
          ${TABLE}.mkt_medium is null and
          ${TABLE}.mkt_term is null and
          ${TABLE}.mkt_campaign is null and
          ${TABLE}.mkt_content is null and
          ${TABLE}.refr_source is null and
          ${TABLE}.refr_medium is null and
          ${TABLE}.refr_term is null and
          ${TABLE}.refr_urlhost is null and
          ${TABLE}.refr_urlpath is null

  - dimension: referer_medium
    label: Referrer Medium
    sql: ${TABLE}.refr_medium_ga
    
  - dimension: referer_source
    label: Referrer Source
    sql: ${TABLE}.refr_source_ga
    
  - dimension: referer_term
    label: Referrer Term
    sql: ${TABLE}.refr_term_ga
    
  - dimension: referer_url_host
    label:  Referrer Host
    sql: ${TABLE}.refr_urlhost_ga
  
  - dimension: referer_url_path
    label: Referrer Path
    sql: ${TABLE}.refr_urlpath_ga
    
  # MKT fields (paid acquisition channels)
    
  - dimension: campaign_medium
    label: Campaign Medium
    sql: ${TABLE}.mkt_medium_ga
  
  - dimension: campaign_source
    label: Campaign Source
    sql: ${TABLE}.mkt_source_ga
  
  - dimension: campaign_term
    label: Campaign Term
    sql: ${TABLE}.mkt_term_ga
  
  - dimension: campaign_name
    label: Campaign Name
    sql: ${TABLE}.mkt_campaign_ga

  - dimension: campaign_content
    label: Campaign Content
    sql: ${TABLE}.mkt_content_ga

  # Device fields #
    
  - dimension: device_type
    label: Device Type
    sql_case:
      Desktop: ${TABLE}.dvce_type = 'Computer'
      Tablet: ${TABLE}.dvce_type = 'Tablet'
      Mobile: ${TABLE}.dvce_type = 'Mobile'
      else: Other/Unknown
      
  - dimension: device_is_mobile
    label: Mobile Flag
    sql: ${TABLE}.dvce_ismobile
    hidden: true
    
  - dimension: device_screen_width
    sql: ${TABLE}.dvce_screenwidth
    hidden: true
    
  - dimension: device_screen_height
    sql: ${TABLE}.dvce_screenheight
    hidden: true
    
  # OS fields #
    
  - dimension: operating_system
    label: Operating System
    sql: ${TABLE}.os_name
    
  - dimension: operating_system_family
    label: Operating System Family
    sql: ${TABLE}.os_family
    
  - dimension: operating_system_manufacturer
    label: Operating System Manufacturer
    sql: ${TABLE}.os_manufacturer
    
  # Browser fields #
  
  - dimension: browser
    label: Browser
    sql: ${TABLE}.br_name
    
  - dimension: browser_version
    label: Browser Version
    sql: ${TABLE}.br_version
    
  - dimension: browser_type
    label: Browser Type
    sql: ${TABLE}.br_type
    
  - dimension: browser_family
    label: Browser Family
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
    hidden: true

    ##########################################################################################################################################################
  ######################################################## MEASURES ########################################################################################
##########################################################################################################################################################
  
  - measure: latest_data
    type: string
    sql: max(${start_time})
    
  - measure: count
    label: Visits Total
    type: count_distinct
    sql: ${session_id}
    
  - measure: count_running_total
    label: Visits Running Total
    type: running_total
    sql: ${count}
    
  - measure: count_percent_of_total
    label: Visits Percent of Total
    type: percent_of_total
    sql: ${count}

  - measure: bounced_sessions_count
    label: Bounced Visits Total
    type: count_distinct
    sql: ${session_id}
    filters:
      bounce: yes

  - measure: bounce_rate
    label: Bounce Rate
    type: number
    decimals: 4
    sql: ${bounced_sessions_count}/NULLIF(${count},0)::REAL
    value_format: '0.00%'

  - measure: engaged_sessions_count
    label: Engaged Sessions Total
    type: count_distinct
    sql: ${session_id}
    filters:
      engaged_session: yes

  - measure: engagement_rate
    label: Engagement Rate
    type: number
    decimals: 4
    sql: ${engaged_sessions_count}/NULLIF(${count},0)::REAL
    value_format: '0.00%'

  - measure: engagement_rate_short_name
    label: Engag. Rate
    type: number
    decimals: 4
    sql: ${engaged_sessions_count}/NULLIF(${count},0)::REAL
    value_format: '0.00%'

  - measure: logged_in_sessions_count
    label: Logged In Visits Total
    type: count_distinct
    sql: ${session_id}
    filters:
      log_in_flag: yes

  - measure: conversion_rate
    label: Conversion Rate
    type: number
    decimals: 4
    sql: ${transactions.count_transactions}/NULLIF(${count},0)::REAL
    value_format: '0.00%'

  - measure: conversion_rate_short_name
    label: Conv. Rate
    type: number
    decimals: 4
    sql: ${transactions.count_transactions}/NULLIF(${count},0)::REAL
    value_format: '0.00%'
    hidden: true
    
  - measure: revenue_per_session
    label: Revenue Per Visit
    type: number
    decimals: 2
    sql: ${transactions.gross_revenue_ex_discount_ex_vat}/NULLIF(${count},0)::REAL
    value_format: '"£"#0.00'
    
  - measure: sessions_from_new_visitors_count
    label: New Visits Total
    type: count_distinct
    sql: ${session_id}
    filters:
      session_index: 1
  
  - measure: sessions_from_returning_visitor_count
    label: Returning Visits Total
    type: number
    sql: ${count} - ${sessions_from_new_visitors_count}
  
  - measure: new_visitor_percentage
    label: New Visit %
    type: number
    decimals: 2
    sql: ${sessions_from_new_visitors_count}/NULLIF(${count},0)::REAL
    value_format: '#0.00%'

  - measure: returning_visitor_percentage
    label: Returning Visit %
    type: number
    decimals: 2
    sql: 100.0 * ${sessions_from_returning_visitor_count}/NULLIF(${count},0)::REAL
    value_format: '#0.00%'

  - measure: visitors_count
    label: Total Visitors
    type: count_distinct
    sql: ${blended_user_id}
    
  - measure: events_count
    label: Total Events
    type: sum
    sql: ${TABLE}.number_of_events
    
  - measure: events_per_session
    label: Events Per Visit
    type: number
    decimals: 2
    sql: ${events_count}/NULLIF(${count},0)::REAL
    
  - measure: events_per_visitor
    label: Events Per Visitor
    type: number
    decimals: 2
    sql: ${events_count}/NULLIF(${visitors_count},0)::REAL

  - measure: page_views_per_visit
    label: Page Views Per Visit
    type: number
    decimals: 2
    sql: ${sum_page_views}/NULLIF(${count},0)::REAL
    
  - measure: sum_accounts_created
    label: Accounts Created Total
    type: sum
    sql: ${accounts_created}

  - measure: sum_newsletter_signups
    label: Newsletter Signups Total
    type: sum
    sql: ${newsletter_signups}

  - measure: sum_products_added_to_cart
    label: Products Added to Cart Total
    type: sum
    sql: ${products_added_to_cart}

  - measure: sum_product_removed_from_cart
    label: Products Removed from Cart Total
    type: sum
    sql: ${product_removed_from_cart}

  - measure: sum_cart_events
    label: Cart Views Total
    type: sum
    sql: ${cart_events}

  - measure: sum_page_views
    label: Page Views Total
    type: sum
    sql: ${distinct_pages_viewed}

  - measure: sum_referrals_sent
    label: Referrals Sent
    type: sum
    sql: ${referrals_sent}

  - measure: sum_product_impressions
    label: Product Impressions Total
    type: sum
    sql: ${product_impressions}
    
  - measure: sum_product_clicks
    label: Product Clicks Total
    type: sum
    sql: ${product_clicks}
    
  - measure: sum_product_views
    label: Product Views Total
    type: sum
    sql: ${product_views}

# Payment Funnel Measures

  - meausre: 1_payment_funnel_all_sessions
    label: Payment Funnel 1 (All Sessions)
    type: number
    decimals: 2
    sql: ${count}/NULLIF(${count},0)::REAL
    value_format: '#0.00%'

  - measure: 2_payment_funnel_category_page
    label: Payment Funnel 2 (Category Page)
    type: number
    decimals: 2
    sql: ${count}/NULLIF(${count},0)::REAL
    value_format: '#0.00%'
    
  - measure: 3_payment_funnel_product_page
    label: Payment Funnel 3 (Product Page)
    type: number
    decimals: 2
    sql: ${count}/NULLIF(${count},0)::REAL
    value_format: '#0.00%'
    
  - measure: 4_payment_funnel_add_to_cart
    label: Payment Funnel 4 (Cart)
    type: number
    decimals: 2
    sql: ${count}/NULLIF(${count},0)::REAL
    value_format: '#0.00%'
    
  - measure: 5_payment_funnel_checkout_address
    label: Payment Funnel 5 (Checkout - Enter Address)
    type: number
    decimals: 2
    sql: ${count}/NULLIF(${count},0)::REAL
    value_format: '#0.00%'
    
  - measure: 6_payment_funnel_checkout_delivery
    label: Payment Funnel 6 (Checkout - Delivery Method)
    type: number
    decimals: 2
    sql: ${count}/NULLIF(${count},0)::REAL
    value_format: '#0.00%'
    
  - measure: 7_payment_funnel_checkout_payment
    label: Payment Funnel 7 (Checkout - Payment)
    type: number
    decimals: 2
    sql: ${count}/NULLIF(${count},0)::REAL
    value_format: '#0.00%'
    
  - measure: 8_payment_funnel_order
    label: Payment Funnel 8 (Placed Order)
    type: number
    decimals: 2
    sql: ${transactions.count_transactions}/NULLIF(${count},0)::REAL
    value_format: '#0.00%'