- view: warehouse_consumables_yesterday
  sql_table_name: cml.warehouse_consumables_yesterday
  fields:

  - dimension: cust_code
    type: string
    sql: ${TABLE}.cust_code

  - dimension: hol_code
    type: string
    sql: ${TABLE}.hol_code

  - dimension: invt_lev1
    type: string
    sql: ${TABLE}.invt_lev1

  - dimension: invt_lev2
    type: string
    sql: ${TABLE}.invt_lev2

  - dimension: invt_lev4
    type: string
    sql: ${TABLE}.invt_lev4

  - dimension: item_des1
    type: string
    sql: ${TABLE}.item_des1

  - dimension: on_hand
    type: number
    sql: ${TABLE}.on_hand

  - dimension: on_ord_qty
    type: number
    sql: ${TABLE}.on_ord_qty

  - dimension: on_rcpt_qty
    type: number
    sql: ${TABLE}.on_rcpt_qty

