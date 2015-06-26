- dashboard: sales_month_so_far
  title: Sales - Month so Far
  layout: static
  tile_size: 50


  elements:

  - name: month_number
    title: Month
    type: single_value
    model: finery_data
    explore: spree_orders
    dimensions: [calendar_weeks.calendar_date_month]
    filters:
      calendar_weeks.calendar_date_date: this month
      spree_orders.completed_date: before 0 days ago
    sorts: [calendar_weeks.calendar_date_month]
    limit: 500
    column_limit: ''
    font_size: small
    top: 0
    left: 0
    height: 3
    width: 4

  - name: orders_last_month
    title: Orders
    type: single_value
    model: finery_data
    explore: spree_orders
    measures: [spree_orders.count_orders]
    filters:
      calendar_weeks.calendar_date_date: this month
      spree_orders.completed_date: before 0 days ago
    sorts: [spree_orders.count_orders desc]
    limit: 1
    column_limit: ''
    font_size: small
    top: 0
    left: 4
    height: 3
    width: 4
    
  - name: gross_rev_last_month
    title: Revenue
    type: single_value
    model: finery_data
    explore: spree_orders
    measures: [spree_orders.sum_gross_revenue_ex_discount_in_gbp_ex_vat_ex_shipping_in_k]
    filters:
      calendar_weeks.calendar_date_date: this month
      spree_orders.completed_date: before 0 days ago
    sorts: [spree_orders.sum_gross_revenue_ex_discount_in_gbp_ex_vat_ex_shipping_in_k desc]
    limit: 1
    column_limit: ''
    font_size: small
    top: 0
    left: 8
    height: 3
    width: 4
    
  - name: basket_size_last_month
    title: Basket Size
    type: single_value
    model: finery_data
    explore: spree_orders
    measures: [spree_orders.avg_gross_revenue_ex_discount_in_gbp_ex_vat_ex_shipping]
    filters:
      calendar_weeks.calendar_date_date: this month
      spree_orders.completed_date: before 0 days ago
    sorts: [spree_orders.avg_gross_revenue_ex_discount_in_gbp_ex_vat_ex_shipping desc]
    limit: 1
    column_limit: ''
    font_size: small
    top: 0
    left: 12
    height: 3
    width: 4
    
  - name: average_discount_last_month
    title: Average Total Discount
    type: single_value
    model: finery_data
    explore: spree_order_items
    measures: [spree_order_items.avg_total_discount]
    filters:
      calendar_weeks.calendar_date_date: this month
      spree_orders.completed_date: before 0 days ago
    sorts: [spree_order_items.avg_total_discount desc]
    limit: 1
    column_limit: ''
    font_size: small
    top: 0
    left: 16
    height: 3
    width: 4

  - name: orders_tm_v_lm
    title: Orders per Day v Previous Month
    type: table
    model: finery_data
    explore: spree_orders
    dimensions: [calendar_weeks.calendar_date_month]
    measures: [spree_orders.orders_per_day]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Month on Month
      expression: |
        concat(round(100 * (${spree_orders.orders_per_day} - offset(${spree_orders.orders_per_day},1))/offset(${spree_orders.orders_per_day},1),2),"%")
    filters:
      calendar_weeks.calendar_date_date: 1 month ago for 2 months
      spree_orders.completed_date: before 0 days ago
    sorts: [calendar_weeks.calendar_date_month desc]
    limit: 2
    column_limit: ''
    show_view_names: false
    top: 3
    left: 0
    height: 4
    width: 5

  - name: revenue_tm_v_lm
    title: Revenue per Day v Previous Month
    type: table
    model: finery_data
    explore: spree_orders
    dimensions: [calendar_weeks.calendar_date_month]
    measures: [spree_orders.revenue_per_day]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Month on Month
      expression: |
        concat(round(100 * (${spree_orders.revenue_per_day} - offset(${spree_orders.revenue_per_day},1))/offset(${spree_orders.revenue_per_day},1),2),"%")
    filters:
      calendar_weeks.calendar_date_date: 1 month ago for 2 months
      spree_orders.completed_date: before 0 days ago
    sorts: [calendar_weeks.calendar_date_month desc]
    limit: 2
    column_limit: ''
    show_view_names: false
    top: 3
    left: 5
    height: 4
    width: 5

  - name: basket_size_tm_v_lm
    title: Basket Size v Previous Month
    type: table
    model: finery_data
    explore: spree_orders
    dimensions: [calendar_weeks.calendar_date_month]
    measures: [spree_orders.avg_gross_revenue_ex_discount_in_gbp_ex_vat_ex_shipping]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Month on Month
      expression: |
        concat(round(100 * (${spree_orders.avg_gross_revenue_ex_discount_in_gbp_ex_vat_ex_shipping} - offset(${spree_orders.avg_gross_revenue_ex_discount_in_gbp_ex_vat_ex_shipping},1))/offset(${spree_orders.avg_gross_revenue_ex_discount_in_gbp_ex_vat_ex_shipping},1),2),"%")
    filters:
      calendar_weeks.calendar_date_date: 1 month ago for 2 months
      spree_orders.completed_date: before 0 days ago
    sorts: [calendar_weeks.calendar_date_month desc]
    limit: 2
    column_limit: ''
    show_view_names: false
    top: 3
    left: 10
    height: 4
    width: 5

  - name: avg_discount_tm_v_lm
    title: Total Discount v Previous Month
    type: table
    model: finery_data
    explore: spree_order_items
    dimensions: [calendar_weeks.calendar_date_month]
    measures: [spree_order_items.avg_total_discount]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Month on Month
      expression: |
        concat(round(100 * (${spree_order_items.avg_total_discount} - offset(${spree_order_items.avg_total_discount},1))/offset(${spree_order_items.avg_total_discount},1),2),"%")
    filters:
      calendar_weeks.calendar_date_date: 1 month ago for 2 months
      spree_orders.completed_date: before 0 days ago
    sorts: [calendar_weeks.calendar_date_month desc]
    limit: 2
    column_limit: ''
    show_view_names: false
    top: 3
    left: 15
    height: 4
    width: 5

  - name: orders_by_dom
    title: Running Total Orders by Day of Month
    type: looker_line
    model: finery_data
    explore: spree_orders
    dimensions: [calendar_weeks.calendar_date_month, spree_orders.completed_day_of_month]
    pivots: [calendar_weeks.calendar_date_month]
    measures: [spree_orders.orders_running_total]
    filters:
      calendar_weeks.calendar_date_date: 1 month ago for 2 months
      spree_orders.completed_date: before 0 days ago
    sorts: [calendar_weeks.calendar_date_month desc, spree_orders.completed_day_of_month]
    limit: 31
    column_limit: ''
    show_view_names: false
    show_null_points: false
    interpolation: monotone
    show_value_labels: false
    point_style: none
    colors: [purple, skyblue]
    x_axis_gridlines: true
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_gridlines: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    stacking: ''
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    x_axis_scale: auto
    top: 7
    left: 0
    height: 6
    width: 5

  - name: revenue_by_dom
    title: Running Total Revenue by Day of Month
    type: looker_line
    model: finery_data
    explore: spree_orders
    dimensions: [calendar_weeks.calendar_date_month, spree_orders.completed_day_of_month]
    pivots: [calendar_weeks.calendar_date_month]
    measures: [spree_orders.revenue_running_total]
    filters:
      calendar_weeks.calendar_date_date: 1 month ago for 2 months
      spree_orders.completed_date: before 0 days ago
    sorts: [calendar_weeks.calendar_date_month desc, spree_orders.completed_day_of_month]
    limit: 31
    column_limit: ''
    show_view_names: false
    show_null_points: false
    interpolation: monotone
    show_value_labels: false
    point_style: none
    colors: [purple, skyblue]
    x_axis_gridlines: true
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_gridlines: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    stacking: ''
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    x_axis_scale: auto
    top: 7
    left: 5
    height: 6
    width: 5

  - name: basket_size_by_dom
    title: Basket Size by Day of Month
    type: looker_line
    model: finery_data
    explore: spree_orders
    dimensions: [calendar_weeks.calendar_date_month, spree_orders.completed_day_of_month]
    pivots: [calendar_weeks.calendar_date_month]
    measures: [spree_orders.avg_gross_revenue_ex_discount_in_gbp_ex_vat_ex_shipping]
    filters:
      calendar_weeks.calendar_date_date: 1 month ago for 2 months
      spree_orders.completed_date: before 0 days ago
    sorts: [calendar_weeks.calendar_date_month desc, spree_orders.completed_day_of_month]
    limit: 31
    column_limit: ''
    show_view_names: false
    show_null_points: false
    interpolation: monotone
    show_value_labels: false
    point_style: none
    colors: [purple, skyblue]
    x_axis_gridlines: true
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_gridlines: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    stacking: ''
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    x_axis_scale: auto
    top: 7
    left: 10
    height: 6
    width: 5

  - name: discount_by_dom
    title: Total Discount by Day of Month
    type: looker_line
    model: finery_data
    explore: spree_order_items
    dimensions: [calendar_weeks.calendar_date_month, spree_orders.completed_day_of_month]
    pivots: [calendar_weeks.calendar_date_month]
    measures: [spree_order_items.avg_total_discount]
    filters:
      calendar_weeks.calendar_date_date: 1 month ago for 2 months
      spree_orders.completed_date: before 0 days ago
    sorts: [calendar_weeks.calendar_date_month desc, spree_orders.completed_day_of_month]
    limit: 31
    column_limit: ''
    show_view_names: false
    show_null_points: false
    interpolation: monotone
    show_value_labels: false
    point_style: none
    colors: [purple, skyblue]
    x_axis_gridlines: true
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_gridlines: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    stacking: ''
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    x_axis_scale: auto
    top: 7
    left: 15
    height: 6
    width: 5
    
  - name: orders_by_hour
    title: Avg Orders by Hour v Previous Month
    type: looker_line
    model: finery_data
    explore: spree_orders
    dimensions: [calendar_weeks.calendar_date_month, spree_orders.completed_hour_of_day]
    pivots: [calendar_weeks.calendar_date_month]
    measures: [spree_orders.orders_per_day]
    filters:
      calendar_weeks.calendar_date_date: 1 month ago for 2 months
      spree_orders.completed_date: before 0 days ago
    sorts: [calendar_weeks.calendar_date_month desc, spree_orders.completed_hour_of_day]
    limit: 24
    column_limit: ''
    show_null_points: false
    interpolation: monotone
    show_value_labels: false
    point_style: none
    colors: [purple, skyblue]
    x_axis_gridlines: true
    show_x_axis_label: true
    y_axis_labels: [Hour]
    show_x_axis_ticks: true
    y_axis_gridlines: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    show_view_names: false
    stacking: ''
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    x_axis_scale: auto
    top: 13
    left: 0
    height: 6
    width: 10

  - name: basket_size_distrn
    title: Basket Size Distribution v Previous Month
    type: looker_line
    model: finery_data
    explore: spree_orders
    dimensions: [calendar_weeks.calendar_date_month, spree_orders.gross_reveune_ex_discount_ex_vat_ex_shipping_gbp_tier]
    pivots: [calendar_weeks.calendar_date_month]
    measures: [spree_orders.orders_perc_of_total]
    filters:
      calendar_weeks.calendar_date_date: 1 month ago for 2 months
      spree_orders.completed_date: before 0 days ago
    sorts: [calendar_weeks.calendar_date_month desc, spree_orders.gross_reveune_ex_discount_ex_vat_ex_shipping_gbp_tier]
    limit: 100
    column_limit: ''
    show_view_names: false
    show_null_points: false
    interpolation: monotone
    show_value_labels: false
    point_style: none
    colors: [purple, skyblue]
    x_axis_gridlines: true
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_labels: ["% of Orders"]
    x_axis_datetime_label: '%a'
    stacking: ''
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    x_axis_scale: auto
    top: 13
    left: 10
    height: 6
    width: 10


