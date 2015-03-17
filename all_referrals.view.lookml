- view: all_referrals
  derived_table:
   sql: |
        select email, min(message_sent_at) as message_sent_at from
        (select * from
        (select lower(email_address) as email, "date" as message_sent_at from mandrill.referrals)
        union
        (select lower("msg.email") as email, "msg.ts" as message_sent_at from atomic.com_mandrill_message_sent_1 where "msg.subject" like '%exclusive invitation%')
        union
        (select lower("data.email") as email, root_tstamp as message_sent_at from atomic.com_mailchimp_subscribe_1 where "data.list_id" = 'de06e9bf29')
        union
        (select lower(email) as email, confirm_time as message_sent_at from finery.referrals_snapshot_03_03)
        )
        group by 1

   sql_trigger_value: SELECT max(root_tstamp) FROM atomic.com_mailchimp_subscribe_1
   distkey: email
   sortkeys: [email]

  fields:

  - dimension: email
    sql: ${TABLE}.email
    hidden: true
    
  - dimension_group: referral
    label: REFERRAL
    type: time
    timeframes: [date, week, month]
    sql: ${TABLE}.message_sent_at 
  
  - dimension: customer_referred_flag
    label: CUSTOMER REFERRED FLAG
    type: yesno
    sql: ${email} is not null
  
  - dimension: time_to_convert
    sql: case when ${spree_customers.first_order_date} - ${referral_date} < 0 then 0 else ${spree_customers.first_order_date} - ${referral_date} end
    hidden: true

  - dimension: time_to_convert_tier
    label: CONVERSION DAYS TIER
    type: tier
    tiers: [0,1,2,3,4,5,6,7,8,15,22,29]
    sql: ${time_to_convert}
  
  - measure: count_referrals
    label: REFERRALS
    type: count_distinct
    sql: ${email}

  - measure: count_converted
    label: REFERRALS CONVERTED
    type: count_distinct
    sql: ${spree_customers.email}

  - measure: conversion_percentage
    label: REFERRAL CONVERSION %
    type: number
    decimals: 2
    sql: 100.0 * ${count_converted}/${count_referrals}::REAL
    format: "%0.2f%"

  - measure: running_total_converted
    label: REFERRALS CONVERTED - RUNNING TOTAL
    type: running_total
    sql: ${count_converted}
    direction: column
