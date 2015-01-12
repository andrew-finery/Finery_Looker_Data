- view: opening_stock
  derived_table:
     sql: |
          select
          matrix.calendar_date,
          matrix.year_week_number,
          matrix.sku,
          coalesce(opening.opening_stock, '0') as opening_stock
          
          
          from 
          
          (select aaa.sku, aaa.variant_id, bbb.calendar_date, bbb.year_week_number from
          (select a.variant_id, b.sku from      
          (select * from daily_snapshot.spree_stock_items where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_stock_items)) a
          inner join
          (select * from daily_snapshot.spree_variants where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_variants)) b
          on a.variant_id = b.id
          and a.updated_at > date '2014-11-11'
          and b.sku <> ' '
          group by 1,2) aaa
          cross join
          (select calendar_date, year_week_number from lookup.calendar)bbb
          where bbb.calendar_date < current_date) matrix
          
          left join
          
          (select abc.calendar_date, abc.variant_id, def.count_on_hand as opening_stock from
          (select date(spree_timestamp) as calendar_date, variant_id, min(spree_timestamp) as spree_timestamp from daily_snapshot.spree_stock_items group by 1,2) abc
          left join
          daily_snapshot.spree_stock_items def
          on abc.variant_id = def.variant_id
          and abc.spree_timestamp = def.spree_timestamp) opening
          on opening.calendar_date = matrix.calendar_date
          and opening.variant_id = matrix.variant_id

  fields:
  
  - dimension_group: calendar_date
    type: time
    timeframes: [date, dow, dow_num, week, dom, month, month_num]
    convert_tz: false
    sql: ${TABLE}.calendar_date

  - dimension: year_week_number
    sql: ${TABLE}.year_week_number
    
  - dimension: sku
    sql: ${TABLE}.sku
    
  - dimension: opening_stock
    type: int
    sql: ${TABLE}.opening_stock

  - measure: sum_opening_stock
    type: sum
    sql: ${opening_stock}
    
    
    
