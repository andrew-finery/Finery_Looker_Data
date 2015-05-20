- dashboard: website_technology
  title: Website Technology
  layout: static
  tile_size: 50
  show_applied_filters: true

#  filters:

  elements:

  - name: orders_by_hour_by_device_yest
    title: Orders by Hour by Device - Yesterday
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
    show_view_names: false
    top: 0
    left: 0
    height: 6
    width: 12
    
  - name: visit_split_by_device
    title: Visit Split by Device - Last 30 Days
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
    show_view_names: false
    top: 0
    left: 12
    height: 6
    width: 6

  - name: orders_split_by_device
    title: Orders Split by Device - Last 30 Days
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
    show_view_names: false
    top: 0
    left: 18
    height: 6
    width: 6

## Visits Tables
    
  - name: dektop_visits_table
    title: Computer Visits
    type: table
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_date]
    measures: [sessions.count]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Week on Week
      expression: |
        concat(round(100 * (${sessions.count} - offset(${sessions.count},1))/offset(${sessions.count},1),2),"%")
    filters:
      sessions.start_date: 15 days ago, 8 days ago, 1 day ago
      sessions.device_type: Desktop
    sorts: [sessions.start_date desc]
    show_view_name: false
    limit: 500
    height: 4
    width: 8
    top: 6
    left: 0

  - name: mobile_visits_table
    title: Mobile Visits
    type: table
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_date]
    measures: [sessions.count]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Week on Week
      expression: |
        concat(round(100 * (${sessions.count} - offset(${sessions.count},1))/offset(${sessions.count},1),2),"%")
    filters:
      sessions.start_date: 15 days ago, 8 days ago, 1 day ago
      sessions.device_type: Mobile
    sorts: [sessions.start_date desc]
    show_view_names: false
    limit: 500
    height: 4
    width: 8
    top: 6
    left: 8

  - name: tablet_visits_table
    title: Tablet Visits
    type: table
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_date]
    measures: [sessions.count]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Week on Week
      expression: |
        concat(round(100 * (${sessions.count} - offset(${sessions.count},1))/offset(${sessions.count},1),2),"%")
    filters:
      sessions.start_date: 15 days ago, 8 days ago, 1 day ago
      sessions.device_type: Tablet
    sorts: [sessions.start_date desc]
    show_view_name: false
    limit: 500
    height: 4
    width: 8
    top: 6
    left: 16

## Visits Graphs

  - name: sessions_tw_vs_lw_computer
    title: Visits This Week vs Last Week vs Week Before Last - Computer
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_day_of_week, sessions.start_week]
    pivots: [sessions.start_week]
    measures: [sessions.count]
    filters:
      sessions.start_date: 2 weeks ago for 3 weeks
      sessions.start_time: before 0 days ago
      sessions.device_type: Desktop
    sorts: [sessions.start_day_of_week, sessions.start_week desc]
    limit: 500
    total: false
    font_size: small
    show_null_points: false
    show_value_labels: false
    show_view_names: false
    show_x_axis_label: true
    show_x_axis_ticks: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    x_axis_datetime_label: ''
    x_axis_label: Day
    discontinuous_nulls: false
    interpolation: monotone
    colors: [blue, red, lightgreen]
    stacking: ''
    x_axis_scale: auto
    point_style: none
    height: 6
    width: 8
    top: 10
    left: 0

  - name: sessions_tw_vs_lw_mobile
    title: Visits This Week vs Last Week vs Week Before Last - Mobile
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_day_of_week, sessions.start_week]
    pivots: [sessions.start_week]
    measures: [sessions.count]
    filters:
      sessions.start_date: 2 weeks ago for 3 weeks
      sessions.start_time: before 0 days ago
      sessions.device_type: Mobile
    sorts: [sessions.start_day_of_week, sessions.start_week desc]
    limit: 500
    total: false
    font_size: small
    show_null_points: false
    show_value_labels: false
    show_view_names: false
    show_x_axis_label: true
    show_x_axis_ticks: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    x_axis_datetime_label: ''
    x_axis_label: Day
    discontinuous_nulls: false
    interpolation: monotone
    colors: [blue, red, lightgreen]
    stacking: ''
    x_axis_scale: auto
    point_style: none
    height: 6
    width: 8
    top: 10
    left: 8

  - name: sessions_tw_vs_lw_tablet
    title: Visits This Week vs Last Week vs Week Before Last - Tablet
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_day_of_week, sessions.start_week]
    pivots: [sessions.start_week]
    measures: [sessions.count]
    filters:
      sessions.start_date: 2 weeks ago for 3 weeks
      sessions.start_time: before 0 days ago
      sessions.device_type: Tablet
    sorts: [sessions.start_day_of_week, sessions.start_week desc]
    limit: 500
    total: false
    font_size: small
    show_null_points: false
    show_value_labels: false
    show_view_names: false
    show_x_axis_label: true
    show_x_axis_ticks: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    x_axis_datetime_label: ''
    x_axis_label: Day
    discontinuous_nulls: false
    interpolation: monotone
    colors: [blue, red, lightgreen]
    stacking: ''
    x_axis_scale: auto
    point_style: none
    height: 6
    width: 8
    top: 10
    left: 16
    
