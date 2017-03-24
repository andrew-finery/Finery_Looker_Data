view: facebook_daily_ad_reach {
  sql_table_name: facebook_data.daily_ad_reach ;;

  dimension: add_id {
    type: string
    sql: ${TABLE}.add_id ;;
  }

  dimension: date {
    type: string
    sql: ${TABLE}.date ;;
  }

  dimension: frequency {
    type: string
    sql: ${TABLE}.frequency ;;
  }

  dimension: reach {
    type: number
    sql: ${TABLE}.reach ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }

  measure: total_reach {
    type: sum
    sql: ${reach} ;;
  }
}
