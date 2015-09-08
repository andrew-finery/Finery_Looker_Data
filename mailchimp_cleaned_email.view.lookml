- view: mailchimp_cleaned_email
  derived_table:
   sql: |
        select
        lower(email) as email, min(cleaned_time) as cleaned_time, list, max(cleaned_campaign_id) as cleaned_campaign_id
        from
        (select * from
        (select lower("data.email") as email, min(convert_timezone('UTC', 'Europe/London', root_tstamp)) as cleaned_time, "data.list_id" as list, max("data.campaign_id") as cleaned_campaign_id
        from atomic.com_mailchimp_cleaned_email_1
        group by 1,3)
        union
        (select * from finery.mailchimp_snapshot_all_cleaned_24_03_2015))
        group by 1,3

  fields:

  - dimension: email
    sql: ${TABLE}.email
    hidden: true
  
  - dimension: list
    label: List ID
    sql: ${TABLE}.list
    hidden: true
  
  - dimension_group: email_cleaned
    type: time
    timeframes: [time]
    sql: ${TABLE}.cleaned_time
    hidden: true

  - dimension: cleaned_campaign_id
    sql: ${TABLE}.cleaned_campaign_id
    hidden: true
  
  - measure: count_cleaned_emails
    type: count_distinct
    sql: ${email} || ${list}