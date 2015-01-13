- view: spree_stock_items
  derived_table:
    sql: |
      select
      a.spree_timestamp,
      a.stock_location_id,
      b.sku,
      a.count_on_hand,
      a.updated_at,
      a.backorderable
      
      from
      
      (select * from daily_snapshot.spree_stock_items where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_stock_items)) a
      
      inner join
      (select * from daily_snapshot.spree_variants where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_variants)) b
      on a.variant_id = b.id
      
      where a.deleted_at is null
      and a.updated_at > date '2014-11-11'
      and b.sku <> ' '
      and b.is_master <> 1
    
    sql_trigger_value: SELECT max(spree_timestamp) FROM ${spree_users.SQL_TABLE_NAME}
    sortkeys: [sku]

        
  fields:

  - dimension: backorderable
    type: number
    sql: ${TABLE}.backorderable
  
  - dimension: ean
    sql: ${TABLE}.sku

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

  - dimension: sku
    type: int
    sql: ${TABLE}.sku
    
  # measures #
  - measure: sum_count_on_hand
    type: sum
    sql: ${count_on_hand}
  
  - measure: number_of_skus
    type: count_distinct
    sql: ${sku}
  



