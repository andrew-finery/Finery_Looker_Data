- view: facebook_api_ad_performance
  sql_table_name: facebook_data.facebook_ad_performance
  fields:
  
  - dimension: audience_segment
    sql: |
          case when ${TABLE}.campaign_name like '%Acquisition%' then 'Acquisition'
          when ${TABLE}.campaign_name like '%Custom Audience%' then 'Retargeting Custom Audience'
          when ${TABLE}.campaign_name like '%DPA%' then 'Retargeting DPA'
          when ${TABLE}.campaign_name like '%Reactivation%' then 'Retargeting Customer Reactivation' end
          
  - dimension: buyers_vs_nonbuyers
    sql: |
          case when ${TABLE}.campaign_name not like '%Retention%' and ${TABLE}.campaign_name not like '%Reactivation%' then 'Customer Acquisition'
          when ${TABLE}.campaign_name like '%Retention%' then 'Customer Retention'
          when ${TABLE}.campaign_name like '%Reactivation%' then 'Customer Retention' end
          
  - dimension: country
    sql: |
          case when ${TABLE}.campaign_name like '%UK%' then 'UK'
          when ${TABLE}.campaign_name like '%USA%' then 'US'
          when ${TABLE}.campaign_name like '%Ireland%' then 'IE'
          when ${TABLE}.campaign_name like '%AUS%' then 'AUS' end
          
          
  - dimension: placement
    sql: |
          case when ${TABLE}.campaign_name like '%Instagram%' or ${TABLE}.advert_set_name like '%Instagram%' then 'Instagram'
          when ${TABLE}.campaign_name like '%Mobile%' or ${TABLE}.advert_set_name like '%NFM%' or ${TABLE}.advert_set_name like '%Mobile%' then 'Mobile' 
          when ${TABLE}.campaign_name like '%Desktop%' or ${TABLE}.advert_set_name like '%NFD%' or ${TABLE}.advert_set_name like '%RHS%' or ${TABLE}.advert_set_name like '%Desktop%'  then 'Desktop' end

  
  
  #- dimension: add_payment_info_facebook_pixel
  #  type: string
  #  hidden: true
  #  sql: ${TABLE}.add_payment_info_facebook_pixel

  #- dimension: add_payment_info_facebook_pixel_1_day_after_clicking
  #  type: string
  #  hidden: true
  #  sql: ${TABLE}.add_payment_info_facebook_pixel_1_day_after_clicking

  #- dimension: add_payment_info_facebook_pixel_28_days_after_clicking
  #  type: string
  #  hidden: true
  #  sql: ${TABLE}.add_payment_info_facebook_pixel_28_days_after_clicking

  #- dimension: add_payment_info_facebook_pixel_7_days_after_clicking
  #  hidden: true
  #  sql: ${TABLE}.add_payment_info_facebook_pixel_7_days_after_clicking
  #  type: string

  - dimension: add_to_basket_facebook_pixel
    type: string
    sql: ${TABLE}.add_to_basket_facebook_pixel

  - dimension: add_to_basket_facebook_pixel_1_day_after_clicking
    type: string
    sql: ${TABLE}.add_to_basket_facebook_pixel_1_day_after_clicking

  - dimension: add_to_basket_facebook_pixel_28_days_after_clicking
    type: string
    sql: ${TABLE}.add_to_basket_facebook_pixel_28_days_after_clicking

  - dimension: add_to_basket_facebook_pixel_7_days_after_clicking
    type: string
    sql: ${TABLE}.add_to_basket_facebook_pixel_7_days_after_clicking

  #- dimension: add_to_wishlist_facebook_pixel
  #  type: string
  #  hidden: true
  #  sql: ${TABLE}.add_to_wishlist_facebook_pixel

  #- dimension: add_to_wishlist_facebook_pixel_1_day_after_clicking
  #  hidden: true
  #  type: string
  #  sql: ${TABLE}.add_to_wishlist_facebook_pixel_1_day_after_clicking

  #- dimension: add_to_wishlist_facebook_pixel_28_days_after_clicking
  #  type: string
  #  hidden: true
  #  sql: ${TABLE}.add_to_wishlist_facebook_pixel_28_days_after_clicking

  #- dimension: add_to_wishlist_facebook_pixel_7_days_after_clicking
  #  type: string
  #  hidden: true
  #  sql: ${TABLE}.add_to_wishlist_facebook_pixel_7_days_after_clicking

  - dimension: advert_id
    type: string
    sql: ${TABLE}.advert_id

  - dimension: advert_name
    type: string
    sql: ${TABLE}.advert_name

  - dimension: advert_relevance_score
    type: string
    sql: ${TABLE}.advert_relevance_score

  - dimension: advert_set_id
    type: string
    sql: ${TABLE}.advert_set_id

  - dimension: advert_set_name
    type: string
    sql: ${TABLE}.advert_set_name

  - dimension: amount_spent_gbp
    type: number
    hidden: true
    sql: ${TABLE}.amount_spent_gbp

  #- dimension: avg_duration_canvas_viewed_gbp
  #  type: string
  #  sql: ${TABLE}.avg_duration_canvas_viewed_gbp

  #- dimension: avg_per_canvas_viewed_gbp
  #  type: string
  #  sql: ${TABLE}.avg_per_canvas_viewed_gbp

  #- dimension: business_name
  #  type: string
  #  hidden: true
  #  sql: ${TABLE}.business_name

  - dimension: button_clicks
    type: string
    sql: ${TABLE}.button_clicks

  - dimension: campaign_id
    type: string
    sql: ${TABLE}.campaign_id

  - dimension: campaign_name
    type: string
    sql: ${TABLE}.campaign_name

  - dimension: clicks_all
    type: string
    hidden: true
    sql: ${TABLE}.clicks_all

  #- dimension: clicks_to_play_video
  #  type: string
  #  sql: ${TABLE}.clicks_to_play_video

  #- dimension: clicks_to_play_video_1_day_after_clicking
  #  type: string
  #  sql: ${TABLE}.clicks_to_play_video_1_day_after_clicking

  #- dimension: clicks_to_play_video_28_days_after_clicking
  #  type: string
  #  sql: ${TABLE}.clicks_to_play_video_28_days_after_clicking

  #- dimension: clicks_to_play_video_7_days_after_clicking
  #  type: string
  #  sql: ${TABLE}.clicks_to_play_video_7_days_after_clicking

  - dimension: complete_registration_facebook_pixel
    type: string
    hidden: true
    sql: ${TABLE}.complete_registration_facebook_pixel

  - dimension: complete_registration_facebook_pixel_1_day_after_clicking
    type: string
    hidden: true
    sql: ${TABLE}.complete_registration_facebook_pixel_1_day_after_clicking

  - dimension: complete_registration_facebook_pixel_28_days_after_clicking
    type: string
    hidden: true
    sql: ${TABLE}.complete_registration_facebook_pixel_28_days_after_clicking

  - dimension: complete_registration_facebook_pixel_7_days_after_clicking
    type: string
    hidden: true
    sql: ${TABLE}.complete_registration_facebook_pixel_7_days_after_clicking

  - dimension: ctr_all
    type: string
    sql: ${TABLE}.ctr_all

  - dimension: ctr_link
    type: string
    sql: ${TABLE}.ctr_link

  - dimension: effective_status
    type: string
    sql: ${TABLE}.effective_status

  #- dimension: event_responses
  #  type: string
  #  hidden: true
  #  sql: ${TABLE}.event_responses

  #- dimension: event_responses_1_day_after_clicking
  #  type: string
  #  hidden: true
  #  sql: ${TABLE}.event_responses_1_day_after_clicking

  #- dimension: event_responses_28_days_after_clicking
  #  type: string
  #  hidden: true
  #  sql: ${TABLE}.event_responses_28_days_after_clicking

  #- dimension: event_responses_7_days_after_clicking
  #  type: string
  #  hidden: true
  #  sql: ${TABLE}.event_responses_7_days_after_clicking

  - dimension: frequency
    type: number
    sql: cast(${TABLE}.frequency as decimal(20,10))
    value_format: '#,##0.00'

  - dimension: impressions
    type: number
    hidden: true
    sql: cast(${TABLE}.impressions as integer)

  - dimension: initiate_checkout_facebook_pixel
    type: string
    sql: ${TABLE}.initiate_checkout_facebook_pixel

  - dimension: initiate_checkout_facebook_pixel_1_day_after_clicking
    type: string
    sql: ${TABLE}.initiate_checkout_facebook_pixel_1_day_after_clicking

  - dimension: initiate_checkout_facebook_pixel_28_days_after_clicking
    type: string
    sql: ${TABLE}.initiate_checkout_facebook_pixel_28_days_after_clicking

  - dimension: initiate_checkout_facebook_pixel_7_days_after_clicking
    type: string
    sql: ${TABLE}.initiate_checkout_facebook_pixel_7_days_after_clicking

  - dimension: lead_facebook_pixel
    type: string
    sql: ${TABLE}.lead_facebook_pixel

  - dimension: lead_facebook_pixel_1_day_after_clicking
    type: string
    sql: ${TABLE}.lead_facebook_pixel_1_day_after_clicking

  - dimension: lead_facebook_pixel_28_days_after_clicking
    type: string
    sql: ${TABLE}.lead_facebook_pixel_28_days_after_clicking

  - dimension: lead_facebook_pixel_7_days_after_clicking
    type: string
    sql: ${TABLE}.lead_facebook_pixel_7_days_after_clicking

  - dimension: link_clicks
    type: string
    sql: ${TABLE}.link_clicks

  - dimension: link_clicks_1_day_after_clicking
    type: string
    sql: ${TABLE}.link_clicks_1_day_after_clicking

  - dimension: link_clicks_28_days_after_clicking
    type: string
    sql: ${TABLE}.link_clicks_28_days_after_clicking

  - dimension: link_clicks_7_days_after_clicking
    type: string
    sql: ${TABLE}.link_clicks_7_days_after_clicking

  - dimension: negative_feedback
    type: string
    sql: ${TABLE}.negative_feedback

  #- dimension: objective
  #  type: string
  #  sql: ${TABLE}.objective

  #- dimension: offer_claims
  #  type: string
  #  sql: ${TABLE}.offer_claims

  #- dimension: offer_claims_1_day_after_clicking
  #  type: string
  #  sql: ${TABLE}.offer_claims_1_day_after_clicking

  #- dimension: offer_claims_28_days_after_clicking
  #  type: string
  #  sql: ${TABLE}.offer_claims_28_days_after_clicking

  #- dimension: offer_claims_7_days_after_clicking
  #  type: string
  #  sql: ${TABLE}.offer_claims_7_days_after_clicking

  - dimension: page_engagement
    type: string
    sql: ${TABLE}.page_engagement

  - dimension: page_engagement_1_day_after_clicking
    type: string
    sql: ${TABLE}.page_engagement_1_day_after_clicking

  - dimension: page_engagement_28_days_after_clicking
    type: string
    sql: ${TABLE}.page_engagement_28_days_after_clicking

  - dimension: page_engagement_7_days_after_clicking
    type: string
    sql: ${TABLE}.page_engagement_7_days_after_clicking

  - dimension: page_likes
    type: string
    sql: ${TABLE}.page_likes

  - dimension: page_likes_1_day_after_clicking
    type: string
    sql: ${TABLE}.page_likes_1_day_after_clicking

  - dimension: page_likes_28_days_after_clicking
    type: string
    sql: ${TABLE}.page_likes_28_days_after_clicking

  - dimension: page_likes_7_days_after_clicking
    type: string
    sql: ${TABLE}.page_likes_7_days_after_clicking

  #- dimension: page_tab_views
  #  type: string
  #  hidden: true
  #  sql: ${TABLE}.page_tab_views

  #- dimension: page_tab_views_1_day_after_clicking
  #  type: string
  #  hidden: true
  #  sql: ${TABLE}.page_tab_views_1_day_after_clicking

  #- dimension: page_tab_views_28_days_after_clicking
  #  type: string
  #  hidden: true
  #  sql: ${TABLE}.page_tab_views_28_days_after_clicking

  #- dimension: page_tab_views_7_days_after_clicking
  #  type: string
  #  hidden: true
  #  sql: ${TABLE}.page_tab_views_7_days_after_clicking

  - dimension: positive_feedback
    type: string
    sql: ${TABLE}.positive_feedback

  - dimension: post_comments
    type: string
    sql: ${TABLE}.post_comments

  - dimension: post_comments_1_day_after_clicking
    type: string
    sql: ${TABLE}.post_comments_1_day_after_clicking

  - dimension: post_comments_28_days_after_clicking
    type: string
    sql: ${TABLE}.post_comments_28_days_after_clicking

  - dimension: post_comments_7_days_after_clicking
    type: string
    sql: ${TABLE}.post_comments_7_days_after_clicking

  - dimension: post_engagement
    type: string
    sql: ${TABLE}.post_engagement

  - dimension: post_engagement_1_day_after_clicking
    type: string
    sql: ${TABLE}.post_engagement_1_day_after_clicking

  - dimension: post_engagement_28_days_after_clicking
    type: string
    sql: ${TABLE}.post_engagement_28_days_after_clicking

  - dimension: post_engagement_7_days_after_clicking
    type: string
    sql: ${TABLE}.post_engagement_7_days_after_clicking

  - dimension: post_likes
    type: string
    sql: ${TABLE}.post_likes

  - dimension: post_likes_1_day_after_clicking
    type: string
    sql: ${TABLE}.post_likes_1_day_after_clicking

  - dimension: post_likes_28_days_after_clicking
    type: string
    sql: ${TABLE}.post_likes_28_days_after_clicking

  - dimension: post_likes_7_days_after_clicking
    type: string
    sql: ${TABLE}.post_likes_7_days_after_clicking

  - dimension: post_shares
    type: string
    sql: ${TABLE}.post_shares

  - dimension: post_shares_1_day_after_clicking
    type: string
    sql: ${TABLE}.post_shares_1_day_after_clicking

  - dimension: post_shares_28_days_after_clicking
    type: string
    sql: ${TABLE}.post_shares_28_days_after_clicking

  - dimension: post_shares_7_days_after_clicking
    type: string
    sql: ${TABLE}.post_shares_7_days_after_clicking

  - dimension: purchase_facebook_pixel
    type: string
    sql: ${TABLE}.purchase_facebook_pixel

  - dimension: purchase_facebook_pixel_1_day_after_clicking
    type: string
    sql: ${TABLE}.purchase_facebook_pixel_1_day_after_clicking

  - dimension: purchase_facebook_pixel_28_days_after_clicking
    type: string
    sql: ${TABLE}.purchase_facebook_pixel_28_days_after_clicking

  - dimension: purchase_facebook_pixel_7_days_after_clicking
    type: string
    sql: ${TABLE}.purchase_facebook_pixel_7_days_after_clicking

  - dimension: reach
    type: string
    sql: ${TABLE}.reach

  - dimension: relevance_score
    type: string
    sql: ${TABLE}.relevance_score

  - dimension: relevance_score_status
    type: string
    sql: ${TABLE}.relevance_score_status

  - dimension: relevanceorganic_rank
    type: string
    sql: ${TABLE}.relevanceorganic_rank

  - dimension_group: calendar
    type: time
    timeframes: [date, day_of_week_index, day_of_week, week, week_of_year, day_of_month, month, month_num, year, quarter, quarter_of_year]
    convert_tz: false
    sql: cast(${TABLE}.reporting_starts as date)

  - dimension: reporting_starts
    type: string
    hidden: true
    sql: cast(${TABLE}.reporting_starts as date)

  #- dimension: search_facebook_pixel
  #  type: string
  #  hidden: true
  #  sql: ${TABLE}.search_facebook_pixel

  #- dimension: search_facebook_pixel_1_day_after_clicking
  #  type: string
  #  hidden: true
  #  sql: ${TABLE}.search_facebook_pixel_1_day_after_clicking

  #- dimension: search_facebook_pixel_28_days_after_clicking
  #  hidden: true
  #  type: string
  #  sql: ${TABLE}.search_facebook_pixel_28_days_after_clicking

  #- dimension: search_facebook_pixel_7_days_after_clicking
  #  type: string
  #  hidden: true
  #  sql: ${TABLE}.search_facebook_pixel_7_days_after_clicking

  #- dimension: video_views
  #  type: string
  #  sql: ${TABLE}.video_views

  #- dimension: video_views_1_day_after_clicking
  #  type: string
  #  sql: ${TABLE}.video_views_1_day_after_clicking

  #- dimension: video_views_28_days_after_clicking
  #  type: string
  #  sql: ${TABLE}.video_views_28_days_after_clicking

  #- dimension: video_views_7_days_after_clicking
  #  type: string
  #  sql: ${TABLE}.video_views_7_days_after_clicking

  - dimension: view_content_facebook_pixel
    type: string
    sql: ${TABLE}.view_content_facebook_pixel

  - dimension: view_content_facebook_pixel_1_day_after_clicking
    type: string
    sql: ${TABLE}.view_content_facebook_pixel_1_day_after_clicking

  - dimension: view_content_facebook_pixel_28_days_after_clicking
    type: string
    sql: ${TABLE}.view_content_facebook_pixel_28_days_after_clicking

  - dimension: view_content_facebook_pixel_7_days_after_clicking
    type: string
    sql: ${TABLE}.view_content_facebook_pixel_7_days_after_clicking

  - dimension: website_actions_all
    type: string
    sql: ${TABLE}.website_actions_all

  - dimension: website_actions_all_1_day_after_clicking
    type: string
    sql: ${TABLE}.website_actions_all_1_day_after_clicking

  - dimension: website_actions_all_28_days_after_clicking
    type: string
    sql: ${TABLE}.website_actions_all_28_days_after_clicking

  - dimension: website_actions_all_7_days_after_clicking
    type: string
    sql: ${TABLE}.website_actions_all_7_days_after_clicking

  - dimension: website_ctr
    type: string
    sql: ${TABLE}.website_ctr
    
    
    
    
  ######################################################################################################
  ###################################### MEASURES ####################################################
