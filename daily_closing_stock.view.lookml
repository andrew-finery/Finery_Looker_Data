- view: daily_closing_stock
  derived_table:
     sql: |
          SELECT closing_stock.closing_stock_date,
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
  