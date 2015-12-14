- view: mc_campaign_member_activity
  sql_table_name: mailchimp_data.mc_campaign_member_activity
  fields:

  - dimension: action
    sql: ${TABLE}.action

  - dimension: campaign_id
    sql: ${TABLE}.campaign_id

  - dimension: email_address
    sql: ${TABLE}.email_address

  - dimension: ip
    sql: ${TABLE}.ip

  - dimension_group: action_performed_at
    type: time
    timeframes: [time, date, week, month]
    sql: cast(${TABLE}.time_stamp as datetime)

  - dimension: url
    sql: ${TABLE}.url

  # Measures

  - measure: unique_clicks_total
    type: count_distinct
    sql: ${email_address} || ${campaign_id}
    filters:
      action: click
  
  - measure: unique_opens_total
    type: count_distinct
    sql: ${email_address} || ${campaign_id}
    filters:
      action: open