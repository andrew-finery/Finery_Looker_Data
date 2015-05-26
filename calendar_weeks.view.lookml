- view: calendar_weeks
  sql_table_name: finery.calendar
  fields:

  - dimension_group: calendar_date
    label: Calendar
    type: time
    timeframes: [date, day_of_week_index, week, month, month_num]
    convert_tz: false
    sql: ${TABLE}.calendar_date

  - dimension: year_week_number
    label: Year Week Number
    sql: ${TABLE}.year_week_number
  
  - dimension: year
    label: Year
    sql: ${TABLE}.year
    
  - dimension: week_number
    label: Week Number
    sql: ${TABLE}.week_number
  
  - dimension: period
    label: Period
    sql: ${TABLE}.period
    
  - dimension: year_period_number
    label: Year Period
    sql: ${TABLE}.year_period
    
  - dimension: quarter
    label: Quarter
    sql: ${TABLE}.quarter
  
  - dimension: year_quarter_number
    label: Year Quarter
    sql: ${TABLE}.year_quarter
    