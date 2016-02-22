- dashboard: hermes_performance_dashboard
  title: Hermes Performance
  layout: static
  tile_size: 100

  filters:
  - name: date
    title: "Date Filter - On Time % and Order Volumes"
    type: date_filter
    default_value: after 2015/02/02

  - name: date2
    title: "Date Filter - Late Delivery Reasons"
    type: date_filter
    default_value: last week

  elements:

  - name: order_vol_trend
    title: Order Volume Trend
    type: looker_column
    model: finery_data
    explore: spree_orders
    dimensions: [spree_orders.completed_week]
    measures: [spree_orders.count_hermes_completed_orders]
    listen:
     date: spree_orders.completed_date
    filters:
      spree_orders.completed_time: before this week
      spree_orders.delivery_type: '"Standard Delivery","Next Day Delivery","Sunday Delivery"'
    sorts: [spree_orders.completed_week]
    limit: 500
    show_view_names: true
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_labels: [Total Orders Shipped]
    stacking: ''
    show_value_labels: false
    x_axis_gridlines: false
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    show_null_points: false
    point_style: none
    interpolation: linear
    show_null_labels: false
    x_axis_label: Week Beginning
    x_axis_datetime_label: ''
    height: 4
    width: 8
    top: 0
    left: 0

  - name: perc_of_total_by_week
    title: Delivery Method Proportions
    type: looker_column
    model: finery_data
    explore: spree_orders
    dimensions: [spree_orders.completed_week, spree_orders.delivery_type]
    pivots: [spree_orders.delivery_type]
    measures: [spree_orders.count_hermes_completed_orders]
    listen:
     date: spree_orders.completed_date
    filters:
      spree_orders.completed_time: before this week
      spree_orders.delivery_type: '"Standard Delivery","Next Day Delivery","Sunday Delivery"'
    sorts: [spree_orders.completed_week]
    limit: 500
    show_view_names: true
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_labels: [Percentage of Total Orders]
    stacking: percent
    show_value_labels: false
    x_axis_gridlines: false
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    show_null_points: false
    point_style: none
    interpolation: linear
    show_null_labels: false
    x_axis_label: Week Beginning
    x_axis_datetime_label: ''
    height: 4
    width: 7
    top: 0
    left: 8

  - name: next_day_deliv_on_time_perc
    title: Next Day Delivery - On Time Percentage
    type: looker_line
    model: finery_data
    explore: spree_orders
    dimensions: [spree_orders.completed_week]
    measures: [spree_orders.hermes_on_time_percentage]
    listen:
     date: spree_orders.completed_date
    filters:
      spree_orders.completed_time: before this week
      spree_orders.delivery_type: '"Next Day Delivery"'
    sorts: [spree_orders.completed_week desc]
    limit: 500
    total: false
    show_view_names: false
    show_null_points: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_labels: [Hermes On-Time Percentage]
    stacking: ''
    show_value_labels: false
    x_axis_gridlines: false
    show_view_names: true
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_max: ['1']
    y_axis_min: ['0.8']
    reference_lines:
      - value: 0.988
        label: Hermes SLA
        color: crimson
    point_style: none
    interpolation: linear
    height: 4
    width: 5
    top: 4
    left: 0

  - name: 48h_deliv_on_time_perc
    title: Standard Delivery - On Time Percentage
    type: looker_line
    model: finery_data
    explore: spree_orders
    dimensions: [spree_orders.completed_week]
    measures: [spree_orders.hermes_on_time_percentage]
    listen:
     date: spree_orders.completed_date
    filters:
      spree_orders.completed_time: before this week
      spree_orders.delivery_type: '"Standard Delivery"'
    sorts: [spree_orders.completed_week desc]
    limit: 500
    total: false
    show_view_names: false
    show_null_points: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_labels: [Hermes On-Time Percentage]
    stacking: ''
    show_value_labels: false
    x_axis_gridlines: false
    show_view_names: true
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_max: ['1']
    y_axis_min: ['0.8']
    reference_lines:
      - value: 0.99
        label: Hermes SLA
        color: crimson
    point_style: none
    interpolation: linear
    height: 4
    width: 5
    top: 4
    left: 5
  
  - name: sunday_on_time_perc
    title: Sunday - On Time Percentage
    type: looker_line
    model: finery_data
    explore: spree_orders
    dimensions: [spree_orders.completed_week]
    measures: [spree_orders.hermes_on_time_percentage]
    listen:
     date: spree_orders.completed_date
    filters:
      spree_orders.completed_time: before this week
      spree_orders.delivery_type: '"Sunday Delivery"'
    sorts: [spree_orders.completed_week desc]
    limit: 500
    total: false
    show_view_names: false
    show_null_points: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_labels: [Hermes On-Time Percentage]
    stacking: ''
    show_value_labels: false
    x_axis_gridlines: false
    show_view_names: true
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_max: ['1']
    y_axis_min: ['0.9']
    reference_lines:
      - value: 0.99
        label: Hermes SLA
        color: crimson
    point_style: none
    interpolation: linear
    height: 4
    width: 5
    top: 4
    left: 10

  - name: next_day_deliv_late_reasons
    title: Next Day Delivery - Late Delivery Reasons
    type: looker_pie
    model: finery_data
    explore: spree_orders
    dimensions: [spree_orders.late_delivery_reason]
    measures: [spree_orders.count_hermes_late_orders]
    listen:
     date2: spree_orders.completed_date
    filters:
      spree_orders.delivery_type: '"Next Day Delivery"'
      spree_orders.count_hermes_late_orders: '>0'
    sorts: [spree_orders.count_hermes_late_orders desc]
    limit: 500
    total: false
    height: 4
    width: 5
    top: 8
    left: 0

  - name: 48h_deliv_late_reasons
    title: Standard Delivery - Late Delivery Reasons
    type: looker_pie
    model: finery_data
    explore: spree_orders
    dimensions: [spree_orders.late_delivery_reason]
    measures: [spree_orders.count_hermes_late_orders]
    listen:
     date2: spree_orders.completed_date
    filters:
      spree_orders.delivery_type: '"Standard Delivery"'
      spree_orders.count_hermes_late_orders: '>0'
    sorts: [spree_orders.count_hermes_late_orders desc]
    limit: 500
    total: false
    show_view_names: false
    height: 4
    width: 5
    top: 8
    left: 5
    
  - name: sun_deliv_late_reasons
    title: Sunday Delivery - Late Delivery Reasons
    type: looker_pie
    model: finery_data
    explore: spree_orders
    dimensions: [spree_orders.late_delivery_reason]
    measures: [spree_orders.count_hermes_late_orders]
    listen:
     date2: spree_orders.completed_date
    filters:
      spree_orders.delivery_type: '"Sunday Delivery"'
      spree_orders.count_hermes_late_orders: '>0'
    sorts: [spree_orders.count_hermes_late_orders desc]
    limit: 500
    total: false
    show_view_names: false
    height: 4
    width: 5
    top: 8
    left: 10

