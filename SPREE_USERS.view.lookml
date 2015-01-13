- view: spree_users
  derived_table:
    sql: |
      select
        a.spree_timestamp,
        a.id as user_id,
        a.email as email_address,
        a.created_at,
        a.first_name,
        a.last_name,
        a.newsletter_opt_in,
        a.sign_in_count,
        a.last_sign_in_at,
        a.birth_date,
        coalesce(a.permitted_referrals, '0') as permitted_referrals,
        c.credit_amount as signup_credit,
        c.currency as signup_credit_currency,
        c.credit_amount_gbp as signup_credit_gbp,
        coalesce(b.total_credit_granted_gbp, '0') as total_credit_granted_gbp,
        coalesce(b.total_credit_used_gbp, '0') as total_credit_used_gbp,
        coalesce(b.current_credit_gbp, '0') as current_credit_gbp,
        coalesce(d.referrals_sent, '0') as referrals_sent
        
        from
        
        (select * from daily_snapshot.spree_users where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_users)) a
        left join
        (select aaa.user_id, sum(aaa.amount * bbb.exchange_rate) as total_credit_granted_gbp, sum(aaa.amount_used * bbb.exchange_rate) as total_credit_used_gbp, sum(aaa.amount * bbb.exchange_rate) - sum(aaa.amount_used * bbb.exchange_rate) as current_credit_gbp from (select * from daily_snapshot.spree_store_credits where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_store_credits)) aaa left join lookup.exchange_rates bbb on date(aaa.created_at) = bbb."date" and aaa.currency = bbb.currency group by 1) b
        on a.id = b.user_id
        
        left join
        (select aaa.email, aaa.credit_amount, aaa.currency, aaa.credit_amount * bbb.exchange_rate as credit_amount_gbp from (select * from daily_snapshot.spree_user_signup_awards where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_user_signup_awards)) aaa left join lookup.exchange_rates bbb on date(aaa.created_at) = bbb."date" and aaa.currency = bbb.currency) c
        on lower(a.email) = lower(c.email)
        
        left join
        (select sent_by_id as user_id, count(*) as referrals_sent from daily_snapshot.spree_invitations where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_invitations) and sent_by_id is not null group by 1) d
        on a.id = d.user_id
        
    sql_trigger_value: SELECT MAX(spree_timestamp) FROM daily_snapshot.spree_users
    distkey: user_id
    sortkeys: [user_id]


  fields:
  - dimension: email_address
    sql: ${TABLE}.email_address
  
  - dimension: customer_id
    type: int
    sql: ${TABLE}.user_id
    
  - dimension_group: account_created_at
    type: time
    timeframes: [time, date, hod, hour, week, month]
    sql: ${TABLE}.created_at
    
  - dimension: first_name
    sql: ${TABLE}.first_name
    
  - dimension: last_name
    sql: ${TABLE}.last_name
    
  - dimension: newsletter_opt_in
    type: yesno
    sql: ${TABLE}.newsletter_opt_in = 1
    
  - dimension: sign_in_count
    sql: ${TABLE}.sign_in_count
  
  - dimension_group: birth_date
    type: time
    timeframes: [date, month, year]
    sql: ${TABLE}.birth_date
  
  - dimension_group: last_sign_in_at
    type: time
    timeframes: [time, date, hod, hour, week, month]
    sql: ${TABLE}.last_sign_in_at
    
  - dimension: permitted_referrals
    sql: ${TABLE}.permitted_referrals
  
  - dimension: referrals_sent
    sql: ${TABLE}.referrals_sent
  
  - dimension: referrals_left
    sql: ${TABLE}.permitted_referrals - ${TABLE}.referrals_sent
    
  - dimension: used_all_referrals
    type: yesno
    sql: ${referrals_left} = 0
  
  - dimension: signup_credit
    type: number
    decimals: 2
    sql: ${TABLE}.signup_credit
    format: "%0.2f"
       
  - dimension: signup_credit_currency
    sql: ${TABLE}.signup_credit_currency
       
  - dimension: signup_credit_gbp
    type: number
    decimals: 2
    sql: ${TABLE}.signup_credit_gbp
    format: "£%0.2f"
    
  - dimension: total_credit_granted_gbp
    type: number
    decimals: 2
    sql: ${TABLE}.total_credit_granted_gbp
    format: "£%0.2f"
    
  - dimension: total_credit_used_gbp
    type: number
    decimals: 2
    sql: ${TABLE}.total_credit_used_gbp
    format: "£%0.2f"
    
  - dimension: current_credit_gbp
    type: number
    decimals: 2
    sql: ${TABLE}.current_credit_gbp
    format: "£%0.2f"
    
  # Measures
  
  - measure: count_users
    type: count_distinct
    sql: ${customer_id}
  
  - measure: count_newsletter_subscribers
    type: count_distinct
    sql: ${customer_id}
    filters:
      newsletter_opt_in: yes
  
  - measure: sum_referrals_sent
    type: sum
    sql: ${referrals_sent}
  
  - measure: sum_referrals_permitted
    type: sum
    sql: ${permitted_referrals}
    
  - measure: sum_referrals_left
    type: sum
    sql: ${referrals_left}
  
  - measure: percentage_referrals_sent
    type: number
    decimals: 2
    sql: 100.0 * ${sum_referrals_sent}/NULLIF(${sum_referrals_permitted},0)::REAL
    format: "%0.2f%"
  
  - measure: sum_signup_credit_granted
    type: sum
    sql: ${signup_credit}
    format: "%0.2f"
  
  - measure: sum_signup_credit_granted_gbp
    type: sum
    sql: ${signup_credit_gbp}
    format: "£%0.2f"
  
  - measure: sum_total_credit_granted_gbp
    type: sum
    sql: ${total_credit_granted_gbp}
    format: "£%0.2f"
    
  - measure: sum_total_credit_used_gbp
    type: sum
    sql: ${total_credit_used_gbp}
    format: "£%0.2f"
    
  - measure: sum_current_live_credit_gbp
    type: sum
    sql: ${current_credit_gbp}
    format: "£%0.2f"
