- view: spree_customers
  sql_table_name: sales.customers

  fields:

    #####################################################################################################################################################
  ###################################################################  DIMENSIONS  ####################################################################
#####################################################################################################################################################

  - dimension: email
    sql: ${TABLE}.email
  
  - dimension_group: first_order
    label: First Order
    type: time
    timeframes: [date, week, month]
    sql: ${TABLE}.first_order_time

  - dimension: number_of_orders
    label: Number of Orders
    type: number
    sql: ${TABLE}.number_of_orders

  - dimension: has_repurchased
    type: yesno
    sql: ${number_of_orders} != 1
    
## Measures
    
  - measure: total_customers
    type: count_distinct
    sql: ${email}
    
  - measure: repurchasing_customers
    type: count_distinct
    sql: ${email}
    filters:
      has_repurchased: Yes

  - measure: non_repurchasing_customers
    type: count_distinct
    sql: ${email}
    filters:
      has_repurchased: No
      
  - measure: repurchase_rate
    type: number
    sql: ${repurchasing_customers}/NULLIF(${total_customers},0)::REAL
    value_format: '#0.00%'