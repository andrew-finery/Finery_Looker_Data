- view: snowplow_product_click_through_daily
  sql_table_name: finery.product_click_through_daily
  fields:

    #################################################################################################################################################
  ######################################################## DIMENSIONS #############################################################################
#################################################################################################################################################

   - dimension_group: impression_date
     type: time
     label: Calendar
     sql: ${TABLE}.impression_date
     timeframes: [date, week, month]

   - dimension: brand
     sql: ${TABLE}.brand
     hidden: true
   
   - dimension: category
     sql: ${TABLE}.category

   - dimension: product_id
     sql: ${TABLE}.id

   - dimension: list
     sql: ${TABLE}.list
     
   - dimension: position
     type: int
     sql: cast(${TABLE}."position" as integer)

   - dimension: style
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
     label: Product Impressions
     sql: ${product_impressions}
   
   - measure: sum_product_clicks
     type: sum
     label: Product Clicks
     sql: ${product_clicks}
   
   - measure: click_through_rate
     type: number
     label: Click-Through Rate
     sql: ${sum_product_clicks}/NULLIF(${sum_product_impressions},0)::REAL
     value_format: '#0.00%'