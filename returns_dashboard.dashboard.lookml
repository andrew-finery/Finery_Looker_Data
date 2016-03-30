- dashboard: returns_dashboard
  title: Returns Dashboard
  layout: static
  show_applied_filters: true
  tile_size: 100

  filters:
  - name: select_department
    title: "Select Department"
    type: field_filter
    explore: spree_order_items
    field: option_info.category
    default_value: null

  elements:

  - name: return_rate
    title: Return Rate (orders over 3 days old)
    type: single_value
    model: finery_data
    explore: spree_order_items
    measures: [spree_order_items.return_rate]
    filters:
      spree_orders.completed_date: before 3 days ago
    sorts: [spree_order_items.return_rate desc]
    limit: 5
    height: 2
    width: 3
    top: 0
    left: 0

  - name: total_items_returned
    title: Total Items Returned
    type: single_value
    model: finery_data
    explore: spree_order_items
    measures: [spree_order_items.total_items_returned]
    sorts: [spree_order_items.total_items_returned desc]
    limit: 5
    height: 2
    width: 3
    top: 0
    left: 3

  - name: highest_return_rates
    title: 5 products with highest return rate
    type: table
    model: finery_data
    explore: spree_order_items
    dimensions: [option_info.style]
    measures: [option_info.image, spree_order_items.total_items_sold, spree_order_items.total_items_returned,
      spree_order_items.return_rate]
    filters:
      spree_order_items.return_rate: NOT NULL
    listen:
     select_department: option_info.category
    sorts: [spree_order_items.return_rate desc]
    limit: 5
    show_view_names: false
    height: 8
    width: 6
    top: 0
    left: 6

  - name: return_rate_by_department
    title: Return Rate by Department (orders over 3 days old)
    type: table
    model: finery_data
    explore: spree_order_items
    dimensions: [option_info.category]
    measures: [spree_order_items.total_items_sold, spree_order_items.total_items_returned,
      spree_order_items.return_rate]
    filters:
      spree_orders.completed_date: before 3 days ago
    sorts: [spree_order_items.return_rate desc]
    limit: 500
    show_view_names: false
    total: on
    height: 3
    width: 6
    top: 2
    left: 0
    
  - name: returns_by_reason
    title: Returns by Reason
    type: looker_pie
    model: finery_data
    explore: spree_order_items
    dimensions: [spree_order_items.return_reason]
    measures: [spree_order_items.total_items_returned]
    sorts: [spree_order_items.items_returned desc]
    limit: 500
    height: 4
    width: 6
    top: 5
    left: 0

  - name: returns_by_reason_and_department
    title: Returns by Reason for each Department
    type: looker_column
    model: finery_data
    explore: spree_order_items
    dimensions: [spree_order_items.return_reason, option_info.category]
    pivots: [spree_order_items.return_reason]
    measures: [spree_order_items.total_items_returned]
    limit: 500
    stacking: percent
    show_value_labels: false
    show_view_names: true
    x_axis_scale: auto
    show_null_points: true
    point_style: none
    interpolation: linear
    show_null_labels: false
    show_view_names: false
    height: 5
    width: 6
    top: 8
    left: 6

  - name: return_rate_by_week
    title: Return Rate by Week
    type: looker_line
    model: finery_data
    explore: spree_order_items
    dimensions: [spree_orders.completed_week]
    measures: [spree_order_items.return_rate]
    filters:
      spree_orders.completed_week: before 1 weeks ago
    sorts: [spree_orders.completed_date desc]
    limit: 500
    show_null_points: true
    stacking: ''
    show_value_labels: false
    show_view_names: true
    x_axis_scale: auto
    point_style: none
    interpolation: linear
    show_view_names: false
    height: 4
    width: 6
    top: 9
    left: 0
   