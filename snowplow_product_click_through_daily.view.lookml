- view: snowplow_product_click_through_daily
  sql_table_name: finery.product_click_through_daily
  fields:

    #################################################################################################################################################
  ######################################################## DIMENSIONS #############################################################################
#################################################################################################################################################

   - dimension_group: impression_date
     type: time
     label: CALENDAR
     sql: ${TABLE}.impression_date
     timeframes: [date, week, month]

   - dimension: brand
     label: BRAND
     sql: ${TABLE}.brand
     hidden: true
   
   - dimension: category
     label: CATEGORY
     sql: ${TABLE}.category

   - dimension: product_id
     label: PRODUCT ID
     sql: ${TABLE}.id

   - dimension: list
     label: LIST
     sql: ${TABLE}.list
     
   - dimension: position
     type: int
     label: POSITION
     sql: cast(${TABLE}."position" as integer)

   - dimension: style
     label: STYLE
     sql: ${TABLE}.style

   - dimension: product_impressions
     sql: ${TABLE}.distinct_impressions
     hidden: true
   
   - dimension: product_clicks
     sql: ${TABLE}.distinct_clicks
     hidden: true

    #################################################################################################################################################
  ######################################################## MEASURES ###############################################################################
#################################################################################################################################################
     
   - measure: sum_product_impressions
     type: sum
     label: PRODUCT IMPRESSIONS
     sql: ${product_impressions}
   
   - measure: sum_product_clicks
     type: sum
     label: PRODUCT CLICKS
     sql: ${product_clicks}
   
   - measure: click_through_rate
     type: number
     label: CLICK-THROUGH RATE
     sql: ${sum_product_clicks}/NULLIF(${sum_product_impressions},0)::REAL
     value_format: '#0.00%'