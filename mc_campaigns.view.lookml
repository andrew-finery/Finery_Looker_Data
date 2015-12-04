- view: mc_campaigns
  sql_table_name: mailchimp_data.mc_campaigns
  fields:

  - dimension: id
    sql: ${TABLE}.id

  - dimension: click_rate
    type: number
    sql: ${TABLE}.click_rate

  - dimension: clicks
    type: int
    sql: ${TABLE}.clicks

  - dimension: content_type
    sql: ${TABLE}.content_type

  - dimension: create_time
    sql: ${TABLE}.create_time

  - dimension: emails_sent
    type: int
    sql: ${TABLE}.emails_sent

  - dimension: folder_id
    sql: ${TABLE}.folder_id

  - dimension: google_analytics
    sql: ${TABLE}.google_analytics

  - dimension: list_id
    sql: ${TABLE}.list_id

  - dimension: open_rate
    type: number
    sql: ${TABLE}.open_rate

  - dimension: opens
    type: int
    sql: ${TABLE}.opens

  - dimension: send_time
    sql: ${TABLE}.send_time

  - dimension: status
    sql: ${TABLE}.status

  - dimension: subscriber_clicks
    type: int
    sql: ${TABLE}.subscriber_clicks

  - dimension: title
    sql: ${TABLE}.title

  - dimension: type
    sql: ${TABLE}.type

  - dimension: unique_opens
    type: int
    sql: ${TABLE}.unique_opens

