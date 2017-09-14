- dashboard: website_interaction_dashboard
  title: Website Interaction Dashboard
  layout: static
  tile_size: 100

  filters:

  elements:

  - name: page_views_per_visit
    title: Page Views Per Visit
    model: finery_data
    explore: sessions
    type: table
    fields: [sessions.page_views_per_visit, sessions.page_views_lw, sessions.page_views_wow,
      sessions.page_views_last_7_days, sessions.page_views_last_7_days_percentage]
    limit: 500
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
    width: 12
    height: 1
    top: 0
    left: 0


  - name: product_views_per_visit
    title: Product Views Per Visit
    model: finery_data
    explore: sessions
    type: table
    fields: [sessions.product_views_per_visit, sessions.product_views_lw, sessions.product_views_wow,
      sessions.product_views_last_7_days, sessions.product_views_last_7_days_percentage]
    limit: 500
    column_limit: 50
    width: 12
    height: 1
    top: 1
    left: 0

  - name: conversion_rate
    title: Conversion Rate
    model: finery_data
    explore: sessions
    type: table
    fields: [sessions.conversion_yesterday, sessions.conversion_yesterday_last_week,
      sessions.conversion_yesterday_wow, sessions.conversion_rate_last_7_days, sessions.conversion_last_7_days_percentage]
    limit: 500
    column_limit: 50
    width: 12
    height: 1
    top: 2
    left: 0

  - name: engagement_rate
    title: Engagement Rate
    model: finery_data
    explore: sessions
    type: table
    fields: [sessions.engagement_rate_yesterday, sessions.engagement_rate_lw, sessions.engagement_rate_wow,
      sessions.engagement_rate_last_7_days, sessions.engagement_rate_last_7_days_percentage]
    limit: 500
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
    width: 12
    height: 1
    top: 3
    left: 0

  - name: bounce_rate
    title: Bounce Rate
    model: finery_data
    explore: sessions
    type: table
    fields: [sessions.bounce_rate_yesterday, sessions.bounce_rate_lw, sessions.bounce_rate_wow,
      sessions.bounce_rate_last_7_days, sessions.bounce_rate_last_7_days_percentage]
    limit: 500
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
    width: 12
    height: 1
    top: 4
    left: 0

  - name: add_to_cart_rate
    title: Add To Cart
    model: finery_data
    explore: sessions
    type: table
    fields: [sessions.add_to_cart_rate_yesterday, sessions.add_to_cart_rate_lw, sessions.add_to_cart_rate_wow,
      sessions.add_to_cart_rate_last_7_days, sessions.add_to_cart_rate_last_7_days_percentage]
    limit: 500
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
    width: 12
    height: 1
    top: 5
    left: 0


  - name: landing_page_bounced_visits
    title: Landing Page With Bounce Rate
    model: finery_data
    explore: sessions
    type: table
    fields: [sessions.visits_yesterday, sessions.bounce_rate_yesterday, sessions.bounce_rate_lw,
      sessions.bounce_rate_wow, sessions.bounce_rate_last_7_days, sessions.bounce_rate_last_7_days_percentage,
      sessions.landing_page_path]
    sorts: [sessions.visits_yesterday desc]
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
      sessions.visits_yesterday: Visits Yest.
      sessions.bounce_rate_yesterday: Bounce Rate
    width: 12
    height: 3
    top: 6
    left: 0


  - name: website_top_exit_page
    title: Website Top Exit Page - Last 2 Weeks
    model: finery_data
    explore: website_page_views
    type: table
    fields: [visits.start_week, website_page_views.count_exits, website_page_views.bounce_rate,
      visits.exit_page_path]
    filters:
      visits.start_week: 2 weeks ago for 2 weeks
    sorts: [website_page_views.count_exits desc]
    limit: 10
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
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_null_points: true
    point_style: circle
    interpolation: linear
    series_types: {}
    width: 12
    height: 3
    top: 9
    left: 0



  - name: top_products_viewed_last_week
    title: Top Products Viewed - Last Week
    model: finery_data
    explore: product_info_option_daily
    type: table
    fields: [product_info_option_daily.calendar_date_week, option_info.option, product_info_option_daily.sum_product_page_views,
      product_info_option_daily.add_to_carts, product_info_option_daily.sum_items_sold,
      option_info.option_image]
    filters:
      product_info_option_daily.calendar_date_week: 1 weeks ago for 1 weeks
      product_info_option_daily.sum_product_page_views: not 0
    sorts: [product_info_option_daily.sum_product_page_views desc]
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
    width: 12
    height: 6
    top: 12
    left: 0


  - name: top_products_viewed_2_weeks_ago
    title: Top Products Viewed - 2 Weeks Ago
    model: finery_data
    explore: product_info_option_daily
    type: table
    fields: [product_info_option_daily.calendar_date_week, option_info.option, product_info_option_daily.sum_product_page_views,
      product_info_option_daily.add_to_carts, product_info_option_daily.sum_items_sold,
      option_info.option_image]
    filters:
      product_info_option_daily.calendar_date_week: 2 weeks ago for 1 weeks
      product_info_option_daily.sum_product_page_views: not 0
    sorts: [product_info_option_daily.sum_product_page_views desc]
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
    width: 12
    height: 6
    top: 18
    left: 0


  - name: add_a_unique_name_1505213099
    title: Untitled Visualization
    model: finery_data
    explore: product_info_option_daily
    type: table
    fields: [product_info_option_daily.calendar_date_week, option_info.option, product_info_option_daily.add_to_carts,
      product_info_option_daily.sum_items_sold, product_info_option_daily.sum_product_page_views,
      option_info.option_image]
    filters:
      product_info_option_daily.calendar_date_week: 1 weeks ago for 1 weeks
      product_info_option_daily.sum_product_page_views: not 0
    sorts: [product_info_option_daily.add_to_carts desc]
    limit: 10
    column_limit: 50
    dynamic_fields:
    - table_calculation: prod_cr
      label: Prod. CR %
      expression: "${product_info_option_daily.sum_items_sold}/${product_info_option_daily.sum_product_page_views}"
      value_format:
      value_format_name: percent_1
      _kind_hint: measure
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
    width: 12
    height: 6
    top: 24
    left: 0



  - name: top_products_added_to_cart_2_weeks_ago
    title: Top Products Added To Cart - 2 Weeks Ago
    model: finery_data
    explore: product_info_option_daily
    type: table
    fields: [product_info_option_daily.calendar_date_week, option_info.option, product_info_option_daily.add_to_carts,
      product_info_option_daily.sum_items_sold, product_info_option_daily.sum_product_page_views,
      option_info.option_image]
    filters:
      product_info_option_daily.calendar_date_week: 2 weeks ago for 1 weeks
      product_info_option_daily.sum_product_page_views: not 0
    sorts: [product_info_option_daily.add_to_carts desc]
    limit: 10
    column_limit: 50
    dynamic_fields:
    - table_calculation: prod_cr
      label: Prod. CR %
      expression: "${product_info_option_daily.sum_items_sold}/${product_info_option_daily.sum_product_page_views}"
      value_format:
      value_format_name: percent_1
      _kind_hint: measure
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
    width: 12
    height: 6
    top: 30
    left: 0



  - name: top_products_sold_last_week
    title: Top Products Sold Last Week
    model: finery_data
    explore: product_info_option_daily
    type: table
    fields: [product_info_option_daily.calendar_date_week, option_info.option, product_info_option_daily.sum_items_sold,
      product_info_option_daily.add_to_carts, product_info_option_daily.sum_product_page_views]
    filters:
      product_info_option_daily.calendar_date_week: 1 weeks ago for 1 weeks
      product_info_option_daily.sum_product_page_views: not 0
    sorts: [product_info_option_daily.sum_items_sold desc]
    limit: 10
    column_limit: 50
    width: 12
    height: 4
    top: 36
    left: 0


  - name: top_products_sold_two_weeks_ago
    title: Top Products Sold 2 Weeks Ago
    model: finery_data
    explore: product_info_option_daily
    type: table
    fields: [product_info_option_daily.calendar_date_week, option_info.option, product_info_option_daily.sum_items_sold,
      product_info_option_daily.add_to_carts, product_info_option_daily.sum_product_page_views]
    filters:
      product_info_option_daily.calendar_date_week: 2 weeks ago for 1 weeks
      product_info_option_daily.sum_product_page_views: not 0
    sorts: [product_info_option_daily.sum_items_sold desc]
    limit: 10
    column_limit: 50
    width: 12
    height: 4
    top: 40
    left: 0
