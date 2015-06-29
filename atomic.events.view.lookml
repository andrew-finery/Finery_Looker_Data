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
  
  - dimension: event
    sql: ${TABLE}.event
    hidden: true

  - dimension: page_url_host
    label: URL Host
    sql: ${TABLE}.page_urlhost

  - dimension: page_url_path
    label: URL Path
    sql: ${TABLE}.page_urlpath
    hidden: true
  
  - dimension: page_urlpath_adjusted_for_country
    label: Page URL Path
    sql: |
        case

        when ${TABLE}.page_urlpath like '%/uk' then replace(${TABLE}.page_urlpath, '/uk', '/')
        when ${TABLE}.page_urlpath like '%/uk/%' then replace(${TABLE}.page_urlpath, '/uk/', '/')
        
        when ${TABLE}.page_urlpath like '%/us' then replace(${TABLE}.page_urlpath, '/us', '/')
        when ${TABLE}.page_urlpath like '%/us/%' then replace(${TABLE}.page_urlpath, '/us/', '/')
        
        when ${TABLE}.page_urlpath like '%/ie' then replace(${TABLE}.page_urlpath, '/ie', '/')
        when ${TABLE}.page_urlpath like '%/ie/%' then replace(${TABLE}.page_urlpath, '/ie/', '/')
        
        when ${TABLE}.page_urlpath like '%/au' then replace(${TABLE}.page_urlpath, '/au', '/')
        when ${TABLE}.page_urlpath like '%/au/%' then replace(${TABLE}.page_urlpath, '/au/', '/')
        
        when ${TABLE}.page_urlpath like '%/ca' then replace(${TABLE}.page_urlpath, '/ca', '/')
        when ${TABLE}.page_urlpath like '%/ca/%' then replace(${TABLE}.page_urlpath, '/ca/', '/')
        
        when ${TABLE}.page_urlpath like '%/sg' then replace(${TABLE}.page_urlpath, '/sg', '/')
        when ${TABLE}.page_urlpath like '%/sg/%' then replace(${TABLE}.page_urlpath, '/sg/', '/')
        
        when ${TABLE}.page_urlpath like '%/hk' then replace(${TABLE}.page_urlpath, '/hk', '/')
        when ${TABLE}.page_urlpath like '%/hk/%' then replace(${TABLE}.page_urlpath, '/hk/', '/')
        
        when ${TABLE}.page_urlpath like '%/ae' then replace(${TABLE}.page_urlpath, '/ae', '/')
        when ${TABLE}.page_urlpath like '%/ae/%' then replace(${TABLE}.page_urlpath, '/ae/', '/')
        
        else ${TABLE}.page_urlpath
        
        end
  
  - dimension: page_type
    label: Page Type
    sql_case:
      Homepage: ${page_urlpath_adjusted_for_country} in ('/', '//')
      Product Listing Page: ${page_url_path} like '%/t/%'
      Product Detail Page: ${page_url_path} like '%/products/%'
      Chapters Home: ${page_urlpath_adjusted_for_country} = '/chapters'
      Editorial: ${page_url_path} like '%/chapters/%'
      Cart: ${page_urlpath_adjusted_for_country} = '/cart'
      Checkout: ${page_urlpath_adjusted_for_country} = '/checkout'
      Order Complete: ${page_url_path} like '/orders/%'
      else: Other
      
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
    label: Email Campaign Title
    sql: |
         case
         when ${sessions.campaign_medium} = 'email' and ${mailchimp_campaigns_2.email_subject} != 'Other' then ${mailchimp_campaigns_2.email_subject}
         when ${sessions.campaign_medium} = 'email' then ${sessions.campaign_name}
         when ${structured_event_category} = 'email' then ${mailchimp_campaigns_1.email_subject}
         else null end

  - dimension: email_description
    label: Email Description
    sql: |
         case
         when ${sessions.campaign_medium} = 'email' and ${mailchimp_campaigns_2.email_description} != 'Other' then ${mailchimp_campaigns_2.email_description}
         when ${sessions.campaign_medium} = 'email' then ${sessions.campaign_source}
         when ${structured_event_category} = 'email' then ${mailchimp_campaigns_1.email_description}
         else null end
    
  - dimension: email_list
    label: Email List
    sql: |
         case
         when ${sessions.campaign_medium} = 'email' and ${mailchimp_campaigns_2.email_list} != 'Other' then ${mailchimp_campaigns_2.email_list}
         when ${sessions.campaign_medium} = 'email' then 'Non-Finery Email'
         when ${structured_event_category} = 'email' then ${mailchimp_campaigns_1.email_list}
         else null end


  - dimension: email_latest_send_date
    type: date
    label: Email Sent
    sql: case when ${sessions.campaign_medium} = 'email' then ${mailchimp_campaigns_2.latest_send_date} when ${structured_event_category} = 'email' then ${mailchimp_campaigns_1.latest_send_date} else null end
    hidden: true
  
  - dimension: campaign
    label: Sub-Channel
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
    label: Count Events
    type: count_distinct
    sql: ${event_id}

  - measure: count_users
    label: Count Users
    type: count_distinct
    sql: ${blended_user_id}
    filters:
      domain_userid: -EMPTY
      domain_sessionidx: -EMPTY
      app_id: production

  - measure: count_new_users
    label: Count New Users
    type: count_distinct
    sql: ${blended_user_id}
    filters:
      domain_userid: -EMPTY
      domain_sessionidx: 1
      app_id: production
  
  - measure: count_sessions
    label: Count Sessions
    type: count_distinct
    sql: ${session_id}
    filters:
      domain_userid: -EMPTY
      domain_sessionidx: -EMPTY
      app_id: production

  - measure: count_new_sessions
    label: Count New Sessions
    type: count_distinct
    sql: ${session_id}
    filters:
      domain_userid: -EMPTY
      domain_sessionidx: 1
      app_id: production

  - measure: count_session_logged_in
    label: Count Logged in Sessions
    type: count_distinct
    sql: ${session_id}
    filters:
      user_id: -NULL
      domain_userid: -EMPTY
      domain_sessionidx: -EMPTY
      app_id: production

  - measure: count_users_logged_in
    label: Count Logged in Users
    type: count_distinct
    sql: ${user_id}
    filters:
      app_id: production
    
  - measure: new_user_percentage
    label: New User %
    type: number
    decimals: 2
    sql: 100.0 * ${count_new_users}/NULLIF(${count_users},0)::REAL
    format: "%0.1f%"

  - measure: new_session_percentage
    label: New Session %
    type: number
    decimals: 2
    sql: 100.0 * ${count_new_sessions}/NULLIF(${count_sessions},0)::REAL
    format: "%0.1f%"
  
  - measure: user_logged_in_percentage
    label: Logged In %
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
    label: Latest Update
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
    label: Page Views
    type: count_distinct
    sql: ${event_id}
    filters:
      event: page_view
      app_id: production

  - measure: page_views_per_session
    label: PPage Views per Session
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
    label: Average Session Duration
    type: string
    sql: floor((${total_usage_time_mins}/NULLIF(${count_sessions}, 0)::REAL)) || ':' || right(cast('00' as varchar) || cast((((${total_usage_time_mins}/NULLIF(${count_sessions}, 0)::REAL) - floor((${total_usage_time_mins}/NULLIF(${count_sessions}, 0)::REAL))) * 60) as integer), 2)

