- view: warehouse_stock_yesterday
  sql_table_name: cml.warehouse_stock_yesterday
  fields:

  - dimension: cust_code
    type: string
    sql: ${TABLE}.cust_code

  - dimension: hold_code
    type: string
    sql: ${TABLE}.hold_code

  - dimension: sku
    type: string
    sql: ${TABLE}.invt_lev1

  - dimension: color
    type: string
    sql: ${TABLE}.invt_lev2

  - dimension: size
    type: string
    sql: ${TABLE}.invt_lev3

  - dimension: variant_id
    type: string
    sql: ${TABLE}.invt_lev4

  - dimension: name
    type: string
    sql: ${TABLE}.item_des1

  - dimension: loc_code
    type: string
    sql: ${TABLE}.loc_code




  - measure: on_hand_qty
    type: number
    sql: sum(${TABLE}.on_hand_qty)

  - measure: on_ord_qty
    type: number
    sql: sum(${TABLE}.on_ord_qty)



