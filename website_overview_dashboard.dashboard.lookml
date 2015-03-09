- dashboard: website_overview_dashboard
  title: Website Overview Dashboard
  layout: static
  tile_size: 100

#  filters:

  elements:
  
################## Line 1

  - name: add_a_unique_name_265
    title: Latest Information Available
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.latest_update]
    sorts: [atomic_events.latest_update desc]
    limit: 500
    total: false
    font_size: medium
    height: 2
    width: 8
    top: 0
    left: 0
    
  - name: add_a_unique_name_109
    title: Orders Today
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [transactions.count_transactions]
    filters:
      atomic_events.event_time_date: today
    sorts: [transactions.count_transactions desc]
    limit: 500
    total: false
    font_size: medium
    height: 2
    width: 3
    top: 0
    left: 8

  - name: add_a_unique_name_158
    title: Conversion Rate Today
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.conversion_rate]
    filters:
      atomic_events.event_time_date: today
    sorts: [atomic_events.conversion_rate desc]
    limit: 500
    total: false
    font_size: medium
    height: 2
    width: 3
    top: 0
    left: 11

############################### Line 2    

  - name: add_a_unique_name_326
    title: Users Today
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.count_users]
    filters:
      atomic_events.event_time_date: today
    sorts: [atomic_events.count_users desc]
    limit: 500
    total: false
    font_size: medium
    height: 2
    width: 3
    top: 2
    left: 0
    
  - name: add_a_unique_name_711
    title: New Users Today
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.count_new_users]
    filters:
      atomic_events.event_time_date: today
    sorts: [atomic_events.count_new_users desc]
    limit: 500
    total: false
    font_size: medium
    height: 2
    width: 3
    top: 4
    left: 0

  - name: add_a_unique_name_611
    title: Users Today vs Last Week
    type: looker_line
    model: finery_data
    explore: atomic_events
    dimensions: [atomic_events.event_time_hour_of_day, atomic_events.event_time_date]
    pivots: [atomic_events.event_time_date]
    measures: [atomic_events.count_users]
    filters:
      atomic_events.event_time_time: before 1 hours ago
      atomic_events.wow_date_filter: 'Yes'
    sorts: [atomic_events.event_time_hour_of_day]
    limit: 500
    total: false
    show_null_points: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_combined: true
    x_axis_gridlines: false
    show_x_axis_label: true
    show_x_axis_ticks: true
    show_value_labels: false
    show_view_names: true
    stacking: ''
    x_axis_scale: auto
    point_style: none
    interpolation: linear
    height: 4
    width: 5
    top: 2
    left: 3

  - name: add_a_unique_name_404
    title: Sessions, Users and New Users - Last 7 Days
    type: looker_line
    model: finery_data
    explore: atomic_events
    dimensions: [atomic_events.event_time_date]
    measures: [atomic_events.count_sessions, atomic_events.count_users, atomic_events.count_new_users]
    filters:
      atomic_events.event_time_date: 7 days ago for 7 days
    sorts: [atomic_events.event_time_date desc]
    limit: 500
    total: false
    show_null_points: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_combined: true
    x_axis_gridlines: false
    show_x_axis_label: true
    show_x_axis_ticks: true
    show_value_labels: false
    show_view_names: true
    stacking: ''
    x_axis_scale: auto
    point_style: none
    interpolation: linear
    height: 4
    width: 6
    top: 2
    left: 8
    
