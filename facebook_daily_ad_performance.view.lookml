- view: facebook_daily_ad_performance
  sql_table_name: facebook_data.daily_ad_performance
  fields:

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

  - dimension: behaviors
    sql: ${TABLE}.behaviors
    
  - dimension_group: calendar
    type: time
    timeframes: [date, week, month]
    convert_tz: false
    sql: ${TABLE}.calendar_date  

  - dimension: bid_billing_event
    sql: ${TABLE}.bid_billing_event

  - dimension: bid_optimization_goal
    sql: ${TABLE}.bid_optimization_goal

  - dimension: bid_type
    sql: ${TABLE}.bid_type

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

  - dimension: clicks
    type: int
    sql: ${TABLE}.clicks
    hidden: true

  - dimension: connections
    sql: ${TABLE}.connections
    hidden: true

  - dimension: conversions
    type: int
    sql: ${TABLE}.conversions
    hidden: true

  - dimension: conversions_account_0
    sql: ${TABLE}.conversions_account_0
    hidden: true

  - dimension: conversions_comments
    type: int
    sql: ${TABLE}.conversions_comments
    hidden: true
    
  - dimension: conversions_mentions
    type: int
    sql: ${TABLE}.conversions_mentions
    hidden: true
    
  - dimension: conversions_offsite_6019249047149
    sql: ${TABLE}.conversions_offsite_6019249047149
    hidden: true
    
  - dimension: conversions_offsite_6020814566949
    sql: ${TABLE}.conversions_offsite_6020814566949
    hidden: true
    
  - dimension: conversions_offsite_6020814633549
    sql: ${TABLE}.conversions_offsite_6020814633549
    hidden: true
    
  - dimension: conversions_offsite_6020814677949
    sql: ${TABLE}.conversions_offsite_6020814677949
    hidden: true
    
  - dimension: conversions_offsite_6020814706949
    sql: ${TABLE}.conversions_offsite_6020814706949
    hidden: true
    
  - dimension: conversions_offsite_6020814710549
    sql: ${TABLE}.conversions_offsite_6020814710549
    hidden: true
    
  - dimension: conversions_offsite_6020814716949
    sql: ${TABLE}.conversions_offsite_6020814716949
    hidden: true
    
  - dimension: conversions_offsite_6020814720149
    sql: ${TABLE}.conversions_offsite_6020814720149
    hidden: true
    
  - dimension: conversions_offsite_6031974989949
    sql: ${TABLE}.conversions_offsite_6031974989949
    hidden: true
    
  - dimension: conversions_page_engagement
    type: int
    sql: ${TABLE}.conversions_page_engagement
    hidden: true
    
  - dimension: conversions_page_likes
    type: int
    sql: ${TABLE}.conversions_page_likes
    hidden: true
    
  - dimension: conversions_post_engagement
    type: int
    sql: ${TABLE}.conversions_post_engagement
    hidden: true
    
  - dimension: conversions_post_likes
    type: int
    sql: ${TABLE}.conversions_post_likes
    hidden: true
    
  - dimension: conversions_post_shares
    type: int
    sql: ${TABLE}.conversions_post_shares
    hidden: true
    
  - dimension: conversions_website_clicks
    type: int
    sql: ${TABLE}.conversions_website_clicks
    hidden: true
    
  - dimension: countries
    sql: ${TABLE}.countries
    
  - dimension: creative_name
    sql: ${TABLE}.creative

  - dimension: page_name
    sql: ${TABLE}.creative_meta_page_name

  - dimension: url_tags
    sql: ${TABLE}.creative_meta_url_tags

  - dimension: creative_type
    sql: ${TABLE}.creative_type

  - dimension: custom_audiences
    sql: ${TABLE}.custom_audiences

  - dimension: date
    sql: ${TABLE}.date

  - dimension: excluded_custom_audiences
    sql: ${TABLE}.excluded_custom_audiences

  - dimension: facebook_objective
    sql: ${TABLE}.facebook_objective

  - dimension: frequency
    sql: ${TABLE}.frequency

  - dimension: genders
    sql: ${TABLE}.genders

  - dimension: impressions
    type: int 
    sql: ${TABLE}.impressions
    hidden: true
    
  - dimension: interests
    sql: ${TABLE}.interests

  - dimension: max_age
    sql: ${TABLE}.max_age

  - dimension: min_age
    sql: ${TABLE}.min_age

  - dimension: mobile_device
    sql: ${TABLE}.mobile_device
    hidden: true

  - dimension: mobile_os
    sql: ${TABLE}.mobile_os
    hidden: true

  - dimension: name
    sql: ${TABLE}.name
    hidden: true

  - dimension: picture
    sql: ${TABLE}.picture
    

  - dimension: placement
    sql: ${TABLE}.placement

  - dimension: post_id
    sql: ${TABLE}.post_id

  - dimension: post_type
    sql: ${TABLE}.post_type

  - dimension: reach
    sql: ${TABLE}.reach
    hidden: true

  - dimension: revenue
    sql: ${TABLE}.revenue
    hidden: true
    
  - dimension: spent
    type: int
    sql: ${TABLE}.spent
    hidden: true

  - dimension: title
    sql: ${TABLE}.title
    hidden: true

  - dimension: url
    sql: ${TABLE}.url


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
    label: Return on Investment
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
    
  - measure: cost_per_impression
    type: number
    sql: 1000 * ${sum_amount_spent}/ NULLIF(${sum_impressions},0) ::REAL
    value_format: '#,##0.00'
    
  - measure: cost_per_order
    type: number
    sql: ${sum_amount_spent}/ NULLIF(${sum_orders},0) ::REAL
    value_format: '#,##0.00'
    
    

  # ----- Sets of fields for drilling ------
  sets:
    detail:
    - creative_meta_page_name
    - campaign_name
    - adset_name
    - ad_name
    - account_name
    - name

