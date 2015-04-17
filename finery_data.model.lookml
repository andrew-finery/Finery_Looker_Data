- connection: finery-redshift

- scoping: true                  # for backward compatibility
- include: "*.view.lookml"       # include all the views
- include: "*.dashboard.lookml"  # include all the dashboards

- explore: sessions
  joins: 
  - join: visitors
    sql_on: ${sessions.blended_user_id} = ${visitors.blended_user_id}
  - join: transactions
    sql_on: ${transactions.domain_userid} = ${sessions.user_id} and ${transactions.domain_sessionidx} = ${sessions.domain_session_index}
    relationship: one_to_many

- explore: snowplow_transaction_attribution
  joins:
  - join: transactions
    sql_on: ${snowplow_transaction_attribution.order_id} = ${transactions.order_id}
  - join: sessions
    sql_on: ${snowplow_transaction_attribution.user_id} = ${sessions.user_id} and ${snowplow_transaction_attribution.domain_session_index} = ${sessions.domain_session_index}

- explore: events
  joins:
  - join: identity_stitching
    sql_on: |
      identity_stitching.domain_userid = events.domain_userid
      
- explore: spree_invitations
  joins:
  - join: spree_users
    sql_on: |
      lower(spree_invitations.email) = lower(spree_users.email_address)

- explore: spree_users
  joins:
  - join: spree_orders
    sql_on: spree_orders.customer_id = spree_users.user_id
  - join: hermes_delivery_tracking
    sql_on: hermes_delivery_tracking.tracking_code = concat(spree_orders.tracking_number,'a')
  - join: spree_addresses
    sql_on: spree_orders.ship_address_id = spree_addresses.address_id

- explore: referrals
  joins:
  - join: spree_users
    sql_on: |
      referrals.sent_by_id = spree_users.user_id
  - join: spree_users_2
    sql_on: |
      referrals.id = spree_users_2.invitation_id
  - join: spree_orders
    sql_on: spree_users_2.user_id = spree_orders.customer_id
  - join: hermes_delivery_tracking
    sql_on: hermes_delivery_tracking.tracking_code = concat(spree_orders.tracking_number,'a')
  - join: spree_addresses
    sql_on: spree_orders.ship_address_id = spree_addresses.address_id

- explore: atomic_events
  joins:
  - join: identity_stitching
    sql_on: identity_stitching.domain_userid = atomic_events.domain_userid
  - join: transactions
    sql_on: transactions.event_id = atomic_events.event_id
  - join: page_contexts
    sql_on: page_contexts.root_id = atomic_events.event_id
  - join: email_subscriptions
    sql_on: email_subscriptions.root_id = atomic_events.event_id
  - join: register_success
    sql_on: register_success.root_id = atomic_events.event_id
  - join: newsletter_subscriptions
    sql_on: newsletter_subscriptions.root_id = atomic_events.event_id
  - join: spree_exchange_rates
    sql_on: spree_exchange_rates.currency = transactions.currency_code and spree_exchange_rates.calendar_date = date(transactions.collector_tstamp)
  - join: sessions
    sql_on: sessions.domain_userid = atomic_events.domain_userid and sessions.domain_sessionidx = atomic_events.domain_sessionidx
  - join: product_impressions
    sql_on: product_impressions.root_id = atomic_events.event_id
  - join: product_clicked
    sql_on: product_clicked.root_id = atomic_events.event_id
  - join: product_quick_views
    sql_on: product_quick_views.root_id = atomic_events.event_id   
  - join: product_in_cart
    sql_on: product_in_cart.root_id = atomic_events.event_id
  - join: product_in_transaction
    sql_on: product_in_transaction.root_id = atomic_events.event_id
  - join: product_in_checkout
    sql_on: product_in_checkout.root_id = atomic_events.event_id
    
  - join: mailchimp_campaigns_1
    from: mailchimp_campaigns
    sql_on: atomic_events.se_label = mailchimp_campaigns_1.email_id
  - join: mailchimp_campaigns_2
    from: mailchimp_campaigns
    sql_on: sessions.mkt_campaign_ga = mailchimp_campaigns_2.email_id

  - join: spree_products
    from: spree_products
    sql_on: ${atomic_events.product_id} = ${spree_products.product_id}


- explore: users_signup
  joins:
  - join: spree_orders
    sql_on: spree_orders.customer_id = users_signup.id
  - join: hermes_delivery_tracking
    sql_on: hermes_delivery_tracking.tracking_code = concat(spree_orders.tracking_number,'a')
  - join: spree_addresses
    sql_on: spree_orders.ship_address_id = spree_addresses.address_id


