- view: mandrill_message_sent
  sql_table_name: atomic.com_mandrill_message_sent_1
  fields:

  - dimension: event_id
    sql: ${TABLE}.root_id
    hidden: true

  - dimension_group: email_sent
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.root_tstamp

  - dimension: email_id
    sql: ${TABLE}."msg._id"

  - dimension: email_sent_to
    sql: ${TABLE}."msg.email"

  - dimension: email_sent_from
    sql: ${TABLE}."msg.sender"

  - dimension: email_state
    sql: ${TABLE}."msg.state"

  - dimension: email_subject
    sql: ${TABLE}."msg.subject"
    
  - measure: count_messages_sent
    type: count_distinct
    sql: ${email_id}
    
  - measure: open_rate
    type: number
    sql: ${mandrill_message_opened.count_unique_opens}/NULLIF(${count_messages_sent},0)::REAL
    value_format: '#0.00%'

