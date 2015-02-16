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
    
################################ Line 3 ##################################################################

  - name: add_a_unique_name_666
    title: In-Store vs Online Orders
    type: looker_pie
    model: finery_data
    explore: spree_orders
    dimensions: [spree_orders.in_store_flag]
    measures: [spree_orders.count_orders]
    listen:
     date: spree_orders.completed_date
    sorts: [spree_orders.count_orders desc]
    width: 5
    height: 3
    top: 4
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
    width: 7
    height: 3
    top: 4
    left: 5

##################################################### Line 4 ####################################################################

  - name: add_a_unique_name_71
    title: Gross Revenue by Day
    type: looker_area
    model: finery_data
    explore: spree_orders
    dimensions: [spree_orders.completed_date, spree_orders.in_store_flag]
    pivots: [spree_orders.in_store_flag]
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
    top: 7
    left: 0

  - name: add_a_unique_name_71
    title: Average Discount
    type: looker_line
    model: finery_data
    explore: spree_orders
    dimensions: [spree_orders.completed_date, spree_orders.in_store_flag]
    pivots: [spree_orders.in_store_flag]
    measures: [spree_orders.average_discount]
    listen:
      date: spree_orders.completed_date
    sorts: [spree_orders.completed_date desc]
    limit: 500
    total: false
    row_total: right
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
    interpolation: linear
    x_axis_datetime_tick_count: 7
    hidden_series: [Row Total]
    width: 6
    height: 3
    top: 7
    left: 6

################################################## Line 5 #################################################################
    
  - name: add_a_unique_name_324
    title: Average Basket Size
    type: looker_line
    model: finery_data
    explore: spree_orders
    dimensions: [spree_orders.in_store_flag, spree_orders.completed_date]
    pivots: [spree_orders.in_store_flag]
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
    interpolation: linear
    x_axis_datetime_tick_count: 7
    hidden_series: [Row Total]
    width: 6
    height: 3
    top: 10
    left: 0

  - name: add_a_unique_name_609
    title: Average Items in Basket
    type: looker_line
    model: finery_data
    explore: spree_orders
    dimensions: [spree_orders.in_store_flag, spree_orders.completed_date]
    pivots: [spree_orders.in_store_flag]
    measures: [spree_orders.avg_items_in_basket]
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
    interpolation: linear
    x_axis_datetime_tick_count: 7
    hidden_series: [Row Total]
    width: 6
    height: 3
    top: 10
    left: 6

############################################## Line 6 + 7 ###########################################################

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
    top: 13
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
    top: 13
    left: 6

  - name: add_a_unique_name_923
    title: Order Distribution Throughout the Day
    type: looker_area
    model: finery_data
    explore: spree_orders
    dimensions: [spree_orders.completed_hod]
    measures: [spree_orders.orders_per_day]
    listen:
     date: spree_orders.completed_date
    sorts: [spree_orders.completed_hod]
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
    top: 16
    left: 6
