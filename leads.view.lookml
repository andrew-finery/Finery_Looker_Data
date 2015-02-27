- view: leads
  derived_table:
    sql: |
        SELECT lower(leads.email) AS email_address,
               MIN(DATE (leads.created_at)) AS created_at
        FROM (SELECT *
              FROM daily_snapshot.spree_leads
              WHERE spree_timestamp = (SELECT MAX(spree_timestamp) FROM daily_snapshot.spree_leads)) leads
          LEFT JOIN (SELECT *
                     FROM daily_snapshot.spree_users
                     WHERE spree_timestamp = (SELECT MAX(spree_timestamp) FROM daily_snapshot.spree_users)) users ON lower (leads.email) = lower (users.email)
          LEFT JOIN emails_to_exclude excl ON lower (excl.email_address) = lower (leads.email)
        WHERE users.email IS NULL
        -- user hasn't signed up
        AND   excl.email_address IS NULL
        GROUP BY 1

    sql_trigger_value: SELECT COUNT(*) FROM daily_snapshot.spree_leads
    distkey: email_address
    sortkeys: [email_address, created_at]
    
  
  fields:

  - dimension: email_address
    sql: ${TABLE}.email_address
  
  - dimension_group: created_at
    type: time
    timeframes: [time, date, hour, week, month]
    sql: ${TABLE}.created_at
  
  - measure: count_leads
    type: count_distinct
    sql: ${email_address}
  
  - measure: leads_running_total
    type: running_total
    sql: ${count_leads}