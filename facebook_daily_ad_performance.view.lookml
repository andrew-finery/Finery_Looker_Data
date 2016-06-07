- view: facebook_daily_ad_performance
  sql_table_name: facebook_data.daily_ad_performance
  fields:

  #- dimension: facebook_pixel_in_use
  #  sql: |
  #        case when ${TABLE}.date >= '2016-02-08' then 'New - Facebook Pixel'
  #        else 'Old - Conversion Pixel'end
          
  #- dimension: account_name
  #  sql: ${TABLE}.account_name

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
    sql: ${TABLE}.date  

  #- dimension: bid_billing_event
  #  sql: ${TABLE}.bid_billing_event

  #- dimension: bid_optimization_goal
  #  sql: ${TABLE}.bid_optimization_goal

  #- dimension: bid_type
  #  sql: ${TABLE}.bid_type


  - dimension: campaign
    sql: ${TABLE}.campaign

  - dimension: campaign_name
    sql: ${TABLE}.campaign_name

  - dimension: campaign_type
    sql: |
          case
          when ${campaign_name} like '%DPA%' then 'DPA'
          when ${campaign_name} like '%Brand%' then 'Brand'
          when ${campaign_name} like '%brand%' then 'Brand'
          when ${campaign_name} like '%BRAND%' then 'Brand'
          when ${campaign_name} like '%DR%' then 'DR'
          else 'Other' end
          
 # - dimension: campaign_start_date
 #   sql: ${TABLE}.campaign_start_date

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

  #- dimension: connections
  #  sql: ${TABLE}.connections
  #  hidden: true

  #- dimension: goal_conversions
  #  type: int
  #  sql: ${TABLE}.conversions
  #  hidden: true

  #- dimension: conversions_account_0
  #  sql: ${TABLE}.conversions_account_0
  #  hidden: true

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
    sql: ${TABLE}.fb_pixel_complete_registration
    hidden: true
    
  - dimension: action_sale
    sql: ${TABLE}.fb_pixel_purchase
    hidden: true
    
  - dimension: action_lead
    sql: ${TABLE}.std_event_lead
    hidden: true

  - dimension: action_view_content
    sql: ${TABLE}.fb_pixel_view_content
    hidden: true
    
  - dimension: action_add_to_cart
    sql: ${TABLE}.fb_pixel_add_to_cart
    hidden: true
    
  - dimension: action_initate_checkout
    sql: ${TABLE}.fb_pixel_initiate_checkout
    hidden: true

  #- dimension: action_delivery
  #  sql: ${TABLE}.conversions_offsite_6020814716949
  #  hidden: true

  #- dimension: action_payment
  #  sql: ${TABLE}.conversions_offsite_6020814720149
  #  hidden: true
    
  #- dimension: action_engagement
  #  sql: ${TABLE}.conversions_offsite_6031974989949
  #  hidden: true

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
    sql: coalesce(${TABLE}.conversions_website_clicks,0)
    hidden: true
    
  - dimension: countries
    sql: ${TABLE}.countries

  - dimension: page_name
    sql: ${TABLE}.creative_meta_page_name

  - dimension: url_tags
    sql: ${TABLE}.creative_meta_url_tags

  - dimension: creative_type
    sql: ${TABLE}.creative_type

  - dimension: creative_group
    sql: |
          case
          when ${creative_name} like '%Image _A%' then 'Image A (Image)'
          when ${creative_name} like '%Image_A%' then 'Image A (Image)'
          when ${creative_name} like '%Image _B%' then 'Image B (Graphic)'
          when ${creative_name} like '%Image_B%' then 'Image B (Graphic)'
          when ${creative_name} like '%Multi%' then 'Multi-Product'
          else ${creative_name} end

  - dimension: custom_audiences
    sql: ${TABLE}.custom_audiences

  - dimension: excluded_custom_audiences
    sql: ${TABLE}.excluded_custom_audiences

  - dimension: facebook_objective
    sql: ${TABLE}.facebook_objective

  - dimension: frequency
    sql: ${TABLE}.frequency

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

  - measure: sum_revenue
    label: Revenue
    type: sum
    sql: ${revenue}
    value_format: '#,##0.00'
    hidden: true

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

  - measure: offsite_conversions_to_impressions
    type: number
    sql: ${total_goal_conversions}/ NULLIF(${total_impressions},0) ::REAL
    value_format: '#0.000%'

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

  #- measure: total_action_delivery
  #  type: sum
  #  sql: ${action_delivery}

  #- measure: total_action_payment
  #  type: sum
  #  sql: ${action_payment}

  #- measure: total_action_engagement
  #  type: sum
  #  sql: ${action_engagement}

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
    
  #- measure: cpa_action_delivery
  #  type: number
  #  sql: ${total_spend}/ NULLIF(${total_action_delivery},0) ::REAL
  #  value_format: '#,##0.00'

  #- measure: cpa_action_payment
  #  type: number
  #  sql: ${total_spend}/ NULLIF(${total_action_payment},0) ::REAL
  #  value_format: '#,##0.00'
    
  #- measure: cpa_action_engagement
  #  type: number
  #  sql: ${total_spend}/ NULLIF(${total_action_engagement},0) ::REAL
  #  value_format: '#,##0.00'
