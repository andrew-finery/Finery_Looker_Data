- view: snowplow_transaction_attribution
  sql_table_name: website_data.order_attribution
  fields:
  
    ###################################################################################################################################
  ################################## DIMENSIONS #####################################################################################
###################################################################################################################################

   - dimension: user_id
     sql: ${TABLE}.domain_userid
     hidden: true
  
   - dimension: domain_session_index
     sql: ${TABLE}.domain_sessionidx
     hidden: true

   - dimension: order_id
     sql: ${TABLE}.order_id
   
   - dimension: attribution_ratio
     type: number
     decimals: 4
     sql: ${TABLE}.attribution_percentage * 0.0001
   
    ###################################################################################################################################
  ################################## MEASURES #######################################################################################
###################################################################################################################################   
   
   - measure: attributed_orders
     type: sum
     decimals: 2
     sql: ${attribution_ratio}

   - measure: attributed_new_customers
     type: sum
     decimals: 2
     sql: ${attribution_ratio}
     filters:
      transactions.new_customer_flag: yes
     
   - measure: attributed_revenue_ex_discount_ex_vat
     label: Attributed Revenue ex. discount, VAT
     type: sum
     decimals: 2
     value_format: '#,##0.00'
     sql: ${attribution_ratio} * ${transactions.revenue_ex_coupon_and_vat} / ${transactions.exchange_rate}