- view: sessions
  sql_table_name: web.sessions
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

  - dimension: engagement_goal_1
    label: Engagement Goal 1 (>6 Pages)
    type: yesno
    sql: ${distinct_pages_viewed} > 6

  - dimension: engagement_goal_2
    label: Engagement Goal 2 (Create Account)
    type: yesno
    sql: ${accounts_created} > 0
          
  - dimension: engagement_goal_3
    label: Engagement Goal 3 (NL Signup)
    type: yesno
    sql: ${newsletter_signups} > 0


  - dimension: engagement_goal_4
    label: Engagement Goal 4 (>4 mins)
    type: yesno
    sql: ${session_duration_seconds} > 239

  - dimension: engagement_goal_5
    label: Engagement Goal 5 (Add to Cart)
    type: yesno
    sql: |
          ${cart_events} > 0
          or ${checkout_progress} > 0
          or ${transactions.order_id} is not null
 
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

  - dimension: geography_country
    label: Geo - Country
    sql_case:
      UK: ${geography_country_two_letter_iso_code} = 'GB'
      USA: ${geography_country_two_letter_iso_code} = 'US'
      Australia: ${geography_country_two_letter_iso_code} = 'AU'
      Hong Kong: ${geography_country_two_letter_iso_code} = 'HK'
      Ireland: ${geography_country_two_letter_iso_code} = 'IE'
      Singapore: ${geography_country_two_letter_iso_code} = 'SG'
      UAE: ${geography_country_two_letter_iso_code} = 'AE'
      Canada: ${geography_country_two_letter_iso_code} = 'CA'
      else: Other

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

  - dimension: landing_page_type
    sql: |
         case
          when ${landing_page_path} in ('/', '//', '/uk', '/uk/', '/us', '/us/', '/ie', '/ie/', '/ca', '/ca/', '/hk', '/hk/', '/ae', '/ae/','/sg', '/sg/','/au', '/au/') or ${landing_page_path} is null then 'Homepage'
          when ${landing_page_path} like '%/products/%' then 'Product Page'
          when ${landing_page_path} like '%/t/%' then 'Category Page'
          else 'Other' end
    
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

################################ MARKETING #################################################################################################

  - dimension: acquisition_channel
    label: Acquisition Channel
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

  - dimension: browser_width
    sql: ${TABLE}.br_viewwidth

  - dimension: browser_height
    sql: ${TABLE}.br_viewheight

  - dimension: homepage_view_flag
    sql: ${TABLE}.homepage_view_flag
    hidden: true
  - dimension: category_page_view_flag
    sql: ${TABLE}.category_page_view_flag
    hidden: true
  - dimension: products_page_view_flag
    sql: ${TABLE}.products_page_view_flag
    hidden: true
  - dimension: chapters_page_flag
    sql: ${TABLE}.chapters_page_flag
    hidden: true
  - dimension: editorial_page_flag
    sql: ${TABLE}.editorial_page_flag
    hidden: true
  - dimension: cart_page_view_flag
    sql: ${TABLE}.cart_page_view_flag
    hidden: true
  - dimension: checkout_reg_page_view_flag
    sql: ${TABLE}.checkout_reg_page_view_flag
    hidden: true
  - dimension: checkout_ad_page_view_flag
    sql: ${TABLE}.checkout_ad_page_view_flag
    hidden: true
  - dimension: checkout_del_page_flag
    sql: ${TABLE}.checkout_del_page_flag
    hidden: true
  - dimension: checkout_payment_page_view_flag
    sql: ${TABLE}.checkout_payment_page_view_flag
    hidden: true
  - dimension: checkout_order_page_view_flag
    sql: ${TABLE}.checkout_order_page_view_flag
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
    value_format: '#0.00'
    
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
    sql: ${sessions_from_returning_visitor_count}/NULLIF(${count},0)::REAL
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

  - measure: nl_signup_rate
    label: Newsletter Signup Rate
    type: number
    decimals: 2
    sql: ${sum_newsletter_signups}/NULLIF(${count},0)::REAL
    value_format: '#0.00%'
    
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
    
