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

   sql_trigger_value: SELECT max(spree_timestamp) FROM atomic.com_mailchimp_subscribe_1
   distkey: email
   sortkeys: [email]

  fields:

  - dimension: email
    sql: ${TABLE}.email
  
  - dimension_group: referral_time
    label: REFERRAL
    type: time
    timeframes: [date, week, month]
    sql: ${TABLE}.message_sent_at 
  
  - measure: count_referrals
    type: count_distinct
    sql: ${email}
