- dashboard: website_daily_kpis
  title: Website Daily KPIs
  layout: grid

  rows:
    - elements: [visits_yesterday, visits_by_day]
      height: 250
    - elements: [conversion_rate_yesterday, conversion_rate_by_day]
      height: 250
    - elements: [bounce_rate_yesterday, bounce_rate_by_day]
      height: 250
    - elements: [engagement_rate_yesterday, engagement_rate_by_day]
      height: 250
    - elements: [page_views_per_visit_yesterday, page_views_per_visit_by_day]
      height: 250
    - elements: [product_views_per_visit_yesterday, product_views_per_visit_by_day]
      height: 250
    - elements: [product_conversion_rate_yesterday, product_conversion_rate_by_day]
      height: 250
    - elements: [products_impressions_per_visit_yesterday, products_impressions_per_visit_by_day]
      height: 250
    - elements: [revenue_per_1k_impressions_yesterday, revenue_per_1k_impressions_by_day]
      height: 250
    - elements: [sum_gross_revenue_ex_discount_yesterday, sum_gross_revenue_ex_discount_by_day]
      height: 250
    - elements: [average_basket_size_yesterday, average_basket_size_by_day]
      height: 250
    - elements: [average_items_in_basket_yesterday, average_items_in_basket_by_day]
      height: 250
    - elements: [average_selling_price_yesterday, average_selling_price_by_day]
      height: 250
# % sale product views
# FP product CR
# Sale Product CR

# % Sale Impressions
# FP Rev/1k Imp
# SAle Rev/1k imp

    - elements: [sum_newsletter_signups_yesterday, sum_newsletter_signups_by_day]
      height: 250
    - elements: [nl_signup_rate_yesterday, nl_signup_rate_by_day]
      height: 250
    - elements: [dropout_rate_1_yesterday, dropout_rate_1_by_day]
      height: 250
    - elements: [dropout_rate_2_yesterday, dropout_rate_2_by_day]
      height: 250
    - elements: [dropout_rate_3_yesterday, dropout_rate_3_by_day]
      height: 250
    - elements: [dropout_rate_4_yesterday, dropout_rate_4_by_day]
      height: 250
    - elements: [dropout_rate_5_yesterday, dropout_rate_5_by_day]
      height: 250
    - elements: [dropout_rate_6_yesterday, dropout_rate_6_by_day]
      height: 250
    - elements: [dropout_rate_7_yesterday, dropout_rate_7_by_day]
      height: 250
    - elements: [dropout_rate_8_yesterday, dropout_rate_8_by_day]
      height: 250
    - elements: [dropout_rate_9_yesterday, dropout_rate_9_by_day]
      height: 250
    - elements: [cart_abandonment_rate_yesterday, cart_abandonment_rate_by_day]
      height: 250
    - elements: [products_added_to_cart_per_visit_yesterday, products_added_to_cart_per_visit_by_day]
      height: 250
    - elements: [product_added_to_cart_view_ratio_yesterday, product_added_to_cart_view_ratio_by_day]
      height: 250
    - elements: [checkout_abandonment_rate_yesterday, checkout_abandonment_rate_by_day]
      height: 250





  filters:

  - name: date
    title: "Date"
    type: date_filter
    default_value: 30 days ago for 30 days
  - name: marketing_channel
    title: "Marketing Channel"
    type: field_filter
    explore: sessions
    field: sessions.acquisition_channel
    default_value:
  - name: device
    title: "Device"
    type: field_filter
    explore: sessions
    field: sessions.device_type
    default_value:
  - name: country
    title: "Country"
    type: field_filter
    explore: sessions
    field: sessions.geography_country
    default_value:

  elements:

