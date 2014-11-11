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
  joins: 
  - join: sessions_last_page
    sql_on: |
      sessions_last_page.event_id = page_views.event_id




