- view: facebook_carousel_breakdown
  sql_table_name: facebook_data.facebook_carousel_breakdown
  fields:

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

  - dimension: add_payment_info_facebook_pixel_28_days_after_clicking
    type: string
    sql: ${TABLE}.add_payment_info_facebook_pixel_28_days_after_clicking

  - dimension: add_to_cart_facebook_pixel_1_day_after_clicking
    type: string
    sql: ${TABLE}.add_to_cart_facebook_pixel_1_day_after_clicking

  - dimension: add_to_cart_facebook_pixel_28_days_after_clicking
    type: string
    sql: ${TABLE}.add_to_cart_facebook_pixel_28_days_after_clicking

  - dimension: add_to_wishlist_facebook_pixel_1_day_after_clicking
    type: string
    sql: ${TABLE}.add_to_wishlist_facebook_pixel_1_day_after_clicking

  - dimension: add_to_wishlist_facebook_pixel_28_days_after_clicking
    type: string
    sql: ${TABLE}.add_to_wishlist_facebook_pixel_28_days_after_clicking

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

  - dimension: clicks_to_play_video_28_days_after_clicking
    type: string
    sql: ${TABLE}.clicks_to_play_video_28_days_after_clicking

  - dimension: complete_registration_facebook_pixel_1_day_after_clicking
    type: string
    sql: ${TABLE}.complete_registration_facebook_pixel_1_day_after_clicking

  - dimension: complete_registration_facebook_pixel_28_days_after_clicking
    type: string
    sql: ${TABLE}.complete_registration_facebook_pixel_28_days_after_clicking

  - dimension: ctr_link
    type: string
    sql: ${TABLE}.ctr_link

  - dimension: effective_status
    type: string
    sql: ${TABLE}.effective_status

  - dimension: event_responses_1_day_after_clicking
    type: string
    sql: ${TABLE}.event_responses_1_day_after_clicking

  - dimension: event_responses_28_days_after_clicking
    type: string
    sql: ${TABLE}.event_responses_28_days_after_clicking

  - dimension: initiate_checkout_facebook_pixel_1_day_after_clicking
    type: string
    sql: ${TABLE}.initiate_checkout_facebook_pixel_1_day_after_clicking

  - dimension: initiate_checkout_facebook_pixel_28_days_after_clicking
    type: string
    sql: ${TABLE}.initiate_checkout_facebook_pixel_28_days_after_clicking

  - dimension: lead_facebook_pixel_1_day_after_clicking
    type: string
    sql: ${TABLE}.lead_facebook_pixel_1_day_after_clicking

  - dimension: lead_facebook_pixel_28_days_after_clicking
    type: string
    sql: ${TABLE}.lead_facebook_pixel_28_days_after_clicking

  - dimension: link_click
    type: string
    sql: ${TABLE}.link_click

  - dimension: link_clicks_1_day_after_clicking
    type: string
    sql: ${TABLE}.link_clicks_1_day_after_clicking

  - dimension: link_clicks_28_days_after_clicking
    type: string
    sql: ${TABLE}.link_clicks_28_days_after_clicking

  - dimension: offer_claims_1_day_after_clicking
    type: string
    sql: ${TABLE}.offer_claims_1_day_after_clicking

  - dimension: offer_claims_28_days_after_clicking
    type: string
    sql: ${TABLE}.offer_claims_28_days_after_clicking

  - dimension: page_engagement_1_day_after_clicking
    type: string
    sql: ${TABLE}.page_engagement_1_day_after_clicking

  - dimension: page_engagement_28_days_after_clicking
    type: string
    sql: ${TABLE}.page_engagement_28_days_after_clicking

  - dimension: page_likes_1_day_after_clicking
    type: string
    sql: ${TABLE}.page_likes_1_day_after_clicking

  - dimension: page_likes_28_days_after_clicking
    type: string
    sql: ${TABLE}.page_likes_28_days_after_clicking

  - dimension: page_tab_views_1_day_after_clicking
    type: string
    sql: ${TABLE}.page_tab_views_1_day_after_clicking

  - dimension: page_tab_views_28_days_after_clicking
    type: string
    sql: ${TABLE}.page_tab_views_28_days_after_clicking

  - dimension: post_comments_1_day_after_clicking
    type: string
    sql: ${TABLE}.post_comments_1_day_after_clicking

  - dimension: post_comments_28_days_after_clicking
    type: string
    sql: ${TABLE}.post_comments_28_days_after_clicking

  - dimension: post_engagement_1_day_after_clicking
    type: string
    sql: ${TABLE}.post_engagement_1_day_after_clicking

  - dimension: post_engagement_28_days_after_clicking
    type: string
    sql: ${TABLE}.post_engagement_28_days_after_clicking

  - dimension: post_likes_1_day_after_clicking
    type: string
    sql: ${TABLE}.post_likes_1_day_after_clicking

  - dimension: post_likes_28_days_after_clicking
    type: string
    sql: ${TABLE}.post_likes_28_days_after_clicking

  - dimension: post_shares_1_day_after_clicking
    type: string
    sql: ${TABLE}.post_shares_1_day_after_clicking

  - dimension: post_shares_28_days_after_clicking
    type: string
    sql: ${TABLE}.post_shares_28_days_after_clicking

  - dimension: purchase_facebook_pixel_1_day_after_clicking
    type: string
    sql: ${TABLE}.purchase_facebook_pixel_1_day_after_clicking

  - dimension: purchase_facebook_pixel_28_days_after_clicking
    type: string
    sql: ${TABLE}.purchase_facebook_pixel_28_days_after_clicking

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

  - dimension: search_facebook_pixel_28_days_after_clicking
    type: string
    sql: ${TABLE}.search_facebook_pixel_28_days_after_clicking

  - dimension: video_views_1_day_after_clicking
    type: string
    sql: ${TABLE}.video_views_1_day_after_clicking

  - dimension: video_views_28_days_after_clicking
    type: string
    sql: ${TABLE}.video_views_28_days_after_clicking

  - dimension: view_content_facebook_pixel_1_day_after_clicking
    type: string
    sql: ${TABLE}.view_content_facebook_pixel_1_day_after_clicking

  - dimension: view_content_facebook_pixel_28_days_after_clicking
    type: string
    sql: ${TABLE}.view_content_facebook_pixel_28_days_after_clicking

  - dimension: website_actions_all_1_day_after_clicking
    type: string
    sql: ${TABLE}.website_actions_all_1_day_after_clicking

  - dimension: website_actions_all_28_days_after_clicking
    type: string
    sql: ${TABLE}.website_actions_all_28_days_after_clicking

  - dimension: website_ctr
    type: string
    sql: ${TABLE}.website_ctr

  
  
  
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
  
  

