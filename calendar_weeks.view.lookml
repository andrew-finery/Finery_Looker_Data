- view: calendar_weeks
  sql_table_name: lookup.calendar
  fields:

  - dimension_group: calendar_date
    type: time
    timeframes: [date, day_of_week_index, week, month, month_num]
    convert_tz: false
    sql: ${TABLE}.calendar_date

  - dimension: year_week_number
    sql: ${TABLE}.year_week_number
  
  - dimension: year
    sql: ${TABLE}.year
    
  - dimension: week_number
    sql: ${TABLE}.week_number

