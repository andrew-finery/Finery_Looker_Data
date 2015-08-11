- view: spree_variant_info_daily
  derived_table:
    sql: |
      select
      cal.calendar_date,
      spree_variants.variant_id,
      spree_variants.ean,
      spree_variants.product_id,
      coalesce(spree_variants.is_live, true) as is_live,
      spree_variants.available_on,
      spree_variants.pre_sale_price,
      spree_variants.price,
      spree_variants.count_on_hand,
      spree_variants.on_sale_flag,
      coalesce(sales.approx_items_sold, 0) as approx_items_sold
      
      
      from 
      
      (select
      calendar_date,
      case
      when calendar_date < '2014-12-10' then '2014-12-10'
      else calendar_date end as join_date
      from finery.calendar
      where calendar_date < current_date
      and calendar_date > '2014-11-22') cal
      
      left join
      
      (select
      date(variants.spree_timestamp) as calendar_date,
      variants.id as variant_id,
      variants.sku as ean,
      variants.product_id as product_id,
      products.is_live,
      products.available_on,
      
      max(pre_sale_prices.amount) as pre_sale_price,
      max(prices.amount) as price,
      sum(stock_items.count_on_hand) as count_on_hand,
      
        case
        when max(pre_sale_prices.amount) is null then 'No'
        else 'Yes' end
        as on_sale_flag
        
      from
      (select * from daily_snapshot.spree_variants where deleted_at is null and is_master <> 1) variants
      inner join
      (select * from daily_snapshot.spree_stock_items where deleted_at is null) stock_items
      on variants.id = stock_items.variant_id and date(variants.spree_timestamp) = date(stock_items.spree_timestamp)
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
      on spree_variants.calendar_date = cal.join_date
      
      
      left join
      (select order_date, variant_id, sum(quantity) as approx_items_sold from
      (select * from daily_snapshot.spree_line_items where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_line_items)) line_items
      left join
      (select date(completed_at) as order_date, id from daily_snapshot.spree_orders where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_orders) and completed_at is not null) orders
      on line_items.order_id = orders.id
      where order_date is not null
      group by 1,2) sales
      on sales.variant_id = spree_variants.variant_id
      and sales.order_date = spree_variants.calendar_date

    sql_trigger_value: select count(*) from daily_snapshot.spree_zones
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
    hidde: true

  - dimension: ean
    sql: ${TABLE}.ean
    hidden: true

  - dimension: product_id
    type: number
    sql: ${TABLE}.product_id
    hidden: true

  - dimension: is_live
    sql: |
          case when ${TABLE}.is_live = true then 'Yes' else 'No' end

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

  - dimension: count_on_hand
    type: number
    sql: ${TABLE}.count_on_hand
    hidden: true

  - dimension: on_sale_flag
    sql: ${TABLE}.on_sale_flag

  - dimension: approx_items_sold
    sql: ${TABLE}.approx_items_sold
    hidden: true
  
  - dimension: on_site_flag
    sql: |
          case
          when ${approx_items_sold} > 0 then 'Yes'
          when ${is_live} = 'No' then 'No'
          when date(${available_on}) > ${calendar_date} then 'No'
          when ${count_on_hand} = 0 then 'No'
          else 'Yes' end

####### MEASURES

  - measure: count_variants
    type: count_distinct
    sql: ${variant_id}

  - measure: count_products
    type: count_distinct
    sql: ${product_id}


