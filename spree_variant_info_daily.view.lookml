- view: spree_variant_info_daily
  sql_table_name: info.variant_info_daily
  fields:

## DIMENSIONS

  - dimension: calendar_date
    type: date
    sql: ${TABLE}.calendar_date

  - dimension: variant_id
    type: number
    sql: ${TABLE}.variant_id
    hidden: true

  - dimension: ean
    sql: ${TABLE}.ean
    hidden: true

  - dimension: product_id
    type: number
    sql: ${TABLE}.product_id
    hidden: true

  - dimension: is_live
    sql: ${TABLE}.is_live
    hidden: true

  - dimension: available_on
    sql: ${TABLE}.available_on
    hidden: true

  - dimension: pre_sale_price
    label: Was Price
    sql: ${TABLE}.pre_sale_price

  - dimension: price
    label: Price
    type: number
    sql: ${TABLE}.price

  - dimension: closing_stock
    type: number
    sql: ${TABLE}.closing_stock
    hidden: true

  - dimension: opening_stock
    type: number
    sql: ${TABLE}.opening_stock
    hidden: true

  - dimension: on_sale_flag
    sql: ${TABLE}.on_sale_flag

  - dimension: items_sold
    sql: ${TABLE}.items_sold
    hidden: true
  
  - dimension: on_site_flag
    sql: |
          case
          when ${items_sold} > 0 then 'Yes'
          when ${is_live} is null then 'No'
          when ${is_live} = false then 'No'
          when date(${available_on}) > ${calendar_date} then 'No'
          when (${closing_stock} = 0 and ${opening_stock} = 0) then 'No'
          else 'Yes' end

####### MEASURES

  - measure: count_variants
    type: count_distinct
    sql: ${variant_id}

  - measure: count_products
    type: count_distinct
    sql: ${product_id}


