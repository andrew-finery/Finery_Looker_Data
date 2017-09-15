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
    title: Add To Cart Rate
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


  - name: top_exit_page
    title: Top Exit Page
    model: finery_data
    explore: website_page_views
    type: table
    fields: [visits.exit_page_path, website_page_views.count_total_page_views_yesterday,
      website_page_views.count_distinct_page_views_yesterday, website_page_views.exit_rate_yesterday,
      website_page_views.exit_rate_lw, website_page_views.exit_rate_wow, website_page_views.exit_rate_l7d,
      website_page_views.exit_rate_l7d_percentage]
    sorts: [website_page_views.count_distinct_page_views_yesterday desc]
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
      website_page_views.exit_rate_yesterday: Exit Rate
      website_page_views.count_distinct_page_views_yesterday: No. Of Exits Yest
      website_page_views.exit_rate_lw: LW
      website_page_views.exit_rate_wow: "%"
      website_page_views.exit_rate_l7d: Last 7 Days
      website_page_views.exit_rate_l7d_percentage: L7D%
      website_page_views.count_total_page_views_yesterday: Times Viewed
    width: 12
    height: 3
    top: 9
    left: 0


  - name: top_products_viewed_yesterday
    title: Top Products Viewed - Yesterday
    model: finery_data
    explore: product_info_option_daily
    type: table
    fields: [option_info.option, product_info_option_daily.sum_product_page_views, product_info_option_daily.add_to_carts,
      product_info_option_daily.sum_items_sold, option_info.option_image, product_info_option_daily.conversion_rate,
      product_info_option_daily.sum_gross_revenue_gbp]
    filters:
      product_info_option_daily.calendar_date_week: 1 days ago for 1 days
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
    height: 15
    top: 12
    left: 0

  - name: top_products_sold_yesterday
    title: Top Products Sold - Yesterday
    model: finery_data
    explore: product_info_option_daily
    type: table
    fields: [option_info.option, option_info.option_image, product_info_option_daily.sum_product_page_views,
      product_info_option_daily.add_to_carts, product_info_option_daily.sum_items_sold,
      product_info_option_daily.conversion_rate, product_info_option_daily.sum_gross_revenue_gbp]
    filters:
      product_info_option_daily.calendar_date_week: 1 days ago for 1 days
    sorts: [product_info_option_daily.sum_items_sold desc]
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
    height: 15
    top: 27
    left: 0


  - name: top_products_viewed_last_7_days
    title: Top Products Viewed - Last 7 Days
    model: finery_data
    explore: product_info_option_daily
    type: table
    fields: [option_info.option, product_info_option_daily.sum_product_page_views, product_info_option_daily.add_to_carts,
      product_info_option_daily.sum_items_sold, option_info.option_image, product_info_option_daily.conversion_rate,
      product_info_option_daily.sum_gross_revenue_gbp]
    filters:
      product_info_option_daily.calendar_date_week: 7 days ago for 7 days
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
    height: 15
    top: 42
    left: 0


  - name: top_products_sold_last_7_days
    title: Top Products Sold Last 7 Days
    model: finery_data
    explore: product_info_option_daily
    type: table
    fields: [option_info.option, option_info.option_image, product_info_option_daily.sum_product_page_views,
      product_info_option_daily.add_to_carts, product_info_option_daily.sum_items_sold,
      product_info_option_daily.conversion_rate, product_info_option_daily.sum_gross_revenue_gbp]
    filters:
      product_info_option_daily.calendar_date_week: 7 days ago for 7 days
    sorts: [product_info_option_daily.sum_items_sold desc]
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
    height: 15
    top: 57
    left: 0
