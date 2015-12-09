- view: mc_newsletter_subscribers
  derived_table:
    sql: |
      with step_1 as (
      select list_id, email_address, member_rating, optin_time, optin_ip, confirm_time, confirm_ip, latitude, longitude, gmtoff, dstoff, timezone, cc, region, leid, euid, notes, 'subscribed' as status
      from mailchimp_data.mc_list_members_subscribed where
      list_id = '179a8621fb'
      )
      
      , step_2 as (
      select list_id, email_address, member_rating, optin_time, optin_ip, confirm_time, confirm_ip, latitude, longitude, gmtoff, dstoff, timezone, cc, region, leid, euid, notes, 'unsubscribed' as status
      from mailchimp_data.mc_list_members_unsubs where
      list_id = '179a8621fb'
      )
      
      , step_3 as (
      select list_id, email_address, member_rating, optin_time, optin_ip, confirm_time, confirm_ip, latitude, longitude, gmtoff, dstoff, timezone, cc, region, leid, euid, notes, 'cleaned' as status
      from mailchimp_data.mc_list_members_cleaned where
      list_id = '179a8621fb'
      )
      
      select * from step_1
      union
      select * from step_2
      union
      select * from step_3

  fields:

  - dimension: email_address
    type: string
    sql: ${TABLE}.email_address

  - dimension: member_rating
    type: int
    sql: ${TABLE}.member_rating

  - dimension_group: member_subscribed_time
    type: time
    timeframes: [time, date, week, month]
    sql: cast(${TABLE}.confirm_time as datetime)

  - dimension: confirm_ip
    type: string
    sql: ${TABLE}.confirm_ip

  - dimension: latitude
    type: string
    sql: ${TABLE}.latitude

  - dimension: longitude
    type: string
    sql: ${TABLE}.longitude

  - dimension: gmtoff
    type: string
    sql: ${TABLE}.gmtoff

  - dimension: dstoff
    type: string
    sql: ${TABLE}.dstoff

  - dimension: timezone
    type: string
    sql: ${TABLE}.timezone

  - dimension: cc
    type: string
    sql: ${TABLE}.cc

  - dimension: region
    type: string
    sql: ${TABLE}.region

  - dimension: leid
    type: string
    sql: ${TABLE}.leid

  - dimension: euid
    type: string
    sql: ${TABLE}.euid

  - dimension: notes
    type: string
    sql: ${TABLE}.notes

  - dimension: status
    type: string
    sql: ${TABLE}.status
    
  # Measures
  
  - measure: unique_emails_total
    type: count_distinct
    sql: ${email_address}
