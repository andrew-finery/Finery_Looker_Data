- view: mc_referrals
  sql_table_name: marketing_data.mc_referral_list

  fields:

  - dimension: email_address
    type: string
    sql: ${TABLE}.email_address

  - dimension: member_rating
    type: number
    sql: ${TABLE}.member_rating

  - dimension_group: member_subscribed_time
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.confirm_time

  - dimension: confirm_ip
    type: string
    sql: ${TABLE}.confirm_ip
    hidden: true

  - dimension: latitude
    type: string
    sql: ${TABLE}.latitude
    hidden: true
    
  - dimension: longitude
    type: string
    sql: ${TABLE}.longitude
    hidden: true
    
  - dimension: gmtoff
    type: string
    sql: ${TABLE}.gmtoff
    hidden: true
    
  - dimension: dstoff
    type: string
    sql: ${TABLE}.dstoff
    hidden: true
    
  - dimension: timezone
    type: string
    sql: ${TABLE}.timezone
    hidden: true
    
  - dimension: cc
    type: string
    sql: ${TABLE}.cc
    hidden: true
    
  - dimension: region
    type: string
    sql: ${TABLE}.region
    hidden: true
    
  - dimension: leid
    type: string
    sql: ${TABLE}.leid
    hidden: true
    
  - dimension: euid
    type: string
    sql: ${TABLE}.euid
    hidden: true
    
  - dimension: notes
    type: string
    sql: ${TABLE}.notes
    hidden: true
    
  - dimension: status
    type: string
    sql: ${TABLE}.status

  - dimension: signup_source
    type: string
    sql: ${TABLE}.signup_source

  - dimension_group: member_unsubscribed_time
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.unsub_time

  - dimension_group: member_cleaned_time
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.clean_time

  - dimension: unsubscription_campaign_title
    type: string
    sql: ${TABLE}.unsub_campaign_title

  - dimension: unsubscription_campaign_id
    type: string
    sql: ${TABLE}.unsub_campaign_id

  # Measures
  
  - measure: unique_email_addresses
    type: count_distinct
    sql: ${email_address}

  - measure: unique_subscribed_emails_total
    type: count_distinct
    sql: ${email_address}
    filters:
      status: subscribed

  - measure: unique_unsubscribed_emails
    type: count_distinct
    sql: ${email_address}
    filters:
      status: unsubscribed
    
  - measure: unique_cleaned_emails
    type: count_distinct
    sql: ${email_address}
    filters:
      status: cleaned

  - measure: unsubscription_percentage
    type: number
    value_format_name: percent_2
    sql: ${unique_unsubscribed_emails}/NULLIF(${unique_email_addresses},0)::REAL

  - measure: cleaned_percentage
    type: number
    value_format_name: percent_2
    sql: ${unique_cleaned_emails}/NULLIF(${unique_email_addresses},0)::REAL