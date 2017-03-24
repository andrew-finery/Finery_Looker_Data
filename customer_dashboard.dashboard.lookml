- dashboard: customer_dashboard
  title: Customer Dashboard
  layout: static
  tile_size: 100

#  filters:

  elements:

#################### Line 1

  - name: add_a_unique_name_89
    title: Total Customers
    type: single_value
    model: finery_data
    explore: spree_orders
    measures: [spree_orders.count_customers]
    sorts: [spree_orders.count_customers desc]
    limit: 500
    total: false
    font_size: medium
    height: 2
    width: 3
    top: 0
    left: 0
    
  - name: add_a_unique_name_793
    title: Orders per Customer
    type: single_value
    model: finery_data
    explore: spree_orders
    measures: [spree_orders.orders_per_customer]
    sorts: [spree_orders.orders_per_customer desc]
    limit: 500
    total: false
    height: 2
    width: 3
    top: 0
    left: 3

  - name: add_a_unique_name_926
    title: New Customers - Last 7 Days
    type: single_value
    model: finery_data
    explore: spree_orders
    measures: [spree_orders.count_new_customers]
    filters:
      spree_orders.completed_date: 7 days ago for 7 days
    sorts: [spree_orders.count_new_customers desc]
    limit: 500
    total: false
    height: 2
    width: 3
    top: 0
    left: 6
    
  - name: add_a_unique_name_674
    title: Total Customers - Last 7 Days
    type: single_value
    model: finery_data
    explore: spree_orders
    measures: [spree_orders.count_customers]
    filters:
      spree_orders.completed_date: 7 days ago for 7 days
    sorts: [spree_orders.count_customers desc]
    limit: 500
    total: false
    height: 2
    width: 3
    top: 0
    left: 9
    
############################### Line 2

  - name: add_a_unique_name_652
    title: Customers vs New Customers - Last 7 Days
    type: looker_area
    model: finery_data
    explore: spree_orders
    dimensions: [spree_orders.completed_date]
    measures: [spree_orders.count_customers, spree_orders.count_new_customers]
    filters:
      spree_orders.completed_date: 7 days ago for 7 days
    sorts: [spree_orders.completed_date desc]
    limit: 500
    total: false
    show_null_points: true
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_gridlines: false
    show_value_labels: false
    show_view_names: false
    interpolation: monotone
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_gridlines: false
    y_axis_combined: true
    stacking: ''
    x_axis_scale: auto
    point_style: none
    height: 3
    width: 5
    top: 2
    left: 0
    
  - name: add_a_unique_name_373
    title: Basket Size - New vs Repreat Purchase - Last 7 Days
    type: looker_bar
    model: finery_data
    explore: spree_orders
    dimensions: [spree_orders.new_customer_flag]
    measures: [spree_orders.avg_gross_revenue_ex_discount_in_gbp_ex_vat]
    filters:
      spree_orders.completed_date: 7 days ago for 7 days
    sorts: [spree_orders.avg_gross_revenue_ex_discount_in_gbp_ex_vat desc]
    limit: 500
    total: true
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_gridlines: false
    show_value_labels: false
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_gridlines: false
    y_axis_combined: true
    show_null_points: true
    interpolation: monotone
    stacking: ''
    x_axis_scale: auto
    show_null_labels: false
    height: 3
    width: 3
    top: 2
    left: 5

  - name: add_a_unique_name_618
    title: Customers by Orders Placed
    type: looker_area
    model: finery_data
    explore: spree_orders
    dimensions: [spree_orders.order_sequence_tier]
    measures: [spree_orders.count_customers]
    filters:
      spree_orders.latest_order_flag: 'Yes'
      spree_orders.order_sequence_number: -NULL
    sorts: [spree_orders.order_sequence_tier]
    limit: 500
    total: false
    show_null_points: true
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_gridlines: false
    show_value_labels: false
    show_view_names: false
    interpolation: monotone
    colors: [purple]
    y_axis_gridlines: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    stacking: ''
    x_axis_scale: auto
    point_style: none
    height: 3
    width: 4
    top: 2
    left: 8

