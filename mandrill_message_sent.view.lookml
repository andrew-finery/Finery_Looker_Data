- view: mandrill_message_sent
  sql_table_name: atomic.com_mandrill_message_sent_1
  fields:

  - dimension: message_id
    sql: ${TABLE}."msg._id"

  - dimension: msg_version
    sql: ${TABLE}.msg._version

  - dimension: msgclicks
    sql: ${TABLE}.msg.clicks

  - dimension: msgemail
    sql: ${TABLE}.msg.email

  - dimension: msgmetadatauser_id
    sql: ${TABLE}.msg.metadata.user_id

  - dimension: msgopens
    sql: ${TABLE}.msg.opens

  - dimension: msgreject
    sql: ${TABLE}.msg.reject

  - dimension: msgresends
    sql: ${TABLE}.msg.resends

  - dimension: msgsender
    sql: ${TABLE}.msg.sender

  - dimension: msgsmtp_events
    sql: ${TABLE}.msg.smtp_events

  - dimension: msgstate
    sql: ${TABLE}.msg.state

  - dimension: msgsubaccount
    sql: ${TABLE}.msg.subaccount

  - dimension: msgsubject
    sql: ${TABLE}."msg.subject"

  - dimension: msgtags
    sql: ${TABLE}.msg.tags

  - dimension: msgtemplate
    sql: ${TABLE}.msg.template

  - dimension_group: msgts
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.msg.ts

  - dimension: root_id
    sql: ${TABLE}.root_id

  - dimension_group: root_tstamp
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.root_tstamp

  - measure: count
    type: count
    drill_fields: [schema_name]

