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
  
  - dimension: page_url_path
    label: PAGE PATH
    sql: ${TABLE}.page_urlpath
  
  - dimension: unstruct_event
    label: UNSTRUCTURED EVENT
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

  - dimension: structured_event_value
    type: int
    sql: ${TABLE}.se_value
    hidden: true
    
  - dimension_group: event_time
    label: EVENT
    type: time
    timeframes: [time, hour, date, hour_of_day, day_of_week_index, day_of_week, week, month]
    sql: convert_timezone('UTC', 'Europe/London', ${TABLE}.collector_tstamp)

  - dimension: today_tw_lw_flag
    label: FLAG
    sql: case when ${event_time_date} = current_date then 'Today' when ${event_time_date} = current_date - 7 then 'Last Week' else null end
    hidden: true

  - dimension: yesterday_tw_lw_flag
    label: FLAG
    sql: case when ${event_time_date} = current_date - 1 then 'Yesterday' when ${event_time_date} = current_date - 8 then 'Last Week' else null end
    hidden: true
    
  - dimension: tw_lw_flag
    sql: case when ${event_time_date} between (current_date - extract(dow from current_date) + 1) and current_date then 'This Week' when ${event_time_date} > (current_date - extract(dow from current_date) - 7) then 'Last Week' when ${event_time_date} > (current_date - extract(dow from current_date) - 14) then 'Week Before Last' else null end
    hidden: true
    
  ########### User and Session Dimensions
    
  - dimension: user_id
    sql: ${TABLE}.user_id
    hidden: true
    
  - dimension: blended_user_id
    sql: ${sessions.blended_user_id}
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

  - dimension: email_campaign
    label: EMAIL CAMPAIGN TITLE
    sql: |
         case
         when ${sessions.campaign_medium} = 'email' and ${mailchimp_campaigns_2.email_subject} != 'Other' then ${mailchimp_campaigns_2.email_subject}
         when ${sessions.campaign_medium} = 'email' then ${sessions.campaign_name}
         when ${structured_event_category} = 'email' then ${mailchimp_campaigns_1.email_subject}
         else null end

  - dimension: email_description
    label: EMAIL DESCRIPTION
    sql: |
         case
         when ${sessions.campaign_medium} = 'email' and ${mailchimp_campaigns_2.email_description} != 'Other' then ${mailchimp_campaigns_2.email_description}
         when ${sessions.campaign_medium} = 'email' then ${sessions.campaign_source}
         when ${structured_event_category} = 'email' then ${mailchimp_campaigns_1.email_description}
         else null end
    
  - dimension: email_list
    label: EMAIL LIST
    sql: |
         case
         when ${sessions.campaign_medium} = 'email' and ${mailchimp_campaigns_2.email_list} != 'Other' then ${mailchimp_campaigns_2.email_list}
         when ${sessions.campaign_medium} = 'email' then 'Non-Finery Email'
         when ${structured_event_category} = 'email' then ${mailchimp_campaigns_1.email_list}
         else null end


  - dimension: email_latest_send_date
    type: date
    label: EMAIL SENT
    sql: case when ${sessions.campaign_medium} = 'email' then ${mailchimp_campaigns_2.latest_send_date} when ${structured_event_category} = 'email' then ${mailchimp_campaigns_1.latest_send_date} else null end
    hidden: true
  
  - dimension: campaign
    label: SUB-CHANNEL
    sql: |
         case
         when ${sessions.acquisition_channel} = 'Email' then ${mailchimp_campaigns_2.email_subject}
         when ${sessions.acquisition_channel} = 'Paid Search' then ${sessions.campaign_name}
         when ${sessions.acquisition_channel} = 'Social' then ${sessions.referer_source}
         when ${sessions.acquisition_channel} = 'Search' then ${sessions.referer_source}
         when ${sessions.acquisition_channel} = 'Facebook - Paid Marketing' then ${sessions.campaign_name}
         when ${sessions.acquisition_channel} = 'Referrals' then ${sessions.referer_url_host}
         when ${sessions.acquisition_channel} = 'Other Marketing Source' then ${sessions.campaign_medium} || ' - ' || ${sessions.campaign_name}
         when ${sessions.acquisition_channel} = 'Direct' then null
         else null end
  
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
  
  - measure: latest_snowplow_update
    type: string
    sql: max(convert_timezone('UTC', 'Europe/London', ${TABLE}.collector_tstamp))
  
  - measure: latest_update
    label: LATEST UPDATE
    type: string
    sql: |
        case
        when max(date(convert_timezone('UTC', 'Europe/London', ${TABLE}.collector_tstamp))) < current_date
        then
        'Yesterday @ ' || cast(((extract(epoch from max(convert_timezone('UTC', 'Europe/London', ${TABLE}.collector_tstamp)))) - (extract(epoch from max(date(convert_timezone('UTC', 'Europe/London', ${TABLE}.collector_tstamp))))))/3600 as decimal(8,0)) || ':00'
        else
        'Today @ ' || cast(((extract(epoch from max(convert_timezone('UTC', 'Europe/London', ${TABLE}.collector_tstamp)))) - (extract(epoch from max(date(convert_timezone('UTC', 'Europe/London', ${TABLE}.collector_tstamp))))))/3600 as decimal(8,0)) || ':00'
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

