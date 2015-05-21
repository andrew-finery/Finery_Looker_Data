- dashboard: website_technology
  title: Website Technology
  layout: static
  tile_size: 20
  show_applied_filters: true

#  filters:

  elements:

  - name: orders_by_hour_by_device_yest
    title: Visits by Hour by Device - Yesterday
    type: looker_area
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_hour_of_day, sessions.device_type]
    pivots: [sessions.device_type]
    measures: [sessions.count]
    filters:
      sessions.device_type: -Other/Unknown
      sessions.start_date: yesterday
    sorts: [sessions.start_hour_of_day, sessions.device_type asc]
    limit: 500
    column_limit: ''
    show_value_labels: false
    stacking: normal
    show_null_labels: false
    interpolation: monotone
    swap_axes: false
    point_style: none
    x_axis_gridlines: false
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    x_axis_scale: auto
    show_null_points: true
    show_view_names: false
    top: 0
    left: 0
    height: 14
    width: 30

#### VISITS

  - name: visits_yesterday_v_last_week
    title: Visits Yesterday vs Last Week
    type: table
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_date, sessions.device_type]
    pivots: [sessions.device_type]
    measures: [sessions.count]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Week on Week
      expression: |
        concat(round(100 * (${sessions.count} - offset(${sessions.count},1))/offset(${sessions.count},1),2),"%")
    filters:
      sessions.device_type: -Other/Unknown
      sessions.start_date: 8 days ago, 1 day ago
    sorts: [sessions.start_date desc]
    limit: 500
    column_limit: ''
    show_view_names: false
    top: 14
    left: 0
    height: 14
    width: 22

  - name: visits_yesterday_v_last_week
    title: Visits Last Week vs Week Before
    type: table
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_week, sessions.device_type]
    pivots: [sessions.device_type]
    measures: [sessions.count]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Week on Week
      expression: |
        concat(round(100 * (${sessions.count} - offset(${sessions.count},1))/offset(${sessions.count},1),2),"%")
    filters:
      sessions.device_type: -Other/Unknown
      sessions.start_date: 3 weeks ago for 2 weeks
    sorts: [sessions.start_week desc]
    limit: 500
    column_limit: ''
    show_view_names: false
    top: 14
    left: 22
    height: 14
    width: 22

  - name: visits_last_30_days
    title: Visits by Device - Last 30 Days
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_date, sessions.device_type]
    pivots: [sessions.device_type]
    measures: [sessions.count]
    filters:
      sessions.device_type: -Other/Unknown
      sessions.start_date: 31 days ago for 30 days
    sorts: [sessions.start_date]
    limit: 500
    column_limit: ''
    show_null_points: true
    x_axis_gridlines: false
    show_x_axis_label: true
    show_x_axis_ticks: true
    show_value_labels: false
    show_view_names: false
    point_style: none
    interpolation: monotone
    stacking: ''
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    x_axis_scale: auto
    top: 14
    left: 44
    height: 14
    width: 22

## ORDERS
  
  - name: orders_yesterday_v_last_week
    title: Orders Yesterday vs Last Week
    type: table
    model: finery_data
    explore: sessions
    dimensions: [transactions.trans_time_date, sessions.device_type]
    pivots: [sessions.device_type]
    measures: [transactions.count_transactions]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Week on Week
      expression: |
        concat(round(100 * (${transactions.count_transactions} - offset(${transactions.count_transactions},1))/offset(${transactions.count_transactions},1),2),"%")
    filters:
      sessions.device_type: -Other/Unknown
      transactions.trans_time_date: 8 days ago, 1 day ago
    sorts: [transactions.trans_time_date desc]
    limit: 500
    column_limit: ''
    show_view_names: false
    top: 28
    left: 0
    height: 14
    width: 22

  - name: orders_yesterday_v_last_week
    title: Orders Last Week vs Week Before
    type: table
    model: finery_data
    explore: sessions
    dimensions: [transactions.trans_time_week, sessions.device_type]
    pivots: [sessions.device_type]
    measures: [transactions.count_transactions]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Week on Week
      expression: |
        concat(round(100 * (${transactions.count_transactions} - offset(${transactions.count_transactions},1))/offset(${transactions.count_transactions},1),2),"%")
    filters:
      sessions.device_type: -Other/Unknown
      transactions.trans_time_date: 3 weeks ago for 2 weeks
    sorts: [transactions.trans_time_week desc]
    limit: 500
    column_limit: ''
    show_view_names: false
    top: 28
    left: 22
    height: 14
    width: 22

  - name: orders_last_30_days
    title: Orders by Device - Last 30 Days
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [transactions.trans_time_date, sessions.device_type]
    pivots: [sessions.device_type]
    measures: [transactions.count_transactions]
    filters:
      sessions.device_type: -Other/Unknown
      transactions.trans_time_date: 31 days ago for 30 days
    sorts: [transactions.trans_time_date]
    limit: 500
    column_limit: ''
    show_null_points: true
    x_axis_gridlines: false
    show_x_axis_label: true
    show_x_axis_ticks: true
    show_value_labels: false
    show_view_names: false
    point_style: none
    interpolation: monotone
    stacking: ''
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    x_axis_scale: auto
    top: 28
    left: 44
    height: 14
    width: 22

