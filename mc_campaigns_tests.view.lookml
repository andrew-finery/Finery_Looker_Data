- view: mc_campaigns_tests
  derived_table:
   sql: |
        with step_1 as (
        select
        a.id as campaign_id,
        case when len(b.test_id) > 0 then b.test_id else a.id end as test_id,
        b.winning_campaign,
        case
        when b.winning_campaign = 'true' then 'Winning Campaign'
        when b.winning_campaign = 'false' then 'Test Variation'
        else 'No Variate Test'
        end as test_type,
        null as email_sent_time,
        null as subject_line,
        null as from_name,
        null as reply_to,
        null as emails_sent,
        null as opens,
        null as unique_opens,
        null as clicks,
        null as subscriber_clicks
        from mailchimp_data.mc_campaigns a
        left join mailchimp_data.mc_campaigns_tests b
        on a.id = b.campaign_id
        )
        
        ,step_2 as (
        select
        email_id as campaign_id,
        email_id as test_id,
        null as winning_campaign,
        'No Variate Test' as test_type,
        null as email_sent_time,
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

### Dimensions

  - dimension: test_id
    type: string
    sql: ${TABLE}.test_id

  - dimension: campaign_id
    type: string
    sql: ${TABLE}.campaign_id

  - dimension: test_type
    type: string
    sql: ${TABLE}.test_type

  - dimension_group: variate_send_time
    type: time
    timeframes: [time, date, hour_of_day, week, month]
    sql: cast(${TABLE}.email_sent_time as datetime)

  - dimension: variate_subject_line
    type: string
    sql: ${TABLE}.subject_line

  - dimension: variate_from_name
    type: string
    sql: ${TABLE}.from_name

  - dimension: variate_reply_to
    type: string
    sql: ${TABLE}.reply_to

  - dimension: variate_emails_sent
    type: int
    sql: ${TABLE}.emails_sent

  - dimension: variate_opens
    type: int
    sql: ${TABLE}.opens

  - dimension: variate_unique_opens
    type: int
    sql: ${TABLE}.unique_opens

  - dimension: variate_open_rate
    type: number
    decimals: 4
    sql: ${variate_unique_opens}/NULLIF(${variate_emails_sent},0)::REAL
    value_format: '#0.00%'

  - dimension: variate_clicks
    type: int
    sql: ${TABLE}.clicks

  - dimension: variate_subscriber_clicks
    type: int
    sql: ${TABLE}.subscriber_clicks

  - dimension: variate_click_rate
    type: number
    decimals: 4
    sql: ${variate_subscriber_clicks}/NULLIF(${variate_emails_sent},0)::REAL
    value_format: '#0.00%'
    
### Measures
  
  - measure: total_emails_sent
    type: sum
    sql: ${variate_emails_sent}
  
  - measure: total_opens
    type: sum
    sql: ${variate_opens}
    
  - measure: total_unique_opens
    type: sum
    sql: ${variate_unique_opens}
    
  - measure: total_clicks
    type: sum
    sql: ${variate_clicks}
    
  - measure: total_subscriber_clicks
    type: sum
    sql: ${variate_subscriber_clicks}
    
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