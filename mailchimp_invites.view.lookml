- view: mailchimp_invites
  sql_table_name: scratchpad.mailchimp_temp
  fields:

  - dimension: credit
    sql: ${TABLE}.credit

  - dimension: currency
    sql: ${TABLE}.currency

  - dimension: email_address
    sql: ${TABLE}.email_address

  - dimension: first_name
    sql: ${TABLE}.first_name

  - dimension: invitecode
    sql: ${TABLE}.invitecode

  - dimension: last_name
    sql: ${TABLE}.last_name

  - dimension: referrer
    sql: ${TABLE}.referrer

  - dimension: tier
    sql: ${TABLE}.tier

  - measure: number_of_invites_sent
    type: count_distinct
    sql: ${email_address}

