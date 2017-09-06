view: calendar_weeks {
  sql_table_name: finery.calendar ;;

  dimension_group: calendar_date {
    label: "Calendar"
    type: time
    timeframes: [
      time,
      date,
      hour_of_day,
      hour,
      time_of_day,
      day_of_week_index,
      day_of_week,
      week,
      week_of_year,
      day_of_month,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year
    ]
    convert_tz: no
    sql: ${TABLE}.calendar_date ;;
  }

  dimension: year_week_number {
    label: "Year Week Number"
    sql: ${TABLE}.year_week_number ;;
  }

  dimension: year {
    label: "Year"
    sql: ${TABLE}.year ;;
  }

  dimension: week_number {
    label: "Week Number"
    type:  number
    sql: ${TABLE}.week_number;;
  }

  dimension: period {
    label: "Period"
    sql: ${TABLE}.period ;;
  }

  dimension: year_period_number {
    label: "Year Period"
    sql: ${TABLE}.year_period ;;
  }

  dimension: quarter {
    label: "Quarter"
    sql: ${TABLE}.quarter ;;
  }

  dimension: year_quarter_number {
    label: "Year Quarter"
    sql: ${TABLE}.year_quarter ;;
  }
}