############################################################################# TRANSACTION MEASURES ###############################################################################
  
  - measure: sum_revenue_ex_coupon_and_vat
    label: GROSS REVENUE EX COUPON, VAT
    type: sum
    sql: ${transactions.revenue_ex_coupon_and_vat} / ${transactions.exchange_rate}
    format: "£%d"

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
    format: "£%0.2f"

############################################################ Page Measures #######################################################################################################

  - dimension: landing_page_flag
    type: yesno
    sql: ${page_url_path} = ${sessions.landing_page_path}
    hidden: true
  
  - dimension: exit_page_flag
    type: yesno
    sql: ${page_url_path} = ${sessions.exit_page_path}
    hidden: true
  
  - measure: count_landed_sessions
    label: LANDED SESSIONS COUNT
    type: count_distinct
    sql: ${session_id}
    filters:
      app_id: production
      landing_page_flag: yes
  
  - measure: count_exit_sessions
    label: EXIT SESSIONS COUNT
    type: count_distinct
    sql: ${session_id}
    filters:
      app_id: production
      exit_page_flag: yes
      
  - measure: page_exit_rate
    label: PAGE EXIT RATE
    type: number
    sql: ${count_exit_sessions}/NULLIF(${count_sessions},0)::REAL
    value_format: '#.00%'
  
  - measure: page_bounce_rate
    label: PAGE BOUNCE RATE
    type: number
    sql: ${sessions.bounced_sessions_count}/NULLIF(${count_landed_sessions},0)::REAL
    value_format: '#.00%'
    
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
  
################################################################## Structured Events ##########################################################################

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

  - measure: free_gift_click_event
    label: FREE GIFT BUTTON CLICKS
    type: count_distinct
    sql: ${event_id}
    filters:
      structured_event: freeGiftClick
      app_id: production

  - measure: invite_friends_events
    label: INVITE FRIENDS EVENT
    type: count_distinct
    sql: ${event_id}
    filters:
      structured_event: inviteFriends
      app_id: production
  
  - measure: total_friends_invited
    label: TOTAL FRIENDS INVITED
    type: sum
    sql: ${structured_event_value}
    filters:
      structured_event: inviteFriends
      app_id: production
      
  - measure: button_clicks_invite_ratio
    label: FRIENDS INVITED-BUTTON CLICKS RATIO
    type: number
    decimals: 2
    sql:  coalesce(${invite_friends_events}/NULLIF(${free_gift_click_event},0)::REAL, '0')
    value_format: '#.##%'  

  - measure: avg_friend_invites_sent
    label: AVG FRIENDS INVITED
    type: number
    decimals: 2
    sql:  coalesce(${total_friends_invited}/NULLIF(${invite_friends_events},0)::REAL, '0')
    value_format: '#.##'
  
