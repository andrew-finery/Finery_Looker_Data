view: product_info_variants {
  sql_table_name: web.variant_info ;;

  dimension: bp_option_id {
    type: string
    sql: ${TABLE}.bp_option_id ;;
    hidden: yes
  }

  dimension: current_stock {
    type: number
    sql: ${TABLE}.current_stock ;;
  }

  dimension_group: deleted {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.deleted_at ;;
    hidden: yes
  }

  dimension: ean {
    type: string
    sql: ${TABLE}.ean ;;
  }

  dimension: option_id {
    sql: ${TABLE}.option_id ;;
  }

  dimension: product_id {
    type: number
    sql: ${TABLE}.product_id ;;
  }

  dimension: size {
    type: string
    sql: ${TABLE}.size ;;
  }

  dimension: total_landed_cost_gbp {
    type: number
    value_format_name: decimal_2
    sql: ${TABLE}.total_landed_cost_gbp ;;
  }

  dimension: variant_id {
    type: number
    sql: ${TABLE}.variant_id ;;
  }
}
