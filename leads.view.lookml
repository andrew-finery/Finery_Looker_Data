- view: leads
  derived_table:
    sql: |
      select a.email_address, a.created_at

      from
      
      (select
      left(right(email, len(email)-1), len(email)-2) as email_address,
      min(cast (left(right(created_at, len(created_at)-1), len(created_at)-2) as timestamp)) as created_at
      from spree_leads
      group by 1) a
      
      left join ${users_signup.SQL_TABLE_NAME} b
      
      on a.email_address = b.email_address
      
      where b.email_address is null

    sql_trigger_value: SELECT COUNT(*) FROM spree_leads
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