- view: search_query_performance
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
    type: string
    sql: ${TABLE}.clicks

  - dimension: conversions
    type: string
    sql: ${TABLE}.conversions

  - dimension: cost
    type: string
    sql: ${TABLE}.cost

  - dimension: date
    type: string
    sql: ${TABLE}.date

  - dimension: device
    type: string
    sql: ${TABLE}.device

  - dimension: final_url
    type: string
    sql: ${TABLE}.final_url

  - dimension: impressions
    type: string
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
    type: count
    sql: ${search_term}
    

