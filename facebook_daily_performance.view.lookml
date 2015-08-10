- view: facebook_daily_performance
  sql_table_name: marketing_data.facebook_daily_performance
  fields:
  
######################################################################################################
  ###################################### DIMENSIONS ####################################################
    ######################################################################################################

  - dimension: account_name
    sql: ${TABLE}.account_name

  - dimension: ad
    sql: ${TABLE}.ad

  - dimension: ad_name
    sql: ${TABLE}.ad_name

  - dimension: adset
    sql: ${TABLE}.adset

  - dimension: adset_name
    sql: ${TABLE}.adset_name

  - dimension: behaviours
    sql: ${TABLE}.behaviours

  - dimension_group: calendar
    type: time
    timeframes: [date, week, month]
    convert_tz: false
    sql: ${TABLE}.calendar_date

  - dimension: call_to_action
    sql: ${TABLE}.call_to_action

  - dimension: campaign
    sql: ${TABLE}.campaign

  - dimension: campaign_name
    sql: ${TABLE}.campaign_name

  - dimension: campaign_start_date
    sql: ${TABLE}.campaign_start_date

  - dimension: cities
    sql: ${TABLE}.cities

  - dimension: connections
    sql: ${TABLE}.connections

  - dimension: countries
    sql: ${TABLE}.countries

  - dimension: cpa_website_click
    type: number
    sql: ${TABLE}.cpa_website_click

  - dimension: creative
    sql: ${TABLE}.creative

  - dimension: creative_type
    sql: ${TABLE}.creative_type

  - dimension: custom_audiences
    sql: ${TABLE}.custome_audiences

  - dimension: excluded_custom_audiences
    sql: ${TABLE}.excluded_custom_audiences

  - dimension: facebook_objective
    sql: ${TABLE}.facebook_objective

  - dimension: genders
    type: int
    sql: ${TABLE}.genders

  - dimension: interests
    sql: ${TABLE}.interests

  - dimension: max_age
    type: int
    sql: ${TABLE}.max_age

  - dimension: min_age
    type: int
    sql: ${TABLE}.min_age

  - dimension: mobile_device
    sql: ${TABLE}.mobile_device

  - dimension: mobile_os
    sql: ${TABLE}.mobile_os

  - dimension: name
    sql: ${TABLE}.name

  - dimension: picture
    sql: ${TABLE}.picture

  - dimension: placement
    sql: ${TABLE}.placement

  - dimension: post_id
    sql: ${TABLE}.post_id

  - dimension: post_type
    sql: ${TABLE}.post_type

  - dimension: relevance_score
    sql: ${TABLE}.relevance_score

  - dimension: text
    sql: ${TABLE}.text_

  - dimension: title
    sql: ${TABLE}.title

  - dimension: url
    sql: ${TABLE}.url

  - dimension: online_flag
    type: yesno
    sql: ${impressions} > 0

  - dimension: impressions
    type: number
    sql: ${TABLE}.impressions
    hidden: true

  - dimension: clicks
    type: int
    sql: ${TABLE}.clicks
    hidden: true

  - dimension: conversions
    type: int
    sql: ${TABLE}.conversions
    hidden: true

  - dimension: conversions_website_click
    type: int
    sql: ${TABLE}.conversions_website_click
    hidden: true

  - dimension: revenue
    type: number
    sql: ${TABLE}.revenue
    hidden: true

  - dimension: spent
    type: number
    decimals: 2
    sql: ${TABLE}.spent
    hidden: true



    ######################################################################################################
  ###################################### MEASURES ####################################################
######################################################################################################

  - measure: sum_impressions
    label: Impressions
    type: sum
    sql: ${impressions}

  - measure: sum_clicks
    label: Clicks
    type: sum
    sql: ${clicks}

  - measure: sum_orders
    label: Orders
    type: sum
    sql: ${conversions}

  - measure: sum_revenue
    label: Revenue
    type: sum
    sql: ${revenue}
    value_format: '#,##0.00'
    hidden: true

  - measure: sum_amount_spent
    label: Total Spend
    type: sum
    decimals: 2
    sql: ${spent}
    value_format: '#,##0.00'

  - measure: roi
    label: ROI
    type: number
    sql: (${sum_revenue} - ${sum_amount_spent})/ NULLIF(${sum_amount_spent},0) ::REAL    
    value_format: '0.00%'
    hidden: true

  - measure: click_through_rate
    label: Click-Through Rate
    type: number
    sql: ${sum_clicks}/ NULLIF(${sum_impressions},0) ::REAL
    value_format: '0.00%'
    
  - measure: cost_per_click
    type: number
    sql: ${sum_amount_spent}/ NULLIF(${sum_clicks},0) ::REAL
    value_format: '#,##0.00'
    
  - measure: cost_per_mille
    type: number
    sql: 1000 * ${sum_amount_spent}/ NULLIF(${sum_impressions},0) ::REAL
    value_format: '#,##0.00'
    
  - measure: cost_per_order
    type: number
    sql: ${sum_amount_spent}/ NULLIF(${sum_orders},0) ::REAL
    value_format: '#,##0.00'