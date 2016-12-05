- view: affiliate_lookup
  sql_table_name: affiliate_data.campaign_lookup
  fields:

  - dimension: campaign_id
    type: number
    sql: ${TABLE}.campaign_id

  - dimension: affiliate_name
    type: string
    sql: ${TABLE}.affiliate_name
