- view: mc_campaigns
  derived_table:
    sql: |
      with step_1 as (
      select
      a.id as campaign_id,
      a.title as campaign_title,
      a.folder_id as folder_id,
      b.name as folder_name,
      null as automation_id,
      a."type" as campaign_type,
      a.create_time as create_time,
      a.send_time as email_send_time,
      a.content_type,
      a.list_id,
      null as subject_line,
      null as from_name,
      null as reply_to,
      a.emails_sent,
      a.opens,
      a.unique_opens,
      a.clicks,
      a.subscriber_clicks
      from mailchimp_data.mc_campaigns a
      left join mailchimp_data.mc_campaign_folder b
      on a.folder_id = b.id
      )
      
      , step_2 as (
      select
      email_id as campaign_id,
      title as campaign_title,
      null as folder_id,
      case
      when automation_id in ('7f1baa9d8b', '8cd6bf7f92', '441aa42e8b', '62f4e948c3', '8a61167fd4', 'fdfb7ce989') then 'Refer a Friend Campaign'
      when automation_id in ('920b44ef42', '05d5a02652', '1f5d8a19b8', 'e5c6b20814', '661c00b026') then 'Welcome Chain'
      when automation_id in ('838042d7aa', '3499ef190d', '7675a1474d', '9be275b240') then 'Referral Chain'
      else 'Other' end as folder_name,
      automation_id as automation_id,
      'automation' as campaign_type,
      create_time as create_time,
      null as email_send_time,
      content_type,
      list_id,
      subject_line,
      from_name,
      reply_to,
      emails_sent,
      opens,
      unique_opens,
      clicks,
      subscriber_clicks
      from mailchimp_data.mc_automations_emails
      )
      
      select * from step_1
      union
      select * from step_2

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
    sql: cast(${TABLE}.create_time as datetime)
    hidden: true

  - dimension_group: email_sent_at
    type: time
    timeframes: [date, week, month, year]
    sql: cast(${TABLE}.email_send_time as datetime)

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
    
  - measure: unique_campaigns_count
    type: count_distinct
    sql: ${campaign_id}
  
  
  
  

  
  
  
  