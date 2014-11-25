- view: register_success
  derived_table:
    sql: |
      select cast(a.customer_id as integer) as customer_id, b.collector_tstamp from 
      atomic.com_finerylondon_registration_success_1 a
      left join atomic.events b
      on a.root_id = b.event_id
      where b.app_id = 'production'
    
    
    sql_trigger_value: SELECT COUNT(*) FROM ${order_items.SQL_TABLE_NAME}
    distkey: customer_id
    sortkeys: [customer_id, collector_tstamp]


  fields:

  - dimension: customer_id
    type: int
    sql: ${TABLE}.customer_id
    
  - dimension_group: registration_time
    type: time
    timeframes: [time, date, hod, week, month]
    sql: ${TABLE}.collector_tstamp
    
  # Measures
  
  - measure: number_of_signups
    type: max
    sql: ${customer_id}
  