view: cml_orders {
  sql_table_name: cml.orders ;;

  dimension: alt_ref1 {
    type: string
    sql: ${TABLE}.alt_ref1 ;;
  }

  dimension: cust_ord {
    type: string
    sql: ${TABLE}.cust_ord ;;
  }

  dimension_group: date_add {
    type: time
    timeframes: [time, date, week, month]
    hidden: yes
    sql: ${TABLE}.date_add ;;
  }

  dimension: delivery_window {
    type: string
    sql: ${TABLE}.delivery_window ;;
  }

  dimension: failed_deliveries {
    type: number
    hidden: yes
    sql: ${TABLE}.failed_deliveries ;;
  }

  dimension: file_date {
    type: string
    sql: ${TABLE}.file_date ;;
  }

  dimension: flow_pros_code {
    type: string
    sql: ${TABLE}.flow_pros_code ;;
  }

  dimension_group: order_confirmation_shipped {
    type: time
    timeframes: [
      date,
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
    sql: ${TABLE}.ord_conf_date ;;
  }

  dimension_group: order_date {
    type: time
    timeframes: [
      date,
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
    sql: ${TABLE}.ord_date ;;
  }

  dimension: ord_number {
    type: string
    sql: ${TABLE}.ord_num ;;
  }

  dimension: order_quantity {
    type: number
    sql: ${TABLE}.ord_qty ;;
  }

  dimension: shipping_quantity {
    type: number
    sql: ${TABLE}.ship_qty ;;
  }

  dimension_group: order_time {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.time_ ;;
  }

  measure: total_orders_failed_times {
    type: sum
    sql: ${failed_deliveries} ;;
  }

  measure: total_orders {
    type: count_distinct
    sql: ${alt_ref1} ;;
  }

  measure: Percentage_of_failed_times {
    type: number
    sql: cast(${total_orders_failed_times} as decimal(20,10))/nullif(cast(${total_orders} as decimal(20,10)),0) ;;
    value_format: "#,##0.00"
  }

  measure: total_order_quantity {
    type: number
    sql: sum(${order_quantity}) ;;
  }

  measure: total_shipping_quantity {
    type: number
    sql: sum(${shipping_quantity}) ;;
  }

  measure: accuracy {
    type: number
    sql: cast(${total_shipping_quantity} as decimal(20,10))/nullif(cast(${total_order_quantity} as decimal (20,10)),0) ;;
    value_format: "#,##0.00"
  }
}
