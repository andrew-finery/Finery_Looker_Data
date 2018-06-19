- dashboard: website_interaction_weekly_dashboard
  title: Website Interaction Weekly Dashboard
  layout: static
  tile_size: 100



  elements:
  - name: page_views_per_visit
    title: Page Views Per Visit
    model: finery_data
    explore: sessions
    type: table
    fields: [sessions.page_views_per_visit_lcw, sessions.page_views_per_visit_pcw, sessions.page_views_per_visit_lcw_wow,
      sessions.page_views_per_visit_lcw_ly, sessions.page_views_per_visit_lcw_ly_yoy,
      sessions.page_views_per_visit_mtd, sessions.page_views_per_visit_mtd_lm, sessions.page_views_per_visit_mtd_mom,
      sessions.page_views_per_visit_ytd, sessions.page_views_per_visit_ytd_ly, sessions.page_views_per_visit_ytd_yoy]
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
    series_labels:
      sessions.page_views_per_visit_lcw_wow: "%"
    width: 14
    height: 1
    top: 0
    left: 0


  - name: product_views_per_visit
    title: Product Views Per Visit
    model: finery_data
    explore: sessions
    type: table
    fields: [sessions.product_views_per_visit_lcw, sessions.product_views_per_visit_pcw,
      sessions.product_views_per_visit_lcw_wow, sessions.product_views_per_visit_lcw_ly,
      sessions.product_views_per_visit_lcw_ly_yoy, sessions.product_views_per_visit_mtd,
      sessions.product_views_per_visit_mtd_lm, sessions.product_views_per_visit_mtd_mom,
      sessions.product_views_per_visit_ytd, sessions.product_views_per_visit_ytd_ly,
      sessions.product_views_per_visit_ytd_yoy]
    limit: 500
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
    x_axis_reversed: false
    y_axis_reversed: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    series_labels:
      sessions.product_views_per_visit_lcw_wow: "%"
    conditional_formatting: [{type: low to high, value: !!null '', background_color: !!null '',
        font_color: !!null '', palette: {name: Red to Yellow to Green, colors: ["#F36254",
            "#FCF758", "#4FBC89"]}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: 0
    width: 14
    height: 1
    top: 1
    left: 0


  - name: engagement_rate
    title: Engagement Rate
    model: finery_data
    explore: sessions
    type: table
    fields: [sessions.engagement_rate_lcw, sessions.engagement_rate_pcw, sessions.engagement_rate_lcw_wow,
      sessions.engagement_rate_lcw_ly, sessions.engagement_rate_lcw_ly_yoy, sessions.engagement_rate_mtd,
      sessions.engagement_rate_mtd_lm, sessions.engagement_rate_mtd_mom, sessions.engagement_rate_ytd,
      sessions.engagement_rate_ytd_ly, sessions.engagement_rate_ytd_yoy]
    limit: 500
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
    x_axis_reversed: false
    y_axis_reversed: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    series_labels:
      sessions.engagement_rate_lcw_wow: "%"
    width: 14
    height: 1
    top: 2
    left: 0


  - name: bounce_rate
    title: Bounce Rate
    model: finery_data
    explore: sessions
    type: table
    fields: [sessions.bounce_rate_lcw, sessions.bounce_rate_pcw, sessions.bounce_rate_lcw_wow,
      sessions.bounce_rate_lcw_ly, sessions.bounce_rate_lcw_ly_yoy, sessions.bounce_rate_mtd,
      sessions.bounce_rate_mtd_lm, sessions.bounce_rate_mtd_mom, sessions.bounce_rate_ytd,
      sessions.bounce_rate_ytd_ly, sessions.bounce_rate_ytd_yoy]
    limit: 500
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
    x_axis_reversed: false
    y_axis_reversed: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    series_labels:
      sessions.bounce_rate_lcw_wow: "%"
    width: 14
    height: 1
    top: 3
    left: 0


  - name: add_to_cart_rate_site
    title: Add To Cart Rate (Site)
    model: finery_data
    explore: sessions
    type: table
    fields: [sessions.add_to_cart_lcw, sessions.add_to_cart_pcw, sessions.add_to_cart_lcw_wow,
      sessions.add_to_cart_lcw_ly, sessions.add_to_cart_lcw_ly_yoy, sessions.add_to_cart_mtd,
      sessions.add_to_cart_mtd_lm, sessions.add_to_cart_mtd_mom, sessions.add_to_cart_ytd,
      sessions.add_to_cart_ytd_ly, sessions.add_to_cart_ytd_yoy]
    limit: 500
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
    x_axis_reversed: false
    y_axis_reversed: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    series_labels:
      sessions.add_to_cart_lcw_wow: "%"
    width: 14
    height: 1
    top: 4
    left: 0


  - name: conversion_rate_site
    title: Conversion Rate (Site)
    model: finery_data
    explore: sessions
    type: table
    fields: [sessions.conversion_last_complete_week, sessions.conversion_previous_complete_week,
      sessions.conversion_last_complete_week_wow, sessions.conversion_last_complete_week_last_year,
      sessions.conversion_last_complete_week_last_year_yoy, sessions.conversion_month_to_date,
      sessions.conversion_month_to_date_last_month, sessions.conversion_month_to_date_mom,
      sessions.conversion_year_to_date, sessions.conversion_year_to_date_last_year,
      sessions.conversion_year_to_date_yoy]
    limit: 500
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
    x_axis_reversed: false
    y_axis_reversed: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    series_labels:
      sessions.conversion_last_complete_week_wow: "%"
    width: 14
    height: 1
    top: 5
    left: 0


  - name: landing_page_with_bounce_rate
    title: Landing Page With Bounce Rate
    model: finery_data
    explore: sessions
    type: table
    fields: [sessions.landing_page_path, sessions.visits_last_complete_week, sessions.bounce_rate_lcw,
      sessions.bounce_rate_pcw, sessions.bounce_rate_lcw_wow]
    sorts: [sessions.visits_last_complete_week desc]
    limit: 10
    column_limit: 50
    show_view_names: false
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
      sessions.visits_yesterday: Actual
      sessions.bounce_rate_yesterday: Bounce Rate
      sessions.landing_page_path: Landing Page
      sessions.visits_last_complete_week: Visits
      sessions.bounce_rate_lcw: Bounce Rate
      sessions.bounce_rate_lcw_wow: "%"
    width: 14
    height: 3
    top: 6
    left: 0


  - name: page_visits_with_conversion
    title: Page Visits With Conversion
    model: finery_data
    explore: website_page_views
    type: table
    fields: [website_page_views.page_urlpath, website_page_views.count_total_page_views_lcw,
      website_page_views.count_total_page_views_pcw, website_page_views.count_total_page_views_lcw_wow,
      visits.distinct_conversion_rate_lcw, visits.distinct_conversion_rate_pcw, visits.distinct_conversion_rate_lcw_percentage]
    sorts: [website_page_views.count_total_page_views_lcw desc]
    limit: 10
    column_limit: 50
    show_view_names: false
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
      website_page_views.exit_rate_l7d: L7D
      website_page_views.exit_rate_l7d_percentage: L7D%
      visits.conversion_yesterday: Conversion Rate
      visits.conversion_yesterday_last_week: LW
      visits.conversion_yesterday_wow: "%"
      website_page_views.count_total_page_views_lw: LW
      website_page_views.percentage_total_page_views_lw: "%"
      website_page_views.percentage_total_page_views_l7d: vs L7D
      visits.conversion_last_7_days_percentage: L7D%
      visits.distinct_conversion_rate_yesterday: C.R
      visits.distinct_conversion_rate_lw: LW
      visits.distinct_conversion_rate_wow: "%"
      visits.distinct_conversion_rate_l7d: L7D
      visits.distinct_conversion_rate_l7d_percentage: vs L7D
      website_page_views.count_total_page_views_l7d_average: L7D Avg
      website_page_views.count_total_page_views_yesterday: Actual
      website_page_views.count_total_page_views_l7d: L7D
      website_page_views.page_urlpath: Page Url
      website_page_views.count_total_page_views_lcw: LCW
      website_page_views.count_total_page_views_pcw: PCW
      website_page_views.count_total_page_views_lcw_wow: LCW %
      visits.distinct_conversion_rate_lcw: LCW
      visits.distinct_conversion_rate_pcw: PCW
      visits.distinct_conversion_rate_lcw_percentage: LCW %
    width: 14
    height: 3
    top: 9
    left: 0


  - name: exit_rate
    title: Exit Rate
    model: finery_data
    explore: website_page_views
    type: table
    fields: [visits.exit_page_path, visits.visits_last_complete_week, website_page_views.exit_rate_lcw,
      website_page_views.exit_rate_pcw, website_page_views.exit_rate_lcw_percentage]
    sorts: [visits.visits_last_complete_week desc]
    limit: 10
    query_timezone: Europe/London
    show_view_names: false
    show_row_numbers: true
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
    x_axis_reversed: false
    y_axis_reversed: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    series_labels:
      website_page_views.exit_rate_lcw: LCW
    width: 14
    height: 3
    top: 12
    left: 0


  - name: add_to_cart_product
    title: Add To Cart Rate (Product)
    model: finery_data
    explore: sessions
    type: table
    fields: [sessions.product_add_to_cart_rate_lcw, sessions.product_add_to_cart_rate_pcw,
      sessions.product_add_to_cart_rate_lcw_wow, sessions.product_add_to_cart_rate_lcw_ly,
      sessions.product_add_to_cart_rate_lcw_yoy, sessions.product_add_to_cart_rate_mtd,
      sessions.product_add_to_cart_rate_mtd_lm, sessions.product_add_to_cart_rate_mtd_mom,
      sessions.product_add_to_cart_rate_ytd, sessions.product_add_to_cart_rate_ytd_ly,
      sessions.product_add_to_cart_rate_ytd_yoy]
    limit: 500
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
    x_axis_reversed: false
    y_axis_reversed: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    series_labels:
      sessions.product_add_to_cart_rate_lcw_wow: "%"
    width: 14
    height: 1
    top: 15
    left: 0


  - name: product_conversion_rate
    title: Conversion Rate (Product)
    model: finery_data
    explore: sessions
    type: table
    fields: [sessions.product_conversion_rate_lcw, sessions.product_conversion_rate_pcw,
      sessions.product_conversion_lcw_wow, sessions.product_conversion_rate_lcw_ly,
      sessions.product_conversion_lcw_yoy, sessions.product_conversion_rate_mtd, sessions.product_conversion_rate_mtd_lm,
      sessions.product_conversion_mtd_mom, sessions.product_conversion_rate_ytd, sessions.product_conversion_rate_ytd_ly,
      sessions.product_conversion_ytd_yoy]
    limit: 500
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
    x_axis_reversed: false
    y_axis_reversed: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    series_labels:
      sessions.product_conversion_lcw_wow: "%"
    width: 14
    height: 1
    top: 16
    left: 0


  - name: most_viewed_product
    title: Most Viewed Products
    model: finery_data
    explore: product_info_option_daily
    type: table
    fields: [option_info.option, option_info.option_image_small, product_info_option_daily.sum_products_page_views_lcw,
      product_info_option_daily.add_to_carts_lcw, product_info_option_daily.add_to_cart_rate_lcw,
      product_info_option_daily.items_sold_lcw, product_info_option_daily.conversion_rate_lcw,
      product_info_option_daily.gross_revenue_lcw]
    sorts: [product_info_option_daily.sum_products_page_views_lcw desc]
    limit: 10
    column_limit: 50
    show_view_names: false
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
      product_info_option_daily.sum_products_page_views_lcw: Page Views
      product_info_option_daily.add_to_carts_lcw: Add To Carts
      product_info_option_daily.add_to_cart_rate_lcw: Add To Cart Rate
      product_info_option_daily.items_sold_lcw: Items Sold
      product_info_option_daily.conversion_rate_lcw: C.R
      product_info_option_daily.gross_revenue_lcw: Gross Rev.
    width: 7
    height: 6
    top: 17
    left: 0


  - name: most_added_to_cart_product
    title: Most Added To Cart Products
    model: finery_data
    explore: product_info_option_daily
    type: table
    fields: [option_info.option, option_info.option_image_small, product_info_option_daily.sum_products_page_views_lcw,
      product_info_option_daily.add_to_carts_lcw, product_info_option_daily.add_to_cart_rate_lcw,
      product_info_option_daily.items_sold_lcw, product_info_option_daily.conversion_rate_lcw,
      product_info_option_daily.gross_revenue_lcw]
    sorts: [product_info_option_daily.add_to_carts_lcw desc]
    limit: 10
    column_limit: 50
    show_view_names: false
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
      product_info_option_daily.sum_products_page_views_lcw: Page Views
      product_info_option_daily.add_to_carts_lcw: Add To Carts
      product_info_option_daily.add_to_cart_rate_lcw: Add To Cart Rate
      product_info_option_daily.items_sold_lcw: Items Sold
      product_info_option_daily.conversion_rate_lcw: C.R
      product_info_option_daily.gross_revenue_lcw: Gross Rev.
    width: 7
    height: 6
    top: 17
    left: 7


  - name: most_sold_product
    title: Most Sold Products
    model: finery_data
    explore: product_info_option_daily
    type: table
    fields: [option_info.option, option_info.option_image_small, product_info_option_daily.sum_products_page_views_lcw,
      product_info_option_daily.add_to_carts_lcw, product_info_option_daily.add_to_cart_rate_lcw,
      product_info_option_daily.items_sold_lcw, product_info_option_daily.conversion_rate_lcw,
      product_info_option_daily.gross_revenue_lcw]
    sorts: [product_info_option_daily.items_sold_lcw desc]
    limit: 10
    column_limit: 50
    show_view_names: false
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
      product_info_option_daily.sum_products_page_views_lcw: Page Views
      product_info_option_daily.add_to_carts_lcw: Add To Carts
      product_info_option_daily.add_to_cart_rate_lcw: Add To Cart Rate
      product_info_option_daily.items_sold_lcw: Items Sold
      product_info_option_daily.conversion_rate_lcw: C.R
      product_info_option_daily.gross_revenue_lcw: Gross Rev.
    width: 7
    height: 6
    top: 23
    left: 0
