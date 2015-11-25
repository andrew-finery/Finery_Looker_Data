- dashboard: facebook
  title: Facebook
  layout: tile
  tile_size: 100

#  filters:

  elements:

  - name: add_a_unique_name_1448469187432
    title: Impressions
    type: looker_area
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_date]
    measures: [facebook_daily_ad_performance.sum_impressions]
    filters:
      facebook_daily_ad_performance.calendar_date: 30 days ago for 30 days
    sorts: [facebook_daily_ad_performance.calendar_date desc]
    limit: 500
    show_view_names: false
    stacking: normal
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
    show_null_points: true
    point_style: circle
    interpolation: linear
    colors: [salmon]
    x_axis_label_rotation: -45


    
  - name: add_a_unique_name_1448468474256
    title: Clicks
    type: looker_area
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_date]
    measures: [facebook_daily_ad_performance.sum_clicks]
    filters:
      facebook_daily_ad_performance.calendar_date: 30 days ago for 30 days
    sorts: [facebook_daily_ad_performance.calendar_date desc]
    show_view_names: false
    ordering: none
    show_null_labels: false
    colors: [salmon]
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
    show_null_points: true
    point_style: circle
    interpolation: monotone
    swap_axes: false
    hide_legend: false
    font_size: 14px
    value_labels: legend
    label_type: labPer
    x_axis_label_rotation: -45
    x_axis_datetime_tick_count: 0
