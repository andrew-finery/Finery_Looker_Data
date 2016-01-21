- view: redshift_load_errors
  sql_table_name: pg_catalog.stl_load_errors
  fields:

  - dimension: column_length
    type: string
    sql: ${TABLE}.col_length

  - dimension: column_name
    type: string
    sql: ${TABLE}.colname

  - dimension: error_code
    type: int
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
    type: int
    sql: ${TABLE}.position

  - dimension: query
    type: int
    sql: ${TABLE}.query

  - dimension: raw_field_value
    type: string
    sql: ${TABLE}.raw_field_value

  - dimension: raw_line
    type: string
    sql: ${TABLE}.raw_line

  - dimension: session
    type: int
    sql: ${TABLE}.session

  - dimension: slice
    type: int
    sql: ${TABLE}.slice

  - dimension_group: start_time
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.starttime

  - dimension: table
    type: int
    sql: ${TABLE}.tbl

  - dimension: type
    type: string
    sql: ${TABLE}.type

  - dimension: user_id
    type: int
    sql: ${TABLE}.userid

