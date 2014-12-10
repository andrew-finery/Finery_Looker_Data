- view: users_signup
  derived_table:
    sql: |
      SELECT all_emails.email_address AS email_address,
                 spree_users.id AS id,
                CASE
                   when mailchimp_diff.email_address is not null and spree_users.email_address is null then 'Initial Invite - But Diff Email Used'
                   WHEN mailchimp.email_address IS NOT NULL THEN 'Initial Invite'
                   WHEN mandrill.email_address IS NOT NULL THEN 'Referral'
                   ELSE 'Other'
                 END AS source,
                 CASE
                   WHEN spree_users.email_address IS NOT NULL THEN 'Yes'
                   ELSE 'No'
                 END AS signed_up,
                 spree_users.created_at,
                 spree_users.first_name AS first_name,
                 spree_users.last_name AS last_name,
                 min(mandrill.referral_sent_at) as referral_sent_at,
                 mailchimp.first_name AS mailchimp_first_name,
                 mailchimp.last_name AS mailchimp_last_name,
                 mailchimp.INVITECODE,
                 mailchimp.CREDIT,
                 mailchimp.Tier,
                 mailchimp.Currency,
                 mailchimp.Referrer,
                 mailchimp.NR_Reference,
                 mailchimp.Time_for_Welcome_Email,
                 ord.number_of_orders,
                 ord.first_order,
                 ord.last_order,
                 case when ord.customer_id is not null then 'Yes' else 'No' end as purchased_flag
          
          from
                
                (select lower(email_address) as email_address
                from
                ((select lower(email) as email_address from spree.users_snapshot)
                union
                (select lower(email_address) as email_address from mailchimp.initial_invites)
                union
                (select lower(email_address) as email_address from mandrill.referrals where status = 'sent'))
                group by 1) all_emails
                
           LEFT JOIN (SELECT lower(email_address) as email_address,
                              first_name,
                              last_name,
                              INVITECODE,
                              CREDIT,
                              Tier,
                              Currency,
                              Referrer,
                              NR_Reference,
                              Time_for_Welcome_Email
                       FROM mailchimp.initial_invites) AS mailchimp ON all_emails.email_address = mailchimp.email_address
                       
          LEFT JOIN (SELECT CAST(DATE AS datetime) AS referral_sent_at,
                              lower(Email_Address) AS email_address
                       FROM mandrill.referrals
                       WHERE status = 'sent'
                       GROUP BY 1,
                                2) AS mandrill ON all_emails.email_address = mandrill.email_address
                                
          LEFT JOIN (SELECT id AS id,
                              lower(email) AS email_address,
                              created_at AS created_at,
                              CASE
                                WHEN first_name = 'NULL' THEN 'N/A'
                                ELSE first_name
                              END AS first_name,
                              CASE
                                WHEN last_name = 'NULL' THEN 'N/A'
                                ELSE last_name
                              END AS last_name
                       FROM spree.users_snapshot
                       WHERE email <> 'NULL') spree_users ON spree_users.email_address = all_emails.email_address
                       
          LEFT JOIN (SELECT customer_id as customer_id,
                            count(distinct order_id) as number_of_orders,
                            min(completed_at) as first_order,
                            max(completed_at) as last_order
                            from ${spree_orders.SQL_TABLE_NAME}
                            group by 1) ord
                      on ord.customer_id = spree_users.id
          left join (select
                      lower(mailchimp.email_address) as email_address
                      from spree.users_snapshot users
                      inner join (select first_name, last_name, email_address from mailchimp.initial_invites group by 1,2,3) mailchimp
                      on lower(users.first_name) = lower(mailchimp.first_name)
                      and lower(users.last_name) = lower(mailchimp.last_name)
                      where lower(users.email) <> lower(mailchimp.email_address)
                      group by 1) mailchimp_diff
                      on mailchimp_diff.email_address = all_emails.email_address

                      
              group by 1,2,3,4,5,6,7,9,10,11,12,13,14,15,16,17,18,19,20,21

    sql_trigger_value: SELECT COUNT(*) FROM spree_users
    distkey: id
    sortkeys: [id, created_at]
    


  fields:

  - dimension: email_address
    sql: ${TABLE}.email_address
  
  - dimension: customer_id
    type: int
    sql: ${TABLE}.id
    
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
  
  - dimension: purchased
    type: yesno
    sql: ${TABLE}.purchased_flag = 'Yes'
    
  - dimension_group: first_purchase
    type: time
    timeframes: [time, date, hod, hour, week, month]
    sql: ${TABLE}.first_order
  
  - dimension_group: last_purchase
    type: time
    timeframes: [time, date, hod, hour, week, month]
    sql: ${TABLE}.last_order

  - dimension: first_name
    sql: ${TABLE}.first_name
    
  - dimension: last_name
    sql: ${TABLE}.last_name
    
  # mailchimp dimensions#
  
  - dimension: mailchimp_first_name
    sql: ${TABLE}.mailchimp_first_name
    
  - dimension: mailchimp_last_name
    sql: ${TABLE}.mailchimp_last_name
    
  - dimension: invitecode
    sql: ${TABLE}.invitecode
    
  - dimension: credit
    sql: ${TABLE}.credit
    
  - dimension: tier
    sql: ${TABLE}.tier
    
  - dimension: currency
    sql: ${TABLE}.currency
    
  - dimension: referrer
    sql: ${TABLE}.referrer
    
  - dimension: nr_reference
    sql: ${TABLE}.nr_reference
  
  - dimension: time_for_welcome_e_mail
    sql: ${TABLE}.time_for_welcome_e_mail
    
  # MEASURES #
  
  - measure: sign_ups
    type: count_distinct
    filters:
      signed_up: yes
    sql: ${customer_id}
  
  - measure: sign_ups_running_total
    type: running_total
    sql: ${sign_ups}
    
  - measure: emails_sent
    type: count_distinct
    filters:
      source: Initial Invite,Referral, Initial Invite - But Diff Email Used
    sql: ${email_address}
  
  - measure: count_customers
    type: count_distinct
    filters:
      purchased: Yes
    sql: ${customer_id}
  
  - measure: sign_up_rate
    type: number
    decimals: 2
    sql: 100.0 * ${sign_ups}/NULLIF(${emails_sent},0)::REAL
    format: "%0.2f%"
    
  - measure: purchase_rate
    type: number
    decimals: 2
    sql: 100.0 * ${count_customers}/NULLIF(${emails_sent},0)::REAL
    format: "%0.2f%"
    

