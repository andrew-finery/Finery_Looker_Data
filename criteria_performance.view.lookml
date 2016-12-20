- view: adwords_criteria_performance
  sql_table_name: adwords_data.criteria_performance
  fields:


  - dimension: Brand_Non_Brand
    sql: |
          case when ${TABLE}.campaign like '%brand%' or ${TABLE}.campaign like '%Brand%' then 'Brand' else 'Non Brand' end
          
  - dimension: Country
    sql: |
          case when ${TABLE}.accountdescriptivename like 'uk_%' then 'UK'
          case when ${TABLE}.accountdescriptivename like 'ie_%' then 'IE'
          case when ${TABLE}.accountdescriptivename like 'us_%' then 'US' end
  - dimension: ad_group
    type: string
    sql: ${TABLE}.ad_group

  - dimension: ad_group_id
    type: string
    sql: ${TABLE}.ad_group_id
    
  - dimension: account_name
    type: string
    sql: ${TABLE}.accountdescriptivename

  - dimension: ad_relevance
    type: string
    sql: ${TABLE}.ad_relevance

  - dimension: avg_position
    type: string
    sql: ${TABLE}.avg_position

  - dimension: bid_adj
    type: string
    sql: ${TABLE}.bid_adj

  - dimension: campaign
    type: string
    sql: ${TABLE}.campaign

  - dimension: campaign_id
    type: string
    sql: ${TABLE}.campaign_id

  - dimension: campaign_state
    type: string
    sql: ${TABLE}.campaign_state

  - dimension: click_type
    type: string
    sql: ${TABLE}.click_type

  - dimension: clicks
    type: string
    sql: ${TABLE}.clicks

  - dimension: conversion_optimizer_bid_type
    type: string
    sql: ${TABLE}.conversion_optimizer_bid_type

  - dimension: conversions
    type: string
    sql: ${TABLE}.conversions

  - dimension: cost
    type: number
    sql: ${TABLE}.cost

  - dimension: criteria_display_name
    type: string
    sql: ${TABLE}.criteria_display_name

  - dimension: criteria_type
    type: string
    sql: ${TABLE}.criteria_type

  - dimension: custom_parameter
    type: string
    sql: ${TABLE}.custom_parameter

  - dimension_group: date
    type: time
    timeframes: [date, week, month]
    convert_tz: false
    sql: ${TABLE}.date
    
  - dimension_group: calendar
    type: time
    timeframes: [date, day_of_week_index, day_of_week, week, week_of_year, day_of_month, month, month_num, year, quarter, quarter_of_year]
    convert_tz: false
    sql: ${TABLE}.date

  - dimension: device
    type: string
    sql: ${TABLE}.device

  - dimension: dynamic_ad_target
    type: string
    sql: ${TABLE}.dynamic_ad_target

  - dimension: final_url
    type: string
    sql: ${TABLE}.final_url

  - dimension: first_page_cpc
    type: string
    sql: ${TABLE}.first_page_cpc

  - dimension: first_position_cpc
    type: string
    sql: ${TABLE}.first_position_cpc

  - dimension: impressions
    type: string
    sql: ${TABLE}.impressions

  - dimension: is_negative
    type: string
    sql: ${TABLE}.is_negative

  - dimension: keyword__and_placement
    type: string
    sql: ${TABLE}.keyword__and_placement

  - dimension: keyword_and_placement_state
    type: string
    sql: ${TABLE}.keyword_and_placement_state

  - dimension: keyword_id
    type: string
    sql: ${TABLE}.keyword_id

  - dimension: labels
    type: string
    sql: ${TABLE}.labels

  - dimension: landing_page_experience
    type: string
    sql: ${TABLE}.landing_page_experience

  - dimension: max_cpc
    type: string
    sql: ${TABLE}.max_cpc

  - dimension: max_cpc_source
    type: string
    sql: ${TABLE}.max_cpc_source

  - dimension: max_cpm
    type: string
    sql: ${TABLE}.max_cpm

  - dimension: max_cpv
    type: string
    sql: ${TABLE}.max_cpv

  - dimension: max_cpv_source
    type: string
    sql: ${TABLE}.max_cpv_source

  - dimension: quality_score
    type: string
    sql: ${TABLE}.quality_score

  - dimension: top_of_page_cpc
    type: string
    sql: ${TABLE}.top_of_page_cpc

  - dimension: view_through_conv
    type: string
    sql: ${TABLE}.view_through_conv


  ######################################################################################################
  ###################################### MEASURES ####################################################
######################################################################################################

  - measure: total_spend
    type: sum
    decimals: 2
    sql: ${cost}/1000000
    value_format: '#,##0.00'

