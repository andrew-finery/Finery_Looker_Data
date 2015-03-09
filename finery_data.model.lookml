- connection: finery-redshift

- scoping: true                  # for backward compatibility
- include: "*.view.lookml"       # include all the views
- include: "*.dashboard.lookml"  # include all the dashboards

- explore: sessions
  joins: 
  - join: visitors
    sql_on: |
      sessions.domain_userid = visitors.domain_userid
  - join: payment_funnel
    sql_on: |
      sessions.domain_userid = payment_funnel.domain_userid and sessions.domain_sessionidx = payment_funnel.domain_sessionidx

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
    sql_on: |
      identity_stitching.domain_userid = atomic_events.domain_userid
  - join: product_funnel
    sql_on: |
      product_funnel.event_id = atomic_events.event_id
  - join: transactions
    sql_on: |
      transactions.event_id = atomic_events.event_id
  - join: page_view_events
    sql_on: |
      page_view_events.event_id = atomic_events.event_id
  - join: email_subscriptions
    sql_on: |
      email_subscriptions.root_id = atomic_events.event_id
  - join: register_success
    sql_on: |
      register_success.root_id = atomic_events.event_id
  - join: sessions_source
    sql_on: |
      sessions_source.domain_userid = atomic_events.domain_userid
      and sessions_source.domain_sessionidx = atomic_events.domain_sessionidx
  - join: newsletter_subscriptions
    sql_on: |
      newsletter_subscriptions.root_id = atomic_events.event_id
  - join: email_campaign_lookup
    sql_on: atomic_events.se_label = email_campaign_lookup.email_id
    
- explore: page_views

- explore: users_signup
  joins:
  - join: spree_orders
    sql_on: spree_orders.customer_id = users_signup.id
  - join: hermes_delivery_tracking
    sql_on: hermes_delivery_tracking.tracking_code = concat(spree_orders.tracking_number,'a')
  - join: spree_addresses
    sql_on: spree_orders.ship_address_id = spree_addresses.address_id
  
- explore: leads

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
    
- explore: sales_snapshot
  joins:
  - join: product_lookup
    sql_on: |
      sales_snapshot.sku = product_lookup.ean
  - join: online_products
    sql_on: |
      sales_snapshot.sku = online_products.ean
      
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

- explore: weekly_sales
  joins:
  - join: product_lookup
    sql_on: |
      weekly_sales.sku = product_lookup.ean
  - join: online_products
    sql_on: |
      weekly_sales.sku = online_products.ean

- explore: returns
  joins:
  - join: product_lookup
    sql_on: |
      returns.sku = product_lookup.ean
  - join: online_products
    sql_on: |
      returns.sku = online_products.ean
  - join: spree_orders
    sql_on: spree_orders.order_id = returns.order_id
  - join: hermes_delivery_tracking
    sql_on: hermes_delivery_tracking.tracking_code = concat(spree_orders.tracking_number,'a')
  - join: spree_addresses
    sql_on: spree_orders.ship_address_id = spree_addresses.address_id
  - join: users_signup
    sql_on: |
      returns.user_id = users_signup.id

- explore: spree_refunds

- explore: page_view_events

- explore: product_funnel
  joins:
  - join: online_products
    sql_on: |
      product_funnel.product_id = online_products.product_id
  - join: identity_stitching
    sql_on: |
      product_funnel.domain_userid = identity_stitching.domain_userid
  - join: product_lookup
    sql_on: |
      product_lookup.ean = online_products.ean
  - join: calendar_weeks
    sql_on: |
      date(product_funnel.collector_tstamp) = calendar_weeks.calendar_date

- explore: goods_in
  joins:
  - join: product_lookup
    sql_on: |
      goods_in.ean = product_lookup.ean
  - join: calendar_weeks
    sql_on: |
      goods_in.confirm_date = calendar_weeks.calendar_date
  - join: online_products
    sql_on: |
      goods_in.ean = online_products.ean

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