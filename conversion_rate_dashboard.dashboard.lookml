- dashboard: conversion_rate_dashboard
  title: Conversion Rate Dashboard
  layout: static
  tile_size: 100

  filters:
  - name: date
    title: "Date"
    type: date_filter
    default_value: 8 weeks ago for 8 weeks

  - name: country
    title: "Country"
    type: field_filter
    explore: sessions
    field: sessions.geography_country
    default_value: 
  
  - name: traffic_source
    title: "Traffic Source"
    type: field_filter
    explore: sessions
    field: sessions.traffic_source
    default_value:
    
  - name: device
    title: "Device"
    type: field_filter
    explore: sessions
    field: sessions.device_type    
    default_value:

  elements:

################## CHANNEL SUMMARY ################################

## CR by Channel

  - name: conversion_rate_by_week
    title: Conversion Rate
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_week]
    measures: [sessions.conversion_rate]
    listen:
     date: session_start_calendar.calendar_date_week
     country: sessions.geography_country
     device: sessions.device_type
    sorts: [session_start_calendar.calendar_date_week]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#000000']
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    hidden_series: [Row Total]
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    top: 0
    left: 0
    height: 6
    width: 8

  - name: conversion_rate_by_channel
    title: Conversion Rate by Channel
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_week, sessions.traffic_source]
    pivots: [sessions.traffic_source]
    measures: [sessions.conversion_rate]
    listen:
     date: session_start_calendar.calendar_date_week
     country: sessions.geography_country
     device: sessions.device_type
    sorts: [session_start_calendar.calendar_date_week, sessions.traffic_source, sessions.traffic_source__sort_]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
      '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    hidden_series: [Row Total]
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    top: 0
    left: 8
    height: 6
    width: 8

## Prod CR by Channel

  - name: product_cr_by_week
    title: Product Conversion Rate
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_week]
    measures: [sessions.product_conversion_rate]
    listen:
     date: session_start_calendar.calendar_date_week
     country: sessions.geography_country
     device: sessions.device_type
    sorts: [session_start_calendar.calendar_date_week]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#000000']
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    hidden_series: [Row Total]
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    top: 6
    left: 0
    height: 6
    width: 8
    
  - name: product_cr_by_channel
    title: Product Conversion Rate by Channel
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_week, sessions.traffic_source]
    pivots: [sessions.traffic_source]
    measures: [sessions.product_conversion_rate]
    listen:
     date: session_start_calendar.calendar_date_week
     country: sessions.geography_country
     device: sessions.device_type
    sorts: [session_start_calendar.calendar_date_week, sessions.traffic_source, sessions.traffic_source__sort_]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
      '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    hidden_series: [Row Total]
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    top: 6
    left: 8
    height: 6
    width: 8

# Product View/Visit by Channel

  - name: prod_views_per_visit_by_week
    title: Product Views/Visit
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_week]
    measures: [sessions.product_views_per_visit]
    listen:
     date: session_start_calendar.calendar_date_week
     country: sessions.geography_country
     device: sessions.device_type
    sorts: [session_start_calendar.calendar_date_week, sessions.traffic_source]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#000000']
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    hidden_series: [Row Total]
    y_axis_combined: true
    y_axis_min: ['0.8']
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    top: 12
    left: 0
    height: 6
    width: 8
    
  - name: prod_views_per_visit_by_channel
    title: Product Views/Visit by Channel
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_week, sessions.traffic_source]
    pivots: [sessions.traffic_source]
    measures: [sessions.product_views_per_visit]
    listen:
     date: session_start_calendar.calendar_date_week
     country: sessions.geography_country
     device: sessions.device_type
    sorts: [session_start_calendar.calendar_date_week, sessions.traffic_source, sessions.traffic_source__sort_]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
      '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    hidden_series: [Row Total]
    y_axis_combined: true
    y_axis_min: ['0.8']
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    top: 12
    left: 8
    height: 6
    width: 8

## Traffic split by channel
  
  - name: traffic_split_by_channel
    title: Traffic Split by Channel
    type: looker_area
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_week, sessions.traffic_source]
    pivots: [sessions.traffic_source]
    measures: [sessions.count]
    listen:
     date: session_start_calendar.calendar_date_week
     country: sessions.geography_country
     device: sessions.device_type
    sorts: [session_start_calendar.calendar_date_week desc, sessions.traffic_source,
      sessions.traffic_source__sort_]
    limit: 500
    column_limit: 50
    stacking: percent
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
      '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_labels: ['% of Visits']
    y_axis_tick_density: default
    show_x_axis_label: true
    x_axis_label: Week
    show_x_axis_ticks: true
    x_axis_scale: auto
    point_style: none
    interpolation: linear
    top: 18
    left: 0
    height: 6
    width: 8


