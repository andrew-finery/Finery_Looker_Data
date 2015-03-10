- dashboard: dashboard_2
  title: Web Dashboard 2 - Today's Overview
  layout: static
  tile_size: 50

  elements:

######################################### Graphs

  - name: conv_rate_today_vs_lw
    title: Conversion Rate - Today vs Last Week
    type: looker_line
    model: finery_data
    explore: atomic_events
    dimensions: [atomic_events.event_time_date, atomic_events.event_time_hour_of_day]
    pivots: [atomic_events.event_time_date]
    measures: [atomic_events.conversion_rate]
    filters:
      atomic_events.event_time_time: before 1 hour ago
      atomic_events.wow_date_filter: 'Yes'
    sorts: [atomic_events.event_time_hour_of_day, atomic_events.event_time_date]
    limit: 500
    total: false
    show_null_points: false
    font_size: small
    show_value_labels: false
    show_view_names: true
    x_axis_gridlines: true
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_gridlines: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    x_axis_datetime_label: ''
    x_axis_label: Hour of Day
    stacking: ''
    x_axis_scale: auto
    point_style: none
    interpolation: monotone
    colors: [blue, red]
    height: 6
    width: 8
    top: 0
    left: 0

  - name: orders_today_vs_lw
    title: Orders - Today vs Last Week
    type: looker_line
    model: finery_data
    explore: atomic_events
    dimensions: [atomic_events.event_time_date, atomic_events.event_time_hour_of_day]
    pivots: [atomic_events.event_time_date]
    measures: [transactions.count_transactions]
    filters:
      atomic_events.event_time_time: before 1 hour ago
      atomic_events.wow_date_filter: 'Yes'
    sorts: [atomic_events.event_time_hour_of_day, atomic_events.event_time_date]
    limit: 500
    total: false
    show_null_points: false
    font_size: small
    show_value_labels: false
    show_view_names: true
    x_axis_gridlines: true
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_gridlines: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    x_axis_datetime_label: ''
    x_axis_label: Hour of Day
    stacking: ''
    x_axis_scale: auto
    point_style: none
    interpolation: monotone
    colors: [blue, red]
    height: 6
    width: 8
    top: 6
    left: 0

  - name: sessions_vs_lw
    title: Visits - Today vs Last Week
    type: looker_line
    model: finery_data
    explore: atomic_events
    dimensions: [atomic_events.event_time_date, atomic_events.event_time_hour_of_day]
    pivots: [atomic_events.event_time_date]
    measures: [atomic_events.count_sessions]
    filters:
      atomic_events.event_time_time: before 1 hour ago
      atomic_events.wow_date_filter: 'Yes'
    sorts: [atomic_events.event_time_hour_of_day, atomic_events.event_time_date]
    limit: 500
    total: false
    show_null_points: false
    font_size: small
    show_value_labels: false
    show_view_names: true
    x_axis_gridlines: true
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_gridlines: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    x_axis_datetime_label: ''
    x_axis_label: Hour of Day
    stacking: ''
    x_axis_scale: auto
    point_style: none
    interpolation: monotone
    colors: [blue, red]
    height: 6
    width: 8
    top: 12
    left: 0

################################################# Column - this week vs target

  - name: conversion_rate_today
    title: CR - So Far Today
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.conversion_rate]
    filters:
      atomic_events.event_time_date: 0 days ago for 1 day
    font_size: small
    height: 3
    width: 3
    top: 0
    left: 8

  - name: conversion_rate_last_week
    title: TARGET - CR Last Week
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.conversion_rate]
    filters:
      atomic_events.event_time_date: 7 days ago for 1 day
    font_size: small
    height: 3
    width: 3
    top: 3
    left: 8