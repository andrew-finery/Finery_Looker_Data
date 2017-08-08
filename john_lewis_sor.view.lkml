view: john_lewis_sor {
sql_table_name: john_lewis.sor_data ;;

# Dimensions

dimension: ean {
  type: string
  sql: ${TABLE}.ean ;;
}

  dimension_group: calendar {
    type: time
    timeframes: [
      date,
      day_of_week_index,
      week,
      week_of_year,
      day_of_month,
      month,
      month_num,
      year,
    ]
    sql: ${TABLE}.calendar_date ;;
  }

  dimension: jl_store_name {
    type: string
    sql: ${TABLE}.loc_name ;;
  }

  dimension: sales_units {
    type: number
    value_format_name: decimal_0
    sql: ${TABLE}.sales_units ;;
    hidden: yes
  }

  dimension: returns_units {
    type: number
    value_format_name: decimal_0
    sql: ${TABLE}.returns_units ;;
    hidden: yes
  }

  dimension: gross_revenue {
    type: number
    value_format_name: decimal_2
    sql: ${TABLE}.gross_revenue  ;;
    hidden: yes
  }

  dimension: refunds {
    type: number
    value_format_name: decimal_2
    sql: ${TABLE}.refunds ;;
    hidden: yes
  }

  dimension: units_delivered {
    type: number
    value_format_name: decimal_2
    sql: ${TABLE}.units_delivered ;;
    hidden: yes
  }

# Measures

  measure: sum_sales_units {
    type: sum
    sql: ${sales_units} ;;
  }

  measure: sum_returns_units{
    type: sum
    sql: ${returns_units} ;;
  }

  measure: sum_gross_revenue {
    type: sum
    sql: ${gross_revenue} ;;
  }

  measure: sum_refunds {
    type: sum
    sql: ${refunds} ;;
  }

  measure: sum_units_delivered {
    type: sum
    sql: ${units_delivered} ;;
  }

  measure: sum_net_sales_units {
    type: number
    sql: ${sum_sales_units} - ${sum_returns_units} ;;
  }

  measure: sum_net_revenue {
    type: number
    sql: ${sum_gross_revenue} - ${sum_refunds} ;;
  }

  measure: derived_stock_units {
    type: sum
    sql: ${TABLE}.derived_closing_stock;;
  }

  measure: derived_stock_units_closing_yesterday {
    type: sum
    sql: ${TABLE}.derived_closing_stock;;

    filters: {
      field: calendar_date
      value: "yesterday"
    }
  }

}
