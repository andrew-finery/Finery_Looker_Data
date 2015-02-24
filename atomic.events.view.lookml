- view: atomic_events
  derived_table:
    sql: |
      SELECT
          a.app_id,
          a.platform,
          a.etl_tstamp,
          a.collector_tstamp,
          a.dvce_tstamp,
          a.event,
          a.event_id,
          a.txn_id,
          a.name_tracker,
          a.v_tracker,
          a.v_collector,
          a.v_etl,
          a.user_id,
          a.user_ipaddress,
          a.user_fingerprint,
          a.domain_userid,
          a.domain_sessionidx,
          a.network_userid,
          a.geo_country,
          a.geo_region,
          a.geo_city,
          a.geo_zipcode,
          a.geo_latitude,
          a.geo_longitude,
          a.geo_region_name,
          a.ip_isp,
          a.ip_organization,
          a.ip_domain,
          a.ip_netspeed,
          a.page_url,
          a.page_title,
          a.page_referrer,
          a.page_urlscheme,
          a.page_urlhost,
          a.page_urlport,
          a.page_urlpath,
          a.page_urlquery,
          a.page_urlfragment,
          a.refr_urlscheme,
          a.refr_urlhost,
          a.refr_urlport,
          a.refr_urlpath,
          a.refr_urlquery,
          a.refr_urlfragment,
          a.refr_medium,
          a.refr_source,
          a.refr_term,
          a.mkt_medium,
          a.mkt_source,
          a.mkt_term,
          a.mkt_content,
          a.mkt_campaign,
          a.contexts,
          a.se_category,
          a.se_action,
          a.se_label,
          a.se_property,
          a.se_value,
          a.unstruct_event,
          a.tr_orderid,
          a.tr_affiliation,
          a.tr_total,
          a.tr_tax,
          a.tr_shipping,
          a.tr_city,
          a.tr_state,
          a.tr_country,
          a.ti_orderid,
          a.ti_sku,
          a.ti_name,
          a.ti_category,
          a.ti_price,
          a.ti_quantity,
          a.pp_xoffset_min,
          a.pp_xoffset_max,
          a.pp_yoffset_min,
          a.pp_yoffset_max,
          a.useragent,
          a.br_name,
          a.br_family,
          a.br_version,
          a.br_type,
          a.br_renderengine,
          a.br_lang,
          a.br_features_pdf,
          a.br_features_flash,
          a.br_features_java,
          a.br_features_director,
          a.br_features_quicktime,
          a.br_features_realplayer,
          a.br_features_windowsmedia,
          a.br_features_gears,
          a.br_features_silverlight,
          a.br_cookies,
          a.br_colordepth,
          a.br_viewwidth,
          a.br_viewheight,
          a.os_name,
          a.os_family,
          a.os_manufacturer,
          a.os_timezone,
          a.dvce_type,
          a.dvce_ismobile,
          a.dvce_screenwidth,
          a.dvce_screenheight,
          a.doc_charset,
          a.doc_width,
          a.doc_height
          
          from atomic.events a

          WHERE a.app_id = 'production'
          
    sql_trigger_value: SELECT MAX(collector_tstamp) FROM atomic.events
    distkey: event_id
    sortkeys: [domain_userid, domain_sessionidx, collector_tstamp]
    
  fields:
    ###################################################################################################################################################################
  ########################################################################## DIMENSIONS #############################################################################
###################################################################################################################################################################
  
  - dimension: event_id
    primary_key: true
    sql: ${TABLE}.event_id
    hidden: true

  - dimension: structured_event
    sql: ${TABLE}.se_action
    hidden: true
    
  - dimension_group: event_time
    label: EVENT
    type: time
    timeframes: [time, hour, date, hour_of_day, day_of_week_index, week, month]
    sql: ${TABLE}.collector_tstamp

  ########### User and Session Dimensions
    
  - dimension: user_id
    sql: ${TABLE}.user_id
    hidden: true
    
  - dimension: blended_user_id
    sql: ${identity_stitching.blended_user_id}
    hidden: true
    
  - dimension: domain_sessionidx
    sql: ${TABLE}.domain_sessionidx
    hidden: true
    
  - dimension: session_id
    sql: ${TABLE}.domain_userid || '-' || ${TABLE}.domain_sessionidx
    hidden: true
    
  - dimension: domain_userid
    sql: ${TABLE}.domain_userid
    hidden: true
  
###################################################################################################################################################################
  ########################################################################## MEASURES ###############################################################################
    ###################################################################################################################################################################

