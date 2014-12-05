- view: daily_data
  derived_table:
     sql: |
         select aaa.session_date as "date",
          aaa.logged_in_sessions,
          aaa.not_logged_in_sessions,
          aaa.total_sessions,
          aaa.new_visitor_sessions,
          aaa.returning_visitor_sessions,
          aaa.new_visitor_not_logged_in,
          bbb.count_referrals,
          ccc.count_sign_ups,
          ddd.count_orders,
          eee.count_leads
          
          from

          (select
          date(a.session_start_ts) as session_date,
          sum(case when b.logged_in_boolean = 1 then 1 else 0 end) as logged_in_sessions,
          sum(case when b.logged_in_boolean = 0 then 1 else 0 end) as not_logged_in_sessions,
          count(distinct a.domain_userid || '-' || a.domain_sessionidx) as total_sessions,
          sum(case when a.domain_sessionidx = 1 then 1 else 0 end) as new_visitor_sessions,
          sum(case when a.domain_sessionidx = 1 then 0 else 1 end) as returning_visitor_sessions,
          sum(case when a.domain_sessionidx = 1 and b.logged_in_boolean = 0 then 1 else 0 end) as new_visitor_not_logged_in
          from ${sessions.SQL_TABLE_NAME} a
          left join ${payment_funnel.SQL_TABLE_NAME} b
          on a.domain_userid = b.domain_userid
          and a.domain_sessionidx = b.domain_sessionidx
          group by 1) aaa
          
         inner join
         
         (select date(referral_sent_at) as referral_date,
         count(distinct email_address) as count_referrals
         from ${users_signup.SQL_TABLE_NAME}
         where date(referral_sent_at) is not null
         group by 1) bbb
         on aaa.session_date = bbb.referral_date
         
         inner join
         
         (select date(created_at) as sign_up_date,
         count(distinct email_address) as count_sign_ups
         from ${users_signup.SQL_TABLE_NAME}
         where signed_up = 'Yes'
         group by 1) ccc
         on aaa.session_date = ccc.sign_up_date
         
         inner join
         
         (select date(completed_at) as order_date,
         count(distinct order_id) as count_orders
         from ${spree_orders.SQL_TABLE_NAME}
         group by 1) ddd
         on aaa.session_date = ddd.order_date
         
         inner join
         
         (select date(created_at) as created_date,
         count(email_address) as count_leads
         from ${leads.SQL_TABLE_NAME}
         group by 1) eee
         
         on aaa.session_date = eee.created_date
         
     sql_trigger_value: SELECT COUNT(*) FROM ${spree_orders.SQL_TABLE_NAME}
     distkey: date
     sortkeys: [date]







  fields:

   - dimension_group: date
     type: time
     timeframes: [date, week, month]
     sql: ${TABLE}.date
    
   - measure: sum_logged_in_sessions
     type: sum
     sql: ${TABLE}.logged_in_sessions
  
   - measure: sum_not_logged_in_sessions
     type: sum
     sql: ${TABLE}.not_logged_in_sessions
     
   - measure: sum_total_sessions
     type: sum
     sql: ${TABLE}.total_sessions
     
   - measure: sum_new_visitor_sessions
     type: sum
     sql: ${TABLE}.new_visitor_sessions
     
   - measure: sum_returning_visitor_sessions
     type: sum
     sql: ${TABLE}.returning_visitor_sessions
     
   - measure: sum_new_visitor_not_logged_in
     type: sum
     sql: ${TABLE}.new_visitor_not_logged_in
     
   - measure: sum_referrals
     type: sum
     sql: ${TABLE}.count_referrals
     
   - measure: sum_sign_ups
     type: sum
     sql: ${TABLE}.count_sign_ups
     
   - measure: sum_orders
     type: sum
     sql: ${TABLE}.count_orders
     
   - measure: sum_leads
     type: sum
     sql: ${TABLE}.count_leads