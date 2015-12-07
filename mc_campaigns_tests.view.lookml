- view: mc_campaigns_tests
  derived_table:
   sql: |
        with step_1 as (
        select
        case when len(b.test_id) > 0 then b.test_id
             else a.id end as id,
        a.id as campaign_id,
        a.folder_id,
        a.send_time as campaign_send_time,
        a.list_id,
        a.title
        from mailchimp_data.mc_campaigns a
        left join mailchimp_data.mc_campaigns_tests b
        on a.id = b.campaign_id
        )
        
        , step_2 as (
        select
        email_id as id,
        email_id as campaign_id,
        automation_id as folder_id,
        send_time as campaign_send_time,
        list_id,
        title
        from mailchimp_data.mc_automations_emails
        )
        
        , step_3 as (
        select * from step_1
        union
        select * from step_2
        )
        
        select
        a.id,
        a.campaign_id,
        a.folder_id,
        a.campaign_send_time,
        a.list_id,
        a.title,
          case
          when b.name  is not null then b.name
          when a.folder_id in ('7f1baa9d8b', '8cd6bf7f92', '441aa42e8b', '62f4e948c3', '8a61167fd4', 'fdfb7ce989') then 'Refer a Friend Campaign'
          when a.folder_id in ('920b44ef42', '05d5a02652', '1f5d8a19b8', 'e5c6b20814', '661c00b026') then 'Welcome Chain'
          when a.folder_id in ('838042d7aa', '3499ef190d', '7675a1474d', '9be275b240') then 'Referral Chain'
          else 'Other' end as folder_name
        from step_3 a
        left join mailchimp_data.mc_campaign_folder b
        on a.folder_id = b.id
        where len(campaign_send_time)>0
                

  fields:

  - dimension: id
    sql: ${TABLE}.id

  - dimension: campaign_id
    sql: ${TABLE}.campaign_id

  - dimension: folder_id
    sql: ${TABLE}.folder_id

  - dimension_group: send_time
    type: time
    timeframes: [time, date, hour_of_day, week, month]
    sql: ${TABLE}.campaign_send_time

  - dimension: list_id
    sql: ${TABLE}.list_id

  - dimension: campaign_title
    sql: ${TABLE}.title

  - dimension: folder_name
    sql: ${TABLE}.folder_name