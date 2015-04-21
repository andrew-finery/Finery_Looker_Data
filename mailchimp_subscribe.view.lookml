- view: mailchimp_subscribe
  derived_table:
   sql: |
        select
        lower(email) as email, min(subscribe_time) as subscribe_time, list
        from
        (select * from
        (select lower("data.email") as email, min(convert_timezone('UTC', 'Europe/London', root_tstamp)) as subscribe_time, "data.list_id" as list
        from atomic.com_mailchimp_subscribe_1
        group by 1,3)
        union
        (select * from finery.mailchimp_snapshot_all_subscribers_24_03_2015)
        union
        (select * from finery.mailchimp_snapshot_newsletter_subscribers_02_04_2015))
        group by 1,3

  fields:

    ###########################################################################################################################################
  ####################################################  DIMENSIONS  #########################################################################
###########################################################################################################################################

  - dimension: email
    label: EMAIL
    sql: ${TABLE}.email
    hidden: true

  - dimension: email_list
    label: EMAIL LIST
    sql_case:
      Newsletter Subscribers: ${TABLE}.list = '179a8621fb'
      Newsletter Welcome Chain: ${TABLE}.list = '292b2aee8e'
      Create Account Welcome Chain: ${TABLE}.list = '4666d51b64'
      Referral Welcome Chain: ${TABLE}.list = 'de06e9bf29'
      else: Other
  
  - dimension: list
    label: LIST ID
    sql: ${TABLE}.list
    hidden: true
  
  - dimension_group: subscribe_time
    label: SUBSCRIBED
    type: time
    timeframes: [time, date, week]
    sql: ${TABLE}.subscribe_time


    ###########################################################################################################################################
  ####################################################  MEASURES  ###########################################################################
###########################################################################################################################################

  - measure: count_all_time_subscribers
    label: ALL TIME SUBSCRIBERS
    type: count_distinct
    sql: ${email} || ${list}

  - measure: count_current_emails
    label: COUNT CURRENT EMAILS
    type: count_distinct
    sql: ${email} || ${list}
    filters:
      mailchimp_unsubscribe.unsubscribe_time: "NULL"
      mailchimp_cleaned_email.email_cleaned_time: "NULL"

  - measure: list_size_running_total
    label: LIST SIZE RUNNING TOTAL
    type: running_total
    sql: ${count_current_emails}

  - measure: unsubscription_rate
    label: UNSUBSCRIPTION RATE
    type: number
    decimals: 2
    sql:  coalesce(${mailchimp_unsubscribe.count_unsubscriptions_from_campaign}/NULLIF(${count_all_time_subscribers},0)::REAL, '0')
    value_format: '#.##%'
  
  - measure: cleaned_email_rate
    label: CLEANED EMAIL RATE
    type: number
    type: number
    decimals: 2
    sql:  coalesce(${mailchimp_cleaned_email.count_cleaned_emails}/NULLIF(${count_all_time_subscribers},0)::REAL, '0')
    value_format: '#.##%'

      