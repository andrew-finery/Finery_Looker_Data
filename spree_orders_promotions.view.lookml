- view: spree_orders_promotions
  derived_table:
    sql: |
          SELECT orders.order_id,
                 promotions.description,
                 promotions.name,
                 promotions.code
          FROM (SELECT *
                FROM daily_snapshot.spree_orders_promotions
                WHERE spree_timestamp = (SELECT MAX(spree_timestamp)
                                         FROM daily_snapshot.spree_orders_promotions)) orders
            LEFT JOIN (SELECT *
                       FROM daily_snapshot.spree_promotions
                       WHERE spree_timestamp = (SELECT MAX(spree_timestamp)
                                                FROM daily_snapshot.spree_promotions)) promotions ON orders.promotion_id = promotions.id

    
    sql_trigger_value: select count(*) from daily_snapshot.spree_zones
    distkey: order_id
    sortkeys: [order_id]


  fields:
  
  - dimension: promotion_code
    sql: ${TABLE}.code