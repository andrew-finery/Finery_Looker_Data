- dashboard: marketing_report
  title: Marketing Report
  layout: static
  tile_size: 100


  elements:
  - name: visits_yesterday_pie_chart
    title: Visits Yesterday
    model: finery_data
    explore: sessions
    type: looker_pie
    fields: [sessions.channel_grouping_3, sessions.visits_yesterday]
    fill_fields: [sessions.channel_grouping_3]
    sorts: [sessions.visits_yesterday desc]
    limit: 500
    column_limit: 50
    value_labels: labels
    label_type: labPer
    stacking: ''
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
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    width: 6
    height: 6
    top: 0
    left: 0

  - name: revenue_yesterday_pie_chart
    title: Revenue Yesterday
    model: finery_data
    explore: sessions
    type: looker_pie
    fields: [sessions.channel_grouping_3, sessions.sum_gross_revenue_ex_discount]
    fill_fields: [sessions.channel_grouping_3]
    filters:
      session_start_calendar.calendar_date_date: 1 days ago for 1 days
    sorts: [sessions.sum_gross_revenue_ex_discount desc]
    limit: 500
    column_limit: 50
    value_labels: labels
    label_type: labPer
    stacking: ''
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
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    width: 6
    height: 6
    top: 0
    left: 6


  - name: orders_yesterday_pie_chart
    title: Orders Yesterday
    model: finery_data
    explore: sessions
    type: looker_pie
    fields: [sessions.channel_grouping_3, sessions.orders_yesterday]
    fill_fields: [sessions.channel_grouping_3]
    sorts: [sessions.orders_yesterday desc]
    limit: 500
    column_limit: 50
    value_labels: labels
    label_type: labPer
    stacking: ''
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
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    width: 6
    height: 6
    top: 6
    left: 3

  - name: marketing_kpi_yesterday
    title: KPI Performance Yesterday
    model: finery_data
    explore: sessions
    type: table
    fields: [sessions.channel_grouping_3, sessions.visits_yesterday, sessions.sum_gross_revenue_ex_discount, sessions.orders_yesterday,
      sessions.conversion_yesterday, sessions.average_basket_ex_discount_yesterday]
    fill_fields: [sessions.channel_grouping_3]
    filters:
      session_start_calendar.calendar_date_date: 1 days ago for 1 days
    sorts: [sessions.sum_gross_revenue_ex_discount desc]
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
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
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
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    series_labels:
      sessions.orders_yesterday: Orders
      sessions.visits_yesterday: Visits
      sessions.conversion_yesterday: Conversion Rate
      sessions.average_basket_ex_discount_yesterday: Average Basket Size
    width: 12
    height: 3
    top: 12
    left: 0

  - name: facebook_spend_last_30_days
    title: Facebook Spend Last 30 Days
    model: finery_data
    explore: facebook_api_ad_performance
    type: looker_area
    fields: [facebook_api_ad_performance.total_spend, facebook_api_ad_performance.calendar_date]
    fill_fields: [facebook_api_ad_performance.calendar_date]
    filters:
      facebook_api_ad_performance.calendar_date: 30 days ago for 30 days
    sorts: [facebook_api_ad_performance.calendar_date desc]
    limit: 500
    column_limit: 50
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
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    ordering: none
    show_null_labels: false
    series_types: {}
    y_axes: [{label: Total Spend, maxValue: !!null '', minValue: !!null '', orientation: left,
        showLabels: false, showValues: true, tickDensity: default, tickDensityCustom: 5,
        type: linear, unpinAxis: false, valueFormat: !!null '', series: [{id: facebook_api_ad_performance.total_spend,
            name: Facebook API Ad Performance Total Spend, axisId: facebook_api_ad_performance.total_spend}]}]
    x_axis_label: Calendar Date
    width: 12
    height: 4
    top: 15
    left: 0

  - name: facebook_roi
    title: Facebook ROI
    model: finery_data
    explore: facebook_api_ad_performance
    type: table
    fields: [facebook_api_ad_performance.buyers_vs_nonbuyers, facebook_api_ad_performance.return_on_investment_yesterday,
      facebook_api_ad_performance.return_on_investment_lw, facebook_api_ad_performance.return_on_investment_wow,
      facebook_api_ad_performance.return_on_investment_l3d_average, facebook_api_ad_performance.return_on_investment_l3d_vs_yesterday,
      facebook_api_ad_performance.return_on_investment_l7d_average, facebook_api_ad_performance.return_on_investment_l7d_vs_yesterday]
    filters:
      facebook_api_ad_performance.buyers_vs_nonbuyers: "-EMPTY"
    sorts: [facebook_api_ad_performance.return_on_investment_yesterday desc]
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
    show_totals_labels: true
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    series_labels:
      facebook_api_ad_performance.revenue_1_day_after_clicking_yesterday: Revenue
      facebook_api_ad_performance.return_on_investment_yesterday: Actual
    width: 12
    height: 2
    top: 19
    left: 0

  - name: facebook_cpo
    title: Facebook CPO
    model: finery_data
    explore: facebook_api_ad_performance
    type: table
    fields: [facebook_api_ad_performance.buyers_vs_nonbuyers, facebook_api_ad_performance.cost_per_order_yesterday,
      facebook_api_ad_performance.cost_per_order_lw, facebook_api_ad_performance.cost_per_order_wow,
      facebook_api_ad_performance.cost_per_order_l3d_average, facebook_api_ad_performance.cost_per_order_l3d_vs_yesterday,
      facebook_api_ad_performance.cost_per_order_l7d_average, facebook_api_ad_performance.cost_per_order_l7d_vs_yesterday]
    filters:
      facebook_api_ad_performance.buyers_vs_nonbuyers: "-EMPTY"
    sorts: [facebook_api_ad_performance.cost_per_order_yesterday desc]
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
    show_totals_labels: true
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    width: 12
    height: 2
    top: 21
    left: 0

  - name: affiliate_spend_last_30_days
    title: Affiliate Spend Last 30 Days
    model: finery_data
    explore: rakuten_orders
    type: looker_area
    fields: [rakuten_orders.sum_commission, rakuten_orders.order_placed_date]
    filters:
      rakuten_orders.order_placed_date: 30 days ago for 30 days
    sorts: [rakuten_orders.order_placed_date desc]
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
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    ordering: none
    show_null_labels: false
    series_types: {}
    y_axes: [{label: '', maxValue: !!null '', minValue: !!null '', orientation: left,
        showLabels: false, showValues: true, tickDensity: default, tickDensityCustom: 5,
        type: linear, unpinAxis: false, valueFormat: !!null '', series: [{id: rakuten_orders.sum_commission,
            name: Rakuten Orders Sum Commission, axisId: rakuten_orders.sum_commission}]}]
    colors: ['palette: Santa Cruz']
    series_colors: {}
    width: 12
    height: 3
    top: 23
    left: 0

  - name: traffic_per_channel
    title: Traffic
    model: finery_data
    explore: sessions
    type: table
    fields: [sessions.channel_grouping_3, sessions.visits_yesterday, sessions.visits_yesterday_last_week,
      sessions.visits_yesterday_wow, sessions.visits_yesterday_last_year, sessions.visits_yesterday_yoy,
      sessions.visits_month_to_date, sessions.visits_month_to_date_last_month, sessions.visits_month_to_date_mom,
      sessions.visits_year_to_date, sessions.visits_year_to_date_last_year, sessions.visits_year_to_date_yoy]
    fill_fields: [sessions.channel_grouping_3]
    sorts: [sessions.visits_yesterday desc]
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
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
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
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    series_labels:
      sessions.orders_yesterday: Orders
      sessions.visits_yesterday: Actual
      sessions.conversion_yesterday: Conversion Rate
      sessions.visits_yesterday_last_week: LW
    width: 12
    height: 3
    top: 26
    left: 0

  - name: revenue_per_channel
    title: Revenue Ex. Discount
    model: finery_data
    explore: sessions
    type: table
    fields: [sessions.channel_grouping_3, sessions.gross_revenue_ex_discount_yesterday,
      sessions.gross_revenue_ex_discount_lw, sessions.gross_Revenue_ex_discount_wow,
      sessions.gross_revenue_ex_discount_yesterday_last_year, sessions.gross_revenue_ex_discount_yesterday_yoy,
      sessions.gross_revenue_ex_discount_month_to_date, sessions.gross_revenue_ex_discount_month_to_date_last_month,
      sessions.gross_revenue_ex_discount_month_to_date_mom, sessions.gross_revenue_ex_discount_year_to_date,
      sessions.gross_revenue_ex_discount_year_to_date_last_year, sessions.gross_revenue_ex_discount_year_to_date_yoy]
    fill_fields: [sessions.channel_grouping_3]
    sorts: [sessions.gross_revenue_ex_discount_yesterday desc]
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
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
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
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    series_labels:
      sessions.orders_yesterday: Actual
      sessions.visits_yesterday: Visits
      sessions.conversion_yesterday: Actual
    width: 12
    height: 3
    top: 29
    left: 0

  - name: orders_per_channel
    title: Orders
    model: finery_data
    explore: sessions
    type: table
    fields: [sessions.channel_grouping_3, sessions.orders_yesterday, sessions.orders_yesterday_last_week,
      sessions.orders_yesterday_week_on_week, sessions.orders_yesterday_last_year, sessions.orders_yesterday_year_on_year,
      sessions.orders_month_to_date, sessions.orders_month_to_date_last_month, sessions.orders_month_to_date_month_on_month,
      sessions.orders_year_to_date, sessions.orders_year_to_date_last_year, sessions.orders_year_to_date_year_on_year]
    fill_fields: [sessions.channel_grouping_3]
    sorts: [sessions.orders_yesterday desc]
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
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
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
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    series_labels:
      sessions.orders_yesterday: Actual
      sessions.visits_yesterday: Visits
      sessions.conversion_yesterday: Conversion Rate
    width: 12
    height: 3
    top: 32
    left: 0

  - name: conversion_per_channel
    title: Conversion Rate
    model: finery_data
    explore: sessions
    type: table
    fields: [sessions.channel_grouping_3, sessions.conversion_yesterday, sessions.conversion_yesterday_last_week,
      sessions.conversion_yesterday_wow, sessions.conversion_yesterday_last_year, sessions.conversion_yesterday_yoy,
      sessions.conversion_month_to_date, sessions.conversion_month_to_date_last_month,
      sessions.conversion_month_to_date_mom, sessions.conversion_year_to_date, sessions.conversion_year_to_date_last_year,
      sessions.conversion_year_to_date_yoy]
    fill_fields: [sessions.channel_grouping_3]
    sorts: [sessions.conversion_yesterday desc]
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
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
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
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    series_labels:
      sessions.orders_yesterday: Actual
      sessions.visits_yesterday: Visits
      sessions.conversion_yesterday: Actual
    width: 12
    height: 3
    top: 35
    left: 0

  - name: average_basket_per_channel
    title: Average Basket Size
    model: finery_data
    explore: sessions
    type: table
    fields: [sessions.channel_grouping_3, sessions.average_basket_ex_discount_yesterday,
      sessions.average_basket_ex_discount_lw, sessions.gross_revenue_ex_discount_wow,
      sessions.average_basket_ex_discount_yesterday_last_year, sessions.average_basket_ex_discount_yesterday_yoy,
      sessions.average_basket_ex_discount_month_to_date, sessions.average_basket_ex_discount_month_to_date_last_month,
      sessions.average_basket_ex_discount_month_to_date_mom, sessions.average_basket_ex_discount_year_to_date,
      sessions.average_basket_ex_discount_year_to_date_last_year, sessions.average_basket_ex_discount_year_to_date_yoy]
    fill_fields: [sessions.channel_grouping_3]
    sorts: [sessions.average_basket_ex_discount_yesterday desc]
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
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
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
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    series_labels:
      sessions.orders_yesterday: Actual
      sessions.visits_yesterday: Visits
      sessions.conversion_yesterday: Actual
    width: 12
    height: 3
    top: 38
    left: 0

  - name: crm_revenue_26_week_graph
    title: CRM Revenue (6 Months)
    model: finery_data
    explore: sessions
    type: looker_area
    fields: [sessions.sum_gross_revenue_ex_discount, session_start_calendar.calendar_date_week]
    fill_fields: [session_start_calendar.calendar_date_week]
    filters:
      session_start_calendar.calendar_date_date: 26 weeks ago for 26 weeks
      sessions.channel_grouping_3: CRM (Email)
    sorts: [session_start_calendar.calendar_date_week desc]
    limit: 500
    column_limit: 50
    total: true
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    value_labels: legend
    label_type: labPer
    ordering: none
    show_null_labels: false
    series_types: {}
    series_labels:
      sessions.orders_yesterday: Actual
      sessions.visits_yesterday: Visits
      sessions.conversion_yesterday: Actual
    series_colors: {}
    y_axes: [{label: '', maxValue: !!null '', minValue: !!null '', orientation: left,
        showLabels: false, showValues: true, tickDensity: default, tickDensityCustom: 5,
        type: linear, unpinAxis: false, valueFormat: !!null '', series: [{id: sessions.sum_gross_revenue_ex_discount,
            name: Sum Gross Revenue Ex Discount, axisId: sessions.sum_gross_revenue_ex_discount}]}]
    colors: ['palette: Looker Classic']
    width: 6
    height: 3
    top: 41
    left: 0

  - name: search_26_week_graph
    title: Search Revenue (6 Months)
    model: finery_data
    explore: sessions
    type: looker_area
    fields: [sessions.sum_gross_revenue_ex_discount, session_start_calendar.calendar_date_week]
    fill_fields: [session_start_calendar.calendar_date_week]
    filters:
      session_start_calendar.calendar_date_date: 26 weeks ago for 26 weeks
      sessions.channel_grouping_3: Search
    sorts: [session_start_calendar.calendar_date_week desc]
    limit: 500
    column_limit: 50
    total: true
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    value_labels: legend
    label_type: labPer
    ordering: none
    show_null_labels: false
    series_types: {}
    series_labels:
      sessions.orders_yesterday: Actual
      sessions.visits_yesterday: Visits
      sessions.conversion_yesterday: Actual
    series_colors: {}
    y_axes: [{label: '', maxValue: !!null '', minValue: !!null '', orientation: left,
        showLabels: false, showValues: true, tickDensity: default, tickDensityCustom: 5,
        type: linear, unpinAxis: false, valueFormat: !!null '', series: [{id: sessions.sum_gross_revenue_ex_discount,
            name: Sum Gross Revenue Ex Discount, axisId: sessions.sum_gross_revenue_ex_discount}]}]
    colors: ['palette: Looker Classic']
    width: 6
    height: 3
    top: 41
    left: 6

  - name: paid_social_26_week_graph
    title: Paid Social Revenue (6 Months)
    model: finery_data
    explore: sessions
    type: looker_area
    fields: [sessions.sum_gross_revenue_ex_discount, session_start_calendar.calendar_date_week]
    fill_fields: [session_start_calendar.calendar_date_week]
    filters:
      session_start_calendar.calendar_date_date: 26 weeks ago for 26 weeks
      sessions.channel_grouping_3: Paid Social
    sorts: [session_start_calendar.calendar_date_week desc]
    limit: 500
    column_limit: 50
    total: true
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    value_labels: legend
    label_type: labPer
    ordering: none
    show_null_labels: false
    series_types: {}
    series_labels:
      sessions.orders_yesterday: Actual
      sessions.visits_yesterday: Visits
      sessions.conversion_yesterday: Actual
    series_colors: {}
    y_axes: [{label: '', maxValue: !!null '', minValue: !!null '', orientation: left,
        showLabels: false, showValues: true, tickDensity: default, tickDensityCustom: 5,
        type: linear, unpinAxis: false, valueFormat: !!null '', series: [{id: sessions.sum_gross_revenue_ex_discount,
            name: Sum Gross Revenue Ex Discount, axisId: sessions.sum_gross_revenue_ex_discount}]}]
    colors: ['palette: Looker Classic']
    width: 6
    height: 3
    top: 44
    left: 0

  - name: affiliates_26_week_graph
    title: Affiliates Revenue (6 Months)
    model: finery_data
    explore: sessions
    type: looker_area
    fields: [sessions.sum_gross_revenue_ex_discount, session_start_calendar.calendar_date_week]
    fill_fields: [session_start_calendar.calendar_date_week]
    filters:
      session_start_calendar.calendar_date_date: 26 weeks ago for 26 weeks
      sessions.channel_grouping_3: Affiliates
    sorts: [session_start_calendar.calendar_date_week desc]
    limit: 500
    column_limit: 50
    total: true
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
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
    show_null_points: true
    point_style: none
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    value_labels: legend
    label_type: labPer
    ordering: none
    show_null_labels: false
    series_types: {}
    series_labels:
      sessions.orders_yesterday: Actual
      sessions.visits_yesterday: Visits
      sessions.conversion_yesterday: Actual
    series_colors: {}
    y_axes: [{label: '', maxValue: !!null '', minValue: !!null '', orientation: left,
        showLabels: false, showValues: true, tickDensity: default, tickDensityCustom: 5,
        type: linear, unpinAxis: false, valueFormat: !!null '', series: [{id: sessions.sum_gross_revenue_ex_discount,
            name: Sum Gross Revenue Ex Discount, axisId: sessions.sum_gross_revenue_ex_discount}]}]
    colors: ['palette: Looker Classic']
    width: 6
    height: 3
    top: 44
    left: 6

  - name: direct_26_week_graph
    title: Direct Revenue (6 Months)
    model: finery_data
    explore: sessions
    type: looker_area
    fields: [sessions.sum_gross_revenue_ex_discount, session_start_calendar.calendar_date_week]
    fill_fields: [session_start_calendar.calendar_date_week]
    filters:
      session_start_calendar.calendar_date_date: 26 weeks ago for 26 weeks
      sessions.channel_grouping_3: Direct
    sorts: [session_start_calendar.calendar_date_week desc]
    limit: 500
    column_limit: 50
    total: true
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
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
    show_null_points: true
    point_style: none
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    value_labels: legend
    label_type: labPer
    ordering: none
    show_null_labels: false
    series_types: {}
    series_labels:
      sessions.orders_yesterday: Actual
      sessions.visits_yesterday: Visits
      sessions.conversion_yesterday: Actual
    series_colors: {}
    y_axes: [{label: '', maxValue: !!null '', minValue: !!null '', orientation: left,
        showLabels: false, showValues: true, tickDensity: default, tickDensityCustom: 5,
        type: linear, unpinAxis: false, valueFormat: !!null '', series: [{id: sessions.sum_gross_revenue_ex_discount,
            name: Sum Gross Revenue Ex Discount, axisId: sessions.sum_gross_revenue_ex_discount}]}]
    colors: ['palette: Looker Classic']
    width: 6
    height: 3
    top: 47
    left: 0

  - name: organic_social_26_week_graph
    title: Organic Social Revenue (6 Months)
    model: finery_data
    explore: sessions
    type: looker_area
    fields: [sessions.sum_gross_revenue_ex_discount, session_start_calendar.calendar_date_week]
    fill_fields: [session_start_calendar.calendar_date_week]
    filters:
      session_start_calendar.calendar_date_date: 26 weeks ago for 26 weeks
      sessions.channel_grouping_3: Organic Social
    sorts: [session_start_calendar.calendar_date_week desc]
    limit: 500
    column_limit: 50
    total: true
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
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
    show_null_points: true
    point_style: none
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    value_labels: legend
    label_type: labPer
    ordering: none
    show_null_labels: false
    series_types: {}
    series_labels:
      sessions.orders_yesterday: Actual
      sessions.visits_yesterday: Visits
      sessions.conversion_yesterday: Actual
    series_colors: {}
    y_axes: [{label: '', maxValue: !!null '', minValue: !!null '', orientation: left,
        showLabels: false, showValues: true, tickDensity: default, tickDensityCustom: 5,
        type: linear, unpinAxis: false, valueFormat: !!null '', series: [{id: sessions.sum_gross_revenue_ex_discount,
            name: Sum Gross Revenue Ex Discount, axisId: sessions.sum_gross_revenue_ex_discount}]}]
    colors: ['palette: Looker Classic']
    width: 6
    height: 3
    top: 47
    left: 6

  - name: referrals_26_week_graph
    title: Referrals Revenue (6 Months)
    model: finery_data
    explore: sessions
    type: looker_area
    fields: [sessions.sum_gross_revenue_ex_discount, session_start_calendar.calendar_date_week]
    fill_fields: [session_start_calendar.calendar_date_week]
    filters:
      session_start_calendar.calendar_date_date: 26 weeks ago for 26 weeks
      sessions.channel_grouping_3: Referrals
    sorts: [session_start_calendar.calendar_date_week desc]
    limit: 500
    column_limit: 50
    total: true
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
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
    show_null_points: true
    point_style: none
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    value_labels: legend
    label_type: labPer
    ordering: none
    show_null_labels: false
    series_types: {}
    series_labels:
      sessions.orders_yesterday: Actual
      sessions.visits_yesterday: Visits
      sessions.conversion_yesterday: Actual
    series_colors: {}
    y_axes: [{label: '', maxValue: !!null '', minValue: !!null '', orientation: left,
        showLabels: false, showValues: true, tickDensity: default, tickDensityCustom: 5,
        type: linear, unpinAxis: false, valueFormat: !!null '', series: [{id: sessions.sum_gross_revenue_ex_discount,
            name: Sum Gross Revenue Ex Discount, axisId: sessions.sum_gross_revenue_ex_discount}]}]
    colors: ['palette: Looker Classic']
    width: 6
    height: 3
    top: 50
    left: 3
