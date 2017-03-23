- view: facebook_carousel_breakdown
  sql_table_name: facebook_data.facebook_carousel_breakdown
  fields:
  
  
  
  - dimension: carousel_card_position
    sql: |
          case when substring(${TABLE}.carousel_card, 0,2) = 1 then 1 
          when substring(${TABLE}.carousel_card, 0,2) = 2 then 2 
          when substring(${TABLE}.carousel_card, 0,2) = 3 then 3 
          when substring(${TABLE}.carousel_card, 0,2) = 4 then 4 
          when substring(${TABLE}.carousel_card, 0,2) = 5 then 5 
          else null end
          
          
  - dimension: carousel_card_name
    sql: |
          case when carousel_card = 'No Breakdown' then 'DPA Cards'
          when carousel_card = 'Finery London' then 'Finery London'
          when carousel_card like '%product.name%' then 'DPA Cards'
          else substring(carousel_card, 4, len(carousel_card)) end
          
  - dimension: ad_id
    type: string
    sql: ${TABLE}.ad_id

  - dimension: ad_name
    type: string
    sql: ${TABLE}.ad_name

  - dimension: ad_set_id
    type: string
    sql: ${TABLE}.ad_set_id

  - dimension: ad_set_name
    type: string
    sql: ${TABLE}.ad_set_name

  - dimension: add_payment_info_facebook_pixel_1_day_after_clicking
    type: string
    sql: ${TABLE}.add_payment_info_facebook_pixel_1_day_after_clicking
    hidden: true

  - dimension: add_payment_info_facebook_pixel_28_days_after_clicking
    type: string
    sql: ${TABLE}.add_payment_info_facebook_pixel_28_days_after_clicking
    hidden: true

  - dimension: add_to_cart_facebook_pixel_1_day_after_clicking
    type: string
    sql: ${TABLE}.add_to_cart_facebook_pixel_1_day_after_clicking
    hidden: true

  - dimension: add_to_cart_facebook_pixel_28_days_after_clicking
    type: string
    sql: ${TABLE}.add_to_cart_facebook_pixel_28_days_after_clicking
    hidden: true

  - dimension: add_to_wishlist_facebook_pixel_1_day_after_clicking
    type: string
    sql: ${TABLE}.add_to_wishlist_facebook_pixel_1_day_after_clicking
    hidden: true

  - dimension: add_to_wishlist_facebook_pixel_28_days_after_clicking
    type: string
    sql: ${TABLE}.add_to_wishlist_facebook_pixel_28_days_after_clicking
    hidden: true

  - dimension: campaign_id
    type: string
    sql: ${TABLE}.campaign_id

  - dimension: campaign_name
    type: string
    sql: ${TABLE}.campaign_name

  - dimension: carousel_card
    type: string
    sql: ${TABLE}.carousel_card

  - dimension: clicks_to_play_video_1_day_after_clicking
    type: string
    sql: ${TABLE}.clicks_to_play_video_1_day_after_clicking
    hidden: true

  - dimension: clicks_to_play_video_28_days_after_clicking
    type: string
    sql: ${TABLE}.clicks_to_play_video_28_days_after_clicking
    hidden: true

  - dimension: complete_registration_facebook_pixel_1_day_after_clicking
    type: string
    sql: ${TABLE}.complete_registration_facebook_pixel_1_day_after_clicking
    hidden: true

  - dimension: complete_registration_facebook_pixel_28_days_after_clicking
    type: string
    sql: ${TABLE}.complete_registration_facebook_pixel_28_days_after_clicking
    hidden: true

  - dimension: ctr_link
    type: string
    sql: ${TABLE}.ctr_link
    hidden: true

  - dimension: effective_status
    type: string
    sql: ${TABLE}.effective_status

  - dimension: event_responses_1_day_after_clicking
    type: string
    sql: ${TABLE}.event_responses_1_day_after_clicking
    hidden: true

  - dimension: event_responses_28_days_after_clicking
    type: string
    sql: ${TABLE}.event_responses_28_days_after_clicking
    hidden: true

  - dimension: initiate_checkout_facebook_pixel_1_day_after_clicking
    type: string
    sql: ${TABLE}.initiate_checkout_facebook_pixel_1_day_after_clicking
    hidden: true

  - dimension: initiate_checkout_facebook_pixel_28_days_after_clicking
    type: string
    sql: ${TABLE}.initiate_checkout_facebook_pixel_28_days_after_clicking
    hidden: true

  - dimension: lead_facebook_pixel_1_day_after_clicking
    type: string
    sql: ${TABLE}.lead_facebook_pixel_1_day_after_clicking
    hidden: true

  - dimension: lead_facebook_pixel_28_days_after_clicking
    type: string
    sql: ${TABLE}.lead_facebook_pixel_28_days_after_clicking
    hidden: true

  - dimension: link_click
    type: string
    sql: ${TABLE}.link_click
    hidden: true

  - dimension: link_clicks_1_day_after_clicking
    type: string
    sql: ${TABLE}.link_clicks_1_day_after_clicking
    hidden: true

  - dimension: link_clicks_28_days_after_clicking
    type: string
    sql: ${TABLE}.link_clicks_28_days_after_clicking
    hidden: true

  - dimension: offer_claims_1_day_after_clicking
    type: string
    sql: ${TABLE}.offer_claims_1_day_after_clicking
    hidden: true

  - dimension: offer_claims_28_days_after_clicking
    type: string
    sql: ${TABLE}.offer_claims_28_days_after_clicking
    hidden: true

  - dimension: page_engagement_1_day_after_clicking
    type: string
    sql: ${TABLE}.page_engagement_1_day_after_clicking
    hidden: true

  - dimension: page_engagement_28_days_after_clicking
    type: string
    sql: ${TABLE}.page_engagement_28_days_after_clicking
    hidden: true

  - dimension: page_likes_1_day_after_clicking
    type: string
    sql: ${TABLE}.page_likes_1_day_after_clicking
    hidden: true

  - dimension: page_likes_28_days_after_clicking
    type: string
    sql: ${TABLE}.page_likes_28_days_after_clicking
    hidden: true

  - dimension: page_tab_views_1_day_after_clicking
    type: string
    sql: ${TABLE}.page_tab_views_1_day_after_clicking
    hidden: true

  - dimension: page_tab_views_28_days_after_clicking
    type: string
    sql: ${TABLE}.page_tab_views_28_days_after_clicking
    hidden: true

  - dimension: post_comments_1_day_after_clicking
    type: string
    sql: ${TABLE}.post_comments_1_day_after_clicking
    hidden: true

  - dimension: post_comments_28_days_after_clicking
    type: string
    sql: ${TABLE}.post_comments_28_days_after_clicking
    hidden: true

  - dimension: post_engagement_1_day_after_clicking
    type: string
    sql: ${TABLE}.post_engagement_1_day_after_clicking
    hidden: true

  - dimension: post_engagement_28_days_after_clicking
    type: string
    sql: ${TABLE}.post_engagement_28_days_after_clicking
    hidden: true

  - dimension: post_likes_1_day_after_clicking
    type: string
    sql: ${TABLE}.post_likes_1_day_after_clicking
    hidden: true

  - dimension: post_likes_28_days_after_clicking
    type: string
    sql: ${TABLE}.post_likes_28_days_after_clicking
    hidden: true

  - dimension: post_shares_1_day_after_clicking
    type: string
    sql: ${TABLE}.post_shares_1_day_after_clicking
    hidden: true

  - dimension: post_shares_28_days_after_clicking
    type: string
    sql: ${TABLE}.post_shares_28_days_after_clicking
    hidden: true

  - dimension: purchase_facebook_pixel_1_day_after_clicking
    type: string
    sql: ${TABLE}.purchase_facebook_pixel_1_day_after_clicking
    hidden: true

  - dimension: purchase_facebook_pixel_28_days_after_clicking
    type: string
    sql: ${TABLE}.purchase_facebook_pixel_28_days_after_clicking
    hidden: true

  - dimension: reporting_ends
    type: string
    sql: ${TABLE}.reporting_ends
    hidden: true

  - dimension: reporting_starts
    type: string
    sql: ${TABLE}.reporting_starts
    hidden: true
    
  - dimension_group: calendar
    type: time
    timeframes: [date, day_of_week_index, day_of_week, week, week_of_year, day_of_month, month, month_num, year, quarter, quarter_of_year]
    convert_tz: false
    sql: cast(${TABLE}.reporting_starts as date)

  - dimension: search_facebook_pixel_1_day_after_clicking
    type: string
    sql: ${TABLE}.search_facebook_pixel_1_day_after_clicking
    hidden: true

  - dimension: search_facebook_pixel_28_days_after_clicking
    type: string
    sql: ${TABLE}.search_facebook_pixel_28_days_after_clicking
    hidden: true

  - dimension: video_views_1_day_after_clicking
    type: string
    sql: ${TABLE}.video_views_1_day_after_clicking
    hidden: true

  - dimension: video_views_28_days_after_clicking
    type: string
    sql: ${TABLE}.video_views_28_days_after_clicking
    hidden: true

  - dimension: view_content_facebook_pixel_1_day_after_clicking
    type: string
    sql: ${TABLE}.view_content_facebook_pixel_1_day_after_clicking
    hidden: true

  - dimension: view_content_facebook_pixel_28_days_after_clicking
    type: string
    sql: ${TABLE}.view_content_facebook_pixel_28_days_after_clicking
    hidden: true

  - dimension: website_actions_all_1_day_after_clicking
    type: string
    sql: ${TABLE}.website_actions_all_1_day_after_clicking
    hidden: true

  - dimension: website_actions_all_28_days_after_clicking
    type: string
    sql: ${TABLE}.website_actions_all_28_days_after_clicking
    hidden: true

  - dimension: website_ctr
    type: string
    sql: ${TABLE}.website_ctr
    hidden: true

      ######################################################################################################
  ###################################### MEASURES ####################################################
######################################################################################################
  
  - measure: total_link_clicks
    type: sum
    sql: cast(coalesce(nullif(${link_click}, ''),'0') as integer)    
    
  - measure: ctr_link_clicks
    type: number
    sql:  sum(cast(coalesce(nullif(facebook_carousel_breakdown.ctr_link, ''),'0') as numeric(10,5)) * cast(coalesce(nullif(facebook_carousel_breakdown.link_click, ''),'0') as integer)) / (case when sum(cast(coalesce(nullif(${link_click}, ''),'0') as integer)) = 0 then 1 else sum(cast(coalesce(nullif(${link_click}, ''),'0') as integer)) end)
    value_format: '#,##0.00'
      ######################################################################################################
  ###################################### 1 day window click ####################################################
######################################################################################################
  

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
    sql: cast(coalesce(nullif(${add_to_cart_facebook_pixel_1_day_after_clicking}, ''),'0') as integer)

  - measure: 1d_total_action_initate_checkout
    type: sum
    sql: cast(coalesce(nullif(${initiate_checkout_facebook_pixel_1_day_after_clicking}, ''),'0') as integer)
    
  
    

    

  
  

