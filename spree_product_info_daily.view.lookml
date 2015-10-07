- view: spree_product_info_daily
  derived_table:
    sql: |
            SELECT calendar_date,
                   product_id,
                   sum(items_sold) as items_sold,
                   sum(closing_stock) as closing_stock,
                   sum(opening_stock) as opening_stock,
                   max(case when is_live = true then 1 else 0 end) as is_live,
                   min(available_on) as available_on,
                   max(pre_sale_price) as pre_sale_price,
                   case when max(pre_sale_price) is not null then 'Yes' else 'No' end as on_sale_flag,
                   max(price) as price
            FROM ${spree_variant_info_daily.SQL_TABLE_NAME}
            WHERE product_id IS NOT NULL
            GROUP BY 1,2


    sql_trigger_value: select count(*) from ${spree_variant_info_daily.SQL_TABLE_NAME}
    distkey: product_id
    sortkeys: [product_id, calendar_date]

  fields:

## DIMENSIONS

  - dimension: calendar_date
    type: date
    sql: ${TABLE}.calendar_date

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

  - measure: count_products
    type: count_distinct
    sql: ${product_id}