- view: website_promo_block_click_through_daily
  sql_table_name: web.promo_block_click_through_daily
  fields:

################ Dimensions

  - dimension_group: calendar
    type: time
    timeframes: [date, week, month]
    convert_tz: false
    sql: ${TABLE}.calendar_date

  - dimension: page_type
    type: string
    sql: ${TABLE}.page_type

  - dimension: page_urlpath
    type: string
    sql: ${TABLE}.page_urlpath

  - dimension: promo_block_id
    type: string
    sql: ${TABLE}.promo_block_id

  - dimension: promo_clicks
    type: number
    sql: ${TABLE}.promo_clicks

  - dimension: promo_views
    type: number
    sql: ${TABLE}.promo_views

###################### Measures

  - measure: sum_promo_clicks
    type: sum
    sql: ${promo_clicks}
    
  - measure: sum_promo_views
    type: sum
    sql: ${promo_views}
    
  - measure: click_through_rate
    type: number
    sql: ${sum_promo_clicks}/NULLIF(${sum_promo_views},0)::REAL
    value_format: '#0.00%'
  
  - measure: unique_promo_blocks
    type: count_distinct
    sql: ${promo_block_id}
