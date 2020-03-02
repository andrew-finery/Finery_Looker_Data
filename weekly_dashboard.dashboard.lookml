- dashboard: weekly_dashboard
  title: Weekly Dashboard
  layout: newspaper


  elements:

  - name: traffic_last_week
    title: Traffic Last Week
    model: finery_data
    explore: sessions
    type: single_value
    fields: [sessions.count]
    filters:
      session_start_calendar.calendar_date_date: 1 weeks ago for 1 weeks
    limit: 500
    column_limit: 50
    query_timezone: Europe/London
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    single_value_title: Traffic Last Week
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    series_types: {}
    height: 6
    width: 6


  - name: total_orders
    title: Orders
    model: finery_data
    explore: spree_order_items
    type: single_value
    fields: [spree_orders.count_orders]
    filters:
      calendar_weeks.calendar_date_date: 1 weeks ago for 1 weeks
    limit: 500
    query_timezone: Europe/London
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    single_value_title: Total Orders Last week
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    series_types: {}
    height: 6
    width: 6
    col: 6


  - name: conversion_last_week
    title: Conversion Last Week
    model: finery_data
    explore: sessions
    type: single_value
    fields: [sessions.conversion_rate]
    filters:
      session_start_calendar.calendar_date_date: 1 weeks ago for 1 weeks
    limit: 500
    column_limit: 50
    query_timezone: Europe/London
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    single_value_title: Conversion Rate Last Week
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    series_types: {}
    height: 6
    width: 6
    col: 12


  - name: aov_last_week
    title: AOV Last Week
    model: finery_data
    explore: spree_order_items
    type: single_value
    fields: [spree_orders.avg_gross_revenue_ex_discount_in_gbp]
    filters:
      calendar_weeks.calendar_date_date: 1 weeks ago for 1 weeks
    limit: 500
    dynamic_fields:
    - table_calculation: calculation_1
      label: Calculation 1
      expression: "${spree_orders.avg_gross_revenue_ex_discount_in_gbp}"
      value_format:
      value_format_name: gbp_0
      _kind_hint: measure
      _type_hint: number
    query_timezone: Europe/London
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    single_value_title: AOV Last Week
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    series_types: {}
    height: 6
    width: 6
    col: 18



  - name: new_customers_yoy
    title: New Customers
    model: finery_data
    explore: spree_orders
    type: looker_area
    fields: [spree_orders.count_new_customers_ytd, calendar_weeks.week_number, spree_orders.count_new_customers_ytd_ly]
    filters:
      spree_orders.count_new_customers_ytd_ly: not 0
    sorts: [calendar_weeks.week_number]
    limit: 500
    color_application:
      collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
      custom:
        id: 6efd826c-c970-65a7-e409-c28776430cb6
        label: Custom
        type: continuous
        stops:
        - color: "#c73011"
          offset: 0
        - color: "#2344c7"
          offset: 100
      options:
        steps: 5
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    y_axes: [{label: '', orientation: left, series: [{axisId: spree_orders.count_new_customers_ytd,
            id: spree_orders.count_new_customers_ytd, name: New Customers YTD}, {axisId: spree_orders.count_new_customers_ytd_ly,
            id: spree_orders.count_new_customers_ytd_ly, name: New Customers YTD LY}],
        showLabels: true, showValues: true, unpinAxis: true, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    limit_displayed_rows_values:
      show_hide: hide
      first_last: last
      num_rows: '20'
    hidden_series: []
    legend_position: center
    series_types: {}
    point_style: circle_outline
    series_colors: {}
    series_labels:
      spree_orders.count_new_customers_ytd: '2020'
      spree_orders.count_new_customers_ytd_ly: '2019'
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    trend_lines: []
    swap_axes: false
    show_null_points: false
    interpolation: monotone
    discontinuous_nulls: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    width: 24
    height: 8


  - name: customer_second_order_yoy
    title: Customer Placed Second Order
    model: finery_data
    explore: spree_orders
    type: looker_area
    fields: [calendar_weeks.week_number, spree_orders.count_second_order_customers_ytd,
      spree_orders.count_second_order_customers_ytd_ly]
    filters:
      spree_orders.count_new_customers_ytd_ly: not 0
    sorts: [calendar_weeks.week_number]
    limit: 500
    color_application:
      collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
      custom:
        id: a7e7dba4-ed36-8c11-342e-e8fd09c16da1
        label: Custom
        type: continuous
        stops:
        - color: "#46c73b"
          offset: 0
        - color: "#bb6bc7"
          offset: 100
      options:
        steps: 5
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    y_axes: [{label: '', orientation: left, series: [{axisId: spree_orders.count_second_order_customers_ytd,
            id: spree_orders.count_second_order_customers_ytd, name: Second Purchase
              Customers YTD}, {axisId: spree_orders.count_second_order_customers_ytd_ly,
            id: spree_orders.count_second_order_customers_ytd_ly, name: Second Purchase
              Customers YTD LY}], showLabels: true, showValues: true, unpinAxis: true,
        tickDensity: default, type: linear}]
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    limit_displayed_rows_values:
      show_hide: hide
      first_last: last
      num_rows: '20'
    hidden_series: []
    legend_position: center
    series_types: {}
    point_style: circle_outline
    series_colors: {}
    series_labels:
      spree_orders.count_new_customers_ytd: '2020'
      spree_orders.count_new_customers_ytd_ly: '2019'
      spree_orders.count_second_order_customers_ytd: '2020'
      spree_orders.count_second_order_customers_ytd_ly: '2019'
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    trend_lines: []
    swap_axes: false
    show_null_points: false
    interpolation: monotone
    discontinuous_nulls: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    width: 24
    height: 8

  - name: lapsed_won_back
    title: Customers Won Back
    model: finery_data
    explore: spree_orders
    type: looker_area
    fields: [calendar_weeks.week_number, spree_orders.count_customers_ytd, spree_orders.count_customers_ytd_ly]
    filters:
      spree_orders.customer_bucket_when_placing_order: 4. Lapsed Customer
      spree_orders.count_customers_ytd: not 0
    sorts: [calendar_weeks.week_number]
    limit: 500
    color_application:
      collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
      palette_id: fb7bb53e-b77b-4ab6-8274-9d420d3d73f3
      options:
        steps: 5
        __FILE: finery_data/weekly_dashboard.dashboard.lookml
        __LINE_NUM: 136
        reverse: false
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    y_axes: [{label: '', orientation: left, series: [{axisId: spree_orders.count_new_customers_ytd,
            id: spree_orders.count_new_customers_ytd, name: New Customers YTD, __FILE: finery_data/weekly_dashboard.dashboard.lookml,
            __LINE_NUM: 140}, {axisId: spree_orders.count_new_customers_ytd_ly, id: spree_orders.count_new_customers_ytd_ly,
            name: New Customers YTD LY, __FILE: finery_data/weekly_dashboard.dashboard.lookml,
            __LINE_NUM: 141}], showLabels: true, showValues: true, unpinAxis: true,
        tickDensity: default, tickDensityCustom: 5, type: linear, __FILE: finery_data/weekly_dashboard.dashboard.lookml,
        __LINE_NUM: 140}]
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    limit_displayed_rows_values:
      show_hide: hide
      first_last: last
      num_rows: '20'
    hidden_series: []
    legend_position: center
    series_types: {}
    point_style: circle_outline
    series_colors:
      spree_orders.count_customers_ytd: "#170d1f"
      spree_orders.count_customers_ytd_ly: "#f0c819"
    series_labels:
      spree_orders.count_new_customers_ytd: '2020'
      spree_orders.count_new_customers_ytd_ly: '2019'
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    trend_lines: []
    swap_axes: false
    show_null_points: false
    interpolation: monotone
    discontinuous_nulls: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    width: 24
    height: 8


  - name: conversion_funnel
    title: Conversion Funnel
    model: finery_data
    explore: sessions
    type: looker_funnel
    fields: [sessions.1_conversion_funnel_all_sessions, sessions.2_conversion_funnel_category_page,
      sessions.3_conversion_funnel_product_page, sessions.4_conversion_funnel_add_to_cart,
      sessions.5_conversion_funnel_view_cart, sessions.6_conversion_funnel_checkout_registration,
      sessions.7_conversion_funnel_checkout_address, sessions.8_conversion_funnel_checkout_delivery,
      sessions.9_conversion_funnel_checkout_payment, sessions.10_conversion_funnel_order]
    filters:
      session_start_calendar.calendar_date_date: 1 weeks ago for 1 weeks
    limit: 500
    query_timezone: Europe/London
    leftAxisLabelVisible: false
    leftAxisLabel: ''
    rightAxisLabelVisible: false
    rightAxisLabel: ''
    color_application:
      collection_id: legacy
      custom:
        id: 837205f4-4054-6c71-4be0-a111ce81018a
        label: Custom
        type: continuous
        stops:
        - color: "#31bd7b"
          offset: 0
        - color: "#9ec651"
          offset: 100
      options:
        steps: 5
    smoothedBars: false
    orientation: automatic
    labelPosition: left
    percentType: total
    percentPosition: inline
    valuePosition: Hidden
    labelColorEnabled: false
    labelColor: "#FFF"
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    series_labels:
      sessions.1_conversion_funnel_all_sessions: All sessions
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    width: 16
    height: 12



  - name: uk_map
    title: UK Orders By Reigon
    model: finery_data
    explore: spree_order_items
    type: looker_geo_choropleth
    fields: [spree_orders.count_orders, spree_addresses.map_postcode]
    filters:
      spree_addresses.uk_flag: 'Yes'
      calendar_weeks.calendar_date_date: 1 weeks ago for 1 weeks
    sorts: [spree_orders.count_orders desc]
    limit: 500
    query_timezone: Europe/London
    map: uk_postcode_areas
    map_projection: ''
    outer_border_color: "#bfbfbf"
    inner_border_color: "#bfbfbf"
    show_view_names: false
    colors: ["#ff0000"]
    quantize_colors: false
    series_types: {}
    width: 8
    height: 12
    col: 16


  - name: revenue_mom
    title: Gross Revenue MoM
    model: finery_data
    explore: spree_orders
    type: looker_line
    fields: [calendar_weeks.calendar_date_month, spree_orders.completed_day_of_month,
      spree_orders.sum_gross_revenue_ex_discount_in_gbp]
    pivots: [calendar_weeks.calendar_date_month]
    filters:
      calendar_weeks.calendar_date_date: 1 month ago for 2 months
      spree_orders.completed_date: before 0 days ago
    sorts: [calendar_weeks.calendar_date_month desc, spree_orders.completed_day_of_month]
    limit: 31
    dynamic_fields:
    - table_calculation: calculation_3
      label: Calculation 3
      expression: if(is_null(${spree_orders.sum_gross_revenue_ex_discount_in_gbp}),
        null, running_total(${spree_orders.sum_gross_revenue_ex_discount_in_gbp}))
      value_format_name: gbp_0
    hidden_fields: [spree_orders.sum_gross_revenue_ex_discount_in_gbp, calculation_2,
      calculation_1]
    stacking: ''
    colors: [purple, skyblue]
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: true
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: false
    point_style: none
    interpolation: monotone
    width: 12
    height: 13


  - name: promo_code_usage
    title: Promo Code Usage
    model: finery_data
    explore: spree_order_items
    type: table
    fields: [spree_orders.primary_promotion, spree_orders.count_orders]
    filters:
      calendar_weeks.calendar_date_date: 1 weeks ago for 1 weeks
    sorts: [spree_orders.count_orders desc]
    limit: 500
    query_timezone: Europe/London
    show_view_names: false
    show_row_numbers: false
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: gray
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#62bad4",
        font_color: !!null '', color_application: {collection_id: legacy, palette_id: legacy_sequential3},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    width: 12
    height: 6
    col: 12


  - name: revenue_by_device
    title: Gross Revenue By Device
    model: finery_data
    explore: sessions
    type: looker_pie
    fields: [sessions.device_type, transactions.sum_gross_revenue_ex_discount_in_gbp]
    filters:
      session_start_calendar.calendar_date_date: 1 weeks ago for 1 weeks
      sessions.device_type: "-Other/Unknown"
    sorts: [transactions.sum_gross_revenue_ex_discount_in_gbp desc]
    limit: 500
    total: true
    dynamic_fields:
    - table_calculation: calculation_1
      label: Calculation 1
      expression: "${transactions.sum_gross_revenue_ex_discount_in_gbp}"
      value_format:
      value_format_name: gbp_0
      _kind_hint: measure
      _type_hint: number
    query_timezone: Europe/London
    value_labels: labels
    label_type: labVal
    inner_radius: 50
    show_value_labels: true
    font_size: 12
    hide_legend: false
    series_types: {}
    up_color: "#62bad4"
    down_color: "#a9c574"
    total_color: "#929292"
    hidden_fields: [transactions.sum_gross_revenue_ex_discount_in_gbp]
    width: 12
    height: 7
    col: 12


  - name: top_performing_products
    title: Top Performing Products
    model: finery_data
    explore: product_info_option_daily
    type: table
    fields: [option_info.option, option_info.option_image_small, product_info_option_daily.sum_product_impressions,
      product_info_option_daily.sum_products_page_views_lcw, product_info_option_daily.sum_product_clicks,
      product_info_option_daily.click_through_rate, product_info_option_daily.items_sold_lcw,
      product_info_option_daily.conversion_rate_lcw, product_info_option_daily.gross_revenue_lcw,
      product_info_option_daily.closing_stock_end_of_week, product_info_option_daily.revenue_per_1k_impressions]
    filters:
      calendar_weeks.calendar_date_date: 1 weeks ago for 1 weeks
    sorts: [product_info_option_daily.items_sold_lcw desc]
    limit: 15
    column_limit: 50
    show_view_names: false
    show_row_numbers: false
    truncate_column_names: true
    hide_totals: false
    hide_row_totals: false
    series_labels:
      product_info_option_daily.sum_products_page_views_lcw: Page Views
      product_info_option_daily.click_through_rate: CTR
      product_info_option_daily.items_sold_lcw: Items Sold
      product_info_option_daily.conversion_rate_lcw: C.R
      product_info_option_daily.gross_revenue_lcw: Gross Rev.
      product_info_option_daily.revenue_per_1k_impressions: Rev per 1k Impression
      product_info_option_daily.closing_stock_end_of_week: Stock
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#62bad4",
        font_color: !!null '', color_application: {collection_id: legacy, palette_id: legacy_sequential3},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    conditional_formatting_ignored_fields: []
    width: 24
    height: 16



  - name: low_performing_products
    title: Under Performing Products
    model: finery_data
    explore: product_info_option_daily
    type: table
    fields: [option_info.option, option_info.option_image_small, option_info.size_availability,
      product_info_option_daily.sum_product_impressions, product_info_option_daily.sum_products_page_views_lcw,
      product_info_option_daily.sum_product_clicks, product_info_option_daily.click_through_rate,
      product_info_option_daily.items_sold_lcw, product_info_option_daily.conversion_rate_lcw,
      product_info_option_daily.gross_revenue_lcw, product_info_option_daily.closing_stock_end_of_week]
    filters:
      calendar_weeks.calendar_date_date: 1 weeks ago for 1 weeks
      product_info_option_daily.sum_products_page_views_lcw: ">=100"
      product_info_option_daily.conversion_rate_lcw: "<=0.01"
      product_info_option_daily.on_sale_flag: 'No'
      option_info.coming_soon_flag: 'No'
      product_info_option_daily.items_sold_lcw: "<=3"
      option_info.size_availability: ">0.3"
      option_info.days_online: ">=7"
    sorts: [product_info_option_daily.sum_products_page_views_lcw desc]
    limit: 15
    column_limit: 50
    show_view_names: false
    show_row_numbers: false
    truncate_column_names: true
    hide_totals: false
    hide_row_totals: false
    series_labels:
      product_info_option_daily.sum_products_page_views_lcw: Page Views
      product_info_option_daily.items_sold_lcw: Items Sold
      product_info_option_daily.conversion_rate_lcw: C.R
      product_info_option_daily.gross_revenue_lcw: Gross Rev.
      product_info_option_daily.click_through_rate: CTR
      product_info_option_daily.closing_stock_end_of_week: Stock
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#62bad4",
        font_color: !!null '', color_application: {collection_id: legacy, palette_id: legacy_sequential3},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    conditional_formatting_ignored_fields: []
    width: 24
    height: 16
