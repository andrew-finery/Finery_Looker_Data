- view: mc_campaigns
  sql_table_name: marketing_data.mc_campaigns

  fields:

###### Dimensions

  - dimension: campaign_id
    type: string
    sql: ${TABLE}.campaign_id
    hidden: true

  - dimension: campaign_title
    type: string
    sql: ${TABLE}.campaign_title

  - dimension: folder_id
    type: string
    sql: ${TABLE}.folder_id
    hidden: true

  - dimension: folder_name
    type: string
    sql: ${TABLE}.folder_name

  - dimension: automation_id
    type: string
    sql: ${TABLE}.automation_id
    hidden: true

  - dimension: campaign_type
    type: string
    sql: ${TABLE}.campaign_type

  - dimension: create_time
    type: string
    sql: ${TABLE}.create_time as datetime
    hidden: true

  - dimension_group: email_sent_at
    type: time
    timeframes: [time, date, time_of_day, day_of_week, week, month, year]
    sql: ${TABLE}.email_send_time

  - dimension: content_type
    type: string
    sql: ${TABLE}.content_type
    hidden: true

  - dimension: list_id
    type: string
    sql: ${TABLE}.list_id
    hidden: true

  - dimension: subject_line
    type: string
    sql: ${TABLE}.subject_line

  - dimension: from_name
    type: string
    sql: ${TABLE}.from_name

  - dimension: reply_to
    type: string
    sql: ${TABLE}.reply_to

  - dimension: emails_sent
    type: int
    sql: ${TABLE}.emails_sent

  - dimension: opens
    type: int
    sql: ${TABLE}.opens

  - dimension: unique_opens
    type: int
    sql: ${TABLE}.unique_opens

  - dimension: campaign_open_rate
    type: number
    decimals: 4
    sql: ${unique_opens}/NULLIF(${emails_sent},0)::REAL
    value_format: '#0.00%'

  - dimension: clicks
    type: int
    sql: ${TABLE}.clicks

  - dimension: subscriber_clicks
    type: int
    sql: ${TABLE}.subscriber_clicks

  - dimension: campaign_click_rate
    type: number
    decimals: 4
    sql: ${subscriber_clicks}/NULLIF(${emails_sent},0)::REAL
    value_format: '#0.00%'

  - dimension: campaign_click_through_rate
    type: number
    decimals: 4
    sql: ${subscriber_clicks}/NULLIF(${unique_opens},0)::REAL
    value_format: '#0.00%'
    
### Measures
  
  - measure: total_emails_sent
    type: sum
    sql: ${emails_sent}
  
  - measure: total_opens
    type: sum
    sql: ${opens}
    
  - measure: total_unique_opens
    type: sum
    sql: ${unique_opens}
    
  - measure: total_clicks
    type: sum
    sql: ${clicks}
    
  - measure: total_subscriber_clicks
    type: sum
    sql: ${subscriber_clicks}
    
  - measure: open_rate
    type: number
    decimals: 4
    sql: ${total_unique_opens}/NULLIF(${total_emails_sent},0)::REAL
    value_format: '#0.00%'
    
  - measure: click_rate
    type: number
    decimals: 4
    sql: ${total_subscriber_clicks}/NULLIF(${total_emails_sent},0)::REAL
    value_format: '#0.00%'

  - measure: click_through_rate
    type: number
    decimals: 4
    sql: ${total_subscriber_clicks}/NULLIF(${total_unique_opens},0)::REAL
    value_format: '#0.00%'
    
  - measure: unique_campaigns_count
    type: count_distinct
    sql: ${campaign_id}
  
  
  
  

  
  
  
  