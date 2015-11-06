- view: spree_refunds
  sql_table_name: sales.refunds

  fields:
#  Dimensions
  - dimension: order_id
    sql: ${TABLE}.order_id
    
  - dimension: currency
    sql: ${TABLE}.currency
       
  - dimension: refund_method
    sql_case:
      Credit Card: ${TABLE}.payment_method_id = 1
      PayPal: ${TABLE}.payment_method_id = 2
      Store Credit: ${TABLE}.payment_method_id = 3
    
  - dimension_group: refund_processed_at
    type: time
    timeframes: [time, date, hour, week, month]
    sql: ${TABLE}.refund_processed_at
       
  - dimension: amount_refunded
    type: number
    decimals: 2
    sql: ${TABLE}.amount_refunded
    value_format: '##0.00'
       
  - dimension: amount_refunded_gbp
    type: number
    decimals: 2
    sql: ${TABLE}.amount_refunded_gbp
    value_format: '##0.00'
  
    


#  Measures
  - measure: count_orders
    type: count_distinct
    sql: ${order_id}
       
  - measure: total_refunded
    type: sum
    sql: ${amount_refunded}
    value_format: '##0.00'
           
  - measure: total_refunded_gbp
    type: sum
    decimals: 2
    sql: ${amount_refunded_gbp}
    value_format: '##0.00'