################## DEVICE SUMMARY################################

  - name: conversion_rate_by_week_2
    title: Conversion Rate
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_week]
    measures: [sessions.conversion_rate]
    filters:
      sessions.device_type: -Other/Unknown
    listen:
     date: session_start_calendar.calendar_date_week
     country: sessions.geography_country
     traffic_source: sessions.traffic_source
    sorts: [session_start_calendar.calendar_date_week]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#000000']
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    hidden_series: [Row Total]
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    top: 25
    left: 0
    height: 6
    width: 8

  - name: conversion_rate_by_device
    title: Conversion Rate by Device
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_week, sessions.device_type]
    pivots: [sessions.device_type]
    measures: [sessions.conversion_rate]
    filters:
      sessions.device_type: -Other/Unknown
    listen:
     date: session_start_calendar.calendar_date_week
     country: sessions.geography_country
     traffic_source: sessions.traffic_source
    sorts: [session_start_calendar.calendar_date_week, sessions.device_type, sessions.device_type__sort_]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
      '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    hidden_series: [Row Total]
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    top: 25
    left: 8
    height: 6
    width: 8

## Prod CR by device

  - name: product_cr_by_week_2
    title: Product Conversion Rate
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_week]
    measures: [sessions.product_conversion_rate]
    filters:
      sessions.device_type: -Other/Unknown
    listen:
     date: session_start_calendar.calendar_date_week
     country: sessions.geography_country
     traffic_source: sessions.traffic_source
    sorts: [session_start_calendar.calendar_date_week]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#000000']
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    hidden_series: [Row Total]
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    top: 31
    left: 0
    height: 6
    width: 8
    
  - name: product_cr_by_device
    title: Product Conversion Rate by Device
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_week, sessions.device_type]
    pivots: [sessions.device_type]
    measures: [sessions.product_conversion_rate]
    filters:
      sessions.device_type: -Other/Unknown
    listen:
     date: session_start_calendar.calendar_date_week
     country: sessions.geography_country
     traffic_source: sessions.traffic_source
    sorts: [session_start_calendar.calendar_date_week, sessions.device_type, sessions.device_type__sort_]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
      '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    hidden_series: [Row Total]
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    top: 31
    left: 8
    height: 6
    width: 8

# Product View/Visit by device

  - name: prod_views_per_visit_by_week_2
    title: Product Views/Visit
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_week]
    measures: [sessions.product_views_per_visit]
    filters:
      sessions.device_type: -Other/Unknown
    listen:
     date: session_start_calendar.calendar_date_week
     country: sessions.geography_country
     traffic_source: sessions.traffic_source
    sorts: [session_start_calendar.calendar_date_week, sessions.device_type]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#000000']
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    hidden_series: [Row Total]
    y_axis_combined: true
    y_axis_min: ['0.8']
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    top: 37
    left: 0
    height: 6
    width: 8
    
  - name: prod_views_per_visit_by_device
    title: Product Views/Visit by Device
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_week, sessions.device_type]
    pivots: [sessions.device_type]
    measures: [sessions.product_views_per_visit]
    filters:
      sessions.device_type: -Other/Unknown
    listen:
     date: session_start_calendar.calendar_date_week
     country: sessions.geography_country
     traffic_source: sessions.traffic_source
    sorts: [session_start_calendar.calendar_date_week, sessions.device_type, sessions.device_type__sort_]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
      '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    hidden_series: [Row Total]
    y_axis_combined: true
    y_axis_min: ['0.8']
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    top: 37
    left: 8
    height: 6
    width: 8

## Traffic split by device
  
  - name: traffic_split_by_device
    title: Traffic Split by Device
    type: looker_area
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_week, sessions.device_type]
    pivots: [sessions.device_type]
    measures: [sessions.count]
    filters:
      sessions.device_type: -Other/Unknown
    listen:
     date: session_start_calendar.calendar_date_week
     country: sessions.geography_country
     traffic_source: sessions.traffic_source
    sorts: [session_start_calendar.calendar_date_week desc, sessions.device_type,
      sessions.device_type__sort_]
    limit: 500
    column_limit: 50
    stacking: percent
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
      '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_labels: ['% of Visits']
    y_axis_tick_density: default
    show_x_axis_label: true
    x_axis_label: Week
    show_x_axis_ticks: true
    x_axis_scale: auto
    point_style: none
    interpolation: linear
    top: 43
    left: 0
    height: 6
    width: 8
    