########################## Line 3

  - name: add_a_unique_name_901
    title: Order by Hour - Today vs Last Week
    type: looker_line
    model: finery_data
    explore: atomic_events
    dimensions: [atomic_events.event_time_hour_of_day, atomic_events.event_time_date]
    pivots: [atomic_events.event_time_date]
    measures: [transactions.count_transactions]
    filters:
      atomic_events.event_time_time: before 1 hours ago
      atomic_events.wow_date_filter: 'Yes'
    sorts: [atomic_events.event_time_hour_of_day]
    limit: 500
    total: false
    show_null_points: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_combined: true
    x_axis_gridlines: false
    show_x_axis_label: true
    show_x_axis_ticks: true
    show_value_labels: false
    show_view_names: true
    stacking: ''
    x_axis_scale: auto
    point_style: none
    interpolation: linear
    height: 4
    width: 5
    top: 6
    left: 0

  - name: add_a_unique_name_532
    title: Conversion Rate by Hour - Last 7 Days
    type: looker_line
    model: finery_data
    explore: atomic_events
    dimensions: [atomic_events.event_time_hour_of_day]
    measures: [atomic_events.conversion_rate]
    filters:
      atomic_events.event_time_date: 7 days ago for 7 days
    sorts: [atomic_events.conversion_rate desc]
    limit: 500
    total: false
    show_null_points: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_combined: false
    x_axis_gridlines: false
    show_x_axis_label: true
    show_x_axis_ticks: true
    show_value_labels: false
    show_view_names: true
    stacking: ''
    x_axis_scale: auto
    point_style: none
    interpolation: linear
    height: 4
    width: 6
    top: 6
    left: 5

  - name: add_a_unique_name_974
    title: Conversion Rate - Last 7 Days
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.conversion_rate]
    filters:
      atomic_events.event_time_date: 7 days ago for 7 days
    sorts: [atomic_events.conversion_rate desc]
    limit: 500
    total: false
    font_size: medium
    height: 2
    width: 3
    top: 6
    left: 11

  - name: add_a_unique_name_363
    title: Avg Orders per Day - last 7 Days
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.orders_per_day]
    filters:
      atomic_events.event_time_date: 7 days ago for 7 days
    sorts: [atomic_events.orders_per_day desc]
    limit: 500
    total: false
    font_size: medium
    height: 2
    width: 3
    top: 8
    left: 11
    
######################### Line 4

  - name: add_a_unique_name_185
    title: Newsletter Subscriptions Today
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [email_subscriptions.count_newsletter_subscribers]
    filters:
      atomic_events.event_time_date: today
    sorts: [email_subscriptions.count_newsletter_subscribers desc]
    limit: 500
    total: false
    font_size: medium
    height: 2
    width: 3
    top: 10
    left: 0
    
  - name: add_a_unique_name_796
    title: Referrals Sent Today
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [email_subscriptions.count_referrals]
    filters:
      atomic_events.event_time_date: today
    sorts: [email_subscriptions.count_referrals desc]
    limit: 500
    total: false
    font_size: medium
    height: 2
    width: 3
    top: 12
    left: 0

  - name: add_a_unique_name_708
    title: Newsletter Subscriptions Today vs Last Week
    type: looker_line
    model: finery_data
    explore: atomic_events
    dimensions: [atomic_events.event_time_hour_of_day, atomic_events.event_time_date]
    pivots: [atomic_events.event_time_date]
    measures: [email_subscriptions.count_newsletter_subscribers]
    filters:
      atomic_events.event_time_time: before 1 hours ago
      atomic_events.wow_date_filter: 'Yes'
    sorts: [atomic_events.event_time_hour_of_day]
    limit: 500
    total: false
    show_null_points: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_combined: true
    x_axis_gridlines: false
    show_x_axis_label: true
    show_x_axis_ticks: true
    show_value_labels: false
    show_view_names: true
    stacking: ''
    x_axis_scale: auto
    point_style: none
    interpolation: linear
    height: 4
    width: 5
    top: 10
    left: 3

  - name: add_a_unique_name_819
    title: Newsletter Subscriptions and Referrals
    type: looker_line
    model: finery_data
    explore: atomic_events
    dimensions: [atomic_events.event_time_date]
    measures: [email_subscriptions.count_newsletter_subscribers, email_subscriptions.count_referrals]
    filters:
      atomic_events.event_time_date: 7 days ago for 7 days
    sorts: [atomic_events.event_time_date desc]
    limit: 500
    total: false
    show_null_points: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_combined: true
    x_axis_gridlines: false
    show_x_axis_label: true
    show_x_axis_ticks: true
    show_value_labels: false
    show_view_names: true
    stacking: ''
    x_axis_scale: auto
    point_style: none
    interpolation: linear
    height: 4
    width: 6
    top: 10
    left: 8

