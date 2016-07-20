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

  - dimension: is_discounted_first_order
    type: yesno
    sql: ${first_order_promotion} is not null

  - dimension: first_order_store_credit
    type: number
    decimals: 2
    sql: ${TABLE}.first_order_store_credit

  - dimension: first_order_store_credit_flag
    type: yesno
    sql: ${first_order_store_credit} > 0

  - dimension: first_order_promotion_or_store_credit_flag
    type: yesno
    sql: ${first_order_store_credit} > 0 or ${first_order_promotion} is not null
    
  - dimension: first_order_currency
    sql: ${TABLE}.first_order_currency

  - dimension: first_order_gross_revenue
    type: number
    decimals: 2
    sql: ${TABLE}.first_order_gross_revenue

  - dimension: first_order_gross_revenue_tier
    type: tier
    sql: ${first_order_gross_revenue}
    tiers: [0,25,50,75,100,150,200,300]
    style: integer

# Second Order Info  
  - dimension_group: second_order
    type: time
    timeframes: [time, date, week, week_of_year, month, year]
    sql: ${TABLE}.second_order_time

  - dimension_group: second_order_id
    sql: ${TABLE}.second_order_id

  - dimension: second_order_promotion
    sql: ${TABLE}.second_order_promotion

  - dimension: is_discounted_second_order
    type: yesno
    sql: ${second_order_promotion} is not null

  - dimension: second_order_store_credit
    type: number
    decimals: 2
    sql: ${TABLE}.second_order_store_credit

  - dimension: second_order_store_credit_flag
    type: yesno
    sql: ${second_order_store_credit} > 0

  - dimension: second_order_promotion_or_store_credit_flag
    type: yesno
    sql: ${second_order_store_credit} > 0 or ${second_order_promotion} is not null

  - dimension: second_order_currency
    sql: ${TABLE}.second_order_currency

  - dimension: days_between_first_and_second_order
    type: int
    sql: ${second_order_date} - ${first_order_date}

  - dimension: days_between_first_and_second_order_tier
    type: tier
    sql: ${days_between_first_and_second_order}
    tiers: [0,30,60,90,120,150,180]
    style: integer

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
  
  - dimension: days_since_last_order
    type: int
    sql: current_date - ${last_order_date}

# Customer Status
  - dimension: days_between_first_and_last_order
    type: int
    sql: ${last_order_date} - ${first_order_date}
  
  - dimension: average_days_between_orders
    type: int
    sql: |
          case
          when ${number_of_orders} = 1 then null
          else ${days_between_first_and_last_order}/${number_of_orders}
          end
  
  - dimension: customer_status
    sql: |
          case
          when ${days_since_last_order} < 90 then 'Active'                                            -- around 66% of repurchasers make their second purchase within 90 days of their first, so people who have purchased in the last 90 days are deemed 'active'
          when ${days_since_last_order} < ${average_days_between_orders} then 'Active'                -- If someone hasn't purchased for less than the average amnount of time between their previous ordered, they are deemed 'active'
          when ${days_since_last_order} < 240 then 'At Risk'                                          -- 90% of repurchasers do so within 240 days.
          when ${days_since_last_order} < 2*${average_days_between_orders} then 'Active'              -- If someone hasn't ordered for between 1 and 2 of their typical repurchase periods, they are deemed 'At Risk'
          else 'Lapsed' end                                                                           -- If someone does not match the above criteria, they are deemed 'Lapsed'
          
  
# General Info
  - dimension: number_of_orders
    type: number
    sql: ${TABLE}.number_of_orders

  - dimension: number_of_orders_tier
    type: tier
    sql: ${number_of_orders}
    tiers: [0,1,2,3,4,5]
    style: integer
    
  - dimension: has_repurchased
    type: yesno
    sql: ${number_of_orders} != 1

  - dimension: orders_with_discount
    type: number
    sql: ${TABLE}.orders_with_discount

  - dimension: has_all_orders_discounted
    type: yesno
    sql: ${orders_with_discount} = ${number_of_orders}
    
  - dimension: items_purchased
    type: number
    sql: ${TABLE}.total_items_purchsed

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

  - dimension: total_gross_cogs_gbp
    type: number
    decimals: 2
    sql: ${TABLE}.total_gross_cogs_gbp
    hidden: true

  - dimension: total_net_cogs_gbp
    type: number
    decimals: 2
    sql: ${TABLE}.total_net_cogs_gbp
    hidden: true

  - dimension: total_gross_revenue_ex_discount_gbp
    label: CLV (gross) inc. vat, shipping
    type: number
    decimals: 2
    sql: ${TABLE}.total_gross_revenue_ex_discount_gbp

  - dimension: total_net_store_credit_used_gbp
    type: number
    decimals: 2
    sql: ${TABLE}.total_net_store_credit_used_gbp

  - dimension: total_vat_gbp
    type: number
    decimals: 2
    sql: ${TABLE}.total_vat_gbp

  - dimension: net_profit_pre_ops_and_markeing
    type: number
    decimals: 2
    sql: ${TABLE}.net_profit_pre_ops_and_markeing

  - dimension: top_customer_flag
    description: 'Definition of Top Customer: >£75 Lifetime Net Profit pre Ops/Marketing'
    type: yesno
    sql: ${TABLE}.top_customer_flag = 'Yes'

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

  - measure: count_repurchasing_customers_90d
    type: count_distinct
    sql: ${email}
    filters:
      has_repurchased: Yes
      days_between_first_and_second_order: <91

  - measure: count_repurchasing_customers_180d
    type: count_distinct
    sql: ${email}
    filters:
      has_repurchased: Yes
      days_between_first_and_second_order: <181

  - measure: count_non_repurchasing_customers
    type: count_distinct
    sql: ${email}
    filters:
      has_repurchased: No
      
  - measure: repurchase_rate
    type: number
    sql: ${count_repurchasing_customers}/NULLIF(${count_customers},0)::REAL
    value_format: '#0.00%'

  - measure: repurchase_rate_90d
    type: number
    sql: ${count_repurchasing_customers_90d}/NULLIF(${count_customers},0)::REAL
    value_format: '#0.00%'
        
  - measure: repurchase_rate_180d
    type: number
    sql: ${count_repurchasing_customers_90d}/NULLIF(${count_customers},0)::REAL
    value_format: '#0.00%'

# order info
  - measure: sum_orders
    type: sum
    sql: ${number_of_orders}
    
  - measure: orders_per_customer
    type: number
    sql: ${sum_orders}/NULLIF(${count_customers},0)::REAL
    value_format: '#0.00'    

  - measure: sum_discounted_orders
    type: sum
    sql: ${orders_with_discount}

  - measure: discounted_order_percentage
    type: number
    sql: ${sum_discounted_orders}/NULLIF(${sum_orders},0)::REAL
    value_format: '#0.00'   

  - measure: average_days_between_first_and_second_order
    type: average
    sql: ${days_between_first_and_second_order}

# items info
  - measure: total_items_purchased
    type: sum
    sql: ${items_purchased}

  - measure: total_items_returned
    type: sum
    sql: ${items_returned}
    
  - measure: return_rate
    type: number
    sql: ${total_items_returned}/NULLIF(${total_items_purchased},0)::REAL
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

  - measure: sum_net_profit_pre_ops_and_markeing
    type: sum
    decimals: 2
    sql: ${net_profit_pre_ops_and_markeing}
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