######################################################################################################

  - measure: total_impressions
    type: sum
    sql: ${impressions}

  - measure: total_clicks
    type: sum
    sql: ${clicks_all}

  - measure: total_spend
    type: sum
    decimals: 2
    sql: ${amount_spent_gbp}
    value_format: '#,##0.00'

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

  - measure: cost_per_mille
    label: CPM
    type: number
    sql: ${total_spend}*1000/ NULLIF(${total_impressions},0) ::REAL
    value_format: '#,##0.00'
  
  - measure: unique_users
    label: Unique Users
    type: number
    sql: sum(${impressions} / NULLIF(${frequency},0) ::REAL)
    value_format: '#,##0.00'
    
  - measure: avg_frequency
    label: Avg Frequency
    type: number
    sql: ${total_impressions}/${unique_users}
    value_format: '#,##0.00'
    
  - measure: imp_times_relevance_score
    label: imp_times_rel
    type: number
    hidden: true
    sql: sum(${impressions} * (case when relevance_score ='' then '0' else relevance_score end))
    
  - measure: total_imp_with_relevance_score
    label: total_imp_with_relevance_score
    type: number
    hidden: true
    sql: sum(case when relevance_score ='' then '0' else ${impressions} end)

  - measure: avg_relevance_score
    label: Avg Relevance Score
    type: number
    sql: ${imp_times_relevance_score}/nullif(${total_imp_with_relevance_score},0)
    value_format: '#,##0.00'
    
    ######################################################################################################
  ###################################### 1 day window click ####################################################
