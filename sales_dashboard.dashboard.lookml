- dashboard: sales_dashboard
  title: Sales Dashboard
  layout: static
  show_applied_filters: true
  tile_size: 100

  filters:
  - name: date
    title: "Date Filter"
    type: date_filter
    default_value: 7 days ago for 7 days

  elements:

################################ Line 1: Yesterday Tiles #########################################################

  - name: total_orders_yesterday
    title: Total Orders Yesterday
    type: single_value
    model: finery_data
    explore: spree_orders
    measures: [spree_orders.count_orders]
    filters:
      spree_orders.completed_date: yesterday
    sorts: [spree_orders.count_orders desc]
    font_size: medium
    width: 3
    height: 2
    top: 0
    left: 0
    
  - name: basket_size_yesterday
    title: Basket Size Yesterday (excluding Coupons,VAT,Shipping)
    type: single_value
    model: finery_data
    explore: spree_orders
    measures: [spree_orders.avg_gross_revenue_ex_discount_in_gbp_ex_vat_ex_shipping]
    filters:
      spree_orders.completed_date: yesterday
    font_size: medium
    width: 3
    height: 2
    top: 0
    left: 3
  
  - name: gross_revenue_yesterday
    title: Gross Revenue Yesterday (excluding Coupons,VAT,Shipping)
    type: single_value
    model: finery_data
    explore: spree_orders
    measures: [spree_orders.sum_gross_revenue_ex_discount_in_gbp_ex_vat_ex_shipping_in_k]
    filters:
      spree_orders.completed_date: yesterday
    font_size: medium
    width: 3
    height: 2
    top: 0
    left: 6

  - name: average_discount_yesterday
    title: Average Discount Yesterday
    type: single_value
    model: finery_data
    explore: spree_orders
    measures: [spree_orders.average_discount]
    filters:
      spree_orders.completed_date: yesterday
    font_size: medium
    width: 3
    height: 2
    top: 0
    left: 9
    
############################ Line 2: Tiles Listening to Filer ####################################################### 

  - name: total_orders
    title: Total Orders
    type: single_value
    model: finery_data
    explore: spree_orders
    measures: [spree_orders.count_orders]
    listen:
     date: spree_orders.completed_date
    font_size: medium
    width: 3
    height: 2
    top: 2
    left: 0
    
  - name: basket_size
    title: Basket Size (excluding Coupons,VAT,Shipping)
    type: single_value
    model: finery_data
    explore: spree_orders
    measures: [spree_orders.avg_gross_revenue_ex_discount_in_gbp_ex_vat_ex_shipping]
    listen:
     date: spree_orders.completed_date
    font_size: medium
    width: 3
    height: 2
    top: 2
    left: 3
  
  - name: gross_revenue
    title: Gross Revenue (excluding Coupons,VAT,Shipping)
    type: single_value
    model: finery_data
    explore: spree_orders
    measures: [spree_orders.sum_gross_revenue_ex_discount_in_gbp_ex_vat_ex_shipping_in_k]
    listen:
     date: spree_orders.completed_date
    font_size: medium
    width: 3
    height: 2
    top: 2
    left: 6

  - name: average_discount
    title: Average Discount
    type: single_value
    model: finery_data
    explore: spree_orders
    measures: [spree_orders.average_discount]
    listen:
     date: spree_orders.completed_date
    font_size: medium
    width: 3
    height: 2
    top: 2
    left: 9

