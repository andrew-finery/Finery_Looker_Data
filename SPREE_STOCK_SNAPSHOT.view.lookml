- view: stock_items_snapshot
  derived_table:
    sql: |
      select stock_location_id,
      variant_id,
      count_on_hand,
      updated_at,
      backorderable
      
      from
      
      spree.stock_items_snapshot
      
      where deleted_at is null
        
        
  fields:

  - dimension: backorderable
    type: number
    sql: ${TABLE}.backorderable

  - dimension: count_on_hand
    type: int
    sql: ${TABLE}.count_on_hand

  - dimension: stock_location_id
    type: int
    sql: ${TABLE}.stock_location_id

  - dimension_group: last_update
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.updated_at

  - dimension: variant_id
    type: int
    sql: ${TABLE}.variant_id


