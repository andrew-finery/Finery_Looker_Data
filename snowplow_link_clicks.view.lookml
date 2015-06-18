- view: snowplow_link_clicks
  sql_table_name: atomic.com_snowplowanalytics_snowplow_link_click_1
  fields:

  - dimension: element_classes
    label: Link Type
    sql: ${TABLE}.element_classes
    
  - dimension: element_id
    sql: ${TABLE}.element_id
    hidden: true

  - dimension: element_target
    sql: ${TABLE}.element_target

  - dimension: root_id
    sql: ${TABLE}.root_id
    hidden: true

  - dimension_group: root_tstamp
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.root_tstamp
    hidden: true
    
  - dimension: target_url
    sql: ${TABLE}.target_url

  - measure: link_clicks_count
    type: number
    sql: approximate count(distinct ${root_id})