################################ Line 3: MTD ##################################################################

  - name: add_a_unique_name_402
    title: Revenue - Last Month
    type: single_value
    model: finery_data
    explore: spree_orders
    measures: [spree_orders.sum_gross_revenue_ex_discount_in_gbp_ex_vat_ex_shipping_in_k]
    filters:
      spree_orders.completed_date: last month
    sorts: [spree_orders.sum_gross_revenue_ex_discount_in_gbp_ex_vat_ex_shipping_in_k desc]
    limit: 500
    total: false
    font_size: medium
    width: 3
    height: 3
    top: 4
    left: 0
    
  - name: add_a_unique_name_878
    title: Revenue - Month-to-Date
    type: single_value
    model: finery_data
    explore: spree_orders
    measures: [spree_orders.sum_gross_revenue_ex_discount_in_gbp_ex_vat_ex_shipping_in_k]
    filters:
      spree_orders.completed_date: this month
      spree_orders.completed_time: before 0 days ago
    sorts: [spree_orders.sum_gross_revenue_ex_discount_in_gbp_ex_vat_ex_shipping_in_k desc]
    limit: 500
    total: false
    font_size: medium
    width: 3
    height: 3
    top: 4
    left: 3
    
  - name: add_a_unique_name_202
    title: Revenue by Day This Month vs Last Month
    type: looker_line
    model: finery_data
    explore: spree_orders
    dimensions: [spree_orders.completed_day_of_month, spree_orders.completed_month]
    pivots: [spree_orders.completed_month]
    measures: [spree_orders.sum_gross_revenue_ex_discount_in_gbp_ex_vat_ex_shipping_in_k]
    filters:
      spree_orders.completed_date: 1 months ago for 2 months
      spree_orders.completed_time: before 0 days ago
    sorts: [spree_orders.completed_day_of_month]
    limit: 500
    total: false
    font_size: medium
    show_null_points: false
    stacking: ''
    show_value_labels: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    point_style: none
    interpolation: linear
    width: 6
    height: 3
    top: 4
    left: 6

    
################################ Line 4 ##################################################################

  - name: add_a_unique_name_971
    title: Orders by Day of Week - This Week vs Last Week
    type: looker_line
    model: finery_data
    explore: spree_orders
    dimensions: [calendar_weeks.year_week_number, spree_orders.completed_day_of_week]
    pivots: [calendar_weeks.year_week_number]
    measures: [spree_orders.count_orders]
    filters:
      spree_orders.completed_date: 1 weeks ago for 2 weeks
      spree_orders.completed_time: before 0 days ago
    sorts: [spree_orders.completed_day_of_week]
    limit: 500
    total: false
    show_null_points: false
    stacking: ''
    show_value_labels: false
    show_view_names: false
    swap_axes: false
    point_style: circle
    hide_legend: false
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_gridlines: true
    x_axis_scale: auto
    x_axis_label: Date
    x_axis_datetime_label: '%a %d %b'
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_gridlines: true
    y_axis_labels: [Number of Orders]
    y_axis_combined: false
    interpolation: linear
    x_axis_datetime_tick_count: 7
    width: 6
    height: 3
    top: 7
    left: 0

  - name: add_a_unique_name_674
    title: Orders by Day
    type: looker_line
    model: finery_data
    explore: spree_orders
    dimensions: [spree_orders.completed_date]
    measures: [spree_orders.count_orders]
    listen:
     date: spree_orders.completed_date
    sorts: [spree_orders.completed_date desc]
    limit: 500
    total: false
    show_null_points: true
    stacking: normal
    show_value_labels: false
    show_view_names: false
    swap_axes: false
    point_style: circle
    hide_legend: false
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_gridlines: true
    x_axis_scale: auto
    x_axis_label: Date
    x_axis_datetime_label: '%a %d %b'
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_gridlines: true
    y_axis_labels: [Number of Orders]
    y_axis_combined: false
    interpolation: linear
    x_axis_datetime_tick_count: 7
    width: 6
    height: 3
    top: 7
    left: 6