##### Click-Through Rate Measures

  - measure: product_ctr
    label: CTR (to any Product Page)
    type: number
    sql: ${snowplow_link_clicks.sessions_with_product_click_count}/${sessions.count}
    value_format: '#0.00%'
    
############################################################################# TRANSACTION MEASURES ###############################################################################
  
  - measure: sum_revenue_ex_coupon_and_vat
    label: Gross Revenue ex. Discount, VAT
    type: sum
    sql: ${transactions.revenue_ex_coupon_and_vat} / ${transactions.exchange_rate}
    format: "£%d"

  - measure: items_purchased
    label: Items Purchased
    type: sum
    sql: ${transactions.number_of_items}
  
  - measure: conversion_rate
    label: Conversion Rate
    type: number
    decimals: 2
    sql: 100.0 * ${transactions.count_transactions}/NULLIF(${count_sessions},0)::REAL
    format: "%0.2f%"
  
#  - measure: avg_basket_size
#    label: AVERAGE BASKET SIZE
#    type: number
#    decimals: 2
#    sql: ${items_purchased}/NULLIF(${transactions.count_transactions},0)::REAL
  
#  - measure: avg_basket_value
#    label: AVERAGE BASKET VALUE
#    type: number
#    decimals: 2
#    sql: ${sum_revenue_ex_coupon_and_vat}/NULLIF(${transactions.count_transactions},0)::REAL
#    format: "£%0.2f"


