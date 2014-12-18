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
        coalesce(b.current_credit, '0') as current_credit,
        c.referrals_sent 
        
        from
        
        (select * from daily_snapshot.spree_users where date(spree_timestamp) = current_date) a
        left join
        (select user_id, sum(amount) - sum(amount_used) as current_credit from (select * from daily_snapshot.spree_store_credits where date(spree_timestamp) = current_date) group by 1) b
        on a.id = b.user_id
        
        left join
        (select sent_by_id as user_id, count(*) as referrals_sent from daily_snapshot.spree_invitations where date(spree_timestamp) = (select max(date(spree_timestamp)) from daily_snapshot.spree_invitations) and sent_by_id is not null group by 1) c
        on a.id = c.user_id
        
  sql_trigger_value: SELECT MAX(spree_timestamp) FROM daily_snapshot.spree_users
  distkey: user_id
  sortkeys: [user_id]


  fields:
# #     Define your dimensions and measures here, like this:
#     - dimension: profit
#       type: number
#       sql: ${TABLE}.profit
#
#     - measure: total_profit
#       type: sum
#       sql: ${profit}
