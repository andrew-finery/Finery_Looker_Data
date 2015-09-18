- dashboard: weekly_kpi_dashboard
  title: Weekly Kpi Dashboard
  layout: static
  tile_size: 100

#  filters:

  elements:

  - name: orders_wow
    title: Orders WoW
    type: table
    model: finery_data
    explore: spree_orders
    dimensions: [calendar_weeks.year_week_number]
    measures: [spree_orders.count_orders]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Week on Week
      expression: |
        (${spree_orders.count_orders} - offset(${spree_orders.count_orders},1))/offset(${spree_orders.count_orders},1)
      value_format: '#0.00%'
    filters:
      calendar_weeks.calendar_date_date: 2 weeks ago for 2 weeks
    sorts: [calendar_weeks.year_week_number desc]
    limit: 500
    column_limit: ''
    height: 2
    width: 3
    top: 0
    left: 0

  - name: basket_size_wow
    title: Basket Size Week on Week
    type: table
    model: finery_data
    explore: spree_orders
    dimensions: [calendar_weeks.year_week_number]
    measures: [spree_orders.avg_gross_revenue_ex_discount_in_gbp_ex_vat]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Week on Week
      expression: |+
        (${spree_orders.avg_gross_revenue_ex_discount_in_gbp_ex_vat} - offset(${spree_orders.avg_gross_revenue_ex_discount_in_gbp_ex_vat},1))/(offset(${spree_orders.avg_gross_revenue_ex_discount_in_gbp_ex_vat},1))
  
      value_format: '#0.00%'
    filters:
      calendar_weeks.calendar_date_date: 2 weeks ago for 2 weeks
    sorts: [calendar_weeks.year_week_number desc]
    limit: 500
    column_limit: ''
    height: 2
    width: 3
    top: 0
    left: 3
    
  - name: visits_wow
    title: Visits Week on Week
    type: table
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.year_week_number]
    measures: [sessions.count]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Week on Week
      expression: (${sessions.count} - offset(${sessions.count},1))/offset(${sessions.count},1)
      value_format: '#0.00%'
    filters:
      session_start_calendar.calendar_date_date: 2 weeks ago for 2 weeks
    sorts: [session_start_calendar.year_week_number desc]
    limit: 500
    column_limit: ''
    height: 2
    width: 3
    top: 0
    left: 6
    
  - name: conversion_rate_wow
    title: Conversion Rate Week on Week
    type: table
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.year_week_number]
    measures: [sessions.conversion_rate]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Week on Week
      expression: (${sessions.conversion_rate} - offset(${sessions.conversion_rate},1))/offset(${sessions.conversion_rate},1)
      value_format: '#0.00%'
    filters:
      session_start_calendar.calendar_date_date: 2 weeks ago for 2 weeks
    sorts: [session_start_calendar.year_week_number desc]
    limit: 500
    column_limit: ''
    height: 2
    width: 3
    top: 0
    left: 9
    
  - name: orders_last_8_weeks
    title: Orders Last 8 Weeks
    type: looker_column
    model: finery_data
    explore: spree_orders
    dimensions: [calendar_weeks.year_week_number]
    measures: [spree_orders.count_orders]
    filters:
      calendar_weeks.calendar_date_date: 8 weeks ago for 8 weeks
    sorts: [calendar_weeks.year_week_number]
    limit: 500
    column_limit: ''
    show_view_names: false
    stacking: ''
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    ordering: none
    show_null_labels: false
    show_row_numbers: true
    height: 4
    width: 6
    top: 2
    left: 0
    
  - name: basket_size_last_8_weeks
    title: Basket Size Last 8 Weeks
    type: looker_line
    model: finery_data
    explore: spree_orders
    dimensions: [calendar_weeks.year_week_number]
    measures: [spree_orders.avg_gross_revenue_ex_discount_in_gbp_ex_vat]
    filters:
      calendar_weeks.calendar_date_date: 8 weeks ago for 8 weeks
    sorts: [calendar_weeks.year_week_number]
    limit: 500
    column_limit: ''
    show_view_names: false
    stacking: ''
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    show_row_numbers: true
    show_null_points: true
    point_style: none
    interpolation: linear
    ordering: none
    show_null_labels: false
    height: 4
    width: 6
    top: 2
    left: 6
    
  - name: visits_last_8_weeks
    title: Visits Last 8 Weeks
    type: looker_column
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.year_week_number]
    measures: [sessions.count]
    filters:
      session_start_calendar.calendar_date_date: 8 weeks ago for 8 weeks
    sorts: [session_start_calendar.year_week_number]
    limit: 500
    column_limit: ''
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    ordering: none
    show_null_labels: false
    hide_legend: false
    show_null_points: true
    point_style: circle
    interpolation: monotone
    show_dropoff: false
    height: 4
    width: 6
    top: 6
    left: 0

  - name: cr_last_8_weeks
    title: Conversion Rate - Last 8 Weeks
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.year_week_number]
    measures: [sessions.conversion_rate]
    filters:
      session_start_calendar.calendar_date_date: 8 weeks ago for 8 weeks
    sorts: [session_start_calendar.year_week_number]
    limit: 500
    column_limit: ''
    stacking: ''
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    show_null_points: true
    point_style: circle
    interpolation: monotone
    ordering: none
    show_null_labels: false
    hide_legend: false
    height: 4
    width: 6
    top: 6
    left: 6
    
  - name: orders_by_month
    title: Orders by Month
    type: looker_column
    model: finery_data
    explore: spree_orders
    dimensions: [calendar_weeks.calendar_date_month]
    measures: [spree_orders.count_orders]
    filters:
      calendar_weeks.calendar_date_date: after 2015/02/01
    sorts: [calendar_weeks.calendar_date_month]
    limit: 500
    column_limit: ''
    show_view_names: false
    stacking: ''
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: ordinal
    ordering: none
    show_null_labels: false
    show_row_numbers: true
    height: 4
    width: 6
    top: 10
    left: 0
    
  - name: basket_size_by_month
    title: Basket Size by Month
    type: looker_line
    model: finery_data
    explore: spree_orders
    dimensions: [calendar_weeks.calendar_date_month]
    measures: [spree_orders.avg_gross_revenue_ex_discount_in_gbp_ex_vat]
    filters:
      calendar_weeks.calendar_date_date: after 2015/02/01
    sorts: [calendar_weeks.calendar_date_month]
    limit: 500
    column_limit: ''
    show_view_names: false
    stacking: ''
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: ordinal
    show_row_numbers: true
    show_null_points: true
    point_style: none
    interpolation: linear
    ordering: none
    show_null_labels: false
    height: 4
    width: 6
    top: 10
    left: 6

  - name: visits_by_month
    title: Visits by Month
    type: looker_column
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_month]
    measures: [sessions.count]
    filters:
      session_start_calendar.calendar_date_date: after 2015/02/01
    sorts: [session_start_calendar.calendar_date_month]
    limit: 500
    column_limit: ''
    stacking: ''
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: ordinal
    ordering: none
    show_null_labels: false
    hide_legend: false
    show_null_points: true
    point_style: circle
    interpolation: monotone
    show_dropoff: false
    height: 4
    width: 6
    top: 14
    left: 0
    
  - name: conversion_rate_by_month
    title: Conversion Rate by Month
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_month]
    measures: [sessions.conversion_rate]
    filters:
      session_start_calendar.calendar_date_date: after 2015/02/01
    sorts: [session_start_calendar.calendar_date_month]
    limit: 500
    column_limit: ''
    stacking: ''
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: ordinal
    hide_legend: false
    show_null_points: true
    point_style: circle
    interpolation: monotone
    ordering: none
    show_null_labels: false
    show_dropoff: false
    height: 4
    width: 6
    top: 14
    left: 6

  - name: traffic_split_last_week
    title: Traffic Split - Last Week
    type: looker_pie
    model: finery_data
    explore: sessions
    dimensions: [sessions.acquisition_channel]
    measures: [sessions.count]
    filters:
      session_start_calendar.calendar_date_date: last week
    sorts: [sessions.count desc]
    limit: 500
    column_limit: ''
    show_view_names: true
    value_labels: legend
    label_type: labPer
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    ordering: none
    show_null_labels: false
    height: 6
    width: 6
    top: 18
    left: 0

  - name: return_rate_by_week
    title: Return Rate by Week
    type: looker_line
    model: finery_data
    explore: spree_order_items
    dimensions: [calendar_weeks.year_week_number]
    measures: [spree_order_items.return_rate]
    filters:
      calendar_weeks.calendar_date_date: after 2015/02/02
      calendar_weeks.calendar_date_week: before 4 weeks ago
    sorts: [calendar_weeks.year_week_number]
    limit: 500
    column_limit: ''
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    show_null_points: true
    point_style: circle_outline
    interpolation: monotone
    ordering: none
    show_null_labels: false
    height: 6
    width: 6
    top: 18
    left: 6