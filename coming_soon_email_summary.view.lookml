- view: coming_soon_email_summary
  sql_table_name: coming_soon_emails.summary
  fields:

  - dimension: unique_clicks
    type: number
    sql: ${TABLE}.distinct_clicks

  - dimension: unique_opens
    type: number
    sql: ${TABLE}.distinct_opens

  - dimension: email_description
    type: string
    sql: ${TABLE}.email_description

  - dimension_group: email_sent
    type: time
    timeframes: [date, week, month]
    convert_tz: false
    sql: ${TABLE}.email_sent_date

  - dimension: email_subject
    type: string
    sql: ${TABLE}.email_subject

  - dimension: email_type
    type: string
    sql: ${TABLE}.email_type

  - dimension: option_name
    type: string
    sql: ${TABLE}.option_name

  - dimension: product_id
    type: number
    sql: ${TABLE}.product_id

  - dimension: sku
    type: string
    sql: ${TABLE}.sku

  - dimension: total_clicks
    type: number
    sql: ${TABLE}.total_clicks

  - dimension: total_opens
    type: number
    sql: ${TABLE}.total_opens

  - dimension: emails_sent
    type: number
    sql: ${TABLE}.total_sends

  - dimension: campaign_open_rate
    type: number
    value_format_name: percent_2
    sql: ${unique_opens}/NULLIF(${emails_sent},0)::REAL

  - dimension: campaign_click_rate
    type: number
    value_format_name: percent_2
    sql: ${unique_clicks}/NULLIF(${emails_sent},0)::REAL

  - dimension: campaign_click_through_rate
    type: number
    value_format_name: percent_2
    sql: ${unique_clicks}/NULLIF(${unique_opens},0)::REAL