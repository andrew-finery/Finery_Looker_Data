- view: newsletter_subscriptions
  sql_table_name: atomic.com_finerylondon_newsletter_subscription_1

  fields:
  
  - dimension: event_id
    sql: ${TABLE}.root_id
    hidden: true

  - dimension: email
    sql: ${TABLE}.email
    hidden: true
    