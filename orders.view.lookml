- view: com_finerylondon_transaction_1
  sql: |
      SELECT
      a.customer_id,
      a.diff_billing_address,
      a.currency_code,
      a.coupon,
      a.id,
      a.revenue,
      a.shipping,
      a.tax,
      a.transaction_ids,
      a.gift_wrapping,
      a.net_value,
      a.payment_methods,
      a.promo_code,
      a.promo_code_type,
      a.promo_code_value,
      a.qty_total,
      a.shipping_cost,
      b.domain_userid,
      b.domain_sessionidx
      
      from atomic.com_finerylondon_transaction_1 a
      left join
      atomic.events b
      on a.root_id = b.event_id
      
      
  fields:

  - dimension: user_id
    sql: ${TABLE}.domain_userid
    
  - dimension: session_index
    type: int
    sql: ${TABLE}.domain_sessionidx
  
  - dimension: session_id
    sql: ${TABLE}.domain_userid || '-' || ${TABLE}.domain_sessionidx
  - dimension: user_id
    sql: ${TABLE}.domain_userid
    
  - dimension: order_id
    primary_key: true
    sql: ${TABLE}.id

  - dimension: coupon
    sql: ${TABLE}.coupon

  - dimension: currency_code
    sql: ${TABLE}.currency_code

  - dimension: customer_id
    sql: ${TABLE}.customer_id

  - dimension: diff_billing_address
    sql: ${TABLE}.diff_billing_address

  - dimension: gift_wrapping
    sql: ${TABLE}.gift_wrapping

  - dimension: net_value
    type: number
    sql: ${TABLE}.net_value

  - dimension: payment_methods
    sql: ${TABLE}.payment_methods

  - dimension: promo_code
    sql: ${TABLE}.promo_code

  - dimension: promo_code_type
    sql: ${TABLE}.promo_code_type

  - dimension: promo_code_value
    sql: ${TABLE}.promo_code_value

  - dimension: qty_total
    type: int
    sql: ${TABLE}.qty_total

  - dimension: revenue
    type: number
    sql: ${TABLE}.revenue

  - dimension_group: order_time
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.root_tstamp

  - dimension: schema_format
    sql: ${TABLE}.schema_format

  - dimension: schema_name
    sql: ${TABLE}.schema_name

  - dimension: schema_vendor
    sql: ${TABLE}.schema_vendor

  - dimension: schema_version
    sql: ${TABLE}.schema_version

  - dimension: shipping
    type: number
    sql: ${TABLE}.shipping

  - dimension: shipping_cost
    type: number
    sql: ${TABLE}.shipping_cost

  - dimension: tax
    type: number
    sql: ${TABLE}.tax

  - dimension: transaction_ids
    sql: ${TABLE}.transaction_ids


  - measure: count
    type: count
    drill_fields: [id, schema_name]