############################################################################## EMAIL MEASURES ####################################################################################
    
  - measure: newsletter_signup_rate
    label: Newsletter Signup Rate
    type: number
    decimals: 1
    sql: 100.0 * ${email_subscriptions.count_newsletter_subscribers}/NULLIF(${count_new_users},0)::REAL
    format: "%0.1f%"
    
  - measure: referral_rate
    label: Referral Rate
    type: number
    decimals: 1
    sql: 100.0 * ${email_subscriptions.count_referrals}/NULLIF(${count_users_logged_in},0)::REAL
    format: "%0.1f%"
  
  - measure: count_total_opens
    label: Total Email Opens
    type: count_distinct
    sql: ${event_id}
    filters:
      structured_event: open
      structured_event_category: email
      app_id: production

  - measure: count_unique_opens
    label: Unique Email Opens
    type: count_distinct
    sql: ${structured_event_label} || '-' || ${structured_event_property}
    filters:
      structured_event: open
      structured_event_category: email
      app_id: production
  
################################################################## Structured Events ##########################################################################

  - measure: count_customer_service_events
    label: CS Link Clicked
    type: count_distinct
    sql: ${event_id}
    filters:
      structured_event: customerService
      app_id: production

  - measure: count_contact_form_events
    label: Contact Form Submitted
    type: count_distinct
    sql: ${event_id}
    filters:
      structured_event: contactForm
      app_id: production

  - measure: free_gift_click_event
    label: Free Gift Button Clicks
    type: count_distinct
    sql: ${event_id}
    filters:
      structured_event: freeGiftClick
      app_id: production

  - measure: invite_friends_events
    label: Invite Friends Event
    type: count_distinct
    sql: ${event_id}
    filters:
      structured_event: inviteFriends
      app_id: production
  
  - measure: total_friends_invited
    label: Total Friends Invited
    type: sum
    sql: ${structured_event_value}
    filters:
      structured_event: inviteFriends
      app_id: production
      
  - measure: button_clicks_invite_ratio
    label: Friends Invited - Button Clicked Ratio
    type: number
    decimals: 2
    sql:  coalesce(${invite_friends_events}/NULLIF(${free_gift_click_event},0)::REAL, '0')
    value_format: '#.##%'  

  - measure: avg_friend_invites_sent
    label: Average Friends Invited
    type: number
    decimals: 2
    sql:  coalesce(${total_friends_invited}/NULLIF(${invite_friends_events},0)::REAL, '0')
    value_format: '#.##'
  
####################################################################### Product Dimensions and Measures##########################################################################################
  
  - dimension: product_id
    label: Product ID
    sql: coalesce(cast(${product_impressions.product_id} as int), cast(${product_clicked.product_id} as int), cast(${product_quick_views.product_id} as int), ${page_contexts.product_id}, cast(${product_in_cart.product_id} as int), cast(${product_in_transaction.product_id} as int), cast(${product_in_checkout.product_id} as int))
    
  - dimension: category
    label: Category Page
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
    label: Product Image Style
    sql: coalesce(${product_impressions.style}, ${product_clicked.style}, ${product_quick_views.style})

  - dimension: list
    label: Display List
    sql: coalesce(${product_impressions.list}, ${product_clicked.list}, ${product_quick_views.list})
    
  - dimension: position
    label: List Position
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

