- dashboard: royal_mail
  title: Royal Mail
  layout: static
  tile_size: 100

#  filters:

  elements:

  - name: rm_delivery_volumes_by_week
    title: RM Delivery Volumes by Week
    type: looker_column
    model: finery_data
    explore: spree_orders
    dimensions: [spree_orders.completed_week]
    measures: [spree_orders.RM_orders]
    filters:
      spree_orders.completed_week: 10 weeks ago for 10 weeks
      spree_orders.completed_date: after 2016/10/03
      spree_orders.RM_order_flag: '1'
    sorts: [spree_orders.completed_week desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
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
    totals_color: '#808080'
    show_null_points: true
    point_style: none
    interpolation: linear
    series_types: {}
    colors: 'palette: Santa Cruz'
    series_colors: {}
    column_spacing_ratio: ''
    column_group_spacing_ratio: ''
    hide_legend: false
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: 0
    show_dropoff: false
    width: 6
    height: 4
    top: 0
    left: 0

  - name: 48h_vs_24h_delivery
    title: Next Day vs Standard Delivery
    type: looker_column
    model: finery_data
    explore: spree_orders
    dimensions: [spree_orders.delivery_type, spree_orders.completed_week]
    pivots: [spree_orders.delivery_type]
    measures: [spree_orders.RM_orders]
    filters:
      spree_orders.delivery_type: Standard Delivery,Next Day Delivery
      spree_orders.completed_date: after 2016/10/03
      spree_orders.completed_week: 10 weeks ago for 10 weeks
      spree_orders.RM_order_flag: '1'
    sorts: [spree_orders.completed_week desc, spree_orders.delivery_type]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
    stacking: percent
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
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
    totals_color: '#808080'
    colors: 'palette: Santa Cruz'
    series_colors: {}
    width: 6
    height: 4
    top: 0
    left: 6
    
    
  - name: percentage_on_time_delivery_attempt_next_day
    title: Percentage of On Time Delivery Attempt - Next Day Delivery
    type: looker_line
    model: finery_data
    explore: spree_orders
    dimensions: [spree_orders.delivery_type, spree_orders.completed_week]
    pivots: [spree_orders.delivery_type]
    measures: [spree_orders.percentage_of_on_time_rm_deliveries]
    filters:
      spree_orders.delivery_type: Next Day Delivery
      spree_orders.completed_date: after 2016/10/03
      spree_orders.completed_week: 10 weeks ago for 10 weeks
      spree_orders.RM_order_flag: '1'
    sorts: [spree_orders.completed_week desc, spree_orders.delivery_type]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
    stacking: percent
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: '#808080'
    colors: 'palette: Santa Cruz'
    series_colors: {}
    series_types: {}
    width: 6
    height: 4
    top: 4
    left: 0
    
  - name: percentage_on_time_delivery_attempt_standard
    title: Percentage of On Time Delivery Attempt - Standard Delivery
    type: looker_line
    model: finery_data
    explore: spree_orders
    dimensions: [spree_orders.delivery_type, spree_orders.completed_week]
    pivots: [spree_orders.delivery_type]
    measures: [spree_orders.percentage_of_on_time_rm_deliveries]
    filters:
      spree_orders.delivery_type: Standard Delivery
      spree_orders.completed_date: after 2016/10/03
      spree_orders.completed_week: 10 weeks ago for 10 weeks
      spree_orders.RM_order_flag: '1'
    sorts: [spree_orders.completed_week desc, spree_orders.delivery_type]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
    stacking: percent
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: '#808080'
    colors: 'palette: Santa Cruz'
    series_colors: {}
    series_types: {}
    width: 6
    height: 4
    top: 4
    left: 6


