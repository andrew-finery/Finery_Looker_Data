- view: affiliate_lookup
  sql_table_name: affiliate_data.lookup_table
  fields:

  - dimension: affiliate_id
    type: number
    sql: ${TABLE}.affiliate_id

  - dimension: affiliate_name
    type: string
    sql: ${TABLE}.affiliate_name
