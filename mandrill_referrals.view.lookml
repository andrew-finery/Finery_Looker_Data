- view: mandrill_referrals
  sql_table_name: scratchpad.mandrill_referrals_temp
  fields:

  - dimension: bounce_detail
    sql: ${TABLE}.bounce_detail

  - dimension: clicks
    sql: ${TABLE}.clicks

  - dimension: email_address
    sql: ${TABLE}.email_address

  - dimension: opens
    sql: ${TABLE}.opens

  - dimension: sender
    sql: ${TABLE}.sender

  - dimension: status
    sql: ${TABLE}.status

  - dimension: subject
    sql: ${TABLE}.subject

  - dimension: tags
    sql: ${TABLE}.tags

  - measure: number_of_invites_sent
    type: count_distinct
    sql: ${email_address}

