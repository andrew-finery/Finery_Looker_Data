- view: goods_in
  sql_table_name: sales.goods_in

  fields:

    ##################################################################################################################################################################################
  ######################################################################  DIMENSIONS  ##############################################################################################
##################################################################################################################################################################################

  - dimension: ean
    sql: ${TABLE}.ean
    hidden: true

  - dimension: confirm_date
    label: Goods Received Date
    type: date
    sql: ${TABLE}.confirm_date
  
  - dimension: receipt_reference
    label: Receipt Reference
    sql: ${TABLE}.rcpt_ref_num
  
  - dimension: received_quantity
    sql: ${TABLE}.received_quantity
    hidden: true
  
  - dimension: stock_type
    label: Stock Type (Ecom/Wholesale)
    sql: ${TABLE}.stock_type
    
##################################################################################################################################################################################
  ######################################################################  MEASURES  ################################################################################################
    ##################################################################################################################################################################################

  - measure: sum_received_quantity
    label: Received Quantity
    type: sum
    sql: ${received_quantity}
  
  - measure: received_value_cost
    label: Received Value @ Cost
    type: sum
    value_format_name: decimal_2
    sql: ${received_quantity} * ${variant_info.total_landed_cost_gbp}
    
  - measure: received_value_retail
    label: Received Value @ Retail
    type: sum
    value_format_name: decimal_2
    sql: ${received_quantity} * ${option_info.max_price}
  