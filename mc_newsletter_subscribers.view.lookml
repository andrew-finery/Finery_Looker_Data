- view: mc_newsletter_subscribers
  sql_table_name: marketing_data.mc_newsletter_subscribers

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

## Member engagement metrics

  - dimension: total_campaigns_sent
    type: int
    sql: ${TABLE}.total_campaigns_sent
    group_label: 'Engagement'
      
  - dimension: total_campaign_opens
    type: int
    sql: ${TABLE}.total_campaign_opens
    group_label: 'Engagement'
     
  - dimension: total_campaign_clicks
    type: int
    sql: ${TABLE}.total_campaign_clicks
    group_label: 'Engagement'
     
  - dimension: member_open_rate
    type: number
    sql: ${total_campaign_opens}/NULLIF(${total_campaigns_sent},0)::REAL
    value_format: '0%'
    group_label: 'Engagement'
     
  - dimension: member_click_rate
    type: number
    sql: ${total_campaign_clicks}/NULLIF(${total_campaigns_sent},0)::REAL
    value_format: '0%' 
    group_label: 'Engagement'
     
  - dimension: member_ctr
    type: number
    sql: ${total_campaign_clicks}/NULLIF(${total_campaign_opens},0)::REAL
    value_format: '0%'
    group_label: 'Engagement'
     
  - dimension: member_open_rate_tier
    type: tier
    sql: ${member_open_rate}
    group_label: 'Engagement'
    style: relational
    tiers: [0,0.1,0.2,0.3,0.4,0.5,0.6,0.7]
     
  - dimension: member_click_rate_tier
    type: tier
    sql: ${member_click_rate}
    group_label: 'Engagement'
    style: relational
    tiers: [0,0.1,0.2,0.3,0.4,0.5]

## Engagement Metrics 90d

  - dimension: total_campaigns_sent_90d
    type: int
    sql: ${TABLE}.total_campaigns_sent_90d
    group_label: 'Engagement 90d'
      
  - dimension: total_campaign_opens_90d
    type: int
    sql: ${TABLE}.total_campaign_opens_90d
    group_label: 'Engagement 90d'
     
  - dimension: total_campaign_clicks_90d
    type: int
    sql: ${TABLE}.total_campaign_clicks_90d
    group_label: 'Engagement 90d'
     
  - dimension: member_open_rate_90d
    type: number
    sql: ${total_campaign_opens_90d}/NULLIF(${total_campaigns_sent_90d},0)::REAL
    value_format: '0%'
    group_label: 'Engagement 90d'
     
  - dimension: member_click_rate_90d
    type: number
    sql: ${total_campaign_clicks_90d}/NULLIF(${total_campaigns_sent_90d},0)::REAL
    value_format: '0%' 
    group_label: 'Engagement 90d'
     
  - dimension: member_ctr_90d
    type: number
    sql: ${total_campaign_clicks_90d}/NULLIF(${total_campaign_opens_90d},0)::REAL
    value_format: '0%'
    group_label: 'Engagement 90d'
     
  - dimension: has_opened_email_90d
    type: yesno
    sql: ${total_campaign_opens_90d} > 0
    group_label: 'Engagement 90d'
    
  - dimension: has_clicked_email_90d
    type: yesno
    sql: ${total_campaign_clicks_90d} > 0
    group_label: 'Engagement 90d'
    
## Engagement Metrics 60d

  - dimension: total_campaigns_sent_60d
    type: int
    sql: ${TABLE}.total_campaigns_sent_60d
    group_label: 'Engagement 60d'
      
  - dimension: total_campaign_opens_60d
    type: int
    sql: ${TABLE}.total_campaign_opens_60d
    group_label: 'Engagement 60d'
     
  - dimension: total_campaign_clicks_60d
    type: int
    sql: ${TABLE}.total_campaign_clicks_60d
    group_label: 'Engagement 60d'
     
  - dimension: member_open_rate_60d
    type: number
    sql: ${total_campaign_opens_60d}/NULLIF(${total_campaigns_sent_60d},0)::REAL
    value_format: '0%'
    group_label: 'Engagement 60d'
     
  - dimension: member_click_rate_60d
    type: number
    sql: ${total_campaign_clicks_60d}/NULLIF(${total_campaigns_sent_60d},0)::REAL
    value_format: '0%' 
    group_label: 'Engagement 60d'
     
  - dimension: member_ctr_60d
    type: number
    sql: ${total_campaign_clicks_60d}/NULLIF(${total_campaign_opens_60d},0)::REAL
    value_format: '0%'
    group_label: 'Engagement 60d'
     
  - dimension: has_opened_email_60d
    type: yesno
    sql: ${total_campaign_opens_60d} > 0
    group_label: 'Engagement 60d'
    
  - dimension: has_clicked_email_60d
    type: yesno
    sql: ${total_campaign_clicks_60d} > 0
    group_label: 'Engagement 60d'
    