######################################################################################################



# Sum Actions

  - measure: 1d_total_action_complete_registration
    type: sum
    sql: cast(coalesce(nullif(${complete_registration_facebook_pixel_1_day_after_clicking}, ''),'0') as integer)

  - measure: 1d_total_action_purchase
    type: sum
    sql: cast(coalesce(nullif(${purchase_facebook_pixel_1_day_after_clicking}, ''),'0') as integer)

  - measure: 1d_total_action_lead
    type: sum
    sql: cast(coalesce(nullif(${lead_facebook_pixel_1_day_after_clicking}, ''),'0') as integer)

  - measure: 1d_total_action_view_content
    type: sum
    sql: cast(coalesce(nullif(${view_content_facebook_pixel_1_day_after_clicking}, ''),'0') as integer)

  - measure: 1d_total_action_add_to_cart
    type: sum
    sql: cast(coalesce(nullif(${add_to_basket_facebook_pixel_1_day_after_clicking}, ''),'0') as integer)

  - measure: 1d_total_action_initate_checkout
    type: sum
    sql: cast(coalesce(nullif(${initiate_checkout_facebook_pixel_1_day_after_clicking}, ''),'0') as integer)

# CPA's

  - measure: 1d_cpa_complete_registration
    type: number
    sql: ${total_spend}/ NULLIF(${1d_total_action_complete_registration},0) ::REAL
    value_format: '#,##0.00'

  - measure: 1d_cpa_purchase
    type: number
    sql: ${total_spend}/ NULLIF(${1d_total_action_purchase},0) ::REAL
    value_format: '#,##0.00'

  - measure: 1d_cpa_lead
    type: number
    sql: ${total_spend}/ NULLIF(${1d_total_action_lead},0) ::REAL
    value_format: '#,##0.00'

  - measure: 1d_cpa_product_view_content
    type: number
    sql: ${total_spend}/ NULLIF(${1d_total_action_view_content},0) ::REAL
    value_format: '#,##0.00'
    
  - measure: 1d_cpa_add_to_cart
    type: number
    sql: ${total_spend}/ NULLIF(${1d_total_action_add_to_cart},0) ::REAL
    value_format: '#,##0.00'
    
  - measure: 1d_cpa_initiate_checkout
    type: number
    sql: ${total_spend}/ NULLIF(${1d_total_action_initate_checkout},0) ::REAL
    value_format: '#,##0.00'
    
    
    ######################################################################################################
  ###################################### 7 days window click ####################################################