- explore: spree_orders
  joins:
  - join: calendar_weeks
    sql_on: date(spree_orders.completed_at) = calendar_weeks.calendar_date
  - join: hermes_delivery_tracking
    sql_on: hermes_delivery_tracking.tracking_code = concat(spree_orders.tracking_number,'a')
  - join: spree_users
    sql_on: spree_orders.customer_id = spree_users.user_id
  - join: spree_addresses
    sql_on: spree_orders.ship_address_id = spree_addresses.address_id
  - join: spree_customers
    sql_on: spree_customers.email = spree_orders.blended_email
  - join: all_referrals
    sql_on: spree_orders.blended_email = all_referrals.email
  - join: spree_orders_promotions
    sql_on: spree_orders.order_id = spree_orders_promotions.order_id

- explore: spree_order_items
  joins:
  - join: spree_orders
    sql_on: spree_orders.order_id = spree_order_items.order_id
    relationship: many_to_one
  - join: hermes_delivery_tracking
    sql_on: hermes_delivery_tracking.tracking_code = concat(spree_orders.tracking_number,'a')
    relationship: one_to_one
  - join: spree_addresses
    sql_on: spree_orders.ship_address_id = spree_addresses.address_id
    relationship: many_to_one
  - join: users_signup
    sql_on: |
      spree_orders.customer_id = users_signup.id
  - join: online_products
    sql_on: |
      spree_order_items.sku  = online_products.ean
  - join: product_lookup
    sql_on: |
      spree_order_items.sku = product_lookup.ean
  - join: calendar_weeks
    sql_on: |
      date(spree_order_items.order_tstamp) = calendar_weeks.calendar_date

- explore: daily_sales
  joins:
  - join: product_lookup
    sql_on: |
      daily_sales.sku = product_lookup.ean
  - join: online_products
    sql_on: |
      daily_sales.sku = online_products.ean
  - join: calendar_weeks
    sql_on: ${daily_sales.calendar_date_date} = ${calendar_weeks.calendar_date_date}

- explore: returns
  joins:
  - join: product_lookup
    sql_on: |
      returns.sku = product_lookup.ean
  - join: online_products
    sql_on: |
      returns.sku = online_products.ean
      
- explore: spree_refunds

- explore: goods_in
  joins:
  - join: product_lookup
    sql_on: goods_in.ean = product_lookup.ean
  - join: calendar_weeks
    sql_on: goods_in.confirm_date = calendar_weeks.calendar_date
  - join: online_products
    sql_on: goods_in.ean = online_products.ean

- explore: goods_commitment
  joins:
  - join: product_lookup
    sql_on: |
      goods_commitment.ean = product_lookup.ean
  - join: online_products
    sql_on: |
      goods_commitment.ean = online_products.ean

- explore: all_newsletter_subscribers
  joins:
  - join: spree_customers
    sql_on: all_newsletter_subscribers.email = spree_customers.email
    relationship: one_to_one

- explore: all_referrals
  joins:
  - join: spree_customers
    sql_on: all_referrals.email = spree_customers.email
    relationship: one_to_one

- explore: snowplow_product_click_through_daily
  joins:
  - join: spree_products
    sql_on: ${snowplow_product_click_through_daily.product_id} = ${spree_products.product_id}

- explore: daily_option_info
  joins:
  - join: spree_products
    sql_on: ${daily_option_info.product_id} = ${spree_products.product_id}
    
- explore: mailchimp_subscribe
  joins:
  - join: mailchimp_unsubscribe
    sql_on: ${mailchimp_subscribe.email} = ${mailchimp_unsubscribe.email} and ${mailchimp_subscribe.list} = ${mailchimp_unsubscribe.list}
  - join: mailchimp_cleaned_email
    sql_on: ${mailchimp_subscribe.email} = ${mailchimp_cleaned_email.email} and ${mailchimp_subscribe.list} = ${mailchimp_cleaned_email.list}

- explore: mailchimp_campaigns
  joins:
  - join: mailchimp_unsubscribe
    sql_on: ${mailchimp_unsubscribe.unsubscribe_campaign_id} = ${mailchimp_campaigns.campaign_id}
  - join: mailchimp_cleaned_email
    sql_on: ${mailchimp_cleaned_email.cleaned_campaign_id} = ${mailchimp_campaigns.campaign_id}

- explore: visitors
  joins:
  - join: transactions
    sql_on: ${visitors.blended_user_id} = ${transactions.blended_user_id}
  - join: spree_exchange_rates
    sql_on: ${spree_exchange_rates.currency} = ${transactions.currency_code} and ${spree_exchange_rates.date} = ${transactions.trans_time_date}    