## Orders Tables
    
  - name: computer_orders_table
    title: Computer Orders
    type: table
    model: finery_data
    explore: sessions
    dimensions: [transactions.trans_time_date]
    measures: [transactions.count_transactions]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Week on Week
      expression: |
        concat(round(100 * (${transactions.count_transactions} - offset(${transactions.count_transactions},1))/offset(${transactions.count_transactions},1),2),"%")
    filters:
      transactions.trans_time_date: 15 days ago, 8 days ago, 1 day ago
      sessions.device_type: Desktop
    sorts: [transactions.trans_time_date desc]
    show_view_name: false
    limit: 500
    height: 4
    width: 8
    top: 16
    left: 0

  - name: mobile_orders_table
    title: Mobile Orders
    type: table
    model: finery_data
    explore: sessions
    dimensions: [transactions.trans_time_date]
    measures: [transactions.count_transactions]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Week on Week
      expression: |
        concat(round(100 * (${transactions.count_transactions} - offset(${transactions.count_transactions},1))/offset(${transactions.count_transactions},1),2),"%")
    filters:
      transactions.trans_time_date: 15 days ago, 8 days ago, 1 day ago
      sessions.device_type: Mobile
    sorts: [transactions.trans_time_date desc]
    show_view_name: false
    height: 4
    width: 8
    top: 16
    left: 8

  - name: tablet_orders_table
    title: Tablet Orders
    type: table
    model: finery_data
    explore: sessions
    dimensions: [transactions.trans_time_date]
    measures: [transactions.count_transactions]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Week on Week
      expression: |
        concat(round(100 * (${transactions.count_transactions} - offset(${transactions.count_transactions},1))/offset(${transactions.count_transactions},1),2),"%")
    filters:
      transactions.trans_time_date: 15 days ago, 8 days ago, 1 day ago
      sessions.device_type: Tablet
    sorts: [transactions.trans_time_date desc]
    show_view_name: false
    height: 4
    width: 8
    top: 16
    left: 16

  - name: computer orders_tw_vs_lw
    title: Orders This Week vs Last Week vs Week Before Last - Computer
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_day_of_week, sessions.start_week]
    pivots: [sessions.start_week]
    measures: [transactions.count_transactions]
    filters:
      sessions.start_date: 2 weeks ago for 3 weeks
      sessions.start_time: before 0 days ago
      sessions.device_type: Desktop
    sorts: [sessions.start_day_of_week, sessions.start_week desc]
    limit: 500
    total: false
    font_size: small
    show_null_points: false
    show_value_labels: false
    show_view_names: true
    show_x_axis_label: true
    show_x_axis_ticks: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    x_axis_datetime_label: ''
    x_axis_label: Day
    discontinuous_nulls: false
    interpolation: monotone
    colors: [blue, red, lightgreen]
    stacking: ''
    x_axis_scale: auto
    point_style: none
    height: 6
    width: 8
    top: 20
    left: 0
