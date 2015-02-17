- dashboard: marketing_overview_dashboard
  title: Marketing Overview Dashboard
  layout: static
  show_applied_filters: true
  tile_size: 50

  filters:
  - name: date
    title: "Date Filter"
    type: date_filter
    default_value: 7 days ago for 7 days

  elements:

#################### Line 1: Total Summary Table

  - name: user_split_by_source_pie_chart
    title: Where do the users come from?
    type: looker_pie
    model: finery_data
    explore: atomic_events
    dimensions: [sessions_source.session_source]
    measures: [atomic_events.count_users]
    listen:
     date: atomic_events.event_time_date
    sorts: [atomic_events.count_sessions desc]
    show_view_names: false
    limit: 500
    total: true
    show_null_points: true
    width: 10
    height: 6
    top: 0
    left: 0
  
  - name: traffic_overview_table
    title: Traffic Overview
    type: table
    model: finery_data
    explore: atomic_events
    dimensions: [sessions_source.session_source]
    measures: [atomic_events.count_sessions, atomic_events.count_users, atomic_events.count_new_users,
      atomic_events.new_user_percentage, transactions.count_transactions, atomic_events.sum_revenue_ex_coupon_and_vat, atomic_events.conversion_rate]
    listen:
     date: atomic_events.event_time_date
    sorts: [atomic_events.count_sessions desc]
    show_view_names: false
    limit: 500
    total: true
    width: 18
    height: 6
    top: 0
    left: 10

################################ Line 2: Users trend

  - name: add_a_unique_name_212
    title: Users by Source Trend
    type: looker_area
    model: finery_data
    explore: atomic_events
    dimensions: [sessions_source.session_source, atomic_events.event_time_date]
    pivots: [sessions_source.session_source]
    measures: [atomic_events.count_users]
    listen:
     date: atomic_events.event_time_date
    sorts: [atomic_events.event_time_date]
    limit: 500
    total: false
    show_view_names: false
    show_null_points: true
    hide_legend: false
    swap_axes: false
    point_style: none
    interpolation: linear
    stacking: normal
    show_value_labels: false
    show_null_labels: false
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_gridlines: true
    show_dropoff: false
    y_axis_combined: false
    x_axis_scale: auto
    width: 28
    height: 9
    top: 6
    left: 0

################################ Line 3: Revenue trend
  - name: add_a_unique_name_212
    title: Users by Source Trend
    type: looker_area
    model: finery_data
    explore: atomic_events
    dimensions: [sessions_source.session_source, atomic_events.event_time_date]
    pivots: [sessions_source.session_source]
    measures: [atomic_events.sum_revenue_ex_coupon_and_vat]
    listen:
     date: atomic_events.event_time_date
    sorts: [atomic_events.event_time_date]
    limit: 500
    total: false
    show_view_names: false
    show_null_points: true
    hide_legend: false
    swap_axes: false
    point_style: none
    interpolation: linear
    stacking: normal
    show_value_labels: false
    show_null_labels: false
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_gridlines: true
    show_dropoff: false
    y_axis_combined: false
    x_axis_scale: auto
    width: 28
    height: 9
    top: 15
    left: 0
############################## Line 4: Conversion Rates and Revenue by Source
    
  - name: add_a_unique_name_904
    title: Conversion Rate by Source
    type: looker_bar
    model: finery_data
    explore: atomic_events
    dimensions: [sessions_source.session_source]
    measures: [atomic_events.conversion_rate]
    listen:
     date: atomic_events.event_time_date
    sorts: [atomic_events.conversion_rate desc 0]
    limit: 500
    total: true
    show_view_names: false
    stacking: ''
    show_value_labels: false
    x_axis_gridlines: false
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    hide_legend: false
    y_axis_combined: true
    show_null_labels: false
    show_dropoff: false
    x_axis_scale: auto
    show_null_points: true
    swap_axes: false
    point_style: none
    interpolation: linear
    width: 8
    height: 8
    top: 24
    left: 0

  - name: add_a_unique_name_200
    title: Users vs Revenue by Source
    type: looker_column
    model: finery_data
    explore: atomic_events
    dimensions: [sessions_source.session_source]
    measures: [atomic_events.count_users, atomic_events.sum_revenue_ex_coupon_and_vat]
    listen:
     date: atomic_events.event_time_date
    sorts: [atomic_events.count_users desc]
    limit: 500
    total: true
    stacking: ''
    show_value_labels: true
    show_view_names: false
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_gridlines: true
    hide_legend: false
    y_axis_combined: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: false
    show_null_points: true
    swap_axes: false
    point_style: none
    interpolation: linear
    width: 20
    height: 8
    top: 24
    left: 8

