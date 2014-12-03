- dashboard: customer_dashboard
  title: Customer Dashboard
  layout: tile
  tile_size: 100

#  filters:

  elements:

  - name: leads_generated
    title: Leads Generated
    type: single_value
    model: finery_data
    explore: leads
    measures: [leads.count_leads]
    sorts: [leads.count_leads desc]
    height: 2
    width: 3
    
  - name: sign_ups
    title: Users Signed Up
    type: single_value
    model: finery_data
    explore: users_signup
    measures: [users_signup.sign_ups]
    sorts: [users_signup.sign_ups desc]
    height: 2
    width: 3

  - name: number_of_customers
    title: Number of Customers
    type: single_value
    model: finery_data
    explore: spree_orders
    measures: [spree_orders.count_customers]
    sorts: [spree_orders.count_customers desc]
    height: 2
    width: 3
    
  - name: number_of_orders
    title: Number_of_Orders
    type: single_value
    model: finery_data
    explore: spree_orders
    measures: [spree_orders.count_orders]
    sorts: [spree_orders.count_orders desc]
    height: 2
    width: 3

  - name: leads_generated_over_time
    title: Leads Generated by Day
    type: looker_line
    model: finery_data
    explore: leads
    dimensions: [leads.created_at_hour]
    measures: [leads.leads_running_total]
    sorts: [leads.created_at_hour]
    limit: 500
    show_null_points: true
    stacking: ''
    show_value_labels: false
    show_view_names: true
    x_axis_scale: auto
    point_style: none
    interpolation: linear
    height: 3
    width: 4

  - name: sign_ups_over_time
    title: Sign Ups Over Time
    type: looker_line
    model: finery_data
    explore: users_signup
    dimensions: [users_signup.created_at_hour]
    measures: [users_signup.sign_ups_running_total]
    sorts: [users_signup.created_at_hour]
    limit: 500
    show_value_labels: false
    show_view_names: true
    y_axis_combined: false
    show_null_points: false
    stacking: ''
    x_axis_scale: time
    point_style: none
    interpolation: linear
    height: 3
    width: 4

  - name: sign_ups_by_source
    title: Sign Ups By Source
    type: table
    model: finery_data
    explore: users_signup
    dimensions: [users_signup.source]
    measures: [users_signup.emails_sent, users_signup.sign_ups, users_signup.sign_up_rate,
      spree_orders.count_customers, users_signup.purchase_rate]
    sorts: [users_signup.emails_sent desc]
    limit: 500
    height: 3
    width: 4

  - name: customer_information
    title: Customer Information
    type: table
    model: finery_data
    explore: spree_orders
    dimensions: [users_signup.source]
    measures: [spree_orders.count_customers, spree_orders.count_orders, spree_orders.avg_gross_revenue_gbp,
    spree_orders.avg_net_revenue_ex_tax_in_gbp, spree_orders.avg_net_revenue_ex_tax_and_discount_gbp,
    spree_orders.avg_store_credit_used_gbp, spree_orders.avg_discount_in_gbp]
    sorts: [spree_orders.count_customers desc]
    limit: 500
    height: 3
    width: 8

  - name: gross_revenue_by_day
    title: Gross Revenue by Day
    type: looker_line
    model: finery_data
    explore: spree_orders
    dimensions: [spree_orders.completed_date]
    measures: [spree_orders.sum_gross_revenue_gbp, spree_orders.gross_revenue_gbp_running_total]
    filters:
      spree_orders.completed_date: before 0 days ago
    sorts: [spree_orders.completed_date]
    limit: 500
    show_null_points: true
    show_value_labels: false
    show_view_names: true
    y_axis_combined: true
    stacking: ''
    x_axis_scale: auto
    point_style: none
    interpolation: linear
    height: 3
    width: 7



  - name: top_customers
    title: Ten Highest Spending Repeat Customers
    type: table
    model: finery_data
    explore: spree_orders
    dimensions: [users_signup.email_address, users_signup.first_name, users_signup.last_name,
      users_signup.source]
    measures: [spree_orders.count_orders, spree_orders.total_items, spree_orders.avg_gross_revenue_gbp,
      spree_orders.sum_gross_revenue_gbp]
    filters:
      spree_orders.count_orders: '>1'
    sorts: [spree_orders.sum_gross_revenue_gbp desc]
    limit: 10
    height: 6
    width: 8

