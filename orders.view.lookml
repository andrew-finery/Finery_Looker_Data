- view: orders
  derived_table:
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
      b.domain_sessionidx,
      a.root_tstamp,
      c.adjustment_amount,
      d.total_items,
      d.items_full_price,
      d.number_of_parent_skus,
      d.number_of_child_skus
      
      from atomic.com_finerylondon_transaction_1 a
      
      left join
      atomic.events b
      on a.root_id = b.event_id
      
      left join
      (select root_id as root_id, sum(amount) as adjustment_amount from atomic.com_finerylondon_order_adjustments_1 group by 1) c
      on a.root_id = c.root_id
      
      left join
      (select root_id as root_id, sum(price*quantity) as items_full_price, count(distinct id) as number_of_parent_skus, count(distinct variant_id) as number_of_child_skus,  sum(quantity) as total_items from atomic.com_finerylondon_product_in_order_1 group by 1) d
      on a.root_id = d.root_id

  
    sql_trigger_value: SELECT COUNT(*) FROM ${sessions.SQL_TABLE_NAME}
    distkey: domain_userid
    sortkeys: [domain_userid, domain_sessionidx, root_tstamp]
    
  fields:

  - dimension: user_id
    sql: ${TABLE}.domain_userid
    
  - dimension: session_index
    type: int
    sql: ${TABLE}.domain_sessionidx
  
  - dimension: session_id
    sql: ${TABLE}.domain_userid || '-' || ${TABLE}.domain_sessionidx

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

  - dimension: revenue_in_gbp
    sql:  |
          case
          when ${TABLE}.currency_code = 'GBP' then ${TABLE}.revenue*1.00
          when ${TABLE}.currency_code = 'USD' then ${TABLE}.revenue*0.64
          when ${TABLE}.currency_code = 'CAD' then ${TABLE}.revenue*0.56
          else ${TABLE}.revenue end
    
  - measure: count
    type: count
    drill_fields: [id, schema_name]