#  - measure: count_sessions_with_catalog_page_view
#    type: count_distinct
#    sql: ${session_id}
#    filters:
#      app_id: production
#      event: page_view
#      page_contexts.page_type: taxons/show
#    hidden: true

#  - measure: count_sessions_with_product_page_view
#    type: count_distinct
#    sql: ${session_id}
#    filters:
#      app_id: production
#      event: page_view
#      page_contexts.page_type: products/show
#    hidden: true
      
#  - measure: count_sessions_with_cart
#    type: count_distinct
#    sql: ${session_id}
#    filters:
#      app_id: production
#      product_in_cart.event_id: -NULL
#    hidden: true
      
#  - measure: count_sessions_with_checkout_1
#    type: count_distinct
#    sql: ${session_id}
#    filters:
#      app_id: production
#      product_in_checkout.checkout_step: '1'
#    hidden: true
      
#  - measure: count_sessions_with_checkout_2
#    type: count_distinct
#    sql: ${session_id}
#    filters:
#      app_id: production
#      product_in_checkout.checkout_step: '2'
#    hidden: true
      
#  - measure: count_sessions_with_checkout_3
#    type: count_distinct
#    sql: ${session_id}
#    filters:
#      app_id: production
#      product_in_checkout.checkout_step: '3'
#    hidden: true
  
#  - measure: count_sessions_with_transaction
#    type: count_distinct
#    sql: ${session_id}
#    filters:
#      app_id: production
#      transactions.event_id: -NULL
#    hidden: true
  
#  - measure: perc_all_sessions
#    label: SESSIONS - ALL SESSIONS
#    type: number
#    decimals: 2
#    sql: 100.0 * ${count_sessions}/NULLIF(${count_sessions},0)::REAL
#    format: "%0.2f%"
    
#  - measure: perc_sessions_catalog
#    label: SESSIONS - CATALOG PAGE
#    type: number
#    decimals: 2
#    sql: 100.0 * ${count_sessions_with_catalog_page_view}/NULLIF(${count_sessions},0)::REAL
#    format: "%0.2f%"

#  - measure: perc_sessions_product
#    label: SESSIONS - PRODUCT PAGE
#    type: number
#    decimals: 2
#    sql: 100.0 * ${count_sessions_with_product_page_view}/NULLIF(${count_sessions},0)::REAL
#    format: "%0.2f%"

#  - measure: perc_sessions_cart
#    label: SESSIONS - ADD TO CART
#    type: number
#    decimals: 2
#    sql: 100.0 * ${count_sessions_with_cart}/NULLIF(${count_sessions},0)::REAL
#    format: "%0.2f%"
  
#  - measure: perc_sessions_checkout_1
#    label: SESSIONS - CHECKOUT STARTED
#    type: number
#    decimals: 2
#    sql: 100.0 * ${count_sessions_with_checkout_1}/NULLIF(${count_sessions},0)::REAL
#    format: "%0.2f%"

#  - measure: perc_sessions_checkout_2
#    label: SESSIONS - CHECKOUT ADDRESS ENTERED
#    type: number
#    decimals: 2
#    sql: 100.0 * ${count_sessions_with_checkout_2}/NULLIF(${count_sessions},0)::REAL
#    format: "%0.2f%"

#  - measure: perc_sessions_checkout_3
#    label: SESSIONS - CHECKOUT DELIVERY METHOD SELECTED
#    type: number
#    decimals: 2
#    sql: 100.0 * ${count_sessions_with_checkout_3}/NULLIF(${count_sessions},0)::REAL
#    format: "%0.2f%"

#  - measure: perc_sessions_transaction
#    label: SESSIONS - ORDER COMPLETED
#    type: number
#    decimals: 2
#    sql: 100.0 * ${count_sessions_with_transaction}/NULLIF(${count_sessions},0)::REAL
#    format: "%0.2f%"
  
#  - measure: dropout_rate_visitor
#    label: DROPOUT RATE - VISITOR
#    type: number
#    decimals: 2
#    sql: 100.0 * (${perc_all_sessions} - ${perc_sessions_catalog})/NULLIF(${perc_all_sessions},0)::REAL
#    format: "%0.2f%"
  
