- dashboard: web_stats_report
  title: Web Stats Report
  layout: tile
  tile_size: 100

  filters:
  - name: date
    title: "Date"
    type: date_filter
    default_value: 7 Days

  
  
  elements:
  - name: total_visits
    title: Total Visits
    type: single_value
    base_view: sessions
    measures: [sessions.count]
    listen:
     date: sessions.start_date
    width: 3
    height: 2
    
  - name: visitors
    title: Total Visitors
    type: single_value
    base_view: sessions
    measures: [sessions.sessions_from_new_visitors_count]
    listen:
     date: sessions.start_date
    width: 3
    height: 2
    
  - name: conversion_rate
    title: Conversion Rate
    type: single_value
    base_view: sessions
    measures: [sessions.conversion_rate_temp]
    listen:
     date: sessions.start_date
    width: 3
    height: 2

  - name: bounce_rate
    title: Bounce Rate
    type: single_value
    base_view: sessions
    measures: [sessions.bounce_rate]
    listen:
     date: sessions.start_date
    width: 3
    height: 2

  - name: web_stats_by_device
    title: Web Stats by Device
    type: table
    base_view: sessions
    dimensions: [sessions.device_type]
    measures: [sessions.count, visitors.count, sessions.pages_per_session, sessions.average_session_duration,
    sessions.bounce_rate, sessions.new_visitor_percentage, sessions.conversion_rate_temp]
    listen:
     date: sessions.start_date
    sorts: [sessions.count desc]
    colors: [red, orange]
    limit: 50
    width: 6
    height: 2

  - name: web_stats_by_browser
    title: Web Stats by Browser
    type: table
    base_view: sessions
    dimensions: [sessions.browser_family]
    measures: [sessions.count, visitors.count, sessions.pages_per_session, sessions.average_session_duration,
    sessions.bounce_rate, sessions.new_visitor_percentage, sessions.conversion_rate_temp]
    listen:
     date: sessions.start_date
    sorts: [sessions.count desc]
    limit: 50
    width: 6
    height: 3
  
  - name: visits_by_day
    title: Visits
    type: looker_line
    base_view: sessions
    dimensions: [sessions.start_date]
    measures: [sessions.count, sessions.sessions_from_new_visitors_count]
    listen:
     date: sessions.start_date
    series_labels:
     "sessions.count": "Total"
     "sessions.sessions_from_new_visitors_count": "New Visitors"
    colors: [maroon, mediumslateblue]
    sorts: [sessions.start_date desc]
    limit: 500
    show_null_labels: false
    show_null_points: true
    point_style: circle
    x_axis_scale: auto
    y_axis_combined: true
    y_axis_labels: "Visits"
    interpolation: linear
    width: 6
    height: 4
    
  #- name: exit_rates_by_page
  #  title: Exit Rates by Page
  #  type: table
  #  base_view: page_views
  #  dimensions: [page_views.page_type]
  #  measures: [page_views.count_views, page_views.count_exits, page_views.exit_rate]
  #  listen:
  #   date: sessions.start_date
  #  sorts: [page_views.count_views desc]
  #  width: 6
  #  height: 3
    
  - name: visits_by_hour
    title: Visits by Hour
    type: looker_line
    base_view: sessions
    dimensions: [sessions.start_hod]
    measures: [sessions.count]
    listen:
     date: sessions.start_date
    sorts: [sessions.count desc 0]
    limit: 500
    colors: [lightseagreen]
    show_null_points: true
    show_null_labels: false
    stacking: ''
    point_style: circle
    x_axis_scale: auto
    y_axis_labels: [Visits]
    interpolation: linear
    width: 6
    height: 3

    
  - name: exit_rates_by_page_and_browser
    title: Exit Rates by Page and Browser
    type: looker_column
    base_view: page_views
    dimensions: [page_views.browser_family, page_views.page_type]
    pivots: [page_views.browser_family]
    measures: [page_views.exit_rate]
    listen:
     date: sessions.start_date
    sorts: [page_views.page_type]
    limit: 500
    show_null_labels: false
    column_spacing_ratio: 0.2
    hide_legend: false
    column_group_spacing_ratio: 0.3
    stacking: ''
    x_axis_label: ''
    y_axis_labels: [Exit Rate (%)]
    y_axis_max: ['100']
    y_axis_min: ['0']
    width: 12
    height: 4

  - name: where_do_visitors_reach
    title: How far do Visitors reach on the site?
    type: looker_pie
    base_view: sessions
    dimensions: [sessions.site_progress]
    measures: [sessions.count_percent_of_total]
    listen:
     date: sessions.start_date
    filters:
      sessions.site_progress: -Error
    sorts: [sessions.site_progress]
    limit: 500
    show_null_labels: false
    show_null_points: true
    width: 6
    height: 4
    
  - name: payment_funnel
    title: Payment Funnel - Where do we lose Visitors?
    type: looker_column
    base_view: sessions
    dimensions: [sessions.site_progress]
    measures: [sessions.count_percent_of_total]
    listen:
     date: sessions.start_date
    colors: [darkolivegreen]
    filters:
      sessions.site_progress: 4 - View Cart, 5 - Checkout - Enter Address, 6 - Checkout - Delivery, 7 - Checkout - Payment, 8 - Order Completed
    sorts: [sessions.site_progress]
    limit: 500
    y_axis_labels: "Visitors Lost (%)"
    show_null_labels: false
    show_null_points: true
    stacking: ''
    width: 6
    height: 4

  
