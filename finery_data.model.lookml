- connection: finery-redshift

- scoping: true                  # for backward compatibility
- include: "*.view.lookml"       # include all the views
- include: "*.dashboard.lookml"  # include all the dashboards

- explore: sessions
  symmetric_aggregates: true 
  joins: 
  - join: visitors
    sql_on: ${sessions.blended_user_id} = ${visitors.blended_user_id}
    relationship: many_to_one
  - join: transactions
    sql_on: ${transactions.domain_userid} = ${sessions.domain_user_id} and ${transactions.domain_sessionidx} = ${sessions.domain_session_index}
    relationship: one_to_many
  - join: session_start_calendar
    from: calendar_weeks
    sql_on: ${session_start_calendar.calendar_date_date} = ${sessions.start_date}
    relationship: many_to_one
  - join: email_campaign_tests
    from: mc_campaigns_tests
    sql_on: ${email_campaign_tests.test_id} = ${sessions.campaign_name}
    relationship: many_to_one
  - join: email_campaigns
    from: mc_campaigns
    sql_on: ${email_campaigns.campaign_id} = ${email_campaign_tests.campaign_id}
    relationship: many_to_one


- explore: website_products
  from: website_product_stats
  joins:
  - join: visits
    from: sessions
    sql_on: ${website_products.domain_userid} = ${visits.domain_user_id} and ${website_products.domain_sessionidx} = ${visits.domain_session_index}    
    relationship: many_to_one
  - join: product_info
    from: spree_products
    sql_on: ${website_products.id} = ${product_info.product_id} 
    relationship: many_to_one
    
- explore: snowplow_transaction_attribution
  joins:
  - join: transactions
    sql_on: ${snowplow_transaction_attribution.order_id} = ${transactions.order_id}
    relationship: many_to_one
  - join: sessions
    sql_on: ${snowplow_transaction_attribution.user_id} = ${sessions.domain_user_id} and ${snowplow_transaction_attribution.domain_session_index} = ${sessions.domain_session_index}
    relationship: many_to_one
    
- explore: facebook_daily_ad_performance

- explore: fb_automated_ads_creatives

- explore: facebook_daily_ad_performance_1day
  joins:
  - join: facebook_daily_ad_reach
    sql_on: ${facebook_daily_ad_performance_1day.date} = ${facebook_daily_ad_reach.date} and ${facebook_daily_ad_performance_1day.adset} = ${facebook_daily_ad_reach.add_id}
    relationship: one_to_one

- explore: spree_customers
  joins:
#  - join: all_newsletter_subscribers
#    sql_on: all_newsletter_subscribers.email = spree_customers.email
#    relationship: one_to_one
  - join: visitors
    sql_on: spree_customers.email = ${visitors.email_address}
    relationship: one_to_one

- explore: fb_daily_ad_performance
  label: 'Facebook Perfomance'
  joins:
  - join: 1_day_click_through
    from: fb_daily_ad_perf_1day_click
    sql_on: ${fb_daily_ad_performance.calendar_date} = ${1_day_click_through.calendar_date} and ${fb_daily_ad_performance.ad} = ${1_day_click_through.ad}
    relationship: one_to_one
  - join: 7_day_click_through
    from: fb_daily_ad_perf_7day_click
    sql_on: ${fb_daily_ad_performance.calendar_date} = ${7_day_click_through.calendar_date} and ${fb_daily_ad_performance.ad} = ${7_day_click_through.ad}
    relationship: one_to_one
  - join: 28_day_click_through
    from: fb_daily_ad_perf_28day_click
    sql_on: ${fb_daily_ad_performance.calendar_date} = ${28_day_click_through.calendar_date} and ${fb_daily_ad_performance.ad} = ${28_day_click_through.ad}
    relationship: one_to_one