######################################################################################################


  # Sum Actions

  - measure: 7d_total_action_complete_registration
    type: sum
    sql: cast(coalesce(nullif(${complete_registration_facebook_pixel_7_days_after_clicking}, ''),'0') as integer)

  - measure: 7d_total_action_purchase
    type: sum
    sql: cast(coalesce(nullif(${purchase_facebook_pixel_7_days_after_clicking}, ''),'0') as integer)

  - measure: 7d_total_action_lead
    type: sum
    sql: cast(coalesce(nullif(${lead_facebook_pixel_7_days_after_clicking}, ''),'0') as integer)

  - measure: 7d_total_action_view_content
    type: sum
    sql: cast(coalesce(nullif(${view_content_facebook_pixel_7_days_after_clicking}, ''),'0') as integer)

  - measure: 7d_total_action_add_to_cart
    type: sum
    sql: cast(coalesce(nullif(${add_to_basket_facebook_pixel_7_days_after_clicking}, ''),'0') as integer)

  - measure: 7d_total_action_initate_checkout
    type: sum
    sql: cast(coalesce(nullif(${initiate_checkout_facebook_pixel_7_days_after_clicking}, ''),'0') as integer)

# CPA's

  - measure: 7d_cpa_complete_registration
    type: number
    sql: ${total_spend}/ NULLIF(${7d_total_action_complete_registration},0) ::REAL
    value_format: '#,##0.00'

  - measure: 7d_cpa_purchase
    type: number
    sql: ${total_spend}/ NULLIF(${7d_total_action_purchase},0) ::REAL
    value_format: '#,##0.00'

  - measure: 7d_cpa_lead
    type: number
    sql: ${total_spend}/ NULLIF(${7d_total_action_lead},0) ::REAL
    value_format: '#,##0.00'

  - measure: 7d_cpa_product_view_content
    type: number
    sql: ${total_spend}/ NULLIF(${7d_total_action_view_content},0) ::REAL
    value_format: '#,##0.00'
    
  - measure: 7d_cpa_add_to_cart
    type: number
    sql: ${total_spend}/ NULLIF(${7d_total_action_add_to_cart},0) ::REAL
    value_format: '#,##0.00'
    
  - measure: 7d_cpa_initiate_checkout
    type: number
    sql: ${total_spend}/ NULLIF(${7d_total_action_initate_checkout},0) ::REAL
    value_format: '#,##0.00'
    
    
      ######################################################################################################
  ###################################### 28 days window click ####################################################
