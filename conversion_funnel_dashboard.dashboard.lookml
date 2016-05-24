- dashboard: conversion_funnel_dashboard
  title: Conversion Funnel Dashboard
  layout: static
  tile_size: 100

  filters:
  - name: date
    title: "Date"
    type: date_filter
    default_value: 30 days ago for 30 days

  - name: country
    title: "Country"
    type: field_filter
    explore: sessions
    field: sessions.geography_country
    default_value: 
  
  - name: acquisition
    title: "Acquisition"
    type: field_filter
    explore: sessions
    field: sessions.acquisition_channel
    default_value:
    
  - name: device
    title: "Device"
    type: field_filter
    explore: sessions
    field: sessions.device_type    
    default_value:
    
  elements:

  - name: conversion_rate
    title: Conversion Rate
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_date]
    measures: [sessions.conversion_rate]
    listen:
     date: session_start_calendar.calendar_date_date
     country: sessions.geography_country
     acquisition: sessions.acquisition_channel
     device: sessions.device_type
    sorts: [session_start_calendar.calendar_date_date desc]
    limit: 500
    stacking: ''
    colors: ['#F16358']
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
    y_axis_value_format: '#.0%'
    show_x_axis_label: true
    x_axis_label: Date
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    top: 0
    left: 0
    height: 4
    width: 12

  - name: dropout_rate_1
    title: Dropout Rate 1 (Before Category Page)
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_date]
    measures: [sessions.count, sessions.conversion_funnel_2]
    dynamic_fields:
    - table_calculation: dropout_rate_1_before_category_page
      label: Dropout Rate 1 - Before Category Page
      expression: (${sessions.count}-${sessions.conversion_funnel_2})/${sessions.count}
      value_format_name: percent_1
    hidden_fields: [sessions.count, sessions.conversion_funnel_2]
    listen:
     date: session_start_calendar.calendar_date_date
     country: sessions.geography_country
     acquisition: sessions.acquisition_channel
     device: sessions.device_type
    sorts: [session_start_calendar.calendar_date_date desc]
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
    top: 4
    left: 0
    height: 4
    width: 6

  - name: dropout_rate_2
    title: Dropout Rate 2 (Category Page)
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_date]
    measures: [sessions.conversion_funnel_3, sessions.conversion_funnel_2]
    dynamic_fields:
    - table_calculation: dropout_rate_2_category_page
      label: Dropout Rate 2 - Category Page
      expression: (${sessions.conversion_funnel_2}-${sessions.conversion_funnel_3})/${sessions.conversion_funnel_2}
      value_format_name: percent_1
    hidden_fields: [sessions.conversion_funnel_2, sessions.conversion_funnel_3]
    listen:
     date: session_start_calendar.calendar_date_date
     country: sessions.geography_country
     acquisition: sessions.acquisition_channel
     device: sessions.device_type
    sorts: [session_start_calendar.calendar_date_date desc]
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
    top: 4
    left: 6
    height: 4
    width: 6

  - name: dropout_rate_3
    title: Dropout Rate 3 (Product Page)
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_date]
    measures: [sessions.conversion_funnel_3, sessions.conversion_funnel_4]
    dynamic_fields:
    - table_calculation: dropout_rate_3_product_page
      label: Dropout Rate 3 - Product Page
      expression: (${sessions.conversion_funnel_3}-${sessions.conversion_funnel_4})/${sessions.conversion_funnel_3}
      value_format_name: percent_1
    hidden_fields: [sessions.conversion_funnel_3, sessions.conversion_funnel_4]
    listen:
     date: session_start_calendar.calendar_date_date
     country: sessions.geography_country
     acquisition: sessions.acquisition_channel
     device: sessions.device_type
    sorts: [session_start_calendar.calendar_date_date desc]
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
    top: 8
    left: 0
    height: 4
    width: 6

  - name: dropout_rate_4
    title: Dropout Rate 4 (Add to Cart)
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_date]
    measures: [sessions.conversion_funnel_4, sessions.conversion_funnel_5]
    dynamic_fields:
    - table_calculation: dropout_rate_4_add_to_cart
      label: Dropout Rate 4 - Add to Cart
      expression: (${sessions.conversion_funnel_4}-${sessions.conversion_funnel_5})/${sessions.conversion_funnel_4}
      value_format_name: percent_1
    hidden_fields: [sessions.conversion_funnel_4, sessions.conversion_funnel_5]
    listen:
     date: session_start_calendar.calendar_date_date
     country: sessions.geography_country
     acquisition: sessions.acquisition_channel
     device: sessions.device_type
    sorts: [session_start_calendar.calendar_date_date desc]
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
    top: 8
    left: 6
    height: 4
    width: 6

  - name: dropout_rate_5
    title: Dropout Rate 5 (View Cart)
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_date]
    measures: [sessions.conversion_funnel_5, sessions.conversion_funnel_6]
    dynamic_fields:
    - table_calculation: dropout_rate_5_view_cart
      label: Dropout Rate 5 - View Cart
      expression: (${sessions.conversion_funnel_5}-${sessions.conversion_funnel_6})/${sessions.conversion_funnel_5}
      value_format_name: percent_1
    hidden_fields: [sessions.conversion_funnel_5, sessions.conversion_funnel_6]
    listen:
     date: session_start_calendar.calendar_date_date
     country: sessions.geography_country
     acquisition: sessions.acquisition_channel
     device: sessions.device_type
    sorts: [session_start_calendar.calendar_date_date desc]
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
    top: 12
    left: 0
    height: 4
    width: 6

  - name: dropout_rate_6
    title: Dropout Rate 6 (Checkout - Registration)
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_date]
    measures: [sessions.conversion_funnel_6, sessions.conversion_funnel_7]
    dynamic_fields:
    - table_calculation: dropout_rate_6_checkout_reg
      label: Dropout Rate 6 - Checkout - Registration
      expression: (${sessions.conversion_funnel_6}-${sessions.conversion_funnel_7})/${sessions.conversion_funnel_6}
      value_format_name: percent_1
    hidden_fields: [sessions.conversion_funnel_6, sessions.conversion_funnel_7]
    listen:
     date: session_start_calendar.calendar_date_date
     country: sessions.geography_country
     acquisition: sessions.acquisition_channel
     device: sessions.device_type
    sorts: [session_start_calendar.calendar_date_date desc]
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
    top: 12
    left: 6
    height: 4
    width: 6
    
  - name: dropout_rate_7
    title: Dropout Rate 7 (Checkout - Address)
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_date]
    measures: [sessions.conversion_funnel_7, sessions.conversion_funnel_8]
    dynamic_fields:
    - table_calculation: dropout_rate_7_checkout_add
      label: Dropout Rate 7 - Checkout - Address
      expression: (${sessions.conversion_funnel_7}-${sessions.conversion_funnel_8})/${sessions.conversion_funnel_7}
      value_format_name: percent_1
    hidden_fields: [sessions.conversion_funnel_7, sessions.conversion_funnel_8]
    listen:
     date: session_start_calendar.calendar_date_date
     country: sessions.geography_country
     acquisition: sessions.acquisition_channel
     device: sessions.device_type
    sorts: [session_start_calendar.calendar_date_date desc]
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
    top: 16
    left: 0
    height: 4
    width: 6

  - name: dropout_rate_8
    title: Dropout Rate 8 (Checkout - Delivery)
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_date]
    measures: [sessions.conversion_funnel_8, sessions.conversion_funnel_9]
    dynamic_fields:
    - table_calculation: dropout_rate_8_checkout_del
      label: Dropout Rate 8 - Checkout - Delivery
      expression: (${sessions.conversion_funnel_8}-${sessions.conversion_funnel_9})/${sessions.conversion_funnel_8}
      value_format_name: percent_1
    hidden_fields: [sessions.conversion_funnel_8, sessions.conversion_funnel_9]
    listen:
     date: session_start_calendar.calendar_date_date
     country: sessions.geography_country
     acquisition: sessions.acquisition_channel
     device: sessions.device_type
    sorts: [session_start_calendar.calendar_date_date desc]
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
    top: 16
    left: 6
    height: 4
    width: 6

  - name: dropout_rate_9
    title: Dropout Rate 9 (Checkout - Payment)
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_date]
    measures: [sessions.conversion_funnel_9, sessions.conversion_funnel_10]
    dynamic_fields:
    - table_calculation: dropout_rate_9_checkout_pay
      label: Dropout Rate 9 - Checkout - Payment
      expression: (${sessions.conversion_funnel_9}-${sessions.conversion_funnel_10})/${sessions.conversion_funnel_9}
      value_format_name: percent_1
    hidden_fields: [sessions.conversion_funnel_9, sessions.conversion_funnel_10]
    listen:
     date: session_start_calendar.calendar_date_date
     country: sessions.geography_country
     acquisition: sessions.acquisition_channel
     device: sessions.device_type
    sorts: [session_start_calendar.calendar_date_date desc]
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
    top: 20
    left: 0
    height: 4
    width: 6