#################################################################################################################
########################################### Conversion Funnel Measures ##########################################
#################################################################################################################


  - measure: conversion_funnel_2
    label: Conversion Funnel 2 - Category Page Visits
    type: number
    sql: |
          COUNT(DISTINCT
          CASE
          WHEN (${category_page_view_flag} = 1
                OR ${products_page_view_flag} = 1
                OR ${cart_page_view_flag} = 1
                OR ${checkout_reg_page_view_flag} = 1
                OR ${cart_events} > 0
                OR ${products_added_to_cart} > 0
                OR ${transactions.order_id} is not null
                OR ${checkout_progress} > 0)
          THEN ${session_id}
          ELSE NULL
          END)
    
  - measure: conversion_funnel_3
    label: Conversion Funnel 3 - Product Page Visits
    type: number
    sql: |
          COUNT(DISTINCT
          CASE
          WHEN (${products_page_view_flag} = 1
                OR ${cart_page_view_flag} = 1
                OR ${checkout_reg_page_view_flag} = 1
                OR ${cart_events} > 0
                OR ${products_added_to_cart} > 0
                OR ${transactions.order_id} is not null
                OR ${checkout_progress} > 0)
          THEN ${session_id}
          ELSE NULL
          END)
    
  - measure: conversion_funnel_4
    label: Conversion Funnel 4 - Add to Cart Visits
    type: number
    sql: |
          COUNT(DISTINCT
          CASE
          WHEN (${cart_page_view_flag} = 1
                OR ${checkout_reg_page_view_flag} = 1
                OR ${cart_events} > 0
                OR ${products_added_to_cart} > 0
                OR ${transactions.order_id} is not null
                OR ${checkout_progress} > 0)
          THEN ${session_id}
          ELSE NULL
          END)
    
  - measure: conversion_funnel_5
    type: number
    label: Conversion Funnel 5 - View Cart Visits
    sql: |
          COUNT(DISTINCT
          CASE
          WHEN (${cart_page_view_flag} = 1
                OR ${checkout_reg_page_view_flag} = 1
                OR ${transactions.order_id} is not null
                OR ${checkout_progress} > 0)
          THEN ${session_id}
          ELSE NULL
          END)   
    
  - measure: conversion_funnel_6
    label: Conversion Funnel 6 - Checkout - Registration Visits
    type: number
    sql: |
          COUNT(DISTINCT
          CASE
          WHEN (${checkout_reg_page_view_flag} = 1
                OR ${transactions.order_id} is not null
                OR ${checkout_progress} > 0)
          THEN ${session_id}
          ELSE NULL
          END)
    
  - measure: conversion_funnel_7
    label: Conversion Funnel 7 - Checkout - Enter Address Visits
    type: number
    sql: |
          COUNT(DISTINCT
          CASE
          WHEN (${transactions.order_id} is not null
                OR ${checkout_progress} > 0)
          THEN ${session_id}
          ELSE NULL
          END)
    
  - measure: conversion_funnel_8
    label: Conversion Funnel 8 - Checkout - Delivery Method Visits
    type: number
    sql: |
          COUNT(DISTINCT
          CASE
          WHEN (${transactions.order_id} is not null
                OR ${checkout_progress} > 1)
          THEN ${session_id}
          ELSE NULL
          END)
  
  - measure: conversion_funnel_9
    label: Conversion Funnel 9 - Checkout - Payment Visits
    type: number
    sql: |
          COUNT(DISTINCT
          CASE
          WHEN (${transactions.order_id} is not null
                OR ${checkout_progress} > 2)
          THEN ${session_id}
          ELSE NULL
          END)
    
  - measure: conversion_funnel_10
    label: Conversion Funnel 10 - Order Completed Visits
    type: number
    sql: |
          COUNT(DISTINCT
          CASE
          WHEN (${transactions.order_id} is not null)
          THEN ${session_id}
          ELSE NULL
          END)
    
  - measure: 1_conversion_funnel_all_sessions
    label: Conversion Funnel 1 (All Sessions)
    type: number
    decimals: 4
    sql: ${count}/NULLIF(${count},0)::REAL
    value_format: '#0.00%'

  - measure: 2_conversion_funnel_category_page
    label: Conversion Funnel 2 (Category Page)
    type: number
    decimals: 4
    sql: ${conversion_funnel_2}/NULLIF(${count},0)::REAL
    value_format: '#0.00%'
    
  - measure: 3_conversion_funnel_product_page
    label: Conversion Funnel 3 (Product Page)
    type: number
    decimals: 4
    sql: ${conversion_funnel_3}/NULLIF(${count},0)::REAL
    value_format: '#0.00%'
    
  - measure: 4_conversion_funnel_add_to_cart
    label: Conversion Funnel 4 (Add to Cart)
    type: number
    decimals: 4
    sql: ${conversion_funnel_4}/NULLIF(${count},0)::REAL
    value_format: '#0.00%'
    
  - measure: 5_conversion_funnel_view_cart
    label: Conversion Funnel 5 (View Cart)
    type: number
    decimals: 4
    sql: ${conversion_funnel_5}/NULLIF(${count},0)::REAL
    value_format: '#0.00%'

  - measure: 6_conversion_funnel_checkout_registration
    label: Conversion Funnel 6 (Checkout - Registration)
    type: number
    decimals: 4
    sql: ${conversion_funnel_6}/NULLIF(${count},0)::REAL
    value_format: '#0.00%'
    
  - measure: 7_conversion_funnel_checkout_address
    label: Conversion Funnel 7 (Checkout - Enter Address)
    type: number
    decimals: 4
    sql: ${conversion_funnel_7}/NULLIF(${count},0)::REAL
    value_format: '#0.00%'
    
  - measure: 8_conversion_funnel_checkout_delivery
    label: Conversion Funnel 8 (Checkout - Delivery Method)
    type: number
    decimals: 4
    sql: ${conversion_funnel_8}/NULLIF(${count},0)::REAL
    value_format: '#0.00%'
    
  - measure: 9_conversion_funnel_checkout_payment
    label: Conversion Funnel 9 (Checkout - Payment)
    type: number
    decimals: 4
    sql: ${conversion_funnel_9}/NULLIF(${count},0)::REAL
    value_format: '#0.00%'
    
  - measure: 10_conversion_funnel_order
    label: Conversion Funnel 10 (Placed Order)
    type: number
    decimals: 4
    sql: ${conversion_funnel_10}/NULLIF(${count},0)::REAL
    value_format: '#0.00%'

