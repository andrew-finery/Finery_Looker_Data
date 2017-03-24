view: website_product_click_through {
  sql_table_name: web.product_click_through ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: clicks {
    type: number
    sql: ${TABLE}.clicks ;;
  }

  dimension: domain_sessionidx {
    type: number
    sql: ${TABLE}.domain_sessionidx ;;
  }

  dimension: domain_userid {
    sql: ${TABLE}.domain_userid ;;
  }

  dimension: impression_source {
    sql: ${TABLE}.impression_source ;;
  }

  dimension: impression_type {
    sql: ${TABLE}.impression_type ;;
  }

  dimension: impressions {
    type: number
    sql: ${TABLE}.impressions ;;
  }

  dimension: style {
    sql: ${TABLE}.style ;;
  }

  measure: count {
    type: count
    drill_fields: [id]
  }
}
