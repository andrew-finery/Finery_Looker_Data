- dashboard: marketing_report_monthly
  title: Marketing Report Monthly
  layout: static
  tile_size: 100


  elements:
  - name: visits_pie_chart
    title: Visits - Full Month
    model: finery_data
    explore: sessions
    type: looker_pie
    fields: [sessions.channel_grouping_3, sessions.visits_month_to_date]
    fill_fields: [sessions.channel_grouping_3]
    sorts: [sessions.visits_month_to_date desc]
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
    series_colors:
      CRM (Email): "#04c49c"
      Direct: "#2545aa"
      Search: "#ec8080"
      Referrals: "#f1cd52"
      Paid Social: "#9fdee0"
      Affiliates: "#1f3e5a"
      Organic Social: "#92818d"
    width: 6
    height: 6
    top: 0
    left: 0


  - name: gross_revenue_pie_chart
    title: Gross Revenue - Full Month
    model: finery_data
    explore: sessions
    type: looker_pie
    fields: [sessions.channel_grouping_3, sessions.gross_revenue_ex_discount_month_to_date]
    fill_fields: [sessions.channel_grouping_3]
    sorts: [sessions.gross_revenue_ex_discount_month_to_date desc]
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
    series_colors:
      CRM (Email): "#04c49c"
      Direct: "#2545aa"
      Search: "#ec8080"
      Referrals: "#f1cd52"
      Paid Social: "#9fdee0"
      Affiliates: "#1f3e5a"
      Organic Social: "#92818d"
    width: 6
    height: 6
    top: 0
    left: 6


  - name: orders_pie_chart
    title: Orders - Full Month
    model: finery_data
    explore: sessions
    type: looker_pie
    fields: [sessions.channel_grouping_3, sessions.orders_month_to_date]
    fill_fields: [sessions.channel_grouping_3]
    sorts: [sessions.orders_month_to_date desc]
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
    series_colors:
      CRM (Email): "#04c49c"
      Direct: "#2545aa"
      Search: "#ec8080"
      Referrals: "#f1cd52"
      Paid Social: "#9fdee0"
      Affiliates: "#1f3e5a"
      Organic Social: "#92818d"
    width: 6
    height: 6
    top: 6
    left: 3


  - name: kpi_table
    title: KPI's - Full Month
    model: finery_data
    explore: sessions
    type: table
    fields: [sessions.channel_grouping_3, sessions.visits_month_to_date, sessions.gross_revenue_ex_discount_month_to_date,
      sessions.orders_month_to_date, sessions.conversion_month_to_date, sessions.average_basket_ex_discount_month_to_date]
    fill_fields: [sessions.channel_grouping_3]
    sorts: [sessions.gross_revenue_ex_discount_month_to_date desc]
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
    value_labels: labels
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
    series_colors:
      CRM (Email): "#04c49c"
      Direct: "#2545aa"
      Search: "#ec8080"
      Referrals: "#f1cd52"
      Paid Social: "#9fdee0"
      Affiliates: "#1f3e5a"
      Organic Social: "#92818d"
    series_labels:
      sessions.visits_month_to_date: Visits
      sessions.gross_revenue_ex_discount_month_to_date: Gross Revenue ex. Discount
      sessions.orders_month_to_date: Orders
      sessions.conversion_month_to_date: Conversion Rate
      sessions.average_basket_ex_discount_month_to_date: Average Basket Size
    width: 12
    height: 3
    top: 12
    left: 0



  - name: traffic_table
    title: Traffic
    model: finery_data
    explore: sessions
    type: table
    fields: [sessions.channel_grouping_3, sessions.visits_month_to_date, sessions.visits_month_to_date_last_month,
      sessions.visits_month_to_date_mom, sessions.visits_month_to_date_last_year, sessions.visits_month_to_date_yoy,
      sessions.visits_year_to_date, sessions.visits_year_to_date_last_year, sessions.visits_year_to_date_yoy]
    fill_fields: [sessions.channel_grouping_3]
    sorts: [sessions.visits_month_to_date desc]
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
    value_labels: labels
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
    series_colors:
      CRM (Email): "#04c49c"
      Direct: "#2545aa"
      Search: "#ec8080"
      Referrals: "#f1cd52"
      Paid Social: "#9fdee0"
      Affiliates: "#1f3e5a"
      Organic Social: "#92818d"
    series_labels:
      sessions.visits_month_to_date: LCM
      sessions.gross_revenue_ex_discount_month_to_date: Gross Revenue ex. Discount
      sessions.orders_month_to_date: Orders
      sessions.conversion_month_to_date: Conversion Rate
      sessions.average_basket_ex_discount_month_to_date: Average Basket Size
      sessions.visits_month_to_date_last_month: PCM
      sessions.visits_month_to_date_mom: "%"
      sessions.visits_month_to_date_last_year: LCM LY
      sessions.visits_month_to_date_yoy: LCM YoY
    width: 12
    height: 3
    top: 15
    left: 0



  - name: gross_revenue_table
    title: Gross Revenue ex. Discount
    model: finery_data
    explore: sessions
    type: table
    fields: [sessions.channel_grouping_3, sessions.gross_revenue_ex_discount_month_to_date,
      sessions.gross_revenue_ex_discount_month_to_date_last_month, sessions.gross_revenue_ex_discount_month_to_date_mom,
      sessions.gross_revenue_ex_discount_month_to_date_last_year, sessions.gross_revenue_ex_discount_month_to_date_yoy,
      sessions.gross_revenue_ex_discount_year_to_date, sessions.gross_revenue_ex_discount_year_to_date_last_year,
      sessions.gross_revenue_ex_discount_year_to_date_yoy]
    fill_fields: [sessions.channel_grouping_3]
    sorts: [sessions.gross_revenue_ex_discount_month_to_date desc]
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
    value_labels: labels
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
    series_colors:
      CRM (Email): "#04c49c"
      Direct: "#2545aa"
      Search: "#ec8080"
      Referrals: "#f1cd52"
      Paid Social: "#9fdee0"
      Affiliates: "#1f3e5a"
      Organic Social: "#92818d"
    series_labels:
      sessions.visits_month_to_date: LCM
      sessions.gross_revenue_ex_discount_month_to_date: LCM
      sessions.orders_month_to_date: Orders
      sessions.conversion_month_to_date: Conversion Rate
      sessions.average_basket_ex_discount_month_to_date: Average Basket Size
      sessions.visits_month_to_date_last_month: PCM
      sessions.visits_month_to_date_mom: "%"
      sessions.visits_month_to_date_last_year: LCM LY
      sessions.visits_month_to_date_yoy: LCM YoY
      sessions.gross_revenue_ex_discount_month_to_date_last_month: PCM
      sessions.gross_revenue_ex_discount_month_to_date_mom: "%"
      sessions.gross_revenue_ex_discount_month_to_date_last_year: LCM LY
      sessions.gross_revenue_ex_discount_month_to_date_yoy: LCM YoY
    width: 12
    height: 3
    top: 18
    left: 0


  - name: orders_table
    title: Orders
    model: finery_data
    explore: sessions
    type: table
    fields: [sessions.channel_grouping_3, sessions.orders_month_to_date, sessions.orders_month_to_date_last_month,
      sessions.orders_month_to_date_month_on_month, sessions.orders_month_to_date_last_year,
      sessions.orders_month_to_date_year_on_year, sessions.orders_year_to_date, sessions.orders_year_to_date_last_year,
      sessions.orders_year_to_date_year_on_year]
    fill_fields: [sessions.channel_grouping_3]
    sorts: [sessions.orders_month_to_date desc]
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
    value_labels: labels
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
    series_colors:
      CRM (Email): "#04c49c"
      Direct: "#2545aa"
      Search: "#ec8080"
      Referrals: "#f1cd52"
      Paid Social: "#9fdee0"
      Affiliates: "#1f3e5a"
      Organic Social: "#92818d"
    series_labels:
      sessions.visits_month_to_date: LCM
      sessions.gross_revenue_ex_discount_month_to_date: LCM
      sessions.conversion_month_to_date: Conversion Rate
      sessions.average_basket_ex_discount_month_to_date: Average Basket Size
      sessions.visits_month_to_date_last_month: PCM
      sessions.visits_month_to_date_mom: "%"
      sessions.visits_month_to_date_last_year: LCM LY
      sessions.visits_month_to_date_yoy: LCM YoY
      sessions.gross_revenue_ex_discount_month_to_date_last_month: PCM
      sessions.gross_revenue_ex_discount_month_to_date_mom: "%"
      sessions.gross_revenue_ex_discount_month_to_date_last_year: LCM LY
      sessions.gross_revenue_ex_discount_month_to_date_yoy: LCM YoY
      sessions.orders_month_to_date: LCM
      sessions.orders_month_to_date_last_month: PCM
      sessions.orders_month_to_date_month_on_month: "%"
      sessions.orders_month_to_date_last_year: LCM LY
      sessions.orders_month_to_date_year_on_year: LCM YoY
      sessions.orders_year_to_date: YTD
      sessions.orders_year_to_date_last_year: YTD LY
      sessions.orders_year_to_date_year_on_year: YTD YoY
    width: 12
    height: 3
    top: 21
    left: 0


  - name: conversion_table
    title: Conversion Rate
    model: finery_data
    explore: sessions
    type: table
    fields: [sessions.channel_grouping_3, sessions.conversion_month_to_date, sessions.conversion_month_to_date_last_month,
      sessions.conversion_month_to_date_mom, sessions.conversion_month_to_date_last_year,
      sessions.conversion_month_to_date_yoy, sessions.conversion_year_to_date, sessions.conversion_year_to_date_last_year,
      sessions.conversion_year_to_date_yoy]
    fill_fields: [sessions.channel_grouping_3]
    sorts: [sessions.conversion_month_to_date desc]
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
    value_labels: labels
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
    series_colors:
      CRM (Email): "#04c49c"
      Direct: "#2545aa"
      Search: "#ec8080"
      Referrals: "#f1cd52"
      Paid Social: "#9fdee0"
      Affiliates: "#1f3e5a"
      Organic Social: "#92818d"
    series_labels:
      sessions.visits_month_to_date: LCM
      sessions.gross_revenue_ex_discount_month_to_date: LCM
      sessions.conversion_month_to_date: LCM
      sessions.average_basket_ex_discount_month_to_date: Average Basket Size
      sessions.visits_month_to_date_last_month: PCM
      sessions.visits_month_to_date_mom: "%"
      sessions.visits_month_to_date_last_year: LCM LY
      sessions.visits_month_to_date_yoy: LCM YoY
      sessions.gross_revenue_ex_discount_month_to_date_last_month: PCM
      sessions.gross_revenue_ex_discount_month_to_date_mom: "%"
      sessions.gross_revenue_ex_discount_month_to_date_last_year: LCM LY
      sessions.gross_revenue_ex_discount_month_to_date_yoy: LCM YoY
      sessions.orders_month_to_date: LCM
      sessions.orders_month_to_date_last_month: PCM
      sessions.orders_month_to_date_month_on_month: "%"
      sessions.orders_month_to_date_last_year: LCM LY
      sessions.orders_month_to_date_year_on_year: LCM YoY
      sessions.orders_year_to_date: YTD
      sessions.orders_year_to_date_last_year: YTD LY
      sessions.orders_year_to_date_year_on_year: YTD YoY
      sessions.conversion_month_to_date_last_month: PCM
      sessions.conversion_month_to_date_mom: "%"
      sessions.conversion_month_to_date_last_year: LCM LY
      sessions.conversion_month_to_date_yoy: LCM YoY
    width: 12
    height: 3
    top: 24
    left: 0


  - name: average_basket_table
    title: Average Basket Size
    model: finery_data
    explore: sessions
    type: table
    fields: [sessions.channel_grouping_3, sessions.average_basket_ex_discount_month_to_date,
      sessions.average_basket_ex_discount_month_to_date_last_month, sessions.average_basket_ex_discount_month_to_date_mom,
      sessions.average_basket_ex_discount_month_to_date_last_year, sessions.avereage_basket_ex_discount_month_to_date_yoy,
      sessions.average_basket_ex_discount_year_to_date, sessions.average_basket_ex_discount_year_to_date_last_year,
      sessions.average_basket_ex_discount_year_to_date_yoy_2]
    fill_fields: [sessions.channel_grouping_3]
    sorts: [sessions.average_basket_ex_discount_month_to_date desc]
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
    value_labels: labels
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
    series_colors:
      CRM (Email): "#04c49c"
      Direct: "#2545aa"
      Search: "#ec8080"
      Referrals: "#f1cd52"
      Paid Social: "#9fdee0"
      Affiliates: "#1f3e5a"
      Organic Social: "#92818d"
    series_labels:
      sessions.visits_month_to_date: LCM
      sessions.gross_revenue_ex_discount_month_to_date: LCM
      sessions.conversion_month_to_date: LCM
      sessions.average_basket_ex_discount_month_to_date: LCM
      sessions.visits_month_to_date_last_month: PCM
      sessions.visits_month_to_date_mom: "%"
      sessions.visits_month_to_date_last_year: LCM LY
      sessions.visits_month_to_date_yoy: LCM YoY
      sessions.gross_revenue_ex_discount_month_to_date_last_month: PCM
      sessions.gross_revenue_ex_discount_month_to_date_mom: "%"
      sessions.gross_revenue_ex_discount_month_to_date_last_year: LCM LY
      sessions.gross_revenue_ex_discount_month_to_date_yoy: LCM YoY
      sessions.orders_month_to_date: LCM
      sessions.orders_month_to_date_last_month: PCM
      sessions.orders_month_to_date_month_on_month: "%"
      sessions.orders_month_to_date_last_year: LCM LY
      sessions.orders_month_to_date_year_on_year: LCM YoY
      sessions.orders_year_to_date: YTD
      sessions.orders_year_to_date_last_year: YTD LY
      sessions.orders_year_to_date_year_on_year: YTD YoY
      sessions.conversion_month_to_date_last_month: PCM
      sessions.conversion_month_to_date_mom: "%"
      sessions.conversion_month_to_date_last_year: LCM LY
      sessions.conversion_month_to_date_yoy: LCM YoY
      sessions.average_basket_ex_discount_month_to_date_last_month: PCM
      sessions.average_basket_ex_discount_month_to_date_mom: "%"
      sessions.average_basket_ex_discount_month_to_date_last_year: LCM LY
      sessions.avereage_basket_ex_discount_month_to_date_yoy: LCM YoY
    width: 12
    height: 3
    top: 27
    left: 0


  - name: top_campaign_traffic
    title: Top 10 Campaigns (Traffic)
    model: finery_data
    explore: website_page_views
    type: table
    fields: [visits.campaign_source, visits.campaign_medium, visits.campaign_content,
      visits.campaign_name, visits.campaign_term, visits.count, visits.sum_gross_revenue_ex_discount,
      visits.conversion_rate]
    filters:
      visits.campaign_content: "-EMPTY"
      visits.start_date: 1 months ago for 1 months
    sorts: [visits.count desc]
    limit: 10
    query_timezone: Europe/London
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
    width: 12
    height: 5
    top: 30
    left: 0
