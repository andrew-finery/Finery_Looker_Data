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
    sql: |
      left join ${sessions.SQL_TABLE_NAME} AS sessions
      on sessions.domain_userid = orders.domain_userid
      and sessions.domain_sessionidx = orders.domain_sessionidx



