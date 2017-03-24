view: visitors {
  sql_table_name: web.visitors ;;
  # DIMENSIONS #

  # Basic dimensions #

  dimension: blended_user_id {
    sql: ${TABLE}.blended_user_id ;;
  }

  dimension: email_address {
    sql: case when ${TABLE}.blended_user_id like '%@%' then ${TABLE}.blended_user_id else null end ;;
  }

  dimension_group: first_touch {
    label: "First Touch"
    type: time
    timeframes: [
      time,
      hour,
      date,
      day_of_week,
      week,
      month
    ]
    sql: ${TABLE}.first_touch ;;
  }

  dimension_group: last_touch {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.last_touch ;;
  }

  dimension: days_since_last_visit {
    type: number
    sql: ${last_touch_date} - ${first_touch_date} ;;
  }

  dimension: has_visited_in_last_90_days {
    type: yesno
    sql: ${days_since_last_visit} < 91 ;;
  }

  dimension: has_visited_in_last_60_days {
    type: yesno
    sql: ${days_since_last_visit} < 61 ;;
  }

  dimension: has_visited_in_last_30_days {
    type: yesno
    sql: ${days_since_last_visit} < 31 ;;
  }

  dimension: has_visited_in_last_7_days {
    type: yesno
    sql: ${days_since_last_visit} < 8 ;;
  }

  dimension: events_during_lifetime {
    type: number
    sql: ${TABLE}.number_of_events ;;
  }

  dimension: events_during_lifetime_tiered {
    type: tier
    tiers: [
      1,
      5,
      10,
      25,
      50,
      100,
      1000,
      10000,
      100000
    ]
    sql: ${events_during_lifetime} ;;
  }

  dimension: number_of_visits {
    type: number
    sql: ${TABLE}.number_of_sessions ;;
  }

  dimension: number_of_visits_tiered {
    type: tier
    tiers: [
      1,
      2,
      5,
      10,
      25,
      50,
      100,
      1000
    ]
    sql: ${number_of_visits} ;;
  }

  dimension: visits_after_first_purchase {
    type: number
    sql: ${TABLE}.visits_after_first_purchase ;;
  }

  dimension: visits_after_first_purchase_tier {
    type: tier
    sql: ${visits_after_first_purchase} ;;
    tiers: [
      0,
      1,
      2,
      3,
      4,
      5,
      10,
      20,
      30,
      40,
      50
    ]
    style: integer
  }

  dimension: has_visited_after_first_purchase {
    type: yesno
    sql: ${visits_after_first_purchase} > 0 ;;
  }

  dimension: conversion_funnel_progress {
    sql: ${TABLE}.conversion_funnel_progress ;;
  }

  dimension: conversion_funnel_progress_after_first_purchase {
    sql: ${TABLE}.conversion_funnel_progress_after_first_purchase ;;
  }

  dimension: visits_to_make_first_purchase {
    type: number
    sql: ${TABLE}.visits_to_make_first_purchase ;;
  }

  dimension: visits_to_make_first_purchase_tier {
    type: tier
    sql: ${visits_to_make_first_purchase} ;;
    tiers: [
      1,
      2,
      3,
      4,
      5,
      10,
      20
    ]
    style: integer
  }

  # Landing page dimensions #

  dimension: landing_page_url_host {
    sql: ${TABLE}.page_urlhost ;;
  }

  dimension: landing_page_url_path {
    sql: ${TABLE}.page_urlpath ;;
  }

  dimension: landing_page_url {
    sql: ${TABLE}.page_urlhost || ${TABLE}.page_urlpath ;;
  }

  # Referer source dimensions #

  dimension: acquisition_channel {
    label: "First Touch Acquisition Channel"
    sql: ${TABLE}.acquisition_channel ;;
  }

  dimension: traffic_source {
    label: "First Touch CRM/Brand/Paid"

    case: {
      when: {
        sql: ${acquisition_channel} = 'CRM' ;;
        label: "CRM"
      }

      when: {
        sql: ${acquisition_channel} in ('SEM Non-Brand', 'Affiliates', 'Facebook - Paid Marketing') ;;
        label: "Paid"
      }

      else: "Brand"
    }
  }

  dimension: channel_grouping_3 {
    label: "First Touch Search + Direct / Facebook / Other"

    case: {
      when: {
        sql: ${acquisition_channel} in ('SEM Brand', 'Search', 'Direct') ;;
        label: "Search & Direct"
      }

      when: {
        sql: ${acquisition_channel} in ('Facebook - Paid Marketing') ;;
        label: "Facebook (Paid)"
      }

      else: "Other"
    }
  }

  dimension: referer_source {
    sql: ${TABLE}.refr_source_ga ;;
  }

  dimension: referer_term {
    sql: ${TABLE}.refr_term_ga ;;
  }

  dimension: referer_url_host {
    sql: ${TABLE}.refr_urlhost_ga ;;
  }

  dimension: referer_url_path {
    sql: ${TABLE}.refr_urlpath_ga ;;
  }

  # MKT fields (paid acquisition channels)

  dimension: campaign_medium {
    sql: ${TABLE}.mkt_medium_ga ;;
  }

  dimension: campaign_source {
    sql: ${TABLE}.mkt_source_ga ;;
  }

  dimension: campaign_term {
    sql: ${TABLE}.mkt_term_ga ;;
  }

  dimension: campaign_name {
    sql: ${TABLE}.mkt_campaign_ga ;;
  }

  # Measures #

  measure: total_visitors {
    type: count_distinct
    sql: ${blended_user_id} ;;
  }

  measure: total_visitors_last_90d {
    type: count_distinct
    sql: ${blended_user_id} ;;

    filters: {
      field: has_visited_in_last_90_days
      value: "yes"
    }
  }

  measure: total_visitors_last_60d {
    type: count_distinct
    sql: ${blended_user_id} ;;

    filters: {
      field: has_visited_in_last_60_days
      value: "yes"
    }
  }

  measure: total_visitors_last_30d {
    type: count_distinct
    sql: ${blended_user_id} ;;

    filters: {
      field: has_visited_in_last_30_days
      value: "yes"
    }
  }

  measure: total_visitors_last_7d {
    type: count_distinct
    sql: ${blended_user_id} ;;

    filters: {
      field: has_visited_in_last_7_days
      value: "yes"
    }
  }

  measure: total_events {
    type: sum
    sql: ${events_during_lifetime} ;;
  }

  measure: events_per_visitor {
    type: number
    value_format_name: decimal_2
    sql: ${total_events}/NULLIF(${total_visitors},0)::REAL ;;
  }

  measure: total_visits {
    type: sum
    sql: ${number_of_visits} ;;
  }

  measure: sessions_per_visitor {
    type: number
    value_format_name: decimal_2
    sql: ${total_visits}/NULLIF(${total_visitors},0)::REAL ;;
  }

  measure: total_visits_after_first_purchase {
    type: sum
    sql: ${visits_after_first_purchase} ;;
  }

  measure: avg_after_first_purchase {
    type: average
    sql: ${visits_after_first_purchase} ;;
  }
}
