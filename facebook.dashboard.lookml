- dashboard: facebook
  title: Facebook
  layout: static
  tile_size: 100

#  filters:

  elements:
  
  - name: add_a_unique_name_1448542053708
    title: Orders
    type: looker_area
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_date]
    measures: [facebook_daily_ad_performance.sum_orders]
    filters:
      facebook_daily_ad_performance.calendar_date: 30 days ago for 30 days
    sorts: [facebook_daily_ad_performance.sum_orders desc]
    limit: 500
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
    show_null_points: true
    point_style: circle
    interpolation: monotone
    colors: [orange]
    ordering: none
    show_null_labels: false
    y_axis_orientation: [left, left, right]
    width: 4
    height: 3
    top: 0
    left: 0

  - name: spend_last_30_days
    title: Spend
    type: looker_area
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_date]
    measures: [facebook_daily_ad_performance.total_spend]
    filters:
      facebook_daily_ad_performance.calendar_date: 30 days ago for 30 days
    sorts: [facebook_daily_ad_performance.calendar_date desc]
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
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_date]
    measures: [facebook_daily_ad_performance.total_impressions]
    filters:
      facebook_daily_ad_performance.calendar_date: 30 days ago for 30 days
    sorts: [facebook_daily_ad_performance.calendar_date desc]
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
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_date]
    measures: [facebook_daily_ad_performance.total_clicks]
    filters:
      facebook_daily_ad_performance.calendar_date: 30 days ago for 30 days
    sorts: [facebook_daily_ad_performance.calendar_date desc]
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
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_date]
    measures: [facebook_daily_ad_performance.cost_per_mille]
    filters:
      facebook_daily_ad_performance.calendar_date: 30 days ago for 30 days
    sorts: [facebook_daily_ad_performance.calendar_date desc]
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
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_date]
    measures: [facebook_daily_ad_performance.cost_per_click]
    filters:
      facebook_daily_ad_performance.calendar_date: 30 days ago for 30 days
    sorts: [facebook_daily_ad_performance.calendar_date desc]
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
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_date]
    measures: [facebook_daily_ad_performance.click_through_rate]
    filters:
      facebook_daily_ad_performance.calendar_date: 30 days ago for 30 days
    sorts: [facebook_daily_ad_performance.calendar_date desc]
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



  