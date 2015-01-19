- view: weekly_closing_stock
  derived_table:
     sql: |
          SELECT calendar.year_week_number,
                 closing_stock.sku,
                 stock_updated.count_on_hand AS closing_stock
          FROM (SELECT sku,
                       DATE (root_tstamp) - 1 AS closing_stock_date,
                       MIN(root_tstamp) AS root_tstamp
                FROM atomic.com_finerylondon_stock_updated_1 stock_updated
                  LEFT JOIN atomic.events events ON stock_updated.root_id = events.event_id
                WHERE events.app_id = 'production'
                GROUP BY 1,
                         2) closing_stock
            LEFT JOIN atomic.com_finerylondon_stock_updated_1 stock_updated
                   ON closing_stock.sku = stock_updated.sku
                  AND closing_stock.root_tstamp = stock_updated.root_tstamp
            LEFT JOIN lookup.calendar calendar ON closing_stock.closing_stock_date = calendar.calendar_date
            where calendar.dow = 'Sunday'

  fields:
  
#################################################################################################################################################################################################
########################################################## DIMENSIONS ###########################################################################################################################
#################################################################################################################################################################################################
  
  - dimension: year_week_number
    sql: ${TABLE}.year_week_number
  
  - dimension: sku
    sql: ${TABLE}.sku
  
#################################################################################################################################################################################################
########################################################## MEASURES #############################################################################################################################
#################################################################################################################################################################################################
  
  - measure: closing_stock
    type: sum
    sql: ${TABLE}.closing_stock