####################################################################### Product Dimensions and Measures##########################################################################################
  
  - dimension: product_id
    label: PRODUCT ID
    sql: coalesce(cast(${product_impressions.product_id} as int), cast(${product_clicked.product_id} as int), cast(${product_quick_views.product_id} as int), ${page_contexts.product_id}, cast(${product_in_cart.product_id} as int), cast(${product_in_transaction.product_id} as int), cast(${product_in_checkout.product_id} as int))
    
  - dimension: category
    label: CATEGORY PAGE
    sql: |
          case
          when ${product_impressions.list} = 'taxons/show' then coalesce(${product_impressions.category}, ${product_clicked.category}, ${product_quick_views.category}, ${page_contexts.category})
          when ${product_impressions.list} is null then coalesce(${product_impressions.category}, ${product_clicked.category}, ${product_quick_views.category}, ${page_contexts.category})
          when ${product_impressions.list} like '%complete_the_look%' then 'Complete The Look'
          when ${product_impressions.list} = 'products/show' then 'Complete The Look'
          when ${product_impressions.list} like '%related_products%' then 'Related Products'
          else coalesce(${product_impressions.category}, ${product_clicked.category}, ${product_quick_views.category}, ${page_contexts.category})
          end
    
  - dimension: image_style
    label: PRODUCT IMAGE STYLE
    sql: coalesce(${product_impressions.style}, ${product_clicked.style}, ${product_quick_views.style})

  - dimension: list
    label: DISPLAY LIST
    sql: coalesce(${product_impressions.list}, ${product_clicked.list}, ${product_quick_views.list})
    
  - dimension: position
    label: LIST POSITION
    sql: coalesce(${product_impressions.position}, ${product_clicked.position}, ${product_quick_views.position})
    
  - measure: count_product_impressions
    label: COUNT PRODUCT IMPRESSIONS
    type: int
    sql: APPROXIMATE COUNT (DISTINCT case when ${app_id} = 'production' then ${product_impressions.product_impression_id} else null end)

  - measure: count_product_clicks
    label: COUNT PRODUCT CLICKS
    type: int
    sql: APPROXIMATE COUNT (DISTINCT case when ${app_id} = 'production' then coalesce(${product_clicked.event_id},null) else null end)
  
  - measure: count_product_quick_views
    label: COUNT PRODUCT QUICK VIEWS
    type: int
    sql: APPROXIMATE COUNT(DISTINCT case when ${app_id} = 'production' then ${product_quick_views.event_id} else null end)
   
  - measure: count_product_page_views
    label: COUNT PRODUCT PAGE VIEWS
    type: count_distinct
    sql: ${session_id} || ${page_contexts.product_id}
    filters:
      app_id: production
      event: page_view
      page_contexts.page_type: products/show

  - measure: count_products_in_cart
    label: COUNT PRODUCTS IN CART
    type: count_distinct
    sql: ${session_id} || ${product_in_cart.product_id}
    filters:
      app_id: production

  - measure: count_products_in_transaction
    label: COUNT PRODUCTS PURCHASED
    type: sum
    sql: coalesce(${product_in_transaction.quantity}, '0')
    filters:
      app_id: production

  - measure: product_ctr
    label: PRODUCT CLICK-THROUGH RATE
    type: number
    decimals: 2
    sql: coalesce(100.0 * ${count_product_clicks}/NULLIF(${count_product_impressions},0)::REAL,'0')
    format: "%0.2f%"
  
  - measure: product_cr
    label: PRODUCT CONVERSION RATE
    type: number
    decimals: 2
    sql:  coalesce(100.0 * ${count_products_in_transaction}/NULLIF(${count_product_page_views},0)::REAL, '0')
    format: "%0.2f%"
  
  - measure: category_page_views
    label: CATEGORY UNIQUE PAGE VIEWS
    type: count_distinct
    sql: ${session_id} || ${product_impressions.category}
    filters:
      app_id: production
      product_impressions.category: -NULL
      product_impressions.list: taxons/show
      
  - measure: category_clicks
    label: CATEGORY UNIQUE PAGE CLICKS
    type: count_distinct
    sql: ${session_id} || ${product_clicked.category}
    filters:
      app_id: production
      product_clicked.category: -NULL
      
  - measure: category_click_through_rate
    label: CATEGORY CLICK-THROUGH RATE
    type: number
    decimals: 2
    sql:  coalesce(${category_clicks}/NULLIF(${category_page_views},0)::REAL, '0')
    value_format: '#.00%'

  - measure: count_distinct_product_impressions
    label: DISTINCT PRODUCT IMPRESSIONS
    type: count_distinct
    sql: ${product_impressions.product_id} || ${session_id} || ${product_impressions.category}
    hidden: true

  - measure: max_products_in_category
    label: CATEGORY TOTAL PRODUCTS
    type: max
    sql: cast(${product_impressions.position} as int)

  - measure: product_impressions_per_session
    label: CATEGORY AVERAGE PRODUCTS SCROLLED
    type: number
    decimals: 2
    sql:  coalesce(${count_distinct_product_impressions}/NULLIF(${count_sessions},0)::REAL, '0')
    value_format: '#.##'
  
  - measure: avg_scroll_percentage
    label: CATEGORY AVERAGE SCROLL PERCENTAGE
    type: number
    decimals: 2
    sql:  coalesce(${product_impressions_per_session}/NULLIF(${max_products_in_category},0)::REAL, '0')
    value_format: '#.##%'
    
