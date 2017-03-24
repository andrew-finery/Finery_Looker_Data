- dashboard: sales_last_week
  title: Sales - Last Week
  layout: static
  tile_size: 50

  elements:

  - name: week_number
    title: Week Number
    type: single_value
    model: finery_data
    explore: spree_orders
    dimensions: [calendar_weeks.year_week_number]
    filters:
      calendar_weeks.calendar_date_date: last week
    sorts: [calendar_weeks.year_week_number]
    limit: 500
    column_limit: ''
    font_size: small
    top: 0
    left: 0
    height: 3
    width: 4

  - name: orders_last_week
    title: Orders
    type: single_value
    model: finery_data
    explore: spree_orders
    measures: [spree_orders.count_orders]
    filters:
      calendar_weeks.calendar_date_date: last week
    sorts: [spree_orders.count_orders desc]
    limit: 1
    column_limit: ''
    font_size: small
    top: 0
    left: 4
    height: 3
    width: 4

  - name: gross_rev_last_week
    title: Revenue
    type: single_value
    model: finery_data
    explore: spree_orders
    measures: [spree_orders.sum_gross_revenue_ex_discount_in_gbp_ex_vat_ex_shipping_in_k]
    filters:
      calendar_weeks.calendar_date_date: last week
    sorts: [spree_orders.sum_gross_revenue_ex_discount_in_gbp_ex_vat_ex_shipping_in_k desc]
    limit: 1
    column_limit: ''
    font_size: small
    top: 0
    left: 8
    height: 3
    width: 4

  - name: basket_size_last_week
    title: Basket Size
    type: single_value
    model: finery_data
    explore: spree_orders
    measures: [spree_orders.avg_gross_revenue_ex_discount_in_gbp_ex_vat_ex_shipping]
    filters:
      calendar_weeks.calendar_date_date: last week
    sorts: [spree_orders.avg_gross_revenue_ex_discount_in_gbp_ex_vat_ex_shipping desc]
    limit: 1
    column_limit: ''
    font_size: small
    top: 0
    left: 12
    height: 3
    width: 4

  - name: average_discount_last_week
    title: Average Total Discount
    type: single_value
    model: finery_data
    explore: spree_order_items
    measures: [spree_order_items.avg_total_discount]
    filters:
      calendar_weeks.calendar_date_date: last week
    sorts: [spree_order_items.avg_total_discount desc]
    limit: 1
    column_limit: ''
    font_size: small
    top: 0
    left: 16
    height: 3
    width: 4

  - name: orders_tw_v_lw
    title: Orders v Previous Week
    type: table
    model: finery_data
    explore: spree_orders
    dimensions: [calendar_weeks.year_week_number]
    measures: [spree_orders.count_orders]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Week on Week
      expression: |
        concat(round(100 * (${spree_orders.count_orders} - offset(${spree_orders.count_orders},1))/offset(${spree_orders.count_orders},1),2),"%")
    filters:
      calendar_weeks.calendar_date_date: 2 weeks ago for 2 weeks
    sorts: [calendar_weeks.year_week_number desc]
    limit: 2
    column_limit: ''
    show_view_names: false
    top: 3
    left: 0
    height: 4
    width: 5

  - name: revenue_tw_v_lw
    title: Revenue v Previous Week
    type: table
    model: finery_data
    explore: spree_orders
    dimensions: [calendar_weeks.year_week_number]
    measures: [spree_orders.sum_gross_revenue_ex_discount_in_gbp_ex_vat_ex_shipping_in_k]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Week on Week
      expression: |
        concat(round(100 * (${spree_orders.sum_gross_revenue_ex_discount_in_gbp_ex_vat_ex_shipping_in_k} - offset(${spree_orders.sum_gross_revenue_ex_discount_in_gbp_ex_vat_ex_shipping_in_k},1))/offset(${spree_orders.sum_gross_revenue_ex_discount_in_gbp_ex_vat_ex_shipping_in_k},1),2),"%")
    filters:
      calendar_weeks.calendar_date_date: 2 weeks ago for 2 weeks
    sorts: [calendar_weeks.year_week_number desc]
    limit: 2
    column_limit: ''
    show_view_names: false
    top: 3
    left: 5
    height: 4
    width: 5

  - name: basket_size_tw_v_lw
    title: Basket Size v Previous Week
    type: table
    model: finery_data
    explore: spree_orders
    dimensions: [calendar_weeks.year_week_number]
    measures: [spree_orders.avg_gross_revenue_ex_discount_in_gbp_ex_vat_ex_shipping]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Week on Week
      expression: |
        concat(round(100 * (${spree_orders.avg_gross_revenue_ex_discount_in_gbp_ex_vat_ex_shipping} - offset(${spree_orders.avg_gross_revenue_ex_discount_in_gbp_ex_vat_ex_shipping},1))/offset(${spree_orders.avg_gross_revenue_ex_discount_in_gbp_ex_vat_ex_shipping},1),2),"%")
    filters:
      calendar_weeks.calendar_date_date: 2 weeks ago for 2 weeks
    sorts: [calendar_weeks.year_week_number desc]
    limit: 2
    column_limit: ''
    show_view_names: false
    top: 3
    left: 10
    height: 4
    width: 5

  - name: avg_discount_tw_v_lw
    title: Total Discount v Previous Week
    type: table
    model: finery_data
    explore: spree_order_items
    dimensions: [calendar_weeks.year_week_number]
    measures: [spree_order_items.avg_total_discount]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Week on Week
      expression: |
        concat(round(100 * (${spree_order_items.avg_total_discount} - offset(${spree_order_items.avg_total_discount},1))/offset(${spree_order_items.avg_total_discount},1),2),"%")
    filters:
      calendar_weeks.calendar_date_date: 2 weeks ago for 2 weeks
    sorts: [calendar_weeks.year_week_number desc]
    limit: 2
    column_limit: ''
    show_view_names: false
    top: 3
    left: 15
    height: 4
    width: 5

  - name: orders_by_weekday
    title: Orders by Weekday
    type: looker_line
    model: finery_data
    explore: spree_orders
    dimensions: [calendar_weeks.year_week_number, spree_orders.completed_day_of_week]
    pivots: [calendar_weeks.year_week_number]
    measures: [spree_orders.count_orders]
    filters:
      calendar_weeks.calendar_date_date: 2 weeks ago for 2 weeks
    sorts: [calendar_weeks.year_week_number desc, spree_orders.completed_day_of_week]
    limit: 7
    column_limit: ''
    show_view_names: false
    show_null_points: true
    interpolation: monotone
    show_value_labels: false
    point_style: circle_outline
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

  - name: revenue_by_weekday
    title: Revenue by Weekday
    type: looker_line
    model: finery_data
    explore: spree_orders
    dimensions: [calendar_weeks.year_week_number, spree_orders.completed_day_of_week]
    pivots: [calendar_weeks.year_week_number]
    measures: [spree_orders.sum_gross_revenue_ex_discount_in_gbp_ex_vat_ex_shipping]
    filters:
      calendar_weeks.calendar_date_date: 2 weeks ago for 2 weeks
    sorts: [calendar_weeks.year_week_number desc, spree_orders.completed_day_of_week]
    limit: 7
    column_limit: ''
    show_view_names: false
    show_null_points: true
    interpolation: monotone
    show_value_labels: false
    point_style: circle_outline
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

  - name: basket_size_by_weekday
    title: Basket Size by Weekday
    type: looker_line
    model: finery_data
    explore: spree_orders
    dimensions: [calendar_weeks.year_week_number, spree_orders.completed_day_of_week]
    pivots: [calendar_weeks.year_week_number]
    measures: [spree_orders.avg_gross_revenue_ex_discount_in_gbp_ex_vat_ex_shipping]
    filters:
      calendar_weeks.calendar_date_date: 2 weeks ago for 2 weeks
    sorts: [calendar_weeks.year_week_number desc, spree_orders.completed_day_of_week]
    limit: 7
    column_limit: ''
    show_view_names: false
    show_null_points: true
    interpolation: monotone
    show_value_labels: false
    point_style: circle_outline
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

  - name: discount_by_weekday
    title: Total Discount by Weekday
    type: looker_line
    model: finery_data
    explore: spree_order_items
    dimensions: [calendar_weeks.year_week_number, spree_orders.completed_day_of_week]
    pivots: [calendar_weeks.year_week_number]
    measures: [spree_order_items.avg_total_discount]
    filters:
      calendar_weeks.calendar_date_date: 2 weeks ago for 2 weeks
    sorts: [calendar_weeks.year_week_number desc, spree_orders.completed_day_of_week]
    limit: 7
    column_limit: ''
    show_view_names: false
    show_null_points: true
    interpolation: monotone
    show_value_labels: false
    point_style: circle_outline
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
    title: Avg Orders by Hour v Previous Week
    type: looker_line
    model: finery_data
    explore: spree_orders
    dimensions: [calendar_weeks.year_week_number, spree_orders.completed_hour_of_day]
    pivots: [calendar_weeks.year_week_number]
    measures: [spree_orders.orders_per_day]
    filters:
      calendar_weeks.calendar_date_date: 2 weeks ago for 2 weeks
    sorts: [calendar_weeks.year_week_number desc, spree_orders.completed_hour_of_day]
    limit: 24
    column_limit: ''
    show_null_points: true
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
    title: Basket Size Distribution v Previous Week
    type: looker_line
    model: finery_data
    explore: spree_orders
    dimensions: [calendar_weeks.year_week_number, spree_orders.gross_reveune_ex_discount_ex_vat_ex_shipping_gbp_tier]
    pivots: [calendar_weeks.year_week_number]
    measures: [spree_orders.orders_perc_of_total]
    filters:
      calendar_weeks.calendar_date_date: 2 weeks ago for 2 weeks
    sorts: [calendar_weeks.year_week_number desc, spree_orders.gross_reveune_ex_discount_ex_vat_ex_shipping_gbp_tier]
    limit: 100
    column_limit: ''
    show_view_names: false
    show_null_points: true
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

  - name: avg_items_last_week
    title: Avg. Items in Basket
    type: single_value
    model: finery_data
    explore: spree_orders
    measures: [spree_orders.avg_items_in_basket]
    filters:
      calendar_weeks.calendar_date_date: last week
    sorts: [spree_orders.avg_items_in_basket desc]
    limit: 1
    column_limit: ''
    font_size: small
    top: 20
    left: 0
    height: 3
    width: 5

  - name: new_cust_last_week
    title: New Customers
    type: single_value
    model: finery_data
    explore: spree_orders
    measures: [spree_orders.new_customer_percentage]
    filters:
      calendar_weeks.calendar_date_date: last week
    sorts: [spree_orders.new_customer_percentage desc]
    limit: 1
    column_limit: ''
    font_size: small
    top: 20
    left: 5
    height: 3
    width: 5

  - name: asp_last_week
    title: Average Selling Price
    type: single_value
    model: finery_data
    explore: spree_orders
    measures: [spree_orders.asp]
    filters:
      calendar_weeks.calendar_date_date: last week
    sorts: [spree_orders.asp desc]
    limit: 1
    column_limit: ''
    font_size: small
    top: 20
    left: 10
    height: 3
    width: 5

  - name: new_customers_using_discount_last_week
    title: New Customers Using Voucher
    type: single_value
    model: finery_data
    explore: spree_orders
    measures: [spree_orders.new_customers_using_discount_percentage]
    filters:
      calendar_weeks.calendar_date_date: last week
    sorts: [spree_orders.new_customers_using_discount_percentage desc]
    limit: 1
    column_limit: ''
    font_size: small
    top: 20
    left: 15
    height: 3
    width: 5

  - name: avg_items_in_basket_tw_v_lw
    title: Avg Items in Basket v Previous Week
    type: table
    model: finery_data
    explore: spree_orders
    dimensions: [calendar_weeks.year_week_number]
    measures: [spree_orders.avg_items_in_basket]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Week on Week
      expression: |
        concat(round(100 * (${spree_orders.avg_items_in_basket} - offset(${spree_orders.avg_items_in_basket},1))/offset(${spree_orders.avg_items_in_basket},1),2),"%")
    filters:
      calendar_weeks.calendar_date_date: 2 weeks ago for 2 weeks
    sorts: [calendar_weeks.year_week_number desc]
    limit: 2
    column_limit: ''
    show_view_names: false
    top: 23
    left: 0
    height: 4
    width: 5

  - name: new_customer_percentage_tw_v_lw
    title: New Customers v Previous Week
    type: table
    model: finery_data
    explore: spree_orders
    dimensions: [calendar_weeks.year_week_number]
    measures: [spree_orders.new_customer_percentage]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Week on Week
      expression: |
        concat(round(100 * (${spree_orders.new_customer_percentage} - offset(${spree_orders.new_customer_percentage},1))/offset(${spree_orders.new_customer_percentage},1),2),"%")
    filters:
      calendar_weeks.calendar_date_date: 2 weeks ago for 2 weeks
    sorts: [calendar_weeks.year_week_number desc]
    limit: 2
    column_limit: ''
    show_view_names: false
    top: 23
    left: 5
    height: 4
    width: 5

  - name: asp_tw_v_lw
    title: Avg. Selling Price v Previous Week
    type: table
    model: finery_data
    explore: spree_orders
    dimensions: [calendar_weeks.year_week_number]
    measures: [spree_orders.asp]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Week on Week
      expression: |
        concat(round(100 * (${spree_orders.asp} - offset(${spree_orders.asp},1))/offset(${spree_orders.asp},1),2),"%")
    filters:
      calendar_weeks.calendar_date_date: 2 weeks ago for 2 weeks
    sorts: [calendar_weeks.year_week_number desc]
    limit: 2
    column_limit: ''
    show_view_names: false
    top: 23
    left: 10
    height: 4
    width: 5

  - name: new_customers_using_discount_percentage_tw_v_lw
    title: New Customers Using Voucher v Previous Week
    type: table
    model: finery_data
    explore: spree_orders
    dimensions: [calendar_weeks.year_week_number]
    measures: [spree_orders.new_customers_using_discount_percentage]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Week on Week
      expression: |
        concat(round(100 * (${spree_orders.new_customers_using_discount_percentage} - offset(${spree_orders.new_customers_using_discount_percentage},1))/offset(${spree_orders.new_customers_using_discount_percentage},1),2),"%")
    filters:
      calendar_weeks.calendar_date_date: 2 weeks ago for 2 weeks
    sorts: [calendar_weeks.year_week_number desc]
    limit: 2
    column_limit: ''
    show_view_names: false
    top: 23
    left: 15
    height: 4
    width: 5

  - name: avg_items_in_basket_by_weekday
    title: Avg. Items in Basket by Weekday
    type: looker_line
    model: finery_data
    explore: spree_orders
    dimensions: [calendar_weeks.year_week_number, spree_orders.completed_day_of_week]
    pivots: [calendar_weeks.year_week_number]
    measures: [spree_orders.avg_items_in_basket]
    filters:
      calendar_weeks.calendar_date_date: 2 weeks ago for 2 weeks
    sorts: [calendar_weeks.year_week_number desc, spree_orders.completed_day_of_week]
    limit: 7
    column_limit: ''
    show_view_names: false
    show_null_points: true
    interpolation: monotone
    show_value_labels: false
    point_style: circle_outline
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

  - name: new_customers_by_weekday
    title: New Customers by Weekday
    type: looker_line
    model: finery_data
    explore: spree_orders
    dimensions: [calendar_weeks.year_week_number, spree_orders.completed_day_of_week]
    pivots: [calendar_weeks.year_week_number]
    measures: [spree_orders.new_customer_percentage]
    filters:
      calendar_weeks.calendar_date_date: 2 weeks ago for 2 weeks
    sorts: [calendar_weeks.year_week_number desc, spree_orders.completed_day_of_week]
    limit: 7
    column_limit: ''
    show_view_names: false
    show_null_points: true
    interpolation: monotone
    show_value_labels: false
    point_style: circle_outline
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

  - name: asp_by_weekday
    title: Avg. Selling Price by Weekday
    type: looker_line
    model: finery_data
    explore: spree_orders
    dimensions: [calendar_weeks.year_week_number, spree_orders.completed_day_of_week]
    pivots: [calendar_weeks.year_week_number]
    measures: [spree_orders.asp]
    filters:
      calendar_weeks.calendar_date_date: 2 weeks ago for 2 weeks
    sorts: [calendar_weeks.year_week_number desc, spree_orders.completed_day_of_week]
    limit: 7
    column_limit: ''
    show_view_names: false
    show_null_points: true
    interpolation: monotone
    show_value_labels: false
    point_style: circle_outline
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

  - name: new_customers_using_discount_percentage_by_weekday
    title: New Customers Using Voucher by Weekday
    type: looker_line
    model: finery_data
    explore: spree_orders
    dimensions: [calendar_weeks.year_week_number, spree_orders.completed_day_of_week]
    pivots: [calendar_weeks.year_week_number]
    measures: [spree_orders.new_customers_using_discount_percentage]
    filters:
      calendar_weeks.calendar_date_date: 2 weeks ago for 2 weeks
    sorts: [calendar_weeks.year_week_number desc, spree_orders.completed_day_of_week]
    limit: 7
    column_limit: ''
    show_view_names: false
    show_null_points: true
    interpolation: monotone
    show_value_labels: false
    point_style: circle_outline
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
    title: Orders by Country v Previous Week
    type: table
    model: finery_data
    explore: spree_orders
    dimensions: [spree_addresses.country, calendar_weeks.year_week_number]
    pivots: [calendar_weeks.year_week_number]
    measures: [spree_orders.count_orders]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Week on Week
      expression: concat(round(100 * (${spree_orders.count_orders} - pivot_offset(${spree_orders.count_orders},1))/pivot_offset(${spree_orders.count_orders},1),2),"%")
    filters:
      spree_orders.completed_date: 2 weeks ago for 2 weeks
    sorts: [spree_orders.count_orders desc 0, calendar_weeks.year_week_number desc]
    limit: 7
    column_limit: ''
    show_view_names: false
    top: 33
    left: 0
    height: 7
    width: 10

  - name: top_discount_codes
    title: Top Voucher Codes
    type: table
    model: finery_data
    explore: spree_orders
    dimensions: [spree_orders.primary_promotion, calendar_weeks.year_week_number]
    pivots: [calendar_weeks.year_week_number]
    measures: [spree_orders.count_orders]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Week on Week
      expression: concat(round(100 * (${spree_orders.count_orders} - pivot_offset(${spree_orders.count_orders},1))/pivot_offset(${spree_orders.count_orders},1),2),"%")
    filters:
      spree_orders.completed_date: 2 weeks ago for 2 weeks
      spree_orders.primary_promotion: -NULL
    sorts: [spree_orders.count_orders desc 0, calendar_weeks.year_week_number desc]
    limit: 7
    column_limit: ''
    show_view_names: false
    top: 33
    left: 10
    height: 7
    width: 10

