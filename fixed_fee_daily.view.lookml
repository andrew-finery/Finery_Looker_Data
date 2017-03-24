- view: fixed_fee_daily
  sql_table_name: affiliate_data.fixed_fee_daily
  fields:

  - dimension: date
    type: string
    sql: ${TABLE}.date

  - dimension: spend
    type: number
    sql: ${TABLE}.spend
    hidden: true

  - measure: total_spend
    type: sum
    value_format_name: decimal_2
    sql: ${spend}
    value_format: '#,##0.00'