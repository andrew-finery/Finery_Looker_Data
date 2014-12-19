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
        a.permitted_referrals,
        c.credit_amount as signup_credit,
        c.currency as signup_credit_currency,
        c.credit_amount_gbp as sign_credit_gbp,
        coalesce(b.total_credit_granted_gbp, '0') as total_credit_granted_gbp,
        coalesce(b.total_credit_used_gbp, '0') as total_credit_used_gbp,
        coalesce(b.current_credit_gbp, '0') as current_credit_gbp,
        d.referrals_sent 
        
        from
        
        (select * from daily_snapshot.spree_users where date(spree_timestamp) = current_date) a
        left join
        (select aaa.user_id, sum(aaa.amount * bbb.exchange_rate) as total_credit_granted_gbp, sum(aaa.amount_used * bbb.exchange_rate) as total_credit_used_gbp, sum(aaa.amount * bbb.exchange_rate) - sum(aaa.amount_used * bbb.exchange_rate) as current_credit_gbp from (select * from daily_snapshot.spree_store_credits where date(spree_timestamp) = current_date) aaa left join lookup.exchange_rates bbb on date(aaa.created_at) = bbb."date" and aaa.currency = bbb.currency group by 1) b
        on a.id = b.user_id
        
        left join
        (select aaa.email, aaa.credit_amount, aaa.currency, aaa.credit_amount * bbb.exchange_rate as credit_amount_gbp from (select * from daily_snapshot.spree_user_signup_awards where date(spree_timestamp) = current_date) aaa left join lookup.exchange_rates bbb on date(aaa.created_at) = bbb."date" and aaa.currency = bbb.currency) c
        on lower(a.email) = lower(c.email)
        
        left join
        (select sent_by_id as user_id, count(*) as referrals_sent from daily_snapshot.spree_invitations where date(spree_timestamp) = (select max(date(spree_timestamp)) from daily_snapshot.spree_invitations) and sent_by_id is not null group by 1) d
        on a.id = d.user_id
        
    sql_trigger_value: SELECT MAX(spree_timestamp) FROM daily_snapshot.spree_users
    distkey: user_id
    sortkeys: [user_id]


  fields:
     - dimension: user_id
       sql: ${TABLE}.user_id
#
#     - measure: total_profit
#       type: sum
#       sql: ${profit}
