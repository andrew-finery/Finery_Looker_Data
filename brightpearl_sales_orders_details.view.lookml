- view: sales_orders_details
  sql_table_name: brightpearl.sales_orders_details
  fields:

  - dimension: nominal_code
    type: number
    sql: ${TABLE}.nominal_code

  - dimension: order_id
    type: number
    sql: ${TABLE}.order_id

  - dimension: order_row_sequence
    type: number
    sql: ${TABLE}.order_row_sequence

  - dimension: product_id
    type: number
    # hidden: true
    sql: ${TABLE}.product_id

  - dimension: product_name
    type: string
    sql: ${TABLE}.product_name

  - dimension: product_sku
    type: string
    sql: ${TABLE}.product_sku

  - dimension: quantity
    type: number
    sql: ${TABLE}.quantity

  - dimension: row_value_row_net_currency
    type: string
    sql: ${TABLE}.row_value_row_net_currency

  - dimension: row_value_row_net_value
    type: number
    sql: ${TABLE}.row_value_row_net_value

  - dimension: row_value_row_tax_currency
    type: string
    sql: ${TABLE}.row_value_row_tax_currency

  - dimension: row_value_row_tax_tvalue
    type: number
    sql: ${TABLE}.row_value_row_tax_tvalue

  - dimension: row_value_tax_code
    type: string
    sql: ${TABLE}.row_value_tax_code

  - dimension: row_value_tax_rate
    type: number
    sql: ${TABLE}.row_value_tax_rate

  - dimension: rowcost
    type: number
    sql: ${TABLE}.rowcost

  - dimension: size
    type: string
    sql: ${TABLE}.size

  - measure: count
    type: count
    drill_fields: [product_name, products.product_id, products.product_name, products.sales_channel_name]

