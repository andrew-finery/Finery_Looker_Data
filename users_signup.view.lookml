- view: users_signup
  derived_table:
    sql: |
      select

      all_emails.email_address as email_address,
      
      spree_users.id as id,
      
      case when mailchimp.email_address is not null then 'Initial Invite'
           when mandrill.email_address is not null then 'Referral'
           else 'Other' end as source,
           
      case when spree_users.email_address is not null then 'Yes'
           else 'No' end as signed_up,
      
      spree_users.created_at,
      spree_users.first_name,
      spree_users.last_name,
      mandrill.referral_sent_at
      
      from
      
      (select email_address
      from
      ((select left(right(email, len(email)-1), len(email)-2) as email_address from spree_users)
      union
      (select email_address from scratchpad.mailchimp_temp)
      union
      (select email_address from mandrill_referrals where status = 'sent'))
      group by 1) as all_emails
      
      left join (select email_address from scratchpad.mailchimp_temp group by 1) as mailchimp
      on all_emails.email_address = mailchimp.email_address
      
      left join (select cast (date as datetime) as referral_sent_at, Email_Address as email_address from mandrill_referrals where status = 'sent' group by 1,2) as mandrill
      on all_emails.email_address = mandrill.email_address
      
      left join
      (select
      id as id,
      left(right(email, len(email)-1), len(email)-2) as email_address,
      cast(left(right(created_at, len(created_at)-1), len(created_at)-2) as datetime) as created_at,
      case when first_name = 'NULL' then 'N/A' else left(right(first_name, len(first_name)-1), len(first_name)-2) end as first_name,
      case when last_name = 'NULL' then 'N/A' else left(right(last_name, len(last_name)-1), len(last_name)-2) end as last_name
      from spree_users
      where email <> 'NULL') spree_users
      
      on spree_users.email_address = all_emails.email_address

    sql_trigger_value: SELECT COUNT(*) FROM spree_users
    distkey: id
    sortkeys: [id, created_at]
    


  fields:

  - dimension: email_address
    sql: ${TABLE}.email_address
  
  - dimension: customer_id
    type: int
    sql: ${TABLE}.customer_id
    
  - dimension_group: created_at
    type: time
    timeframes: [time, date, hod, hour, week, month]
    sql: ${TABLE}.created_at
  
  - dimension_group: referral_sent_at
    type: time
    timeframes: [time, date, hod, hour, week, month]
    sql: ${TABLE}.referral_sent_at
    
  - dimension: source
    sql: ${TABLE}.source
    
  - dimension: signed_up
    type: yesno
    sql: ${TABLE}.signed_up = 'Yes'
    
  - dimension: first_name
    sql: ${TABLE}.first_name
    
  - dimension: last_name
    sql: ${TABLE}.last_name
    
  # MEASURES #
  
  - measure: sign_ups
    type: count
    filters:
      signed_up: yes
    sql: ${email_address}
  
  - measure: sign_ups_running_total
    type: running_total
    sql: ${sign_ups}
    
  - measure: emails_sent
    type: count
    filters:
      source: Initial Invite,Referral
    sql: ${email_address}
    
  - measure: sign_up_rate
    type: number
    decimals: 2
    sql: 100.0 * ${sign_ups}/NULLIF(${emails_sent},0)::REAL
    format: "%0.2f%"
    
    
  
