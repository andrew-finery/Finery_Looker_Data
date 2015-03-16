- view: all_newsletter_subscribers
  derived_table:
   sql: |
        select email, min(message_sent_at) as message_sent_at from
        (select * from
        (select lower("data.email") as email, root_tstamp as message_sent_at from atomic.com_mailchimp_subscribe_1 where "data.list_id" = '179a8621fb')
        union
        (select lower(email) as email, confirm_time as message_sent_at from finery.newsletter_snapshot_03_03)
        )
        group by 1

   sql_trigger_value: SELECT max(root_tstamp) FROM atomic.com_mailchimp_subscribe_1
   distkey: email
   sortkeys: [email]

  fields:

  - dimension: email
    sql: ${TABLE}.email
    hidden: true
  
  - dimension_group: newsletter_subscription
    label: NEWSLETTER SUBSCRIPTION
    type: time
    timeframes: [date, week, month]
    sql: ${TABLE}.message_sent_at 
  
  - dimension: time_to_convert
    sql: case when ${spree_customers.first_order_date} - ${newsletter_subscription_date} < 0 then 0 else ${spree_customers.first_order_date} - ${newsletter_subscription_date} end
    hidden: true

  - dimension: time_to_convert_tier
    label: CONVERSION DAYS TIER
    type: tier
    tiers: [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29]
    sql: ${time_to_convert}
  
  - measure: count_newsletter_subscribers
    label: NEWSLETTER SUBSCRIBERS
    type: count_distinct
    sql: ${email}

  - measure: count_converted
    label: NEWSLETTER SUBSCRIBERS CONVERTED
    type: count_distinct
    sql: ${spree_customers.email}

  - measure: conversion_percentage
    label: NEWSLETTER CONVERSION %
    type: number
    decimals: 2
    sql: 100.0 * ${count_converted}/${count_newsletter_subscribers}::REAL
    format: "%0.2f%"

  - measure: running_total_converted
    label: NEWSLETTER SUBSCRIBERS CONVERTED - RUNNING TOTAL
    type: running_total
    sql: ${count_converted}
    direction: column
    
    
    
    