- dashboard: daily_summary_report
  title: Daily Summary Report
  layout: static
  tile_size: 100


  elements:

  - name: date_
    title: ""
    model: finery_data
    explore: spree_orders
    type: table
    fields: [calendar_weeks.calendar_date_date, spree_orders.completed_day_of_week,
      calendar_weeks.week_number, calendar_weeks.year]
    filters:
      calendar_weeks.calendar_date_date: 1 days ago for 1 days
    sorts: [calendar_weeks.calendar_date_date desc]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - table_calculation: calculation_1
      label: Calculation 1
      expression: concat(${calendar_weeks.calendar_date_date}, ", ", ${spree_orders.completed_day_of_week},
        " Week ", ${calendar_weeks.week_number}, " ")
      value_format:
      value_format_name:
      _kind_hint: dimension
    show_view_names: true
    show_row_numbers: false
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    conditional_formatting: [{type: low to high, value: !!null '', background_color: !!null '',
        font_color: !!null '', palette: {name: Red to Yellow to Green, colors: ["#F36254",
            "#FCF758", "#4FBC89"]}, bold: false, italic: false, strikethrough: false}]
    hidden_fields: [calendar_weeks.year, calendar_weeks.week_number, spree_orders.completed_day_of_week,
      calendar_weeks.calendar_date_date]
    series_labels:
      calculation_1: Date
    height: 1
    width: 12
    top: 0
    left: 0

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
    height: 1
    width: 12
    top: 1
    left: 0

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
    height: 1
    width: 12
    top: 2
    left: 0

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
    height: 1
    width: 12
    top: 3
    left: 0

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
    height: 1
    width: 12
    top: 4
    left: 0

  - name: john_lewis_net_revenue
    title: John Lewis - Net Revenue
    model: finery_data
    explore: john_lewis_sor
    type: table
    fields: [john_lewis_sor.net_revenue_yesterday, john_lewis_sor.net_revenue_yesterday_last_week,
      john_lewis_sor.net_revenue_yesterday_week_on_week, john_lewis_sor.net_revenue_week_to_date,
      john_lewis_sor.net_revenue_week_to_date_lw, john_lewis_sor.net_revenue_week_to_date_week_on_week,
      john_lewis_sor.net_revenue_month_to_date, john_lewis_sor.net_revenue_month_to_date_last_month,
      john_lewis_sor.net_revenue_month_to_date_month_on_month]
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
    height: 1
    width: 12
    top: 5
    left: 0

  - name: traffic_wow
    title: Traffic Week on Week
    model: finery_data
    explore: sessions
    type: looker_line
    fields: [session_start_calendar.calendar_date_day_of_week, sessions.count, session_start_calendar.year_week_number]
    pivots: [session_start_calendar.year_week_number]
    fill_fields: [session_start_calendar.calendar_date_day_of_week]
    filters:
      session_start_calendar.calendar_date_date: before 0 days ago
      session_start_calendar.calendar_date_week: 2 weeks
    sorts: [session_start_calendar.year_week_number 0, session_start_calendar.calendar_date_day_of_week]
    limit: 500
    column_limit: 50
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: right
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: false
    point_style: none
    interpolation: monotone
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    colors: ['palette: Santa Cruz']
    series_colors: {}
    y_axes: [{label: Traffic, maxValue: !!null '', minValue: !!null '', orientation: left,
        showLabels: false, showValues: true, tickDensity: default, tickDensityCustom: 5,
        type: linear, unpinAxis: false, valueFormat: '#,"k"', series: [{id: '201733',
            name: '201733'}, {id: '201734', name: '201734'}]}]
    height: 3
    width: 6
    top: 6
    left: 0


  - name: conversion_rate_week_on_week
    title: Conversion Rate Week on Week
    model: finery_data
    explore: sessions
    type: looker_line
    fields: [session_start_calendar.calendar_date_day_of_week, session_start_calendar.year_week_number,
      sessions.conversion_rate]
    pivots: [session_start_calendar.year_week_number]
    fill_fields: [session_start_calendar.calendar_date_day_of_week]
    filters:
      session_start_calendar.calendar_date_date: before 0 days ago
      session_start_calendar.calendar_date_week: 2 weeks
    sorts: [session_start_calendar.year_week_number 0, session_start_calendar.calendar_date_day_of_week]
    limit: 500
    column_limit: 50
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: right
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: false
    point_style: none
    interpolation: monotone
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    colors: ['palette: Santa Cruz']
    series_colors: {}
    y_axes: [{label: Traffic, maxValue: !!null '', minValue: !!null '', orientation: left,
        showLabels: false, showValues: true, tickDensity: default, tickDensityCustom: 5,
        type: linear, unpinAxis: false, valueFormat: 0.0%, series: [{id: '201733', name: '201733'},
          {id: '201734', name: '201734'}]}]
    height: 3
    width: 6
    top: 6
    left: 6


  - name: basket_size_week_on_week
    title: Basket Size Week on Week
    model: finery_data
    explore: spree_orders
    type: looker_line
    fields: [calendar_weeks.calendar_date_day_of_week, calendar_weeks.year_week_number,
      spree_orders.avg_gross_revenue_gbp_ex_voucher_and_shipping_and_store_credit]
    pivots: [calendar_weeks.year_week_number]
    fill_fields: [calendar_weeks.calendar_date_day_of_week]
    filters:
      calendar_weeks.calendar_date_date: before 0 days ago
      calendar_weeks.calendar_date_week: 2 weeks
    sorts: [calendar_weeks.year_week_number 0, calendar_weeks.calendar_date_day_of_week]
    limit: 500
    column_limit: 50
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: right
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: false
    point_style: none
    interpolation: monotone
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    colors: ['palette: Santa Cruz']
    series_colors: {}
    y_axes: [{label: '', maxValue: !!null '', minValue: !!null '', orientation: left,
        showLabels: false, showValues: true, tickDensity: default, tickDensityCustom: 5,
        type: linear, unpinAxis: false, valueFormat: '"£"###0', series: [{id: '201733',
            name: '201733'}, {id: '201734', name: '201734'}]}]
    height: 3
    width: 6
    top: 9
    left: 0

  - name: revenue_wow
    title: Revenue Week on Week
    model: finery_data
    explore: spree_orders
    type: looker_line
    fields: [calendar_weeks.calendar_date_day_of_week, calendar_weeks.year_week_number,
      spree_orders.sum_gross_revenue_ex_discount_and_store_credit_and_shipping_in_gbp]
    pivots: [calendar_weeks.year_week_number]
    fill_fields: [calendar_weeks.calendar_date_day_of_week]
    filters:
      calendar_weeks.calendar_date_date: before 0 days ago
      calendar_weeks.calendar_date_week: 2 weeks
    sorts: [calendar_weeks.year_week_number 0, calendar_weeks.calendar_date_day_of_week]
    limit: 500
    column_limit: 50
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: right
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: false
    point_style: none
    interpolation: monotone
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    colors: ['palette: Santa Cruz']
    series_colors: {}
    y_axes: [{label: '', maxValue: !!null '', minValue: !!null '', orientation: left,
        showLabels: false, showValues: true, tickDensity: default, tickDensityCustom: 5,
        type: linear, unpinAxis: false, valueFormat: '"£"#,##0,"k"', series: [{id: '201733',
            name: '201733'}, {id: '201734', name: '201734'}]}]
    height: 3
    width: 6
    top: 9
    left: 6

  - name: traffic_long_term
    title: Traffic
    model: finery_data
    explore: sessions
    type: table
    fields: [sessions.visits_month_to_date, sessions.visits_month_to_date_last_month,
      sessions.visits_month_to_date_mom, sessions.visits_month_to_date_last_year, sessions.visits_month_to_date_yoy,
      sessions.visits_target_month_to_date, sessions.visits_month_to_date_vs_target,
      sessions.visits_year_to_date, sessions.visits_year_to_date_last_year, sessions.visits_year_to_date_yoy]
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
    height: 1
    width: 12
    top: 12
    left: 0

  - name: conversion_rate_long_term
    title: Conversion Rate
    model: finery_data
    explore: sessions
    type: table
    fields: [sessions.conversion_month_to_date, sessions.conversion_month_to_date_last_month,
      sessions.conversion_month_to_date_mom, sessions.conversion_month_to_date_last_year,
      sessions.conversion_month_to_date_yoy, sessions.conversion_target_month_to_date,
      sessions.conversion_month_to_date_vs_target, sessions.conversion_year_to_date,
      sessions.conversion_year_to_date_last_year, sessions.conversion_year_to_date_yoy]
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
    height: 1
    width: 12
    top: 13
    left: 0

  - name: basket_long_term
    title: Basket Size
    model: finery_data
    explore: spree_orders
    type: table
    fields: [spree_orders.basket_month_to_date, spree_orders.basket_month_to_date_last_month,
      spree_orders.basket_month_to_date_mom, spree_orders.basket_month_to_date_last_year,
      spree_orders.basket_month_to_date_yoy, spree_orders.basket_target_month_to_date,
      spree_orders.basket_month_to_date_vs_target, spree_orders.basket_year_to_date,
      spree_orders.basket_year_to_date_last_year, spree_orders.basket_year_to_date_yoy]
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
            "#FCF758", "#4FBC89"], __FILE: finery_data/daily_summary_report.dashboard.lookml,
          __LINE_NUM: 56}, bold: false, italic: false, strikethrough: false, __FILE: finery_data/daily_summary_report.dashboard.lookml,
        __LINE_NUM: 55}]
    height: 1
    width: 12
    top: 14
    left: 0

  - name: revenue_long_term
    title: Revenue
    model: finery_data
    explore: spree_orders
    type: table
    fields: [spree_orders.revenue_month_to_date, spree_orders.revenue_month_to_date_last_month,
      spree_orders.revenue_month_to_date_month_on_month, spree_orders.revenue_month_to_date_last_year,
      spree_orders.revenue_month_to_date_year_on_year, spree_orders.revenue_target_month_to_date,
      spree_orders.revenue_month_to_date_vs_target, spree_orders.revenue_year_to_date,
      spree_orders.revenue_year_to_date_last_year, spree_orders.revenue_year_to_date_year_on_year]
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
            "#FCF758", "#4FBC89"], __FILE: finery_data/daily_summary_report.dashboard.lookml,
          __LINE_NUM: 56}, bold: false, italic: false, strikethrough: false, __FILE: finery_data/daily_summary_report.dashboard.lookml,
        __LINE_NUM: 55}]
    height: 1
    width: 12
    top: 15
    left: 0

  - name: top_products_yesterday_ecom
    title: Top Products Yesterday - finerylondon.com
    model: finery_data
    explore: spree_order_items
    type: table
    fields: [option_info.style, option_info.colour, option_info.option_image, spree_order_items.total_items_sold,
      spree_order_items.sum_gross_item_revenue_ex_voucher_discount_gbp]
    filters:
      calendar_weeks.calendar_date_date: 1 days ago for 1 days
    sorts: [spree_order_items.total_items_sold desc]
    limit: 10
    column_limit: 50
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
    series_labels:
      option_info.style: Style
      option_info.colour: Colour
      option_info.option_image: Image
      spree_order_items.sum_gross_item_revenue_ex_voucher_discount_gbp: Revenue
      spree_order_items.total_items_sold: Units Sold
    height: 16
    width: 6
    top: 16
    left: 0

  - name: top_products_yesterday_jl
    title: Top Products Yesterday - John Lewis
    model: finery_data
    explore: john_lewis_sor
    type: table
    fields: [option_info.style, option_info.colour, john_lewis_sor.sum_sales_units,
      john_lewis_sor.sum_gross_revenue, option_info.option_image]
    filters:
      john_lewis_sor.calendar_date: 1 days ago for 1 days
    sorts: [john_lewis_sor.sum_sales_units desc]
    limit: 10
    column_limit: 50
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
    series_labels:
      option_info.style: Style
      option_info.colour: Colour
      option_info.option_image: Image
      john_lewis_sor.sum_sales_units: Units
      john_lewis_sor.sum_gross_revenue: Revenue
    height: 16
    width: 6
    top: 16
    left: 6

  - name: revenue_short_term_by_channel
    title: Revenue by Channel
    model: finery_data
    explore: transactions
    type: table
    fields: [transactions.revenue_yesterday, transactions.revenue_yesterday_last_week,
      transactions.revenue_yesterday_week_on_week, transactions.revenue_yesterday_last_year,
      transactions.revenue_yesterday_year_on_year, transactions.revenue_week_to_date,
      transactions.revenue_week_to_date_lw, transactions.revenue_week_to_date_week_on_week,
      transactions.revenue_week_to_date_ly, transactions.revenue_week_to_date_year_on_year,
      transactions.conversion_channel]
    sorts: [transactions.revenue_yesterday desc]
    limit: 500
    column_limit: 50
    total: true
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
            "#FCF758", "#4FBC89"], __FILE: finery_data/daily_summary_report.dashboard.lookml,
          __LINE_NUM: 851}, bold: false, italic: false, strikethrough: false, __FILE: finery_data/daily_summary_report.dashboard.lookml,
        __LINE_NUM: 850}]
    height: 3
    width: 12
    top: 32
    left: 0

  - name: revenue_short_term_by_device
    title: Revenue by Device
    model: finery_data
    explore: transactions
    type: table
    fields: [transactions.revenue_yesterday, transactions.revenue_yesterday_last_week,
      transactions.revenue_yesterday_week_on_week, transactions.revenue_yesterday_last_year,
      transactions.revenue_yesterday_year_on_year, transactions.revenue_week_to_date,
      transactions.revenue_week_to_date_lw, transactions.revenue_week_to_date_week_on_week,
      transactions.revenue_week_to_date_ly, transactions.revenue_week_to_date_year_on_year,
      transactions.conversion_device]
    sorts: [transactions.revenue_yesterday desc]
    limit: 500
    column_limit: 50
    total: true
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
            "#FCF758", "#4FBC89"], __FILE: finery_data/daily_summary_report.dashboard.lookml,
          __LINE_NUM: 851}, bold: false, italic: false, strikethrough: false, __FILE: finery_data/daily_summary_report.dashboard.lookml,
        __LINE_NUM: 850}]
    height: 2
    width: 12
    top: 35
    left: 0

  - name: revenue_short_term_by_country
    title: Revenue by Country
    model: finery_data
    explore: transactions
    type: table
    fields: [transactions.revenue_yesterday, transactions.revenue_yesterday_last_week,
      transactions.revenue_yesterday_week_on_week, transactions.revenue_yesterday_last_year,
      transactions.revenue_yesterday_year_on_year, transactions.revenue_week_to_date,
      transactions.revenue_week_to_date_lw, transactions.revenue_week_to_date_week_on_week,
      transactions.revenue_week_to_date_ly, transactions.revenue_week_to_date_year_on_year,
      transactions.conversion_country]
    sorts: [transactions.revenue_yesterday desc]
    limit: 500
    column_limit: 50
    total: true
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
            "#FCF758", "#4FBC89"], __FILE: finery_data/daily_summary_report.dashboard.lookml,
          __LINE_NUM: 851}, bold: false, italic: false, strikethrough: false, __FILE: finery_data/daily_summary_report.dashboard.lookml,
        __LINE_NUM: 850}]
    height: 2
    width: 12
    top: 37
    left: 0
