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
  
  - dimension: event
    sql: ${TABLE}.event
    hidden: true
  
  - dimension: unstruct_event
    label: UNSTRICTURED EVENT
    sql: ${TABLE}.unstruct_event
  
  - dimension: event_type
    label: EVENT TYPE
    sql: |
        case
        when ${TABLE}.event = 'struct' then 'Structured Event'
        when ${TABLE}.event = 'page_ping' then 'Website - Page Ping'
        when ${TABLE}.event = 'page_view' then 'Website - Page View'
        when ${TABLE}.unstruct_event like '%iglu:com.snowplowanalytics.snowplow/link_click/%' then 'Website - Link Click'
        when ${TABLE}.unstruct_event like '%iglu:com.snowplowanalytics.snowplow/submit_form/%' then 'Website - Form Submitted'
        when ${TABLE}.unstruct_event like '%iglu:com.finerylondon/registration_failure/%' then 'Website - Registration Failure'
        when ${TABLE}.unstruct_event like '%iglu:com.finerylondon/login_failure/%' then 'Website - Login Failure'
        when ${TABLE}.unstruct_event like '%iglu:com.finerylondon/share_product/%' then 'Website - Share Product'
        when ${TABLE}.unstruct_event like '%iglu:com.mailchimp/campaign_sending_status/%' then 'Mailchimp - Campaign Sending Status'
        when ${TABLE}.unstruct_event like '%iglu:com.finerylondon/update_cart/%' then 'Website - Update Cart'
        when ${TABLE}.unstruct_event like '%iglu:com.finerylondon/cart/%' then 'Website - Update Cart'
        when ${TABLE}.unstruct_event like '%iglu:com.mailchimp/unsubscribe/%' then 'Mailchimp - Unsubscribe'
        when ${TABLE}.unstruct_event like '%iglu:com.finerylondon/stock_updated/%' then 'Spree - Stock Updated'
        when ${TABLE}.unstruct_event like '%iglu:com.finerylondon/shipment_shipped/%' then 'Spree - Shipment Shipped'
        when ${TABLE}.unstruct_event like '%iglu:com.mailchimp/cleaned_email/%' then 'Mailchimp - Cleaned Email'
        when ${TABLE}.unstruct_event like '%iglu:com.finerylondon/order_updated/%' then 'Spree - Order Updated'
        when ${TABLE}.unstruct_event like '%iglu:com.finerylondon/return_item_updated/%' then 'Spree - Return Item Updated'
        when ${TABLE}.unstruct_event like '%iglu:com.finerylondon/user_updated/%' then 'Spree - User Updated'
        when ${TABLE}.unstruct_event like '%iglu:com.mandrill/message_opened/%' then 'Mandrill - Message Opened'
        when ${TABLE}.unstruct_event like '%iglu:com.mandrill/message_sent/%' then 'Mandrill - Message Sent'
        when ${TABLE}.unstruct_event like '%iglu:com.mandrill/message_clicked/%' then 'Mandrill - Message Clicked'
        when ${TABLE}.unstruct_event like '%iglu:com.mandrill/message_marked_as_spam/%' then 'Mandrill - Message Marked as Spam'
        when ${TABLE}.unstruct_event like '%iglu:com.finerylondon/newsletter_subscription/%' then 'Website - Newsletter Subscription'
        when ${TABLE}.unstruct_event like '%iglu:com.snowplowanalytics.snowplow/change_form/%' then 'Website - Change Form'
        when ${TABLE}.unstruct_event like '%iglu:com.finerylondon/registration_success/%' then 'Website - Registration Success'
        when ${TABLE}.unstruct_event like '%iglu:com.finerylondon/login_success/%' then 'Website - Login Success'
        when ${TABLE}.unstruct_event like '%iglu:com.mailchimp/subscribe/%' then 'Mailchimp - Subscribe'
        when ${TABLE}.unstruct_event like '%iglu:com.finerylondon/checkout/%' then 'Website - Checkout'
        when ${TABLE}.unstruct_event like '%iglu:com.mailchimp/profile_update/%' then 'Mailchimp - Profile Update'
        when ${TABLE}.unstruct_event like '%iglu:com.finerylondon/payment_started/%' then 'Spree - Payment Started'
        when ${TABLE}.unstruct_event like '%iglu:com.finerylondon/transaction/%' then 'Website - Transaction'
        when ${TABLE}.unstruct_event like '%iglu:com.finerylondon/payment_completed/%' then 'Spree - Payment Completed'
        when ${TABLE}.unstruct_event like '%iglu:com.finerylondon/user_created/%' then 'Spree - User Created'
        when ${TABLE}.unstruct_event like '%iglu:com.finerylondon/lead_created/%' then 'Spree - Lead Created'
        when ${TABLE}.unstruct_event like '%iglu:com.mandrill/message_delayed/%' then 'Mandrill - Message Delayed'
        when ${TABLE}.unstruct_event like '%iglu:com.mandrill/message_rejected/%' then 'Mandrill - Message Rejected'
        when ${TABLE}.unstruct_event like '%iglu:com.mandrill/message_bounced/%' then 'Mandrill - Message Bounced'
        when ${TABLE}.unstruct_event like '%iglu:com.finerylondon/product_clicked/%' then 'Website - Product Clicked'
        when ${TABLE}.unstruct_event like '%iglu:com.finerylondon/product_impression/%' then 'Website - Product Impression'
        when ${TABLE}.unstruct_event like '%iglu:com.finerylondon/product_quick_view/%' then 'Website - Product Quick View'
        else 'Other Unstructured Event' end
        
  
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
    timeframes: [time, hour, date, hour_of_day, day_of_week_index, day_of_week, week, month]
    sql: ${TABLE}.collector_tstamp

  - dimension: wow_date_filter
    type: yesno
    sql: ${event_time_date} = current_date - 7 OR ${event_time_date} = current_date
  
  - dimension: today_tw_lw_flag
    sql: case when ${event_time_date} = current_date then 'Today' when ${event_time_date} = current_date - 7 then 'Last Week' else null end

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
  - measure: count_events
    label: COUNT EVENTS
    type: count_distinct
    sql: ${event_id}

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

  - measure: count_bounced_sessions
    type: count_distinct
    sql: ${session_id}
    filters:
      domain_userid: -EMPTY
      app_id: production
      sessions.bounce: yes
    hidden: true

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

  - measure: bounce_rate
    label: BOUNCE RATE
    type: number
    decimals: 2
    sql: 100.0 * ${count_bounced_sessions}/NULLIF(${count_sessions},0)::REAL
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

  - measure: count_page_views
    label: PAGE VIEWS
    type: count_distinct
    sql: ${event_id}
    filters:
      event: page_view
      app_id: production

  - measure: page_views_per_session
    label: PAGE VIEWS PER SESSION
    type: number
    decimals: 2
    sql: ${count_page_views}/NULLIF(${count_sessions},0)::REAL
    format: "%0.2f"
  
  - measure: total_usage_time_10s
    type: count_distinct
    decimals: 2
    sql: CONCAT(FLOOR(EXTRACT (EPOCH FROM ${TABLE}.collector_tstamp)/10), ${session_id})
    filters:
      app_id: production
    hidden: true
  
  - measure: total_usage_time_mins
    type: number
    decimals: 2
    sql: ${total_usage_time_10s}/6
    hidden: true
  
  - measure: engagement_time_per_session_number
    type: number
    decimals: 2
    sql: (${total_usage_time_mins}/NULLIF(${count_sessions}, 0)::REAL)
    hidden: true

  - measure: engagement_time_per_session_minutes
    label: AVERAGE SESSION DURATION
    type: string
    sql: floor((${total_usage_time_mins}/NULLIF(${count_sessions}, 0)::REAL)) || ':' || right(cast('00' as varchar) || cast((((${total_usage_time_mins}/NULLIF(${count_sessions}, 0)::REAL) - floor((${total_usage_time_mins}/NULLIF(${count_sessions}, 0)::REAL))) * 60) as integer), 2)
    
  
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
    label: GROSS REVENUE EX COUPON, VAT
    type: sum
    sql: ${transactions.revenue_ex_coupon_and_vat} / ${transactions.exchange_rate}

  - measure: items_purchased
    label: ITEMS PURCHASED
    type: sum
    sql: ${transactions.number_of_items}
  
  - measure: conversion_rate
    label: CONVERSION RATE
    type: number
    decimals: 2
    sql: 100.0 * ${transactions.count_transactions}/NULLIF(${count_sessions},0)::REAL
    format: "%0.2f%"
  
  - measure: avg_basket_size
    label: AVERAGE BASKET SIZE
    type: number
    decimals: 2
    sql: ${items_purchased}/NULLIF(${transactions.count_transactions},0)::REAL
  
  - measure: avg_basket_value
    label: AVERAGE BASKET VALUE
    type: number
    decimals: 2
    sql: ${sum_revenue_ex_coupon_and_vat}/NULLIF(${transactions.count_transactions},0)::REAL
    format: "%£0.2f"
    