############################################################## Payment Funnel Stuff #########################################################################################################################################################################

  - measure: count_sessions_with_catalog_page_view
    type: count_distinct
    sql: ${session_id}
    filters:
      app_id: production
      event: page_view
      page_contexts.page_type: taxons/show
    hidden: true

  - measure: count_sessions_with_product_page_view
    type: count_distinct
    sql: ${session_id}
    filters:
      app_id: production
      event: page_view
      page_contexts.page_type: products/show
    hidden: true
      
  - measure: count_sessions_with_cart
    type: count_distinct
    sql: ${session_id}
    filters:
      app_id: production
      product_in_cart.event_id: -NULL
    hidden: true
      
  - measure: count_sessions_with_checkout_1
    type: count_distinct
    sql: ${session_id}
    filters:
      app_id: production
      product_in_checkout.checkout_step: '1'
    hidden: true
      
  - measure: count_sessions_with_checkout_2
    type: count_distinct
    sql: ${session_id}
    filters:
      app_id: production
      product_in_checkout.checkout_step: '2'
    hidden: true
      
  - measure: count_sessions_with_checkout_3
    type: count_distinct
    sql: ${session_id}
    filters:
      app_id: production
      product_in_checkout.checkout_step: '3'
    hidden: true
  
  - measure: count_sessions_with_transaction
    type: count_distinct
    sql: ${session_id}
    filters:
      app_id: production
      transactions.event_id: -NULL
    hidden: true
  
  - measure: perc_all_sessions
    label: SESSIONS - ALL SESSIONS
    type: number
    decimals: 2
    sql: 100.0 * ${count_sessions}/NULLIF(${count_sessions},0)::REAL
    format: "%0.2f%"
    
  - measure: perc_sessions_catalog
    label: SESSIONS - CATALOG PAGE
    type: number
    decimals: 2
    sql: 100.0 * ${count_sessions_with_catalog_page_view}/NULLIF(${count_sessions},0)::REAL
    format: "%0.2f%"

  - measure: perc_sessions_product
    label: SESSIONS - PRODUCT PAGE
    type: number
    decimals: 2
    sql: 100.0 * ${count_sessions_with_product_page_view}/NULLIF(${count_sessions},0)::REAL
    format: "%0.2f%"

  - measure: perc_sessions_cart
    label: SESSIONS - ADD TO CART
    type: number
    decimals: 2
    sql: 100.0 * ${count_sessions_with_cart}/NULLIF(${count_sessions},0)::REAL
    format: "%0.2f%"
  
  - measure: perc_sessions_checkout_1
    label: SESSIONS - CHECKOUT STARTED
    type: number
    decimals: 2
    sql: 100.0 * ${count_sessions_with_checkout_1}/NULLIF(${count_sessions},0)::REAL
    format: "%0.2f%"

  - measure: perc_sessions_checkout_2
    label: SESSIONS - CHECKOUT ADDRESS ENTERED
    type: number
    decimals: 2
    sql: 100.0 * ${count_sessions_with_checkout_2}/NULLIF(${count_sessions},0)::REAL
    format: "%0.2f%"

  - measure: perc_sessions_checkout_3
    label: SESSIONS - CHECKOUT DELIVERY METHOD SELECTED
    type: number
    decimals: 2
    sql: 100.0 * ${count_sessions_with_checkout_3}/NULLIF(${count_sessions},0)::REAL
    format: "%0.2f%"

  - measure: perc_sessions_transaction
    label: SESSIONS - ORDER COMPLETED
    type: number
    decimals: 2
    sql: 100.0 * ${count_sessions_with_transaction}/NULLIF(${count_sessions},0)::REAL
    format: "%0.2f%"
  
  - measure: dropout_rate_visitor
    label: DROPOUT RATE - VISITOR
    type: number
    decimals: 2
    sql: 100.0 * (${perc_all_sessions} - ${perc_sessions_catalog})/NULLIF(${perc_all_sessions},0)::REAL
    format: "%0.2f%"
  
  - measure: dropout_rate_catalogue
    label: DROPOUT RATE - CATALOGUE
    type: number
    decimals: 2
    sql: 100.0 * (${perc_sessions_catalog} - ${perc_sessions_product})/NULLIF(${perc_sessions_catalog},0)::REAL
    format: "%0.2f%"

  - measure: dropout_rate_product
    label: DROPOUT RATE - PRODUCT
    type: number
    decimals: 2
    sql: 100.0 * (${perc_sessions_product} - ${perc_sessions_cart})/NULLIF(${perc_sessions_product},0)::REAL
    format: "%0.2f%"

  - measure: dropout_rate_cart
    label: DROPOUT RATE - CART
    type: number
    decimals: 2
    sql: 100.0 * (${perc_sessions_cart} - ${perc_sessions_checkout_1})/NULLIF(${perc_sessions_cart},0)::REAL
    format: "%0.2f%"

  - measure: dropout_rate_checkout
    label: DROPOUT RATE - CHECKOUT
    type: number
    decimals: 2
    sql: 100.0 * (${perc_sessions_checkout_1} - ${perc_sessions_transaction})/NULLIF(${perc_sessions_checkout_1},0)::REAL
    format: "%0.2f%"

