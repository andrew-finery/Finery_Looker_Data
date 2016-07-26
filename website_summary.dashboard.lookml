- dashboard: website_summary
  title: Website Summary
  layout: static
  tile_size: 50

#  filters:

  elements:
  - name: find_yesterday
    title: Date
    type: single_value
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_date]
    filters:
      sessions.start_date: yesterday
    sorts: [sessions.start_date desc]
    limit: 500
    font_size: medium
    height: 3
    width: 8
    top: 0
    left: 0
    
  - name: yest_orders_vs_visits
    title: Orders and Visits Yesterday
    type: looker_column
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_hour_of_day]
    measures: [sessions.sum_orders, sessions.count]
    filters:
      sessions.start_date: yesterday
    sorts: [sessions.start_hour_of_day]
    limit: 500
    series_types:
      sessions.sum_orders: line
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
    y_axis_combined: false
    x_axis_gridlines: false
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_label: Hour of Day
    series_labels:
      sessions.sum_orders: Orders
      sessions.count: Visits
    show_dropoff: false
    stacking: ''
    x_axis_scale: auto
    hide_legend: true
    height: 6
    width: 24
    top: 3
    left: 0

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
    top: 9
    left: 0
    
  - name: orders_table
    title: Orders
    type: table
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_date]
    measures: [sessions.sum_orders]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Week on Week
      expression: |
        concat(round(100 * (${sessions.sum_orders} - offset(${sessions.sum_orders},1))/offset(${sessions.sum_orders},1),2),"%")
    filters:
      sessions.start_date: 15 days ago, 8 days ago, 1 day ago
    sorts: [sessions.start_date desc]
    limit: 500
    height: 4
    width: 6
    top: 13
    left: 0
    
  - name: revenue_table
    title: Revenue
    type: table
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_date]
    measures: [sessions.sum_gross_revenue_ex_discount_ex_vat]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Week on Week
      expression: |
        concat(round(100 * (${sessions.sum_gross_revenue_ex_discount_ex_vat} - offset(${sessions.sum_gross_revenue_ex_discount_ex_vat},1))/offset(${sessions.sum_gross_revenue_ex_discount_ex_vat},1),2),"%")
    filters:
      sessions.start_date: 15 days ago, 8 days ago, 1 day ago
    sorts: [sessions.start_date desc]
    limit: 500
    height: 4
    width: 6
    top: 17
    left: 0
    
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
    top: 21
    left: 0
    
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
    top: 25
    left: 0
    
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
    top: 29
    left: 0
    
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
    top: 33
    left: 0
    
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
    top: 37
    left: 0
    
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
    top: 41
    left: 0

# avg items in basket

# avg basket size

# avg engagement time

# referrals


