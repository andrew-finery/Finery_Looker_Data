- view: facebook_api_ad_performance_breakdown
  sql_table_name: facebook_data.facebook_ad_performance_breakdown
  fields:

  - dimension: breakdown
    type: string
    sql: ${TABLE}.breakdown

  - dimension: breakdown_type
    type: string
    sql: ${TABLE}.breakdown_type
  
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
          
  - dimension: placement_specific
    sql: |
          case when ${TABLE}.breakdown like 'News Feed on Desktop Computers' and ${TABLE}.breakdown_type = 'placement' then 'News Feed Desktop'
          when ${TABLE}.breakdown like 'Audience Network on Third-party Mobile Apps and Mobile Websites' and ${TABLE}.breakdown_type = 'placement' then 'Audience Network'
          when ${TABLE}.breakdown like 'Right Column Ads on Home Page for Desktop Computers' and ${TABLE}.breakdown_type = 'placement' then 'Right Column Desktop'
          when ${TABLE}.breakdown like 'Instagram on Mobile Devices' and ${TABLE}.breakdown_type = 'placement' then 'Instagram'
          when ${TABLE}.breakdown like 'News Feed on Mobile Devices' and ${TABLE}.breakdown_type = 'placement' then 'News Feed Mobile' end
          
  - dimension: placement_general
    sql: |
          case when ${TABLE}.breakdown like '%News Feed on Desktop Computers%' and ${TABLE}.breakdown_type = 'placement' then 'Desktop'
          when ${TABLE}.breakdown like '%Audience Network on Third-party Mobile Apps and Mobile Websites%' and ${TABLE}.breakdown_type = 'placement' then 'Mobile'
          when ${TABLE}.breakdown like '%Right Column Ads on Home Page for Desktop Computers%' and ${TABLE}.breakdown_type = 'placement' then 'Desktop'
          when ${TABLE}.breakdown like '%Instagram on Mobile Devices%' and ${TABLE}.breakdown_type = 'placement' then 'Instagram'
          when ${TABLE}.breakdown like '%News Feed on Mobile Devices%' and ${TABLE}.breakdown_type = 'placement' then 'Mobile' end
    
  - dimension: country
    sql: |
          cas ewhen ${TABLE}.breakdown like 'IE' then 'IE'
          when ${TABLE}.breakdown like 'FR' then 'FR'
          when ${TABLE}.breakdown like 'TR' then 'TR'
          when ${TABLE}.breakdown like 'JE' then 'JE'
          when ${TABLE}.breakdown like 'KW' then 'KW'
          when ${TABLE}.breakdown like 'MA' then 'MA'
          when ${TABLE}.breakdown like 'MO' then 'MO'
          when ${TABLE}.breakdown like 'MM' then 'MM'
          when ${TABLE}.breakdown like 'AT' then 'AT'
          when ${TABLE}.breakdown like 'CY' then 'CY'
          when ${TABLE}.breakdown like 'EE' then 'EE'
          when ${TABLE}.breakdown like 'IS' then 'IS'
          when ${TABLE}.breakdown like 'RS' then 'RS'
          when ${TABLE}.breakdown like 'UG' then 'UG'
          when ${TABLE}.breakdown like 'TW' then 'TW'
          when ${TABLE}.breakdown like 'BG' then 'BG'
          when ${TABLE}.breakdown like 'BR' then 'BR'
          when ${TABLE}.breakdown like 'MC' then 'MC'
          when ${TABLE}.breakdown like 'KN' then 'KN'
          when ${TABLE}.breakdown like 'FI' then 'FI'
          when ${TABLE}.breakdown like 'JM' then 'JM'
          when ${TABLE}.breakdown like 'SA' then 'SA'
          when ${TABLE}.breakdown like 'ME' then 'ME'
          when ${TABLE}.breakdown like 'LB' then 'LB'
          when ${TABLE}.breakdown like 'ID' then 'ID'
          when ${TABLE}.breakdown like 'SE' then 'SE'
          when ${TABLE}.breakdown like 'GY' then 'GY'
          when ${TABLE}.breakdown like 'CA' then 'CA'
          when ${TABLE}.breakdown like 'PE' then 'PE'
          when ${TABLE}.breakdown like 'BM' then 'BM'
          when ${TABLE}.breakdown like 'VN' then 'VN'
          when ${TABLE}.breakdown like 'ZA' then 'ZA'
          when ${TABLE}.breakdown like 'HR' then 'HR'
          when ${TABLE}.breakdown like 'AW' then 'AW'
          when ${TABLE}.breakdown like 'PL' then 'PL'
          when ${TABLE}.breakdown like 'LT' then 'LT'
          when ${TABLE}.breakdown like 'AI' then 'AI'
          when ${TABLE}.breakdown like 'DE' then 'DE'
          when ${TABLE}.breakdown like 'NO' then 'NO'
          when ${TABLE}.breakdown like 'BD' then 'BD'
          when ${TABLE}.breakdown like 'HT' then 'HT'
          when ${TABLE}.breakdown like 'SG' then 'SG'
          when ${TABLE}.breakdown like 'PS' then 'PS'
          when ${TABLE}.breakdown like 'IT' then 'IT'
          when ${TABLE}.breakdown like 'AZ' then 'AZ'
          when ${TABLE}.breakdown like 'KZ' then 'KZ'
          when ${TABLE}.breakdown like 'QA' then 'QA'
          when ${TABLE}.breakdown like 'OM' then 'OM'
          when ${TABLE}.breakdown like 'KE' then 'KE'
          when ${TABLE}.breakdown like 'RW' then 'RW'
          when ${TABLE}.breakdown like 'AO' then 'AO'
          when ${TABLE}.breakdown like 'AD' then 'AD'
          when ${TABLE}.breakdown like 'LV' then 'LV'
          when ${TABLE}.breakdown like 'CH' then 'CH'
          when ${TABLE}.breakdown like 'NL' then 'NL'
          when ${TABLE}.breakdown like 'EC' then 'EC'
          when ${TABLE}.breakdown like 'MX' then 'MX'
          when ${TABLE}.breakdown like 'MW' then 'MW'
          when ${TABLE}.breakdown like 'GB' then 'GB'
          when ${TABLE}.breakdown like 'PT' then 'PT'
          when ${TABLE}.breakdown like 'NP' then 'NP'
          when ${TABLE}.breakdown like 'ES' then 'ES'
          when ${TABLE}.breakdown like 'IN' then 'IN'
          when ${TABLE}.breakdown like 'GE' then 'GE'
          when ${TABLE}.breakdown like 'WS' then 'WS'
          when ${TABLE}.breakdown like 'CR' then 'CR'
          when ${TABLE}.breakdown like 'GI' then 'GI'
          when ${TABLE}.breakdown like 'CL' then 'CL'
          when ${TABLE}.breakdown like 'FO' then 'FO'
          when ${TABLE}.breakdown like 'CZ' then 'CZ'
          when ${TABLE}.breakdown like 'HK' then 'HK'
          when ${TABLE}.breakdown like 'MD' then 'MD'
          when ${TABLE}.breakdown like 'UY' then 'UY'
          when ${TABLE}.breakdown like 'GR' then 'GR'
          when ${TABLE}.breakdown like 'NG' then 'NG'
          when ${TABLE}.breakdown like 'HU' then 'HU'
          when ${TABLE}.breakdown like 'MN' then 'MN'
          when ${TABLE}.breakdown like 'LU' then 'LU'
          when ${TABLE}.breakdown like 'NZ' then 'NZ'
          when ${TABLE}.breakdown like 'AR' then 'AR'
          when ${TABLE}.breakdown like 'EG' then 'EG'
          when ${TABLE}.breakdown like 'AL' then 'AL'
          when ${TABLE}.breakdown like 'TH' then 'TH'
          when ${TABLE}.breakdown like 'MK' then 'MK'
          when ${TABLE}.breakdown like 'SL' then 'SL'
          when ${TABLE}.breakdown like 'US' then 'US'
          when ${TABLE}.breakdown like 'DO' then 'DO'
          when ${TABLE}.breakdown like 'IM' then 'IM'
          when ${TABLE}.breakdown like 'PH' then 'PH'
          when ${TABLE}.breakdown like 'IL' then 'IL'
          when ${TABLE}.breakdown like 'TT' then 'TT'
          when ${TABLE}.breakdown like 'RU' then 'RU'
          when ${TABLE}.breakdown like 'UA' then 'UA'
          when ${TABLE}.breakdown like 'MY' then 'MY'
          when ${TABLE}.breakdown like 'DK' then 'DK'
          when ${TABLE}.breakdown like 'BH' then 'BH'
          when ${TABLE}.breakdown like 'AU' then 'AU'
          when ${TABLE}.breakdown like 'SK' then 'SK'
          when ${TABLE}.breakdown like 'JP' then 'JP'
          when ${TABLE}.breakdown like 'IQ' then 'IQ'
          when ${TABLE}.breakdown like 'CN' then 'CN'
          when ${TABLE}.breakdown like 'PK' then 'PK'
          when ${TABLE}.breakdown like 'CO' then 'CO'
          when ${TABLE}.breakdown like 'RO' then 'RO'
          when ${TABLE}.breakdown like 'MT' then 'MT'
          when ${TABLE}.breakdown like 'JO' then 'JO'
          when ${TABLE}.breakdown like 'SI' then 'SI'
          when ${TABLE}.breakdown like 'AE' then 'AE'
          when ${TABLE}.breakdown like 'GD' then 'GD'
          when ${TABLE}.breakdown like 'KY' then 'KY'
          when ${TABLE}.breakdown like 'BE' then 'BE'
          when ${TABLE}.breakdown like 'KR' then 'KR'
          when ${TABLE}.breakdown like 'HN' then 'HN'
          when ${TABLE}.breakdown like 'TL' then 'TL'
          when ${TABLE}.breakdown like 'BS' then 'BS' end
          
  - dimension: age
    sql: |
          case when ${TABLE}.breakdown like '%13-17%' then '13-17'
          when ${TABLE}.breakdown like '%18-24%' then '18-24'
          when ${TABLE}.breakdown like '%25-34%' then '25-34'
          when ${TABLE}.breakdown like '%35-44%' then '35-44'
          when ${TABLE}.breakdown like '%55-64%' then '55-64' 
          when ${TABLE}.breakdown like '%65+%' then '65+' end
          
  - dimension: impression_device
    sql: |
          case when ${TABLE}.breakdown like '%Desktop%' then 'Desktop'
          when ${TABLE}.breakdown like '%iPod%' then 'iPod'
          when ${TABLE}.breakdown like '%Other%' then 'Other'
          when ${TABLE}.breakdown like '%iPad%' then 'iPad'
          when ${TABLE}.breakdown like '%Android Smartphone%' then 'Android Smartphone' 
          when ${TABLE}.breakdown like '%Android Tablet%' then 'Android Tablet'
          when ${TABLE}.breakdown like '%iPhone%' then 'iPhone' end
          
  - dimension: hourly_stats_aggregated_by_audience_time_zone
    sql: |
          case when ${TABLE}.breakdown like '00:00:00 - 00:59:59' and ${TABLE}.breakdown_type = 'hourly_stats_aggregated_by_audience_time_zone' then '00:00:00 - 00:59:59'
          when ${TABLE}.breakdown like '01:00:00 - 01:59:59' and ${TABLE}.breakdown_type = 'hourly_stats_aggregated_by_audience_time_zone' then '01:00:00 - 01:59:59'
          when ${TABLE}.breakdown like '02:00:00 - 02:59:59' and ${TABLE}.breakdown_type = 'hourly_stats_aggregated_by_audience_time_zone' then '02:00:00 - 02:59:59'
          when ${TABLE}.breakdown like '03:00:00 - 03:59:59' and ${TABLE}.breakdown_type = 'hourly_stats_aggregated_by_audience_time_zone' then '03:00:00 - 03:59:59'
          when ${TABLE}.breakdown like '04:00:00 - 04:59:59' and ${TABLE}.breakdown_type = 'hourly_stats_aggregated_by_audience_time_zone' then '04:00:00 - 04:59:59'
          when ${TABLE}.breakdown like '05:00:00 - 05:59:59' and ${TABLE}.breakdown_type = 'hourly_stats_aggregated_by_audience_time_zone' then '05:00:00 - 05:59:59'
          when ${TABLE}.breakdown like '06:00:00 - 06:59:59' and ${TABLE}.breakdown_type = 'hourly_stats_aggregated_by_audience_time_zone' then '06:00:00 - 06:59:59'
          when ${TABLE}.breakdown like '07:00:00 - 07:59:59' and ${TABLE}.breakdown_type = 'hourly_stats_aggregated_by_audience_time_zone' then '07:00:00 - 07:59:59'
          when ${TABLE}.breakdown like '08:00:00 - 08:59:59' and ${TABLE}.breakdown_type = 'hourly_stats_aggregated_by_audience_time_zone' then '08:00:00 - 08:59:59'
          when ${TABLE}.breakdown like '09:00:00 - 09:59:59' and ${TABLE}.breakdown_type = 'hourly_stats_aggregated_by_audience_time_zone' then '09:00:00 - 09:59:59'
          when ${TABLE}.breakdown like '10:00:00 - 10:59:59' and ${TABLE}.breakdown_type = 'hourly_stats_aggregated_by_audience_time_zone' then '10:00:00 - 10:59:59'
          when ${TABLE}.breakdown like '11:00:00 - 11:59:59' and ${TABLE}.breakdown_type = 'hourly_stats_aggregated_by_audience_time_zone' then '11:00:00 - 11:59:59'
          when ${TABLE}.breakdown like '12:00:00 - 12:59:59' and ${TABLE}.breakdown_type = 'hourly_stats_aggregated_by_audience_time_zone' then '12:00:00 - 12:59:59'
          when ${TABLE}.breakdown like '13:00:00 - 13:59:59' and ${TABLE}.breakdown_type = 'hourly_stats_aggregated_by_audience_time_zone' then '13:00:00 - 13:59:59'
          when ${TABLE}.breakdown like '14:00:00 - 14:59:59' and ${TABLE}.breakdown_type = 'hourly_stats_aggregated_by_audience_time_zone' then '14:00:00 - 14:59:59'
          when ${TABLE}.breakdown like '15:00:00 - 15:59:59' and ${TABLE}.breakdown_type = 'hourly_stats_aggregated_by_audience_time_zone' then '15:00:00 - 15:59:59'
          when ${TABLE}.breakdown like '16:00:00 - 16:59:59' and ${TABLE}.breakdown_type = 'hourly_stats_aggregated_by_audience_time_zone' then '16:00:00 - 16:59:59'
          when ${TABLE}.breakdown like '17:00:00 - 17:59:59' and ${TABLE}.breakdown_type = 'hourly_stats_aggregated_by_audience_time_zone' then '17:00:00 - 17:59:59'
          when ${TABLE}.breakdown like '18:00:00 - 18:59:59' and ${TABLE}.breakdown_type = 'hourly_stats_aggregated_by_audience_time_zone' then '18:00:00 - 18:59:59'
          when ${TABLE}.breakdown like '19:00:00 - 19:59:59' and ${TABLE}.breakdown_type = 'hourly_stats_aggregated_by_audience_time_zone' then '19:00:00 - 19:59:59'
          when ${TABLE}.breakdown like '20:00:00 - 20:59:59' and ${TABLE}.breakdown_type = 'hourly_stats_aggregated_by_audience_time_zone' then '20:00:00 - 20:59:59'
          when ${TABLE}.breakdown like '21:00:00 - 21:59:59' and ${TABLE}.breakdown_type = 'hourly_stats_aggregated_by_audience_time_zone' then '21:00:00 - 21:59:59'
          when ${TABLE}.breakdown like '22:00:00 - 22:59:59' and ${TABLE}.breakdown_type = 'hourly_stats_aggregated_by_audience_time_zone' then '22:00:00 - 22:59:59'
          when ${TABLE}.breakdown like '23:00:00 - 23:59:59' and ${TABLE}.breakdown_type = 'hourly_stats_aggregated_by_audience_time_zone' then '23:00:00 - 23:59:59' end
          
          
          
          
    
          
  
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
    type: string
    sql: ${TABLE}.frequency

  - dimension: impressions
    type: string
    hidden: true
    sql: ${TABLE}.impressions

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
  

