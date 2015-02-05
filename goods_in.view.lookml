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
          TRIM('UN' FROM expected_qty) AS expected_quantity FROM finery.goods_in WHERE confirm_date IS NOT NULL


     sql_trigger_value: SELECT count(*) from cml.goods_in
     distkey: ean
     sortkeys: [confirm_date, ean]

  fields:

    ##################################################################################################################################################################################
  ######################################################################  DIMENSIONS  ##############################################################################################
##################################################################################################################################################################################

  - dimension: confirm_date
    type: date
    sql: ${TABLE}.confirm_date
  
  - dimension: parent_sku
    sql: ${TABLE}.parent_sku

  - dimension: ean
    sql: ${TABLE}.ean

  - dimension: received_quantity
    sql: ${TABLE}.received_quantity
  
  - dimension: expected_quantity
    sql: ${TABLE}.expected_quantity
  
  - dimension: stock_type
    sql: ${TABLE}.stock_type
    
##################################################################################################################################################################################
  ######################################################################  MEASURES  ################################################################################################
    ##################################################################################################################################################################################

  - measure: sum_received_quantity
    type: sum
    sql: ${TABLE}.received_quantity
 
  - measure: sum_expected_quantity_quantity
    type: sum
    sql: ${TABLE}.expected_quantity