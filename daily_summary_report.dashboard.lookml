- dashboard: daily_summary_report
  title: Daily Summary Report
  layout: tile
  tile_size: 100


  elements:

  - name: revenue_short_term
    title: Revenue
    model: finery_data
    explore: spree_orders
    type: table
    fields: [spree_orders.revenue_yesterday, spree_orders.revenue_yesterday_last_week,
      spree_orders.revenue_yesterday_week_on_week, spree_orders.revenue_yesterday_last_year,
      spree_orders.revenue_yesterday_year_on_year, spree_orders.revenue_target_yesterday,
      spree_orders.revenue_yesterday_vs_target, spree_orders.revenue_week_to_date, spree_orders.revenue_week_to_date_lw,
      spree_orders.revenue_week_to_date_week_on_week, spree_orders.revenue_week_to_date_ly,
      spree_orders.revenue_week_to_date_year_on_year, spree_orders.revenue_target_week_to_date,
      spree_orders.revenue_week_to_date_vs_target]
    limit: 500
    column_limit: 50
    show_view_names: false
    show_row_numbers: false
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
    conditional_formatting: [{type: low to high, value: !!null '', background_color: !!null '',
        font_color: !!null '', palette: {name: Red to Yellow to Green, colors: ["#F36254",
            "#FCF758", "#4FBC89"]}, bold: false, italic: false, strikethrough: false}]

  - name: traffic_short_term
    title: Traffic
    model: finery_data
    explore: sessions
    type: table
    fields: [sessions.visits_yesterday, sessions.visits_yesterday_last_week, sessions.visits_yesterday_wow,
      sessions.visits_yesterday_last_year, sessions.visits_yesterday_yoy, sessions.visits_target_yesterday,
      sessions.visits_yeaterday_vs_target, sessions.visits_week_to_date, sessions.visits_week_to_date_last_week,
      sessions.visits_week_to_date_wow, sessions.visits_week_to_date_last_year, sessions.visits_week_to_date_yoy,
      sessions.visits_target_week_to_date, sessions.visits_week_to_date_vs_target]
    limit: 500
    column_limit: 50
    show_view_names: false
    show_row_numbers: false
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


  - name: conversion_rate_short_term
    title: Conversion Rate
    model: finery_data
    explore: sessions
    type: table
    fields: [sessions.conversion_yesterday, sessions.conversion_yesterday_last_week,
      sessions.conversion_yesterday_wow, sessions.conversion_yesterday_last_year, sessions.conversion_yesterday_yoy,
      sessions.conversion_target_yesterday, sessions.conversion_yeaterday_vs_target,
      sessions.conversion_week_to_date, sessions.conversion_week_to_date_last_week,
      sessions.conversion_week_to_date_wow, sessions.conversion_week_to_date_last_year,
      sessions.conversion_week_to_date_yoy, sessions.conversion_target_week_to_date,
      sessions.conversion_week_to_date_vs_target]
    limit: 500
    column_limit: 50
    show_view_names: false
    show_row_numbers: false
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



  - name: basket_short_term
    title: Basket Size
    model: finery_data
    explore: spree_orders
    type: table
    fields: [spree_orders.basket_yesterday, spree_orders.basket_yesterday_last_week,
      spree_orders.basket_yesterday_wow, spree_orders.basket_yesterday_last_year, spree_orders.basket_yesterday_yoy,
      spree_orders.basket_target_yesterday, spree_orders.basket_yeaterday_vs_target,
      spree_orders.basket_week_to_date, spree_orders.basket_week_to_date_last_week,
      spree_orders.basket_week_to_date_wow, spree_orders.basket_week_to_date_last_year,
      spree_orders.basket_week_to_date_yoy, spree_orders.basket_target_week_to_date,
      spree_orders.basket_week_to_date_vs_target]
    limit: 500
    column_limit: 50
    show_view_names: false
    show_row_numbers: false
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
