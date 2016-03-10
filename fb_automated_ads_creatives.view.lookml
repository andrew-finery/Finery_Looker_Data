- view: fb_automated_ads_creatives
  sql_table_name: facebook_data.creatives
  fields:

  - dimension: creative_id
    primary_key: true
    type: number
    sql: ${TABLE}.creative_id

  - dimension: currently_live
    type: string
    sql: ${TABLE}.currently_live

  - dimension: department
    type: string
    sql: ${TABLE}.department

  - dimension: facebook_image_location
    type: string
    sql: ${TABLE}.facebook_image_location

  - dimension: on_sale_flag
    type: string
    sql: ${TABLE}.on_sale_flag

  - dimension: price
    type: number
    sql: ${TABLE}.price

  - dimension: product_id
    type: number
    sql: ${TABLE}.product_id

  - dimension: product_name
    type: string
    sql: ${TABLE}.product_name

  - dimension: sub_season_code
    type: string
    sql: ${TABLE}.sub_season_code

  - dimension: unique_id
    type: number
    sql: ${TABLE}.unique_id

  - dimension_group: upload
    type: time
    timeframes: [date, week, month]
    convert_tz: false
    sql: ${TABLE}.upload_date

  - measure: count
    type: count
    drill_fields: [creative_id, product_name]

