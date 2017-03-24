view: mc_campaign_member_activity {
  sql_table_name: marketing_data.mc_member_activity ;;

  dimension: campaign_id {
    sql: ${TABLE}.campaign_id ;;
  }

  dimension: email_address {
    sql: ${TABLE}.member_email_address ;;
  }

  dimension: opens {
    type: number
    sql: ${TABLE}.opens ;;
    hidden: yes
  }

  dimension: clicks {
    type: number
    sql: ${TABLE}.clicks ;;
    hidden: yes
  }

  # Measures

  measure: emails_sent {
    type: count_distinct
    sql: ${email_address} || ${campaign_id} ;;
  }

  measure: unique_clicks_total {
    type: count_distinct
    sql: ${email_address} || ${campaign_id} ;;

    filters: {
      field: clicks
      value: ">0"
    }
  }

  measure: unique_opens_total {
    type: count_distinct
    sql: ${email_address} || ${campaign_id} ;;

    filters: {
      field: opens
      value: ">0"
    }
  }

  measure: open_rate {
    type: number
    value_format_name: percent_2
    sql: ${unique_opens_total}/${emails_sent}::REAL ;;
  }

  measure: click_rate {
    type: number
    value_format_name: percent_2
    sql: ${unique_clicks_total}/${emails_sent}::REAL ;;
  }

  measure: opens_total {
    type: sum
    sql: ${opens} ;;
  }

  measure: clicks_total {
    type: sum
    sql: ${clicks} ;;
  }
}
