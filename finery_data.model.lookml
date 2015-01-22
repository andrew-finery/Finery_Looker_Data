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
    join_type: one_to_one

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

- explore: referrals
  joins:
  - join: spree_users
    sql_on: |
      referrals.sent_by_id = spree_users.user_id
  - join: spree_users_2
    sql_on: |
      referrals.id = spree_users_2.invitation_id
  - join: spree_orders
    sql_on: |
      spree_users_2.user_id = spree_orders.customer_id
    

- explore: atomic_events
  joins:
  - join: identity_stitching
    sql_on: |
      identity_stitching.domain_userid = atomic_events.domain_userid
  - join: product_funnel
    sql_on: |
      product_funnel.event_id = atomic_events.event_id

- explore: page_views

- explore: users_signup
  joins:
  - join: spree_orders
    sql_on: |
      spree_orders.customer_id = users_signup.id

- explore: leads

- explore: spree_orders
  joins:
  - join: users_signup
    sql_on: |
      spree_orders.customer_id = users_signup.id
  - join: calendar_weeks
    sql_on: |
      date(spree_orders.completed_at) = calendar_weeks.calendar_date

- explore: spree_stock_items
  joins:
  - join: line_detail_re15
    sql_on: |
      spree_stock_items.sku = line_detail_re15.ean
  - join: sales_snapshot
    sql_on: |
      sales_snapshot.sku = spree_stock_items.sku
  - join: online_products
    sql_on: |
      spree_stock_items.sku = online_products.ean
  - join: product_lookup
    sql_on: |
      spree_stock_items.sku = product_lookup.ean
      
      
- explore: sales_snapshot
  joins:
  - join: spree_stock_items
    sql_on: |
      sales_snapshot.sku = spree_stock_items.sku
  - join: line_detail_re15
    sql_on: |
      sales_snapshot.sku = line_detail_re15.ean
  - join: product_lookup
    sql_on: |
      sales_snapshot.sku = product_lookup.ean
  - join: online_products
    sql_on: |
      sales_snapshot.sku = online_products.ean
      
- explore: spree_order_items
  joins:
  - join: line_detail_re15
    sql_on: |
      spree_order_items.sku = line_detail_re15.ean
  - join: spree_orders
    sql_on: |
      spree_orders.order_id = spree_order_items.order_id
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
      
      
- explore: daily_data

- explore: daily_sales
  joins:
  - join: product_lookup
    sql_on: |
      daily_sales.sku = product_lookup.ean

- explore: weekly_sales
  joins:
  - join: product_lookup
    sql_on: |
      weekly_sales.sku = product_lookup.ean
  - join: online_products
    sql_on: |
      weekly_sales.sku = online_products.ean
      
- explore: opening_stock

- explore: returns
  joins:
  - join: product_lookup
    sql_on: |
      returns.sku = product_lookup.ean
  - join: spree_orders
    sql_on: |
      spree_orders.order_id = returns.order_id
  - join: users_signup
    sql_on: |
      returns.user_id = users_signup.id
  - join: online_products
    sql_on: |
      returns.sku = online_products.ean
      
- explore: online_products

- explore: spree_refunds

- explore: daily_closing_stock

- explore: weekly_closing_stock

- explore: page_view_events

- explore: product_funnel
  joins:
  - join: online_products
    sql_on: |
      product_funnel.product_id = online_products.product_id
  - join: identity_stitching
    sql_on: |
      product_funnel.domain_userid = identity_stitching.domain_userid

- explore: goods_in
  joins:
  - join: product_lookup
    sql_on: |
      goods_in.ean = product_lookup.ean
  - join: calendar_weeks
    sql_on: |
      goods_in.confirm_date = calendar_weeks.calendar_date