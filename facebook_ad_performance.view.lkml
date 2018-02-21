view: facebook_api_ad_performance {
  sql_table_name: facebook_data.facebook_ad_performance ;;

  dimension: audience_segment {
    sql: case when ${TABLE}.campaign_name like '%Acquisition%' then 'NonBuyers - Acquisition'
      when ${TABLE}.campaign_name like '%Custom Audience%' and ${TABLE}.campaign_name like '%_NonBuyers%' then 'NonBuyers - Custom Audience'
      when ${TABLE}.campaign_name like '%_CA_%' and ${TABLE}.campaign_name like '%_NonBuyers%' then 'NonBuyers - Custom Audience'
      when ${TABLE}.campaign_name like '%_CA_%' and ${TABLE}.campaign_name like '%_Buyers%' then 'Buyers - CA'
      when ${TABLE}.campaign_name like '%_CA_%' and ${TABLE}.campaign_name like '%_LapsedBuyers%'  then 'Lapsed Buyers' end
       ;;
  }

  dimension: cpa_buyer_type {
    sql: case when ${TABLE}.campaign_name like '%Retention%' then 'Buyers'
      when ${TABLE}.campaign_name like '%_NonBuyers%' then 'NonBuyers'
      when ${TABLE}.campaign_name like '%_Buyers%' then 'Buyers'
      when ${TABLE}.campaign_name like '%Reactivation%' then 'Buyers'
      when ${TABLE}.campaign_name like '%_LapsedBuyers%' then 'Lapsed Buyers' else null end
       ;;
  }

  dimension: aa_vs_custom {
    sql: case when ${TABLE}.advert_name like '%#Fb Automated Ads Creatives Creative ID#%' then 'Custom'
      else 'AA' end
       ;;
  }

  dimension: dpa_vs_non_dpa {
    sql: case when ${TABLE}.campaign_name like '%_DPA' then 'DPA' else 'Non DPA' end ;;
  }

  dimension: country {
    sql: case when ${TABLE}.campaign_name like '%UK%' then 'UK'
      when ${TABLE}.campaign_name like '%USA%' then 'US'
      when ${TABLE}.campaign_name like '%Ireland%' then 'IE'
      when ${TABLE}.campaign_name like '%AUS%' then 'AUS'
      when ${TABLE}.campaign_name like 'UK_%' then 'UK'
      when ${TABLE}.campaign_name like 'US_%' then 'US'
      when ${TABLE}.campaign_name like 'IE_%' then 'IE'
      else 'Unknown' end
       ;;
  }

  dimension: placement {
    sql: case
      when ${TABLE}.campaign_name like '%Instagram%' or ${TABLE}.advert_set_name like '%Instagram%' then 'Instagram'
      when ${TABLE}.campaign_name like '%Mobile%' or ${TABLE}.advert_set_name like '%NFM%' then 'Mobile'
      when ${TABLE}.campaign_name like '%Desktop%' or ${TABLE}.advert_set_name like '%NFD%' or ${TABLE}.advert_set_name like '%RHS%' then 'Desktop' end
       ;;
  }

  dimension: advert_substring_name {
    sql: case when ${TABLE}.advert_name like '%#Fb Automated Ads Creatives Creative ID#%' and ${TABLE}.advert_name like '%Link%' then substring(advert_name,42,20)
      when ${TABLE}.advert_name like '%#Fb Automated Ads Creatives Creative ID#%' and ${TABLE}.advert_name like '%Multi%' then substring(advert_name,42,29)
      when ${TABLE}.advert_name like '%#Fb Automated Ads Creatives Creative ID#%' and ${TABLE}.advert_name like '%Video%' then substring(advert_name,42,24)
      when advert_name like 'Link%' then substring(advert_name,0,20)
      when advert_name like 'Multi%' then substring(advert_name,0,29)
      when advert_name like 'Video%' then substring(advert_name,0,22)
      when advert_name like '%Multi%' then substring(advert_name,0,4)
      when advert_name like 'Dynamic%' then 'DPA' end
       ;;
  }

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

  dimension: conversion_value_1_day_after_clicking {
    type: number
    sql: ${TABLE}.conversion_value_1_day_after_clicking ;;
    hidden: yes
  }

  dimension: conversion_value_7_days_after_clicking {
    type: number
    sql: ${TABLE}.conversion_value_7_days_after_clicking ;;
    hidden: yes
  }

  dimension: conversion_value_28_days_after_clicking {
    type: number
    sql: ${TABLE}.conversion_value_28_days_after_clicking ;;
    hidden: yes
  }

  dimension: add_to_basket_facebook_pixel {
    type: string
    sql: ${TABLE}.add_to_basket_facebook_pixel ;;
    hidden: yes
  }

  dimension: add_to_basket_facebook_pixel_1_day_after_clicking {
    type: string
    sql: ${TABLE}.add_to_basket_facebook_pixel_1_day_after_clicking ;;
    hidden: yes
  }

  dimension: add_to_basket_facebook_pixel_28_days_after_clicking {
    type: string
    sql: ${TABLE}.add_to_basket_facebook_pixel_28_days_after_clicking ;;
    hidden: yes
  }

  dimension: add_to_basket_facebook_pixel_7_days_after_clicking {
    type: string
    sql: ${TABLE}.add_to_basket_facebook_pixel_7_days_after_clicking ;;
    hidden: yes
  }

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

  dimension: advert_id {
    type: string
    sql: ${TABLE}.advert_id ;;
  }

  dimension: advert_name {
    type: string
    sql: ${TABLE}.advert_name ;;
  }

  dimension: advert_name_short {
    type: string
    sql: substring(${advert_name},42,len(${advert_name})-73) ;;
  }

  dimension: advert_type {
    type: string
    sql: case
      when ${advert_name} like 'Dynamic_Ad%' then 'DPA Carousel Ad'
      when ${advert_name} like 'Dynamic Product Ad%' then 'DPA Carousel Ad'
      when ${advert_name} like '0%' then 'Automated Carousel Ad'
      when ${advert_name} like '1%' then 'Automated Carousel Ad'
      when ${advert_name} like '2%' then 'Automated Carousel Ad'
      when ${advert_name} like '3%' then 'Automated Carousel Ad'
      when ${advert_name} like '4%' then 'Automated Carousel Ad'
      when ${advert_name} like '5%' then 'Automated Carousel Ad'
      when ${advert_name} like '6%' then 'Automated Carousel Ad'
      when ${advert_name} like '7%' then 'Automated Carousel Ad'
      when ${advert_name} like '8%' then 'Automated Carousel Ad'
      when ${advert_name} like '9%' then 'Automated Carousel Ad'
      when ${advert_name} like '%Multi_product Post_Customer Reactivation%' then 'Automated Carousel Ad'
      when ${advert_name} like '%Multi_product_Post%' then 'Manual Carousel Ad'
      when ${advert_name} like '%Link_Post%' then 'Manual Link Post Ad'
      when ${advert_name} like '%Video_Post%' then 'Manual Video Post Ad'
      when ${advert_name} like '%_Collection%' then 'Manual Collection Ad'
      else 'Other' end
       ;;
  }

  dimension: advert_group {
    type: string
    sql: case
      when ${advert_name} like 'Dynamic_Ad%' then 'DPA Carousel Ad'
      when ${advert_name} like 'Dynamic Product Ad%' then 'DPA Carousel Ad'
      when ${advert_name} like '0%' then 'Automated Carousel Ad'
      when ${advert_name} like '1%' then 'Automated Carousel Ad'
      when ${advert_name} like '2%' then 'Automated Carousel Ad'
      when ${advert_name} like '3%' then 'Automated Carousel Ad'
      when ${advert_name} like '4%' then 'Automated Carousel Ad'
      when ${advert_name} like '5%' then 'Automated Carousel Ad'
      when ${advert_name} like '6%' then 'Automated Carousel Ad'
      when ${advert_name} like '7%' then 'Automated Carousel Ad'
      when ${advert_name} like '8%' then 'Automated Carousel Ad'
      when ${advert_name} like '9%' then 'Automated Carousel Ad'
      when ${advert_name} like '%Multi_product Post_Customer Reactivation%' then 'Automated Carousel Ad'
      when ${advert_name} like '%ALICE%' then 'Alice Levine'
      when ${advert_name} like '%WAVEN%' then 'Waven'
      when ${advert_name} like '%SLOGAN%' then 'Slogan'
      when ${advert_name} like '%Link_Post%' then 'Manual Link Post Ad'
      when ${advert_name} like '%_Collection%' then 'Manual Collection Ad'
      else 'Other' end
       ;;
  }

  dimension: advert_relevance_score {
    type: string
    sql: ${TABLE}.advert_relevance_score ;;
    hidden: yes
  }

  dimension: advert_set_id {
    type: string
    sql: ${TABLE}.advert_set_id ;;
  }

  dimension: advert_set_name {
    type: string
    sql: ${TABLE}.advert_set_name ;;
  }

  dimension: amount_spent_gbp {
    type: number
    hidden: yes
    sql: ${TABLE}.amount_spent_gbp ;;
  }

  dimension: smartly_commission {
    type: number
    value_format_name: decimal_4
    # Smartly commission approximately 1.55%
    sql: 0.0155 ;;
  }

  dimension: amount_spent_including_smartly_commission {
    type: number
    value_format_name: decimal_4
    sql: ${amount_spent_gbp} * (1 + ${smartly_commission}) ;;
    hidden: yes
  }

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

  dimension: button_clicks {
    type: string
    sql: ${TABLE}.button_clicks ;;
    hidden: yes
  }

  dimension: campaign_id {
    type: string
    sql: ${TABLE}.campaign_id ;;
  }

  dimension: campaign_name {
    type: string
    sql: ${TABLE}.campaign_name ;;
  }

  dimension: clicks_all {
    type: number
    hidden: yes
    sql: CAST(${TABLE}.clicks_all AS INTEGER) ;;
  }

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

  dimension: complete_registration_facebook_pixel {
    type: string
    hidden: yes
    sql: ${TABLE}.complete_registration_facebook_pixel ;;
  }

  dimension: complete_registration_facebook_pixel_1_day_after_clicking {
    type: string
    hidden: yes
    sql: ${TABLE}.complete_registration_facebook_pixel_1_day_after_clicking ;;
  }

  dimension: complete_registration_facebook_pixel_28_days_after_clicking {
    type: string
    hidden: yes
    sql: ${TABLE}.complete_registration_facebook_pixel_28_days_after_clicking ;;
  }

  dimension: complete_registration_facebook_pixel_7_days_after_clicking {
    type: string
    hidden: yes
    sql: ${TABLE}.complete_registration_facebook_pixel_7_days_after_clicking ;;
  }

  dimension: ctr_all {
    type: string
    sql: ${TABLE}.ctr_all ;;
    hidden: yes
  }

  dimension: ctr_link {
    type: string
    sql: ${TABLE}.ctr_link ;;
    hidden: yes
  }

  dimension: effective_status {
    type: string
    sql: ${TABLE}.effective_status ;;
  }

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

  dimension: frequency {
    type: number
    sql: cast(${TABLE}.frequency as decimal(20,10)) ;;
    value_format: "#,##0.00"
    hidden: yes
  }

  dimension: impressions {
    type: number
    hidden: yes
    sql: cast(${TABLE}.impressions as integer) ;;
  }

  dimension: advert_is_live {
    type: yesno
    sql: ${impressions} > 0 ;;
  }

  dimension: initiate_checkout_facebook_pixel {
    type: string
    sql: ${TABLE}.initiate_checkout_facebook_pixel ;;
    hidden: yes
  }

  dimension: initiate_checkout_facebook_pixel_1_day_after_clicking {
    type: string
    sql: ${TABLE}.initiate_checkout_facebook_pixel_1_day_after_clicking ;;
    hidden: yes
  }

  dimension: initiate_checkout_facebook_pixel_28_days_after_clicking {
    type: string
    sql: ${TABLE}.initiate_checkout_facebook_pixel_28_days_after_clicking ;;
    hidden: yes
  }

  dimension: initiate_checkout_facebook_pixel_7_days_after_clicking {
    type: string
    sql: ${TABLE}.initiate_checkout_facebook_pixel_7_days_after_clicking ;;
    hidden: yes
  }

  dimension: lead_facebook_pixel {
    type: string
    sql: ${TABLE}.lead_facebook_pixel ;;
    hidden: yes
  }

  dimension: lead_facebook_pixel_1_day_after_clicking {
    type: string
    sql: ${TABLE}.lead_facebook_pixel_1_day_after_clicking ;;
    hidden: yes
  }

  dimension: lead_facebook_pixel_28_days_after_clicking {
    type: string
    sql: ${TABLE}.lead_facebook_pixel_28_days_after_clicking ;;
    hidden: yes
  }

  dimension: lead_facebook_pixel_7_days_after_clicking {
    type: string
    sql: ${TABLE}.lead_facebook_pixel_7_days_after_clicking ;;
    hidden: yes
  }

  dimension: link_clicks {
    type: string
    sql: ${TABLE}.link_clicks ;;
    hidden: yes
  }

  dimension: link_clicks_1_day_after_clicking {
    type: string
    sql: ${TABLE}.link_clicks_1_day_after_clicking ;;
    hidden: yes
  }

  dimension: link_clicks_28_days_after_clicking {
    type: string
    sql: ${TABLE}.link_clicks_28_days_after_clicking ;;
    hidden: yes
  }

  dimension: link_clicks_7_days_after_clicking {
    type: string
    sql: ${TABLE}.link_clicks_7_days_after_clicking ;;
    hidden: yes
  }

  dimension: negative_feedback {
    type: string
    sql: ${TABLE}.negative_feedback ;;
  }

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

  dimension: page_engagement {
    type: string
    sql: ${TABLE}.page_engagement ;;
    hidden: yes
  }

  dimension: page_engagement_1_day_after_clicking {
    type: string
    sql: ${TABLE}.page_engagement_1_day_after_clicking ;;
    hidden: yes
  }

  dimension: page_engagement_28_days_after_clicking {
    type: string
    sql: ${TABLE}.page_engagement_28_days_after_clicking ;;
    hidden: yes
  }

  dimension: page_engagement_7_days_after_clicking {
    type: string
    sql: ${TABLE}.page_engagement_7_days_after_clicking ;;
    hidden: yes
  }

  dimension: page_likes {
    type: string
    sql: ${TABLE}.page_likes ;;
    hidden: yes
  }

  dimension: page_likes_1_day_after_clicking {
    type: string
    sql: ${TABLE}.page_likes_1_day_after_clicking ;;
    hidden: yes
  }

  dimension: page_likes_28_days_after_clicking {
    type: string
    sql: ${TABLE}.page_likes_28_days_after_clicking ;;
    hidden: yes
  }

  dimension: page_likes_7_days_after_clicking {
    type: string
    sql: ${TABLE}.page_likes_7_days_after_clicking ;;
    hidden: yes
  }

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

  dimension: positive_feedback {
    type: string
    sql: ${TABLE}.positive_feedback ;;
  }

  dimension: post_comments {
    type: string
    sql: ${TABLE}.post_comments ;;
    hidden: yes
  }

  dimension: post_comments_1_day_after_clicking {
    type: string
    sql: ${TABLE}.post_comments_1_day_after_clicking ;;
    hidden: yes
  }

  dimension: post_comments_28_days_after_clicking {
    type: string
    sql: ${TABLE}.post_comments_28_days_after_clicking ;;
    hidden: yes
  }

  dimension: post_comments_7_days_after_clicking {
    type: string
    sql: ${TABLE}.post_comments_7_days_after_clicking ;;
    hidden: yes
  }

  dimension: post_engagement {
    type: string
    sql: ${TABLE}.post_engagement ;;
    hidden: yes
  }

  dimension: post_engagement_1_day_after_clicking {
    type: string
    sql: ${TABLE}.post_engagement_1_day_after_clicking ;;
    hidden: yes
  }

  dimension: post_engagement_28_days_after_clicking {
    type: string
    sql: ${TABLE}.post_engagement_28_days_after_clicking ;;
    hidden: yes
  }

  dimension: post_engagement_7_days_after_clicking {
    type: string
    sql: ${TABLE}.post_engagement_7_days_after_clicking ;;
    hidden: yes
  }

  dimension: post_likes {
    type: string
    sql: ${TABLE}.post_likes ;;
    hidden: yes
  }

  dimension: post_likes_1_day_after_clicking {
    type: string
    sql: ${TABLE}.post_likes_1_day_after_clicking ;;
    hidden: yes
  }

  dimension: post_likes_28_days_after_clicking {
    type: string
    sql: ${TABLE}.post_likes_28_days_after_clicking ;;
    hidden: yes
  }

  dimension: post_likes_7_days_after_clicking {
    type: string
    sql: ${TABLE}.post_likes_7_days_after_clicking ;;
    hidden: yes
  }

  dimension: post_shares {
    type: string
    sql: ${TABLE}.post_shares ;;
    hidden: yes
  }

  dimension: post_shares_1_day_after_clicking {
    type: string
    sql: ${TABLE}.post_shares_1_day_after_clicking ;;
    hidden: yes
  }

  dimension: post_shares_28_days_after_clicking {
    type: string
    sql: ${TABLE}.post_shares_28_days_after_clicking ;;
    hidden: yes
  }

  dimension: post_shares_7_days_after_clicking {
    type: string
    sql: ${TABLE}.post_shares_7_days_after_clicking ;;
    hidden: yes
  }

  dimension: purchase_facebook_pixel {
    type: string
    sql: ${TABLE}.purchase_facebook_pixel ;;
    hidden: yes
  }

  dimension: purchase_facebook_pixel_1_day_after_clicking {
    type: string
    sql: ${TABLE}.purchase_facebook_pixel_1_day_after_clicking ;;
    hidden: yes
  }

  dimension: purchase_facebook_pixel_28_days_after_clicking {
    type: string
    sql: ${TABLE}.purchase_facebook_pixel_28_days_after_clicking ;;
    hidden: yes
  }

  dimension: purchase_facebook_pixel_7_days_after_clicking {
    type: string
    sql: ${TABLE}.purchase_facebook_pixel_7_days_after_clicking ;;
    hidden: yes
  }

  dimension: reach {
    type: string
    sql: ${TABLE}.reach ;;
    hidden: yes
  }

  dimension: relevance_score {
    type: string
    sql: ${TABLE}.relevance_score ;;
    hidden: yes
  }

  dimension: relevance_score_status {
    type: string
    sql: ${TABLE}.relevance_score_status ;;
  }

  dimension: relevanceorganic_rank {
    type: string
    sql: ${TABLE}.relevanceorganic_rank ;;
  }

  dimension_group: calendar {
    type: time
    timeframes: [
      date,
      day_of_week_index,
      day_of_week,
      week,
      week_of_year,
      day_of_month,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year
    ]
    convert_tz: no
    sql: cast(${TABLE}.reporting_starts as date) ;;
  }

  dimension: reporting_starts {
    type: string
    hidden: yes
    sql: cast(${TABLE}.reporting_starts as date) ;;
  }

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

  dimension: view_content_facebook_pixel {
    type: string
    sql: ${TABLE}.view_content_facebook_pixel ;;
  }

  dimension: view_content_facebook_pixel_1_day_after_clicking {
    type: string
    sql: ${TABLE}.view_content_facebook_pixel_1_day_after_clicking ;;
  }

  dimension: view_content_facebook_pixel_28_days_after_clicking {
    type: string
    sql: ${TABLE}.view_content_facebook_pixel_28_days_after_clicking ;;
  }

  dimension: view_content_facebook_pixel_7_days_after_clicking {
    type: string
    sql: ${TABLE}.view_content_facebook_pixel_7_days_after_clicking ;;
  }

  dimension: website_actions_all {
    type: string
    sql: ${TABLE}.website_actions_all ;;
    hidden: yes
  }

  dimension: website_actions_all_1_day_after_clicking {
    type: string
    sql: ${TABLE}.website_actions_all_1_day_after_clicking ;;
    hidden: yes
  }

  dimension: website_actions_all_28_days_after_clicking {
    type: string
    sql: ${TABLE}.website_actions_all_28_days_after_clicking ;;
    hidden: yes
  }

  dimension: website_actions_all_7_days_after_clicking {
    type: string
    sql: ${TABLE}.website_actions_all_7_days_after_clicking ;;
    hidden: yes
  }

  dimension: website_ctr {
    type: string
    sql: ${TABLE}.website_ctr ;;
    hidden: yes
  }

  ######################################################################################################
  ###################################### MEASURES ####################################################
  ######################################################################################################

  measure: total_ads_live {
    type: count_distinct
    sql: ${campaign_id} || ${advert_id} || ${advert_set_id} ;;

    filters: {
      field: advert_is_live
      value: "yes"
    }
  }

  measure: total_automated_ads_live {
    type: count_distinct
    sql: ${campaign_id} || ${advert_id} || ${advert_set_id} ;;

    filters: {
      field: advert_is_live
      value: "yes"
    }

    filters: {
      field: advert_type
      value: "Automated Carousel Ad"
    }
  }

  measure: total_dpa_ads_live {
    type: count_distinct
    sql: ${campaign_id} || ${advert_id} || ${advert_set_id} ;;

    filters: {
      field: advert_is_live
      value: "yes"
    }

    filters: {
      field: advert_type
      value: "DPA Carousel Ad"
    }
  }

  measure: total_manual_ads_live {
    type: count_distinct
    sql: ${campaign_id} || ${advert_id} || ${advert_set_id} ;;

    filters: {
      field: advert_is_live
      value: "yes"
    }

    filters: {
      field: advert_type
      value: "Manual Carousel Ad, Manual Link Post Ad, Manual Video Post Ad"
    }
  }

  measure: total_impressions {
    type: sum
    sql: ${impressions} ;;
  }

  measure: total_clicks {
    type: sum
    sql: ${clicks_all} ;;
  }

  measure: revenue_7_days_after_clicking {
    type: sum
    value_format_name: decimal_2
    sql: ${conversion_value_7_days_after_clicking} ;;
  }

  measure: revenue_28_days_after_clicking {
    type: sum
    value_format_name: decimal_2
    sql: ${conversion_value_28_days_after_clicking} ;;
  }

  measure: 1d_average_basket {
    type: number
    sql: ${revenue_1_day_after_clicking}/ NULLIF(${1d_total_action_purchase},0) ::REAL ;;
  }

  measure: 7d_average_basket {
    type: number
    sql: ${revenue_7_days_after_clicking}/ NULLIF(${7d_total_action_purchase},0) ::REAL ;;
  }

  measure: 28d_average_basket {
    type: number
    sql: ${revenue_28_days_after_clicking}/ NULLIF(${28d_total_action_purchase},0) ::REAL ;;
  }

  measure: total_spend {
    type: sum
    value_format_name: decimal_2
    sql: ${amount_spent_gbp} ;;
  }

  measure: click_through_rate {
    label: "CTR"
    type: number
    value_format_name: percent_2
    sql: ${total_clicks}/ NULLIF(${total_impressions},0) ::REAL ;;
  }


######################################################################################### COST PER MEASURES ######################################################################

  measure: cost_per_click {
    label: "CPC"
    type: number
    value_format_name: decimal_2
    sql: ${total_spend}/ NULLIF(${total_clicks},0) ::REAL ;;
  }

  measure: cost_per_mille {
    label: "CPM"
    type: number
    value_format_name: decimal_2
    sql: ${total_spend}*1000/ NULLIF(${total_impressions},0) ::REAL ;;
  }

  measure: cost_per_click_yesterday {
    label: "Actual"
    type: number
    value_format_name: gbp
    sql: ${total_spend_including_smartly_commission_yesterday}/ NULLIF(${total_clicks_yesterday},0) ::REAL ;;
    group_label: "CPC Reporting Measures"
  }

  measure: cost_per_click_lw {
    label: "LW"
    type: number
    value_format_name: gbp
    sql: ${total_spend_including_smartly_commission_lw}/ NULLIF(${total_clicks_lw},0) ::REAL ;;
    group_label: "CPC Reporting Measures"
  }

  measure: cost_per_click_yesterday_wow {
    label: "%"
    type: number
    value_format_name: percent_0
    group_label: "CPC Reporting Measures"
    sql: (${cost_per_click_yesterday} - ${cost_per_click_lw})/NULLIF(${cost_per_click_lw},0)::REAL ;;
    html: {% if value > 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value < 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: cost_per_click_l3d {
    label: "L3D"
    type: number
    value_format_name: gbp
    sql: ${total_spend_including_smartly_commission_l3d}/ NULLIF(${total_clicks_l3d},0) ::REAL ;;
    group_label: "CPC Reporting Measures"
  }

  measure: cost_per_click_l3d_avg {
    label: "L3D Avg"
    type: number
    value_format_name: gbp
    sql: ${total_spend_including_smartly_commission_l3d_average}/ NULLIF(${total_clicks_l3d_avg},0) ::REAL ;;
    group_label: "CPC Reporting Measures"
  }

  measure: cost_per_click_vs_l3d_avg {
    label: "vs L3D Avg"
    type: number
    value_format_name: percent_0
    group_label: "CPC Reporting Measures"
    sql: (${cost_per_click_yesterday} - ${cost_per_click_l3d_avg})/NULLIF(${cost_per_click_l3d_avg},0)::REAL ;;
    html: {% if value > 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value < 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: cost_per_click_l7d {
    label: "L7D"
    type: number
    value_format_name: gbp
    sql: ${total_spend_including_smartly_commission_l7d}/ NULLIF(${total_clicks_l7d},0) ::REAL ;;
    group_label: "CPC Reporting Measures"
  }

  measure: cost_per_click_l7d_avg {
    label: "L7D Avg"
    type: number
    value_format_name: gbp
    sql: ${total_spend_including_smartly_commission_l7d_average}/ NULLIF(${total_clicks_l7d_avg},0) ::REAL ;;
    group_label: "CPC Reporting Measures"
  }

  measure: cost_per_click_vs_l7d_avg {
    label: "vs L7D Avg"
    type: number
    value_format_name: percent_0
    group_label: "CPC Reporting Measures"
    sql: (${cost_per_click_yesterday} - ${cost_per_click_l7d_avg})/NULLIF(${cost_per_click_l7d_avg},0)::REAL ;;
    html: {% if value > 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value < 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: total_clicks_yesterday {
    label: "Actual"
    type: number
    sql: sum(case when ${calendar_date} = current_date - 1 then ${clicks_all} else 0 end) ;;
    group_label: "Click Reporting Measures"
  }

  measure: total_clicks_lw {
    label: "LW"
    type: number
    sql: sum(case when ${calendar_date} = current_date - 8 then ${clicks_all} else 0 end) ;;
    group_label: "Click Reporting Measures"
  }

  measure: total_clicks_l3d {
    label: "L3D"
    type: number
    sql: sum(case when ${calendar_date} between current_date - 3 and current_date - 1 then ${clicks_all} else 0 end) ;;
    group_label: "Click Reporting Measures"
  }

  measure: total_clicks_l3d_avg {
    label: "L3D Avg"
    type: number
    sql: ${total_clicks_l3d}/3 ;;
    group_label: "Click Reporting Measures"
  }

  measure: total_clicks_l7d {
    label: "L7D"
    type: number
    sql: sum(case when ${calendar_date} between current_date - 7 and current_date - 1 then ${clicks_all} else 0 end) ;;
    group_label: "Click Reporting Measures"
  }

  measure: total_clicks_l7d_avg {
    label: "L7D Avg"
    type: number
    sql: ${total_clicks_l7d}/7 ;;
    group_label: "Click Reporting Measures"
  }

  measure: total_impressions_yesterday {
    label: "Actual"
    type: number
    sql: sum(case when ${calendar_date} = current_date - 1 then ${impressions} else 0 end) ;;
    group_label: "Impressions Reporting Measures"
  }

  measure: total_impressions_lw {
    label: "LW"
    type: number
    sql: sum(case when ${calendar_date} = current_date - 8 then ${impressions} else 0 end) ;;
    group_label: "Impressions Reporting Measures"
  }

  measure: total_impressions_l3d {
    label: "L3D"
    type: number
    sql: sum(case when ${calendar_date} between current_date - 3 and current_date - 1 then ${impressions} else 0 end) ;;
    group_label: "Impressions Reporting Measures"
  }

  measure: total_impressions_l3d_avg {
    label: "L3D Avg"
    type: number
    sql: ${total_impressions_l3d}/3 ;;
    group_label: "Impressions Reporting Measures"
  }

  measure: total_impressions_l7d {
    label: "L7D"
    type: number
    sql: sum(case when ${calendar_date} between current_date - 7 and current_date - 1 then ${impressions} else 0 end) ;;
    group_label: "Impressions Reporting Measures"
  }

  measure: total_impressions_l7d_avg {
    label: "L7D Avg"
    type: number
    sql: ${total_impressions_l7d}/7 ;;
    group_label: "Impressions Reporting Measures"
  }


  measure: total_spend_yesterday_1000 {
    hidden: yes
    type: number
    sql: ${total_spend_including_smartly_commission_yesterday}*1000 ;;
  }

  measure: total_spend_lw_1000 {
    hidden: yes
    type: number
    sql: ${total_spend_including_smartly_commission_lw}*1000 ;;
  }

  measure: total_spend_l3d_1000 {
    hidden: yes
    type: number
    sql: ${total_spend_including_smartly_commission_l3d}*1000 ;;
  }

  measure: total_spend_l3d_avg_1000 {
    hidden: yes
    type: number
    sql: ${total_spend_including_smartly_commission_l3d_average}*1000 ;;
  }

  measure: total_spend_l7d_1000 {
    hidden: yes
    type: number
    sql: ${total_spend_including_smartly_commission_l7d}*1000 ;;
  }

  measure: total_spend_l7d_avg_1000 {
    hidden: yes
    type: number
    sql: ${total_spend_including_smartly_commission_l7d_average}*1000 ;;
  }

  measure: cost_per_mille_yesterday {
    label: "Actual"
    type: number
    value_format_name: decimal_2
    sql: ${total_spend_yesterday_1000}/NULLIF(${total_impressions_yesterday},0)::REAL ;;
    group_label: "CPM Reporting Measures"
  }

  measure: cost_per_mille_lw {
    label: "LW"
    type: number
    value_format_name: decimal_2
    sql: ${total_spend_lw_1000}/ NULLIF(${total_impressions_lw},0) ::REAL ;;
    group_label: "CPM Reporting Measures"
  }

  measure: cost_per_mille_l3d {
    label: "L3D"
    type: number
    value_format_name: decimal_2
    sql: ${total_spend_l3d_1000}/ NULLIF(${total_impressions_l3d},0) ::REAL ;;
    group_label: "CPM Reporting Measures"
  }

  measure: cost_per_mille_l3d_avg {
    label: "L3D Avg"
    type: number
    value_format_name: decimal_2
    sql: ${total_spend_l3d_avg_1000}/ NULLIF(${total_impressions_l3d_avg},0) ::REAL ;;
    group_label: "CPM Reporting Measures"
  }

  measure: cost_per_mille_l7d {
    label: "L7D"
    type: number
    value_format_name: decimal_2
    sql: ${total_spend_l7d_1000}/ NULLIF(${total_impressions_l7d},0) ::REAL ;;
    group_label: "CPM Reporting Measures"
  }

  measure: cost_per_mille_l7d_avg {
    label: "L7D Avg"
    type: number
    value_format_name: decimal_2
    sql: ${total_spend_l7d_avg_1000}/ NULLIF(${total_impressions_l7d_avg},0) ::REAL ;;
    group_label: "CPM Reporting Measures"
  }

  measure: unique_users {
    label: "Unique Users"
    type: number
    sql: sum(${impressions} / NULLIF(${frequency},0) ::REAL) ;;
  }

  measure: avg_frequency {
    label: "Avg Frequency"
    type: number
    value_format_name: decimal_2
    sql: ${total_impressions}/${unique_users} ;;
  }

  measure: imp_times_relevance_score {
    label: "imp_times_rel"
    type: number
    hidden: yes
    sql: sum(${impressions} * (case when relevance_score ='' then '0' else relevance_score end)) ;;
  }

  measure: total_imp_with_relevance_score {
    label: "total_imp_with_relevance_score"
    type: number
    hidden: yes
    sql: sum(case when relevance_score ='' then '0' else ${impressions} end) ;;
  }

  measure: avg_relevance_score {
    label: "Avg Relevance Score"
    type: number
    sql: ${imp_times_relevance_score}/nullif(${total_imp_with_relevance_score},0) ;;
    value_format_name: decimal_2
  }

  ######################################################################################################
  ###################################### 1 day window click ####################################################
  ######################################################################################################



  # Sum Actions

  measure: 1d_total_action_complete_registration {
    type: sum
    sql: cast(coalesce(nullif(${complete_registration_facebook_pixel_1_day_after_clicking}, ''),'0') as integer) ;;
  }

  measure: 1d_total_action_purchase {
    type: sum
    sql: cast(coalesce(nullif(${purchase_facebook_pixel_1_day_after_clicking}, ''),'0') as integer) ;;
  }

  measure: 1d_total_action_lead {
    type: sum
    sql: cast(coalesce(nullif(${lead_facebook_pixel_1_day_after_clicking}, ''),'0') as integer) ;;
  }

  measure: 1d_total_action_view_content {
    type: sum
    sql: cast(coalesce(nullif(${view_content_facebook_pixel_1_day_after_clicking}, ''),'0') as integer) ;;
  }

  measure: 1d_total_action_add_to_cart {
    type: sum
    sql: cast(coalesce(nullif(${add_to_basket_facebook_pixel_1_day_after_clicking}, ''),'0') as integer) ;;
  }

  measure: 1d_total_action_initate_checkout {
    type: sum
    sql: cast(coalesce(nullif(${initiate_checkout_facebook_pixel_1_day_after_clicking}, ''),'0') as integer) ;;
  }

  # CPA's

  measure: 1d_cpa_complete_registration {
    type: number
    sql: ${total_spend}/ NULLIF(${1d_total_action_complete_registration},0) ::REAL ;;
    value_format: "#,##0.00"
  }

  measure: 1d_cpa_purchase {
    type: number
    sql: ${total_spend}/ NULLIF(${1d_total_action_purchase},0) ::REAL ;;
    value_format: "#,##0.00"
  }

  measure: 1d_cpa_lead {
    type: number
    sql: ${total_spend}/ NULLIF(${1d_total_action_lead},0) ::REAL ;;
    value_format: "#,##0.00"
  }

  measure: 1d_cpa_product_view_content {
    type: number
    sql: ${total_spend}/ NULLIF(${1d_total_action_view_content},0) ::REAL ;;
    value_format: "#,##0.00"
  }

  measure: 1d_cpa_add_to_cart {
    type: number
    sql: ${total_spend}/ NULLIF(${1d_total_action_add_to_cart},0) ::REAL ;;
    value_format: "#,##0.00"
  }

  measure: 1d_cpa_initiate_checkout {
    type: number
    sql: ${total_spend}/ NULLIF(${1d_total_action_initate_checkout},0) ::REAL ;;
    value_format: "#,##0.00"
  }

  ######################################################################################################
  ###################################### 7 days window click ####################################################
  ######################################################################################################


  # Sum Actions

  measure: 7d_total_action_complete_registration {
    type: sum
    sql: cast(coalesce(nullif(${complete_registration_facebook_pixel_7_days_after_clicking}, ''),'0') as integer) ;;
  }

  measure: 7d_total_action_purchase {
    type: sum
    sql: cast(coalesce(nullif(${purchase_facebook_pixel_7_days_after_clicking}, ''),'0') as integer) ;;
  }

  measure: 7d_total_action_lead {
    type: sum
    sql: cast(coalesce(nullif(${lead_facebook_pixel_7_days_after_clicking}, ''),'0') as integer) ;;
  }

  measure: 7d_total_action_view_content {
    type: sum
    sql: cast(coalesce(nullif(${view_content_facebook_pixel_7_days_after_clicking}, ''),'0') as integer) ;;
  }

  measure: 7d_total_action_add_to_cart {
    type: sum
    sql: cast(coalesce(nullif(${add_to_basket_facebook_pixel_7_days_after_clicking}, ''),'0') as integer) ;;
  }

  measure: 7d_total_action_initate_checkout {
    type: sum
    sql: cast(coalesce(nullif(${initiate_checkout_facebook_pixel_7_days_after_clicking}, ''),'0') as integer) ;;
  }

  # CPA's

  measure: 7d_cpa_complete_registration {
    type: number
    sql: ${total_spend}/ NULLIF(${7d_total_action_complete_registration},0) ::REAL ;;
    value_format: "#,##0.00"
  }

  measure: 7d_cpa_purchase {
    type: number
    sql: ${total_spend}/ NULLIF(${7d_total_action_purchase},0) ::REAL ;;
    value_format: "#,##0.00"
  }

  measure: 7d_cpa_lead {
    type: number
    sql: ${total_spend}/ NULLIF(${7d_total_action_lead},0) ::REAL ;;
    value_format: "#,##0.00"
  }

  measure: 7d_cpa_product_view_content {
    type: number
    sql: ${total_spend}/ NULLIF(${7d_total_action_view_content},0) ::REAL ;;
    value_format: "#,##0.00"
  }

  measure: 7d_cpa_add_to_cart {
    type: number
    sql: ${total_spend}/ NULLIF(${7d_total_action_add_to_cart},0) ::REAL ;;
    value_format: "#,##0.00"
  }

  measure: 7d_cpa_initiate_checkout {
    type: number
    sql: ${total_spend}/ NULLIF(${7d_total_action_initate_checkout},0) ::REAL ;;
    value_format: "#,##0.00"
  }

  ######################################################################################################
  ###################################### 28 days window click ####################################################
  ######################################################################################################

  measure: 28d_total_action_complete_registration {
    type: sum
    sql: cast(coalesce(nullif(${complete_registration_facebook_pixel_28_days_after_clicking}, ''),'0') as integer) ;;
  }

  measure: 28d_total_action_purchase {
    type: sum
    sql: cast(coalesce(nullif(${purchase_facebook_pixel_28_days_after_clicking}, ''),'0') as integer) ;;
  }

  measure: 28d_total_action_lead {
    type: sum
    sql: cast(coalesce(nullif(${lead_facebook_pixel_28_days_after_clicking}, ''),'0') as integer) ;;
  }

  measure: 28d_total_action_view_content {
    type: sum
    sql: cast(coalesce(nullif(${view_content_facebook_pixel_28_days_after_clicking}, ''),'0') as integer) ;;
  }

  measure: 28d_total_action_add_to_cart {
    type: sum
    sql: cast(coalesce(nullif(${add_to_basket_facebook_pixel_28_days_after_clicking}, ''),'0') as integer) ;;
  }

  measure: 28d_total_action_initate_checkout {
    type: sum
    sql: cast(coalesce(nullif(${initiate_checkout_facebook_pixel_28_days_after_clicking}, ''),'0') as integer) ;;
  }

  # CPA's

  measure: 28d_cpa_complete_registration {
    type: number
    sql: ${total_spend}/ NULLIF(${28d_total_action_complete_registration},0) ::REAL ;;
    value_format: "#,##0.00"
  }

  measure: 28d_cpa_purchase {
    type: number
    sql: ${total_spend}/ NULLIF(${28d_total_action_purchase},0) ::REAL ;;
    value_format: "#,##0.00"
  }

  measure: 28d_cpa_lead {
    type: number
    sql: ${total_spend}/ NULLIF(${28d_total_action_lead},0) ::REAL ;;
    value_format: "#,##0.00"
  }

  measure: 28d_cpa_product_view_content {
    type: number
    sql: ${total_spend}/ NULLIF(${28d_total_action_view_content},0) ::REAL ;;
    value_format: "#,##0.00"
  }

  measure: 28d_cpa_add_to_cart {
    type: number
    sql: ${total_spend}/ NULLIF(${28d_total_action_add_to_cart},0) ::REAL ;;
    value_format: "#,##0.00"
  }

  measure: 28d_cpa_initiate_checkout {
    type: number
    sql: ${total_spend}/ NULLIF(${28d_total_action_initate_checkout},0) ::REAL ;;
    value_format: "#,##0.00"
  }


  ######################################################## Reporting Measures ######################################################

  measure: total_spend_including_smartly_commission {
    type: sum
    value_format_name: decimal_2
    sql: ${amount_spent_including_smartly_commission} ;;
    group_label: "Total Spend Reporting Measures"
  }

  measure: total_spend_including_smartly_commission_yesterday {
    label: "Actual"
    type: sum
    value_format_name:gbp
    sql: case when ${calendar_date} = current_date - 1 then ${amount_spent_including_smartly_commission} else 0 end ;;
    group_label: "Total Spend Reporting Measures"
  }

  measure: total_spend_including_smartly_commission_l3d {
    label: "L3D"
    type: sum
    value_format_name:gbp
    sql: case when ${calendar_date} between current_date - 3 and current_date - 1 then ${amount_spent_including_smartly_commission} else 0 end ;;
    group_label: "Total Spend Reporting Measures"
    hidden: yes
  }

  measure: total_spend_including_smartly_commission_l3d_average {
    label: "L3D Avg"
    type: number
    value_format_name: gbp
    sql: ${total_spend_including_smartly_commission_l3d}/3 ;;
    group_label: "Total Spend Reporting Measures"
  }

  measure: total_spend_including_smartly_commission_l3d_vs_yesterday {
    label: "vs L3D Avg"
    type: number
    value_format_name: percent_0
    group_label: "Total Spend Reporting Measures"
    sql: (${total_spend_including_smartly_commission_yesterday} - ${total_spend_including_smartly_commission_l3d_average})/NULLIF(${total_spend_including_smartly_commission_l3d_average},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: total_spend_including_smartly_commission_l7d {
    label: "L7D"
    type: sum
    value_format_name: gbp
    sql: case when ${calendar_date} between current_date - 7 and current_date - 1 then ${amount_spent_including_smartly_commission} else 0 end ;;
    group_label: "Total Spend Reporting Measures"
    hidden: yes
  }

  measure: total_spend_including_smartly_commission_l7d_average {
    label: "L7D Avg"
    type: number
    value_format_name: gbp
    sql: ${total_spend_including_smartly_commission_l7d}/7 ;;
    group_label: "Total Spend Reporting Measures"
  }

  measure: total_spend_including_smartly_commission_l7d_vs_yesterday {
    label: "vs L7D Avg"
    type: number
    value_format_name: percent_0
    group_label: "Total Spend Reporting Measures"
    sql: (${total_spend_including_smartly_commission_yesterday} - ${total_spend_including_smartly_commission_l7d_average})/NULLIF(${total_spend_including_smartly_commission_l7d_average},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: total_spend_including_smartly_commission_lw {
    label: "LW"
    type: sum
    value_format_name: gbp
    sql: case when ${calendar_date} = current_date - 8 then ${amount_spent_including_smartly_commission} else 0 end ;;
    group_label: "Total Spend Reporting Measures"
  }

  measure: total_spend_including_smartly_commission_wow {
    label: "%"
    type: number
    value_format_name: percent_0
    group_label: "Total Spend Reporting Measures"
    sql: (${total_spend_including_smartly_commission_yesterday} - ${total_spend_including_smartly_commission_lw})/NULLIF(${total_spend_including_smartly_commission_lw},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: total_spend_including_smartly_commission_lcw {
    label: "LCW"
    type: sum
    value_format_name: gbp
    sql: case when (((${calendar_date}) >= ((DATEADD(week,-1, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())) ))) AND ( ${calendar_date} ) < ((DATEADD(week,1, DATEADD(week,-1, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())))))))) then ${amount_spent_including_smartly_commission} else 0 end ;;
    group_label: "Total Spend Reporting Measures"
  }

  measure: total_spend_including_smartly_commission_pcw {
    label: "PCW"
    type: sum
    value_format_name: gbp
    sql: case when (((${calendar_date}) >= ((DATEADD(week,-2, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())) ))) AND (${calendar_date}) < ((DATEADD(week,1, DATEADD(week,-2, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())) ) ))))) then ${amount_spent_including_smartly_commission} else 0 end ;;
    group_label: "Total Spend Reporting Measures"
  }

  measure: total_spend_including_smartly_commission_lcw_wow {
    label: "LCW %"
    type: number
    value_format_name: percent_0
    group_label: "Total Spend Reporting Measures"
    sql: (${total_spend_including_smartly_commission_lcw} - ${total_spend_including_smartly_commission_pcw})/NULLIF(${total_spend_including_smartly_commission_pcw},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }



  measure: total_add_to_cart_yesterday {
    label: "Actual"
    type: sum
    value_format_name: decimal_0
    sql: case when ${calendar_date} = current_date - 1 then cast(coalesce(nullif(${add_to_basket_facebook_pixel_1_day_after_clicking}, ''),'0') as integer) else 0 end::REAL ;;
    group_label: "Total Add To Cart Reporting Measures"
    hidden: yes
  }

  measure: total_add_to_cart_l3d {
    label: "L3D"
    type: sum
    value_format_name: decimal_0
    sql: case when ${calendar_date} between current_date - 3 and current_date - 1 then cast(coalesce(nullif(${add_to_basket_facebook_pixel_1_day_after_clicking}, ''),'0') as integer) else 0 end ;;
    group_label: "Total Add To Cart Reporting Measures"
    hidden: yes
  }

  measure: total_add_to_cart_l3d_average {
    label: "L3D Avg"
    type: number
    value_format_name: decimal_0
    sql: ${total_add_to_cart_l3d}/3 ;;
    group_label: "Total Add To Cart Reporting Measures"
    hidden: yes
  }

  measure: total_add_to_cart_l7d {
    label: "L7D"
    type: sum
    value_format_name: decimal_0
    sql: case when ${calendar_date} between current_date - 7 and current_date -1 then cast(coalesce(nullif(${add_to_basket_facebook_pixel_1_day_after_clicking}, ''),'0') as integer) else 0 end ;;
    group_label: "Total Add To Cart Reporting Measures"
    hidden: yes
  }

  measure: total_add_to_cart_l7d_average {
    label: "L7D Avg"
    type: number
    value_format_name: decimal_0
    sql: ${total_add_to_cart_l7d}/7 ;;
    group_label: "Total Add To Cart Reporting Measures"
    hidden: yes
  }

  measure: total_add_to_cart_lw {
    label: "LW"
    type: sum
    value_format_name: decimal_0
    sql: case when ${calendar_date} = current_date - 8 then cast(coalesce(nullif(${add_to_basket_facebook_pixel_1_day_after_clicking}, ''),'0') as integer) else 0 end ;;
    group_label: "Total Add To Cart Reporting Measures"
    hidden: yes
  }

  measure: cost_per_add_to_cart_yesterday {
    label: "Actual"
    type: number
    value_format_name: gbp
    sql: ${total_spend_including_smartly_commission_yesterday}/NULLIF(${total_add_to_cart_yesterday},0) ;;
    group_label: "Cost Per Add To Cart Reporting Measures"
  }

  measure: cost_per_add_to_cart_l3d_average {
    label: "L3D Avg"
    type: number
    value_format_name: gbp
    sql: ${total_spend_including_smartly_commission_l3d}/NULLIF(${total_add_to_cart_l3d},0) ;;
    group_label: "Cost Per Add To Cart Reporting Measures"
  }

  measure: cost_per_add_to_cart_l3d_vs_yesterday {
    label: "vs L3D Avg"
    type: number
    value_format_name: percent_0
    group_label: "Cost Per Add To Cart Reporting Measures"
    sql: (${cost_per_add_to_cart_yesterday} - ${cost_per_add_to_cart_l3d_average})/NULLIF(${cost_per_add_to_cart_l3d_average},0)::REAL ;;
    html: {% if value > 0 %}
        <font color="#D77070"> {{ rendered_value }} </font>
        {% elsif value < 0 %}
        <font color="#3CB371"> {{ rendered_value }} </font>
        {% else %}
        <font color="#000000"> {{ rendered_value }} </font>
        {% endif %}
        ;;
  }

  measure: cost_per_add_to_cart_l7d_average {
    label: "L7D Avg"
    type: number
    value_format_name: gbp
    sql: ${total_spend_including_smartly_commission_l7d}/NULLIF(${total_add_to_cart_l7d},0)::REAL ;;
    group_label: "Cost Per Add To Cart Reporting Measures"
  }

  measure: cost_per_add_to_cart_l7d_vs_yesterday {
    label: "vs L7D Avg"
    type: number
    value_format_name: percent_0
    group_label: "Cost Per Add To Cart Reporting Measures"
    sql: (${cost_per_add_to_cart_yesterday} - ${cost_per_add_to_cart_l7d_average})/NULLIF(${cost_per_add_to_cart_l7d_average},0)::REAL ;;
    html: {% if value > 0 %}
        <font color="#D77070"> {{ rendered_value }} </font>
        {% elsif value < 0 %}
        <font color="#3CB371"> {{ rendered_value }} </font>
        {% else %}
        <font color="#000000"> {{ rendered_value }} </font>
        {% endif %}
        ;;
  }

  measure: cost_per_add_to_cart_lw {
    label: "LW"
    type: number
    value_format_name: gbp
    group_label: "Cost Per Add To Cart Reporting Measures"
    sql: ${total_spend_including_smartly_commission_lw}/NULLIF(${total_add_to_cart_lw},0)::REAL ;;
  }

  measure: cost_per_add_to_cart_wow {
    label: "%"
    type: number
    value_format_name: percent_0
    group_label: "Cost Per Add To Cart Reporting Measures"
    sql: (${cost_per_add_to_cart_yesterday} - ${cost_per_add_to_cart_lw})/NULLIF(${cost_per_add_to_cart_lw},0)::REAL ;;
    html: {% if value > 0 %}
        <font color="#D77070"> {{ rendered_value }} </font>
        {% elsif value < 0 %}
        <font color="#3CB371"> {{ rendered_value }} </font>
        {% else %}
        <font color="#000000"> {{ rendered_value }} </font>
        {% endif %}
        ;;
  }



  measure: orders_yesterday {
    label: "Actual"
    type: sum
    value_format_name: decimal_0
    sql: case when ${calendar_date} = current_date - 1 then cast(coalesce(nullif(${purchase_facebook_pixel_1_day_after_clicking}, ''),'0') as integer) else 0 end ;;
    group_label: "Orders Reporting Measures"
  }

  measure: orders_l3d {
    label: "L3D"
    type: sum
    value_format_name: decimal_0
    sql: case when ${calendar_date} between current_date - 3 and current_date - 1 then cast(coalesce(nullif(${purchase_facebook_pixel_1_day_after_clicking}, ''),'0') as integer) else 0 end ;;
    group_label: "Orders Reporting Measures"
  }

  measure: orders_l3d_average {
    label: "L3D Avg"
    type: number
    value_format_name: decimal_0
    sql: ${orders_l3d}/3 ;;
    group_label: "Orders Reporting Measures"
  }

  measure: orders_l7d {
    label: "L7D"
    type: sum
    value_format_name: decimal_0
    sql: case when ${calendar_date} between current_date - 7 and current_date -1 then cast(coalesce(nullif(${purchase_facebook_pixel_1_day_after_clicking}, ''),'0') as integer) else 0 end ;;
    group_label: "Orders Reporting Measures"
  }

  measure: orders_l7d_average {
    label: "L7D Avg"
    type: number
    value_format_name: decimal_0
    sql: ${orders_l7d}/7 ;;
    group_label: "Orders Reporting Measures"
  }

  measure: orders_lw {
    label: "LW"
    type: sum
    value_format_name: decimal_0
    sql: case when ${calendar_date} = current_date - 8 then cast(coalesce(nullif(${purchase_facebook_pixel_1_day_after_clicking}, ''),'0') as integer) else 0 end ;;
    group_label: "Orders Reporting Measures"
  }

  measure: orders_lcw {
    label: "LCW"
    type: sum
    value_format_name: decimal_0
    sql: case when (((${calendar_date}) >= ((DATEADD(week,-1, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())) ))) AND (${calendar_date}) < ((DATEADD(week,1, DATEADD(week,-1, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())))))))) then cast(coalesce(nullif(${purchase_facebook_pixel_1_day_after_clicking}, ''),'0') as integer) else 0 end ;;
    group_label: "Orders Reporting Measures"
  }

  measure: orders_pcw {
    label: "PCW"
    type: sum
    value_format_name: decimal_0
    sql: case when (((${calendar_date}) >= ((DATEADD(week,-2, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())) ))) AND (${calendar_date}) < ((DATEADD(week,1, DATEADD(week,-2, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())) ) ))))) then cast(coalesce(nullif(${purchase_facebook_pixel_1_day_after_clicking}, ''),'0') as integer) else 0 end ;;
    group_label: "Orders Reporting Measures"
  }

  measure: orders_lcw_wow {
    label: "LCW %"
    type: number
    value_format_name: percent_0
    group_label: "Orders Reporting Measures"
    sql: (${orders_lcw} - ${orders_pcw})/NULLIF(${orders_pcw},0)::REAL ;;
    html: {% if value > 0 %}
        <font color="#D77070"> {{ rendered_value }} </font>
        {% elsif value < 0 %}
        <font color="#3CB371"> {{ rendered_value }} </font>
        {% else %}
        <font color="#000000"> {{ rendered_value }} </font>
        {% endif %}
        ;;
  }


  measure: cost_per_order_yesterday {
    label: "Actual"
    type: number
    value_format_name: gbp
    sql: ${total_spend_including_smartly_commission_yesterday}/NULLIF(${orders_yesterday},0)::REAL ;;
    group_label: "Cost Per Order Reporting Measures"
  }

  measure: cost_per_order_l3d_average {
    label: "L3D Avg"
    type: number
    value_format_name: gbp
    sql: ${total_spend_including_smartly_commission_l3d}/NULLIF(${orders_l3d},0)::REAL ;;
    group_label: "Cost Per Order Reporting Measures"
  }

  measure: cost_per_order_l3d_vs_yesterday {
    label: "vs L3D Avg"
    type: number
    value_format_name: percent_0
    group_label: "Cost Per Order Reporting Measures"
    sql: (${cost_per_order_yesterday} - ${cost_per_order_l3d_average})/NULLIF(${cost_per_order_l3d_average},0)::REAL ;;
    html: {% if value > 0 %}
        <font color="#D77070"> {{ rendered_value }} </font>
        {% elsif value < 0 %}
        <font color="#3CB371"> {{ rendered_value }} </font>
        {% else %}
        <font color="#000000"> {{ rendered_value }} </font>
        {% endif %}
        ;;
  }

  measure: cost_per_order_l7d_average {
    label: "L7D Avg"
    type: number
    value_format_name: gbp
    sql: ${total_spend_including_smartly_commission_l7d}/NULLIF(${orders_l7d},0)::REAL ;;
    group_label: "Cost Per Order Reporting Measures"
  }

  measure: cost_per_order_l7d_vs_yesterday {
    label: "vs L7D Avg"
    type: number
    value_format_name: percent_0
    group_label: "Cost Per Order Reporting Measures"
    sql: (${cost_per_order_yesterday} - ${cost_per_order_l7d_average})/NULLIF(${cost_per_order_l7d_average},0)::REAL ;;
    html: {% if value > 0 %}
        <font color="#D77070"> {{ rendered_value }} </font>
        {% elsif value < 0 %}
        <font color="#3CB371"> {{ rendered_value }} </font>
        {% else %}
        <font color="#000000"> {{ rendered_value }} </font>
        {% endif %}
        ;;
  }

  measure: cost_per_order_lw {
    label: "LW"
    type: number
    value_format_name: gbp
    group_label: "Cost Per Order Reporting Measures"
    sql: ${total_spend_including_smartly_commission_lw}/NULLIF(${orders_lw},0)::REAL ;;
  }

  measure: cost_per_order_wow {
    label: "%"
    type: number
    value_format_name: percent_0
    group_label: "Cost Per Order Reporting Measures"
    sql: (${cost_per_order_yesterday} - ${cost_per_order_lw})/NULLIF(${cost_per_order_lw},0)::REAL ;;
    html: {% if value > 0 %}
        <font color="#D77070"> {{ rendered_value }} </font>
        {% elsif value < 0 %}
        <font color="#3CB371"> {{ rendered_value }} </font>
        {% else %}
        <font color="#000000"> {{ rendered_value }} </font>
        {% endif %}
        ;;
  }

  measure: cost_per_order_lcw {
    label: "LCW"
    type: number
    value_format_name: gbp
    sql: ${total_spend_including_smartly_commission_lcw}/NULLIF(${orders_lcw},0)::REAL ;;
    group_label: "Cost Per Order Reporting Measures"
  }

  measure: cost_per_order_pcw {
    label: "PCW"
    type: number
    value_format_name: gbp
    sql: ${total_spend_including_smartly_commission_pcw}/NULLIF(${orders_pcw},0)::REAL ;;
    group_label: "Cost Per Order Reporting Measures"
  }

  measure: cost_per_order_lcw_wow {
    label: "LCW %"
    type: number
    value_format_name: percent_0
    group_label: "Cost Per Order Reporting Measures"
    sql: (${cost_per_order_lcw} - ${cost_per_order_pcw})/NULLIF(${cost_per_order_pcw},0)::REAL ;;
    html: {% if value > 0 %}
        <font color="#D77070"> {{ rendered_value }} </font>
        {% elsif value < 0 %}
        <font color="#3CB371"> {{ rendered_value }} </font>
        {% else %}
        <font color="#000000"> {{ rendered_value }} </font>
        {% endif %}
        ;;
  }

  measure: revenue_1_day_after_clicking {
    type: sum
    value_format_name: pounds
    sql: ${conversion_value_1_day_after_clicking} ;;
    group_label: "Revenue 1 Day Click Reporting Measures"
  }

  measure: revenue_1_day_after_clicking_yesterday {
    label: "Actual"
    type: sum
    value_format_name: pounds
    sql: case when ${calendar_date} = current_date - 1 then ${conversion_value_1_day_after_clicking} else 0 end;;
    group_label: "Revenue 1 Day Click Reporting Measures"
  }

  measure: revenue_1_day_after_clicking_l3d {
    label: "L3D"
    type: sum
    value_format_name: pounds
    sql: case when ${calendar_date} between current_date - 3 and current_date - 1 then ${conversion_value_1_day_after_clicking} else 0 end;;
    group_label: "Revenue 1 Day Click Reporting Measures"
  }

  measure: revenue_1_day_after_clicking_l3d_average {
    label: "L3D Avg"
    type: number
    value_format_name: pounds
    sql: ${revenue_1_day_after_clicking_l3d}/3  ;;
    group_label: "Revenue 1 Day Click Reporting Measures"
  }

  measure: revenue_1_day_after_clicking_l3d_vs_yesterday {
    label: "vs L3D Avg"
    type: number
    value_format_name: percent_0
    group_label: "Revenue 1 Day Click Reporting Measures"
    sql: (${revenue_1_day_after_clicking_yesterday} - ${revenue_1_day_after_clicking_l3d_average})/NULLIF(${revenue_1_day_after_clicking_l3d_average},0)::REAL ;;
    html: {% if value < 0 %}
        <font color="#D77070"> {{ rendered_value }} </font>
        {% elsif value > 0 %}
        <font color="#3CB371"> {{ rendered_value }} </font>
        {% else %}
        <font color="#000000"> {{ rendered_value }} </font>
        {% endif %}
        ;;
  }

  measure: revenue_1_day_after_clicking_l7d {
    label: "L7D"
    type: sum
    value_format_name: pounds
    sql: case when ${calendar_date} between current_date - 7 and current_date - 1 then ${conversion_value_1_day_after_clicking} else 0 end;;
    group_label: "Revenue 1 Day Click Reporting Measures"
  }

  measure: revenue_1_day_after_clicking_l7d_average {
    label: "L7D Avg"
    type: number
    value_format_name: pounds
    sql: ${revenue_1_day_after_clicking_l7d}/7  ;;
    group_label: "Revenue 1 Day Click Reporting Measures"
  }

  measure: revenue_1_day_after_clicking_l7d_vs_yesterday {
    label: "vs L7D Avg"
    type: number
    value_format_name: percent_0
    group_label: "Revenue 1 Day Click Reporting Measures"
    sql: (${revenue_1_day_after_clicking_yesterday} - ${revenue_1_day_after_clicking_l7d_average})/NULLIF(${revenue_1_day_after_clicking_l7d_average},0)::REAL ;;
    html: {% if value < 0 %}
        <font color="#D77070"> {{ rendered_value }} </font>
        {% elsif value > 0 %}
        <font color="#3CB371"> {{ rendered_value }} </font>
        {% else %}
        <font color="#000000"> {{ rendered_value }} </font>
        {% endif %}
        ;;
  }

  measure: revenue_1_day_after_clicking_lw {
    label: "LW"
    type: sum
    value_format_name: pounds
    sql: case when ${calendar_date} = current_date - 8 then ${conversion_value_1_day_after_clicking} else 0 end;;
    group_label: "Revenue 1 Day Click Reporting Measures"
  }

  measure: revenue_1_day_after_clicking_wow {
    label: "%"
    type: number
    value_format_name: percent_0
    group_label: "Revenue 1 Day Click Reporting Measures"
    sql: (${revenue_1_day_after_clicking_yesterday} - ${revenue_1_day_after_clicking_lw})/NULLIF(${revenue_1_day_after_clicking_lw},0)::REAL ;;
    html: {% if value < 0 %}
        <font color="#D77070"> {{ rendered_value }} </font>
        {% elsif value > 0 %}
        <font color="#3CB371"> {{ rendered_value }} </font>
        {% else %}
        <font color="#000000"> {{ rendered_value }} </font>
        {% endif %}
        ;;
  }

  measure: revenue_1_day_after_clicking_lcw {
    label: "LCW"
    type: sum
    value_format_name: pounds
    sql: case when (((${calendar_date}) >= ((DATEADD(week,-1, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())) ))) AND (${calendar_date}) < ((DATEADD(week,1, DATEADD(week,-1, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())))))))) then ${conversion_value_1_day_after_clicking} else 0 end ;;
    group_label: "Revenue 1 Day Click Reporting Measures"
  }

  measure: revenue_1_day_after_clicking_pcw {
    label: "PCW"
    type: sum
    value_format_name: pounds
    sql: case when (((${calendar_date}) >= ((DATEADD(week,-2, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())) ))) AND (${calendar_date}) < ((DATEADD(week,1, DATEADD(week,-2, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())) ) ))))) then ${conversion_value_1_day_after_clicking} else 0 end ;;
    group_label: "Revenue 1 Day Click Reporting Measures"
  }

  measure: revenue_1_day_after_clicking_lcw_wow {
    label: "LCW %"
    type: number
    value_format_name: percent_0
    group_label: "Revenue 1 Day Click Reporting Measures"
    sql: (${revenue_1_day_after_clicking_lcw} - ${revenue_1_day_after_clicking_pcw})/NULLIF(${revenue_1_day_after_clicking_pcw},0)::REAL ;;
    html: {% if value < 0 %}
        <font color="#D77070"> {{ rendered_value }} </font>
        {% elsif value > 0 %}
        <font color="#3CB371"> {{ rendered_value }} </font>
        {% else %}
        <font color="#000000"> {{ rendered_value }} </font>
        {% endif %}
        ;;
  }


  measure: return_on_investment_yesterday {
    label: "Actual"
    type: number
    value_format_name: decimal_0
    sql: (${revenue_1_day_after_clicking_yesterday}-${total_spend_including_smartly_commission_yesterday})/NULLIF(${total_spend_including_smartly_commission_yesterday},0) ;;
    group_label: "ROI Reporting Measures"
  }

  measure: return_on_investment_l3d_average {
    label: "L3D Avg"
    type: number
    value_format_name: decimal_0
    sql: (${revenue_1_day_after_clicking_l3d_average}-${total_spend_including_smartly_commission_l3d_average})/NULLIF(${total_spend_including_smartly_commission_l3d_average},0) ;;
    group_label: "ROI Reporting Measures"
  }

  measure: return_on_investment_l3d_vs_yesterday {
    label: "vs L3D Avg"
    type: number
    value_format_name: percent_0
    group_label: "ROI Reporting Measures"
    sql: (${return_on_investment_yesterday} - ${return_on_investment_l3d_average})/NULLIF(${return_on_investment_l3d_average},0)::REAL ;;
    html: {% if value < 0 %}
        <font color="#D77070"> {{ rendered_value }} </font>
        {% elsif value > 0 %}
        <font color="#3CB371"> {{ rendered_value }} </font>
        {% else %}
        <font color="#000000"> {{ rendered_value }} </font>
        {% endif %}
        ;;
  }

  measure: return_on_investment_l7d_average {
    label: "L7D Avg"
    type: number
    value_format_name: decimal_0
    sql: (${revenue_1_day_after_clicking_l7d_average}-${total_spend_including_smartly_commission_l7d_average})/NULLIF(${total_spend_including_smartly_commission_l7d_average},0) ;;
    group_label: "ROI Reporting Measures"
  }

  measure: return_on_investment_l7d_vs_yesterday {
    label: "vs L7D Avg"
    type: number
    value_format_name: percent_0
    group_label: "ROI Reporting Measures"
    sql: (${return_on_investment_yesterday} - ${return_on_investment_l7d_average})/NULLIF(${return_on_investment_l7d_average},0)::REAL ;;
    html: {% if value < 0 %}
        <font color="#D77070"> {{ rendered_value }} </font>
        {% elsif value > 0 %}
        <font color="#3CB371"> {{ rendered_value }} </font>
        {% else %}
        <font color="#000000"> {{ rendered_value }} </font>
        {% endif %}
        ;;
  }

  measure: return_on_investment_lw {
    label: "LW"
    type: number
    value_format_name: decimal_0
    group_label: "ROI Reporting Measures"
    sql: (${revenue_1_day_after_clicking_lw}-${total_spend_including_smartly_commission_lw})/NULLIF(${total_spend_including_smartly_commission_lw},0);;
  }

  measure: return_on_investment_wow {
    label: "%"
    type: number
    value_format_name: percent_0
    group_label: "ROI Reporting Measures"
    sql: (${return_on_investment_yesterday} - ${return_on_investment_lw})/NULLIF(${return_on_investment_lw},0)::REAL ;;
    html: {% if value < 0 %}
        <font color="#D77070"> {{ rendered_value }} </font>
        {% elsif value > 0 %}
        <font color="#3CB371"> {{ rendered_value }} </font>
        {% else %}
        <font color="#000000"> {{ rendered_value }} </font>
        {% endif %}
        ;;
  }

  measure: return_on_investment_lcw {
    label: "LCW"
    type: number
    value_format_name: decimal_0
    group_label: "ROI Reporting Measures"
    sql: (${revenue_1_day_after_clicking_lcw}-${total_spend_including_smartly_commission_lcw})/NULLIF(${total_spend_including_smartly_commission_lcw},0);;
  }

  measure: return_on_investment_pcw {
    label: "PCW"
    type: number
    value_format_name: decimal_0
    group_label: "ROI Reporting Measures"
    sql: (${revenue_1_day_after_clicking_pcw}-${total_spend_including_smartly_commission_pcw})/NULLIF(${total_spend_including_smartly_commission_pcw},0);;
  }

  measure: return_on_investment_lcw_wow {
    label: "LCW %"
    type: number
    value_format_name: percent_0
    group_label: "ROI Reporting Measures"
    sql: (${return_on_investment_lcw} - ${return_on_investment_pcw})/NULLIF(${return_on_investment_pcw},0)::REAL ;;
    html: {% if value < 0 %}
        <font color="#D77070"> {{ rendered_value }} </font>
        {% elsif value > 0 %}
        <font color="#3CB371"> {{ rendered_value }} </font>
        {% else %}
        <font color="#000000"> {{ rendered_value }} </font>
        {% endif %}
        ;;
  }




}
