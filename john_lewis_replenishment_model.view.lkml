view: john_lewis_replenishment_model {
  sql_table_name: john_lewis.replenishment_model ;;

  dimension: cover_option {
    type: number
    sql: ${TABLE}.cover_option ;;
  }

  dimension: initial_demand {
    type: number
    sql: ${TABLE}.demand ;;
  }

  dimension: final_demand_ecom_adjusted {
    type: number
    sql: ${TABLE}.demand_ecom_adjusted ;;
  }

  dimension: ean {
    type: string
    sql: ${TABLE}.ean ;;
  }

  dimension_group: first_intake_date_option {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.first_intake_date_option ;;
  }

  dimension: in_stock {
    type: number
    sql: ${TABLE}.in_stock ;;
  }

  dimension: items_sold_l4w {
    type: number
    sql: ${TABLE}.items_sold_l4w ;;
  }

  dimension: items_sold_l7d {
    type: number
    sql: ${TABLE}.items_sold_l7d ;;
  }

  dimension_group: last_replen_date_option {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.last_replen_date_option ;;
  }

  dimension: store_name {
    type: string
    sql: ${TABLE}.loc_name ;;
  }

  dimension_group: replen_model_run {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.run_at_date ;;
  }
}
