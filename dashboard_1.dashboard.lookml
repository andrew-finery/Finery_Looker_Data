- dashboard: dashboard_1
  title: Web Dashbaord 1 - Overview
  layout: static
  tile_size: 50

  elements:

  - name: conversion_rate_yesterday
    title: CR TW
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.conversion_rate]
    filters:
      atomic_events.event_time_date: 1 day ago for 1 day
    sorts: [atomic_events.conversion_rate desc]
    limit: 500
    total: false
    font_size: small
    height: 2
    width: 3
    top: 0
    left: 0

  - name: conversion_rate_last_week
    title: CR LW
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.conversion_rate]
    filters:
      atomic_events.event_time_date: 8 days ago for 1 day
    sorts: [atomic_events.conversion_rate desc]
    limit: 500
    total: false
    font_size: small
    height: 2
    width: 3
    top: 0
    left: 3

  - name: add_a_unique_name_675
    title: CR WoW
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.conversion_rate_wow]
    sorts: [atomic_events.conversion_rate_wow desc]
    limit: 500
    total: false
    font_size: small
    height: 2
    width: 3
    top: 0
    left: 6

####

  - name: orders_yesterday
    title: Orders TW
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [transactions.count_transactions]
    filters:
      atomic_events.event_time_date: 1 day ago for 1 day
    limit: 500
    total: false
    font_size: small
    height: 2
    width: 3
    top: 2
    left: 0

  - name: orders_last_week
    title: Orders LW
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [transactions.count_transactions]
    filters:
      atomic_events.event_time_date: 8 days ago for 1 day
    limit: 500
    total: false
    font_size: small
    height: 2
    width: 3
    top: 2
    left: 3

  - name: orders_wow
    title: Orders WoW
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.orders_wow]
    sorts: [atomic_events.orders_wow desc]
    limit: 500
    total: false
    font_size: small
    height: 2
    width: 3
    top: 2
    left: 6
  
  ####

  - name: sessions_yesterday
    title: Visits Yesterday
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.count_sessions]
    filters:
      atomic_events.event_time_date: 1 day ago for 1 day
    limit: 500
    total: false
    font_size: small
    height: 2
    width: 3
    top: 8
    left: 0

  - name: orders_last_week
    title: Visits Last Week
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.count_sessions]
    filters:
      atomic_events.event_time_date: 8 days ago for 1 day
    limit: 500
    total: false
    font_size: small
    height: 2
    width: 3
    top: 8
    left: 3

  - name: add_a_unique_name_675
    title: Visits WoW
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.sessions_wow]
    limit: 500
    total: false
    font_size: small
    height: 2
    width: 3
    top: 8
    left: 6
