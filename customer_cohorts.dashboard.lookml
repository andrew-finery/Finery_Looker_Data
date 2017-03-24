- dashboard: customer_cohorts
  title: Monthly Customer Cohort Dashboard
  layout: static
  tile_size: 100

#  filters:

  elements:

  - name: customer_cohort_size_by_month
    title: Customer Cohort Sizes (New Customers in each Month)
    type: looker_column
    model: finery_data
    explore: spree_customers
    dimensions: [spree_customers.first_order_month]
    measures: [spree_customers.count_customers]
    filters:
      spree_customers.first_order_date: before this month
      spree_customers.first_order_month: after 2015/02/01
    sorts: [spree_customers.first_order_month]
    limit: 500
    colors: ['#66CDAA']
    show_value_labels: true
    label_density: 25
    label_color: [red]
    font_size: 20px
    legend_position: center
    show_y_axis_labels: true
    y_axis_labels: [New Customers]
    y_axis_tick_density: default
    show_x_axis_ticks: true
    x_axis_datetime_label: '%b %y'
    x_axis_scale: ordinal
    show_view_names: false
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_x_axis_label: false
    label_value_format: 0.0, "k"
    top: 0
    left: 0
    height: 3
    width: 10

  - name: customer_cohorts_rpr2
    title: Customer Cohorts - Repurchase Rate 2 (Repeat Orders/Number of Customers)
    type: table
    model: finery_data
    explore: spree_orders
    dimensions: [calendar_weeks.calendar_date_month, spree_customers.first_order_month]
    pivots: [spree_customers.first_order_month]
    measures: [spree_customers.count_customers, spree_orders.count_orders]
    dynamic_fields:
    - table_calculation: repurchase_rate_2
      label: Repurchase Rate 2
      expression: offset(if(is_null(${spree_customers.count_customers}), null, running_total(${spree_orders.count_orders})/max(${spree_customers.count_customers}) - 1), max(diff_months(${calendar_weeks.calendar_date_month},${spree_customers.first_order_month})))

    - table_calculation: months_after_first_order
      label: Months After First Order
      expression: concat("Month + ", row()-1)
    filters:
      calendar_weeks.calendar_date_month: before this month
      spree_customers.first_order_month: after 2015/02/01
    sorts: [spree_customers.first_order_month, calendar_weeks.calendar_date_month]
    limit: 500
    column_limit: 50
    show_value_labels: false
    show_view_names: false
    x_axis_scale: auto
    ordering: none
    show_null_labels: false
    hidden_fields: [spree_customers.count_customers, spree_orders.count_orders, calendar_weeks.calendar_date_month]
    show_row_numbers: false
    show_null_points: false
    height: 4
    width: 10
    top: 3
    left: 0

  - name: orders_by_month_by_cohort
    title: Orders by Month by Monthly Cohort
    type: looker_area
    model: finery_data
    explore: spree_orders
    dimensions: [spree_customers.first_order_month, calendar_weeks.calendar_date_month]
    pivots: [spree_customers.first_order_month]
    measures: [spree_orders.count_orders]
    filters:
      calendar_weeks.calendar_date_date: before this month
      calendar_weeks.calendar_date_month: after 2015/02/01
    sorts: [calendar_weeks.calendar_date_month, spree_customers.first_order_month]
    limit: 500
    column_limit: 50
    stacking: normal
    colors: ['#294987', '#5a1038', '#ff947c', '#1f6b62', '#764173', '#910303', '#b2947c',
      '#192d54', '#a31e67', '#a16154', '#0f544b', '#ffd9ba']
    label_density: 25
    legend_position: center
    show_view_names: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    point_style: none
    interpolation: linear
    show_view_names: false
    x_axis_gridlines: false
    y_axis_gridlines: false
    height: 6
    width: 10
    top: 7
    left: 0