#- explore: atomic_events
#  fields: [ALL_FIELDS]
#  joins:
#  - join: transactions
#    sql_on: transactions.event_id = atomic_events.event_id
#    relationship: one_to_one
#  - join: email_subscriptions
#    sql_on: email_subscriptions.root_id = atomic_events.event_id
#    relationship: one_to_one
#  - join: newsletter_subscriptions
#    sql_on: newsletter_subscriptions.root_id = atomic_events.event_id
#    relationship: one_to_one
#  - join: sessions
#    sql_on: sessions.domain_userid = atomic_events.domain_userid and sessions.domain_sessionidx = atomic_events.domain_sessionidx
#    relationship: many_to_one
#  - join: mailchimp_campaigns_1
#    from: mailchimp_campaigns
#    sql_on: atomic_events.se_label = mailchimp_campaigns_1.email_id
#    relationship: many_to_one
#  - join: mailchimp_campaigns_2
#    from: mailchimp_campaigns
#    sql_on: sessions.mkt_campaign_ga = mailchimp_campaigns_2.email_id
#    relationship: many_to_one
#  - join: spree_products
#    from: spree_products
#    sql_on: ${atomic_events.product_id} = ${spree_products.product_id}
#    relationship: many_to_one
#  - join: snowplow_link_clicks
#    sql_on: ${atomic_events.event_id} = ${snowplow_link_clicks.root_id}
#    relationship: many_to_one
#  - join: event_calendar
#    from: calendar_weeks
#    sql_on: ${event_calendar.calendar_date_date} = ${atomic_events.event_time_date}
#    relationship: many_to_one

- explore: spree_users
    
- explore: spree_orders
  joins:
  - join: calendar_weeks
    sql_on: date(spree_orders.completed_at) = calendar_weeks.calendar_date
    relationship: many_to_one
  - join: spree_users
    sql_on: spree_orders.customer_id = spree_users.user_id
    relationship: many_to_one
  - join: spree_addresses
    sql_on: spree_orders.ship_address_id = spree_addresses.address_id
    relationship: many_to_one
  - join: spree_customers
    sql_on: spree_customers.email = spree_orders.blended_email
    relationship: many_to_one
  - join: all_referrals
    sql_on: spree_orders.blended_email = all_referrals.email
    relationship: many_to_one

- explore: spree_order_items
  fields: [ALL_FIELDS*, -online_products.option_for_returns_report]
  always_join: [spree_orders]
  joins:
  - join: spree_orders
    sql_on: spree_orders.order_id = spree_order_items.order_id
    relationship: many_to_one
  - join: spree_customers
    sql_on: spree_customers.email = spree_orders.blended_email
    relationship: many_to_one
  - join: spree_users
    sql_on: spree_orders.customer_id = spree_users.user_id
    relationship: many_to_one
  - join: hermes_delivery_tracking
    sql_on: hermes_delivery_tracking.tracking_code = concat(spree_orders.tracking_number,'a')
    relationship: one_to_one
  - join: spree_addresses
    sql_on: spree_orders.ship_address_id = spree_addresses.address_id
    relationship: many_to_one
  - join: online_products
    sql_on: spree_order_items.sku  = online_products.ean
    relationship: many_to_one
  - join: product_lookup
    sql_on: spree_order_items.sku = product_lookup.ean
    relationship: many_to_one
  - join: calendar_weeks
    sql_on: date(spree_order_items.order_tstamp) = calendar_weeks.calendar_date
    relationship: many_to_one

- explore: daily_sales
  fields: [ALL_FIELDS*, -online_products.option_for_returns_report]
  joins:
  - join: product_lookup
    sql_on: daily_sales.sku = product_lookup.ean
    relationship: many_to_one
  - join: online_products
    sql_on: daily_sales.sku = online_products.ean
    relationship: many_to_one
  - join: calendar_weeks
    sql_on: ${daily_sales.calendar_date_date} = ${calendar_weeks.calendar_date_date}
    relationship: many_to_one
  - join: variant_info_daily
    from: spree_variant_info_daily
    sql_on: ${daily_sales.calendar_date_date} = ${variant_info_daily.calendar_date} and ${daily_sales.sku} = ${variant_info_daily.ean}
    relationship: one_to_one
    
- explore: mandrill_email_summary
    
- explore: spree_refunds
  joins:
  - join: spree_orders
    sql_on: ${spree_orders.order_id} = ${spree_refunds.order_id}
    relationship: many_to_one
  - join: spree_addresses
    sql_on: ${spree_orders.ship_address_id} = ${spree_addresses.address_id}
    relationship: many_to_one
    
- explore: goods_in
  fields: [ALL_FIELDS*, -online_products.option_for_returns_report]
  joins:
  - join: product_lookup
    sql_on: goods_in.ean = product_lookup.ean
    relationship: many_to_one
  - join: calendar_weeks
    sql_on: goods_in.confirm_date = calendar_weeks.calendar_date
    relationship: many_to_one
  - join: online_products
    sql_on: goods_in.ean = online_products.ean
    relationship: many_to_one

