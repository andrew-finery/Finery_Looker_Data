- view: website_all_orders
  sql_table_name: website_data.all_orders
  fields:

  - dimension: additional_tax_total
    type: number
    sql: ${TABLE}.additional_tax_total

  - dimension: adjustment_total
    type: number
    sql: ${TABLE}.adjustment_total

  - dimension: amount_refunded
    type: number
    sql: ${TABLE}.amount_refunded

  - dimension: bill_address_id
    type: int
    sql: ${TABLE}.bill_address_id

  - dimension: blended_email
    sql: ${TABLE}.blended_email

  - dimension: cash_refunded
    type: number
    sql: ${TABLE}.cash_refunded

  - dimension_group: collector_tstamp
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.collector_tstamp

  - dimension_group: completed
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.completed_at

  - dimension: consignee
    sql: ${TABLE}.consignee

  - dimension: country_id
    type: int
    sql: ${TABLE}.country_id

  - dimension: currency
    sql: ${TABLE}.currency

  - dimension: customer_id
    type: int
    sql: ${TABLE}.customer_id

  - dimension: delivery_type
    sql: ${TABLE}.delivery_type

  - dimension: domain_sessionidx
    type: number
    sql: ${TABLE}.domain_sessionidx

  - dimension: domain_userid
    sql: ${TABLE}.domain_userid

  - dimension: email
    sql: ${TABLE}.email

  - dimension: exchange_rate
    type: number
    sql: ${TABLE}.exchange_rate

  - dimension: in_store_flag
    type: number
    sql: ${TABLE}.in_store_flag

  - dimension: included_tax_total
    type: number
    sql: ${TABLE}.included_tax_total

  - dimension: item_count
    type: int
    sql: ${TABLE}.item_count

  - dimension: item_total
    type: number
    sql: ${TABLE}.item_total

  - dimension: items_returned
    type: int
    sql: ${TABLE}.items_returned

  - dimension: latest_order_id
    type: int
    sql: ${TABLE}.latest_order_id

  - dimension: number_of_products
    type: int
    sql: ${TABLE}.number_of_products

  - dimension: number_of_skus
    type: int
    sql: ${TABLE}.number_of_skus

  - dimension: order_code
    sql: ${TABLE}.order_code

  - dimension: order_id
    type: int
    # hidden: true
    sql: ${TABLE}.order_id

  - dimension: order_sequence_number
    type: number
    sql: ${TABLE}.order_sequence_number

  - dimension: order_total
    type: number
    sql: ${TABLE}.order_total

  - dimension: primary_payment_method
    sql: ${TABLE}.primary_payment_method

  - dimension: promotion
    sql: ${TABLE}.promotion

  - dimension: reason_to_strip_out
    sql: ${TABLE}.reason_to_strip_out

  - dimension: return_item_total
    type: number
    sql: ${TABLE}.return_item_total

  - dimension: ship_address_id
    type: int
    sql: ${TABLE}.ship_address_id

  - dimension: shipment_number
    sql: ${TABLE}.shipment_number

  - dimension: shipment_total
    type: number
    sql: ${TABLE}.shipment_total

  - dimension_group: shipped_at
    type: time
    timeframes: [date, week, month]
    convert_tz: false
    sql: ${TABLE}.shipped_at_date

  - dimension: shipping_method
    sql: ${TABLE}.shipping_method

  - dimension: state
    sql: ${TABLE}.state

  - dimension: store_credit_refunded
    type: number
    sql: ${TABLE}.store_credit_refunded

  - dimension: store_credit_used
    type: number
    sql: ${TABLE}.store_credit_used

  - dimension: tax_rate
    type: number
    sql: ${TABLE}.tax_rate

  - dimension: tracking_number
    sql: ${TABLE}.tracking_number

  - measure: count
    type: count
    drill_fields: [orders.order_id]

