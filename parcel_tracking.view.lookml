- view: parcel_tracking
  sql_table_name: royal_mail.parcel_tracking
  fields:

  - dimension_group: time_of_first_attempted_delivery
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.attempted_delivery

  - dimension: status_detail_of_first_attempted_delivery
    type: string
    sql: ${TABLE}.attempted_delivery_status_detail

  - dimension: status_detail_of_confimed_delivery
    type: string
    sql: ${TABLE}.confimed_delivery_status_detail

  - dimension_group: time_of_confirmed_delivery
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
    hidden: true

  - dimension: event_location2
    type: string
    sql: ${TABLE}.event_location2
    hidden: true

  - dimension: event_location_code
    type: string
    sql: ${TABLE}.event_location_code
    hidden: true

  - dimension: item_code
    type: string
    sql: ${TABLE}.item_code

  - dimension_group: time_of_last_event
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.last_event

  - dimension: status_detail_of_last_event
    type: string
    sql: ${TABLE}.last_event_status_detail

  - dimension_group: time_of_first_problem
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.problem

  - dimension: status_detail_of_first_problem
    type: string
    sql: ${TABLE}.problem_status_detail

  - dimension: record_type
    type: string
    sql: ${TABLE}.record_type
    hidden: true

  - dimension: senders_reference
    label: 'shipment number'
    type: string
    sql: ${TABLE}.senders_reference

  - dimension: service
    type: string
    sql: ${TABLE}.service

  - dimension: status
    type: string
    sql: ${TABLE}.status
    hidden: true

  - dimension: wire_number
    type: string
    sql: ${TABLE}.wire_number
    hidden: true