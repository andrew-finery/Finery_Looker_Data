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
    decimals: 2
    sql: ${TABLE}.commission

  - dimension: currency
    type: string
    sql: ${TABLE}.currency

  - dimension: customer_id
    type: string
    sql: ${TABLE}.customer_id

  - dimension_group: order_placed
    type: time
    timeframes: [time, date, hour_of_day, hour, time_of_day, day_of_week_index, day_of_week, week, week_of_year, day_of_month, month, month_num, year, quarter, quarter_of_year]
    sql: cast(${TABLE}.date as datetime)

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

  - dimension: order_value
    type: number
    decimals: 2
    sql: ${TABLE}.value

  - dimension: voucher_code
    type: string
    sql: ${TABLE}.voucher_code

## Measures

  - measure: sum_commission
    type: sum
    sql: ${commission}
    value_format: '#0.00'
    
  - measure: sum_revenue
    type: sum
    sql: ${order_value}
    value_format: '#0.00'