######################################################################################################
########################################### Graphs ###################################################
######################################################################################################

  - name: cr_tw_vs_lw
    title: Conversion Rate This Week vs Last Week vs Week Before Last
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_day_of_week, sessions.start_week]
    pivots: [sessions.start_week]
    measures: [sessions.conversion_rate]
    filters:
      sessions.start_date: 2 weeks ago for 3 weeks
      sessions.start_time: before 0 days ago
    sorts: [sessions.start_day_of_week, sessions.start_week desc]
    font_size: small
    show_null_points: false
    show_value_labels: false
    show_view_names: true
    show_x_axis_label: true
    show_x_axis_ticks: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    x_axis_datetime_label: ''
    x_axis_label:  Day
    discontinuous_nulls: false
    interpolation: monotone
    colors: [blue, red, lightgreen]
    stacking: ''
    x_axis_scale: auto
    point_style: none
    height: 6
    width: 9
    top: 9
    left: 6

  - name: cr_lt
    title: Conversion Rate - Last 28 Days
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_date]
    measures: [sessions.conversion_rate]
    filters:
      sessions.start_date: 28 days ago for 28 days
    sorts: [sessions.start_date desc]
    limit: 500
    total: false
    font_size: small
    show_null_points: false
    show_value_labels: false
    show_view_names: true
    show_x_axis_label: true
    show_x_axis_ticks: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    x_axis_datetime_label: ''
    x_axis_label: Date
    discontinuous_nulls: false
    interpolation: monotone
    colors: [orange]
    stacking: ''
    x_axis_scale: auto
    point_style: none
    reference_lines:
      - value: [deviation, mean, deviation]
        label: "Avg {{mean}}"
    height: 6
    width: 9
    top: 9
    left: 15

  - name: orders_tw_vs_lw
    title: Orders This Week vs Last Week vs Week Before Last
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_day_of_week, sessions.start_week]
    pivots: [sessions.start_week]
    measures: [sessions.sum_orders]
    filters:
      sessions.start_date: 2 weeks ago for 3 weeks
      sessions.start_time: before 0 days ago
    sorts: [sessions.start_day_of_week, sessions.start_week desc]
    limit: 500
    total: false
    font_size: small
    show_null_points: false
    show_value_labels: false
    show_view_names: true
    show_x_axis_label: true
    show_x_axis_ticks: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    x_axis_datetime_label: ''
    x_axis_label: Day
    discontinuous_nulls: false
    interpolation: monotone
    colors: [blue, red, lightgreen]
    stacking: ''
    x_axis_scale: auto
    point_style: none
    height: 6
    width: 9
    top: 15
    left: 6

  - name: orders_lt
    title: Orders - Last 28 Days
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_date]
    measures: [sessions.sum_orders]
    filters:
      sessions.start_date: 28 days ago for 28 days
    sorts: [sessions.start_date desc]
    limit: 500
    total: false
    font_size: small
    show_null_points: false
    show_value_labels: false
    show_view_names: true
    show_x_axis_label: true
    show_x_axis_ticks: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    x_axis_datetime_label: ''
    x_axis_label: Date
    discontinuous_nulls: false
    interpolation: monotone
    colors: [orange]
    stacking: ''
    x_axis_scale: auto
    point_style: none
    reference_lines:
      - value: mean
        label: "Avg {{mean}}"
    height: 6
    width: 9
    top: 15
    left: 15

  - name: sessions_tw_vs_lw
    title: Visits This Week vs Last Week vs Week Before Last
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_day_of_week, sessions.start_week]
    pivots: [sessions.start_week]
    measures: [sessions.count]
    filters:
      sessions.start_date: 2 weeks ago for 3 weeks
      sessions.start_time: before 0 days ago
    sorts: [sessions.start_day_of_week, sessions.start_week desc]
    limit: 500
    total: false
    font_size: small
    show_null_points: false
    show_value_labels: false
    show_view_names: true
    show_x_axis_label: true
    show_x_axis_ticks: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    x_axis_datetime_label: ''
    x_axis_label: Day
    discontinuous_nulls: false
    interpolation: monotone
    colors: [blue, red, lightgreen]
    stacking: ''
    x_axis_scale: auto
    point_style: none
    height: 6
    width: 9
    top: 21
    left: 6

  - name: sessions_lt
    title: Visits - Last 28 Days
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_date]
    measures: [sessions.count]
    filters:
      sessions.start_date: 28 days ago for 28 days
    sorts: [sessions.start_date desc]
    limit: 500
    total: false
    font_size: small
    show_null_points: false
    show_value_labels: false
    show_view_names: true
    show_x_axis_label: true
    show_x_axis_ticks: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    x_axis_datetime_label: ''
    x_axis_label: Date
    discontinuous_nulls: false
    interpolation: monotone
    colors: [orange]
    stacking: ''
    x_axis_scale: auto
    point_style: none
    reference_lines:
      - value: mean
        label: "Avg {{mean}}"
    height: 6
    width: 9
    top: 21
    left: 15

  - name: new_sessions_tw_vs_lw
    title: New Session % This Week vs Last Week vs Week Before Last
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_day_of_week, sessions.start_week]
    pivots: [sessions.start_week]
    measures: [sessions.new_visitor_percentage]
    filters:
      sessions.start_date: 2 weeks ago for 3 weeks
      sessions.start_time: before 0 days ago
    sorts: [sessions.start_day_of_week, sessions.start_week desc]
    limit: 500
    total: false
    font_size: small
    show_null_points: false
    show_value_labels: false
    show_view_names: true
    show_x_axis_label: true
    show_x_axis_ticks: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    x_axis_datetime_label: ''
    x_axis_label: Day
    discontinuous_nulls: false
    interpolation: monotone
    colors: [blue, red, lightgreen]
    stacking: ''
    x_axis_scale: auto
    point_style: none
    height: 6
    width: 9
    top: 27
    left: 6

  - name: new_sessions_lt
    title: New Session % - Last 28 Days
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_date]
    measures: [sessions.new_visitor_percentage]
    filters:
      sessions.start_date: 28 days ago for 28 days
    sorts: [sessions.start_date desc]
    limit: 500
    total: false
    font_size: small
    show_null_points: false
    show_value_labels: false
    show_view_names: true
    show_x_axis_label: true
    show_x_axis_ticks: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    x_axis_datetime_label: ''
    x_axis_label: Date
    discontinuous_nulls: false
    interpolation: monotone
    colors: [orange]
    stacking: ''
    x_axis_scale: auto
    point_style: none
    reference_lines:
      - value: mean
        label: "Avg {{mean}}"
    height: 6
    width: 9
    top: 27
    left: 15

  - name: nl_sub_tw_vs_lw
    title: Newsletter Subscriptions This Week vs Last Week vs Week Before Last
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_day_of_week, sessions.start_week]
    pivots: [sessions.start_week]
    measures: [sessions.sum_newsletter_signups]
    filters:
      sessions.start_date: 2 weeks ago for 3 weeks
      sessions.start_time: before 0 days ago
    sorts: [sessions.start_day_of_week, sessions.start_week desc]
    limit: 500
    total: false
    font_size: small
    show_null_points: false
    show_value_labels: false
    show_view_names: true
    show_x_axis_label: true
    show_x_axis_ticks: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    x_axis_datetime_label: ''
    x_axis_label: Day
    discontinuous_nulls: false
    interpolation: monotone
    colors: [blue, red, lightgreen]
    stacking: ''
    x_axis_scale: auto
    point_style: none
    height: 6
    width: 9
    top: 33
    left: 6

  - name: nl_sub_lt
    title: Newsletter Subscriptions - Last 28 Days
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_date]
    measures: [sessions.sum_newsletter_signups]
    filters:
      sessions.start_date: 28 days ago for 28 days
    sorts: [sessions.start_date desc]
    limit: 500
    total: false
    font_size: small
    show_null_points: false
    show_value_labels: false
    show_view_names: true
    show_x_axis_label: true
    show_x_axis_ticks: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    x_axis_datetime_label: ''
    x_axis_label: Date
    discontinuous_nulls: false
    interpolation: monotone
    colors: [orange]
    stacking: ''
    x_axis_scale: auto
    point_style: none
    reference_lines:
      - value: mean
        label: "Avg {{mean}}"
    height: 6
    width: 9
    top: 33
    left: 15
    
# referrals