########### DROPOUT RATES ########################

  - name: dropout_rate_1
    title: Dropout Rate 1 (Before Category Page)
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_week]
    measures: [sessions.count, sessions.conversion_funnel_2]
    dynamic_fields:
    - table_calculation: dropout_rate_1_before_category_page
      label: Dropout Rate 1 - Before Category Page
      expression: (${sessions.count}-${sessions.conversion_funnel_2})/${sessions.count}
      value_format_name: percent_1
    hidden_fields: [sessions.count, sessions.conversion_funnel_2]
    listen:
     date: session_start_calendar.calendar_date_week
     country: sessions.geography_country
     traffic_source: sessions.traffic_source
     device: sessions.device_type
    sorts: [session_start_calendar.calendar_date_week desc]
    colors: ['#000000']
    limit: 500
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_value_format: '#%'
    show_x_axis_label: true
    x_axis_label: Date
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    top: 50
    left: 0
    height: 4
    width: 8

  - name: dropout_rate_2
    title: Dropout Rate 2 (Category Page)
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_week]
    measures: [sessions.conversion_funnel_3, sessions.conversion_funnel_2]
    dynamic_fields:
    - table_calculation: dropout_rate_2_category_page
      label: Dropout Rate 2 - Category Page
      expression: (${sessions.conversion_funnel_2}-${sessions.conversion_funnel_3})/${sessions.conversion_funnel_2}
      value_format_name: percent_1
    hidden_fields: [sessions.conversion_funnel_2, sessions.conversion_funnel_3]
    listen:
     date: session_start_calendar.calendar_date_week
     country: sessions.geography_country
     traffic_source: sessions.traffic_source
     device: sessions.device_type
    sorts: [session_start_calendar.calendar_date_week desc]
    colors: ['#000000']
    limit: 500
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_value_format: '#%'
    show_x_axis_label: true
    x_axis_label: Date
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    top: 50
    left: 8
    height: 4
    width: 8

  - name: dropout_rate_3
    title: Dropout Rate 3 (Product Page)
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_week]
    measures: [sessions.conversion_funnel_3, sessions.conversion_funnel_4]
    dynamic_fields:
    - table_calculation: dropout_rate_3_product_page
      label: Dropout Rate 3 - Product Page
      expression: (${sessions.conversion_funnel_3}-${sessions.conversion_funnel_4})/${sessions.conversion_funnel_3}
      value_format_name: percent_1
    hidden_fields: [sessions.conversion_funnel_3, sessions.conversion_funnel_4]
    listen:
     date: session_start_calendar.calendar_date_week
     country: sessions.geography_country
     traffic_source: sessions.traffic_source
     device: sessions.device_type
    colors: ['#000000']
    sorts: [session_start_calendar.calendar_date_week desc]
    limit: 500
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_value_format: '#%'
    show_x_axis_label: true
    x_axis_label: Date
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    top: 54
    left: 0
    height: 4
    width: 8

  - name: dropout_rate_4
    title: Dropout Rate 4 (Add to Cart)
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_week]
    measures: [sessions.conversion_funnel_4, sessions.conversion_funnel_5]
    dynamic_fields:
    - table_calculation: dropout_rate_4_add_to_cart
      label: Dropout Rate 4 - Add to Cart
      expression: (${sessions.conversion_funnel_4}-${sessions.conversion_funnel_5})/${sessions.conversion_funnel_4}
      value_format_name: percent_1
    hidden_fields: [sessions.conversion_funnel_4, sessions.conversion_funnel_5]
    listen:
     date: session_start_calendar.calendar_date_week
     country: sessions.geography_country
     traffic_source: sessions.traffic_source
     device: sessions.device_type
    colors: ['#000000']
    sorts: [session_start_calendar.calendar_date_week desc]
    limit: 500
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_value_format: '#%'
    show_x_axis_label: true
    x_axis_label: Date
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    top: 54
    left: 8
    height: 4
    width: 8

  - name: dropout_rate_5
    title: Dropout Rate 5 (View Cart)
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_week]
    measures: [sessions.conversion_funnel_5, sessions.conversion_funnel_6]
    dynamic_fields:
    - table_calculation: dropout_rate_5_view_cart
      label: Dropout Rate 5 - View Cart
      expression: (${sessions.conversion_funnel_5}-${sessions.conversion_funnel_6})/${sessions.conversion_funnel_5}
      value_format_name: percent_1
    hidden_fields: [sessions.conversion_funnel_5, sessions.conversion_funnel_6]
    listen:
     date: session_start_calendar.calendar_date_week
     country: sessions.geography_country
     traffic_source: sessions.traffic_source
     device: sessions.device_type
    colors: ['#000000']
    sorts: [session_start_calendar.calendar_date_week desc]
    limit: 500
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_value_format: '#%'
    show_x_axis_label: true
    x_axis_label: Date
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    top: 58
    left: 0
    height: 4
    width: 8

  - name: dropout_rate_6
    title: Dropout Rate 6 (Checkout - Registration)
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_week]
    measures: [sessions.conversion_funnel_6, sessions.conversion_funnel_7]
    dynamic_fields:
    - table_calculation: dropout_rate_6_checkout_reg
      label: Dropout Rate 6 - Checkout - Registration
      expression: (${sessions.conversion_funnel_6}-${sessions.conversion_funnel_7})/${sessions.conversion_funnel_6}
      value_format_name: percent_1
    hidden_fields: [sessions.conversion_funnel_6, sessions.conversion_funnel_7]
    listen:
     date: session_start_calendar.calendar_date_week
     country: sessions.geography_country
     traffic_source: sessions.traffic_source
     device: sessions.device_type
    colors: ['#000000']
    sorts: [session_start_calendar.calendar_date_week desc]
    limit: 500
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_value_format: '#%'
    show_x_axis_label: true
    x_axis_label: Date
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    top: 58
    left: 8
    height: 4
    width: 8
    
  - name: dropout_rate_7
    title: Dropout Rate 7 (Checkout - Address)
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_week]
    measures: [sessions.conversion_funnel_7, sessions.conversion_funnel_8]
    dynamic_fields:
    - table_calculation: dropout_rate_7_checkout_add
      label: Dropout Rate 7 - Checkout - Address
      expression: (${sessions.conversion_funnel_7}-${sessions.conversion_funnel_8})/${sessions.conversion_funnel_7}
      value_format_name: percent_1
    hidden_fields: [sessions.conversion_funnel_7, sessions.conversion_funnel_8]
    listen:
     date: session_start_calendar.calendar_date_week
     country: sessions.geography_country
     traffic_source: sessions.traffic_source
     device: sessions.device_type
    colors: ['#000000']
    sorts: [session_start_calendar.calendar_date_week desc]
    limit: 500
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_value_format: '#%'
    show_x_axis_label: true
    x_axis_label: Date
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    top: 62
    left: 0
    height: 4
    width: 8

  - name: dropout_rate_8
    title: Dropout Rate 8 (Checkout - Delivery)
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_week]
    measures: [sessions.conversion_funnel_8, sessions.conversion_funnel_9]
    dynamic_fields:
    - table_calculation: dropout_rate_8_checkout_del
      label: Dropout Rate 8 - Checkout - Delivery
      expression: (${sessions.conversion_funnel_8}-${sessions.conversion_funnel_9})/${sessions.conversion_funnel_8}
      value_format_name: percent_1
    hidden_fields: [sessions.conversion_funnel_8, sessions.conversion_funnel_9]
    listen:
     date: session_start_calendar.calendar_date_week
     country: sessions.geography_country
     traffic_source: sessions.traffic_source
     device: sessions.device_type
    colors: ['#000000']
    sorts: [session_start_calendar.calendar_date_week desc]
    limit: 500
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_value_format: '#%'
    show_x_axis_label: true
    x_axis_label: Date
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    top: 62
    left: 8
    height: 4
    width: 8

  - name: dropout_rate_9
    title: Dropout Rate 9 (Checkout - Payment)
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_week]
    measures: [sessions.conversion_funnel_9, sessions.conversion_funnel_10]
    dynamic_fields:
    - table_calculation: dropout_rate_9_checkout_pay
      label: Dropout Rate 9 - Checkout - Payment
      expression: (${sessions.conversion_funnel_9}-${sessions.conversion_funnel_10})/${sessions.conversion_funnel_9}
      value_format_name: percent_1
    hidden_fields: [sessions.conversion_funnel_9, sessions.conversion_funnel_10]
    listen:
     date: session_start_calendar.calendar_date_week
     country: sessions.geography_country
     traffic_source: sessions.traffic_source
     device: sessions.device_type
    colors: ['#000000']
    sorts: [session_start_calendar.calendar_date_week desc]
    limit: 500
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_value_format: '#%'
    show_x_axis_label: true
    x_axis_label: Date
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    top: 66
    left: 0
    height: 4
    width: 8
    