## Visits Row

  - name: visits_yesterday
    title: Visits Yesterday
    type: single_value
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_week]
    fill_fields: [session_start_calendar.calendar_date_week]
    measures: [sessions.count]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Week on Week
      expression: "(${sessions.count} - offset(${sessions.count},1))/offset(${sessions.count},1)"
      value_format:
      value_format_name: percent_1
    filters:
      sessions.start_date: 1 day ago, 8 days ago
    listen:
     marketing_channel: sessions.acquisition_channel
     device: sessions.device_type
     country: sessions.geography_country
    sorts: [session_start_calendar.calendar_date_week desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
    custom_color_enabled: true
    custom_color: "#1a3fd5"
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
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
    comparison_label: Week on Week

  - name: visits_by_day
    title: Visits by Day
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_date]
    fill_fields: [sessions.start_date]
    measures: [sessions.count]
    listen:
     date: sessions.start_date
     marketing_channel: sessions.acquisition_channel
     device: sessions.device_type
     country: sessions.geography_country
    sorts: [sessions.start_date desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    reference_lines: [{reference_type: line, line_value: mean, range_start: max, range_end: min,
        margin_top: deviation, margin_value: mean, margin_bottom: deviation, label_position: left,
        color: "#f91284", label: '', value_format: '#0.0, "k"'}]
    y_axis_value_format: ''

## Conversion Rate Row

  - name: conversion_rate_yesterday
    title: Conversion Rate Yesterday
    type: single_value
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_week]
    fill_fields: [session_start_calendar.calendar_date_week]
    measures: [sessions.conversion_rate]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Week on Week
      expression: "(${sessions.conversion_rate} - offset(${sessions.conversion_rate},1))/offset(${sessions.conversion_rate},1)"
      value_format:
      value_format_name: percent_1
    filters:
      sessions.start_date: 1 day ago, 8 days ago
    listen:
     marketing_channel: sessions.acquisition_channel
     device: sessions.device_type
     country: sessions.geography_country
    sorts: [session_start_calendar.calendar_date_week desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
    custom_color_enabled: true
    custom_color: "#1a3fd5"
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
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
    comparison_label: Week on Week

  - name: conversion_rate_by_day
    title: Conversion Rate by Day
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_date]
    fill_fields: [sessions.start_date]
    measures: [sessions.conversion_rate]
    listen:
     date: sessions.start_date
     marketing_channel: sessions.acquisition_channel
     device: sessions.device_type
     country: sessions.geography_country
    sorts: [sessions.start_date desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    reference_lines: [{reference_type: line, line_value: mean, range_start: max, range_end: min,
        margin_top: deviation, margin_value: mean, margin_bottom: deviation, label_position: left,
        color: "#f91284", label: '', value_format: '#0.0%'}]
    y_axis_value_format: ''

## Bounce Rate Row

  - name: bounce_rate_yesterday
    title: Bounce Rate Yesterday
    type: single_value
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_week]
    fill_fields: [session_start_calendar.calendar_date_week]
    measures: [sessions.bounce_rate]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Week on Week
      expression: "(${sessions.bounce_rate} - offset(${sessions.bounce_rate},1))/offset(${sessions.bounce_rate},1)"
      value_format:
      value_format_name: percent_1
    filters:
      sessions.start_date: 1 day ago, 8 days ago
    listen:
     marketing_channel: sessions.acquisition_channel
     device: sessions.device_type
     country: sessions.geography_country
    sorts: [session_start_calendar.calendar_date_week desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
    custom_color_enabled: true
    custom_color: "#1a3fd5"
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
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
    comparison_label: Week on Week

  - name: bounce_rate_by_day
    title: Bounce Rate by Day
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_date]
    fill_fields: [sessions.start_date]
    measures: [sessions.bounce_rate]
    listen:
     date: sessions.start_date
     marketing_channel: sessions.acquisition_channel
     device: sessions.device_type
     country: sessions.geography_country
    sorts: [sessions.start_date desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    reference_lines: [{reference_type: line, line_value: mean, range_start: max, range_end: min,
        margin_top: deviation, margin_value: mean, margin_bottom: deviation, label_position: left,
        color: "#f91284", label: '', value_format: '#0%'}]
    y_axis_value_format: ''

## Engagement Rate Row

  - name: engagement_rate_yesterday
    title: Engagement Rate Yesterday
    type: single_value
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_week]
    fill_fields: [session_start_calendar.calendar_date_week]
    measures: [sessions.engagement_rate]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Week on Week
      expression: "(${sessions.engagement_rate} - offset(${sessions.engagement_rate},1))/offset(${sessions.engagement_rate},1)"
      value_format:
      value_format_name: percent_1
    filters:
      sessions.start_date: 1 day ago, 8 days ago
    listen:
     marketing_channel: sessions.acquisition_channel
     device: sessions.device_type
     country: sessions.geography_country
    sorts: [session_start_calendar.calendar_date_week desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
    custom_color_enabled: true
    custom_color: "#1a3fd5"
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
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
    comparison_label: Week on Week

  - name: engagement_rate_by_day
    title: Engagement Rate by Day
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_date]
    fill_fields: [sessions.start_date]
    measures: [sessions.engagement_rate]
    listen:
     date: sessions.start_date
     marketing_channel: sessions.acquisition_channel
     device: sessions.device_type
     country: sessions.geography_country
    sorts: [sessions.start_date desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    reference_lines: [{reference_type: line, line_value: mean, range_start: max, range_end: min,
        margin_top: deviation, margin_value: mean, margin_bottom: deviation, label_position: left,
        color: "#f91284", label: '', value_format: '#0%'}]
    y_axis_value_format: ''

## Page Views per Visit Row

  - name: page_views_per_visit_yesterday
    title: Page Views per Visit Yesterday
    type: single_value
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_week]
    fill_fields: [session_start_calendar.calendar_date_week]
    measures: [sessions.page_views_per_visit]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Week on Week
      expression: "(${sessions.page_views_per_visit} - offset(${sessions.page_views_per_visit},1))/offset(${sessions.page_views_per_visit},1)"
      value_format:
      value_format_name: percent_1
    filters:
      sessions.start_date: 1 day ago, 8 days ago
    listen:
     marketing_channel: sessions.acquisition_channel
     device: sessions.device_type
     country: sessions.geography_country
    sorts: [session_start_calendar.calendar_date_week desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
    custom_color_enabled: true
    custom_color: "#1a3fd5"
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
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
    comparison_label: Week on Week

  - name: page_views_per_visit_by_day
    title: Page Views per Visit by Day
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_date]
    fill_fields: [sessions.start_date]
    measures: [sessions.page_views_per_visit]
    listen:
     date: sessions.start_date
     marketing_channel: sessions.acquisition_channel
     device: sessions.device_type
     country: sessions.geography_country
    sorts: [sessions.start_date desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    reference_lines: [{reference_type: line, line_value: mean, range_start: max, range_end: min,
        margin_top: deviation, margin_value: mean, margin_bottom: deviation, label_position: left,
        color: "#f91284", label: '', value_format: '#0.0'}]
    y_axis_value_format: ''

## Product Views per Visit Row

  - name: product_views_per_visit_yesterday
    title: Product Views per Visit Yesterday
    type: single_value
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_week]
    fill_fields: [session_start_calendar.calendar_date_week]
    measures: [sessions.product_views_per_visit]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Week on Week
      expression: "(${sessions.product_views_per_visit} - offset(${sessions.product_views_per_visit},1))/offset(${sessions.product_views_per_visit},1)"
      value_format:
      value_format_name: percent_1
    filters:
      sessions.start_date: 1 day ago, 8 days ago
    listen:
     marketing_channel: sessions.acquisition_channel
     device: sessions.device_type
     country: sessions.geography_country
    sorts: [session_start_calendar.calendar_date_week desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
    custom_color_enabled: true
    custom_color: "#1a3fd5"
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
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
    comparison_label: Week on Week

  - name: product_views_per_visit_by_day
    title: Product Views per Visit by Day
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_date]
    fill_fields: [sessions.start_date]
    measures: [sessions.product_views_per_visit]
    listen:
     date: sessions.start_date
     marketing_channel: sessions.acquisition_channel
     device: sessions.device_type
     country: sessions.geography_country
    sorts: [sessions.start_date desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    reference_lines: [{reference_type: line, line_value: mean, range_start: max, range_end: min,
        margin_top: deviation, margin_value: mean, margin_bottom: deviation, label_position: left,
        color: "#f91284", label: '', value_format: '#0.0'}]
    y_axis_value_format: ''

## Product Conversion Rate Row

  - name: product_conversion_rate_yesterday
    title: Product Conversion Rate Yesterday
    type: single_value
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_week]
    fill_fields: [session_start_calendar.calendar_date_week]
    measures: [sessions.product_conversion_rate]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Week on Week
      expression: "(${sessions.product_conversion_rate} - offset(${sessions.product_conversion_rate},1))/offset(${sessions.product_conversion_rate},1)"
      value_format:
      value_format_name: percent_1
    filters:
      sessions.start_date: 1 day ago, 8 days ago
    listen:
     marketing_channel: sessions.acquisition_channel
     device: sessions.device_type
     country: sessions.geography_country
    sorts: [session_start_calendar.calendar_date_week desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
    custom_color_enabled: true
    custom_color: "#1a3fd5"
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
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
    comparison_label: Week on Week

  - name: product_conversion_rate_by_day
    title: Product Conversion Rate by Day
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_date]
    fill_fields: [sessions.start_date]
    measures: [sessions.product_conversion_rate]
    listen:
     date: sessions.start_date
     marketing_channel: sessions.acquisition_channel
     device: sessions.device_type
     country: sessions.geography_country
    sorts: [sessions.start_date desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    reference_lines: [{reference_type: line, line_value: mean, range_start: max, range_end: min,
        margin_top: deviation, margin_value: mean, margin_bottom: deviation, label_position: left,
        color: "#f91284", label: '', value_format: '#0.0%'}]
    y_axis_value_format: ''

## Product Impressions per Visit Row

  - name: products_impressions_per_visit_yesterday
    title: Product Impressions per Visit Yesterday
    type: single_value
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_week]
    fill_fields: [session_start_calendar.calendar_date_week]
    measures: [sessions.products_impressions_per_visit]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Week on Week
      expression: "(${sessions.products_impressions_per_visit} - offset(${sessions.products_impressions_per_visit},1))/offset(${sessions.products_impressions_per_visit},1)"
      value_format:
      value_format_name: percent_1
    filters:
      sessions.start_date: 1 day ago, 8 days ago
    listen:
     marketing_channel: sessions.acquisition_channel
     device: sessions.device_type
     country: sessions.geography_country
    sorts: [session_start_calendar.calendar_date_week desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
    custom_color_enabled: true
    custom_color: "#1a3fd5"
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
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
    comparison_label: Week on Week

  - name: products_impressions_per_visit_by_day
    title: Product Impressions per Visit by Day
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_date]
    fill_fields: [sessions.start_date]
    measures: [sessions.products_impressions_per_visit]
    listen:
     date: sessions.start_date
     marketing_channel: sessions.acquisition_channel
     device: sessions.device_type
     country: sessions.geography_country
    sorts: [sessions.start_date desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    reference_lines: [{reference_type: line, line_value: mean, range_start: max, range_end: min,
        margin_top: deviation, margin_value: mean, margin_bottom: deviation, label_position: left,
        color: "#f91284", label: '', value_format: '#0'}]
    y_axis_value_format: ''

## Revenue per 1k Impressions Row

  - name: revenue_per_1k_impressions_yesterday
    title: Revenue per 1k Impressions Yesterday
    type: single_value
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_week]
    fill_fields: [session_start_calendar.calendar_date_week]
    measures: [sessions.revenue_per_1k_impressions]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Week on Week
      expression: "(${sessions.revenue_per_1k_impressions} - offset(${sessions.revenue_per_1k_impressions},1))/offset(${sessions.revenue_per_1k_impressions},1)"
      value_format:
      value_format_name: percent_1
    filters:
      sessions.start_date: 1 day ago, 8 days ago
    listen:
     marketing_channel: sessions.acquisition_channel
     device: sessions.device_type
     country: sessions.geography_country
    sorts: [session_start_calendar.calendar_date_week desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
    custom_color_enabled: true
    custom_color: "#1a3fd5"
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
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
    comparison_label: Week on Week

  - name: revenue_per_1k_impressions_by_day
    title: Revenue per 1k Impressions by Day
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_date]
    fill_fields: [sessions.start_date]
    measures: [sessions.revenue_per_1k_impressions]
    listen:
     date: sessions.start_date
     marketing_channel: sessions.acquisition_channel
     device: sessions.device_type
     country: sessions.geography_country
    sorts: [sessions.start_date desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    reference_lines: [{reference_type: line, line_value: mean, range_start: max, range_end: min,
        margin_top: deviation, margin_value: mean, margin_bottom: deviation, label_position: left,
        color: "#f91284", label: '', value_format: '#0.0'}]
    y_axis_value_format: ''

## Gross Revenue Row

  - name: sum_gross_revenue_ex_discount_yesterday
    title: Gross Revenue Yesterday
    type: single_value
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_week]
    fill_fields: [session_start_calendar.calendar_date_week]
    measures: [sessions.sum_gross_revenue_ex_discount]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Week on Week
      expression: "(${sessions.sum_gross_revenue_ex_discount} - offset(${sessions.sum_gross_revenue_ex_discount},1))/offset(${sessions.sum_gross_revenue_ex_discount},1)"
      value_format:
      value_format_name: percent_1
    filters:
      sessions.start_date: 1 day ago, 8 days ago
    listen:
     marketing_channel: sessions.acquisition_channel
     device: sessions.device_type
     country: sessions.geography_country
    sorts: [session_start_calendar.calendar_date_week desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
    custom_color_enabled: true
    custom_color: "#1a3fd5"
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
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
    comparison_label: Week on Week

  - name: sum_gross_revenue_ex_discount_by_day
    title: Gross Revenue by Day
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_date]
    fill_fields: [sessions.start_date]
    measures: [sessions.sum_gross_revenue_ex_discount]
    listen:
     date: sessions.start_date
     marketing_channel: sessions.acquisition_channel
     device: sessions.device_type
     country: sessions.geography_country
    sorts: [sessions.start_date desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    reference_lines: [{reference_type: line, line_value: mean, range_start: max, range_end: min,
        margin_top: deviation, margin_value: mean, margin_bottom: deviation, label_position: left,
        color: "#f91284", label: '', value_format: '#0.0, "k"'}]
    y_axis_value_format: ''

## Average Basket Row

  - name: average_basket_size_yesterday
    title: Average Basket Yesterday
    type: single_value
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_week]
    fill_fields: [session_start_calendar.calendar_date_week]
    measures: [sessions.average_basket_size]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Week on Week
      expression: "(${sessions.average_basket_size} - offset(${sessions.average_basket_size},1))/offset(${sessions.average_basket_size},1)"
      value_format:
      value_format_name: percent_1
    filters:
      sessions.start_date: 1 day ago, 8 days ago
    listen:
     marketing_channel: sessions.acquisition_channel
     device: sessions.device_type
     country: sessions.geography_country
    sorts: [session_start_calendar.calendar_date_week desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
    custom_color_enabled: true
    custom_color: "#1a3fd5"
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
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
    comparison_label: Week on Week

  - name: average_basket_size_by_day
    title: Average Basket by Day
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_date]
    fill_fields: [sessions.start_date]
    measures: [sessions.average_basket_size]
    listen:
     date: sessions.start_date
     marketing_channel: sessions.acquisition_channel
     device: sessions.device_type
     country: sessions.geography_country
    sorts: [sessions.start_date desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    reference_lines: [{reference_type: line, line_value: mean, range_start: max, range_end: min,
        margin_top: deviation, margin_value: mean, margin_bottom: deviation, label_position: left,
        color: "#f91284", label: '', }]
    y_axis_value_format: ''

## Average Items in Basket Row

  - name: average_items_in_basket_yesterday
    title: Average Items in Basket Yesterday
    type: single_value
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_week]
    fill_fields: [session_start_calendar.calendar_date_week]
    measures: [sessions.average_items_in_basket]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Week on Week
      expression: "(${sessions.average_items_in_basket} - offset(${sessions.average_items_in_basket},1))/offset(${sessions.average_items_in_basket},1)"
      value_format:
      value_format_name: percent_1
    filters:
      sessions.start_date: 1 day ago, 8 days ago
    listen:
     marketing_channel: sessions.acquisition_channel
     device: sessions.device_type
     country: sessions.geography_country
    sorts: [session_start_calendar.calendar_date_week desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
    custom_color_enabled: true
    custom_color: "#1a3fd5"
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
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
    comparison_label: Week on Week

  - name: average_items_in_basket_by_day
    title: Average Items in Basket by Day
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_date]
    fill_fields: [sessions.start_date]
    measures: [sessions.average_items_in_basket]
    listen:
     date: sessions.start_date
     marketing_channel: sessions.acquisition_channel
     device: sessions.device_type
     country: sessions.geography_country
    sorts: [sessions.start_date desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    reference_lines: [{reference_type: line, line_value: mean, range_start: max, range_end: min,
        margin_top: deviation, margin_value: mean, margin_bottom: deviation, label_position: left,
        color: "#f91284", label: '', value_format: '#0.0'}]
    y_axis_value_format: ''

## Average Selling Price Row

  - name: average_selling_price_yesterday
    title: Average Selling Price Yesterday
    type: single_value
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_week]
    fill_fields: [session_start_calendar.calendar_date_week]
    measures: [sessions.average_selling_price]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Week on Week
      expression: "(${sessions.average_selling_price} - offset(${sessions.average_selling_price},1))/offset(${sessions.average_selling_price},1)"
      value_format:
      value_format_name: percent_1
    filters:
      sessions.start_date: 1 day ago, 8 days ago
    listen:
     marketing_channel: sessions.acquisition_channel
     device: sessions.device_type
     country: sessions.geography_country
    sorts: [session_start_calendar.calendar_date_week desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
    custom_color_enabled: true
    custom_color: "#1a3fd5"
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
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
    comparison_label: Week on Week

  - name: average_selling_price_by_day
    title: Average Selling Price by Day
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_date]
    fill_fields: [sessions.start_date]
    measures: [sessions.average_selling_price]
    listen:
     date: sessions.start_date
     marketing_channel: sessions.acquisition_channel
     device: sessions.device_type
     country: sessions.geography_country
    sorts: [sessions.start_date desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    reference_lines: [{reference_type: line, line_value: mean, range_start: max, range_end: min,
        margin_top: deviation, margin_value: mean, margin_bottom: deviation, label_position: left,
        color: "#f91284", label: '', }]
    y_axis_value_format: ''

## DR1 (Homepage) Row

  - name: dropout_rate_1_yesterday
    title: DR1 (Homepage) Yesterday
    type: single_value
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_week]
    fill_fields: [session_start_calendar.calendar_date_week]
    measures: [sessions.dropout_rate_1]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Week on Week
      expression: "(${sessions.dropout_rate_1} - offset(${sessions.dropout_rate_1},1))/offset(${sessions.dropout_rate_1},1)"
      value_format:
      value_format_name: percent_1
    filters:
      sessions.start_date: 1 day ago, 8 days ago
    listen:
     marketing_channel: sessions.acquisition_channel
     device: sessions.device_type
     country: sessions.geography_country
    sorts: [session_start_calendar.calendar_date_week desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
    custom_color_enabled: true
    custom_color: "#1a3fd5"
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
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
    comparison_label: Week on Week

  - name: dropout_rate_1_by_day
    title: DR1 (Homepage) by Day
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_date]
    fill_fields: [sessions.start_date]
    measures: [sessions.dropout_rate_1]
    listen:
     date: sessions.start_date
     marketing_channel: sessions.acquisition_channel
     device: sessions.device_type
     country: sessions.geography_country
    sorts: [sessions.start_date desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    reference_lines: [{reference_type: line, line_value: mean, range_start: max, range_end: min,
        margin_top: deviation, margin_value: mean, margin_bottom: deviation, label_position: left,
        color: "#f91284", label: '', value_format: '#0.0%'}]
    y_axis_value_format: ''

## DR2 (Cat Page) Row

  - name: dropout_rate_2_yesterday
    title: DR2 (Cat Page) Yesterday
    type: single_value
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_week]
    fill_fields: [session_start_calendar.calendar_date_week]
    measures: [sessions.dropout_rate_2]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Week on Week
      expression: "(${sessions.dropout_rate_2} - offset(${sessions.dropout_rate_2},1))/offset(${sessions.dropout_rate_2},1)"
      value_format:
      value_format_name: percent_1
    filters:
      sessions.start_date: 1 day ago, 8 days ago
    listen:
     marketing_channel: sessions.acquisition_channel
     device: sessions.device_type
     country: sessions.geography_country
    sorts: [session_start_calendar.calendar_date_week desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
    custom_color_enabled: true
    custom_color: "#1a3fd5"
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
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
    comparison_label: Week on Week

  - name: dropout_rate_2_by_day
    title: DR2 (Cat Page) by Day
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_date]
    fill_fields: [sessions.start_date]
    measures: [sessions.dropout_rate_2]
    listen:
     date: sessions.start_date
     marketing_channel: sessions.acquisition_channel
     device: sessions.device_type
     country: sessions.geography_country
    sorts: [sessions.start_date desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    reference_lines: [{reference_type: line, line_value: mean, range_start: max, range_end: min,
        margin_top: deviation, margin_value: mean, margin_bottom: deviation, label_position: left,
        color: "#f91284", label: '', value_format: '#0.0%'}]
    y_axis_value_format: ''

## DR3 (Prod Page) Row

  - name: dropout_rate_3_yesterday
    title: DR3 (Prod Page) Yesterday
    type: single_value
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_week]
    fill_fields: [session_start_calendar.calendar_date_week]
    measures: [sessions.dropout_rate_3]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Week on Week
      expression: "(${sessions.dropout_rate_3} - offset(${sessions.dropout_rate_3},1))/offset(${sessions.dropout_rate_3},1)"
      value_format:
      value_format_name: percent_1
    filters:
      sessions.start_date: 1 day ago, 8 days ago
    listen:
     marketing_channel: sessions.acquisition_channel
     device: sessions.device_type
     country: sessions.geography_country
    sorts: [session_start_calendar.calendar_date_week desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
    custom_color_enabled: true
    custom_color: "#1a3fd5"
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
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
    comparison_label: Week on Week

  - name: dropout_rate_3_by_day
    title: DR3 (Prod Page) by Day
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_date]
    fill_fields: [sessions.start_date]
    measures: [sessions.dropout_rate_3]
    listen:
     date: sessions.start_date
     marketing_channel: sessions.acquisition_channel
     device: sessions.device_type
     country: sessions.geography_country
    sorts: [sessions.start_date desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    reference_lines: [{reference_type: line, line_value: mean, range_start: max, range_end: min,
        margin_top: deviation, margin_value: mean, margin_bottom: deviation, label_position: left,
        color: "#f91284", label: '', value_format: '#0.0%'}]
    y_axis_value_format: ''

## DR4 (Add to Cart) Row

  - name: dropout_rate_4_yesterday
    title: DR4 (Add to Cart) Yesterday
    type: single_value
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_week]
    fill_fields: [session_start_calendar.calendar_date_week]
    measures: [sessions.dropout_rate_4]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Week on Week
      expression: "(${sessions.dropout_rate_4} - offset(${sessions.dropout_rate_4},1))/offset(${sessions.dropout_rate_4},1)"
      value_format:
      value_format_name: percent_1
    filters:
      sessions.start_date: 1 day ago, 8 days ago
    listen:
     marketing_channel: sessions.acquisition_channel
     device: sessions.device_type
     country: sessions.geography_country
    sorts: [session_start_calendar.calendar_date_week desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
    custom_color_enabled: true
    custom_color: "#1a3fd5"
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
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
    comparison_label: Week on Week

  - name: dropout_rate_4_by_day
    title: DR4 (Add to Cart) by Day
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_date]
    fill_fields: [sessions.start_date]
    measures: [sessions.dropout_rate_4]
    listen:
     date: sessions.start_date
     marketing_channel: sessions.acquisition_channel
     device: sessions.device_type
     country: sessions.geography_country
    sorts: [sessions.start_date desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    reference_lines: [{reference_type: line, line_value: mean, range_start: max, range_end: min,
        margin_top: deviation, margin_value: mean, margin_bottom: deviation, label_position: left,
        color: "#f91284", label: '', value_format: '#0.0%'}]
    y_axis_value_format: ''

## DR5 (View Cart) Row

  - name: dropout_rate_5_yesterday
    title: DR5 (View Cart) Yesterday
    type: single_value
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_week]
    fill_fields: [session_start_calendar.calendar_date_week]
    measures: [sessions.dropout_rate_5]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Week on Week
      expression: "(${sessions.dropout_rate_5} - offset(${sessions.dropout_rate_5},1))/offset(${sessions.dropout_rate_5},1)"
      value_format:
      value_format_name: percent_1
    filters:
      sessions.start_date: 1 day ago, 8 days ago
    listen:
     marketing_channel: sessions.acquisition_channel
     device: sessions.device_type
     country: sessions.geography_country
    sorts: [session_start_calendar.calendar_date_week desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
    custom_color_enabled: true
    custom_color: "#1a3fd5"
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
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
    comparison_label: Week on Week

  - name: dropout_rate_5_by_day
    title: DR5 (View Cart) by Day
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_date]
    fill_fields: [sessions.start_date]
    measures: [sessions.dropout_rate_5]
    listen:
     date: sessions.start_date
     marketing_channel: sessions.acquisition_channel
     device: sessions.device_type
     country: sessions.geography_country
    sorts: [sessions.start_date desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    reference_lines: [{reference_type: line, line_value: mean, range_start: max, range_end: min,
        margin_top: deviation, margin_value: mean, margin_bottom: deviation, label_position: left,
        color: "#f91284", label: '', value_format: '#0.0%'}]
    y_axis_value_format: ''

## DR6 (Checkout Reg) Row

  - name: dropout_rate_6_yesterday
    title: DR6 (Checkout Reg) Yesterday
    type: single_value
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_week]
    fill_fields: [session_start_calendar.calendar_date_week]
    measures: [sessions.dropout_rate_6]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Week on Week
      expression: "(${sessions.dropout_rate_6} - offset(${sessions.dropout_rate_6},1))/offset(${sessions.dropout_rate_6},1)"
      value_format:
      value_format_name: percent_1
    filters:
      sessions.start_date: 1 day ago, 8 days ago
    listen:
     marketing_channel: sessions.acquisition_channel
     device: sessions.device_type
     country: sessions.geography_country
    sorts: [session_start_calendar.calendar_date_week desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
    custom_color_enabled: true
    custom_color: "#1a3fd5"
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
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
    comparison_label: Week on Week

  - name: dropout_rate_6_by_day
    title: DR6 (Checkout Reg) by Day
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_date]
    fill_fields: [sessions.start_date]
    measures: [sessions.dropout_rate_6]
    listen:
     date: sessions.start_date
     marketing_channel: sessions.acquisition_channel
     device: sessions.device_type
     country: sessions.geography_country
    sorts: [sessions.start_date desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    reference_lines: [{reference_type: line, line_value: mean, range_start: max, range_end: min,
        margin_top: deviation, margin_value: mean, margin_bottom: deviation, label_position: left,
        color: "#f91284", label: '', value_format: '#0.0%'}]
    y_axis_value_format: ''

## DR7 (Checkout Add) Row

  - name: dropout_rate_7_yesterday
    title: DR7 (Checkout Add) Yesterday
    type: single_value
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_week]
    fill_fields: [session_start_calendar.calendar_date_week]
    measures: [sessions.dropout_rate_7]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Week on Week
      expression: "(${sessions.dropout_rate_7} - offset(${sessions.dropout_rate_7},1))/offset(${sessions.dropout_rate_7},1)"
      value_format:
      value_format_name: percent_1
    filters:
      sessions.start_date: 1 day ago, 8 days ago
    listen:
     marketing_channel: sessions.acquisition_channel
     device: sessions.device_type
     country: sessions.geography_country
    sorts: [session_start_calendar.calendar_date_week desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
    custom_color_enabled: true
    custom_color: "#1a3fd5"
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
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
    comparison_label: Week on Week

  - name: dropout_rate_7_by_day
    title: DR7 (Checkout Add) by Day
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_date]
    fill_fields: [sessions.start_date]
    measures: [sessions.dropout_rate_7]
    listen:
     date: sessions.start_date
     marketing_channel: sessions.acquisition_channel
     device: sessions.device_type
     country: sessions.geography_country
    sorts: [sessions.start_date desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    reference_lines: [{reference_type: line, line_value: mean, range_start: max, range_end: min,
        margin_top: deviation, margin_value: mean, margin_bottom: deviation, label_position: left,
        color: "#f91284", label: '', value_format: '#0.0%'}]
    y_axis_value_format: ''

## DR8 (Checkout Del) Row

  - name: dropout_rate_8_yesterday
    title: DR8 (Checkout Del) Yesterday
    type: single_value
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_week]
    fill_fields: [session_start_calendar.calendar_date_week]
    measures: [sessions.dropout_rate_8]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Week on Week
      expression: "(${sessions.dropout_rate_8} - offset(${sessions.dropout_rate_8},1))/offset(${sessions.dropout_rate_8},1)"
      value_format:
      value_format_name: percent_1
    filters:
      sessions.start_date: 1 day ago, 8 days ago
    listen:
     marketing_channel: sessions.acquisition_channel
     device: sessions.device_type
     country: sessions.geography_country
    sorts: [session_start_calendar.calendar_date_week desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
    custom_color_enabled: true
    custom_color: "#1a3fd5"
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
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
    comparison_label: Week on Week

  - name: dropout_rate_8_by_day
    title: DR8 (Checkout Del) by Day
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_date]
    fill_fields: [sessions.start_date]
    measures: [sessions.dropout_rate_8]
    listen:
     date: sessions.start_date
     marketing_channel: sessions.acquisition_channel
     device: sessions.device_type
     country: sessions.geography_country
    sorts: [sessions.start_date desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    reference_lines: [{reference_type: line, line_value: mean, range_start: max, range_end: min,
        margin_top: deviation, margin_value: mean, margin_bottom: deviation, label_position: left,
        color: "#f91284", label: '', value_format: '#0.0%'}]
    y_axis_value_format: ''

## DR9 (Checkout Pay) Row

  - name: dropout_rate_9_yesterday
    title: DR9 (Checkout Pay) Yesterday
    type: single_value
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_week]
    fill_fields: [session_start_calendar.calendar_date_week]
    measures: [sessions.dropout_rate_9]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Week on Week
      expression: "(${sessions.dropout_rate_9} - offset(${sessions.dropout_rate_9},1))/offset(${sessions.dropout_rate_9},1)"
      value_format:
      value_format_name: percent_1
    filters:
      sessions.start_date: 1 day ago, 8 days ago
    listen:
     marketing_channel: sessions.acquisition_channel
     device: sessions.device_type
     country: sessions.geography_country
    sorts: [session_start_calendar.calendar_date_week desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
    custom_color_enabled: true
    custom_color: "#1a3fd5"
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
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
    comparison_label: Week on Week

  - name: dropout_rate_9_by_day
    title: DR9 (Checkout Pay) by Day
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_date]
    fill_fields: [sessions.start_date]
    measures: [sessions.dropout_rate_9]
    listen:
     date: sessions.start_date
     marketing_channel: sessions.acquisition_channel
     device: sessions.device_type
     country: sessions.geography_country
    sorts: [sessions.start_date desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    reference_lines: [{reference_type: line, line_value: mean, range_start: max, range_end: min,
        margin_top: deviation, margin_value: mean, margin_bottom: deviation, label_position: left,
        color: "#f91284", label: '', value_format: '#0.0%'}]
    y_axis_value_format: ''

## Newsletter Signups Row

  - name: sum_newsletter_signups_yesterday
    title: Newsletter Signups Yesterday
    type: single_value
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_week]
    fill_fields: [session_start_calendar.calendar_date_week]
    measures: [sessions.sum_newsletter_signups]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Week on Week
      expression: "(${sessions.sum_newsletter_signups} - offset(${sessions.sum_newsletter_signups},1))/offset(${sessions.sum_newsletter_signups},1)"
      value_format:
      value_format_name: percent_1
    filters:
      sessions.start_date: 1 day ago, 8 days ago
    listen:
     marketing_channel: sessions.acquisition_channel
     device: sessions.device_type
     country: sessions.geography_country
    sorts: [session_start_calendar.calendar_date_week desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
    custom_color_enabled: true
    custom_color: "#1a3fd5"
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
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
    comparison_label: Week on Week

  - name: sum_newsletter_signups_by_day
    title: Newsletter Signups by Day
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_date]
    fill_fields: [sessions.start_date]
    measures: [sessions.sum_newsletter_signups]
    listen:
     date: sessions.start_date
     marketing_channel: sessions.acquisition_channel
     device: sessions.device_type
     country: sessions.geography_country
    sorts: [sessions.start_date desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    reference_lines: [{reference_type: line, line_value: mean, range_start: max, range_end: min,
        margin_top: deviation, margin_value: mean, margin_bottom: deviation, label_position: left,
        color: "#f91284", label: '', value_format: '#0'}]
    y_axis_value_format: ''

## Newsletter Signup Rate Row

  - name: nl_signup_rate_yesterday
    title: Newsletter Signup Rate Yesterday
    type: single_value
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_week]
    fill_fields: [session_start_calendar.calendar_date_week]
    measures: [sessions.nl_signup_rate]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Week on Week
      expression: "(${sessions.nl_signup_rate} - offset(${sessions.nl_signup_rate},1))/offset(${sessions.nl_signup_rate},1)"
      value_format:
      value_format_name: percent_1
    filters:
      sessions.start_date: 1 day ago, 8 days ago
    listen:
     marketing_channel: sessions.acquisition_channel
     device: sessions.device_type
     country: sessions.geography_country
    sorts: [session_start_calendar.calendar_date_week desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
    custom_color_enabled: true
    custom_color: "#1a3fd5"
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
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
    comparison_label: Week on Week

  - name: nl_signup_rate_by_day
    title: Newsletter Signup Rate by Day
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_date]
    fill_fields: [sessions.start_date]
    measures: [sessions.nl_signup_rate]
    listen:
     date: sessions.start_date
     marketing_channel: sessions.acquisition_channel
     device: sessions.device_type
     country: sessions.geography_country
    sorts: [sessions.start_date desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    reference_lines: [{reference_type: line, line_value: mean, range_start: max, range_end: min,
        margin_top: deviation, margin_value: mean, margin_bottom: deviation, label_position: left,
        color: "#f91284", label: '', value_format: '#0.00%'}]
    y_axis_value_format: ''

## Cart Abandonment Rate Row

  - name: cart_abandonment_rate_yesterday
    title: Cart Abandonment Rate Yesterday
    type: single_value
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_week]
    fill_fields: [session_start_calendar.calendar_date_week]
    measures: [sessions.cart_abandonment_rate]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Week on Week
      expression: "(${sessions.cart_abandonment_rate} - offset(${sessions.cart_abandonment_rate},1))/offset(${sessions.cart_abandonment_rate},1)"
      value_format:
      value_format_name: percent_1
    filters:
      sessions.start_date: 1 day ago, 8 days ago
    listen:
     marketing_channel: sessions.acquisition_channel
     device: sessions.device_type
     country: sessions.geography_country
    sorts: [session_start_calendar.calendar_date_week desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
    custom_color_enabled: true
    custom_color: "#1a3fd5"
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
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
    comparison_label: Week on Week

  - name: cart_abandonment_rate_by_day
    title: Cart Abandonment Rate by Day
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_date]
    fill_fields: [sessions.start_date]
    measures: [sessions.cart_abandonment_rate]
    listen:
     date: sessions.start_date
     marketing_channel: sessions.acquisition_channel
     device: sessions.device_type
     country: sessions.geography_country
    sorts: [sessions.start_date desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    reference_lines: [{reference_type: line, line_value: mean, range_start: max, range_end: min,
        margin_top: deviation, margin_value: mean, margin_bottom: deviation, label_position: left,
        color: "#f91284", label: '', value_format: '#0.0%'}]
    y_axis_value_format: ''

## Checkout Abandonment Rate Row

  - name: checkout_abandonment_rate_yesterday
    title: Checkout Abandonment Rate Yesterday
    type: single_value
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_week]
    fill_fields: [session_start_calendar.calendar_date_week]
    measures: [sessions.checkout_abandonment_rate]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Week on Week
      expression: "(${sessions.checkout_abandonment_rate} - offset(${sessions.checkout_abandonment_rate},1))/offset(${sessions.checkout_abandonment_rate},1)"
      value_format:
      value_format_name: percent_1
    filters:
      sessions.start_date: 1 day ago, 8 days ago
    listen:
     marketing_channel: sessions.acquisition_channel
     device: sessions.device_type
     country: sessions.geography_country
    sorts: [session_start_calendar.calendar_date_week desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
    custom_color_enabled: true
    custom_color: "#1a3fd5"
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
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
    comparison_label: Week on Week

  - name: checkout_abandonment_rate_by_day
    title: Checkout Abandonment Rate by Day
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_date]
    fill_fields: [sessions.start_date]
    measures: [sessions.checkout_abandonment_rate]
    listen:
     date: sessions.start_date
     marketing_channel: sessions.acquisition_channel
     device: sessions.device_type
     country: sessions.geography_country
    sorts: [sessions.start_date desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    reference_lines: [{reference_type: line, line_value: mean, range_start: max, range_end: min,
        margin_top: deviation, margin_value: mean, margin_bottom: deviation, label_position: left,
        color: "#f91284", label: '', value_format: '#0.0%'}]
    y_axis_value_format: ''

## Products Added to Cart per Visit Row

  - name: products_added_to_cart_per_visit_yesterday
    title: Products Added to Cart per Visit Yesterday
    type: single_value
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_week]
    fill_fields: [session_start_calendar.calendar_date_week]
    measures: [sessions.products_added_to_cart_per_visit]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Week on Week
      expression: "(${sessions.products_added_to_cart_per_visit} - offset(${sessions.products_added_to_cart_per_visit},1))/offset(${sessions.products_added_to_cart_per_visit},1)"
      value_format:
      value_format_name: percent_1
    filters:
      sessions.start_date: 1 day ago, 8 days ago
    listen:
     marketing_channel: sessions.acquisition_channel
     device: sessions.device_type
     country: sessions.geography_country
    sorts: [session_start_calendar.calendar_date_week desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
    custom_color_enabled: true
    custom_color: "#1a3fd5"
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
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
    comparison_label: Week on Week

  - name: products_added_to_cart_per_visit_by_day
    title: Products Added to Cart per Visit by Day
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_date]
    fill_fields: [sessions.start_date]
    measures: [sessions.products_added_to_cart_per_visit]
    listen:
     date: sessions.start_date
     marketing_channel: sessions.acquisition_channel
     device: sessions.device_type
     country: sessions.geography_country
    sorts: [sessions.start_date desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    reference_lines: [{reference_type: line, line_value: mean, range_start: max, range_end: min,
        margin_top: deviation, margin_value: mean, margin_bottom: deviation, label_position: left,
        color: "#f91284", label: '', }]
    y_axis_value_format: ''

## Products Added to Cart / Views Row

  - name: product_added_to_cart_view_ratio_yesterday
    title: Products Added to Cart / Views Yesterday
    type: single_value
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_week]
    fill_fields: [session_start_calendar.calendar_date_week]
    measures: [sessions.product_added_to_cart_view_ratio]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Week on Week
      expression: "(${sessions.product_added_to_cart_view_ratio} - offset(${sessions.product_added_to_cart_view_ratio},1))/offset(${sessions.product_added_to_cart_view_ratio},1)"
      value_format:
      value_format_name: percent_1
    filters:
      sessions.start_date: 1 day ago, 8 days ago
    listen:
     marketing_channel: sessions.acquisition_channel
     device: sessions.device_type
     country: sessions.geography_country
    sorts: [session_start_calendar.calendar_date_week desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
    custom_color_enabled: true
    custom_color: "#1a3fd5"
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
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
    comparison_label: Week on Week

  - name: product_added_to_cart_view_ratio_by_day
    title: Products Added to Cart / Views by Day
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_date]
    fill_fields: [sessions.start_date]
    measures: [sessions.product_added_to_cart_view_ratio]
    listen:
     date: sessions.start_date
     marketing_channel: sessions.acquisition_channel
     device: sessions.device_type
     country: sessions.geography_country
    sorts: [sessions.start_date desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    reference_lines: [{reference_type: line, line_value: mean, range_start: max, range_end: min,
        margin_top: deviation, margin_value: mean, margin_bottom: deviation, label_position: left,
        color: "#f91284", label: '', value_format: '#0.0%'}]
    y_axis_value_format: ''

# % sale product views
# FP product CR
# Sale Product CR

# % Sale Impressions
# FP Rev/1k Imp
# SAle Rev/1k imp






