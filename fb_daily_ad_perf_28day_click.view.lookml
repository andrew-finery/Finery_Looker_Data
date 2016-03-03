- view: fb_daily_ad_perf_28day_click
  sql_table_name: facebook_data.daily_ad_performance
  fields:

  - dimension: facebook_pixel_in_use
    sql: |
          case when ${TABLE}.date >= '2016-02-08' then 'New - Facebook Pixel'
          else 'Old - Conversion Pixel'end
    hidden: true
    
  - dimension: ad
    sql: ${TABLE}.ad
    hidden: true

  - dimension_group: calendar
    type: time
    timeframes: [date, week]
    convert_tz: false
    sql: ${TABLE}.date  
    hidden: true
    
  - dimension: impressions
    type: int 
    sql: ${TABLE}.impressions
    hidden: true

  - dimension: clicks
    type: int
    sql: ${TABLE}.clicks
    hidden: true

  - dimension: connections
    sql: ${TABLE}.connections
    hidden: true

  - dimension: goal_conversions
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

# Conversion Facebook Pixels

  - dimension: action_complete_registration
    sql: ${TABLE}.std_event_complete_regist
    hidden: true
    
  - dimension: action_sale
    sql: |
          case when ${TABLE}."date" >= '2016-02-08' then ${TABLE}.std_event_purchase
          else ${TABLE}.conversions_offsite_6020814566949 end
    hidden: true
    
  - dimension: action_lead
    sql: ${TABLE}.std_event_lead
    hidden: true

  - dimension: action_view_content
    sql: |
          case when ${TABLE}."date" >= '2016-02-08' then ${TABLE}.std_event_view_content
          else ${TABLE}.conversions_offsite_6020814677949 end
    hidden: true
    
  - dimension: action_add_to_cart
    sql: ${TABLE}.std_event_add_to_cart
    sql: |
          case when ${TABLE}."date" >= '2016-02-08' then ${TABLE}.std_event_add_to_cart
          else ${TABLE}.conversions_offsite_6020814706949 end
    hidden: true
    
  - dimension: action_initate_checkout
    sql: ${TABLE}.std_event_initiate_checkout
    hidden: true

# Other Conversions
    
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

  - dimension: revenue
    sql: ${TABLE}.revenue
    hidden: true
    
  - dimension: spent
    type: int
    sql: ${TABLE}.spent
    hidden: true


 ######################################################################################################
  ###################################### MEASURES ####################################################
######################################################################################################

  - measure: total_impressions
    type: sum
    sql: ${impressions}
    hidden: true

  - measure: total_clicks
    type: sum
    sql: ${clicks}
    hidden: true
    
  - measure: sum_revenue
    label: Revenue
    type: sum
    sql: ${revenue}
    value_format: '#,##0.00'
    
  - measure: total_spend
    type: sum
    decimals: 2
    sql: ${spent}
    value_format: '#,##0.00'
    hidden: true
    
  - measure: total_website_clicks
    type: sum
    sql: ${conversions_website_clicks}
    hidden: true
    
  - measure: click_through_rate
    label: CTR
    type: number
    sql: ${total_clicks}/ NULLIF(${total_impressions},0) ::REAL
    value_format: '0.00%'
    hidden: true
    
  - measure: cost_per_click
    label: CPC
    type: number
    sql: ${total_spend}/ NULLIF(${total_clicks},0) ::REAL
    value_format: '#,##0.00'
    hidden: true
    
  - measure: cost_per_website_click
    label: CPWC
    type: number
    sql: ${total_spend}/ NULLIF(${total_website_clicks},0) ::REAL
    value_format: '#,##0.00'    
    hidden: true
    
  - measure: cost_per_mille
    label: CPM
    type: number
    sql: ${total_spend}*1000/ NULLIF(${total_impressions},0) ::REAL
    value_format: '#,##0.00'
    hidden: true

# Sum Actions

  - measure: total_action_complete_registration
    type: sum
    sql: ${action_complete_registration}

  - measure: total_action_sale
    type: sum
    sql: ${action_sale}

  - measure: total_action_lead
    type: sum
    sql: ${action_lead}

  - measure: total_action_view_content
    type: sum
    sql: ${action_view_content}

  - measure: total_action_add_to_cart
    type: sum
    sql: ${action_add_to_cart}

  - measure: total_action_initate_checkout
    type: sum
    sql: ${action_initate_checkout}

  - measure: total_goal_conversions
    type: sum
    sql: ${goal_conversions}

# CPA's

  - measure: cpa_complete_registration
    type: number
    sql: ${total_spend}/ NULLIF(${total_action_complete_registration},0) ::REAL
    value_format: '#,##0.00'

  - measure: cpa_sale
    type: number
    sql: ${total_spend}/ NULLIF(${total_action_sale},0) ::REAL
    value_format: '#,##0.00'

  - measure: cpa_lead
    type: number
    sql: ${total_spend}/ NULLIF(${total_action_lead},0) ::REAL
    value_format: '#,##0.00'

  - measure: cpa_product_view_content
    type: number
    sql: ${total_spend}/ NULLIF(${total_action_view_content},0) ::REAL
    value_format: '#,##0.00'
    
  - measure: cpa_add_to_cart
    type: number
    sql: ${total_spend}/ NULLIF(${total_action_add_to_cart},0) ::REAL
    value_format: '#,##0.00'
    
  - measure: cpa_initiate_checkout
    type: number
    sql: ${total_spend}/ NULLIF(${total_action_initate_checkout},0) ::REAL
    value_format: '#,##0.00'