############################################################################## EMAIL MEASURES ####################################################################################
    
  - measure: newsletter_signup_rate
    label: NEWSLETTER SIGNUP RATE
    type: number
    decimals: 1
    sql: 100.0 * ${email_subscriptions.count_newsletter_subscribers}/NULLIF(${count_new_users},0)::REAL
    format: "%0.1f%"
    
  - measure: referral_rate
    label: REFERRAL RATE
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

# Counts

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
  
  - measure: sum_revenue_yesterday
    type: sum
    sql: ${transactions.revenue_ex_coupon_and_vat} * ${transactions.exchange_rate}
    hidden: true
    filters:
      event_time_date: 1 day ago for 1 day

  - measure: sum_revenue_last_week
    type: sum
    sql: ${transactions.revenue_ex_coupon_and_vat} * ${transactions.exchange_rate}
    hidden: true
    filters:
      event_time_date: 8 days ago for 1 day
      
  - measure: items_purchased_yesterday
    type: sum
    sql: ${transactions.number_of_items}
    hidden: true
    filters:
      event_time_date: 1 day ago for 1 day
      
  - measure: items_purchased_last_week
    type: sum
    sql: ${transactions.number_of_items}
    hidden: true
    filters:
      event_time_date: 8 days ago for 1 day

  - measure: page_views_yesterday
    type: count_distinct
    sql: ${event_id}
    filters:
      event: page_view
      app_id: production
      event_time_date: 1 day ago for 1 day
    hidden: true

  - measure: page_views_last_week
    type: count_distinct
    sql: ${event_id}
    filters:
      event: page_view
      app_id: production
      event_time_date: 8 days ago for 1 day
    hidden: true

  - measure: page_views_per_session_yesterday
    type: number
    decimals: 2
    sql: ${page_views_yesterday}/NULLIF(${count_sessions_yesterday},0)::REAL
    format: "%0.2f"
    hidden: true

  - measure: page_views_per_session_last_week
    type: number
    decimals: 2
    sql: ${page_views_last_week}/NULLIF(${count_sessions_last_week},0)::REAL
    format: "%0.2f"
    hidden: true

  - measure: total_usage_time_10s_yesterday
    type: count_distinct
    decimals: 2
    sql: CONCAT(FLOOR(EXTRACT (EPOCH FROM ${TABLE}.collector_tstamp)/10), ${session_id})
    filters:
      app_id: production
      event_time_date: 1 day ago for 1 day
    hidden: true
  
  - measure: total_usage_time_mins_yesterday
    type: number
    decimals: 2
    sql: ${total_usage_time_10s_yesterday}/6
    hidden: true
  
  - measure: engagement_time_per_session_number_yesterday
    type: number
    decimals: 2
    sql: (${total_usage_time_mins_yesterday}/NULLIF(${count_sessions_yesterday}, 0)::REAL)
    hidden: true

  - measure: total_usage_time_10s_last_week
    type: count_distinct
    decimals: 2
    sql: CONCAT(FLOOR(EXTRACT (EPOCH FROM ${TABLE}.collector_tstamp)/10), ${session_id})
    filters:
      app_id: production
      event_time_date: 8 days ago for 1 day
    hidden: true
  
  - measure: total_usage_time_mins_last_week
    type: number
    decimals: 2
    sql: ${total_usage_time_10s_last_week}/6
    hidden: true
  
  - measure: engagement_time_per_session_number_last_week
    type: number
    decimals: 2
    sql: (${total_usage_time_mins_last_week}/NULLIF(${count_sessions_last_week}, 0)::REAL)
    hidden: true
  
  - measure: count_bounced_sessions_yesterday
    type: count_distinct
    sql: ${session_id}
    filters:
      domain_userid: -EMPTY
      app_id: production
      sessions.bounce: yes
      event_time_date: 1 day ago for 1 day
    hidden: true
  
  - measure: count_bounced_sessions_last_week
    type: count_distinct
    sql: ${session_id}
    filters:
      domain_userid: -EMPTY
      app_id: production
      sessions.bounce: yes
      event_time_date: 8 days ago for 1 day
    hidden: true
  
  - measure: bounce_rate_yesterday
    type: number
    decimals: 2
    sql: 100.0 * ${count_bounced_sessions_yesterday}/NULLIF(${count_sessions_yesterday},0)::REAL
    format: "%0.1f%"
    hidden: true
  
  - measure: bounce_rate_last_week
    type: number
    decimals: 2
    sql: 100.0 * ${count_bounced_sessions_last_week}/NULLIF(${count_sessions_last_week},0)::REAL
    format: "%0.1f%"
    hidden: true
  
  - measure: basket_size_yesterday
    type: number
    decimals: 2
    sql: ${items_purchased_yesterday}/NULLIF(${transactions.count_transactions_yesterday},0)::REAL
    format: "%0.1f%"
    hidden: true
    
  - measure: basket_size_last_week
    type: number
    decimals: 2
    sql: ${items_purchased_last_week}/NULLIF(${transactions.count_transactions_last_week},0)::REAL
    format: "%0.1f%"
    hidden: true
  
  - measure: basket_value_yesterday
    type: number
    decimals: 2
    sql: ${sum_revenue_yesterday}/NULLIF(${transactions.count_transactions_yesterday},0)::REAL
    format: "%0.2f%"
    hidden: true
    
  - measure: basket_value_last_week
    type: number
    decimals: 2
    sql: ${sum_revenue_last_week}/NULLIF(${transactions.count_transactions_last_week},0)::REAL
    format: "%0.2f%"
    hidden: true
    
