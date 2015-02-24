- view: newsletter_subscriptions
  derived_table:
    sql: |
        SELECT root_id,
               root_tstamp,
               email
        FROM atomic.com_finerylondon_newsletter_subscription_1 newsletter
          LEFT JOIN atomic.events events ON events.event_id = newsletter.root_id
        WHERE events.app_id = ' production'

  fields:
  
  - dimension: event_id
    sql: ${TABLE}.root_id
    hidden: true
    
  - dimension: event_time
    type: time
    sql: ${TABLE}.root_tstamp
    hidden: true

  - measure: newsletter_subscriptions
    type: count_distinct
    sql: ${TABLE}.email
