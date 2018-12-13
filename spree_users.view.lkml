view: spree_users {
  sql_table_name: sales.users ;;
  ##############################################################################################################################################################################
  #################################################################### DIMENSIONS ##############################################################################################
  ##############################################################################################################################################################################

  dimension: user_id {
    sql: ${TABLE}.user_id ;;
  }

  dimension: has_account {
    type: yesno
    sql: ${user_id} is not null ;;
  }

  dimension: has_store_credit {
    type: yesno
    sql: coalesce(${credit_balance_gbp},0)>0 ;;
  }

  dimension: email_address {
    sql: ${TABLE}.email_address ;;
  }

  dimension: customer_id {
    type: number
    sql: ${TABLE}.user_id ;;
    hidden: yes
  }

  dimension_group: account_created_at {
    type: time
    timeframes: [
      time,
      date,
      hour_of_day,
      hour,
      week,
      month
    ]
    sql: ${TABLE}.created_at ;;
    hidden: yes
  }

  dimension: first_name {
    sql: ${TABLE}.first_name ;;
  }

  dimension: last_name {
    sql: ${TABLE}.last_name ;;
  }

  dimension: role {
    sql: ${TABLE}.role ;;
  }

  dimension: vip_yes_no {
    label: "VIP"
    type: yesno
    sql: ${TABLE}.role = 'vip' ;;
  }

  dimension: has_sent_referral {
    type: yesno
    sql: coalesce(${TABLE}.referrals_sent,0)>0 ;;
  }

  dimension: credit_currency {
    sql: ${TABLE}.credit_currency ;;
  }

  dimension: credit_balance {
    value_format_name: decimal_2
    sql: ${TABLE}.credit_balance ;;
  }

  dimension: credit_balance_gbp {
    value_format_name: decimal_2
    sql: ${TABLE}.credit_balance_gbp ;;
  }

  ##############################################################################################################################################################################
  #################################################################### MEASURES ################################################################################################
  ##############################################################################################################################################################################

  measure: count_users {
    type: count_distinct
    sql: ${customer_id} ;;
  }

  measure: referrals_sent {
    type: sum
    sql: ${TABLE}.referrals_sent ;;
  }

  measure: sum_credit_balance_gbp {
    value_format_name: decimal_2
    type:  sum
    sql: ${TABLE}.credit_balance_gbp ;;
  }

  measure: sum_credit_balance {
    value_format_name: decimal_2
    type:  sum
    sql: ${TABLE}.credit_balance ;;
  }

}
