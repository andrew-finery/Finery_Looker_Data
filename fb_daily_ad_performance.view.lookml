- view: fb_daily_ad_performance
  sql_table_name: facebook_data.daily_ad_performance
  fields:

  - dimension: facebook_pixel_in_use
    sql: |
          case when ${TABLE}.date >= '2016-02-08' then 'New - Facebook Pixel'
          else 'Old - Conversion Pixel'end
          
  - dimension: account_name
    sql: ${TABLE}.account_name

  - dimension: ad
    label: Ad ID
    sql: ${TABLE}.ad

  - dimension: ad_name
    label: Ad
    sql: ${TABLE}.ad_name

  - dimension: adset
    label: Adset ID
    sql: ${TABLE}.adset

  - dimension: adset_name
    label: Adset
    sql: ${TABLE}.adset_name

  - dimension: behaviors
    sql: ${TABLE}.behaviors
    
  - dimension_group: calendar
    type: time
    timeframes: [date, day_of_week_index, day_of_week, week, week_of_year, day_of_month, month, month_num, year, quarter, quarter_of_year]
    convert_tz: false
    sql: ${TABLE}.date  

  - dimension: bid_billing_event
    sql: ${TABLE}.bid_billing_event

  - dimension: bid_optimization_goal
    sql: ${TABLE}.bid_optimization_goal

  - dimension: bid_type
    sql: ${TABLE}.bid_type

  - dimension: campaign
    sql: ${TABLE}.campaign

  - dimension: campaign_name
    sql: ${TABLE}.campaign_name

  - dimension: campaign_start_date
    sql: ${TABLE}.campaign_start_date

  - dimension: cities
    sql: ${TABLE}.cities

  - dimension: impressions
    type: int 
    sql: ${TABLE}.impressions
    hidden: true

  - dimension: clicks
    type: int
    sql: ${TABLE}.clicks
    hidden: true

  - dimension: conversions_website_clicks
    type: int
    sql: ${TABLE}.conversions_website_clicks
    hidden: true

  - dimension: connections
    sql: ${TABLE}.connections
    hidden: true

  - dimension: countries
    sql: ${TABLE}.countries

  - dimension: page_name
    sql: ${TABLE}.creative_meta_page_name

  - dimension: url_tags
    sql: ${TABLE}.creative_meta_url_tags

  - dimension: creative_type
    sql: ${TABLE}.creative_type

  - dimension: custom_audiences
    sql: ${TABLE}.custom_audiences

  - dimension: excluded_custom_audiences
    sql: ${TABLE}.excluded_custom_audiences

  - dimension: facebook_objective
    sql: ${TABLE}.facebook_objective

  - dimension: genders
    sql: ${TABLE}.genders

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

##    
  - dimension: creative_name
    label: Creative - Name
    sql: ${TABLE}.creative

  - dimension: picture
    label: Creative - Picture
    sql: ${TABLE}.picture
    html: |
          <img src="{{value}}" height="130" width="130"/>

  - dimension: call_to_action
    label: Creative - Call to Action Text
    sql: ${TABLE}.call_to_action

  - dimension: post_type
    label: Creative - Post Type
    sql: ${TABLE}.post_type
##

  - dimension: placement
    sql: ${TABLE}.placement

  - dimension: post_id
    sql: ${TABLE}.post_id

  - dimension: spent
    type: int
    sql: ${TABLE}.spent
    hidden: true

  - dimension: title
    label: Creative - Title
    sql: ${TABLE}.title

  - dimension: url
    label: Creative - Landing Page URL
    sql: ${TABLE}.url


 ######################################################################################################
  ###################################### MEASURES ####################################################
######################################################################################################

  - measure: total_impressions
    type: sum
    sql: ${impressions}

  - measure: total_clicks
    type: sum
    sql: ${clicks}

  - measure: total_spend
    type: sum
    decimals: 2
    sql: ${spent}
    value_format: '#,##0.00'

  - measure: total_website_clicks
    type: sum
    sql: ${conversions_website_clicks}

  - measure: click_through_rate
    label: CTR
    type: number
    sql: ${total_clicks}/ NULLIF(${total_impressions},0) ::REAL
    value_format: '0.00%'
    
  - measure: cost_per_click
    label: CPC
    type: number
    sql: ${total_spend}/ NULLIF(${total_clicks},0) ::REAL
    value_format: '#,##0.00'

  - measure: cost_per_website_click
    label: CPWC
    type: number
    sql: ${total_spend}/ NULLIF(${total_website_clicks},0) ::REAL
    value_format: '#,##0.00'    

  - measure: cost_per_mille
    label: CPM
    type: number
    sql: ${total_spend}*1000/ NULLIF(${total_impressions},0) ::REAL
    value_format: '#,##0.00'
