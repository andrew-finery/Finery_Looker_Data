- dashboard: facebook_api
  title: Facebook API
  layout: static
  tile_size: 100

#  filters:

  elements:
  
  - name: spend_last_30_days
    title: Spend
    type: looker_area
    model: finery_data
    explore: facebook_api_ad_performance
    dimensions: [facebook_api_ad_performance.calendar_date]
    measures: [facebook_api_ad_performance.total_spend]
    filters:
      facebook_api_ad_performance.calendar_date: 30 days ago for 30 days
    sorts: [facebook_api_ad_performance.calendar_date desc]
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    show_null_points: true
    point_style: circle
    interpolation: monotone
    colors: [orange]
    width: 4
    height: 4
    top: 0
    left: 0

  - name: impressions_last_30_days
    title: Impressions
    type: looker_area
    model: finery_data
    explore: facebook_api_ad_performance
    dimensions: [facebook_api_ad_performance.calendar_date]
    measures: [facebook_api_ad_performance.total_impressions]
    filters:
      facebook_api_ad_performance.calendar_date: 30 days ago for 30 days
    sorts: [facebook_api_ad_performance.calendar_date desc]
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    show_null_points: true
    point_style: circle
    interpolation: monotone
    colors: [orange]
    width: 4
    height: 4
    top: 0
    left: 4
    
  - name: clicks_last_30_days
    title: Clicks
    type: looker_area
    model: finery_data
    explore: facebook_api_ad_performance
    dimensions: [facebook_api_ad_performance.calendar_date]
    measures: [facebook_api_ad_performance.total_clicks]
    filters:
      facebook_api_ad_performance.calendar_date: 30 days ago for 30 days
    sorts: [facebook_api_ad_performance.calendar_date desc]
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    show_null_points: true
    point_style: circle
    interpolation: monotone
    colors: [orange]
    width: 4
    height: 4
    top: 0
    left: 8
    
  - name: cpm_last_30_days
    title: Cost per 1000 Impressions
    type: looker_area
    model: finery_data
    explore: facebook_api_ad_performance
    dimensions: [facebook_api_ad_performance.calendar_date]
    measures: [facebook_api_ad_performance.cost_per_mille]
    filters:
      facebook_api_ad_performance.calendar_date: 30 days ago for 30 days
    sorts: [facebook_api_ad_performance.calendar_date desc]
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axis_combined: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    colors: [salmon]
    show_null_points: true
    point_style: circle
    interpolation: monotone
    ordering: none
    show_null_labels: false
    y_axis_orientation: [left, left, right]
    width: 4
    height: 3
    top: 4
    left: 0
    
  - name: cpc_last_30_days
    title: Cost per Click
    type: looker_area
    model: finery_data
    explore: facebook_api_ad_performance
    dimensions: [facebook_api_ad_performance.calendar_date]
    measures: [facebook_api_ad_performance.cost_per_click]
    filters:
      facebook_api_ad_performance.calendar_date: 30 days ago for 30 days
    sorts: [facebook_api_ad_performance.calendar_date desc]
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axis_combined: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    colors: [salmon]
    show_null_points: true
    point_style: circle
    interpolation: monotone
    ordering: none
    show_null_labels: false
    y_axis_orientation: [left, left, right]
    width: 4
    height: 3
    top: 4
    left: 8
    
  - name: ctr_last_30_days
    title: Click Through Rate
    type: looker_area
    model: finery_data
    explore: facebook_api_ad_performance
    dimensions: [facebook_api_ad_performance.calendar_date]
    measures: [facebook_api_ad_performance.click_through_rate]
    filters:
      facebook_api_ad_performance.calendar_date: 30 days ago for 30 days
    sorts: [facebook_api_ad_performance.calendar_date desc]
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axis_combined: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    colors: [salmon]
    show_null_points: true
    point_style: circle
    interpolation: monotone
    ordering: none
    show_null_labels: false
    y_axis_orientation: [left, left, right]
    width: 4
    height: 3
    top: 4
    left: 4
    
  - name: fb_visits_and_orders_last_30_days
    title: FB Visits and Orders Last 30 Days
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_date]
    measures: [sessions.sum_orders, sessions.count]
    filters:
      session_start_calendar.calendar_date_date: 30 days ago for 30 days
      sessions.acquisition_channel: Facebook - Paid Marketing
    sorts: [session_start_calendar.calendar_date_date]
    limit: 500
    stacking: ''
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
      '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    show_value_labels: false
    label_density: 25
    legend_position: center
    y_axis_gridlines: true
    show_view_names: false
    series_colors:
      sessions.count: lightblue
      sessions.sum_orders: darkgreen
    series_types:
      sessions.count: column
      sessions.sum_orders: line
    y_axis_combined: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: true
    show_x_axis_ticks: false
    x_axis_scale: ordinal
    y_axis_orientation: [left, right]
    show_null_points: false
    point_style: none
    interpolation: monotone
    width: 6
    height: 4
    top: 7
    left: 0
    
  - name: add_a_unique_name_1468935771926
    title: Untitled Table
    type: table
    model: finery_data
    explore: facebook_api_ad_performance
    dimensions: [facebook_api_ad_performance.calendar_week]
    measures: [facebook_api_ad_performance.total_spend, facebook_api_ad_performance.1d_total_action_purchase,
      facebook_api_ad_performance.1d_cpa_purchase, facebook_api_ad_performance.7d_total_action_purchase,
      facebook_api_ad_performance.7d_cpa_purchase, facebook_api_ad_performance.28d_cpa_purchase,
      facebook_api_ad_performance.28d_total_action_purchase]
    sorts: [facebook_api_ad_performance.calendar_week]
    limit: 500
    show_view_names: true
    table_theme: editable
    width: 6
    height: 4
    top: 7
    left: 6



