- view: goods_in
  derived_table:
     sql: |
          SELECT confirm_date,
                 style AS parent_sku,
                 ean,
                 receieved_qty AS received_quantity,
                 TRIM('UN' FROM expected_qty) AS expected_quantity
          FROM cml.goods_in
          WHERE confirm_date IS NOT NULL

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