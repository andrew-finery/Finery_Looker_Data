- view: fb_automated_ads_creatives_sale
  sql_table_name: facebook_data.creatives_sale
  fields:

  - dimension: creative_id
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

  - dimension: pre_sale_price_aed
    type: number
    sql: ${TABLE}.pre_sale_price_aed

  - dimension: pre_sale_price_aud
    type: number
    sql: ${TABLE}.pre_sale_price_aud

  - dimension: pre_sale_price_cad
    type: number
    sql: ${TABLE}.pre_sale_price_cad

  - dimension: pre_sale_price_gbp
    type: number
    sql: ${TABLE}.pre_sale_price_gbp

  - dimension: pre_sale_price_hkd
    type: number
    sql: ${TABLE}.pre_sale_price_hkd

  - dimension: pre_sale_price_sgd
    type: number
    sql: ${TABLE}.pre_sale_price_sgd

  - dimension: pre_sale_price_usd
    type: number
    sql: ${TABLE}.pre_sale_price_usd

  - dimension: price
    type: number
    sql: ${TABLE}.price

  - dimension: price_aed
    type: number
    sql: ${TABLE}.price_aed

  - dimension: price_aud
    type: number
    sql: ${TABLE}.price_aud

  - dimension: price_cad
    type: number
    sql: ${TABLE}.price_cad

  - dimension: price_hkd
    type: number
    sql: ${TABLE}.price_hkd

  - dimension: price_sgd
    type: number
    sql: ${TABLE}.price_sgd

  - dimension: price_usd
    type: number
    sql: ${TABLE}.price_usd

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
    
  - dimension: shorthand_name
    type: string
    sql: ${TABLE}.shorthand_name


