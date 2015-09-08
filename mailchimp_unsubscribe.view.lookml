- view: mailchimp_unsubscribe
  derived_table:
   sql: |
        select
        lower(email) as email, min(unsubscribe_time) as unsubscribe_time, list, max(unsub_campaign_id) as unsub_campaign_id
        from
        (select * from
        (select lower("data.email") as email, min(root_tstamp) as unsubscribe_time, "data.list_id" as list, max("data.campaign_id") as unsub_campaign_id
        from atomic.com_mailchimp_unsubscribe_1
        group by 1,3)
        union
        (select * from finery.mailchimp_snapshot_all_unsubscriptions_24_03_2015))
        group by 1,3

  fields:

  - dimension: email
    sql: ${TABLE}.email
    hidden: true
  
  - dimension: list
    label: List ID
    sql: ${TABLE}.list
    hidden: true
  
  - dimension_group: unsubscribe
    type: time
    timeframes: [time]
    sql: ${TABLE}.unsubscribe_time
    hidden: true

  - dimension: unsubscribe_campaign_id
    sql: ${TABLE}.unsub_campaign_id
    hidden: true

  - measure: count_unsubscriptions
    type: count_distinct
    sql: ${email} || ${list}

  - measure: count_unsubscriptions_from_campaign
    type: count_distinct
    sql: ${email} || ${list}
    filters:
      unsubscribe_campaign_id: -NULL