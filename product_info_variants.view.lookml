- view: product_info_variants
  sql_table_name: web.variant_info
  fields:

  - dimension: bp_option_id
    type: string
    sql: ${TABLE}.bp_option_id
    hidden: true

  - dimension: current_stock
    type: number
    sql: ${TABLE}.current_stock

  - dimension_group: deleted
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.deleted_at
    hidden: true

  - dimension: ean
    type: string
    sql: ${TABLE}.ean

  - dimension: option_id
    sql: ${TABLE}.option_id

  - dimension: product_id
    type: number
    sql: ${TABLE}.product_id

  - dimension: size
    type: string
    sql: ${TABLE}.size

  - dimension: total_landed_cost_gbp
    type: number
    sql: ${TABLE}.total_landed_cost_gbp

  - dimension: variant_id
    type: number
    sql: ${TABLE}.variant_id
