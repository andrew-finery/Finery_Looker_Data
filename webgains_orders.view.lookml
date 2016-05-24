- view: webgains_orders
  sql_table_name: affiliate_data.webgains_transactions
  fields:

## Dimensions

  - dimension: id
    primary_key: true
    type: string
    sql: ${TABLE}.id
    hidden: true

  - dimension: campaign_id
    type: string
    sql: ${TABLE}.campaign_id

  - dimension: comment
    type: string
    sql: ${TABLE}.comment

  - dimension: commission
    type: number
    sql: ${TABLE}.commission

  - dimension: currency
    type: string
    sql: ${TABLE}.currency

  - dimension: customer_id
    type: string
    sql: ${TABLE}.customer_id

  - dimension: date
    type: string
    sql: ${TABLE}.date

  - dimension: delayed_until_date
    type: string
    sql: ${TABLE}.delayed_until_date

  - dimension: event_id
    type: string
    sql: ${TABLE}.event_id

  - dimension: order_id
    type: string
    sql: ${TABLE}.order_reference

  - dimension: status
    type: string
    sql: ${TABLE}.status

  - dimension: revenue
    type: number
    sql: ${TABLE}.value

  - dimension: voucher_code
    type: string
    sql: ${TABLE}.voucher_code

## Measures

  - measure: sum_commission
    type: sum
    sql: ${commission}
    
  - measure: sum_revenue
    type: sum
    sql: ${revenue}