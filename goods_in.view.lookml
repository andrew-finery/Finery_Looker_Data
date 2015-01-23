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

     sql_trigger_value: SELECT max(confirm_date from cml.goods_in
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

##################################################################################################################################################################################
  ######################################################################  MEASURES  ################################################################################################
    ##################################################################################################################################################################################

  - measure: sum_received_quantity
    type: sum
    sql: ${TABLE}.received_quantity