## Engagement Metrics 30d

  - dimension: total_campaigns_sent_30d
    type: int
    sql: ${TABLE}.total_campaigns_sent_30d
    group_label: 'Engagement 30d'
      
  - dimension: total_campaign_opens_30d
    type: int
    sql: ${TABLE}.total_campaign_opens_30d
    group_label: 'Engagement 30d'
     
  - dimension: total_campaign_clicks_30d
    type: int
    sql: ${TABLE}.total_campaign_clicks_30d
    group_label: 'Engagement 30d'
     
  - dimension: member_open_rate_30d
    type: number
    sql: ${total_campaign_opens_30d}/NULLIF(${total_campaigns_sent_30d},0)::REAL
    value_format: '0%'
    group_label: 'Engagement 30d'
     
  - dimension: member_click_rate_30d
    type: number
    sql: ${total_campaign_clicks_30d}/NULLIF(${total_campaigns_sent_30d},0)::REAL
    value_format: '0%' 
    group_label: 'Engagement 30d'
     
  - dimension: member_ctr_30d
    type: number
    sql: ${total_campaign_clicks_30d}/NULLIF(${total_campaign_opens_30d},0)::REAL
    value_format: '0%'
    group_label: 'Engagement 30d'
     
  - dimension: has_opened_email_30d
    type: yesno
    sql: ${total_campaign_opens_30d} > 0
    group_label: 'Engagement 30d'
    
  - dimension: has_clicked_email_30d
    type: yesno
    sql: ${total_campaign_clicks_30d} > 0
    group_label: 'Engagement 30d'
     

## Engagement Metrics 7d

  - dimension: total_campaigns_sent_7d
    type: int
    sql: ${TABLE}.total_campaigns_sent_7d
    group_label: 'Engagement 7d'
      
  - dimension: total_campaign_opens_7d
    type: int
    sql: ${TABLE}.total_campaign_opens_7d
    group_label: 'Engagement 7d'
     
  - dimension: total_campaign_clicks_7d
    type: int
    sql: ${TABLE}.total_campaign_clicks_7d
    group_label: 'Engagement 7d'
     
  - dimension: member_open_rate_7d
    type: number
    sql: ${total_campaign_opens_7d}/NULLIF(${total_campaigns_sent_7d},0)::REAL
    value_format: '0%'
    group_label: 'Engagement 7d'
     
  - dimension: member_click_rate_7d
    type: number
    sql: ${total_campaign_clicks_7d}/NULLIF(${total_campaigns_sent_7d},0)::REAL
    value_format: '0%' 
    group_label: 'Engagement 7d'
     
  - dimension: member_ctr_7d
    type: number
    sql: ${total_campaign_clicks_7d}/NULLIF(${total_campaign_opens_7d},0)::REAL
    value_format: '0%'
    group_label: 'Engagement 7d'
     
  - dimension: has_opened_email_7d
    type: yesno
    sql: ${total_campaign_opens_7d} > 0
    group_label: 'Engagement 7d'
    
  - dimension: has_clicked_email_7d
    type: yesno
    sql: ${total_campaign_clicks_7d} > 0
    group_label: 'Engagement 7d'
    

  - dimension: engagement_status
    sql: |
          case
          when ${status} in ('unsubscribed', 'cleaned') then 'Unsubscribed/Cleaned'
          when ${total_campaign_opens_30d} > 0 then 'Active'
          when current_date - ${member_subscribed_time_date} < 20 then 'New List Member'
          when ${total_campaign_opens_30d} = 0 then 'Inactive'
          when ${email_address} is not null then 'Inactive'
          else 'Not subscribed' end
          
    
    
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
    decimals: 4
    sql: ${unique_unsubscribed_emails}/NULLIF(${unique_email_addresses},0)::REAL
    value_format: '#0.00%'

  - measure: cleaned_percentage
    type: number
    decimals: 4
    sql: ${unique_cleaned_emails}/NULLIF(${unique_email_addresses},0)::REAL
    value_format: '#0.00%'

  - measure: count_email_openers_90d
    type: count_distinct
    sql: ${email_address}
    filters:
      has_opened_email_90d: yes
  
  - measure: count_email_clickers_90d
    type: count_distinct
    sql: ${email_address}
    filters:
      has_clicked_email_90d: yes

  - measure: count_email_openers_60d
    type: count_distinct
    sql: ${email_address}
    filters:
      has_opened_email_60d: yes
  
  - measure: count_email_clickers_60d
    type: count_distinct
    sql: ${email_address}
    filters:
      has_clicked_email_60d: yes

  - measure: count_email_openers_30d
    type: count_distinct
    sql: ${email_address}
    filters:
      has_opened_email_30d: yes
  
  - measure: count_email_clickers_30d
    type: count_distinct
    sql: ${email_address}
    filters:
      has_clicked_email_30d: yes

  - measure: count_email_openers_7d
    type: count_distinct
    sql: ${email_address}
    filters:
      has_opened_email_7d: yes
  
  - measure: count_email_clickers_7d
    type: count_distinct
    sql: ${email_address}
    filters:
      has_clicked_email_7d: yes