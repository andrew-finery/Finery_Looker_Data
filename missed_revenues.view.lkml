view: missed_revenues {
  sql_table_name: sales.missed_revenues ;;

  dimension_group: calendar {
    type: time
    timeframes: [
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    sql: ${TABLE}.calendar_date ;;
  }

  dimension: category_impressions {
    type: number
    sql: ${TABLE}.category_impressions ;;
    value_format_name: decimal_0
  }

  dimension: ean {
    type: string
    sql: ${TABLE}.ean ;;
  }

  dimension: gross_revenue {
    type: number
    sql: ${TABLE}.gross_revenue ;;
    value_format_name: decimal_2
  }

  dimension: missed_revs_impressions {
    type: number
    sql: ${TABLE}.missed_revs_impressions ;;
    value_format_name: decimal_2
  }

  dimension: missed_revs_views {
    type: number
    sql: ${TABLE}.missed_revs_views ;;
    value_format_name: decimal_2
  }

  dimension: missed_revenue {
    type: number
    sql: (${missed_revs_impressions} + ${missed_revs_views})*0.5 ;;
    value_format_name: decimal_2
  }

  dimension: oos_impressions {
    type: number
    sql: ${TABLE}.oos_impressions ;;
    value_format_name: decimal_0
  }

  dimension: oos_views {
    type: number
    sql: ${TABLE}.oos_views ;;
    value_format_name: decimal_0
  }

  dimension: product_views {
    type: number
    sql: ${TABLE}.product_views ;;
    value_format_name: decimal_0
  }

### Measures

  measure: gross_revenue_potential {
    type: sum
    sql: ${missed_revenue} + ${gross_revenue} ;;
    value_format_name: decimal_2
  }

  measure: gross_revenue_actual {
    type: sum
    sql: ${gross_revenue} ;;
    value_format_name: decimal_2
  }

  measure: gross_revenue_missed{
    type: sum
    sql: ${missed_revenue} ;;
    value_format_name: decimal_2
  }

  measure: missed_revenue_percentage{
    type: number
    sql: ${gross_revenue_missed}/${gross_revenue_potential} ;;
    value_format_name: percent_1
  }

  measure: product_views_total{
    type: sum
    sql: ${product_views} ;;
    value_format_name: decimal_0
  }

  measure: out_of_stock_product_views_total{
    type: sum
    sql: ${oos_views} ;;
    value_format_name: decimal_0
  }

  measure: out_of_stock_product_views_percentage{
    type: number
    sql: ${out_of_stock_product_views_total}/${product_views_total} ;;
    value_format_name: percent_1
  }

  measure: product_impressions_total{
    type: sum
    sql: ${category_impressions} ;;
    value_format_name: decimal_0
  }

  measure: out_of_stock_product_impressions_total{
    type: sum
    sql: ${oos_impressions} ;;
    value_format_name: decimal_0
  }

  measure: out_of_stock_product_impressions_percentage{
    type: number
    sql: ${out_of_stock_product_impressions_total}/${product_impressions_total} ;;
    value_format_name: percent_1
  }

}
