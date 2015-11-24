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
    sql: ${TABLE}.clicks

  - dimension: connections
    sql: ${TABLE}.connections

  - dimension: conversions
    sql: ${TABLE}.conversions

  - dimension: conversions_account_0
    sql: ${TABLE}.conversions_account_0

  - dimension: conversions_comments
    sql: ${TABLE}.conversions_comments

  - dimension: conversions_mentions
    sql: ${TABLE}.conversions_mentions

  - dimension: conversions_offsite_6019249047149
    sql: ${TABLE}.conversions_offsite_6019249047149

  - dimension: conversions_offsite_6020814566949
    sql: ${TABLE}.conversions_offsite_6020814566949

  - dimension: conversions_offsite_6020814633549
    sql: ${TABLE}.conversions_offsite_6020814633549

  - dimension: conversions_offsite_6020814677949
    sql: ${TABLE}.conversions_offsite_6020814677949

  - dimension: conversions_offsite_6020814706949
    sql: ${TABLE}.conversions_offsite_6020814706949

  - dimension: conversions_offsite_6020814710549
    sql: ${TABLE}.conversions_offsite_6020814710549

  - dimension: conversions_offsite_6020814716949
    sql: ${TABLE}.conversions_offsite_6020814716949

  - dimension: conversions_offsite_6020814720149
    sql: ${TABLE}.conversions_offsite_6020814720149

  - dimension: conversions_offsite_6031974989949
    sql: ${TABLE}.conversions_offsite_6031974989949

  - dimension: conversions_page_engagement
    sql: ${TABLE}.conversions_page_engagement

  - dimension: conversions_page_likes
    sql: ${TABLE}.conversions_page_likes

  - dimension: conversions_post_engagement
    sql: ${TABLE}.conversions_post_engagement

  - dimension: conversions_post_likes
    sql: ${TABLE}.conversions_post_likes

  - dimension: conversions_post_shares
    sql: ${TABLE}.conversions_post_shares

  - dimension: conversions_website_clicks
    sql: ${TABLE}.conversions_website_clicks

  - dimension: countries
    sql: ${TABLE}.countries

  - dimension: creative
    sql: ${TABLE}.creative

  - dimension: creative_meta_page_name
    sql: ${TABLE}.creative_meta_page_name

  - dimension: creative_meta_url_tags
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
    sql: ${TABLE}.impressions

  - dimension: interests
    sql: ${TABLE}.interests

  - dimension: max_age
    sql: ${TABLE}.max_age

  - dimension: min_age
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

  - dimension: reach
    sql: ${TABLE}.reach

  - dimension: revenue
    sql: ${TABLE}.revenue

  - dimension: spent
    sql: ${TABLE}.spent

  - dimension: title
    sql: ${TABLE}.title

  - dimension: url
    sql: ${TABLE}.url

  - measure: count
    type: count
    drill_fields: detail*


  # ----- Sets of fields for drilling ------
  sets:
    detail:
    - creative_meta_page_name
    - campaign_name
    - adset_name
    - ad_name
    - account_name
    - name