#  - name: add_a_unique_name_278
#    title: Untitled Table
#    type: table
#    model: finery_data
#    explore: spree_orders
#    dimensions: [spree_orders.late_delivery_reason]
#    measures: [spree_orders.count_hermes_late_orders]
#    filters:
#      spree_orders.completed_date: this month
#      spree_orders.delivery_type: '"Next Day Delivery"'
#      spree_orders.late_delivery_reason: '"Late to Hub", "Delay at Depot", "Misrouted to Incorrect Depot", "Carried Forward", "Late - Other Reason", "Late to Depot", "Delay in Courier Receiving Package", "Hermes Delay", "Missort to Incorrect Courier"'
#    sorts: [spree_orders.count_hermes_late_orders desc]
#    limit: 500
#    total: true
#    height: 4
#    width: 5
#    top: 12
#    left: 10
    
#  - name: add_a_unique_name_734
#    title: Next Day Delivery - Late Delivery Reasons Table
#    type: table
#    model: finery_data
#    explore: spree_orders
#    dimensions: [spree_orders.late_delivery_reason]
#    measures: [spree_orders.count_hermes_late_orders]
#    listen:
#      date2: spree_orders.completed_date
#    filters:
#      spree_orders.delivery_type: '"Next Day Delivery"'
#      spree_orders.late_delivery_reason: '"Late to Hub", "Delay at Depot", "Misrouted to Incorrect Depot", "Carried Forward", "Late - Other Reason", "Late to Depot", "Delay in Courier Receiving Package", "Hermes Delay", "Missort to Incorrect Courier"'
#    sorts: [spree_orders.count_hermes_late_orders desc]
#    limit: 500
#    total: true
#    height: 4
#    width: 5
#    top: 12
#    left: 0

#  - name: add_a_unique_name_734
#    title: Standard Delivery - Late Delivery Reasons Table
#    type: table
#    model: finery_data
#    explore: spree_orders
#    dimensions: [spree_orders.late_delivery_reason]
#    measures: [spree_orders.count_hermes_late_orders]
#    listen:
#      date2: spree_orders.completed_date
#    filters:
#      spree_orders.delivery_type: '"Standard Delivery"'
#      spree_orders.late_delivery_reason: '"Delay at Depot", "Late to Hub", "Carried Forward", "Late - Other Reason", "Late to Depot", "Delay in Courier Receeving Package"'
#    sorts: [spree_orders.count_hermes_late_orders desc]
#    limit: 500
#    total: true
#    height: 4
#    width: 5
#    top: 12
#    left: 5
    
#  - name: add_a_unique_name_734
#    title: Sunday Delivery - Late Delivery Reasons Table
#    type: table
#    model: finery_data
#    explore: spree_orders
#    dimensions: [spree_orders.late_delivery_reason]
#    measures: [spree_orders.count_hermes_late_orders]
#    listen:
#      date2: spree_orders.completed_date
#    filters:
#      spree_orders.delivery_type: '"Sunday Delivery"'
#      spree_orders.late_delivery_reason: '"Delay at Depot", "Late to Hub", "Carried Forward", "Late - Other Reason", "Late to Depot", "Delay in Courier Receeving Package"'
#    sorts: [spree_orders.count_hermes_late_orders desc]
#    limit: 500
#    total: true
#    height: 4
#    width: 5
#    top: 12
#    left: 10