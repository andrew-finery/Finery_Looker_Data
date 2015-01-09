- dashboard: web_stats_report
  title: Web Stats Report
  layout: tile
  tile_size: 100

  filters:
  - name: date
    title: "Graph Filter - Date"
    type: date_filter
    default_value: 7 days ago for 7 days

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
    
  - name: percentage_logins
    title: Percentage of Logins
    type: looker_pie
    model: finery_data
    explore: sessions
    dimensions: [payment_funnel.logged_in]
    measures: [sessions.count]
    listen:
     date: sessions.start_date
    sorts: [sessions.count desc]
    limit: 500
    width: 3
    height: 2
    colors: [skyblue, red]
    hide_legend: false
    
  - name: conversion_rate
    title: Conversion Rate (from Logins)
    type: single_value
    base_view: sessions
    measures: [payment_funnel.order_completed_percentage]
    filters:
      payment_funnel.logged_in: yes
    listen:
     date: sessions.start_date
    width: 3
    height: 2

  - name: bounce_rate_by_login_status
    title: Bounce Rate by Login (Yes/No)
    type: looker_column
    model: finery_data
    explore: sessions
    dimensions: [payment_funnel.logged_in]
    measures: [sessions.bounce_rate]
    listen:
     date: sessions.start_date
    sorts: [payment_funnel.logged_in desc]
    limit: 500
    colors: [darkgreen]
    hide_legend: false
    width: 3
    height: 2

  - name: web_stats_by_device
    title: Web Stats by Device (Logins)
    type: table
    base_view: sessions
    dimensions: [sessions.device_type]
    measures: [sessions.count, visitors.count, sessions.pages_per_session, sessions.average_session_duration,
    sessions.bounce_rate, sessions.new_visitor_percentage, payment_funnel.order_completed_percentage]
    filters:
      payment_funnel.logged_in: 'Yes'
    listen:
     date: sessions.start_date
    sorts: [sessions.count desc]
    colors: [red, orange]
    limit: 3
    width: 6
    height: 2

  - name: web_stats_by_browser
    title: Web Stats by Browser (Logins)
    type: table
    base_view: sessions
    dimensions: [sessions.browser_family]
    measures: [sessions.count, visitors.count, sessions.pages_per_session, sessions.average_session_duration,
    sessions.bounce_rate, sessions.new_visitor_percentage, payment_funnel.order_completed_percentage]
    filters:
      payment_funnel.logged_in: 'Yes'
    listen:
     date: sessions.start_date
    sorts: [sessions.count desc]
    limit: 5
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
    filters:
     page_views.browser_family: '"Apple WebKit","Chrome","Firefox","Internet Explorer","Safari"'
    listen:
     date: page_views.page_viewed_at_date
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
    title: How far do Visitors reach on the site? (Once they have logged in)
    type: looker_pie
    base_view: sessions
    dimensions: [sessions.site_progress]
    measures: [sessions.count_percent_of_total]
    listen:
     date: sessions.start_date
    filters:
      payment_funnel.logged_in: 'Yes'
      sessions.site_progress: -Error
    sorts: [sessions.site_progress]
    limit: 500
    show_null_labels: false
    show_null_points: true
    width: 6
    height: 4
    
  - name: payment_funnel
    title: Payment Funnel (Once User Logs In)
    type: looker_column
    model: finery_data
    explore: sessions
    measures: [payment_funnel.added_to_cart_percentage, payment_funnel.checkout_started_percentage,
      payment_funnel.address_entered_percentage, payment_funnel.delivery_method_percentage,
      payment_funnel.order_completed_percentage]
    filters:
      payment_funnel.logged_in: 'Yes'
    listen:
     date: sessions.start_date
    sorts: [payment_funnel.added_to_cart_percentage desc]
    series_labels:
     "payment_funnel.added_to_cart_percentage": "Added to Cart"
     "payment_funnel.checkout_started_percentage": "Checkout Started"
     "payment_funnel.address_entered_percentage": "Address Entered"
     "payment_funnel.delivery_method_percentage": "Delivery Method Selected"
     "payment_funnel.order_completed_percentage": "Order Placed"
    limit: 500
    colors: [GREEN, BLUE, BLACK, RED, PURPLE]
    show_null_labels: false
    show_null_points: true
    stacking: ''
    y_axis_combined: true
    show_value_labels: false
    show_view_names: true
    x_axis_scale: auto
    width: 6
    height: 4
    
  - name: payment_funnel_by_browser
    title: Payment Funnel by Browser (Once User Logs In)
    type: looker_column
    model: finery_data
    explore: sessions
    dimensions: [sessions.browser_family]
    measures: [payment_funnel.added_to_cart_percentage, payment_funnel.checkout_started_percentage,
      payment_funnel.address_entered_percentage, payment_funnel.delivery_method_percentage,
      payment_funnel.order_completed_percentage]
    filters:
      payment_funnel.logged_in: 'Yes'
    listen:
      date: sessions.start_date
    sorts: [payment_funnel.added_to_cart_percentage desc]
    series_labels:
     "payment_funnel.added_to_cart_percentage": "Added to Cart"
     "payment_funnel.checkout_started_percentage": "Checkout Started"
     "payment_funnel.address_entered_percentage": "Address Entered"
     "payment_funnel.delivery_method_percentage": "Delivery Method Selected"
     "payment_funnel.order_completed_percentage": "Order Placed"
    limit: 500
    colors: [GREEN, BLUE, BLACK, RED, PURPLE]
    stacking: ''
    y_axis_combined: true
    show_null_labels: false
    show_null_points: true
    show_value_labels: false
    show_view_names: true
    x_axis_scale: auto
    width: 6
    height: 4



  
