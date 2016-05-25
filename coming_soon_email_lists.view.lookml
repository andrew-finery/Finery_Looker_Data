- view: coming_soon_email_lists
  sql_table_name: coming_soon_emails.lists
  fields:

  - dimension: product_id
    primary_key: true
    type: number
    sql: ${TABLE}.id

  - dimension_group: created
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.created_at

  - dimension: device
    type: string
    sql: ${TABLE}.device

  - dimension: email
    type: string
    sql: ${TABLE}.email

  - dimension: sku
    type: string
    sql: ${TABLE}.sku

  - measure: list_members
    type: count_distinct
    sql: ${email} || ${sku}

