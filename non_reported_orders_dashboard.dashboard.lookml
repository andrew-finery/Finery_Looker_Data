- dashboard: non_reported_orders_dashboard
  title: Non Reported Orders Dashboard
  layout: static
  tile_size: 50

  elements:

  - name: press_orders_cost_last_12_month
    title: Press Orders - Cost of Goods - Last 12 Months
    type: looker_line
    model: finery_data
    explore: spree_stripped_out_order_items
    dimensions: [calendar_weeks.calendar_date_month]
    measures: [spree_stripped_out_order_items.sum_gross_landed_cost_gbp]
    filters:
      calendar_weeks.calendar_date_month: 12 months ago for 12 months
      spree_stripped_out_orders.reason_order_stripped_out: Press Order,Press Samples
    sorts: [calendar_weeks.calendar_date_month]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4']
    show_value_labels: true
    label_density: 25
    label_color: [red]
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_labels: [Cost of Goods]
    y_axis_tick_density: default
    y_axis_value_format: '"£"#0'
    show_x_axis_label: true
    x_axis_label: Month
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    label_value_format: '"£"#0'
    show_null_points: true
    point_style: none
    interpolation: linear
    height: 8
    width: 12
    top: 0
    left: 0

  - name: cc_orders_cost_last_12_months
    title: Customer Care Orders - Cost of Goods - Last 12 Months
    type: looker_line
    model: finery_data
    explore: spree_stripped_out_order_items
    dimensions: [calendar_weeks.calendar_date_month]
    measures: [spree_stripped_out_order_items.sum_gross_landed_cost_gbp]
    filters:
      calendar_weeks.calendar_date_month: 12 months ago for 12 months
      spree_stripped_out_orders.reason_order_stripped_out: Customer Care Order
    sorts: [calendar_weeks.calendar_date_month]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#000000']
    show_value_labels: true
    label_density: 25
    label_color: [red]
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_labels: [Cost of Goods]
    y_axis_tick_density: default
    y_axis_value_format: '"£"#0'
    show_x_axis_label: true
    x_axis_label: Month
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    label_value_format: '"£"#0'
    show_null_points: true
    point_style: none
    interpolation: linear
    height: 8
    width: 12
    top: 0
    left: 13

  - name: merch_orders_cost_last_12_month
    title: Merchandising Orders - Cost of Goods - Last 12 Months
    type: looker_line
    model: finery_data
    explore: spree_stripped_out_order_items
    dimensions: [calendar_weeks.calendar_date_month]
    measures: [spree_stripped_out_order_items.sum_gross_landed_cost_gbp]
    filters:
      calendar_weeks.calendar_date_month: 12 months ago for 12 months
      spree_stripped_out_orders.reason_order_stripped_out: Merchandising Order
    sorts: [calendar_weeks.calendar_date_month]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#000000']
    show_value_labels: true
    label_density: 25
    label_color: [red]
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_labels: [Cost of Goods]
    y_axis_tick_density: default
    y_axis_value_format: '"£"#0'
    show_x_axis_label: true
    x_axis_label: Month
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    label_value_format: '"£"#0'
    show_null_points: true
    point_style: none
    interpolation: linear
    height: 8
    width: 12
    top: 9
    left: 0
    
  - name: cancelled_revenue_last_12_months
    title: Cancelled Orders - Gross Revenue - Last 12 Months
    type: looker_line
    model: finery_data
    explore: spree_stripped_out_orders
    dimensions: [calendar_weeks.calendar_date_month]
    measures: [spree_stripped_out_orders.sum_gross_revenue_ex_discount_in_gbp]
    filters:
      calendar_weeks.calendar_date_month: 12 months ago for 12 months
      spree_stripped_out_orders.reason_order_stripped_out: Cancelled Order
    sorts: [calendar_weeks.calendar_date_month]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#8B008B']
    show_value_labels: true
    label_density: 25
    label_color: [red]
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_labels: [Cost of Goods]
    y_axis_tick_density: default
    y_axis_value_format: '"£"#0'
    show_x_axis_label: true
    x_axis_label: Month
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    label_value_format: '"£"#0'
    show_null_points: true
    point_style: none
    interpolation: linear
    height: 8
    width: 12
    top: 9
    left: 13