view: ometria_email_data {
  sql_table_name: marketing_data.ometria_email_data ;;

  dimension: bounce_class {
    type: string
    sql: ${TABLE}.bounce_class ;;
  }

  dimension: bounce_reason {
    type: string
    sql: ${TABLE}.bounce_reason ;;
  }

  dimension: campaign_title {
    type: string
    sql: ${TABLE}.campaign_title ;;
  }

  dimension: campaign_type {
    type: string
    sql: ${TABLE}.campaign_type ;;
  }

  dimension: delay_class {
    type: string
    sql: ${TABLE}.delay_class ;;
  }

  dimension: delay_reason {
    type: string
    sql: ${TABLE}.delay_reason ;;
  }

  dimension: device_type {
    type: string
    sql: ${TABLE}.device_type ;;
  }

  dimension: email_bounced {
    type: number
    sql: ${TABLE}.email_bounced ;;
  }

  dimension: email_clicked {
    type: number
    sql: ${TABLE}.email_clicked ;;
  }

  dimension: email_delayed {
    type: number
    sql: ${TABLE}.email_delayed ;;
  }

  dimension: email_id {
    type: string
    sql: ${TABLE}.email_id ;;
  }

  dimension: email_opened {
    type: number
    sql: ${TABLE}.email_opened ;;
  }

  dimension: first_click_timestamp {
    type: string
    sql: ${TABLE}.first_click_timestamp ;;
  }

  dimension: geo_city {
    type: string
    sql: ${TABLE}.geo_city ;;
  }

  dimension: geo_country {
    type: string
    sql: ${TABLE}.geo_country ;;
  }

  dimension: geo_timezone {
    type: string
    sql: ${TABLE}.geo_timezone ;;
  }

  dimension: number_of_clicks {
    type: number
    sql: ${TABLE}.number_of_clicks ;;
  }

  dimension: number_of_opens {
    type: number
    sql: ${TABLE}.number_of_opens ;;
  }

  dimension: open_timestamp {
    type: string
    sql: ${TABLE}.open_timestamp ;;
  }

  dimension_group: sent {
    type: time
    timeframes: [
      time,
      hour,
      date,
      hour_of_day,
      day_of_week,
      week,
      month,
      year
    ]
    sql: ${TABLE}.send_timestamp ;;
  }

  dimension: target_url {
    type: string
    sql: ${TABLE}.target_url ;;
  }

  dimension: email_address {
    type: string
    sql: ${TABLE}.to_address ;;
  }

# Measures

  measure: emails_sent   {
    type: count_distinct
    sql:${email_id};;
  }

  measure: distinct_email_addresses   {
    type: count_distinct
    sql:${email_address};;
  }

  measure: distinct_email_address_campaign   {
    type: count_distinct
    sql:${email_address}||${campaign_title};;
  }

  measure: distinct_opens   {
    type: count_distinct
    sql:${email_id};;

    filters: {
    field: number_of_opens
    value: ">0"
    }
  }

  measure: total_opens   {
    type: sum
    sql:${number_of_opens};;
  }

  measure: distinct_clicks   {
    type: count_distinct
    sql:${email_id};;

    filters: {
      field: number_of_clicks
      value: ">0"
    }
  }

  measure: total_clicks   {
    type: sum
    sql:${number_of_clicks};;
  }

  measure: open_rate {
    type: number
    value_format_name: percent_2
    sql: ${distinct_opens}/NULLIF(${emails_sent},0)::REAL ;;
  }

  measure: click_rate {
    type: number
    value_format_name: percent_2
    sql: ${distinct_clicks}/NULLIF(${emails_sent},0)::REAL ;;
  }

  measure: click_through_rate {
    type: number
    value_format_name: percent_2
    sql: ${distinct_clicks}/NULLIF(${distinct_opens},0)::REAL ;;
  }

}
