- view: spree_users
  sql_table_name: sales.users

  fields:

##############################################################################################################################################################################
#################################################################### DIMENSIONS ##############################################################################################
##############################################################################################################################################################################

  - dimension: user_id
    sql: ${TABLE}.user_id
  
  - dimension: has_account
    type: yesno
    sql: ${user_id} is not null
  
  - dimension: email_address
    sql: ${TABLE}.email_address
  
  - dimension: customer_id
    type: int
    sql: ${TABLE}.user_id
    hidden: true
    
  - dimension_group: account_created_at
    type: time
    timeframes: [time, date, hour_of_day, hour, week, month]
    sql: ${TABLE}.created_at
    hidden: true
    
  - dimension: first_name
    sql: ${TABLE}.first_name
    
  - dimension: last_name
    sql: ${TABLE}.last_name

  - dimension: role
    sql: ${TABLE}.role
  
  - dimension: newsletter_opt_in
    type: yesno
    sql: ${TABLE}.newsletter_opt_in = 1
    hidden: true

  - dimension: sign_in_count
    sql: ${TABLE}.sign_in_count
    hidden: true
  
  - dimension_group: birth_date
    type: time
    timeframes: [date, month, year]
    sql: ${TABLE}.birth_date
    hidden: true
  
  - dimension: age
    type: int
    sql: |
          case when floor((current_date - ${birth_date_date})/ 365) > 100 then null
               when floor((current_date - ${birth_date_date})/ 365) < 10 then null
              else floor((current_date - ${birth_date_date})/ 365) end
  
  - dimension_group: last_sign_in_at
    type: time
    timeframes: [time, date, hour, week, month]
    sql: ${TABLE}.last_sign_in_at
    hidden: true

##############################################################################################################################################################################
#################################################################### MEASURES ################################################################################################
##############################################################################################################################################################################
  
  - measure: count_users
    type: count_distinct
    sql: ${customer_id}
  
  - measure: count_newsletter_subscribers
    type: count_distinct
    sql: ${customer_id}
    filters:
      newsletter_opt_in: yes
  
  - measure: average_age
    type: average
    sql: ${age}
  
  - measure: sum_referrals_sent
    type: sum
    sql: ${TABLE}.referrals_sent

  - measure: sum_total_credit_granted_gbp
    type: sum
    sql: ${TABLE}.total_credit_granted_gbp
    value_format: '#,##0.00'
    
  - measure: sum_total_credit_used_gbp
    type: sum
    sql: ${TABLE}.total_credit_used_gbp
    value_format: '#,##0.00'
    
  - measure: sum_current_live_credit_gbp
    type: sum
    sql: ${TABLE}.current_credit_gbp
    value_format: '#,##0.00'
