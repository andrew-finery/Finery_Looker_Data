- view: daily_closing_stock
  derived_table:
     sql: |
          SELECT sku,
                 calendar_date - 1 AS closing_stock_date,
                 closing_stock
          FROM (SELECT sku,
                       DATE (root_tstamp) AS calendar_date,
                       FIRST_VALUE(count_on_hand) OVER (PARTITION BY sku,DATE (root_tstamp) ORDER BY root_tstamp ASC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS closing_stock
                FROM (SELECT *
                      FROM (SELECT stock_updated.sku,
                                   stock_updated.count_on_hand,
                                   stock_updated.root_tstamp
                            FROM atomic.com_finerylondon_stock_updated_1 stock_updated
                              LEFT JOIN atomic.events events ON stock_updated.root_id = events.event_id
                            WHERE events.app_id = 'production')
                      UNION
                      (SELECT variants.sku,
                             stock_items.count_on_hand,
                             stock_items.spree_timestamp
                      FROM daily_snapshot.spree_stock_items stock_items
                        LEFT JOIN (SELECT *
                                   FROM daily_snapshot.spree_variants
                                   WHERE spree_timestamp = (SELECT MAX(spree_timestamp)
                                                            FROM daily_snapshot.spree_variants)) variants ON stock_items.variant_id = variants.id
                      WHERE stock_items.deleted_at IS NULL
                      AND   variants.deleted_at IS NULL
                      AND   variants.is_master = 0)))
          GROUP BY 1,
                   2,
                   3

     sql_trigger_value: SELECT max(spree_timestamp) FROM ${spree_order_items.SQL_TABLE_NAME}
     distkey: sku
     sortkeys: [sku, closing_stock_date]

  fields:
  
#################################################################################################################################################################################################
########################################################## DIMENSIONS ###########################################################################################################################
#################################################################################################################################################################################################
  
  - dimension_group: closing_stock_date
    type: time
    timeframes: [date, dow, dow_num, week, dom, month, month_num]
    convert_tz: false
    sql: ${TABLE}.closing_stock_date
  
  - dimension: sku
    sql: ${TABLE}.sku
  
#################################################################################################################################################################################################
########################################################## MEASURES #############################################################################################################################
#################################################################################################################################################################################################
  
  - measure: closing_stock
    type: sum
    sql: ${TABLE}.closing_stock
  