################### Users and Sessions Counts

  - measure: count_users
    label: USERS
    type: count_distinct
    sql: ${blended_user_id}
    filters:
      domain_userid: -EMPTY
      domain_sessionidx: -EMPTY

  - measure: count_new_users
    label: NEW USERS
    type: count_distinct
    sql: ${blended_user_id}
    filters:
      domain_userid: -EMPTY
      domain_sessionidx: 1
  
  - measure: count_sessions
    label: SESSIONS
    type: count_distinct
    sql: ${session_id}
    filters:
      domain_userid: -EMPTY
      domain_sessionidx: -EMPTY

  - measure: count_new_sessions
    label: NEW SESSIONS
    type: count_distinct
    sql: ${session_id}
    filters:
      domain_userid: -EMPTY
      domain_sessionidx: 1

  - measure: count_session_logged_in
    label: LOGGED IN SESSIONS
    type: count_distinct
    sql: ${session_id}
    filters:
      user_id: -NULL
      domain_userid: -EMPTY
      domain_sessionidx: -EMPTY

  - measure: count_users_logged_in
    label: USERS LOGGED IN
    type: count_distinct
    sql: ${user_id}
    
  - measure: new_user_percentage
    label: NEW USER %
    type: number
    decimals: 2
    sql: 100.0 * ${count_new_users}/NULLIF(${count_users},0)::REAL
    format: "%0.1f%"
  
  - measure: user_logged_in_percentage
    label: LOGGED IN %
    type: number
    decimals: 2
    sql: 100.0 * ${count_users_logged_in}/NULLIF(${count_users},0)::REAL
    format: "%0.1f%"

  - measure: count_days
    type: count_distinct
    sql: date(${TABLE}.collector_tstamp)
    hidden: true
    
  - measure: orders_per_day
    type: number
    sql: ${transactions.count_transactions} / ${count_days}

  - measure: latest_update
    label: LATEST UPDATE
    type: string
    sql: |
        case
        when max(date(${TABLE}.collector_tstamp)) < current_date
        then
        'Yesterday @ ' || cast(((extract(epoch from max(${TABLE}.collector_tstamp))) - (extract(epoch from max(date(${TABLE}.collector_tstamp)))))/3600 as decimal(8,0)) || ':00'
        else
        'Today @ ' || cast(((extract(epoch from max(${TABLE}.collector_tstamp))) - (extract(epoch from max(date(${TABLE}.collector_tstamp)))))/3600 as decimal(8,0)) || ':00'
        end
            
########################################################################### Product Payment Funnel Measures #################################################################

  - measure: distinct_product_impressions
    type: count_distinct
    sql: ${product_funnel.product_user_id}
    filters:
      product_funnel.event_type: Product Impression, Product Quick View, Product Page View, Product Added to Cart, Product Purchased
  
  - measure: distinct_quick_views
    type: count_distinct
    sql: ${product_funnel.product_user_id}
    filters:
      product_funnel.event_type: Product Quick View
  
  - measure: distinct_product_page_views
    type: count_distinct
    sql: ${product_funnel.product_user_id}
    filters:
      product_funnel.event_type: Product Page View

  - measure: avg_product_impressions_per_user
    type: number
    decimals: 2
    sql: ${distinct_product_impressions}/NULLIF(${count_users},0)::REAL
    format: "%0.2f"
  
  - measure: avg_product_quick_views_per_user
    type: number
    decimals: 2
    sql: ${distinct_quick_views}/NULLIF(${count_users},0)::REAL
    format: "%0.2f"
  
  - measure: avg_product_page_views_per_user
    type: number
    decimals: 2
    sql: ${distinct_product_page_views}/NULLIF(${count_users},0)::REAL
    format: "%0.2f"
  
  - measure: count_users_with_product_view
    type: count_distinct
    sql: ${blended_user_id}
    filters:
      product_funnel.event_type: Product Page View
  
  - measure: percentage_of_users_who_viewed_product
    type: number
    decimals: 2
    sql: 100.0 * ${count_users_with_product_view}/NULLIF(${count_users},0)::REAL
    format: "%0.2f%"
  
############################################################################# TRANSACTION MEASURES ###############################################################################
  
  - measure: sum_revenue_ex_coupon_and_vat
    type: sum
    sql: ${transactions.revenue_ex_coupon_and_vat}
  
  - measure: conversion_rate
    type: number
    decimals: 1
    sql: 100.0 * ${transactions.count_transactions}/NULLIF(${count_users},0)::REAL
    format: "%0.1f%"

############################################################################## EMAIL MEASURES ####################################################################################
    
  - measure: newsletter_signup_rate
    type: number
    decimals: 1
    sql: 100.0 * ${email_subscriptions.count_newsletter_subscribers}/NULLIF(${count_new_users},0)::REAL
    format: "%0.1f%"
    
  - measure: referral_rate
    type: number
    decimals: 1
    sql: 100.0 * ${email_subscriptions.count_referrals}/NULLIF(${count_users_logged_in},0)::REAL
    format: "%0.1f%"

## Customer Service/Contact Form Events

  - measure: count_customer_service_events
    label: CUSTOMER SERVICE LINK CLICKED
    type: count_distinct
    sql: ${event_id}
    filters:
      structured_event: customerService

  - measure: count_contact_form_events
    label: CONTACT FORM SUBMITTED
    type: count_distinct
    sql: ${event_id}
    filters:
      structured_event: contactForm