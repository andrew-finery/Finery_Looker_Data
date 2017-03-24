- view: redshift_load_errors
  sql_table_name: bi_data.redshift_load_errors
  fields:

  - dimension: column_length
    type: string
    sql: ${TABLE}.col_length

  - dimension: column_name
    type: string
    sql: ${TABLE}.colname

  - dimension: error_code
    type: number
    sql: ${TABLE}.err_code

  - dimension: error_reason
    type: string
    sql: ${TABLE}.err_reason

  - dimension: file_name
    type: string
    sql: ${TABLE}.filename

  - dimension: line_number
    type: number
    sql: ${TABLE}.line_number

  - dimension: position
    type: number
    sql: ${TABLE}.position

  - dimension: query
    type: number
    sql: ${TABLE}.query

  - dimension: raw_field_value
    type: string
    sql: ${TABLE}.raw_field_value

  - dimension: raw_line
    type: string
    sql: ${TABLE}.raw_line

  - dimension: session
    type: number
    sql: ${TABLE}.session

  - dimension: slice
    type: number
    sql: ${TABLE}.slice

  - dimension_group: start_time
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.starttime

  - dimension: table
    type: number
    sql: ${TABLE}.tbl

  - dimension: type
    type: string
    sql: ${TABLE}.type

  - dimension: user_id
    type: number
    sql: ${TABLE}.userid