- view: snowplow_product_click_through_daily
  derived_table:
     sql: |
          select
          impressions.impression_date,
          clicks.click_date,
          impressions.brand,
          impressions.category,
          impressions.id,
          impressions.list,
          impressions. "position",
          impressions.style,
          impressions.product_impressions,
          clicks.product_clicks
          from
          ${snowplow_product_impressions_daily.SQL_TABLE_NAME} impressions
          left join
          ${snowplow_product_clicked_daily.SQL_TABLE_NAME} clicks
          on impressions.impression_date = clicks.click_date
          and impressions.brand = clicks.brand
          and impressions.category = clicks.category
          and impressions.id = clicks.id
          and impressions.list = clicks.list
          and impressions."position" = clicks."position"
          and impressions.style = clicks.style

     sql_trigger_value: select max(click_date) from ${snowplow_product_clicked_daily.SQL_TABLE>NAME}
     distkey: id
     sortkeys: [id, click_date]

  fields:

    #################################################################################################################################################
  ######################################################## DIMENSIONS #############################################################################
#################################################################################################################################################

   - dimension_group: impression_date
     type: time
     label: CALENDAR
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
     sql: ${TABLE}.product_impressions
     hidden: true
   
   - dimension: product_clicks
     sql: ${TABLE}.product_clicks
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