##### 3rd Section

  - name: sales_by_dept
    title: Sales by Dept v Previous Week
    type: table
    model: finery_data
    explore: spree_order_items
    dimensions: [calendar_weeks.year_week_number, option_info.category]
    pivots: [calendar_weeks.year_week_number]
    measures: [spree_order_items.sum_gross_item_revenue_ex_discount_ex_vat_gbp]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Week on Week
      expression: concat(round(100 * (${spree_order_items.sum_gross_item_revenue_ex_discount_ex_vat_gbp} - pivot_offset(${spree_order_items.sum_gross_item_revenue_ex_discount_ex_vat_gbp},1))/pivot_offset(${spree_order_items.sum_gross_item_revenue_ex_discount_ex_vat_gbp},1),2),"%")
    filters:
      spree_orders.completed_date: 2 weeks ago for 2 weeks
    sorts: [spree_order_items.sum_gross_item_revenue_ex_discount_ex_vat_gbp desc 0,
      calendar_weeks.year_week_number desc]
    limit: 500
    column_limit: ''
    show_view_names: false
    top: 41
    left: 0
    height: 9
    width: 10

  - name: sales_by_size
    title: Sales by Size v Previous Week (Apparel)
    type: table
    model: finery_data
    explore: spree_order_items
    dimensions: [calendar_weeks.year_week_number, variant_info.size]
    pivots: [calendar_weeks.year_week_number]
    measures: [spree_order_items.sum_gross_item_revenue_ex_discount_ex_vat_gbp]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Week on Week
      expression: concat(round(100 * (${spree_order_items.sum_gross_item_revenue_ex_discount_ex_vat_gbp} - pivot_offset(${spree_order_items.sum_gross_item_revenue_ex_discount_ex_vat_gbp},1))/pivot_offset(${spree_order_items.sum_gross_item_revenue_ex_discount_ex_vat_gbp},1),2),"%")
    filters:
      variant_info.size: '"6","8","10","14","16","18","12"'
      spree_orders.completed_date: 2 weeks ago for 2 weeks
    sorts: [calendar_weeks.year_week_number desc, spree_order_items.sum_gross_item_revenue_ex_discount_ex_vat_gbp desc 0]
    limit: 500
    column_limit: ''
    top: 41
    left: 10
    height: 9
    width: 10

  - name: basket_size_distrn_items
    title: Basket Size Distribution (Items) v Previous Week
    type: looker_line
    model: finery_data
    explore: spree_orders
    dimensions: [calendar_weeks.year_week_number, spree_orders.item_count_tier]
    pivots: [calendar_weeks.year_week_number]
    measures: [spree_orders.orders_perc_of_total]
    filters:
      calendar_weeks.calendar_date_date: 2 weeks ago for 2 weeks
    sorts: [calendar_weeks.year_week_number desc, spree_orders.item_count_tier]
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
    top: 50
    left: 0
    height: 10
    width: 20

  - name: country_performance_last_week
    title: Performance by Country - Last Week
    type: table
    model: finery_data
    explore: spree_orders
    dimensions: [spree_addresses.country]
    measures: [spree_orders.count_orders, spree_orders.sum_gross_revenue_ex_discount_in_gbp,
      spree_orders.avg_gross_revenue_ex_discount_in_gbp, spree_orders.avg_items_in_basket,
      spree_orders.asp]
    filters:
      spree_orders.completed_date: last week
      spree_orders.completed_time: before today
    sorts: [spree_orders.order_per_day desc 0, spree_orders.count_orders desc]
    limit: '10'
    column_limit: '50'
    total: true
    query_timezone: Europe/London
    show_view_names: false
    top: 60
    left: 0
    height: 8
    width: 20
