- view: leads
  derived_table:
    sql: |
      select
        lower(leads.email) as email_address,
        min(date(leads.created_at)) as created_at
        
        from
        
        (select * from daily_snapshot.spree_leads where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_leads)) leads
        left join
        (select * from daily_snapshot.spree_users where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_users)) users
        on lower(leads.email) = lower(users.email)
        
        where users.email is null -- user hasn't signed up
        
        group by 1
        order by 2 asc

    sql_trigger_value: SELECT COUNT(*) FROM daily_snapshot.spree_leads
    distkey: email_address
    sortkeys: [email_address, created_at]
    
  
  fields:

  - dimension: email_address
    sql: ${TABLE}.email_address
  
  - dimension_group: created_at
    type: time
    timeframes: [time, date, hod, hour, week, month]
    sql: ${TABLE}.created_at
  
  - measure: count_leads
    type: count_distinct
    sql: ${email_address}
  
  - measure: leads_running_total
    type: running_total
    sql: ${count_leads}