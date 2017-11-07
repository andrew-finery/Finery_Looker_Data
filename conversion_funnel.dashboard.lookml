- dashboard: conversion_funnel
  title: Conversion Funnel
  layout: static
  tile_size: 100

  filters:

  elements:
  - name: conversion_funnel_yesterday
    title: Yesterday
    model: finery_data
    explore: sessions
    type: looker_funnel
    fields: [sessions.1_conversion_funnel_all_sessions, sessions.2_conversion_funnel_category_page,
      sessions.3_conversion_funnel_product_page, sessions.4_conversion_funnel_add_to_cart,
      sessions.5_conversion_funnel_view_cart, sessions.6_conversion_funnel_checkout_registration,
      sessions.7_conversion_funnel_checkout_address, sessions.8_conversion_funnel_checkout_delivery,
      sessions.9_conversion_funnel_checkout_payment, sessions.10_conversion_funnel_order,
      session_start_calendar.calendar_date_date]
    filters:
      session_start_calendar.calendar_date_date: yesterday
    sorts: [session_start_calendar.calendar_date_date desc]
    limit: 500
    column_limit: 50
    leftAxisLabelVisible: false
    leftAxisLabel: ''
    rightAxisLabelVisible: false
    rightAxisLabel: ''
    barColors: ['palette: Santa Cruz']
    smoothedBars: false
    orientation: automatic
    labelPosition: left
    percentType: total
    percentPosition: inline
    valuePosition: Hidden
    labelColorEnabled: false
    labelColor: "#FFF"
    show_view_names: true
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
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
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    series_labels: {}
    height: 4
    width: 6
    top: 0
    left: 0


  - name: conversion_funnel_last_week
    title: Last Week
    model: finery_data
    explore: sessions
    type: looker_funnel
    fields: [sessions.1_conversion_funnel_all_sessions, sessions.2_conversion_funnel_category_page,
      sessions.3_conversion_funnel_product_page, sessions.4_conversion_funnel_add_to_cart,
      sessions.5_conversion_funnel_view_cart, sessions.6_conversion_funnel_checkout_registration,
      sessions.7_conversion_funnel_checkout_address, sessions.8_conversion_funnel_checkout_delivery,
      sessions.9_conversion_funnel_checkout_payment, sessions.10_conversion_funnel_order,
      session_start_calendar.calendar_date_date]
    filters:
      session_start_calendar.calendar_date_date: 8 days ago for 1 day
    sorts: [session_start_calendar.calendar_date_date desc]
    limit: 500
    column_limit: 50
    leftAxisLabelVisible: false
    leftAxisLabel: ''
    rightAxisLabelVisible: false
    rightAxisLabel: ''
    barColors: ['palette: Santa Cruz']
    smoothedBars: false
    orientation: automatic
    labelPosition: hidden
    percentType: total
    percentPosition: inline
    valuePosition: Hidden
    labelColorEnabled: false
    labelColor: "#FFF"
    show_view_names: true
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
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
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    series_labels: {}
    height: 4
    width: 3
    top: 0
    left: 6

  - name: conversion_funnel_yesterday_desktop
    title: Yesterday - Desktop
    model: finery_data
    explore: sessions
    type: looker_funnel
    fields: [sessions.1_conversion_funnel_all_sessions, sessions.2_conversion_funnel_category_page,
      sessions.3_conversion_funnel_product_page, sessions.4_conversion_funnel_add_to_cart,
      sessions.5_conversion_funnel_view_cart, sessions.6_conversion_funnel_checkout_registration,
      sessions.7_conversion_funnel_checkout_address, sessions.8_conversion_funnel_checkout_delivery,
      sessions.9_conversion_funnel_checkout_payment, sessions.10_conversion_funnel_order,
      session_start_calendar.calendar_date_date]
    filters:
      session_start_calendar.calendar_date_date: yesterday
      sessions.device_type: Desktop
    sorts: [session_start_calendar.calendar_date_date desc]
    limit: 500
    column_limit: 50
    leftAxisLabelVisible: false
    leftAxisLabel: ''
    rightAxisLabelVisible: false
    rightAxisLabel: ''
    barColors: ['palette: Santa Cruz']
    smoothedBars: false
    orientation: automatic
    labelPosition: left
    percentType: total
    percentPosition: inline
    valuePosition: Hidden
    labelColorEnabled: false
    labelColor: "#FFF"
    show_view_names: true
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
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
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    series_labels: {}
    height: 4
    width: 6
    top: 4
    left: 0

  - name: conversion_funnel_yesterday_tablet
    title: Tablet
    model: finery_data
    explore: sessions
    type: looker_funnel
    fields: [sessions.1_conversion_funnel_all_sessions, sessions.2_conversion_funnel_category_page,
      sessions.3_conversion_funnel_product_page, sessions.4_conversion_funnel_add_to_cart,
      sessions.5_conversion_funnel_view_cart, sessions.6_conversion_funnel_checkout_registration,
      sessions.7_conversion_funnel_checkout_address, sessions.8_conversion_funnel_checkout_delivery,
      sessions.9_conversion_funnel_checkout_payment, sessions.10_conversion_funnel_order,
      session_start_calendar.calendar_date_date]
    filters:
      session_start_calendar.calendar_date_date: yesterday
      sessions.device_type: Tablet
    sorts: [session_start_calendar.calendar_date_date desc]
    limit: 500
    column_limit: 50
    leftAxisLabelVisible: false
    leftAxisLabel: ''
    rightAxisLabelVisible: false
    rightAxisLabel: ''
    barColors: ['palette: Santa Cruz']
    smoothedBars: false
    orientation: automatic
    labelPosition: hidden
    percentType: total
    percentPosition: inline
    valuePosition: Hidden
    labelColorEnabled: false
    labelColor: "#FFF"
    show_view_names: true
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
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
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    series_labels: {}
    height: 4
    width: 3
    top: 4
    left: 6

  - name: conversion_funnel_yesterday_mobile
    title: Mobile
    model: finery_data
    explore: sessions
    type: looker_funnel
    fields: [sessions.1_conversion_funnel_all_sessions, sessions.2_conversion_funnel_category_page,
      sessions.3_conversion_funnel_product_page, sessions.4_conversion_funnel_add_to_cart,
      sessions.5_conversion_funnel_view_cart, sessions.6_conversion_funnel_checkout_registration,
      sessions.7_conversion_funnel_checkout_address, sessions.8_conversion_funnel_checkout_delivery,
      sessions.9_conversion_funnel_checkout_payment, sessions.10_conversion_funnel_order,
      session_start_calendar.calendar_date_date]
    filters:
      session_start_calendar.calendar_date_date: yesterday
      sessions.device_type: Mobile
    sorts: [session_start_calendar.calendar_date_date desc]
    limit: 500
    column_limit: 50
    leftAxisLabelVisible: false
    leftAxisLabel: ''
    rightAxisLabelVisible: false
    rightAxisLabel: ''
    barColors: ['palette: Santa Cruz']
    smoothedBars: false
    orientation: automatic
    labelPosition: hidden
    percentType: total
    percentPosition: inline
    valuePosition: Hidden
    labelColorEnabled: false
    labelColor: "#FFF"
    show_view_names: true
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
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
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    series_labels: {}
    height: 4
    width: 3
    top: 4
    left: 9