##################### Line 3

  - name: customers_by_country
    title: Customers by Country
    type: looker_pie
    model: finery_data
    explore: spree_orders
    dimensions: [spree_addresses.country]
    measures: [spree_orders.count_customers]
    sorts: [spree_orders.count_customers desc]
    limit: 500
    total: false
    height: 3
    width: 4
    top: 5
    left: 0

  - name: add_a_unique_name_839
    title: Avg Basket Size by Country - Last 7 Days
    type: looker_bar
    model: finery_data
    explore: spree_orders
    dimensions: [spree_addresses.country]
    measures: [spree_orders.avg_gross_revenue_ex_discount_in_gbp_ex_vat]
    filters:
      spree_orders.completed_date: 7 days ago for 7 days
    sorts: [spree_orders.avg_gross_revenue_ex_discount_in_gbp_ex_vat desc]
    limit: 500
    total: true
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_gridlines: false
    show_value_labels: false
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_gridlines: false
    y_axis_combined: true
    show_null_points: true
    interpolation: monotone
    stacking: ''
    x_axis_scale: auto
    show_null_labels: false
    height: 3
    width: 4
    top: 5
    left: 4

  - name: add_a_unique_name_590
    title: Top 8 Customers of All-Time - By Revenue
    type: table
    model: finery_data
    explore: spree_orders
    dimensions: [spree_orders.order_email]
    measures: [spree_orders.count_orders, spree_orders.sum_net_revenue_ex_discount_gbp_ex_vat]
    filters:
      spree_orders.state: -"canceled",-"returned"
    sorts: [spree_orders.sum_net_revenue_ex_discount_gbp_ex_vat desc]
    limit: 8
    total: false
    height: 3
    width: 4
    top: 5
    left: 8

################################################# Line 4

  - name: uk_customer_heat_map
    title: UK Customer Heat Map
    type: looker_geo_choropleth
    model: finery_data
    explore: spree_orders
    dimensions: [spree_addresses.map_postcode]
    measures: [spree_orders.count_customers]
    filters:
      spree_addresses.country: '"United Kingdom"'
    sorts: [spree_orders.count_customers desc]
    limit: 500
    total: false
    quantize_colors: false
    map: topojson
    map_url: https://rawgit.com/wilg/3832004ce358c36b06f2/raw/772d28bfd755bcacdff0b6d9fb2b248aa2a563d1/Areas.json
    map_projection: ''
    point_color: blue
    show_null_points: true
    colors: ['#280000', '#300000', '#380000', '#400000', '#480000', '#500000', '#580000',
      '#600000', '#680000', '#700000', '#780000', '#800000', '#880000', '#900000', '#980000',
      '#a00000', '#a80000', '#b00000', '#b80000', '#c00000', '#c80000', '#d00000', '#d80000',
      '#e00000', '#e80000', '#f00000', '#f80000', '#ff0000']
    empty_color: black
    inner_border_width: 0
    loading: false
    height: 8
    width: 6
    top: 8
    left: 0
    
  - name: add_a_unique_name_288
    title: Customer Split - London vs Non-London
    type: looker_pie
    model: finery_data
    explore: spree_orders
    dimensions: [spree_addresses.london_flag]
    measures: [spree_orders.count_customers]
    sorts: [spree_orders.count_customers desc]
    limit: 500
    total: true
    show_null_points: true
    interpolation: monotone
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_gridlines: false
    show_value_labels: false
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_gridlines: false
    y_axis_combined: true
    height: 3
    width: 3
    top: 8
    left: 6

  - name: add_a_unique_name_897
    title: Avg Basket Size - London vs Non-London - Last 7 Days
    type: looker_bar
    model: finery_data
    explore: spree_orders
    dimensions: [spree_addresses.london_flag]
    measures: [spree_orders.avg_gross_revenue_ex_discount_in_gbp_ex_vat]
    filters:
      spree_orders.completed_date: 7 days ago for 7 days
    sorts: [spree_orders.avg_gross_revenue_ex_discount_in_gbp_ex_vat desc]
    limit: 500
    total: true
    show_null_points: true
    interpolation: monotone
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_gridlines: false
    show_value_labels: false
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_gridlines: false
    y_axis_combined: true
    stacking: ''
    x_axis_scale: auto
    show_null_labels: false
    height: 3
    width: 3
    top: 8
    left: 9

  - name: add_a_unique_name_878
    title: Customers in last 7 Days - Top 10 Cities
    type: looker_bar
    model: finery_data
    explore: spree_orders
    dimensions: [spree_addresses.city]
    measures: [spree_orders.count_customers]
    filters:
      spree_orders.completed_date: 7 days ago for 7 days
    sorts: [spree_orders.count_customers desc]
    limit: 10
    total: false
    show_null_points: true
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_gridlines: false
    show_value_labels: false
    show_view_names: false
    interpolation: monotone
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_gridlines: false
    y_axis_combined: true
    height: 5
    width: 6
    top: 11
    left: 6