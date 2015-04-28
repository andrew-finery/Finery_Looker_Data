- dashboard: test_dashboard
  title: Test Dashboard
  layout: tile
  tile_size: 50

#  filters:

  elements:

  - name: yest_orders_vs_visits
    title: Orders and Visits Yesterday
    type: looker_column
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_hour_of_day]
    measures: [transactions.count_transactions, sessions.count]
    filters:
      sessions.start_date: yesterday
    sorts: [sessions.start_hour_of_day]
    limit: 500
    series_types:
      transactions.count_transactions: line
      sessions.count: column
    show_value_labels: false
    show_view_names: true
    show_null_labels: false
    colors: [black, orange]
    y_axis_gridlines: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 6
    y_axis_labels: [Orders, Visits]
    x_axis_gridlines: false
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_label: Hour of Day
    series_labels:
      transactions.count_transactions: Orders
      sessions.count: Visits
    show_dropoff: false
    stacking: ''
    x_axis_scale: auto
    hide_legend: true
    height: 6
    width: 12

  - name: cr_table
    title: Conversion Rate
    type: table
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_date]
    measures: [sessions.conversion_rate]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Week on Week
      expression: |
        concat(round(100 * (${sessions.conversion_rate} - offset(${sessions.conversion_rate},1))/offset(${sessions.conversion_rate},1),2),"%")
    filters:
      sessions.start_date: 15 days ago, 8 days ago, 1 day ago
    sorts: [sessions.start_date desc]
    limit: 500
    height: 4
    width: 6

  - name: orders_table
    title: Orders
    type: table
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_date]
    measures: [transactions.count_transactions]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Week on Week
      expression: |
        concat(round(100 * (${transactions.count_transactions} - offset(${transactions.count_transactions},1))/offset(${transactions.count_transactions},1),2),"%")
    filters:
      sessions.start_date: 15 days ago, 8 days ago, 1 day ago
    sorts: [sessions.start_date desc]
    limit: 500
    height: 4
    width: 6

  - name: revenue_table
    title: Revenue
    type: table
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_date]
    measures: [transactions.gross_revenue_ex_discount_ex_vat]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Week on Week
      expression: |
        concat(round(100 * (${transactions.gross_revenue_ex_discount_ex_vat} - offset(${transactions.gross_revenue_ex_discount_ex_vat},1))/offset(${transactions.gross_revenue_ex_discount_ex_vat},1),2),"%")
    filters:
      sessions.start_date: 15 days ago, 8 days ago, 1 day ago
    sorts: [sessions.start_date desc]
    limit: 500
    height: 4
    width: 6

  - name: visits_table
    title: Visits
    type: table
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_date]
    measures: [sessions.count]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Week on Week
      expression: |
        concat(round(100 * (${sessions.count} - offset(${sessions.count},1))/offset(${sessions.count},1),2),"%")
    filters:
      sessions.start_date: 15 days ago, 8 days ago, 1 day ago
    sorts: [sessions.start_date desc]
    limit: 500
    height: 4
    width: 6

  - name: new_visits_table
    title: New Visits
    type: table
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_date]
    measures: [sessions.new_visitor_percentage]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Week on Week
      expression: |
        concat(round(100 * (${sessions.new_visitor_percentage} - offset(${sessions.new_visitor_percentage},1))/offset(${sessions.new_visitor_percentage},1),2),"%")
    filters:
      sessions.start_date: 15 days ago, 8 days ago, 1 day ago
    sorts: [sessions.start_date desc]
    limit: 500
    height: 4
    width: 6

  - name: engaged_visits_table
    title: Engaged Visits
    type: table
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_date]
    measures: [sessions.engagement_rate]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Week on Week
      expression: |
        concat(round(100 * (${sessions.engagement_rate} - offset(${sessions.engagement_rate},1))/offset(${sessions.engagement_rate},1),2),"%")
    filters:
      sessions.start_date: 15 days ago, 8 days ago, 1 day ago
    sorts: [sessions.start_date desc]
    limit: 500
    height: 4
    width: 6

  - name: page_views_table
    title: Page Views
    type: table
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_date]
    measures: [sessions.sum_page_views]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Week on Week
      expression: |
        concat(round(100 * (${sessions.sum_page_views} - offset(${sessions.sum_page_views},1))/offset(${sessions.sum_page_views},1),2),"%")
    filters:
      sessions.start_date: 15 days ago, 8 days ago, 1 day ago
    sorts: [sessions.start_date desc]
    limit: 500
    height: 4
    width: 6

  - name: page_views_per_visit
    title: Page Views per Visit
    type: table
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_date]
    measures: [sessions.page_views_per_visit]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Week on Week
      expression: |
        concat(round(100 * (${sessions.page_views_per_visit} - offset(${sessions.page_views_per_visit},1))/offset(${sessions.page_views_per_visit},1),2),"%")
    filters:
      sessions.start_date: 15 days ago, 8 days ago, 1 day ago
    sorts: [sessions.start_date desc]
    limit: 500
    height: 4
    width: 6

  - name: bounce_rate_table
    title: Bounce Rate
    type: table
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_date]
    measures: [sessions.bounce_rate]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Week on Week
      expression: |
        concat(round(100 * (${sessions.bounce_rate} - offset(${sessions.bounce_rate},1))/offset(${sessions.bounce_rate},1),2),"%")
    filters:
      sessions.start_date: 15 days ago, 8 days ago, 1 day ago
    sorts: [sessions.start_date desc]
    limit: 500
    height: 4
    width: 6
