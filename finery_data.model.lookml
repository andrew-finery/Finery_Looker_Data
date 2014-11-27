- connection: finery-redshift

- scoping: true                  # for backward compatibility
- include: "*.view.lookml"       # include all the views
- include: "*.dashboard.lookml"  # include all the dashboards

- explore: sessions
  joins: 
  - join: visitors
    sql_on: |
      sessions.domain_userid = visitors.domain_userid

- explore: visitors

- explore: page_views

- explore: users_signup

- explore: leads

- explore: spree_orders
  joins:
  - join: users_signup
    sql_on: |
      spree_orders.customer_id = users_signup.id

- explore: spree_order_items
  joins:
  - join: line_detail_re15
    sql_on: |
      spree_order_items.sku = line_detail_re15.ean
  - join: users_signup
    sql_on: |
      spree_order_items.customer_id = users_signup.id
      
- explore: spree_stock_items
  joins:
  - join: line_detail_re15
    sql_on: |
      spree_stock_items.sku = line_detail_re15.ean
      
      
- explore: sales_snapshot
  joins:
  - join: line_detail_re15
    sql_on: |
      sales_snapshot.sku = line_detail_re15.ean
