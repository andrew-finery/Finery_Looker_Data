view: website_product_stats {
  sql_table_name: web.product_stats ;;

  dimension: id {
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: clicks {
    type: number
    sql: ${TABLE}.category_clicks ;;
  }

  dimension: domain_sessionidx {
    type: number
    sql: ${TABLE}.domain_sessionidx ;;
  }

  dimension: domain_userid {
    sql: ${TABLE}.domain_userid ;;
  }

  dimension: impressions {
    type: number
    sql: ${TABLE}.category_impressions ;;
  }

  dimension: product_views {
    type: number
    sql: ${TABLE}.product_views ;;
  }

  dimension: quantity_purchased {
    type: number
    sql: ${TABLE}.quantity_purchased ;;
  }

  dimension: quick_views {
    type: number
    sql: ${TABLE}.quick_views ;;
  }

  dimension: gross_item_revenue {
    type: number
    value_format_name: decimal_2
    sql: ${TABLE}.gross_item_revenue ;;
    hidden: yes
  }

  dimension: gross_revenue_ex_voucher {
    type: number
    value_format_name: decimal_2
    sql: ${TABLE}.gross_revenue_ex_voucher ;;
    hidden: yes
  }

  dimension: gross_revenue_ex_voucher_and_vat {
    label: "Gross Revenue"
    type: number
    value_format_name: decimal_2
    sql: ${TABLE}.gross_revenue_ex_voucher_and_vat ;;
  }

  # Measures

  measure: sum_impressions {
    type: sum
    sql: ${impressions} ;;
  }

  measure: sum_clicks {
    type: sum
    sql: ${clicks} ;;
  }

  measure: sum_quick_views {
    type: sum
    sql: ${quick_views} ;;
  }

  measure: sum_product_views {
    type: sum
    sql: ${product_views} ;;
  }

  measure: sum_products_purchased {
    type: sum
    sql: ${quantity_purchased} ;;
  }

  measure: sum_gross_revenue {
    type: sum
    value_format_name: decimal_2
    sql: ${gross_revenue_ex_voucher_and_vat} ;;
  }

  measure: product_conversion_rate {
    type: number
    value_format_name: decimal_4
    sql: ${sum_products_purchased}/NULLIF(${sum_product_views},0)::REAL ;;
  }

  measure: product_click_through_rate {
    type: number
    value_format_name: decimal_4
    sql: ${sum_clicks}/NULLIF(${sum_impressions},0)::REAL ;;
  }

  measure: revenue_per_1k_impressions {
    type: number
    value_format_name: decimal_2
    sql: (1000 * ${sum_gross_revenue})/NULLIF(${sum_impressions},0)::REAL ;;
  }
}
