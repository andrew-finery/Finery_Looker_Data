- view: register_success
  sql_table_name: atomic.com_finerylondon_registration_success_1

  fields:

  - dimension: event_id
    sql: ${TABLE}.root_id

  - dimension: register_method
    sql: ${TABLE}.register_method
    
  - dimension: customer_id
    sql: ${TABLE}.customer_id
