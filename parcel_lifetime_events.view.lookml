- view: parcel_lifetime_events
  sql_table_name: royal_mail.parcel_lifetime_events
  fields:

  - dimension: delivery_attempted
    type: number
    sql: ${TABLE}.delivery_attempted

  - dimension: delivery_confirmed
    type: number
    sql: ${TABLE}.delivery_confirmed

  - dimension: despatch_site
    type: string
    sql: ${TABLE}.despatch_site

  - dimension: destination
    type: string
    sql: ${TABLE}.destination

  - dimension: event_code
    type: string
    sql: ${TABLE}.event_code

  - dimension: event_location
    type: string
    sql: ${TABLE}.event_location

  - dimension: event_location2
    type: string
    sql: ${TABLE}.event_location2

  - dimension: event_location_code
    type: string
    sql: ${TABLE}.event_location_code

  - dimension_group: event
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.event_time

  - dimension: item_code
    type: string
    sql: ${TABLE}.item_code

  - dimension: problem
    type: number
    sql: ${TABLE}.problem

  - dimension: record_type
    type: string
    sql: ${TABLE}.record_type

  - dimension: senders_reference
    type: string
    sql: ${TABLE}.senders_reference

  - dimension: service
    type: string
    sql: ${TABLE}.service

  - dimension: status
    type: string
    sql: ${TABLE}.status

  - dimension: status_detail
    type: string
    sql: ${TABLE}.status_detail

  - dimension: wire_number
    type: string
    sql: ${TABLE}.wire_number

  - measure: count
    type: count
    drill_fields: []