########### SECOND SECTION

  - name: avg_items_last_month
    title: Avg. Items in Basket
    type: single_value
    model: finery_data
    explore: spree_orders
    measures: [spree_orders.avg_items_in_basket]
    filters:
      calendar_weeks.calendar_date_date: this month
      spree_orders.completed_date: before 0 days ago
    sorts: [spree_orders.avg_items_in_basket desc]
    limit: 1
    column_limit: ''
    font_size: small
    top: 20
    left: 0
    height: 3
    width: 5

  - name: new_cust_last_month
    title: New Customers
    type: single_value
    model: finery_data
    explore: spree_orders
    measures: [spree_orders.new_customer_percentage]
    filters:
      calendar_weeks.calendar_date_date: this month
      spree_orders.completed_date: before 0 days ago
    sorts: [spree_orders.new_customer_percentage desc]
    limit: 1
    column_limit: ''
    font_size: small
    top: 20
    left: 5
    height: 3
    width: 5

  - name: asp_last_month
    title: Average Selling Price
    type: single_value
    model: finery_data
    explore: spree_orders
    measures: [spree_orders.asp]
    filters:
      calendar_weeks.calendar_date_date: this month
      spree_orders.completed_date: before 0 days ago
    sorts: [spree_orders.asp desc]
    limit: 1
    column_limit: ''
    font_size: small
    top: 20
    left: 10
    height: 3
    width: 5

  - name: new_customers_using_discount_last_month
    title: New Customers Using Discount
    type: single_value
    model: finery_data
    explore: spree_orders
    measures: [spree_orders.new_customers_using_discount_percentage]
    filters:
      calendar_weeks.calendar_date_date: this month
      spree_orders.completed_date: before 0 days ago
    sorts: [spree_orders.new_customers_using_discount_percentage desc]
    limit: 1
    column_limit: ''
    font_size: small
    top: 20
    left: 15
    height: 3
    width: 5

  - name: avg_items_in_basket_tm_v_lm
    title: Avg Items in Basket v Previous Month
    type: table
    model: finery_data
    explore: spree_orders
    dimensions: [calendar_weeks.calendar_date_month]
    measures: [spree_orders.avg_items_in_basket]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Month on Month
      expression: |
        concat(round(100 * (${spree_orders.avg_items_in_basket} - offset(${spree_orders.avg_items_in_basket},1))/offset(${spree_orders.avg_items_in_basket},1),2),"%")
    filters:
      calendar_weeks.calendar_date_date: 1 month ago for 2 months
      spree_orders.completed_date: before 0 days ago
    sorts: [calendar_weeks.calendar_date_month desc]
    limit: 2
    column_limit: ''
    show_view_names: false
    top: 23
    left: 0
    height: 4
    width: 5

  - name: new_customer_percentage_tm_v_lm
    title: New Customers v Previous Month
    type: table
    model: finery_data
    explore: spree_orders
    dimensions: [calendar_weeks.calendar_date_month]
    measures: [spree_orders.new_customer_percentage]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Month on Month
      expression: |
        concat(round(100 * (${spree_orders.new_customer_percentage} - offset(${spree_orders.new_customer_percentage},1))/offset(${spree_orders.new_customer_percentage},1),2),"%")
    filters:
      calendar_weeks.calendar_date_date: 1 month ago for 2 months
      spree_orders.completed_date: before 0 days ago
    sorts: [calendar_weeks.calendar_date_month desc]
    limit: 2
    column_limit: ''
    show_view_names: false
    top: 23
    left: 5
    height: 4
    width: 5

  - name: asp_tm_v_lm
    title: Avg. Selling Price v Previous Month
    type: table
    model: finery_data
    explore: spree_orders
    dimensions: [calendar_weeks.calendar_date_month]
    measures: [spree_orders.asp]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Month on Month
      expression: |
        concat(round(100 * (${spree_orders.asp} - offset(${spree_orders.asp},1))/offset(${spree_orders.asp},1),2),"%")
    filters:
      calendar_weeks.calendar_date_date: 1 month ago for 2 months
      spree_orders.completed_date: before 0 days ago
    sorts: [calendar_weeks.calendar_date_month desc]
    limit: 2
    column_limit: ''
    show_view_names: false
    top: 23
    left: 10
    height: 4
    width: 5

  - name: new_customers_using_discount_percentage_tm_v_lm
    title: New Customers Using Discount v Previous Month
    type: table
    model: finery_data
    explore: spree_orders
    dimensions: [calendar_weeks.calendar_date_month]
    measures: [spree_orders.new_customers_using_discount_percentage]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Month on Month
      expression: |
        concat(round(100 * (${spree_orders.new_customers_using_discount_percentage} - offset(${spree_orders.new_customers_using_discount_percentage},1))/offset(${spree_orders.new_customers_using_discount_percentage},1),2),"%")
    filters:
      calendar_weeks.calendar_date_date: 1 month ago for 2 months
      spree_orders.completed_date: before 0 days ago
    sorts: [calendar_weeks.calendar_date_month desc]
    limit: 2
    column_limit: ''
    show_view_names: false
    top: 23
    left: 15
    height: 4
    width: 5

  - name: avg_items_in_basket_by_dom
    title: Avg. Items in Basket by Day of Month
    type: looker_line
    model: finery_data
    explore: spree_orders
    dimensions: [calendar_weeks.calendar_date_month, spree_orders.completed_day_of_month]
    pivots: [calendar_weeks.calendar_date_month]
    measures: [spree_orders.avg_items_in_basket]
    filters:
      calendar_weeks.calendar_date_date: 1 month ago for 2 months
      spree_orders.completed_date: before 0 days ago
    sorts: [calendar_weeks.calendar_date_month desc, spree_orders.completed_day_of_month]
    limit: 31
    column_limit: ''
    show_view_names: false
    show_null_points: false
    interpolation: monotone
    show_value_labels: false
    point_style: none
    colors: [purple, skyblue]
    x_axis_gridlines: true
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_gridlines: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    stacking: ''
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    x_axis_scale: auto
    top: 27
    left: 0
    height: 6
    width: 5
    
  - name: new_customers_by_dom
    title: New Customers by Day of Month
    type: looker_line
    model: finery_data
    explore: spree_orders
    dimensions: [calendar_weeks.calendar_date_month, spree_orders.completed_day_of_month]
    pivots: [calendar_weeks.calendar_date_month]
    measures: [spree_orders.new_customer_percentage]
    filters:
      calendar_weeks.calendar_date_date: 1 month ago for 2 months
      spree_orders.completed_date: before 0 days ago
    sorts: [calendar_weeks.calendar_date_month desc, spree_orders.completed_day_of_month]
    limit: 31
    column_limit: ''
    show_view_names: false
    show_null_points: false
    interpolation: monotone
    show_value_labels: false
    point_style: none
    colors: [purple, skyblue]
    x_axis_gridlines: true
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_gridlines: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    stacking: ''
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    x_axis_scale: auto
    top: 27
    left: 5
    height: 6
    width: 5
    
  - name: asp_by_dom
    title: Avg. Selling Price by Day of Month
    type: looker_line
    model: finery_data
    explore: spree_orders
    dimensions: [calendar_weeks.calendar_date_month, spree_orders.completed_day_of_month]
    pivots: [calendar_weeks.calendar_date_month]
    measures: [spree_orders.asp]
    filters:
      calendar_weeks.calendar_date_date: 1 month ago for 2 months
      spree_orders.completed_date: before 0 days ago
    sorts: [calendar_weeks.calendar_date_month desc, spree_orders.completed_day_of_month]
    limit: 31
    column_limit: ''
    show_view_names: false
    show_null_points: false
    interpolation: monotone
    show_value_labels: false
    point_style: none
    colors: [purple, skyblue]
    x_axis_gridlines: true
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_gridlines: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    stacking: ''
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    x_axis_scale: auto
    top: 27
    left: 10
    height: 6
    width: 5
    
  - name: new_customers_using_discount_percentage_by_dom
    title: New Customers Using Discount by Day of Month
    type: looker_line
    model: finery_data
    explore: spree_orders
    dimensions: [calendar_weeks.calendar_date_month, spree_orders.completed_day_of_month]
    pivots: [calendar_weeks.calendar_date_month]
    measures: [spree_orders.new_customers_using_discount_percentage]
    filters:
      calendar_weeks.calendar_date_date: 1 month ago for 2 months
      spree_orders.completed_date: before 0 days ago
    sorts: [calendar_weeks.calendar_date_month desc, spree_orders.completed_day_of_month]
    limit: 31
    column_limit: ''
    show_view_names: false
    show_null_points: false
    interpolation: monotone
    show_value_labels: false
    point_style: none
    colors: [purple, skyblue]
    x_axis_gridlines: true
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_gridlines: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    stacking: ''
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    x_axis_scale: auto
    top: 27
    left: 15
    height: 6
    width: 5

  - name: country_performance_v_previous_week
    title: Orders by Country v Previous Month
    type: table
    model: finery_data
    explore: spree_orders
    dimensions: [spree_addresses.country, calendar_weeks.calendar_date_month]
    pivots: [calendar_weeks.calendar_date_month]
    measures: [spree_orders.orders_per_day]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Month on Month
      expression: concat(round(100 * (${spree_orders.orders_per_day} - pivot_offset(${spree_orders.orders_per_day},1))/pivot_offset(${spree_orders.orders_per_day},1),2),"%")
    filters:
      calendar_weeks.calendar_date_date: 1 month ago for 2 months
      spree_orders.completed_date: before 0 days ago
    sorts: [spree_orders.orders_per_day desc 0, calendar_weeks.calendar_date_month desc]
    limit: 31
    column_limit: ''
    show_view_names: false
    top: 33
    left: 0
    height: 7
    width: 10
    
  - name: top_discount_codes
    title: Top Discount Codes
    type: table
    model: finery_data
    explore: spree_orders
    dimensions: [spree_orders.primary_promotion, calendar_weeks.calendar_date_month]
    pivots: [calendar_weeks.calendar_date_month]
    measures: [spree_orders.orders_per_day]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Month on Month
      expression: concat(round(100 * (${spree_orders.orders_per_day} - pivot_offset(${spree_orders.orders_per_day},1))/pivot_offset(${spree_orders.orders_per_day},1),2),"%")
    filters:
      calendar_weeks.calendar_date_date: 1 month ago for 2 months
      spree_orders.completed_date: before 0 days ago
      spree_orders.primary_promotion: -NULL
    sorts: [spree_orders.orders_per_day desc 0, calendar_weeks.calendar_date_month desc]
    limit: 7
    column_limit: ''
    show_view_names: false
    top: 33
    left: 10
    height: 7
    width: 10