################################## Web Goals Engagement Stuff ###########################################################

  - measure: count_registration_sessions
    label: COUNT SESSIONS WITH REGISTRATION
    type: count_distinct
    sql: ${session_id}
    filters:
     app_id: production
     register_success.event_id: -NULL
      
  - measure: count_newsletter_subscription_sessions
    type: count_distinct
    sql: ${session_id}
    filters:
     app_id: production
     newsletter_subscriptions.event_id: -NULL
    hidden: true

  - measure: count_engaged_sessions
    type: count_distinct
    label: COUNT ENGAGED SESSIONS
    sql: |
        case
        when (
        ${register_success.event_id} is not null
        or ${newsletter_subscriptions.event_id} is not null
        or ${transactions.event_id} is not null
        or ${product_in_checkout.event_id} is not null
        or ${product_in_cart.event_id} is not null
        or ${sessions.distinct_pages_viewed} > 6
        or ${sessions.session_duration_seconds} > 239
        ) then ${session_id} else null end
    filters:
     app_id: production
     
  - measure: newsletter_subscription_rate
    label: NEWSLETTER SUBSCRIPTION RATE
    type: number
    decimals: 2
    sql: 100.0 * (${count_newsletter_subscription_sessions})/NULLIF(${count_sessions},0)::REAL
    format: "%0.2f%"
     
  - measure: signup_rate
    label: CREATE ACCOUNT RATE
    type: number
    decimals: 2
    sql: 100.0 * (${count_registration_sessions})/NULLIF(${count_sessions},0)::REAL
    format: "%0.2f%"
  
  - measure: engagement_rate
    label: ENGAGEMENT RATE
    type: number
    decimals: 2
    sql: 100.0 * (${count_engaged_sessions})/NULLIF(${count_sessions},0)::REAL
    format: "%0.2f%"
      
   







#############################################################################################################################################################################################################################################################      
#############################################################################################################################################################################################################################################################  
################################################################################################################## WEEK ON WEEK MEASURES #################################################################################################################### 
############################################################################################################################################################################################################################################################# 
#############################################################################################################################################################################################################################################################

# Counts

#  - measure: count_sessions_yesterday
#    label: SESSIONS YESTERDAY
#    type: count_distinct
#    sql: ${session_id}
#    filters:
#      domain_userid: -EMPTY
#      domain_sessionidx: -EMPTY
#      event_time_date: 1 day ago for 1 day
#      app_id: production
#    hidden: true
#      
#  - measure: count_sessions_last_week
#    label: SESSIONS LAST WEEK
#    type: count_distinct
#    sql: ${session_id}
#    filters:
#      domain_userid: -EMPTY
#      domain_sessionidx: -EMPTY
#      event_time_date: 8 days ago for 1 day
#      app_id: production
#    hidden: true

#  - measure: conversion_rate_yesterday
#    label: CONVERSION RATE YESTERDAY
#    type: number
#    decimals: 2
#    sql: 100.0 * ${transactions.count_transactions_yesterday}/NULLIF(${count_sessions_yesterday},0)::REAL
#    format: "%0.2f%"
#    hidden: true

#  - measure: conversion_rate_last_week
#    label: CONVERSION RATE LAST WEEK
#    type: number
#    decimals: 2
#    sql: 100.0 * ${transactions.count_transactions_last_week}/NULLIF(${count_sessions_last_week},0)::REAL
#    format: "%0.2f%"
#    hidden: true

