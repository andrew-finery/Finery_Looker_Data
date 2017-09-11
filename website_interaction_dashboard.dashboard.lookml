- dashboard: website_interaction_dashboard
  title: Website Interaction Dashboard
  layout: static
  tile_size: 100

  filters:

  elements:

  - name: page_views_per_visit
    title: Website Page Views Per Visit
    model: finery_data
    explore: website_page_views
    type: table
    fields: [visits.start_week, visits.page_views_per_visit]
    fill_fields: [visits.start_week]
    filters:
      visits.start_week: 2 weeks ago for 2 weeks
    sorts: [visits.start_week desc]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - table_calculation: change_wow
      label: "% Change"
      expression: "${visits.page_views_per_visit}/offset(${visits.page_views_per_visit},1)-1"
      value_format:
      value_format_name: percent_1
      _kind_hint: measure
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
    width: 9
    height: 2
    top: 0
    left: -3



  - name: product_views_per_visit
    title: Website Product Views Per Visit
    model: finery_data
    explore: website_page_views
    type: table
    fields: [visits.start_week, visits.product_views_per_visit]
    fill_fields: [visits.start_week]
    filters:
      visits.start_week: 2 weeks ago for 2 weeks
    sorts: [visits.start_week desc]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - table_calculation: of_change
      label: "% of change"
      expression: "${visits.product_views_per_visit}/offset(${visits.product_views_per_visit},1)-1"
      value_format:
      value_format_name: percent_1
      _kind_hint: measure
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
    width: 9
    height: 2
    top: 0
    left: 6



  - name: engaged_visits_last_two_weeks
    title: Engaged Website Visits - Last 2 Weeks
    model: finery_data
    explore: website_page_views
    type: table
    fields: [visits.start_week, visits.engagement_rate, visits.conversion_rate, visits.4_conversion_funnel_add_to_cart,
      visits.bounce_rate]
    fill_fields: [visits.start_week]
    filters:
      visits.start_week: 2 weeks ago for 2 weeks
    sorts: [visits.start_week desc]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - table_calculation: engagement_diff
      label: Engagement Diff %
      expression: "${visits.engagement_rate}/offset(${visits.engagement_rate},1)-1"
      value_format:
      value_format_name: percent_1
      _kind_hint: measure
    - table_calculation: conversion_rate_diff
      label: Conversion Rate Diff %
      expression: "${visits.conversion_rate}/offset(${visits.conversion_rate},1)-1"
      value_format:
      value_format_name: percent_1
      _kind_hint: measure
    - table_calculation: add_to_cart_diff
      label: Add To Cart Diff %
      expression: "${visits.4_conversion_funnel_add_to_cart}/offset(${visits.4_conversion_funnel_add_to_cart},1)-1"
      value_format:
      value_format_name: percent_1
      _kind_hint: measure
    - table_calculation: bounce_rate_diff
      label: Bounce Rate Diff %
      expression: "${visits.bounce_rate}/offset(${visits.bounce_rate},1)-1"
      value_format:
      value_format_name: percent_1
      _kind_hint: measure
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
    width: 18
    height: 2
    top: 2
    left: -3



  - name: website_top_landing_page
    title: Website Top Landing Page
    model: finery_data
    explore: website_page_views
    type: table
    fields: [visits.start_week, website_page_views.count_lands, website_page_views.bounce_rate,
      visits.landing_page_type]
    filters:
      visits.start_week: 2 weeks ago for 2 weeks
    sorts: [website_page_views.count_lands desc]
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
    point_style: circle
    interpolation: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    hidden_series: [website_page_views.bounce_rate]
    width: 9
    height: 3
    top: 4
    left: -3



  - name: website_top_exit_page
    title: Website Top Exit Page
    model: finery_data
    explore: website_page_views
    type: table
    fields: [visits.start_week, visits.landing_page_type, website_page_views.count_exits,
      website_page_views.bounce_rate]
    filters:
      visits.start_week: 2 weeks ago for 2 weeks
    sorts: [website_page_views.count_exits desc]
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
    width: 9
    height: 3
    top: 4
    left: 6



  - name: top_products_viewed_last_week
    title: Top Products Viewed Last Week
    model: finery_data
    explore: product_info_option_daily
    type: table
    fields: [product_info_option_daily.calendar_date_week, option_info.option, product_info_option_daily.sum_product_page_views,
      product_info_option_daily.add_to_carts, product_info_option_daily.sum_items_sold]
    filters:
      product_info_option_daily.calendar_date_week: 1 weeks ago for 1 weeks
      product_info_option_daily.sum_product_page_views: not 0
    sorts: [product_info_option_daily.sum_product_page_views desc]
    limit: 10
    column_limit: 50
    width: 9
    height: 4
    top: 7
    left: -3


  - name: top_products_viewed_2_weeks_ago
    title: Top Products Viewed 2 Weeks Ago
    model: finery_data
    explore: product_info_option_daily
    type: table
    fields: [product_info_option_daily.calendar_date_week, option_info.option, product_info_option_daily.sum_product_page_views,
      product_info_option_daily.add_to_carts, product_info_option_daily.sum_items_sold]
    filters:
      product_info_option_daily.calendar_date_week: 2 weeks ago for 1 weeks
      product_info_option_daily.sum_product_page_views: not 0
    sorts: [product_info_option_daily.sum_product_page_views desc]
    limit: 10
    column_limit: 50
    width: 9
    height: 4
    top: 7
    left: 6


  - name: top_products_add_to_cart_last_week
    title: Top Products Add To Cart Last Week
    model: finery_data
    explore: product_info_option_daily
    type: table
    fields: [product_info_option_daily.calendar_date_week, option_info.option, product_info_option_daily.add_to_carts,
      product_info_option_daily.sum_items_sold, product_info_option_daily.sum_product_page_views]
    filters:
      product_info_option_daily.calendar_date_week: 1 weeks ago for 1 weeks
      product_info_option_daily.sum_product_page_views: not 0
    sorts: [product_info_option_daily.add_to_carts desc]
    limit: 10
    column_limit: 50
    dynamic_fields:
    - table_calculation: of_add_to_cart_sales_completed
      label: "% of add to cart sales completed"
      expression: "${product_info_option_daily.sum_items_sold}/${product_info_option_daily.add_to_carts}"
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
    width: 9
    height: 4
    top: 11
    left: -3



  - name: top_products_add_to_cart_2_weeks_ago
    title: Top Products Add To Cart 2 Weeks Ago
    model: finery_data
    explore: product_info_option_daily
    type: table
    fields: [product_info_option_daily.calendar_date_week, option_info.option, product_info_option_daily.add_to_carts,
      product_info_option_daily.sum_items_sold, product_info_option_daily.sum_product_page_views]
    filters:
      product_info_option_daily.calendar_date_week: 2 weeks ago for 1 weeks
      product_info_option_daily.sum_product_page_views: not 0
    sorts: [product_info_option_daily.add_to_carts desc]
    limit: 10
    column_limit: 50
    dynamic_fields:
    - table_calculation: of_add_to_cart_sales_completed
      label: "% of add to cart sales completed"
      expression: "${product_info_option_daily.sum_items_sold}/${product_info_option_daily.add_to_carts}"
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
    width: 9
    height: 4
    top: 11
    left: 6



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
    width: 9
    height: 4
    top: 15
    left: -3


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
    width: 9
    height: 4
    top: 15
    left: 6