######################################################################################################
    
  - measure: 28d_total_action_complete_registration
    type: sum
    sql: cast(coalesce(nullif(${complete_registration_facebook_pixel_28_days_after_clicking}, ''),'0') as integer)

  - measure: 28d_total_action_purchase
    type: sum
    sql: cast(coalesce(nullif(${purchase_facebook_pixel_28_days_after_clicking}, ''),'0') as integer)

  - measure: 28d_total_action_lead
    type: sum
    sql: cast(coalesce(nullif(${lead_facebook_pixel_28_days_after_clicking}, ''),'0') as integer)

  - measure: 28d_total_action_view_content
    type: sum
    sql: cast(coalesce(nullif(${view_content_facebook_pixel_28_days_after_clicking}, ''),'0') as integer)

  - measure: 28d_total_action_add_to_cart
    type: sum
    sql: cast(coalesce(nullif(${add_to_basket_facebook_pixel_28_days_after_clicking}, ''),'0') as integer)

  - measure: 28d_total_action_initate_checkout
    type: sum
    sql: cast(coalesce(nullif(${initiate_checkout_facebook_pixel_28_days_after_clicking}, ''),'0') as integer)

# CPA's

  - measure: 28d_cpa_complete_registration
    type: number
    sql: ${total_spend}/ NULLIF(${28d_total_action_complete_registration},0) ::REAL
    value_format: '#,##0.00'

  - measure: 28d_cpa_purchase
    type: number
    sql: ${total_spend}/ NULLIF(${28d_total_action_purchase},0) ::REAL
    value_format: '#,##0.00'

  - measure: 28d_cpa_lead
    type: number
    sql: ${total_spend}/ NULLIF(${28d_total_action_lead},0) ::REAL
    value_format: '#,##0.00'

  - measure: 28d_cpa_product_view_content
    type: number
    sql: ${total_spend}/ NULLIF(${28d_total_action_view_content},0) ::REAL
    value_format: '#,##0.00'
    
  - measure: 28d_cpa_add_to_cart
    type: number
    sql: ${total_spend}/ NULLIF(${28d_total_action_add_to_cart},0) ::REAL
    value_format: '#,##0.00'
    
  - measure: 28d_cpa_initiate_checkout
    type: number
    sql: ${total_spend}/ NULLIF(${28d_total_action_initate_checkout},0) ::REAL
    value_format: '#,##0.00'
  
  
  