#  - measure: count_new_sessions_yesterday
#    type: count_distinct
#    sql: ${session_id}
#    filters:
#      domain_userid: -EMPTY
#      domain_sessionidx: 1
#      app_id: production
#      event_time_date: 1 day ago for 1 day
#    hidden: true
#      
#  - measure: count_new_sessions_last_week
#    type: count_distinct
#    sql: ${session_id}
#    filters:
#      domain_userid: -EMPTY
#      domain_sessionidx: 1
#      app_id: production
#      event_time_date:  8 days ago for 1 day
#    hidden: true
#
#  - measure: new_session_perc_yesterday
#    type: number
#    label: NEW SESSION % YESTERDAY
#    decimals: 2
#    sql: 100.0 * ${count_new_sessions_yesterday}/NULLIF(${count_sessions_yesterday},0)::REAL
#    format: "%0.2f%"
#    hidden: true
#    
#  - measure: new_session_perc_last_week
#    type: number
#    label: NEW SESSION % LAST WEEK
#    decimals: 2
#    sql: 100.0 * ${count_new_sessions_last_week}/NULLIF(${count_sessions_last_week},0)::REAL
#    format: "%0.2f%"
#    hidden: true
#  
#  - measure: sum_revenue_yesterday
#    type: sum
#    label: REVENUE YESTERDAY
#    sql: ${transactions.revenue_ex_coupon_and_vat} / ${transactions.exchange_rate}
#    hidden: true
#    filters:
#      event_time_date: 1 day ago for 1 day

  - measure: sum_revenue_last_week
    type: sum
    label: REVENUE LAST WEEK
    sql: ${transactions.revenue_ex_coupon_and_vat} / ${transactions.exchange_rate}
    hidden: true
    filters:
      event_time_date: 8 days ago for 1 day
      
  - measure: items_purchased_yesterday
    type: sum
    label: ITEMS PURCHASED YESTERDAY
    sql: ${transactions.number_of_items}
    hidden: true
    filters:
      event_time_date: 1 day ago for 1 day
      
  - measure: items_purchased_last_week
    type: sum
    label: ITEMS PURCHASED LAST WEEK
    sql: ${transactions.number_of_items}
    hidden: true
    filters:
      event_time_date: 8 days ago for 1 day

  - measure: page_views_yesterday
    type: count_distinct
    label: PAGE VIEWS YESTERDAY
    sql: ${event_id}
    filters:
      event: page_view
      app_id: production
      event_time_date: 1 day ago for 1 day
    hidden: true

  - measure: page_views_last_week
    type: count_distinct
    label: PAGE VIEWS LAST WEEK
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
    label: BOUNCE RATE YESTERDAY
    decimals: 2
    sql: 100.0 * ${count_bounced_sessions_yesterday}/NULLIF(${count_sessions_yesterday},0)::REAL
    format: "%0.1f%"
    hidden: true
  
  - measure: bounce_rate_last_week
    type: number
    label: BOUNCE RATE LAST WEEK
    decimals: 2
    sql: 100.0 * ${count_bounced_sessions_last_week}/NULLIF(${count_sessions_last_week},0)::REAL
    format: "%0.1f%"
    hidden: true
  
  - measure: basket_size_yesterday
    type: number
    label: BASKET SIZE YESTERDAY
    decimals: 2
    sql: ${items_purchased_yesterday}/NULLIF(${transactions.count_transactions_yesterday},0)::REAL
    format: "%0.1f%"
    hidden: true
    
  - measure: basket_size_last_week
    type: number
    label: BASKET SIZE LAST WEEK
    decimals: 2
    sql: ${items_purchased_last_week}/NULLIF(${transactions.count_transactions_last_week},0)::REAL
    format: "%0.1f%"
    hidden: true
  
  - measure: basket_value_yesterday
    type: number
    label: BASKET VALUE YESTERDAY
    decimals: 2
    sql: ${sum_revenue_yesterday}/NULLIF(${transactions.count_transactions_yesterday},0)::REAL
    format: "%0.2f%"
    hidden: true
    
  - measure: basket_value_last_week
    type: number
    label: BASKET VALUE LAST WEEK
    decimals: 2
    sql: ${sum_revenue_last_week}/NULLIF(${transactions.count_transactions_last_week},0)::REAL
    format: "%0.2f%"
    hidden: true
  
  - measure: count_engaged_sessions_yesterday
    type: count_distinct
    sql: |
        case
        when (
        ${register_success.event_id} is not null
        or ${newsletter_subscriptions.event_id} is not null
        or ${transactions.event_id} is not null
        or ${product_in_checkout.event_id} is not null
        or ${product_in_cart.event_id} is not null
        or ${sessions.distinct_pages_viewed} > 6
        or ${sessions.session_duration_seconds} > 239
        ) then ${session_id} else null end
    filters:
     app_id: production
     event_time_date: 1 day ago for 1 day
    hidden: true
  
  - measure: count_engaged_sessions_last_week
    type: count_distinct
    sql: |
        case
        when (
        ${register_success.event_id} is not null
        or ${newsletter_subscriptions.event_id} is not null
        or ${transactions.event_id} is not null
        or ${product_in_checkout.event_id} is not null
        or ${product_in_cart.event_id} is not null
        or ${sessions.distinct_pages_viewed} > 6
        or ${sessions.session_duration_seconds} > 239
        ) then ${session_id} else null end
    filters:
     app_id: production
     event_time_date: 8 days ago for 1 day
    hidden: true

  - measure: engagement_rate_yesterday
    label: ENGAGEMENT RATE YESTERDAY
    type: number
    decimals: 2
    sql: 100.0 * (${count_engaged_sessions_yesterday})/NULLIF(${count_sessions_yesterday},0)::REAL
    format: "%0.2f%"
    hidden: true
    
  - measure: engagement_rate_last_week
    label: ENGAGEMENT RATE LAST WEEK
    type: number
    decimals: 2
    sql: 100.0 * (${count_engaged_sessions_last_week})/NULLIF(${count_sessions_last_week},0)::REAL
    format: "%0.2f%"  
    hidden: true

  - measure: new_customer_perc_yesterday
    label: NEW CUSTOMER % YESTERDAY
    type: number
    decimals: 2
    sql: (${transactions.count_new_customers_yesterday})/NULLIF(${transactions.count_transactions_yesterday},0)::REAL
    value_format: '#.00%'
    hidden: true
    
  - measure: new_customer_perc_last_week
    label: NEW CUSTOMER % LAST WEEK
    type: number
    decimals: 2
    sql: (${transactions.count_new_customers_last_week})/NULLIF(${transactions.count_transactions_last_week},0)::REAL
    value_format: '#.00%'
    hidden: true
    