#- explore: all_newsletter_subscribers
#  joins:
#  - join: spree_customers
#    sql_on: all_newsletter_subscribers.email = spree_customers.email
#    relationship: one_to_one
#  - join: visitors
#    sql_on: all_newsletter_subscribers.email = ${visitors.email_address}
#    relationship: one_to_one
    
- explore: all_referrals
  joins:
  - join: spree_customers
    sql_on: all_referrals.email = spree_customers.email
    relationship: one_to_one
  - join: visitors
    sql_on: all_referrals.email = ${visitors.email_address}
    relationship: one_to_one

- explore: snowplow_product_click_through_daily
  joins:
  - join: spree_products
    sql_on: ${snowplow_product_click_through_daily.product_id} = ${spree_products.product_id}
    relationship: many_to_one
  - join: spree_product_info_daily
    sql_on: ${snowplow_product_click_through_daily.product_id} = ${spree_product_info_daily.product_id} and ${snowplow_product_click_through_daily.impression_date_date} = ${spree_product_info_daily.calendar_date}
    relationship: one_to_one

- explore: daily_option_info
  joins:
  - join: spree_products
    sql_on: ${daily_option_info.product_id} = ${spree_products.product_id}
    relationship: many_to_one
    
#- explore: mailchimp_subscribe
#  joins:
#  - join: mailchimp_unsubscribe
#    sql_on: ${mailchimp_subscribe.email} = ${mailchimp_unsubscribe.email} and ${mailchimp_subscribe.list} = ${mailchimp_unsubscribe.list}
#    relationship: one_to_one
#  - join: mailchimp_cleaned_email
#    sql_on: ${mailchimp_subscribe.email} = ${mailchimp_cleaned_email.email} and ${mailchimp_subscribe.list} = ${mailchimp_cleaned_email.list}
#    relationship: one_to_one

#- explore: mailchimp_campaigns
#  joins:
#  - join: mailchimp_unsubscribe
#    sql_on: ${mailchimp_unsubscribe.unsubscribe_campaign_id} = ${mailchimp_campaigns.campaign_id}
#    relationship: one_to_many
#  - join: mailchimp_cleaned_email
#    sql_on: ${mailchimp_cleaned_email.cleaned_campaign_id} = ${mailchimp_campaigns.campaign_id}
#    relationship: one_to_many

- explore: visitors
  joins:
  - join: customers
    from: spree_customers
    sql_on: ${customers.email} = ${visitors.email_address}
    relationship: one_to_one
    
- explore: spree_cms_product_information

- explore: website_page_views
  joins:
  - join: visits
    from: sessions
    sql_on: ${website_page_views.domain_userid} = ${visits.domain_user_id} and ${website_page_views.domain_sessionidx} = ${visits.domain_session_index}    
    relationship: many_to_one
    


- explore: mc_newsletter_subscribers
  label:  'Mailchimp Newsletter Subscribers'
  description: 'Finery newsletter subscriber information'
  joins:
  - join: customer_info
    from: spree_customers
    sql_on: ${mc_newsletter_subscribers.email_address} = ${customer_info.email}
    relationship: one_to_one
  - join: web_visitor_info
    from: visitors
    sql_on: ${mc_newsletter_subscribers.email_address} = ${web_visitor_info.email_address}
    relationship: one_to_one

- explore: mc_campaign_member_activity
  label:  'Mailchimp Newsletter Subscriber Activity'
  description: 'Finery newsletter subscriber activity'
  joins:
  - join: newsletter_subscribers
    from: mc_newsletter_subscribers
    type: inner
    sql_on: ${newsletter_subscribers.email_address} = ${mc_campaign_member_activity.email_address}
    relationship: many_to_one
  - join: email_campaign_tests
    from: mc_campaigns_tests
    sql_on: ${email_campaign_tests.test_id} = ${mc_campaign_member_activity.campaign_id}
    relationship: many_to_one
  - join: email_campaigns
    from: mc_campaigns
    sql_on: ${email_campaigns.campaign_id} = ${mc_campaign_member_activity.campaign_id}
    relationship: many_to_one

- explore: mc_campaigns
  label:  'Mailchimp Campaigns'
  description: 'Finery Mailchimp account campaign information'


- explore: scripts_bi_server
- explore: redshift_load_errors
- explore: redshift_snowplow_loads
