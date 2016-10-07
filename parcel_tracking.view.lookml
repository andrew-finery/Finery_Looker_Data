- view: parcel_tracking
  sql_table_name: royal_mail.parcel_tracking
  fields:

  - dimension_group: attempted_delivery
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.attempted_delivery

  - dimension: attempted_delivery_status_detail
    type: string
    sql: ${TABLE}.attempted_delivery_status_detail

  - dimension: confimed_delivery_status_detail
    type: string
    sql: ${TABLE}.confimed_delivery_status_detail

  - dimension_group: confirmed_delivery
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.confirmed_delivery

  - dimension: despatch_site
    type: string
    sql: ${TABLE}.despatch_site

  - dimension: destination
    type: string
    sql: ${TABLE}.destination

  - dimension: event_location
    type: string
    sql: ${TABLE}.event_location

  - dimension: event_location2
    type: string
    sql: ${TABLE}.event_location2

  - dimension: event_location_code
    type: string
    sql: ${TABLE}.event_location_code

  - dimension: item_code
    type: string
    sql: ${TABLE}.item_code

  - dimension_group: last_event
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.last_event

  - dimension: last_event_status_detail
    type: string
    sql: ${TABLE}.last_event_status_detail

  - dimension_group: problem
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.problem

  - dimension: problem_status_detail
    type: string
    sql: ${TABLE}.problem_status_detail

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

  - dimension: wire_number
    type: string
    sql: ${TABLE}.wire_number

  - measure: count
    type: count
    drill_fields: []

