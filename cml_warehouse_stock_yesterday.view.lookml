- view: warehouse_stock_yesterday
  sql_table_name: cml.warehouse_stock_yesterday
  fields:

  - dimension: cust_code
    type: string
    sql: ${TABLE}.cust_code

  - dimension: hold_code
    type: string
    sql: ${TABLE}.hold_code

  - dimension: invt_lev1
    type: string
    sql: ${TABLE}.invt_lev1

  - dimension: invt_lev2
    type: string
    sql: ${TABLE}.invt_lev2

  - dimension: invt_lev3
    type: string
    sql: ${TABLE}.invt_lev3

  - dimension: invt_lev4
    type: string
    sql: ${TABLE}.invt_lev4

  - dimension: item_des1
    type: string
    sql: ${TABLE}.item_des1

  - dimension: loc_code
    type: string
    sql: ${TABLE}.loc_code

  - dimension: on_hand_qty
    type: number
    sql: ${TABLE}.on_hand_qty

  - dimension: on_ord_qty
    type: number
    sql: ${TABLE}.on_ord_qty

  - measure: count
    type: count
    drill_fields: []

