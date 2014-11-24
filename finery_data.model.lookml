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

- explore: orders
  joins:
  - join: sessions
    sql_on: |
      sessions.domain_userid = orders.domain_userid
      and sessions.domain_sessionidx = orders.domain_sessionidx
      
- explore: order_items
  joins:
  - join: line_detail_re15
    sql_on: |
      order_items.sku = line_detail_re15.ean

