view: spree_refunds {
  sql_table_name: sales.refunds ;;
  #  Dimensions
  dimension: order_id {
    sql: ${TABLE}.order_id ;;
  }

  dimension: currency {
    sql: ${TABLE}.currency ;;
  }

  dimension: refund_method {
    case: {
      when: {
        sql: ${TABLE}.payment_method_id = 1 ;;
        label: "Credit Card"
      }

      when: {
        sql: ${TABLE}.payment_method_id = 2 ;;
        label: "PayPal"
      }

      when: {
        sql: ${TABLE}.payment_method_id = 3 ;;
        label: "Store Credit"
      }
    }
  }

  dimension_group: refund_processed_at {
    type: time
    timeframes: [time, date, hour, week, month]
    sql: ${TABLE}.refund_processed_at ;;
  }

  dimension: amount_refunded {
    type: number
    value_format_name: decimal_2
    sql: ${TABLE}.amount_refunded ;;
  }

  dimension: amount_refunded_gbp {
    type: number
    value_format_name: decimal_2
    sql: ${TABLE}.amount_refunded_gbp ;;
  }

  #  Measures
  measure: count_orders {
    type: count_distinct
    sql: ${order_id} ;;
  }

  measure: total_refunded {
    type: sum
    sql: ${amount_refunded} ;;
    value_format: "##0.00"
  }

  measure: total_refunded_gbp {
    type: sum
    value_format_name: decimal_2
    sql: ${amount_refunded_gbp} ;;
  }
}
