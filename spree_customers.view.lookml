- view: spree_customers
  sql_table_name: sales.customers

  fields:

    #####################################################################################################################################################
  ###################################################################  DIMENSIONS  ####################################################################
#####################################################################################################################################################

  - dimension: email
    sql: ${TABLE}.email

# First Order Info  
  - dimension_group: first_order
    type: time
    timeframes: [time, date, week, week_of_year, month, year]
    sql: ${TABLE}.first_order_time

  - dimension_group: first_order_id
    sql: ${TABLE}.first_order_id

  - dimension: first_order_promotion
    sql: ${TABLE}.first_order_promotion

  - dimension: first_order_currency
    sql: ${TABLE}.first_order_currency

# Last Order Info
  - dimension_group: last_order
    type: time
    timeframes: [time, date, week, week_of_year, month, year]
    sql: ${TABLE}.last_order_time

  - dimension_group: last_order_id
    sql: ${TABLE}.last_order_id

  - dimension: last_order_promotion
    sql: ${TABLE}.last_order_promotion

  - dimension: last_order_currency
    sql: ${TABLE}.last_order_currency

# General Info
  - dimension: number_of_orders
    type: number
    sql: ${TABLE}.number_of_orders

  - dimension: has_repurchased
    type: yesno
    sql: ${number_of_orders} != 1

  - dimension: orders_with_discount
    type: number
    sql: ${TABLE}.orders_with_discount

  - dimension: all_orders_with_discount
    type: yesno
    sql: ${orders_with_discount} = ${number_of_orders}
    
  - dimension: items_purchased
    type: number
    sql: ${TABLE}.total_items_purchased

  - dimension: items_returned
    type: number
    sql: ${TABLE}.total_items_returned
 
  - dimension: fully_returned_orders
    type: number
    sql: ${TABLE}.fully_returned_orders

  - dimension: all_orders_returned
    type: yesno
    sql: ${fully_returned_orders} = ${number_of_orders}

  - dimension: total_gross_revenue_pre_discount_ex_shipping
    type: number
    decimals: 2
    sql: ${TABLE}.total_gross_revenue_pre_discount_ex_shipping
    hidden: true

  - dimension: total_gross_revenue_ex_discount_ex_shipping
    label: Customer Gross Revenue
    type: number
    decimals: 2
    sql: ${TABLE}.total_gross_revenue_ex_discount_ex_shipping

  - dimension: total_gross_revenue_ex_discount_ex_vat_ex_shipping
    label: Customer Gross Revenue ex. VAT
    type: number
    decimals: 2
    sql: ${TABLE}.total_gross_revenue_ex_discount_ex_vat_ex_shipping

  - dimension: total_shipping_revenue
    type: number
    sql: ${TABLE}.total_shipping_revenue
    hidden: true

  - dimension: total_store_credit_used
    type: number
    decimals: 2
    sql: ${TABLE}.total_store_credit_used
    hidden: true

  - dimension: total_refunded
    type: number
    decimals: 2
    sql: ${TABLE}.total_refunded
    hidden: true

  - dimension: total_store_credit_refunded
    type: number
    decimals: 2
    sql: ${TABLE}.total_store_credit_refunded
    hidden: true

  - dimension: total_cash_refunded
    type: number
    decimals: 2
    sql: ${TABLE}.total_cash_refunded
    hidden: true

  - dimension: net_revenue
    type: number
    decimals: 2
    sql: ${total_gross_revenue_ex_discount_ex_shipping} - ${total_refunded}

################################################################################################################    
  ############################################ Measures ##########################################################
    ################################################################################################################     

  - measure: count_customers
    type: count_distinct
    sql: ${email}

# repurchase rate stuff    
  - measure: count_repurchasing_customers
    type: count_distinct
    sql: ${email}
    filters:
      has_repurchased: Yes

  - measure: count_non_repurchasing_customers
    type: count_distinct
    sql: ${email}
    filters:
      has_repurchased: No
      
  - measure: repurchase_rate
    type: number
    sql: ${count_repurchasing_customers}/NULLIF(${count_customers},0)::REAL
    value_format: '#0.00%'

# order info
  - measure: sum_orders
    type: sum
    sql: ${number_of_orders}
    
  - measure: orders_per_customer
    type: number
    sql: ${sum_orders}/NULLIF(${count_customers},0)::REAL
    value_format: '#0.00'    

  - dimension: sum_discounted_orders
    type: sum
    sql: ${orders_with_discount}

  - measure: discounted_order_percentage
    type: number
    sql: ${sum_discounted_orders}/NULLIF(${sum_orders},0)::REAL
    value_format: '#0.00'   

# items info
  - measure: sum_items_purchased
    type: sum
    sql: ${items_purchased}

  - measure: sum_items_returned
    type: sum
    sql: ${items_returned}
    
  - measure: return_rate
    type: number
    sql: ${items_returned}/NULLIF(${sum_items_purchased},0)::REAL
    value_format: '#0.00%'
    
#revenue info
  - measure: sum_gross_revenue_pre_discount_ex_shipping
    type: sum
    decimals: 2
    sql: ${total_gross_revenue_pre_discount_ex_shipping}
    value_format: '#,##0.00'
    hidden: true
    
  - measure: sum_gross_revenue
    type: sum
    decimals: 2
    sql: ${total_gross_revenue_ex_discount_ex_shipping}
    value_format: '#,##0.00'
    
  - measure: sum_gross_revenue_ex_vat
    type: sum
    decimals: 2
    sql: ${total_gross_revenue_ex_discount_ex_vat_ex_shipping}
    value_format: '#,##0.00'

  - measure: sum_shipping_revenue
    type: sum
    decimals: 2
    sql: ${total_shipping_revenue}
    value_format: '#,##0.00'
    hidden: true
    
  - measure: sum_store_credit_used
    type: sum
    sql: ${total_store_credit_used}
    value_format: '#,##0.00'
    hidden: true
    
  - measure: sum_amount_refunded
    type: sum
    decimals: 2
    sql: ${total_refunded}
    value_format: '#,##0.00'
    
  - measure: sum_store_credit_refunded
    type: sum
    decimals: 2
    sql: ${total_store_credit_refunded}
    value_format: '#,##0.00'
    hidden: true

  - measure: sum_cash_refunded
    type: sum
    decimals: 2
    sql: ${total_cash_refunded}
    value_format: '#,##0.00'
    hidden: true

  - measure: sum_net_revenue
    type: number
    decimals: 2
    sql: ${sum_gross_revenue} - ${sum_amount_refunded}
    value_format: '#,##0.00'

# avg revenue info
  - measure: avg_basket_gross
    type: number
    decimals: 2
    sql: ${sum_gross_revenue}/NULLIF(${sum_orders},0)::REAL
    value_format: '#0.00'    

  - measure: gross_revenue_per_customer
    type: number
    decimals: 2
    sql: ${sum_gross_revenue}/NULLIF(${count_customers},0)::REAL
    value_format: '#0.00'  

  - measure: avg_basket_net
    type: number
    decimals: 2
    sql: ${sum_net_revenue}/NULLIF(${sum_orders},0)::REAL
    value_format: '#0.00'
    
  - measure: net_revenue_per_customer
    type: number
    decimals: 2
    sql: ${sum_net_revenue}/NULLIF(${count_customers},0)::REAL
    value_format: '#0.00'  