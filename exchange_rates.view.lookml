- view: exchange_rates
  sql_table_name: lookup.exchange_rates
  fields:

  - dimension: currency
    sql: ${TABLE}.currency

  - dimension_group: date
    type: time
    timeframes: [date, week, month]
    convert_tz: false
    sql: ${TABLE}.date

  - dimension: exchange_rate
    type: number
    decimals: 4
    sql: ${TABLE}.exchange_rate
    
  - measure: count
    type: count
    sql: (*)

