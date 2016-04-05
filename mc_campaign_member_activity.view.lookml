- view: mc_campaign_member_activity
  sql_table_name: scratchpad.mc_member_activity_temp
  fields:


  - dimension: campaign_id
    sql: ${TABLE}.campaign_id

  - dimension: email_address
    sql: ${TABLE}.member_email_address

  - dimension: opens
    type: int
    sql: ${TABLE}.opens
    hidden: true

  - dimension: clicks
    type: int
    sql: ${TABLE}.clicks
    hidden: true
    
  # Measures

  - measure: emails_sent
    type: count_distinct
    sql: ${email_address} || ${campaign_id}

  - measure: unique_clicks_total
    type: count
    sql: ${email_address} || ${campaign_id}
    filters:
      clicks: '>0'
  
  - measure: unique_opens_total
    type: count_distinct
    sql: ${email_address} || ${campaign_id}
    filters:
      opens: '>0'
  
  - measure: open_rate
    type: number
    decimals: 2
    sql: ${unique_opens_total}/${emails_sent}::REAL
    value_format: '#0.00%'
  
  - measure: click_rate
    type: number
    decimals: 2
    sql: ${unique_clicks_total}/${emails_sent}::REAL
    value_format: '#0.00%'
    
  - measure: opens_total
    type: sum
    sql: ${opens}
  
  - measure: clicks_total
    type: sum
    sql: ${clicks}