## CONVERSION RATE

  - name: orders_yesterday_v_last_week
    title: Orders Yesterday vs Last Week
    type: table
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_date, sessions.device_type]
    pivots: [sessions.device_type]
    measures: [sessions.conversion_rate_short_name]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Week on Week
      expression: |
        concat(round(100 * (${sessions.conversion_rate_short_name} - offset(${sessions.conversion_rate_short_name},1))/offset(${sessions.conversion_rate_short_name},1),2),"%")
    filters:
      sessions.device_type: -Other/Unknown
      sessions.start_date: 8 days ago, 1 day ago
    sorts: [sessions.start_date desc]
    limit: 500
    column_limit: ''
    show_view_names: false
    top: 42
    left: 0
    height: 14
    width: 22

  - name: orders_yesterday_v_last_week
    title: Orders Last Week vs Week Before
    type: table
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_week, sessions.device_type]
    pivots: [sessions.device_type]
    measures: [sessions.conversion_rate_short_name]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Week on Week
      expression: |
        concat(round(100 * (${sessions.conversion_rate_short_name} - offset(${sessions.conversion_rate_short_name},1))/offset(${sessions.conversion_rate_short_name},1),2),"%")
    filters:
      sessions.device_type: -Other/Unknown
      sessions.start_date: 3 weeks ago for 2 weeks
    sorts: [sessions.start_week desc]
    limit: 500
    column_limit: ''
    show_view_names: false
    top: 42
    left: 22
    height: 14
    width: 22

  - name: orders_last_30_days
    title: Orders by Device - Last 30 Days
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_date, sessions.device_type]
    pivots: [sessions.device_type]
    measures: [sessions.conversion_rate_short_name]
    filters:
      sessions.device_type: -Other/Unknown
      sessions.start_date: 31 days ago for 30 days
    sorts: [sessions.start_date]
    limit: 500
    column_limit: ''
    show_null_points: true
    x_axis_gridlines: false
    show_x_axis_label: true
    show_x_axis_ticks: true
    show_value_labels: false
    show_view_names: false
    point_style: none
    interpolation: monotone
    stacking: ''
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    x_axis_scale: auto
    top: 42
    left: 44
    height: 14
    width: 22
    
## CONVERSION RATE

  - name: conversion_rate_short_name_yesterday_v_last_week
    title: Conversion Rate Yesterday vs Last Week
    type: table
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_date, sessions.device_type]
    pivots: [sessions.device_type]
    measures: [sessions.conversion_rate_short_name]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Week on Week
      expression: |
        concat(round(100 * (${sessions.conversion_rate_short_name} - offset(${sessions.conversion_rate_short_name},1))/offset(${sessions.conversion_rate_short_name},1),2),"%")
    filters:
      sessions.device_type: -Other/Unknown
      sessions.start_date: 8 days ago, 1 day ago
    sorts: [sessions.start_date desc]
    limit: 500
    column_limit: ''
    show_view_names: false
    top: 42
    left: 0
    height: 14
    width: 22

  - name: conversion_rate_short_name_yesterday_v_last_week
    title: Conversion Rate Last Week vs Week Before
    type: table
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_week, sessions.device_type]
    pivots: [sessions.device_type]
    measures: [sessions.conversion_rate_short_name]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Week on Week
      expression: |
        concat(round(100 * (${sessions.conversion_rate_short_name} - offset(${sessions.conversion_rate_short_name},1))/offset(${sessions.conversion_rate_short_name},1),2),"%")
    filters:
      sessions.device_type: -Other/Unknown
      sessions.start_date: 3 weeks ago for 2 weeks
    sorts: [sessions.start_week desc]
    limit: 500
    column_limit: ''
    show_view_names: false
    top: 42
    left: 22
    height: 14
    width: 22

  - name: conversion_rate_short_name_last_30_days
    title: Conversion Rate by Device - Last 30 Days
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_date, sessions.device_type]
    pivots: [sessions.device_type]
    measures: [sessions.conversion_rate_short_name]
    filters:
      sessions.device_type: -Other/Unknown
      sessions.start_date: 31 days ago for 30 days
    sorts: [sessions.start_date]
    limit: 500
    column_limit: ''
    show_null_points: true
    x_axis_gridlines: false
    show_x_axis_label: true
    show_x_axis_ticks: true
    show_value_labels: false
    show_view_names: false
    point_style: none
    interpolation: monotone
    stacking: ''
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    x_axis_scale: auto
    top: 42
    left: 44
    height: 14
    width: 22