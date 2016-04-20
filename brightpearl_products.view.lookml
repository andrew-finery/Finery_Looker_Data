- view: products
  sql_table_name: brightpearl.products
  fields:

  - dimension: product_id
    primary_key: true
    type: number
    sql: ${TABLE}.product_id

  - dimension: barcode
    type: string
    sql: ${TABLE}.barcode

  - dimension: brand_id
    type: number
    sql: ${TABLE}.brand_id

  - dimension: brightpearl_category_code
    type: number
    sql: ${TABLE}.brightpearl_category_code

  - dimension: created_on
    type: string
    sql: ${TABLE}.created_on

  - dimension: ean
    type: string
    sql: ${TABLE}.ean

  - dimension: isbn
    type: string
    sql: ${TABLE}.isbn

  - dimension: product_group_id
    type: number
    sql: ${TABLE}.product_group_id

  - dimension: product_name
    type: string
    sql: ${TABLE}.product_name

  - dimension: product_type_id
    type: number
    sql: ${TABLE}.product_type_id

  - dimension: sales_channel_name
    type: string
    sql: ${TABLE}.sales_channel_name

  - dimension: sku
    type: string
    sql: ${TABLE}.sku

  - dimension: stock_tracked
    type: string
    sql: ${TABLE}.stock_tracked

  - dimension: upc
    type: string
    sql: ${TABLE}.upc

  - dimension: updated_on
    type: string
    sql: ${TABLE}.updated_on

  - measure: count
    type: count
    drill_fields: [product_id, product_name, sales_channel_name, sales_orders_details.count]

