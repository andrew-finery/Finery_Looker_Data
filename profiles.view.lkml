view: profiles {
  sql_table_name: ometria_data.profiles ;;

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: customer_id {
    type: string
    sql: ${TABLE}.customer_id ;;
  }

  dimension: date_acquired {
    type: string
    sql: ${TABLE}.date_acquired ;;
  }

  dimension: date_marketing_optin {
    type: string
    sql: ${TABLE}.date_marketing_optin ;;
  }

  dimension: date_of_birth {
    type: string
    sql: ${TABLE}.date_of_birth ;;
  }

  dimension: dates_account_created {
    type: string
    sql: ${TABLE}.dates_account_created ;;
  }

  dimension: dates_marketing_optout {
    type: string
    sql: ${TABLE}.dates_marketing_optout ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: firstname {
    type: string
    sql: ${TABLE}.firstname ;;
  }

  dimension: lastname {
    type: string
    sql: ${TABLE}.lastname ;;
  }

  measure: count {
    type: count
    drill_fields: [id, lastname, firstname]
  }
}
