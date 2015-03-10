- dashboard: dashboard_1
  title: Web Dashbaord 1 - Overview
  layout: static
  tile_size: 50

  elements:

#### conversion rate tiles

  - name: conversion_rate_yesterday
    title: CR Yesterday
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.conversion_rate]
    filters:
      atomic_events.event_time_date: 1 day ago for 1 day
    font_size: small
    height: 2
    width: 3
    top: 0
    left: 0

  - name: conversion_rate_last_week
    title: CR Last Week
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.conversion_rate]
    filters:
      atomic_events.event_time_date: 8 days ago for 1 day
    font_size: small
    height: 2
    width: 3
    top: 0
    left: 3

  - name: conversion_rate_wow
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

#### order tiles

  - name: orders_yesterday
    title: Orders Yesterday
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
    title: Orders Last Week
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

#### items purchased tiles

  - name: items_yesterday
    title: Items Yesterday
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.items_purchased]
    filters:
      atomic_events.event_time_date: 1 day ago for 1 day
    font_size: small
    height: 2
    width: 3
    top: 4
    left: 0

  - name: items_last_week
    title: Items Last Week
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.items_purchased]
    filters:
      atomic_events.event_time_date: 8 days ago for 1 day
    font_size: small
    height: 2
    width: 3
    top: 4
    left: 3

  - name: items_wow
    title: Items WoW
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.items_purchased_wow]
    font_size: small
    height: 2
    width: 3
    top: 4
    left: 6

#### revenue tiles

  - name: revenue_yesterday
    title: Revenue Yesterday
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.sum_revenue_ex_coupon_and_vat]
    filters:
      atomic_events.event_time_date: 1 day ago for 1 day
    font_size: small
    height: 2
    width: 3
    top: 6
    left: 0

  - name: revenue_last_week
    title: Revenue Last Week
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.sum_revenue_ex_coupon_and_vat]
    filters:
      atomic_events.event_time_date: 8 days ago for 1 day
    font_size: small
    height: 2
    width: 3
    top: 6
    left: 3

  - name: revenue_wow
    title: Revenue WoW
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.revenue_wow]
    font_size: small
    height: 2
    width: 3
    top: 6
    left: 6
  
  #### sessions tiles

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

  - name: sessions_last_week
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

  - name: sessions_wow
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

  #### new sessions tiles

  - name: sessions_yesterday
    title: New Visits Yesterday
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.new_session_percentage]
    filters:
      atomic_events.event_time_date: 1 day ago for 1 day
    limit: 500
    total: false
    font_size: small
    height: 2
    width: 3
    top: 10
    left: 0

  - name: sessions_last_week
    title: New Visits Last Week
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.new_session_percentage]
    filters:
      atomic_events.event_time_date: 8 days ago for 1 day
    limit: 500
    total: false
    font_size: small
    height: 2
    width: 3
    top: 10
    left: 3

  - name: sessions_wow
    title: New Visits WoW
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.new_session_perc_wow]
    limit: 500
    total: false
    font_size: small
    height: 2
    width: 3
    top: 10
    left: 6
