view: snowplow_transaction_attribution {
  sql_table_name: web.order_attribution ;;
  ###################################################################################################################################
  ################################## DIMENSIONS #####################################################################################
  ###################################################################################################################################

  dimension: user_id {
    sql: ${TABLE}.domain_userid ;;
    hidden: yes
  }

  dimension: domain_session_index {
    sql: ${TABLE}.domain_sessionidx ;;
    hidden: yes
  }

  dimension: order_id {
    sql: ${TABLE}.order_id ;;
  }

  dimension: attribution_ratio {
    type: number
    value_format_name: decimal_4
    sql: ${TABLE}.attribution_percentage * 0.0001 ;;
  }

  ###################################################################################################################################
  ################################## MEASURES #######################################################################################
  ###################################################################################################################################

  measure: attributed_orders {
    type: sum
    value_format_name: decimal_2
    sql: ${attribution_ratio} ;;
  }

  measure: attributed_new_customers {
    type: sum
    value_format_name: decimal_2
    sql: ${attribution_ratio} ;;

    filters: {
      field: transactions.new_customer_flag
      value: "yes"
    }
  }

  measure: attributed_revenue_ex_discount_ex_vat {
    label: "Attributed Revenue ex. discount, VAT"
    type: sum
    value_format_name: decimal_2
    sql: ${attribution_ratio} * ${transactions.revenue_ex_voucher_and_vat} / ${transactions.exchange_rate} ;;
  }
}
