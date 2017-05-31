view: daily_chapters_stats {
  sql_table_name: web.daily_chapters_stats ;;

  dimension: bounces {
    type: number
    sql: ${TABLE}.bounces ;;
    hidden: yes
  }

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

  dimension: engaged_sessions {
    type: number
    sql: ${TABLE}.engaged_sessions ;;
    hidden: yes
  }

  dimension: lands {
    type: number
    sql: ${TABLE}.lands ;;
    hidden: yes
  }

  dimension: exits {
    type: number
    sql: ${TABLE}.exits ;;
    hidden: yes
  }

  dimension: orders {
    type: number
    sql: ${TABLE}.orders ;;
    hidden: yes
  }

  dimension: chapter_url {
    type: string
    sql: ${TABLE}.page_urlpath ;;
  }

  dimension: page_views {
    type: number
    sql: ${TABLE}.page_views ;;
    hidden: yes
  }

  dimension: revenue {
    type: number
    sql: ${TABLE}.revenue ;;
    hidden: yes
  }

  dimension: unique_page_views {
    type: number
    sql: ${TABLE}.unique_page_views ;;
    hidden: yes
  }


  measure: total_bounces {
    type: sum
    sql: ${bounces} ;;
  }

  measure: total_engaged_sessions {
    type: sum
    sql: ${engaged_sessions} ;;
  }

  measure: total_lands {
    type: sum
    sql: ${lands} ;;
  }

  measure: total_orders {
    type: sum
    sql: ${orders} ;;
  }

  measure: total_page_views {
    type: sum
    sql: ${page_views} ;;
  }

  measure: total_revenue {
    type: sum
    value_format_name:decimal_2
    sql: ${revenue} ;;
  }

  measure: total_unique_page_views {
    type: sum
    sql: ${unique_page_views} ;;
  }

  measure: total_exits {
    type: sum
    sql: ${exits} ;;
  }

  measure: bounce_rate {
    type: number
    value_format_name: percent_2
    sql: ${total_bounces}/NULLIF(${total_lands},0)::REAL ;;
  }

  measure: engagement_rate {
    type: number
    value_format_name: percent_2
    sql: ${total_engaged_sessions}/NULLIF(${total_unique_page_views},0)::REAL ;;
  }

  measure: conversion_rate {
    type: number
    value_format_name: percent_2
    sql: ${total_orders}/NULLIF(${total_unique_page_views},0)::REAL ;;
  }

  measure: exit_rate {
    type: number
    value_format_name: percent_2
    sql: ${total_exits}/NULLIF(${total_page_views},0)::REAL ;;
  }

  measure: average_order_value {
    type: number
    value_format_name: decimal_2
    sql: ${total_revenue}/NULLIF(${total_orders},0)::REAL ;;
  }

  measure: revenue_per_unique_page_view {
    type: number
    value_format_name: decimal_2
    sql: ${total_revenue}/NULLIF(${total_unique_page_views},0)::REAL ;;
  }

}