################# Line 5: Facebook - Paid Marketing Section
  - name: add_a_unique_name_304
    title: Facebook Summary by Campaign
    type: table
    model: finery_data
    explore: atomic_events
    dimensions: [sessions_source.campaign_name]
    measures: [atomic_events.count_sessions, atomic_events.count_users, atomic_events.count_new_users,
      atomic_events.new_user_percentage, transactions.count_transactions, atomic_events.sum_revenue_ex_coupon_and_vat,
      atomic_events.conversion_rate]
    listen:
     date: atomic_events.event_time_date
    filters:
      sessions_source.session_source: Facebook - Paid Marketing
    sorts: [atomic_events.count_users desc]
    show_view_names: false
    limit: 500
    total: true
    width: 16
    height: 6
    top: 34
    left: 0
    
  - name: add_a_unique_name_25
    title: Facebook Conversion Rates by Campaign
    type: looker_line
    model: finery_data
    explore: atomic_events
    dimensions: [atomic_events.event_time_date, sessions_source.campaign_name]
    pivots: [sessions_source.campaign_name]
    measures: [atomic_events.conversion_rate]
    listen:
     date: atomic_events.event_time_date
    filters:
      sessions_source.session_source: Facebook - Paid Marketing
    sorts: [atomic_events.conversion_rate desc 0]
    limit: 500
    total: true
    show_null_points: true
    stacking: ''
    show_view_names: false
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_gridlines: true
    hide_legend: false
    y_axis_combined: false
    swap_axes: false
    x_axis_scale: auto
    point_style: none
    interpolation: linear
    show_null_labels: false
    show_dropoff: false
    width: 12
    height: 6
    top: 34
    left: 16
    
########################### Line 6: Emails - From Finery

  - name: add_a_unique_name_957
    title: Email Summary by Campaign
    type: table
    model: finery_data
    explore: atomic_events
    dimensions: [sessions_source.campaign_name]
    measures: [atomic_events.count_sessions, atomic_events.count_users, atomic_events.count_new_users,
      atomic_events.new_user_percentage, transactions.count_transactions, atomic_events.sum_revenue_ex_coupon_and_vat,
      atomic_events.conversion_rate]
    listen:
     date: atomic_events.event_time_date
    filters:
      sessions_source.session_source: Email - from Finery
      atomic_events.count_sessions: '>10'
    sorts: [atomic_events.count_users desc]
    limit: 500
    total: false
    show_view_names: false
    width: 16
    height: 12
    top: 42
    left: 0
    
  - name: add_a_unique_name_500
    title: Conversion Rates by Email Campaign
    type: looker_bar
    model: finery_data
    explore: atomic_events
    dimensions: [sessions_source.campaign_name]
    measures: [atomic_events.conversion_rate]
    listen:
     date: atomic_events.event_time_date
    filters:
      sessions_source.session_source: Email - from Finery
      atomic_events.count_sessions: '>10'
    sorts: [atomic_events.conversion_rate desc]
    limit: 500
    total: false
    show_null_points: true
    stacking: ''
    show_value_labels: false
    show_null_labels: false
    show_view_names: false
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_gridlines: true
    hide_legend: false
    y_axis_combined: false
    swap_axes: false
    x_axis_scale: auto
    point_style: none
    interpolation: linear
    show_dropoff: false
    width: 12
    height: 12
    top: 42
    left: 16

############################ Line 7: Search Engines
  
  - name: add_a_unique_name_931
    title: Search Engines Used
    type: looker_pie
    model: finery_data
    explore: atomic_events
    dimensions: [sessions_source.referer_source]
    measures: [atomic_events.count_users]
    listen:
     date: atomic_events.event_time_date
    filters:
      sessions_source.session_source: Search
    sorts: [atomic_events.count_users desc]
    limit: 500
    total: false
    show_null_points: true
    hide_legend: false
    swap_axes: false
    point_style: none
    interpolation: linear
    stacking: ''
    show_value_labels: true
    show_null_labels: false
    show_view_names: false
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_gridlines: true
    show_dropoff: false
    y_axis_combined: false
    x_axis_scale: auto
    width: 12
    height: 6
    top: 56
    left: 0
    
  - name: add_a_unique_name_401
    title: Top Search Terms
    type: table
    model: finery_data
    explore: atomic_events
    dimensions: [sessions_source.referer_term]
    measures: [atomic_events.count_users]
    listen:
     date: atomic_events.event_time_date
    filters:
      sessions_source.referer_term: -NULL
      sessions_source.session_source: Search
    sorts: [atomic_events.count_users desc]
    limit: 10
    total: false
    show_view_names: false
    width: 16
    height: 6
    top: 56
    left: 12
    
######################## Line 8: Affiliates and Social

  - name: add_a_unique_name_751
    title: Top 10 Affiliates
    type: table
    model: finery_data
    explore: atomic_events
    dimensions: [sessions_source.referer_url_host]
    measures: [atomic_events.count_sessions, atomic_events.count_users, atomic_events.count_new_users,
      atomic_events.new_user_percentage, transactions.count_transactions, atomic_events.sum_revenue_ex_coupon_and_vat,
      atomic_events.conversion_rate]
    listen:
     date: atomic_events.event_time_date
    filters:
      sessions_source.session_source: Affiliates
    sorts: [atomic_events.count_sessions desc]
    limit: 10
    total: false
    show_view_names: false
    width: 14
    height: 8
    top: 64
    left: 0

  - name: add_a_unique_name_644
    title: Top 10 Social
    type: table
    model: finery_data
    explore: atomic_events
    dimensions: [sessions_source.referer_source]
    measures: [atomic_events.count_sessions, atomic_events.count_users, atomic_events.count_new_users,
      atomic_events.new_user_percentage, transactions.count_transactions, atomic_events.sum_revenue_ex_coupon_and_vat,
      atomic_events.conversion_rate]
    listen:
     date: atomic_events.event_time_date
    filters:
      sessions_source.session_source: Social
    sorts: [atomic_events.count_sessions desc]
    limit: 10
    total: false
    show_view_names: false
    width: 14
    height: 8
    top: 64
    left: 14

