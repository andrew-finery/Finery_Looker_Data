view: website_leads {
  sql_table_name: info.all_leads ;;

  dimension: email_address {
    type: string
    sql: ${TABLE}.email_address ;;
  }

  measure: count_leads {
    type: count_distinct
    sql: ${email_address} ;;
  }
}
