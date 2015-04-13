- view: calendar_weeks
  sql_table_name: finery.calendar
  fields:

  - dimension_group: calendar_date
    label: CALENDAR
    type: time
    timeframes: [date, day_of_week_index, week, month, month_num]
    convert_tz: false
    sql: ${TABLE}.calendar_date
    hidden: true

  - dimension: year_week_number
    label: YEAR WEEK NUMBER
    sql: ${TABLE}.year_week_number
  
  - dimension: year
    label: YEAR
    sql: ${TABLE}.year
    
  - dimension: week_number
    label: WEEK NUMBER
    sql: ${TABLE}.week_number
  
  - dimension: period
    label: PERIOD
    sql: ${TABLE}.period
    
  - dimension: year_period_number
    label: YEAR PERIOD
    sql: ${TABLE}.year_period
    
  - dimension: quarter
    label: QUARTER
    sql: ${TABLE}.quarter
  
  - dimension: year_quarter_number
    label: YEAR QUARTER NUMBER
    sql: ${TABLE}.year_quarter
    