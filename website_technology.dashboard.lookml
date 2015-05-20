- dashboard: website_technology
  title: Website Technology
  layout: static
  tile_size: 50
  show_applied_filters: true

#  filters:

  elements:

  - name: visits_by_hour_by_device_yest
    title: Visits by Hour by Device - Yesterday
    type: looker_area
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_hour_of_day, sessions.device_type]
    pivots: [sessions.device_type]
    measures: [sessions.count]
    filters:
      sessions.device_type: -Other/Unknown
      sessions.start_date: yesterday
    sorts: [sessions.start_hour_of_day]
    limit: 500
    column_limit: ''
    show_value_labels: false
    show_view_names: true
    stacking: normal
    show_null_labels: false
    interpolation: monotone
    swap_axes: false
    point_style: none
    x_axis_gridlines: false
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    x_axis_scale: auto
    show_null_points: true
    top: 0
    left: 0
    height: 6
    width: 12
    
  - name: visit_split_by_device
    title: Visit Split by Device
    type: looker_pie
    model: finery_data
    explore: sessions
    dimensions: [sessions.device_type]
    measures: [sessions.count]
    filters:
      sessions.device_type: -Other/Unknown
      sessions.start_date: last 30 days
    sorts: [sessions.count desc]
    limit: 500
    column_limit: ''
    show_view_names: true
    show_value_labels: false
    show_null_labels: false
    stacking: percent
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_gridlines: true
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_gridlines: false
    top: 0
    left: 12
    height: 6
    width: 6

  - name: order_split_by_device
    title: Order Split by Device
    type: looker_pie
    model: finery_data
    explore: sessions
    dimensions: [sessions.device_type]
    measures: [transactions.count_transactions]
    filters:
      sessions.device_type: -Other/Unknown
      sessions.start_date: last 30 days
    sorts: [transactions.count_transactions desc]
    limit: 500
    column_limit: ''
    show_view_names: true
    show_value_labels: false
    show_null_labels: false
    stacking: percent
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_gridlines: true
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_gridlines: false
    top: 0
    left: 18
    height: 6
    width: 6


