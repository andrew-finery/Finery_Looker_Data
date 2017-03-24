view: mc_campaigns_tests {
  sql_table_name: marketing_data.mc_campaigns_tests ;;
  ### Dimensions

  dimension: test_id {
    type: string
    sql: ${TABLE}.test_id ;;
  }

  dimension: campaign_id {
    type: string
    sql: ${TABLE}.campaign_id ;;
  }

  dimension: test_type {
    type: string
    sql: ${TABLE}.test_type ;;
  }

  dimension_group: variate_send_time {
    type: time
    timeframes: [time, date, hour_of_day, week, month]
    sql: cast(${TABLE}.email_sent_time as datetime) ;;
  }

  dimension: variate_subject_line {
    type: string
    sql: ${TABLE}.subject_line ;;
  }

  dimension: variate_from_name {
    type: string
    sql: ${TABLE}.from_name ;;
  }

  dimension: variate_reply_to {
    type: string
    sql: ${TABLE}.reply_to ;;
  }

  dimension: variate_emails_sent {
    type: number
    sql: ${TABLE}.emails_sent ;;
  }

  dimension: variate_opens {
    type: number
    sql: ${TABLE}.opens ;;
  }

  dimension: variate_unique_opens {
    type: number
    sql: ${TABLE}.unique_opens ;;
  }

  dimension: variate_open_rate {
    type: number
    value_format_name: percent_2
    sql: ${variate_unique_opens}/NULLIF(${variate_emails_sent},0)::REAL ;;
  }

  dimension: variate_clicks {
    type: number
    sql: ${TABLE}.clicks ;;
  }

  dimension: variate_subscriber_clicks {
    type: number
    sql: ${TABLE}.subscriber_clicks ;;
  }

  dimension: variate_click_rate {
    type: number
    value_format_name: percent_2
    sql: ${variate_subscriber_clicks}/NULLIF(${variate_emails_sent},0)::REAL ;;
  }

  ### Measures

  measure: total_emails_sent {
    type: sum
    sql: ${variate_emails_sent} ;;
  }

  measure: total_opens {
    type: sum
    sql: ${variate_opens} ;;
  }

  measure: total_unique_opens {
    type: sum
    sql: ${variate_unique_opens} ;;
  }

  measure: total_clicks {
    type: sum
    sql: ${variate_clicks} ;;
  }

  measure: total_subscriber_clicks {
    type: sum
    sql: ${variate_subscriber_clicks} ;;
  }

  measure: open_rate {
    type: number
    value_format_name: percent_2
    sql: ${total_unique_opens}/NULLIF(${total_emails_sent},0)::REAL ;;
  }

  measure: click_rate {
    type: number
    value_format_name: percent_2
    sql: ${total_subscriber_clicks}/NULLIF(${total_emails_sent},0)::REAL ;;
  }

  measure: unique_campaigns_count {
    type: count_distinct
    sql: ${campaign_id} ;;
  }
}