########### DROPOUT RATES BY CHANNEL########################

  - name: dropout_rate_1_by_channel
    title: Dropout Rate 1 (Before Category Page) - by Channel
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_week, sessions.traffic_source]
    measures: [sessions.count, sessions.conversion_funnel_2]
    pivots: [sessions.traffic_source]
    dynamic_fields:
    - table_calculation: dropout_rate_1_before_category_page
      label: Dropout Rate 1 - Before Category Page
      expression: (${sessions.count}-${sessions.conversion_funnel_2})/${sessions.count}
      value_format_name: percent_1
    hidden_fields: [sessions.count, sessions.conversion_funnel_2]
    listen:
     date: session_start_calendar.calendar_date_week
     country: sessions.geography_country
     device: sessions.device_type
    sorts: [session_start_calendar.calendar_date_week desc]
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
      '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    limit: 500
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_value_format: '#%'
    show_x_axis_label: true
    x_axis_label: Date
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    top: 71
    left: 0
    height: 4
    width: 8

  - name: dropout_rate_2_by_channel
    title: Dropout Rate 2 (Category Page) - by Channel
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_week, sessions.traffic_source]
    measures: [sessions.conversion_funnel_3, sessions.conversion_funnel_2]
    pivots: [sessions.traffic_source]
    dynamic_fields:
    - table_calculation: dropout_rate_2_category_page
      label: Dropout Rate 2 - Category Page
      expression: (${sessions.conversion_funnel_2}-${sessions.conversion_funnel_3})/${sessions.conversion_funnel_2}
      value_format_name: percent_1
    hidden_fields: [sessions.conversion_funnel_2, sessions.conversion_funnel_3]
    listen:
     date: session_start_calendar.calendar_date_week
     country: sessions.geography_country
     device: sessions.device_type
    sorts: [session_start_calendar.calendar_date_week desc]
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
      '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    limit: 500
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_value_format: '#%'
    show_x_axis_label: true
    x_axis_label: Date
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    top: 71
    left: 8
    height: 4
    width: 8

  - name: dropout_rate_3_by_channel
    title: Dropout Rate 3 (Product Page) - by Channel
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_week, sessions.traffic_source]
    measures: [sessions.conversion_funnel_3, sessions.conversion_funnel_4]
    pivots: [sessions.traffic_source]
    dynamic_fields:
    - table_calculation: dropout_rate_3_product_page
      label: Dropout Rate 3 - Product Page
      expression: (${sessions.conversion_funnel_3}-${sessions.conversion_funnel_4})/${sessions.conversion_funnel_3}
      value_format_name: percent_1
    hidden_fields: [sessions.conversion_funnel_3, sessions.conversion_funnel_4]
    listen:
     date: session_start_calendar.calendar_date_week
     country: sessions.geography_country
     device: sessions.device_type
    sorts: [session_start_calendar.calendar_date_week desc]
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
      '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    limit: 500
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_value_format: '#%'
    show_x_axis_label: true
    x_axis_label: Date
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    top: 75
    left: 0
    height: 4
    width: 8

  - name: dropout_rate_4_by_channel
    title: Dropout Rate 4 (Add to Cart) - by Channel
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_week, sessions.traffic_source]
    measures: [sessions.conversion_funnel_4, sessions.conversion_funnel_5]
    pivots: [sessions.traffic_source]
    dynamic_fields:
    - table_calculation: dropout_rate_4_add_to_cart
      label: Dropout Rate 4 - Add to Cart
      expression: (${sessions.conversion_funnel_4}-${sessions.conversion_funnel_5})/${sessions.conversion_funnel_4}
      value_format_name: percent_1
    hidden_fields: [sessions.conversion_funnel_4, sessions.conversion_funnel_5]
    listen:
     date: session_start_calendar.calendar_date_week
     country: sessions.geography_country
     device: sessions.device_type
    sorts: [session_start_calendar.calendar_date_week desc]
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
      '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    limit: 500
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_value_format: '#%'
    show_x_axis_label: true
    x_axis_label: Date
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    top: 75
    left: 8
    height: 4
    width: 8

  - name: dropout_rate_5_by_channel
    title: Dropout Rate 5 (View Cart) - by Channel
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_week, sessions.traffic_source]
    measures: [sessions.conversion_funnel_5, sessions.conversion_funnel_6]
    pivots: [sessions.traffic_source]
    dynamic_fields:
    - table_calculation: dropout_rate_5_view_cart
      label: Dropout Rate 5 - View Cart
      expression: (${sessions.conversion_funnel_5}-${sessions.conversion_funnel_6})/${sessions.conversion_funnel_5}
      value_format_name: percent_1
    hidden_fields: [sessions.conversion_funnel_5, sessions.conversion_funnel_6]
    listen:
     date: session_start_calendar.calendar_date_week
     country: sessions.geography_country
     device: sessions.device_type
    sorts: [session_start_calendar.calendar_date_week desc]
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
      '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    limit: 500
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_value_format: '#%'
    show_x_axis_label: true
    x_axis_label: Date
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    top: 79
    left: 0
    height: 4
    width: 8

  - name: dropout_rate_6_by_channel
    title: Dropout Rate 6 (Checkout - Registration) - by Channel
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_week, sessions.traffic_source]
    measures: [sessions.conversion_funnel_6, sessions.conversion_funnel_7]
    pivots: [sessions.traffic_source]
    dynamic_fields:
    - table_calculation: dropout_rate_6_checkout_reg
      label: Dropout Rate 6 - Checkout - Registration
      expression: (${sessions.conversion_funnel_6}-${sessions.conversion_funnel_7})/${sessions.conversion_funnel_6}
      value_format_name: percent_1
    hidden_fields: [sessions.conversion_funnel_6, sessions.conversion_funnel_7]
    listen:
     date: session_start_calendar.calendar_date_week
     country: sessions.geography_country
     device: sessions.device_type
    sorts: [session_start_calendar.calendar_date_week desc]
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
      '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    limit: 500
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_value_format: '#%'
    show_x_axis_label: true
    x_axis_label: Date
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    top: 79
    left: 8
    height: 4
    width: 8
    
  - name: dropout_rate_7_by_channel
    title: Dropout Rate 7 (Checkout - Address) - by Channel
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_week, sessions.traffic_source]
    measures: [sessions.conversion_funnel_7, sessions.conversion_funnel_8]
    pivots: [sessions.traffic_source]
    dynamic_fields:
    - table_calculation: dropout_rate_7_checkout_add
      label: Dropout Rate 7 - Checkout - Address
      expression: (${sessions.conversion_funnel_7}-${sessions.conversion_funnel_8})/${sessions.conversion_funnel_7}
      value_format_name: percent_1
    hidden_fields: [sessions.conversion_funnel_7, sessions.conversion_funnel_8]
    listen:
     date: session_start_calendar.calendar_date_week
     country: sessions.geography_country
     device: sessions.device_type
    sorts: [session_start_calendar.calendar_date_week desc]
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
      '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    limit: 500
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_value_format: '#%'
    show_x_axis_label: true
    x_axis_label: Date
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    top: 83
    left: 0
    height: 4
    width: 8

  - name: dropout_rate_8_by_channel
    title: Dropout Rate 8 (Checkout - Delivery) - by Channel
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_week, sessions.traffic_source]
    measures: [sessions.conversion_funnel_8, sessions.conversion_funnel_9]
    pivots: [sessions.traffic_source]
    dynamic_fields:
    - table_calculation: dropout_rate_8_checkout_del
      label: Dropout Rate 8 - Checkout - Delivery
      expression: (${sessions.conversion_funnel_8}-${sessions.conversion_funnel_9})/${sessions.conversion_funnel_8}
      value_format_name: percent_1
    hidden_fields: [sessions.conversion_funnel_8, sessions.conversion_funnel_9]
    listen:
     date: session_start_calendar.calendar_date_week
     country: sessions.geography_country
     device: sessions.device_type
    sorts: [session_start_calendar.calendar_date_week desc]
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
      '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    limit: 500
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_value_format: '#%'
    show_x_axis_label: true
    x_axis_label: Date
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    top: 83
    left: 8
    height: 4
    width: 8

  - name: dropout_rate_9_by_channel
    title: Dropout Rate 9 (Checkout - Payment) - by Channel
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_week, sessions.traffic_source]
    measures: [sessions.conversion_funnel_9, sessions.conversion_funnel_10]
    pivots: [sessions.traffic_source]
    dynamic_fields:
    - table_calculation: dropout_rate_9_checkout_pay
      label: Dropout Rate 9 - Checkout - Payment
      expression: (${sessions.conversion_funnel_9}-${sessions.conversion_funnel_10})/${sessions.conversion_funnel_9}
      value_format_name: percent_1
    hidden_fields: [sessions.conversion_funnel_9, sessions.conversion_funnel_10]
    listen:
     date: session_start_calendar.calendar_date_week
     country: sessions.geography_country
     device: sessions.device_type
    sorts: [session_start_calendar.calendar_date_week desc]
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
      '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    limit: 500
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_value_format: '#%'
    show_x_axis_label: true
    x_axis_label: Date
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    top: 87
    left: 0
    height: 4
    width: 8
    