##################################################### Line 5 ####################################################################

  - name: add_a_unique_name_815
    title: Revenue by Day of Week - This Week vs Last Week
    type: looker_line
    model: finery_data
    explore: spree_orders
    dimensions: [calendar_weeks.year_week_number, spree_orders.completed_day_of_week]
    pivots: [calendar_weeks.year_week_number]
    measures: [spree_orders.sum_gross_revenue_ex_discount_in_gbp_ex_vat_ex_shipping_in_k]
    filters:
      spree_orders.completed_date: 1 weeks ago for 2 weeks
      spree_orders.completed_time: before 0 days ago
    sorts: [spree_orders.completed_day_of_week]
    limit: 500
    total: false
    show_null_points: false
    stacking: ''
    show_value_labels: false
    show_view_names: false
    swap_axes: false
    point_style: circle
    hide_legend: false
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_gridlines: true
    x_axis_scale: auto
    x_axis_label: Date
    x_axis_datetime_label: '%a %d %b'
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_gridlines: true
    y_axis_labels: [Number of Orders]
    y_axis_combined: false
    interpolation: linear
    x_axis_datetime_tick_count: 7
    width: 6
    height: 3
    top: 10
    left: 0

  - name: add_a_unique_name_71
    title: Gross Revenue by Day
    type: looker_line
    model: finery_data
    explore: spree_orders
    dimensions: [spree_orders.completed_date]
    measures: [spree_orders.sum_gross_revenue_ex_discount_in_gbp_ex_vat_ex_shipping_in_k]
    listen:
      date: spree_orders.completed_date
    sorts: [spree_orders.completed_date desc, spree_orders.in_store_flag desc]
    limit: 500
    total: false
    show_null_points: true
    stacking: normal
    show_value_labels: false
    show_view_names: false
    swap_axes: false
    point_style: circle
    hide_legend: false
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_gridlines: true
    x_axis_scale: auto
    x_axis_label: Date
    x_axis_datetime_label: '%a %d %b'
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_gridlines: true
    y_axis_labels: [Gross Revenue (£k)]
    y_axis_combined: false
    interpolation: linear
    x_axis_datetime_tick_count: 7
    width: 6
    height: 3
    top: 10
    left: 6
    
################################################## Line 6 #################################################################

  - name: add_a_unique_name_71
    title: Average Discount
    type: looker_line
    model: finery_data
    explore: spree_orders
    dimensions: [spree_orders.completed_date]
    measures: [spree_orders.average_discount]
    listen:
      date: spree_orders.completed_date
    sorts: [spree_orders.completed_date desc]
    limit: 500
    show_null_points: true
    stacking: ''
    show_value_labels: false
    show_view_names: false
    swap_axes: false
    point_style: circle
    hide_legend: false
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_gridlines: true
    x_axis_scale: auto
    x_axis_label: Date
    x_axis_datetime_label: '%a %d %b'
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_gridlines: true
    y_axis_labels: [Number of Orders]
    y_axis_combined: false
    y_axis_min: 10
    y_axis_max: 20
    interpolation: linear
    x_axis_datetime_tick_count: 7
    width: 6
    height: 3
    top: 13
    left: 0

  - name: add_a_unique_name_324
    title: Average Basket Size
    type: looker_line
    model: finery_data
    explore: spree_orders
    dimensions: [spree_orders.completed_date]
    measures: [spree_orders.avg_gross_revenue_ex_discount_in_gbp_ex_vat]
    listen:
     date: spree_orders.completed_date
    sorts: [spree_orders.completed_date desc]
    limit: 500
    total: false
    row_total: right
    hide_legend: false
    show_null_points: true
    stacking: ''
    show_value_labels: false
    show_view_names: false
    swap_axes: false
    point_style: circle
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_gridlines: true
    x_axis_scale: auto
    x_axis_label: Date
    x_axis_datetime_label: '%a %d %b'
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_gridlines: true
    y_axis_labels: [Number of Orders]
    y_axis_combined: false
    y_axis_min: 60
    y_axis_max: 100
    interpolation: linear
    x_axis_datetime_tick_count: 7
    hidden_series: [Row Total]
    width: 6
    height: 3
    top: 13
    left: 6

