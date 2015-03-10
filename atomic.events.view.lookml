- view: atomic_events
  sql_table_name: atomic.events
    
  fields:
    ###################################################################################################################################################################
  ########################################################################## DIMENSIONS #############################################################################
###################################################################################################################################################################

  - dimension: event_id
    primary_key: true
    sql: ${TABLE}.event_id
    hidden: true

  - dimension: app_id
    sql: ${TABLE}.app_id
    hidden: true

  - dimension: structured_event
    sql: ${TABLE}.se_action
    hidden: true
  
  - dimension: structured_event_category
    sql: ${TABLE}.se_category
    hidden: true
  
  - dimension: structured_event_label
    sql: ${TABLE}.se_label
    hidden: true

  - dimension: structured_event_property
    sql: ${TABLE}.se_property
    hidden: true
    
  - dimension_group: event_time
    label: EVENT
    type: time
    timeframes: [time, hour, date, hour_of_day, day_of_week_index, week, month]
    sql: ${TABLE}.collector_tstamp

  - dimension: wow_date_filter
    type: yesno
    sql: ${event_time_date} = current_date - 7 OR ${event_time_date} = current_date

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
  
  - dimension: new_session_flag
    label: NEW SESSION FLAG
    type: yesno
    sql: ${domain_sessionidx} = 1
    
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
      app_id: production

  - measure: count_new_users
    label: NEW USERS
    type: count_distinct
    sql: ${blended_user_id}
    filters:
      domain_userid: -EMPTY
      domain_sessionidx: 1
      app_id: production
  
  - measure: count_sessions
    label: SESSIONS
    type: count_distinct
    sql: ${session_id}
    filters:
      domain_userid: -EMPTY
      domain_sessionidx: -EMPTY
      app_id: production

  - measure: count_new_sessions
    label: NEW SESSIONS
    type: count_distinct
    sql: ${session_id}
    filters:
      domain_userid: -EMPTY
      domain_sessionidx: 1
      app_id: production

  - measure: count_session_logged_in
    label: LOGGED IN SESSIONS
    type: count_distinct
    sql: ${session_id}
    filters:
      user_id: -NULL
      domain_userid: -EMPTY
      domain_sessionidx: -EMPTY
      app_id: production

  - measure: count_users_logged_in
    label: USERS LOGGED IN
    type: count_distinct
    sql: ${user_id}
    filters:
      app_id: production
    
  - measure: new_user_percentage
    label: NEW USER %
    type: number
    decimals: 2
    sql: 100.0 * ${count_new_users}/NULLIF(${count_users},0)::REAL
    format: "%0.1f%"

  - measure: new_session_percentage
    label: NEW SESSION %
    type: number
    decimals: 2
    sql: 100.0 * ${count_new_sessions}/NULLIF(${count_sessions},0)::REAL
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
      app_id: production
  
  - measure: distinct_quick_views
    type: count_distinct
    sql: ${product_funnel.product_user_id}
    filters:
      product_funnel.event_type: Product Quick View
      app_id: production
  
  - measure: distinct_product_page_views
    type: count_distinct
    sql: ${product_funnel.product_user_id}
    filters:
      product_funnel.event_type: Product Page View
      app_id: production

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
    filters:
      app_id: production
  
  - measure: conversion_rate
    type: number
    decimals: 2
    sql: 100.0 * ${transactions.count_transactions}/NULLIF(${count_sessions},0)::REAL
    format: "%0.2f%"

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
  
  - measure: count_total_opens
    label: TOTAL EMAIL OPENS
    type: count_distinct
    sql: ${event_id}
    filters:
      structured_event: open
      structured_event_category: email
      app_id: production
      
  
  - measure: count_unique_opens
    label: UNIQUE EMAIL OPENS
    type: count_distinct
    sql: ${structured_event_label} || '-' || ${structured_event_property}
    filters:
      structured_event: open
      structured_event_category: email
      app_id: production
  
## Customer Service/Contact Form Events

  - measure: count_customer_service_events
    label: CUSTOMER SERVICE LINK CLICKED
    type: count_distinct
    sql: ${event_id}
    filters:
      structured_event: customerService
      app_id: production

  - measure: count_contact_form_events
    label: CONTACT FORM SUBMITTED
    type: count_distinct
    sql: ${event_id}
    filters:
      structured_event: contactForm
      app_id: production


#############################################################################################################################################################################################################################################################      
#############################################################################################################################################################################################################################################################  
################################################################################################################## WEEK ON WEEK MEASURES #################################################################################################################### 
############################################################################################################################################################################################################################################################# 
#############################################################################################################################################################################################################################################################

