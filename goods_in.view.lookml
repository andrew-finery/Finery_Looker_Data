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
          AND not((left(rcpt_ref_num, 1) in ('h', 'R')
              and TRIM('UN' FROM expected_qty) = 0
              and receieved_qty in (0,1,2,3))
              or rcpt_ref_num in ('c', 'RETURNSTOCK')
              or left(rcpt_ref_num, 3) = 'POP')

     sql_trigger_value: SELECT count(*) from finery.goods_in
     distkey: ean
     sortkeys: [confirm_date, ean]

  fields:

    ##################################################################################################################################################################################
  ######################################################################  DIMENSIONS  ##############################################################################################
##################################################################################################################################################################################

  - dimension: confirm_date
    label: GOODS RECEIVED
    type: date
    sql: ${TABLE}.confirm_date
  
  - dimension: received_quantity
    sql: ${TABLE}.received_quantity
    hidden: true
  
  - dimension: expected_quantity
    sql: ${TABLE}.expected_quantity
    hidden: true
  
  - dimension: stock_type
    label: STOCK TYPE (ECOM/WS)
    sql: ${TABLE}.stock_type
    
##################################################################################################################################################################################
  ######################################################################  MEASURES  ################################################################################################
    ##################################################################################################################################################################################

  - measure: sum_received_quantity
    label: RECEIVED QUANTITY
    type: sum
    sql: ${received_quantity}
 
  - measure: sum_expected_quantity_quantity
    label: EXPECTED QUANTITY
    type: sum
    sql: ${expected_quantity}
  
  - measure: received_value_cost
    label: RECEIVED VALUE @ COST
    type: sum
    sql: ${received_quantity} * ${product_lookup.total_landed_cost_gbp}
    format: "£%0.2f"
    
  - measure: received_value_retail
    label: RECEIVED VALUE @ RETAIL
    type: sum
    sql: ${received_quantity} * ${product_lookup.max_selling_price}
    format: "£%0.2f"
  