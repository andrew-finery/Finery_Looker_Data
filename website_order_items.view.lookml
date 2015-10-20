- view: website_order_items
  sql_table_name: website_data.order_items
  fields:

  - dimension: adjustment_total
    type: number
    sql: ${TABLE}.adjustment_total

  - dimension_group: collector_tstamp
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.collector_tstamp

  - dimension: currency
    sql: ${TABLE}.currency

  - dimension: customer_id
    type: int
    sql: ${TABLE}.customer_id

  - dimension: discount
    type: number
    sql: ${TABLE}.discount

  - dimension: domain_sessionidx
    type: number
    sql: ${TABLE}.domain_sessionidx

  - dimension: domain_userid
    sql: ${TABLE}.domain_userid

  - dimension: exchange_rate
    type: number
    sql: ${TABLE}.exchange_rate

  - dimension: items_returned
    type: int
    sql: ${TABLE}.items_returned

  - dimension: max_selling_price
    type: number
    sql: ${TABLE}.max_selling_price

  - dimension: max_selling_price_gbp
    type: number
    sql: ${TABLE}.max_selling_price_gbp

  - dimension: order_code
    sql: ${TABLE}.order_code

  - dimension: order_id
    type: int
    # hidden: true
    sql: ${TABLE}.order_id

  - dimension: order_total
    type: number
    sql: ${TABLE}.order_total

  - dimension_group: order_tstamp
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.order_tstamp

  - dimension: pre_sale_price
    type: number
    sql: ${TABLE}.pre_sale_price

  - dimension: price
    type: number
    sql: ${TABLE}.price

  - dimension: product_id
    type: int
    sql: ${TABLE}.product_id

  - dimension: product_on_sale_flag
    type: number
    sql: ${TABLE}.product_on_sale_flag

  - dimension: quantity
    type: int
    sql: ${TABLE}.quantity

  - dimension: reason_to_strip_out
    sql: ${TABLE}.reason_to_strip_out

  - dimension: return_reason
    sql: ${TABLE}.return_reason

  - dimension_group: return_tstamp
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.return_tstamp

  - dimension: sku
    sql: ${TABLE}.sku

  - dimension: tax_rate
    type: number
    sql: ${TABLE}.tax_rate

  - dimension: variant_id
    type: int
    sql: ${TABLE}.variant_id

  - measure: count
    type: count
    drill_fields: [orders.order_id]