# WoW percentages
  
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
        <font color="#3CB371> {{ rendered_value }} </font>
        {% else %}
        <font color="#000000> {{ rendered_value }} </font>
        {% endif %}
    hidden: true

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
        <font color="#3CB371> {{ rendered_value }} </font>
        {% else %}
        <font color="#000000> {{ rendered_value }} </font>
        {% endif %}
    hidden: true

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
        <font color="#3CB371> {{ rendered_value }} </font>
        {% else %}
        <font color="#000000> {{ rendered_value }} </font>
        {% endif %}
    hidden: true

  - measure: items_purchased_wow
    label: CONVERSION RATE WEEK ON WEEK
    type: number
    decimals: 2
    sql: 100.0 * (${items_purchased_yesterday} - ${items_purchased_last_week})/NULLIF(${items_purchased_last_week},0)::REAL
    format: "%0.2f%"
    html: |
        {% if value < 0 - Red' %}
        <font color="#D77070"> {{ rendered_value }} </font>
        {% elsif value > 0 - Green' %}
        <font color="#3CB371> {{ rendered_value }} </font>
        {% else %}
        <font color="#000000> {{ rendered_value }} </font>
        {% endif %}
    hidden: true

  - measure: revenue_wow
    label: CONVERSION RATE WEEK ON WEEK
    type: number
    decimals: 2
    sql: 100.0 * (${sum_revenue_yesterday} - ${sum_revenue_last_week})/NULLIF(${sum_revenue_last_week},0)::REAL
    format: "%0.2f%"
    html: |
        {% if value < 0 - Red' %}
        <font color="#D77070"> {{ rendered_value }} </font>
        {% elsif value > 0 - Green' %}
        <font color="#3CB371> {{ rendered_value }} </font>
        {% else %}
        <font color="#000000> {{ rendered_value }} </font>
        {% endif %}
    hidden: true

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
        <font color="#3CB371> {{ rendered_value }} </font>
        {% else %}
        <font color="#000000> {{ rendered_value }} </font>
        {% endif %}
    hidden: true
    
  - measure: page_views_wow
    label: PAGE VIEWS WEEK ON WEEK
    type: number
    decimals: 2
    sql: 100.0 * (${page_views_yesterday} - ${page_views_last_week})/NULLIF(${page_views_last_week},0)::REAL
    format: "%0.2f%"
    html: |
        {% if value < 0 - Red' %}
        <font color="#D77070"> {{ rendered_value }} </font>
        {% elsif value > 0 - Green' %}
        <font color="#3CB371> {{ rendered_value }} </font>
        {% else %}
        <font color="#000000> {{ rendered_value }} </font>
        {% endif %}
    hidden: true

  - measure: page_views_per_session_wow
    label: PAGE VIEWS WEEK ON WEEK
    type: number
    decimals: 2
    sql: 100.0 * (${page_views_per_session_yesterday} - ${page_views_per_session_last_week})/NULLIF(${page_views_per_session_last_week},0)::REAL
    format: "%0.2f%"
    html: |
        {% if value < 0 - Red' %}
        <font color="#D77070"> {{ rendered_value }} </font>
        {% elsif value > 0 - Green' %}
        <font color="#3CB371> {{ rendered_value }} </font>
        {% else %}
        <font color="#000000> {{ rendered_value }} </font>
        {% endif %}
    hidden: true
  
  - measure: engagement_time_per_session_wow
    label: ENGAGEMENT TIME PER SESSION WEEK ON WEEK
    type: number
    decimals: 2
    sql: 100.0 * (${engagement_time_per_session_number_yesterday} - ${engagement_time_per_session_number_last_week})/NULLIF(${engagement_time_per_session_number_last_week},0)::REAL
    format: "%0.2f%"
    html: |
        {% if value < 0 - Red' %}
        <font color="#D77070"> {{ rendered_value }} </font>
        {% elsif value > 0 - Green' %}
        <font color="#3CB371> {{ rendered_value }} </font>
        {% else %}
        <font color="#000000> {{ rendered_value }} </font>
        {% endif %}
    hidden: true
  
  - measure: bounce_rate_wow
    label: BOUNCE RATE WEEK ON WEEK
    type: number
    decimals: 2
    sql: 100.0 * (${bounce_rate_yesterday} - ${bounce_rate_last_week})/NULLIF(${bounce_rate_last_week},0)::REAL
    format: "%0.2f%"
    html: |
        {% if value < 0 - Red' %}
        <font color="#D77070"> {{ rendered_value }} </font>
        {% elsif value > 0 - Green' %}
        <font color="#3CB371> {{ rendered_value }} </font>
        {% else %}
        <font color="#000000> {{ rendered_value }} </font>
        {% endif %}
    hidden: true

  - measure: basket_size_wow
    label: AVG BASKET SIZE WEEK ON WEEK
    type: number
    decimals: 2
    sql: 100.0 * (${basket_size_yesterday} - ${basket_size_last_week})/NULLIF(${basket_size_last_week},0)::REAL
    format: "%0.2f%"
    html: |
        {% if value < 0 - Red' %}
        <font color="#D77070"> {{ rendered_value }} </font>
        {% elsif value > 0 - Green' %}
        <font color="#3CB371> {{ rendered_value }} </font>
        {% else %}
        <font color="#000000> {{ rendered_value }} </font>
        {% endif %}
    hidden: true

  - measure: basket_value_wow
    label: AVG BASKET VALUE WEEK ON WEEK
    type: number
    decimals: 2
    sql: 100.0 * (${basket_value_yesterday} - ${basket_value_last_week})/NULLIF(${basket_value_last_week},0)::REAL
    format: "%0.2f%"
    html: |
        {% if value < 0 - Red' %}
        <font color="#D77070"> {{ rendered_value }} </font>
        {% elsif value > 0 - Green' %}
        <font color="#3CB371> {{ rendered_value }} </font>
        {% else %}
        <font color="#000000> {{ rendered_value }} </font>
        {% endif %}
    hidden: true