##### 3rd Section

  - name: sales_by_dept
    title: Revenue per Day by Dept v Previous Month
    type: table
    model: finery_data
    explore: spree_order_items
    dimensions: [calendar_weeks.calendar_date_month, product_lookup.category]
    pivots: [calendar_weeks.calendar_date_month]
    measures: [spree_order_items.revenue_per_day]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Month on Month
      expression: concat(round(100 * (${spree_order_items.revenue_per_day} - pivot_offset(${spree_order_items.revenue_per_day},1))/pivot_offset(${spree_order_items.revenue_per_day},1),2),"%")
    filters:
      calendar_weeks.calendar_date_date: 1 month ago for 2 months
      spree_orders.completed_date: before 0 days ago
    sorts: [spree_order_items.revenue_per_day desc 0,
      calendar_weeks.calendar_date_month desc]
    limit: 500
    column_limit: ''
    show_view_names: false
    top: 41
    left: 0
    height: 9
    width: 10
    
  - name: sales_by_size
    title: Sales by Size v Previous Month (Apparel)
    type: table
    model: finery_data
    explore: spree_order_items
    dimensions: [calendar_weeks.calendar_date_month, online_products.size]
    pivots: [calendar_weeks.calendar_date_month]
    measures: [spree_order_items.revenue_per_day]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Month on Month
      expression: concat(round(100 * (${spree_order_items.revenue_per_day} - pivot_offset(${spree_order_items.revenue_per_day},1))/pivot_offset(${spree_order_items.revenue_per_day},1),2),"%")
    filters:
      online_products.size: '"6","8","10","14","16","18","12"'
      calendar_weeks.calendar_date_date: 1 month ago for 2 months
      spree_orders.completed_date: before 0 days ago
    sorts: [calendar_weeks.calendar_date_month desc, spree_order_items.revenue_per_day desc 0]
    limit: 500
    column_limit: ''
    show_view_names: false
    top: 41
    left: 10
    height: 9
    width: 10