#  - measure: dropout_rate_catalogue
#    label: DROPOUT RATE - CATALOGUE
#    type: number
#    decimals: 2
#    sql: 100.0 * (${perc_sessions_catalog} - ${perc_sessions_product})/NULLIF(${perc_sessions_catalog},0)::REAL
#    format: "%0.2f%"

#  - measure: dropout_rate_product
#    label: DROPOUT RATE - PRODUCT
#    type: number
#    decimals: 2
#    sql: 100.0 * (${perc_sessions_product} - ${perc_sessions_cart})/NULLIF(${perc_sessions_product},0)::REAL
#    format: "%0.2f%"

#  - measure: dropout_rate_cart
#    label: DROPOUT RATE - CART
#    type: number
#    decimals: 2
#    sql: 100.0 * (${perc_sessions_cart} - ${perc_sessions_checkout_1})/NULLIF(${perc_sessions_cart},0)::REAL
#    format: "%0.2f%"

#  - measure: dropout_rate_checkout
#    label: DROPOUT RATE - CHECKOUT
#    type: number
#    decimals: 2
#    sql: 100.0 * (${perc_sessions_checkout_1} - ${perc_sessions_transaction})/NULLIF(${perc_sessions_checkout_1},0)::REAL
#    format: "%0.2f%"

################################## Web Goals Engagement Stuff ###########################################################

#  - measure: count_registration_sessions
#    label: COUNT SESSIONS WITH REGISTRATION
#    type: count_distinct
#    sql: ${session_id}
#    filters:
#     app_id: production
#     register_success.event_id: -NULL
      
#  - measure: count_newsletter_subscription_sessions
#    type: count_distinct
#    sql: ${session_id}
#    filters:
#     app_id: production
#     newsletter_subscriptions.event_id: -NULL
#    hidden: true

#  - measure: count_engaged_sessions
#    type: count_distinct
#    label: COUNT ENGAGED SESSIONS
#    sql: |
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
#    filters:
#     app_id: production
     
#  - measure: newsletter_subscription_rate
#    label: NEWSLETTER SUBSCRIPTION RATE
#    type: number
#    decimals: 2
#    sql: 100.0 * (${count_newsletter_subscription_sessions})/NULLIF(${count_sessions},0)::REAL
#    format: "%0.2f%"
     
#  - measure: signup_rate
#    label: CREATE ACCOUNT RATE
#    type: number
#    decimals: 2
#    sql: 100.0 * (${count_registration_sessions})/NULLIF(${count_sessions},0)::REAL
#    format: "%0.2f%"
  
#  - measure: engagement_rate
#    label: ENGAGEMENT RATE
#    type: number
#    decimals: 2
#    sql: 100.0 * (${count_engaged_sessions})/NULLIF(${count_sessions},0)::REAL
#    format: "%0.2f%"

############################################################ Page Measures #######################################################################################################

#  - dimension: landing_page_flag
#    type: yesno
#    sql: ${page_url_path} = ${sessions.landing_page_path}
#    hidden: true
  
#  - dimension: exit_page_flag
#    type: yesno
#    sql: ${page_url_path} = ${sessions.exit_page_path}
#    hidden: true
  
#  - measure: count_landed_sessions
#    label: LANDED SESSIONS COUNT
#    type: count_distinct
#    sql: ${session_id}
#    filters:
#      app_id: production
#      landing_page_flag: yes
  
#  - measure: count_exit_sessions
#    label: Exit Sessions Count
#    type: count_distinct
#    sql: ${session_id}
#    filters:
#    app_id: production
#    exit_page_flag: yes
      
#  - measure: page_exit_rate
#    label: Page Exit Rate
#    type: number
#    sql: ${count_exit_sessions}/NULLIF(${count_sessions},0)::REAL
#    value_format: '#.00%'
  
#  - measure: page_bounce_rate
#    label: Page Bounce Rate
#    type: number
#    sql: ${sessions.bounced_sessions_count}/NULLIF(${count_landed_sessions},0)::REAL
#    value_format: '#.00%'