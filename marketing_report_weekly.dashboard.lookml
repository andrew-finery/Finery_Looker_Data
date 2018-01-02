- dashboard: marketing_report_weekly
  title: Marketing Report Weekly
  layout: static
  tile_size: 100


  elements:
  - name: visits_chart
    title: Visits - Last Week
    model: finery_data
    explore: sessions
    type: looker_pie
    fields: [sessions.count, sessions.channel_grouping_3]
    fill_fields: [sessions.channel_grouping_3]
    filters:
      session_start_calendar.calendar_date_week: 1 weeks ago for 1 weeks
    sorts: [sessions.count desc]
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    inner_radius: 0
    colors: ["#62bad4", "#a9c574", "#929292", "#9fdee0", "#1f3e5a", "#90c8ae", "#875876",
      "#c5c6a6", "#82c2ca", "#cee0a0", "#928fb4", "#9fc190"]
    series_colors: {}
    width: 6
    height: 6
    top: 0
    left: 0


  - name: revenue_chart
    title: Revenue - Last Week
    model: finery_data
    explore: sessions
    type: looker_pie
    fields: [sessions.channel_grouping_3, sessions.sum_gross_revenue_ex_discount]
    fill_fields: [sessions.channel_grouping_3]
    filters:
      session_start_calendar.calendar_date_week: 1 weeks ago for 1 weeks
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    inner_radius: 0
    colors: ["#62bad4", "#a9c574", "#929292", "#9fdee0", "#1f3e5a", "#90c8ae", "#875876",
      "#c5c6a6", "#82c2ca", "#cee0a0", "#928fb4", "#9fc190"]
    series_colors: {}
    width: 6
    height: 6
    top: 0
    left: 6


  - name: orders_chart
    title: Orders - Last Week
    model: finery_data
    explore: sessions
    type: looker_pie
    fields: [sessions.channel_grouping_3, sessions.sum_orders]
    fill_fields: [sessions.channel_grouping_3]
    filters:
      session_start_calendar.calendar_date_week: 1 weeks ago for 1 weeks
    sorts: [sessions.sum_orders desc]
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    inner_radius: 0
    colors: ["#62bad4", "#a9c574", "#929292", "#9fdee0", "#1f3e5a", "#90c8ae", "#875876",
      "#c5c6a6", "#82c2ca", "#cee0a0", "#928fb4", "#9fc190"]
    series_colors: {}
    width: 6
    height: 6
    top: 6
    left: 3


  - name: kpi_performance
    title: KPI Performance - Last Week
    model: finery_data
    explore: sessions
    type: table
    fields: [sessions.channel_grouping_3, sessions.count, sessions.sum_gross_revenue_ex_discount,
      sessions.sum_orders, sessions.conversion_rate, sessions.average_basket_size]
    fill_fields: [sessions.channel_grouping_3]
    filters:
      session_start_calendar.calendar_date_date: 1 weeks ago for 1 weeks
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


  - name: kpi_performance_day_of_the_week
    title: Day Of The Week Breakdown
    model: finery_data
    explore: sessions
    type: table
    fields: [session_start_calendar.calendar_date_day_of_week, sessions.count, sessions.sum_gross_revenue_ex_discount,
      sessions.sum_orders, sessions.conversion_rate, sessions.average_basket_size]
    fill_fields: [session_start_calendar.calendar_date_day_of_week]
    filters:
      session_start_calendar.calendar_date_week: 1 weeks ago for 1 weeks
    sorts: [session_start_calendar.calendar_date_day_of_week]
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
    width: 12
    height: 3
    top: 15
    left: 0


  - name: facebook_spend_graph
    title: Facebook Spend (26 Weeks)
    model: finery_data
    explore: facebook_api_ad_performance
    type: looker_area
    fields: [facebook_api_ad_performance.total_spend, facebook_api_ad_performance.calendar_week]
    fill_fields: [facebook_api_ad_performance.calendar_week]
    filters:
      facebook_api_ad_performance.calendar_date: 30 weeks ago for 30 weeks
    sorts: [facebook_api_ad_performance.calendar_week desc]
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
            name: Facebook API Ad Performance Total Spend, axisId: facebook_api_ad_performance.total_spend,
            __FILE: finery_data/marketing_report.dashboard.lookml, __LINE_NUM: 240}],
        __FILE: finery_data/marketing_report.dashboard.lookml, __LINE_NUM: 238}]
    x_axis_label: Calendar Date
    width: 12
    height: 4
    top: 18
    left: 0


  - name: facebook_roi_table
    title: Facebook ROI
    model: finery_data
    explore: facebook_api_ad_performance
    type: table
    fields: [facebook_api_ad_performance.buyers_vs_nonbuyers, facebook_api_ad_performance.return_on_investment_lcw,
      facebook_api_ad_performance.return_on_investment_pcw, facebook_api_ad_performance.return_on_investment_lcw_wow]
    filters:
      facebook_api_ad_performance.buyers_vs_nonbuyers: "-EMPTY"
    sorts: [facebook_api_ad_performance.return_on_investment_lcw desc]
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
    series_labels:
      facebook_api_ad_performance.return_on_investment_lcw_wow: "%"
    width: 6
    height: 2
    top: 22
    left: 0


  - name: facebook_cpo_table
    title: Facebook CPO
    model: finery_data
    explore: facebook_api_ad_performance
    type: table
    fields: [facebook_api_ad_performance.buyers_vs_nonbuyers, facebook_api_ad_performance.cost_per_order_lcw,
      facebook_api_ad_performance.cost_per_order_pcw, facebook_api_ad_performance.cost_per_order_lcw_wow]
    filters:
      facebook_api_ad_performance.buyers_vs_nonbuyers: "-EMPTY"
    sorts: [facebook_api_ad_performance.cost_per_order_lcw desc]
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
    series_labels:
      facebook_api_ad_performance.return_on_investment_lcw_wow: "%"
      facebook_api_ad_performance.cost_per_order_lcw_wow: "%"
    width: 6
    height: 2
    top: 22
    left: 6


  - name: traffic_table
    title: Traffic
    model: finery_data
    explore: sessions
    type: table
    fields: [sessions.channel_grouping_3, sessions.visits_last_complete_week, sessions.visits_previous_complete_week,
      sessions.visits_last_complete_week_wow, sessions.visits_month_to_date, sessions.visits_month_to_date_last_month,
      sessions.visits_month_to_date_mom, sessions.visits_year_to_date, sessions.visits_year_to_date_last_year,
      sessions.visits_year_to_date_yoy]
    sorts: [sessions.visits_last_complete_week desc]
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
    series_labels:
      sessions.visits_last_complete_week_wow: "%"
    width: 12
    height: 3
    top: 24
    left: 0


  - name: revenue_ex_discount_table
    title: Revenue Ex. Discount
    model: finery_data
    explore: sessions
    type: table
    fields: [sessions.channel_grouping_3, sessions.gross_revenue_ex_discount_last_complete_week,
      sessions.gross_revenue_ex_discount_previous_complete_week, sessions.gross_revenue_ex_discount_last_complete_week_wow,
      sessions.gross_revenue_ex_discount_month_to_date, sessions.gross_revenue_ex_discount_month_to_date_last_month,
      sessions.gross_revenue_ex_discount_month_to_date_mom, sessions.gross_revenue_ex_discount_year_to_date,
      sessions.gross_revenue_ex_discount_year_to_date_last_year, sessions.gross_revenue_ex_discount_year_to_date_yoy]
    fill_fields: [sessions.channel_grouping_3]
    sorts: [sessions.gross_revenue_ex_discount_last_complete_week desc]
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
    series_labels:
      sessions.visits_last_complete_week_wow: "%"
      sessions.gross_revenue_ex_discount_last_complete_week_wow: "%"
    width: 12
    height: 3
    top: 27
    left: 0


  - name: orders_table
    title: Orders
    model: finery_data
    explore: sessions
    type: table
    fields: [sessions.channel_grouping_3, sessions.orders_last_complete_week, sessions.orders_previous_complete_week,
      sessions.orders_last_complete_week_wow, sessions.orders_month_to_date, sessions.orders_month_to_date_last_month,
      sessions.orders_month_to_date_month_on_month, sessions.orders_year_to_date, sessions.orders_year_to_date_last_year,
      sessions.orders_year_to_date_year_on_year]
    fill_fields: [sessions.channel_grouping_3]
    sorts: [sessions.orders_last_complete_week desc]
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
    series_labels:
      sessions.visits_last_complete_week_wow: "%"
      sessions.gross_revenue_ex_discount_last_complete_week_wow: "%"
      sessions.orders_last_complete_week_wow: "%"
    width: 12
    height: 3
    top: 30
    left: 0


  - name: conversion_rate_table
    title: Conversion Rate
    model: finery_data
    explore: sessions
    type: table
    fields: [sessions.channel_grouping_3, sessions.conversion_last_complete_week, sessions.conversion_previous_complete_week,
      sessions.conversion_last_complete_week_wow, sessions.conversion_month_to_date,
      sessions.conversion_month_to_date_last_month, sessions.conversion_month_to_date_mom,
      sessions.conversion_year_to_date, sessions.conversion_year_to_date_last_year,
      sessions.conversion_year_to_date_yoy]
    fill_fields: [sessions.channel_grouping_3]
    sorts: [sessions.conversion_last_complete_week desc]
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
    series_labels:
      sessions.visits_last_complete_week_wow: "%"
      sessions.gross_revenue_ex_discount_last_complete_week_wow: "%"
      sessions.orders_last_complete_week_wow: "%"
      sessions.conversion_last_complete_week_wow: "%"
    width: 12
    height: 3
    top: 33
    left: 0


  - name: average_basket_table
    title: Average Basket Size
    model: finery_data
    explore: sessions
    type: table
    fields: [sessions.channel_grouping_3, sessions.average_basket_ex_discount_last_complete_week,
    sessions.average_basket_ex_discount_previous_complete_week, sessions.average_basket_ex_discount_last_complete_week_wow,
    sessions.average_basket_ex_discount_month_to_date, sessions.average_basket_ex_discount_month_to_date_last_month,
    sessions.average_basket_ex_discount_month_to_date_mom, sessions.average_basket_ex_discount_year_to_date,
    sessions.average_basket_ex_discount_year_to_date_last_year, sessions.average_basket_ex_discount_year_to_date_yoy]
    sorts: [sessions.average_basket_ex_discount_last_complete_week desc]
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
    series_labels:
      sessions.visits_last_complete_week_wow: "%"
      sessions.gross_revenue_ex_discount_last_complete_week_wow: "%"
      sessions.orders_last_complete_week_wow: "%"
      sessions.conversion_last_complete_week_wow: "%"
      sessions.average_basket_ex_discount_last_complete_week_wow: "%"
    width: 12
    height: 3
    top: 36
    left: 0


  - name: traffic_graph_by_day
    title: Traffic - By Day
    model: finery_data
    explore: sessions
    type: looker_area
    fields: [session_start_calendar.calendar_date_day_of_week, sessions.count]
    fill_fields: [session_start_calendar.calendar_date_day_of_week]
    filters:
      session_start_calendar.calendar_date_week: 1 weeks ago for 1 weeks
    sorts: [session_start_calendar.calendar_date_day_of_week]
    limit: 500
    column_limit: 50
    stacking: ''
    show_value_labels: true
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
    point_style: circle_outline
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    ordering: none
    show_null_labels: false
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: positron
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    value_labels: legend
    label_type: labPer
    series_types: {}
    hide_legend: true
    colors: ["#62bad4", "#a9c574", "#929292", "#9fdee0", "#1f3e5a", "#90c8ae", "#92818d",
      "#c5c6a6", "#82c2ca", "#cee0a0", "#928fb4", "#9fc190", "#9fc190", "#9fc190"]
    series_colors: {}
    y_axes: [{label: '', maxValue: !!null '', minValue: !!null '', orientation: left,
        showLabels: false, showValues: true, tickDensity: default, tickDensityCustom: 5,
        type: linear, unpinAxis: false, valueFormat: !!null '', series: [{id: sessions.count,
            name: Visits Total, axisId: sessions.count}]}]
    width: 6
    height: 3
    top: 39
    left: 0


  - name: revenue_graph_by_day
    title: Revenue Ex. Discount - By Day
    model: finery_data
    explore: sessions
    type: looker_area
    fields: [session_start_calendar.calendar_date_day_of_week, sessions.sum_gross_revenue_ex_discount]
    fill_fields: [session_start_calendar.calendar_date_day_of_week]
    filters:
      session_start_calendar.calendar_date_week: 1 weeks ago for 1 weeks
    sorts: [session_start_calendar.calendar_date_day_of_week]
    limit: 500
    column_limit: 50
    stacking: ''
    show_value_labels: true
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
    point_style: circle_outline
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    ordering: none
    show_null_labels: false
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: positron
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    value_labels: legend
    label_type: labPer
    series_types: {}
    hide_legend: true
    colors: ["#62bad4", "#a9c574", "#929292", "#9fdee0", "#1f3e5a", "#90c8ae", "#92818d",
      "#c5c6a6", "#82c2ca", "#cee0a0", "#928fb4", "#9fc190", "#9fc190", "#9fc190"]
    series_colors: {}
    y_axes: [{label: '', maxValue: !!null '', minValue: !!null '', orientation: left,
        showLabels: false, showValues: true, tickDensity: default, tickDensityCustom: !!null '',
        type: linear, unpinAxis: false, valueFormat: !!null '', series: [{id: sessions.sum_gross_revenue_ex_discount,
            name: Sum Gross Revenue Ex Discount, axisId: sessions.sum_gross_revenue_ex_discount,
            __FILE: finery_data/marketing_report_weekly.dashboard.lookml, __LINE_NUM: 849}],
        __FILE: finery_data/marketing_report_weekly.dashboard.lookml, __LINE_NUM: 847}]
    width: 6
    height: 3
    top: 39
    left: 6


  - name: orders_graph_by_day
    title: Orders - By Day
    model: finery_data
    explore: sessions
    type: looker_area
    fields: [session_start_calendar.calendar_date_day_of_week, sessions.sum_orders]
    fill_fields: [session_start_calendar.calendar_date_day_of_week]
    filters:
      session_start_calendar.calendar_date_week: 1 weeks ago for 1 weeks
    sorts: [session_start_calendar.calendar_date_day_of_week]
    limit: 500
    column_limit: 50
    stacking: ''
    show_value_labels: true
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
    point_style: circle_outline
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    ordering: none
    show_null_labels: false
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: positron
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    value_labels: legend
    label_type: labPer
    series_types: {}
    hide_legend: true
    colors: ["#62bad4", "#a9c574", "#929292", "#9fdee0", "#1f3e5a", "#90c8ae", "#92818d",
      "#c5c6a6", "#82c2ca", "#cee0a0", "#928fb4", "#9fc190", "#9fc190", "#9fc190"]
    series_colors: {}
    y_axes: [{label: '', maxValue: !!null '', minValue: !!null '', orientation: left,
        showLabels: false, showValues: true, tickDensity: default, tickDensityCustom: !!null '',
        type: linear, unpinAxis: false, valueFormat: !!null '', series: [{id: sessions.sum_orders,
            name: Sum Orders, axisId: sessions.sum_orders, __FILE: finery_data/marketing_report_weekly.dashboard.lookml,
            __LINE_NUM: 930}], __FILE: finery_data/marketing_report_weekly.dashboard.lookml,
        __LINE_NUM: 928}]
    width: 6
    height: 3
    top: 42
    left: 0


  - name: conversion_graph_by_day
    title: Conversion Rate - By Day
    model: finery_data
    explore: sessions
    type: looker_area
    fields: [session_start_calendar.calendar_date_day_of_week, sessions.conversion_rate]
    fill_fields: [session_start_calendar.calendar_date_day_of_week]
    filters:
      session_start_calendar.calendar_date_week: 1 weeks ago for 1 weeks
    sorts: [session_start_calendar.calendar_date_day_of_week]
    limit: 500
    column_limit: 50
    stacking: ''
    show_value_labels: true
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
    point_style: circle_outline
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    ordering: none
    show_null_labels: false
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: positron
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    value_labels: legend
    label_type: labPer
    series_types: {}
    hide_legend: true
    colors: ["#62bad4", "#a9c574", "#929292", "#9fdee0", "#1f3e5a", "#90c8ae", "#92818d",
      "#c5c6a6", "#82c2ca", "#cee0a0", "#928fb4", "#9fc190", "#9fc190", "#9fc190"]
    series_colors: {}
    y_axes: [{label: '', maxValue: !!null '', minValue: !!null '', orientation: left,
        showLabels: false, showValues: true, tickDensity: default, tickDensityCustom: !!null '',
        type: linear, unpinAxis: false, valueFormat: !!null '', series: [{id: sessions.conversion_rate,
            name: Conversion Rate, axisId: sessions.conversion_rate, __FILE: finery_data/marketing_report_weekly.dashboard.lookml,
            __LINE_NUM: 1011}], __FILE: finery_data/marketing_report_weekly.dashboard.lookml,
        __LINE_NUM: 1009}]
    width: 6
    height: 3
    top: 42
    left: 6


  - name: average_basket_graph_by_day
    title: Average Basket - By Day
    model: finery_data
    explore: sessions
    type: looker_area
    fields: [session_start_calendar.calendar_date_day_of_week, sessions.average_basket_size]
    fill_fields: [session_start_calendar.calendar_date_day_of_week]
    filters:
      session_start_calendar.calendar_date_week: 1 weeks ago for 1 weeks
    sorts: [session_start_calendar.calendar_date_day_of_week]
    limit: 500
    column_limit: 50
    stacking: ''
    show_value_labels: true
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
    point_style: circle_outline
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    ordering: none
    show_null_labels: false
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: positron
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    value_labels: legend
    label_type: labPer
    series_types: {}
    hide_legend: true
    colors: ["#62bad4", "#a9c574", "#929292", "#9fdee0", "#1f3e5a", "#90c8ae", "#92818d",
      "#c5c6a6", "#82c2ca", "#cee0a0", "#928fb4", "#9fc190", "#9fc190", "#9fc190"]
    series_colors: {}
    y_axes: [{label: '', maxValue: !!null '', minValue: !!null '', orientation: left,
        showLabels: false, showValues: true, tickDensity: default, tickDensityCustom: !!null '',
        type: linear, unpinAxis: false, valueFormat: !!null '', series: [{id: sessions.average_basket_size,
            name: Average Basket Size, axisId: sessions.average_basket_size, __FILE: finery_data/marketing_report_weekly.dashboard.lookml,
            __LINE_NUM: 1092}], __FILE: finery_data/marketing_report_weekly.dashboard.lookml,
        __LINE_NUM: 1090}]
    width: 6
    height: 3
    top: 45
    left: 3
