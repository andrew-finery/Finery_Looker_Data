- view: transactions
  derived_table:
    sql: select * from web.orders where domain_userid is not null and domain_sessionidx is not null
  fields:

    ###########################################################################################################################################################
  #############################################################  DIMENSIONS  ################################################################################
###########################################################################################################################################################

  - dimension: domain_userid
    sql: ${TABLE}.domain_userid
    hidden: true

  - dimension: domain_sessionidx
    type: int
    sql: ${TABLE}.domain_sessionidx
    hidden: true

  - dimension_group: trans_time
    label: Order Placed
    type: time
    timeframes: [time, hour, date, hour_of_day, day_of_week, week, month]
    sql: ${TABLE}.collector_tstamp
    
  - dimension: customer_id
    sql: ${TABLE}.customer_id
    hidden: true
  
  - dimension: currency_code
    sql: ${TABLE}.currency
    hidden: true
  
  - dimension: exchange_rate
    sql: ${TABLE}.exchange_rate
    hidden: true
  
  - dimension: order_id
    sql: ${TABLE}.order_id

  - dimension: order_code
    sql: ${TABLE}.order_code
  
  
  - dimension: revenue_inc_vat
    sql: ${TABLE}.order_total
    hidden: true
     
  - dimension: shipping
    sql: ${TABLE}.shipment_total
    hidden: true
  
  - dimension: primary_promo_code
    sql: ${TABLE}.promotion
    
  - dimension: revenue_ex_coupon_and_vat
    label: Revenue ex. Discount, VAT
    sql: ${TABLE}.order_total - ${shipping} - ${TABLE}.included_tax_total
    
  - dimension: number_of_items
    type: int
    sql: ${TABLE}.item_count
  
  - dimension: items_returned
    type: int
    sql: ${TABLE}.items_returned

  - dimension: new_customer_flag
    type: yesno
    sql: ${TABLE}.order_sequence_number = 1

  - dimension: reason_to_strip_out
    sql: ${TABLE}.reason_to_strip_out
    hidden: true
  
###########################################################################################################################################################
  #############################################################  MEASURES  ##################################################################################
    ###########################################################################################################################################################
    
  - measure: count_transactions
    label: Orders Total
    type: count_distinct
    sql: ${order_id}
    filters:
      reason_to_strip_out: 'NULL'
      
  - measure: transactions_percent_of_total
    label: Orders Percent of Total
    type: percent_of_total
    sql: ${count_transactions}

  - measure: count_new_customers
    label: New Customers Total
    type: count_distinct
    sql: ${order_id}
    filters:
      new_customer_flag: yes
  
  - measure: count_customers
    label: Customer Total
    type: count_distinct
    sql: ${TABLE}.blended_email
    filters:
      reason_to_strip_out: NULL
      
  - measure: gross_revenue_ex_discount_ex_vat
    label: Gross Revenue ex. Discount, VAT Total
    type: sum
    decimals: 2
    sql: ${revenue_ex_coupon_and_vat} / ${exchange_rate}
    value_format: '#,##0.00'
    filters:
      reason_to_strip_out: 'NULL'

  - measure: total_items_purchased
    type: sum
    sql: ${number_of_items}
    
  - measure: total_items_returned
    type: sum
    sql: ${items_returned}
  
  - measure: return_rate
    type: number
    decimals: 2
    sql: ${total_items_returned}/NULLIF(${total_items_purchased},0)::REAL
    value_format: '#0.00%'
    
  - measure: avg_basket_size
    label: Average Basket Size
    type: number
    decimals: 2
    sql: ${gross_revenue_ex_discount_ex_vat} / ${count_transactions}
    value_format: '#,##0.00'

  - measure: new_customer_percentage
    label: New Customer Percentage
    type: number
    decimals: 4
    sql: ${count_new_customers}/NULLIF(${count_transactions},0)::REAL
    value_format: '0.00%'
