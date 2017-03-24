view: scripts_bi_server {
  sql_table_name: finery.scripts_log_bi_server ;;
  # Dimensions

  dimension: name {
    sql: ${TABLE}.name ;;
  }

  dimension_group: script_end {
    type: time
    timeframes: [
      time,
      date,
      week,
      week_of_year,
      month,
      year
    ]
    sql: cast(${TABLE}.end_time as datetime) ;;
  }

  dimension_group: script_start {
    type: time
    timeframes: [
      time,
      date,
      week,
      week_of_year,
      month,
      year
    ]
    sql: cast(${TABLE}.start_time as datetime) ;;
  }

  dimension: duration_seconds {
    type: number
    value_format_name: decimal_2
    sql: datediff(seconds,cast(${TABLE}.start_time as datetime),cast(${TABLE}.end_time as datetime)) ;;
  }

  dimension: duration_minutes {
    type: number
    value_format_name: decimal_2
    sql: ${duration_seconds}/cast('60' as decimal (10,4)) ;;
  }

  # Measures

  measure: unique_script_runs_total {
    type: count_distinct
    sql: ${name} || ${script_start_time} ;;
  }

  measure: unique_scripts_total {
    type: count_distinct
    sql: ${name} ;;
  }

  measure: scripts_started_total {
    type: count_distinct
    sql: ${name} || ${script_start_time} ;;

    filters: {
      field: script_start_time
      value: "-NULL"
    }
  }

  measure: scripts_finished_total {
    type: count_distinct
    sql: ${name} || ${script_start_time} ;;

    filters: {
      field: script_end_time
      value: "-NULL"
    }
  }

  measure: average_script_run_time_minutes {
    type: average
    value_format_name: decimal_2
    sql: ${duration_minutes} ;;
  }
}
