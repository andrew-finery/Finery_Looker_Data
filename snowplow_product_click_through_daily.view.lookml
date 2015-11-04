- view: snowplow_product_click_through_daily
  sql_table_name: web.product_click_through_daily
  fields:

    #################################################################################################################################################
  ######################################################## DIMENSIONS #############################################################################
#################################################################################################################################################

   - dimension_group: impression_date
     type: time
     label: Calendar
     sql: ${TABLE}.calendar_date
     timeframes: [date, week, month]

   - dimension: impression_type
     sql: ${TABLE}.impression_type

   - dimension: product_id
     sql: ${TABLE}.product_id

   - dimension: impression_source
     sql: ${TABLE}.impression_source

   - dimension: style
     sql: ${TABLE}.style

   - dimension: product_impressions
     sql: ${TABLE}.impressions
     hidden: true
   
   - dimension: product_clicks
     sql: ${TABLE}.clicks
     hidden: true

   - dimension: category_product_impressions
     sql: ${TABLE}.category_page_impressions
     hidden: true
   
   - dimension: category_product_clicks
     sql: ${TABLE}.category_page_clicks
     hidden: true

    #################################################################################################################################################
  ######################################################## MEASURES ###############################################################################
#################################################################################################################################################
     
   - measure: sum_product_impressions
     type: sum
     sql: ${product_impressions}
   
   - measure: sum_product_clicks
     type: sum
     sql: ${product_clicks}
   
   - measure: click_through_rate_overall
     type: number
     sql: ${sum_product_clicks}/NULLIF(${sum_product_impressions},0)::REAL
     value_format: '#0.00%'

   - measure: sum_category_product_impressions
     type: sum
     sql: ${category_product_impressions}
   
   - measure: sum_category_product_clicks
     type: sum
     sql: ${category_product_clicks}
   
   - measure: click_through_rate_category
     type: number
     sql: ${sum_category_product_clicks}/NULLIF(${sum_category_product_impressions},0)::REAL
     value_format: '#0.00%'