# Hidden Measures

  - measure: count_sessions_yesterday
    type: count_distinct
    sql: ${session_id}
    filters:
      domain_userid: -EMPTY
      domain_sessionidx: -EMPTY
      event_time_date: 1 day ago for 1 day
      app_id: production
    hidden: true
      
  - measure: count_sessions_last_week
    type: count_distinct
    sql: ${session_id}
    filters:
      domain_userid: -EMPTY
      domain_sessionidx: -EMPTY
      event_time_date: 8 days ago for 1 day
      app_id: production
    hidden: true

  - measure: conversion_rate_yesterday
    type: number
    decimals: 2
    sql: 100.0 * ${transactions.count_transactions_yesterday}/NULLIF(${count_sessions_yesterday},0)::REAL
    format: "%0.2f%"
    hidden: true
    
  - measure: conversion_rate_last_week
    type: number
    decimals: 2
    sql: 100.0 * ${transactions.count_transactions_last_week}/NULLIF(${count_sessions_last_week},0)::REAL
    format: "%0.2f%"
    hidden: true
  
  - measure: count_new_sessions_yesterday
    type: count_distinct
    sql: ${session_id}
    filters:
      domain_userid: -EMPTY
      domain_sessionidx: 1
      app_id: production
      event_time_date: 1 day ago for 1 day
    hidden: true
      
  - measure: count_new_sessions_last_week
    type: count_distinct
    sql: ${session_id}
    filters:
      domain_userid: -EMPTY
      domain_sessionidx: 1
      app_id: production
      event_time_date:  8 days ago for 1 day
    hidden: true

  - measure: new_session_perc_yesterday
    type: number
    decimals: 2
    sql: 100.0 * ${count_new_sessions_yesterday}/NULLIF(${count_sessions_yesterday},0)::REAL
    format: "%0.2f%"
    hidden: true
    
  - measure: new_session_perc_last_week
    type: number
    decimals: 2
    sql: 100.0 * ${count_new_sessions_last_week}/NULLIF(${count_sessions_last_week},0)::REAL
    format: "%0.2f%"
    hidden: true

# Visible Measures
  
  - measure: sessions_wow
    label: SESSIONS WEEK ON WEEK
    type: number
    decimals: 2
    sql: 100.0 * (${count_sessions_yesterday} - ${count_sessions_last_week})/NULLIF(${count_sessions_last_week},0)::REAL
    format: "%0.2f%"
    html: |
        {% if value < 0 - Red' %}
        <font color="#D77070"> {{ rendered_value }} </font>
        {% elsif value > 0 - Green' %}
        <font color="#A2D68F> {{ rendered_value }} </font>
        {% else %}
        <font color="#000000> {{ rendered_value }} </font>
        {% endif %}

  - measure: orders_wow
    label: SESSIONS WEEK ON WEEK
    type: number
    decimals: 2
    sql: 100.0 * (${transactions.count_transactions_yesterday} - ${transactions.count_transactions_last_week})/NULLIF(${transactions.count_transactions_last_week},0)::REAL
    format: "%0.2f%"
    html: |
        {% if value < 0 - Red' %}
        <font color="#D77070"> {{ rendered_value }} </font>
        {% elsif value > 0 - Green' %}
        <font color="#A2D68F> {{ rendered_value }} </font>
        {% else %}
        <font color="#000000> {{ rendered_value }} </font>
        {% endif %}

  - measure: conversion_rate_wow
    label: CONVERSION RATE WEEK ON WEEK
    type: number
    decimals: 2
    sql: 100.0 * (${conversion_rate_yesterday} - ${conversion_rate_last_week})/NULLIF(${conversion_rate_last_week},0)::REAL
    format: "%0.2f%"
    html: |
        {% if value < 0 - Red' %}
        <font color="#D77070"> {{ rendered_value }} </font>
        {% elsif value > 0 - Green' %}
        <font color="#A2D68F> {{ rendered_value }} </font>
        {% else %}
        <font color="#000000> {{ rendered_value }} </font>
        {% endif %}

  - measure: new_session_perc_wow
    label: NEW SESSIONS WEEK ON WEEK
    type: number
    decimals: 2
    sql: 100.0 * (${new_session_perc_yesterday} - ${new_session_perc_last_week})/NULLIF(${new_session_perc_last_week},0)::REAL
    format: "%0.2f%"
    html: |
        {% if value < 0 - Red' %}
        <font color="#D77070"> {{ rendered_value }} </font>
        {% elsif value > 0 - Green' %}
        <font color="#A2D68F> {{ rendered_value }} </font>
        {% else %}
        <font color="#000000> {{ rendered_value }} </font>
        {% endif %}

