- view: goods_in
  derived_table:
     sql: |
          SELECT confirm_date,
                 style AS parent_sku,
                 ean,
                 receieved_qty AS received_quantity,
                 rcpt_ref_num,
                 CASE
                   WHEN rcpt_ref_num LIKE '%(W)%' THEN 'Wholesale'
                   WHEN rcpt_ref_num LIKE '%(WH)%' THEN 'Wholesale'
                   ELSE 'Ecom' end as stock_type,         
          TRIM('UN' FROM expected_qty) AS expected_quantity
          FROM finery.goods_in
          WHERE confirm_date IS NOT NULL
          AND not((left(rcpt_ref_num, 1) in ('h','H','R')
              and TRIM('UN' FROM expected_qty) = 0
              and len(rcpt_ref_num) in (10,11,12,13)
              and receieved_qty in (0,1,2,3))
              or rcpt_ref_num in ('c', 'RETURNSTOCK', '(ECOM) FIN 8 JUN A')
              or left(rcpt_ref_num, 3) = 'POP')
          AND not (rcpt_ref_num = '' and receieved_qty in (1,0))

     sql_trigger_value: SELECT count(*) from finery.goods_in
     distkey: ean
     sortkeys: [confirm_date, ean]

  fields:

    ##################################################################################################################################################################################
  ######################################################################  DIMENSIONS  ##############################################################################################
##################################################################################################################################################################################

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
  
  - dimension: expected_quantity
    sql: ${TABLE}.expected_quantity
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
 
  - measure: sum_expected_quantity_quantity
    label: Expected Quantity
    type: sum
    sql: ${expected_quantity}
  
  - measure: received_value_cost
    label: Received Value @ Cost
    type: sum
    decimals: 2
    sql: ${received_quantity} * ${product_lookup.total_landed_cost_gbp}
    value_format: '#,##0.00'
    
  - measure: received_value_retail
    label: Received Value @ Retail
    type: sum
    decimals: 2
    sql: ${received_quantity} * ${product_lookup.max_selling_price}
    value_format: '#,##0.00'
  