################################################## Line 7+8 #################################################################

  - name: add_a_unique_name_609
    title: Average Items in Basket
    type: looker_line
    model: finery_data
    explore: spree_orders
    dimensions: [spree_orders.completed_date]
    measures: [spree_orders.avg_items_in_basket]
    listen:
     date: spree_orders.completed_date
    sorts: [spree_orders.completed_date desc]
    limit: 500
    hide_legend: false
    show_null_points: true
    stacking: ''
    show_value_labels: false
    show_view_names: false
    swap_axes: false
    point_style: circle
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_gridlines: true
    x_axis_scale: auto
    x_axis_label: Date
    x_axis_datetime_label: '%a %d %b'
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_gridlines: true
    y_axis_labels: [Number of Orders]
    y_axis_combined: false
    y_axis_min: 1.5
    y_axis_max: 2.5
    interpolation: linear
    x_axis_datetime_tick_count: 7
    width: 6
    height: 3
    top: 16
    left: 6

  - name: add_a_unique_name_25
    title: Sales Percentages by Department
    type: looker_column
    model: finery_data
    explore: spree_order_items
    dimensions: [spree_orders.completed_date, online_products.online_department]
    pivots: [online_products.online_department]
    measures: [spree_order_items.sum_gross_item_revenue_ex_discount_ex_vat_gbp]
    listen:
     date: spree_orders.completed_date
    sorts: [spree_orders.completed_date]
    limit: 500
    total: false
    stacking: percent
    show_value_labels: false
    show_view_names: false
    hide_legend: false
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_gridlines: false
    x_axis_scale: auto
    x_axis_label: Date
    x_axis_datetime_label: '%a %d %b'
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_gridlines: true
    y_axis_labels: [Percentage of Revenue]
    y_axis_combined: false
    show_null_points: true
    swap_axes: false
    point_style: circle
    interpolation: linear
    show_null_labels: false
    x_axis_datetime_tick_count: 7
    width: 6
    height: 6
    top: 16
    left: 0

  - name: add_a_unique_name_445
    title: Basket Size Distribution
    type: looker_area
    model: finery_data
    explore: spree_orders
    dimensions: [spree_orders.gross_reveune_ex_discount_ex_vat_ex_shipping_gbp_tier]
    measures: [spree_orders.count_orders]
    listen:
     date: spree_orders.completed_date
    sorts: [spree_orders.gross_reveune_ex_discount_ex_vat_ex_shipping_gbp_tier]
    limit: 500
    total: false
    row_total: right
    show_null_points: true
    stacking: ''
    show_value_labels: false
    show_view_names: false
    swap_axes: false
    point_style: none
    hide_legend: false
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_gridlines: false
    x_axis_scale: auto
    x_axis_label: Basket Size Group
    x_axis_datetime_label: '%d %b'
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_gridlines: true
    y_axis_labels: [Number of Orders]
    y_axis_combined: false
    font_size: medium
    interpolation: monotone
    colors: [orange]
    width: 6
    height: 3
    top: 19
    left: 6

################################################## Line 9 #################################################################

  - name: add_a_unique_name_589
    title: Order Distribution Throughout the Day - Weekend
    type: looker_area
    model: finery_data
    explore: spree_orders
    dimensions: [spree_orders.completed_hour_of_day]
    measures: [spree_orders.orders_per_day]
    listen:
     date: spree_orders.completed_date
    filters:
      spree_orders.completed_day_of_week_index: '5,6'
    sorts: [spree_orders.completed_hour_of_day]
    limit: 500
    total: false
    row_total: right
    show_null_points: true
    stacking: ''
    show_value_labels: false
    show_view_names: false
    swap_axes: false
    point_style: none
    hide_legend: false
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_gridlines: false
    x_axis_scale: auto
    x_axis_label: Hour
    x_axis_datetime_label: '%d %b'
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_gridlines: true
    y_axis_labels: [Number of Orders]
    y_axis_combined: false
    font_size: medium
    interpolation: monotone
    colors: [black]
    width: 6
    height: 3
    top: 23
    left: 6

  - name: add_a_unique_name_589
    title: Order Distribution Throughout the Day - Weekday
    type: looker_area
    model: finery_data
    explore: spree_orders
    dimensions: [spree_orders.completed_hour_of_day]
    measures: [spree_orders.orders_per_day]
    listen:
     date: spree_orders.completed_date
    filters:
      spree_orders.completed_day_of_week_index: '0,1,2,3,4'
    sorts: [spree_orders.completed_hour_of_day]
    limit: 500
    total: false
    row_total: right
    show_null_points: true
    stacking: ''
    show_value_labels: false
    show_view_names: false
    swap_axes: false
    point_style: none
    hide_legend: false
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_gridlines: false
    x_axis_scale: auto
    x_axis_label: Hour
    x_axis_datetime_label: '%d %b'
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_gridlines: true
    y_axis_labels: [Number of Orders]
    y_axis_combined: false
    font_size: medium
    interpolation: monotone
    colors: [black]
    width: 6
    height: 3
    top: 23
    left: 0
