- view: adwords_search_query_performance
  sql_table_name: adwords_data.search_query_performance
  fields:

  - dimension: ad_group
    type: string
    sql: ${TABLE}.ad_group

  - dimension: ad_group_id
    type: string
    sql: ${TABLE}.ad_group_id

  - dimension: ad_id
    type: string
    sql: ${TABLE}.ad_id

  - dimension: ad_type
    type: string
    sql: ${TABLE}.ad_type

  - dimension: avg_position
    type: string
    sql: ${TABLE}.avg_position

  - dimension: campaign
    type: string
    sql: ${TABLE}.campaign

  - dimension: campaign_id
    type: string
    sql: ${TABLE}.campaign_id

  - dimension: campaign_state
    type: string
    sql: ${TABLE}.campaign_state

  - dimension: clicks
    type: number
    hidden: true
    sql: ${TABLE}.clicks

  - dimension: conversions
    type: string
    sql: ${TABLE}.conversions

  - dimension: cost
    type: number
    hidden: true
    sql: ${TABLE}.cost

  - dimension_group: date
    type: time
    timeframes: [date, week, month]
    convert_tz: false
    sql: ${TABLE}.date

  - dimension: device
    type: string
    sql: ${TABLE}.device

  - dimension: final_url
    type: string
    sql: ${TABLE}.final_url

  - dimension: impressions
    type: number
    hidden: true
    sql: ${TABLE}.impressions

  - dimension: keyword
    type: string
    sql: ${TABLE}.keyword

  - dimension: keyword_id
    type: string
    sql: ${TABLE}.keyword_id

  - dimension: match_type
    type: string
    sql: ${TABLE}.match_type

  - dimension: search_term
    type: string
    sql: ${TABLE}.search_term
    
    
    
    
    
    
    
    
    
    
    
    

  - measure: nr_of_searches
    type: count_distinct
    sql: ${search_term}
    
  - measure: total_spend
    type: sum
    decimals: 2
    sql: ${cost}/1000000
    value_format: '#,##0.00'
    
  - measure: total_impressions
    type: sum
    sql: ${impressions}
    
  - measure: total_clicks
    type: sum
    sql: ${clicks}
    
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
    