########### DROPOUT RATES BY DEVICE########################

  - name: dropout_rate_1_by_device
    title: Dropout Rate 1 (Before Category Page) - by Device
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_week, sessions.device_type]
    measures: [sessions.count, sessions.conversion_funnel_2]
    pivots: [sessions.device_type]
    dynamic_fields:
    - table_calculation: dropout_rate_1_before_category_page
      label: Dropout Rate 1 - Before Category Page
      expression: (${sessions.count}-${sessions.conversion_funnel_2})/${sessions.count}
      value_format_name: percent_1
    hidden_fields: [sessions.count, sessions.conversion_funnel_2]
    filters:
      sessions.device_type: -Other/Unknown
    listen:
     date: session_start_calendar.calendar_date_week
     country: sessions.geography_country
     traffic_source: sessions.traffic_source
    sorts: [session_start_calendar.calendar_date_week desc]
    limit: 500
    stacking: ''
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
      '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_value_format: '#%'
    show_x_axis_label: true
    x_axis_label: Date
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    top: 92
    left: 0
    height: 4
    width: 8

  - name: dropout_rate_2_by_device
    title: Dropout Rate 2 (Category Page) - by Device
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_week, sessions.device_type]
    measures: [sessions.conversion_funnel_3, sessions.conversion_funnel_2]
    pivots: [sessions.device_type]
    dynamic_fields:
    - table_calculation: dropout_rate_2_category_page
      label: Dropout Rate 2 - Category Page
      expression: (${sessions.conversion_funnel_2}-${sessions.conversion_funnel_3})/${sessions.conversion_funnel_2}
      value_format_name: percent_1
    hidden_fields: [sessions.conversion_funnel_2, sessions.conversion_funnel_3]
    filters:
      sessions.device_type: -Other/Unknown
    listen:
     date: session_start_calendar.calendar_date_week
     country: sessions.geography_country
     traffic_source: sessions.traffic_source
    sorts: [session_start_calendar.calendar_date_week desc]
    limit: 500
    stacking: ''
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
      '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_value_format: '#%'
    show_x_axis_label: true
    x_axis_label: Date
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    top: 92
    left: 8
    height: 4
    width: 8

  - name: dropout_rate_3_by_device
    title: Dropout Rate 3 (Product Page) - by Device
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_week, sessions.device_type]
    measures: [sessions.conversion_funnel_3, sessions.conversion_funnel_4]
    pivots: [sessions.device_type]
    dynamic_fields:
    - table_calculation: dropout_rate_3_product_page
      label: Dropout Rate 3 - Product Page
      expression: (${sessions.conversion_funnel_3}-${sessions.conversion_funnel_4})/${sessions.conversion_funnel_3}
      value_format_name: percent_1
    hidden_fields: [sessions.conversion_funnel_3, sessions.conversion_funnel_4]
    filters:
      sessions.device_type: -Other/Unknown
    listen:
     date: session_start_calendar.calendar_date_week
     country: sessions.geography_country
     traffic_source: sessions.traffic_source
    sorts: [session_start_calendar.calendar_date_week desc]
    limit: 500
    stacking: ''
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
      '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_value_format: '#%'
    show_x_axis_label: true
    x_axis_label: Date
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    top: 96
    left: 0
    height: 4
    width: 8

  - name: dropout_rate_4_by_device
    title: Dropout Rate 4 (Add to Cart) - by Device
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_week, sessions.device_type]
    measures: [sessions.conversion_funnel_4, sessions.conversion_funnel_5]
    pivots: [sessions.device_type]
    dynamic_fields:
    - table_calculation: dropout_rate_4_add_to_cart
      label: Dropout Rate 4 - Add to Cart
      expression: (${sessions.conversion_funnel_4}-${sessions.conversion_funnel_5})/${sessions.conversion_funnel_4}
      value_format_name: percent_1
    hidden_fields: [sessions.conversion_funnel_4, sessions.conversion_funnel_5]
    filters:
      sessions.device_type: -Other/Unknown
    listen:
     date: session_start_calendar.calendar_date_week
     country: sessions.geography_country
     traffic_source: sessions.traffic_source
    sorts: [session_start_calendar.calendar_date_week desc]
    limit: 500
    stacking: ''
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
      '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_value_format: '#%'
    show_x_axis_label: true
    x_axis_label: Date
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    top: 96
    left: 8
    height: 4
    width: 8

  - name: dropout_rate_5_by_device
    title: Dropout Rate 5 (View Cart) - by Device
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_week, sessions.device_type]
    measures: [sessions.conversion_funnel_5, sessions.conversion_funnel_6]
    pivots: [sessions.device_type]
    dynamic_fields:
    - table_calculation: dropout_rate_5_view_cart
      label: Dropout Rate 5 - View Cart
      expression: (${sessions.conversion_funnel_5}-${sessions.conversion_funnel_6})/${sessions.conversion_funnel_5}
      value_format_name: percent_1
    hidden_fields: [sessions.conversion_funnel_5, sessions.conversion_funnel_6]
    filters:
      sessions.device_type: -Other/Unknown
    listen:
     date: session_start_calendar.calendar_date_week
     country: sessions.geography_country
     traffic_source: sessions.traffic_source
    sorts: [session_start_calendar.calendar_date_week desc]
    limit: 500
    stacking: ''
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
      '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_value_format: '#%'
    show_x_axis_label: true
    x_axis_label: Date
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    top: 100
    left: 0
    height: 4
    width: 8

  - name: dropout_rate_6_by_device
    title: Dropout Rate 6 (Checkout - Registration) - by Device
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_week, sessions.device_type]
    measures: [sessions.conversion_funnel_6, sessions.conversion_funnel_7]
    pivots: [sessions.device_type]
    dynamic_fields:
    - table_calculation: dropout_rate_6_checkout_reg
      label: Dropout Rate 6 - Checkout - Registration
      expression: (${sessions.conversion_funnel_6}-${sessions.conversion_funnel_7})/${sessions.conversion_funnel_6}
      value_format_name: percent_1
    hidden_fields: [sessions.conversion_funnel_6, sessions.conversion_funnel_7]
    filters:
      sessions.device_type: -Other/Unknown
    listen:
     date: session_start_calendar.calendar_date_week
     country: sessions.geography_country
     traffic_source: sessions.traffic_source
    sorts: [session_start_calendar.calendar_date_week desc]
    limit: 500
    stacking: ''
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
      '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_value_format: '#%'
    show_x_axis_label: true
    x_axis_label: Date
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    top: 100
    left: 8
    height: 4
    width: 8
    
  - name: dropout_rate_7_by_device
    title: Dropout Rate 7 (Checkout - Address) - by Device
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_week, sessions.device_type]
    measures: [sessions.conversion_funnel_7, sessions.conversion_funnel_8]
    pivots: [sessions.device_type]
    dynamic_fields:
    - table_calculation: dropout_rate_7_checkout_add
      label: Dropout Rate 7 - Checkout - Address
      expression: (${sessions.conversion_funnel_7}-${sessions.conversion_funnel_8})/${sessions.conversion_funnel_7}
      value_format_name: percent_1
    hidden_fields: [sessions.conversion_funnel_7, sessions.conversion_funnel_8]
    filters:
      sessions.device_type: -Other/Unknown
    listen:
     date: session_start_calendar.calendar_date_week
     country: sessions.geography_country
     traffic_source: sessions.traffic_source
    sorts: [session_start_calendar.calendar_date_week desc]
    limit: 500
    stacking: ''
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
      '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_value_format: '#%'
    show_x_axis_label: true
    x_axis_label: Date
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    top: 104
    left: 0
    height: 4
    width: 8

  - name: dropout_rate_8_by_device
    title: Dropout Rate 8 (Checkout - Delivery) - by Device
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_week, sessions.device_type]
    measures: [sessions.conversion_funnel_8, sessions.conversion_funnel_9]
    pivots: [sessions.device_type]
    dynamic_fields:
    - table_calculation: dropout_rate_8_checkout_del
      label: Dropout Rate 8 - Checkout - Delivery
      expression: (${sessions.conversion_funnel_8}-${sessions.conversion_funnel_9})/${sessions.conversion_funnel_8}
      value_format_name: percent_1
    hidden_fields: [sessions.conversion_funnel_8, sessions.conversion_funnel_9]
    filters:
      sessions.device_type: -Other/Unknown
    listen:
     date: session_start_calendar.calendar_date_week
     country: sessions.geography_country
     traffic_source: sessions.traffic_source
    sorts: [session_start_calendar.calendar_date_week desc]
    limit: 500
    stacking: ''
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
      '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_value_format: '#%'
    show_x_axis_label: true
    x_axis_label: Date
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    top: 104
    left: 8
    height: 4
    width: 8

  - name: dropout_rate_9_by_device
    title: Dropout Rate 9 (Checkout - Payment) - by Device
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_week, sessions.device_type]
    measures: [sessions.conversion_funnel_9, sessions.conversion_funnel_10]
    pivots: [sessions.device_type]
    dynamic_fields:
    - table_calculation: dropout_rate_9_checkout_pay
      label: Dropout Rate 9 - Checkout - Payment
      expression: (${sessions.conversion_funnel_9}-${sessions.conversion_funnel_10})/${sessions.conversion_funnel_9}
      value_format_name: percent_1
    hidden_fields: [sessions.conversion_funnel_9, sessions.conversion_funnel_10]
    filters:
      sessions.device_type: -Other/Unknown
    listen:
     date: session_start_calendar.calendar_date_week
     country: sessions.geography_country
     traffic_source: sessions.traffic_source
    sorts: [session_start_calendar.calendar_date_week desc]
    limit: 500
    stacking: ''
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
      '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_value_format: '#%'
    show_x_axis_label: true
    x_axis_label: Date
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    top: 108
    left: 0
    height: 4
    width: 8