# WoW percentages
  
  - measure: sessions_wow
    label: SESSIONS WOW
    type: number
    decimals: 2
    sql: 100.0 * (${count_sessions_yesterday} - ${count_sessions_last_week})/NULLIF(${count_sessions_last_week},0)::REAL
    format: "%0.2f%"
    html: |
        {% if value < 0 %}
        <font color="#D77070"> {{ rendered_value }} </font>
        {% elsif value > 0 %}
        <font color="#3CB371"> {{ rendered_value }} </font>
        {% else %}
        <font color="#000000"> {{ rendered_value }} </font>
        {% endif %}
    hidden: true

  - measure: orders_wow
    label: ORDERS WOW
    type: number
    decimals: 2
    sql: 100.0 * (${transactions.count_transactions_yesterday} - ${transactions.count_transactions_last_week})/NULLIF(${transactions.count_transactions_last_week},0)::REAL
    format: "%0.2f%"
    html: |
        {% if value < 0 %}
        <font color="#D77070"> {{ rendered_value }} </font>
        {% elsif value > 0 %}
        <font color="#3CB371"> {{ rendered_value }} </font>
        {% else %}
        <font color="#000000"> {{ rendered_value }} </font>
        {% endif %}
    hidden: true

  - measure: new_customers_wow
    label: NEW CUSTOMER PERCENTAGE WOW
    type: number
    decimals: 2
    sql: 100.0 * (${new_customer_perc_yesterday} - ${new_customer_perc_last_week})/NULLIF(${new_customer_perc_last_week},0)::REAL
    format: "%0.2f%"
    html: |
        {% if value < 0 %}
        <font color="#D77070"> {{ rendered_value }} </font>
        {% elsif value > 0 %}
        <font color="#3CB371"> {{ rendered_value }} </font>
        {% else %}
        <font color="#000000"> {{ rendered_value }} </font>
        {% endif %}
    hidden: true


  - measure: conversion_rate_wow
    label: CONVERSION RATE WOW
    type: number
    decimals: 2
    sql: 100.0 * (${conversion_rate_yesterday} - ${conversion_rate_last_week})/NULLIF(${conversion_rate_last_week},0)::REAL
    format: "%0.2f%"
    html: |
        {% if value < 0 %}
        <font color="#D77070"> {{ rendered_value }} </font>
        {% elsif value > 0 %}
        <font color="#3CB371"> {{ rendered_value }} </font>
        {% else %}
        <font color="#000000"> {{ rendered_value }} </font>
        {% endif %}
    hidden: true

  - measure: items_purchased_wow
    label: ITEMS PURCHASED WOW
    type: number
    decimals: 2
    sql: 100.0 * (${items_purchased_yesterday} - ${items_purchased_last_week})/NULLIF(${items_purchased_last_week},0)::REAL
    format: "%0.2f%"
    html: |
        {% if value < 0 %}
        <font color="#D77070"> {{ rendered_value }} </font>
        {% elsif value > 0 %}
        <font color="#3CB371"> {{ rendered_value }} </font>
        {% else %}
        <font color="#000000"> {{ rendered_value }} </font>
        {% endif %}
    hidden: true

  - measure: revenue_wow
    label: REVENUE WOW
    type: number
    decimals: 2
    sql: 100.0 * (${sum_revenue_yesterday} - ${sum_revenue_last_week})/NULLIF(${sum_revenue_last_week},0)::REAL
    format: "%0.2f%"
    html: |
        {% if value < 0 %}
        <font color="#D77070"> {{ rendered_value }} </font>
        {% elsif value > 0 %}
        <font color="#3CB371"> {{ rendered_value }} </font>
        {% else %}
        <font color="#000000"> {{ rendered_value }} </font>
        {% endif %}
    hidden: true

  - measure: new_session_perc_wow
    label: NEW SESSIONS WOW
    type: number
    decimals: 2
    sql: (${new_session_perc_yesterday} - ${new_session_perc_last_week})/NULLIF(${new_session_perc_last_week},0)::REAL
    value_format: '#.00%'
    html: |
        {% if value < 0 %}
        <font color="#D77070"> {{ rendered_value }} </font>
        {% elsif value > 0 %}
        <font color="#3CB371"> {{ rendered_value }} </font>
        {% else %}
        <font color="#000000"> {{ rendered_value }} </font>
        {% endif %}
    hidden: true
    
  - measure: page_views_wow
    label: PAGE VIEWS WOW
    type: number
    decimals: 2
    sql: 100.0 * (${page_views_yesterday} - ${page_views_last_week})/NULLIF(${page_views_last_week},0)::REAL
    format: "%0.2f%"
    html: |
        {% if value < 0 %}
        <font color="#D77070"> {{ rendered_value }} </font>
        {% elsif value > 0 %}
        <font color="#3CB371"> {{ rendered_value }} </font>
        {% else %}
        <font color="#000000"> {{ rendered_value }} </font>
        {% endif %}
    hidden: true

  - measure: page_views_per_session_wow
    label: PAGE VIEWS/SESSION WOW
    type: number
    decimals: 2
    sql: 100.0 * (${page_views_per_session_yesterday} - ${page_views_per_session_last_week})/NULLIF(${page_views_per_session_last_week},0)::REAL
    format: "%0.2f%"
    html: |
        {% if value < 0 %}
        <font color="#D77070"> {{ rendered_value }} </font>
        {% elsif value > 0 %}
        <font color="#3CB371"> {{ rendered_value }} </font>
        {% else %}
        <font color="#000000"> {{ rendered_value }} </font>
        {% endif %}
    hidden: true
  
  - measure: engagement_time_per_session_wow
    label: ENGAGEMENT TIME/SESSION WOW
    type: number
    decimals: 2
    sql: 100.0 * (${engagement_time_per_session_number_yesterday} - ${engagement_time_per_session_number_last_week})/NULLIF(${engagement_time_per_session_number_last_week},0)::REAL
    format: "%0.2f%"
    html: |
        {% if value < 0 %}
        <font color="#D77070"> {{ rendered_value }} </font>
        {% elsif value > 0 %}
        <font color="#3CB371"> {{ rendered_value }} </font>
        {% else %}
        <font color="#000000"> {{ rendered_value }} </font>
        {% endif %}
    hidden: true
  
  - measure: bounce_rate_wow
    label: BOUNCE RATE WOW
    type: number
    decimals: 2
    sql: 100.0 * (${bounce_rate_yesterday} - ${bounce_rate_last_week})/NULLIF(${bounce_rate_last_week},0)::REAL
    format: "%0.2f%"
    html: |
        {% if value < 0 %}
        <font color="#3CB371"> {{ rendered_value }} </font>
        {% elsif value > 0 %}
        <font color="#D77070"> {{ rendered_value }} </font>
        {% else %}
        <font color="#000000"> {{ rendered_value }} </font>
        {% endif %}
    hidden: true

  - measure: basket_size_wow
    label: BASKET SIZE WOW
    type: number
    decimals: 2
    sql: 100.0 * (${basket_size_yesterday} - ${basket_size_last_week})/NULLIF(${basket_size_last_week},0)::REAL
    format: "%0.2f%"
    html: |
        {% if value < 0 %}
        <font color="#D77070"> {{ rendered_value }} </font>
        {% elsif value > 0 %}
        <font color="#3CB371"> {{ rendered_value }} </font>
        {% else %}
        <font color="#000000"> {{ rendered_value }} </font>
        {% endif %}
    hidden: true

  - measure: basket_value_wow
    label: BASKET VALUE WOW
    type: number
    decimals: 2
    sql: 100.0 * (${basket_value_yesterday} - ${basket_value_last_week})/NULLIF(${basket_value_last_week},0)::REAL
    format: "%0.2f%"
    html: |
        {% if value < 0 %}
        <font color="#D77070"> {{ rendered_value }} </font>
        {% elsif value > 0 %}
        <font color="#3CB371"> {{ rendered_value }} </font>
        {% else %}
        <font color="#000000"> {{ rendered_value }} </font>
        {% endif %}
    hidden: true

  - measure: engagement_rate_wow
    label: ENGAGEMENT RATE WOW
    type: number
    decimals: 2
    sql: 100.0 * (${engagement_rate_yesterday} - ${engagement_rate_last_week})/NULLIF(${engagement_rate_last_week},0)::REAL
    format: "%0.2f%"
    html: |
        {% if value < 0 %}
        <font color="#D77070"> {{ rendered_value }} </font>
        {% elsif value > 0 %}
        <font color="#3CB371"> {{ rendered_value }} </font>
        {% else %}
        <font color="#000000"> {{ rendered_value }} </font>
        {% endif %}
    hidden: true
    
  - measure: new_customer_perc_wow
    label: NEW CUSTOMER % WOW
    type: number
    decimals: 2
    sql: 100.0 * (${new_customer_perc_yesterday} - ${new_customer_perc_last_week})/NULLIF(${new_customer_perc_last_week},0)::REAL
    format: "%0.2f%"
    html: |
        {% if value < 0 %}
        <font color="#D77070"> {{ rendered_value }} </font>
        {% elsif value > 0 %}
        <font color="#3CB371"> {{ rendered_value }} </font>
        {% else %}
        <font color="#000000"> {{ rendered_value }} </font>
        {% endif %}
    hidden: true