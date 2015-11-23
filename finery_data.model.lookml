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
  - join: pages
    from: website_page_views
    sql_on: ${pages.domain_userid} = ${sessions.domain_user_id} and ${pages.domain_sessionidx} = ${sessions.domain_session_index}
    relationship: one_to_many
  - join: order_items
    from: website_order_items
    sql_on: ${order_items.domain_userid} = ${sessions.domain_user_id} and ${order_items.domain_sessionidx} = ${sessions.domain_session_index} and ${orders.order_id} = ${order_items.order_id}
    relationship: one_to_many

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
    
- explore: facebook_daily_performance

#- explore: spree_users
#  joins:
#  - join: spree_orders
#    sql_on: spree_orders.customer_id = spree_users.user_id
#    relationship: one_to_many
#  - join: spree_addresses
#    sql_on: spree_orders.ship_address_id = spree_addresses.address_id
#    relationship: one_to_many

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

- explore: all_newsletter_subscribers
  joins:
  - join: spree_customers
    sql_on: all_newsletter_subscribers.email = spree_customers.email
    relationship: one_to_one
  - join: spree_orders
    sql_on: spree_orders.email = all_newsletter_subscribers.email
    relationship: one_to_many
    
- explore: all_referrals
  joins:
  - join: spree_customers
    sql_on: all_referrals.email = spree_customers.email
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
    
- explore: mailchimp_subscribe
  joins:
  - join: mailchimp_unsubscribe
    sql_on: ${mailchimp_subscribe.email} = ${mailchimp_unsubscribe.email} and ${mailchimp_subscribe.list} = ${mailchimp_unsubscribe.list}
    relationship: one_to_one
  - join: mailchimp_cleaned_email
    sql_on: ${mailchimp_subscribe.email} = ${mailchimp_cleaned_email.email} and ${mailchimp_subscribe.list} = ${mailchimp_cleaned_email.list}
    relationship: one_to_one

- explore: mailchimp_campaigns
  joins:
  - join: mailchimp_unsubscribe
    sql_on: ${mailchimp_unsubscribe.unsubscribe_campaign_id} = ${mailchimp_campaigns.campaign_id}
    relationship: one_to_many
  - join: mailchimp_cleaned_email
    sql_on: ${mailchimp_cleaned_email.cleaned_campaign_id} = ${mailchimp_campaigns.campaign_id}
    relationship: one_to_many
- explore: visitors

- explore: spree_cms_product_information

- explore: website_page_views
  joins:
  - join: visits
    from: sessions
    sql_on: ${website_page_views.domain_userid} = ${visits.domain_user_id} and ${website_page_views.domain_sessionidx} = ${visits.domain_session_index}    
    relationship: many_to_one
