- view: spree_users
  sql_table_name: scratchpad.spree_users_temp
  fields:

  - dimension: id
    primary_key: true
    sql: ${TABLE}.id

  - dimension: email
    sql: ${TABLE}.email

  - dimension: first_name
    sql: ${TABLE}.first_name

  - dimension: last_name
    sql: ${TABLE}.last_name

  - measure: count
    type: count
    drill_fields: [id, first_name, last_name]

