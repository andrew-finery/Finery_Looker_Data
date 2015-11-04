- view: spree_variant_info_daily
  derived_table:
    sql: |
            select
            daily_sales.calendar_date,
            daily_sales.sku as ean,
            daily_sales.items_sold,
            daily_sales.closing_stock,
            lead(daily_sales.closing_stock, 1) over (partition by daily_sales.sku order by daily_sales.calendar_date desc) as opening_stock,
            spree_variants.variant_id,
            spree_variants.product_id,
            spree_variants.is_live,
            spree_variants.available_on,                                     
            spree_variants.pre_sale_price,
            spree_variants.price,                                              
            spree_variants.on_sale_flag
            from
            sales.daily_variant_sales daily_sales
            left join
                  (select
                  date(variants.spree_timestamp) - 1 as calendar_date,
                  variants.id as variant_id,
                  variants.sku as ean,
                  variants.product_id as product_id,
                  coalesce(products.is_live, true) as is_live,
                  products.available_on,
                  
                  max(pre_sale_prices.amount) as pre_sale_price,
                  max(prices.amount) as price,
                  
                    case
                    when max(pre_sale_prices.amount) is null then 'No'
                    else 'Yes' end
                    as on_sale_flag
                    
                  from
                  (select * from daily_snapshot.spree_variants where deleted_at is null and is_master <> 1) variants
                  inner join
                  (select spree_timestamp, variant_id, max(amount) as amount from daily_snapshot.spree_prices where deleted_at is null and currency = 'GBP' group by 1,2) prices
                  on variants.id = prices.variant_id and date(variants.spree_timestamp) = date(prices.spree_timestamp)
                  left join
                  (select spree_timestamp, variant_id, max(amount) as amount from daily_snapshot.spree_pre_sale_prices where deleted_at is null and currency = 'GBP' and amount > 0 group by 1,2) pre_sale_prices
                  on variants.id = pre_sale_prices.variant_id and date(variants.spree_timestamp) = date(pre_sale_prices.spree_timestamp)
                  left join
                  (select * from daily_snapshot.spree_products where deleted_at is null) products
                  on products.id = variants.product_id and date(variants.spree_timestamp) = date(products.spree_timestamp)
                  
                  group by 1,2,3,4,5,6) spree_variants
            on daily_sales.sku = spree_variants.ean
            and daily_sales.calendar_date = spree_variants.calendar_date


    sql_trigger_value: select count(*) from sales.daily_variant_sales
    distkey: ean
    sortkeys: [ean, calendar_date]

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


