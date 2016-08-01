- dashboard: weekly_meeting_dashboard
  title: Weekly Meeting Dashboard
  layout: static
  tile_size: 100

#  filters:

  elements:

#### Slide 1

  - name: visits_last_12_weeks
    title: Visits - Last 12 Weeks
    type: looker_column
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.year_week_number]
    measures: [sessions.count]
    filters:
      session_start_calendar.calendar_date_week: 12 weeks ago for 12 weeks
    sorts: [session_start_calendar.year_week_number]
    limit: 500
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_labels: [Visits]
    y_axis_tick_density: default
    y_axis_value_format: '#, "k"'
    show_x_axis_label: true
    x_axis_label: Week
    show_x_axis_ticks: true
    x_axis_datetime_tick_count: 1
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_labels: false
    height: 4
    width: 6
    top: 0
    left: 0
  
  - name: orders_last_12_weeks
    title: Orders - Last 12 Weeks
    type: looker_column
    model: finery_data
    explore: spree_orders
    dimensions: [calendar_weeks.year_week_number]
    measures: [spree_orders.count_orders]
    filters:
      calendar_weeks.calendar_date_week: 12 weeks ago for 12 weeks
    sorts: [calendar_weeks.year_week_number]
    limit: 500
    stacking: ''
    colors: ['#F16358', '#E0635E', '#D06464', '#BF656B', '#AF6671', '#9F6777', '#8E687E',
      '#7E6984', '#6E6A8A', '#5D6B91', '#4D6C97', '#3D6D9E']
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_labels: [Orders]
    y_axis_tick_density: default
    y_axis_value_format: '#.0, "k"'
    show_x_axis_label: true
    x_axis_label: Week
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_labels: false
    height: 4
    width: 6
    top: 0
    left: 6
    
  - name: conversion_rate_last_12_weeks
    title: Conversion Rate - Last 12 Weeks
    type: looker_column
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.year_week_number]
    measures: [sessions.conversion_rate]
    filters:
      session_start_calendar.calendar_date_week: 12 weeks ago for 12 weeks
    sorts: [session_start_calendar.year_week_number]
    limit: 500
    stacking: ''
    colors: ['#8d4074', '#a15e8a', '#b57ba0', '#c899b7', '#dcb7cf', '#efd7e7', '#e0e9cc',
      '#bcd0a6', '#97b780', '#749e5b', '#508637', '#286f0f']
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_labels: [Conversion Rate]
    y_axis_tick_density: default
    y_axis_value_format: 0.0%
    show_x_axis_label: true
    x_axis_label: Week
    show_x_axis_ticks: true
    x_axis_datetime_tick_count: 1
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_labels: false
    height: 4
    width: 6
    top: 4
    left: 0
    
  - name: basket_size_last_12_weeks
    title: Basket Size - Last 12 Weeks
    type: looker_column
    model: finery_data
    explore: spree_orders
    dimensions: [calendar_weeks.year_week_number]
    measures: [spree_orders.avg_gross_revenue_ex_discount_in_gbp]
    filters:
      calendar_weeks.calendar_date_week: 12 weeks ago for 12 weeks
    sorts: [calendar_weeks.year_week_number]
    limit: 500
    stacking: ''
    colors: ['#7FCDAE', '#7ED09C', '#7DD389', '#85D67C', '#9AD97B', '#B1DB7A', '#CADF79',
      '#E2DF78', '#E5C877', '#E7AF75', '#EB9474', '#EE7772']
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_labels: [Basket Size]
    y_axis_tick_density: default
    y_axis_value_format: '"£"#'
    show_x_axis_label: true
    x_axis_label: Week
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_labels: false
    height: 4
    width: 6
    top: 4
    left: 6
    
#### Slide 2

  - name: visits_by_channel_last_12_weeks
    title: Visits by Channel - Last 12 Weeks
    type: looker_column
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.year_week_number, sessions.traffic_source]
    pivots: [sessions.traffic_source]
    measures: [sessions.count]
    filters:
      session_start_calendar.calendar_date_week: 12 weeks ago for 12 weeks
    sorts: [session_start_calendar.year_week_number, sessions.traffic_source, sessions.traffic_source__sort_]
    limit: 500
    column_limit: 50
    stacking: normal
    colors: ['#8dd3c7', '#ffed6f', '#bebada', '#fb8072', '#80b1d3', '#fdb462', '#b3de69',
      '#fccde5', '#d9d9d9', '#bc80bd', '#ccebc5', '#a3a3ff']
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_labels: [Visits]
    y_axis_tick_density: default
    y_axis_value_format: '#, "k"'
    show_x_axis_label: true
    x_axis_label: Week
    show_x_axis_ticks: true
    x_axis_datetime_tick_count: 1
    x_axis_scale: auto
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: '#808080'
    height: 8
    width: 12
    top: 9
    left: 0
    

#### Slide 3
  - name: visits_month_on_month_so_far
    title: Visits - Month on Month (so far)
    type: looker_column
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_month]
    measures: [sessions.count]
    filters:
      session_start_calendar.calendar_date_month: 2 months
    filter_expression: ${session_start_calendar.calendar_date_day_of_month} < extract_days(now())
#    filters:
#      session_start_calendar.calendar_date_month: 2 months ago for 2 months
    sorts: [session_start_calendar.calendar_date_month desc]
    limit: 500
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: '25'
    label_color: [red]
    font_size: 20px
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_labels: [Visits]
    y_axis_tick_density: default
    y_axis_value_format: 0, "k"
    show_x_axis_label: true
    x_axis_label: Month
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    label_value_format: 0, "k"
    show_null_labels: false
    height: 4
    width: 6
    top: 18
    left: 0

  - name: orders_month_on_month_so_far
    title: Orders - Month on Month (so far)
    type: looker_column
    model: finery_data
    explore: spree_orders
    dimensions: [calendar_weeks.calendar_date_month]
    measures: [spree_orders.count_orders]
    filters:
      calendar_weeks.calendar_date_month: 2 months
    filter_expression: ${spree_orders.completed_day_of_month} < extract_days(now())
#    filters:
#      calendar_weeks.calendar_date_month: 2 months ago for 2 months
    sorts: [calendar_weeks.calendar_date_month desc]
    limit: 500
    stacking: ''
    colors: ['#F16358', '#E0635E', '#D06464', '#BF656B', '#AF6671', '#9F6777', '#8E687E',
      '#7E6984', '#6E6A8A', '#5D6B91', '#4D6C97', '#3D6D9E']
    show_value_labels: true
    label_density: 25
    label_color: [red]
    font_size: 20px
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_labels: [Orders]
    y_axis_tick_density: default
    y_axis_value_format: 0.0, "k"
    show_x_axis_label: true
    x_axis_label: Month
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_labels: false
    height: 4
    width: 6
    top: 18
    left: 6

  - name: cr_month_on_month_so_far
    title: Conversion Rate - Month on Month (so far)
    type: looker_column
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_month]
    measures: [sessions.conversion_rate]
    filters:
      session_start_calendar.calendar_date_month: 2 months
    filter_expression: ${session_start_calendar.calendar_date_day_of_month} < extract_days(now())
#    filters:
#      session_start_calendar.calendar_date_month: 2 months ago for 2 months
    sorts: [session_start_calendar.calendar_date_month desc]
    limit: 500
    stacking: ''
    colors: ['#8d4074', '#a15e8a', '#b57ba0', '#c899b7', '#dcb7cf', '#efd7e7', '#e0e9cc',
      '#bcd0a6', '#97b780', '#749e5b', '#508637', '#286f0f']
    show_value_labels: true
    label_density: 25
    label_color: [red]
    font_size: 20px
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_labels: [Visits]
    y_axis_tick_density: default
    y_axis_value_format: 0.0%
    show_x_axis_label: true
    x_axis_label: Month
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    label_value_format: 0.0%
    show_null_labels: false
    height: 4
    width: 6
    top: 22
    left: 0

  - name: basket_size_month_on_month_so_far
    title: Basket Size - Month on Month (so far)
    type: looker_column
    model: finery_data
    explore: spree_orders
    dimensions: [calendar_weeks.calendar_date_month]
    measures: [spree_orders.avg_gross_revenue_ex_discount_in_gbp]
    filters:
      calendar_weeks.calendar_date_month: 2 months
    filter_expression: ${spree_orders.completed_day_of_month} < extract_days(now())
#    filters:
#      calendar_weeks.calendar_date_month: 2 months ago for 2 months
    sorts: [calendar_weeks.calendar_date_month desc]
    limit: 500
    stacking: ''
    colors: ['#7FCDAE', '#7ED09C', '#7DD389', '#85D67C', '#9AD97B', '#B1DB7A', '#CADF79',
      '#E2DF78', '#E5C877', '#E7AF75', '#EB9474', '#EE7772']
    show_value_labels: true
    label_density: 25
    label_color: [red]
    font_size: 20px
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_labels: [Basket Size]
    y_axis_tick_density: default
    y_axis_value_format: '"£"#'
    show_x_axis_label: true
    x_axis_label: Month
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    label_value_format: '"£"0'
    show_null_labels: false
    height: 4
    width: 6
    top: 22
    left: 6
    
#### Slide 4
  - name: running_total_revenue_mom
    title: Running Total Revenue Month on Month
    type: looker_line
    model: finery_data
    explore: spree_orders
    dimensions: [calendar_weeks.calendar_date_month, spree_orders.completed_day_of_month]
    pivots: [calendar_weeks.calendar_date_month]
    measures: [spree_orders.sum_gross_revenue_ex_discount_in_gbp]
    dynamic_fields:
    - table_calculation: calculation_3
      label: Calculation 3
      expression: if(is_null(${spree_orders.sum_gross_revenue_ex_discount_in_gbp}), null, running_total(${spree_orders.sum_gross_revenue_ex_discount_in_gbp}))
      value_format_name: gbp_0
    hidden_fields: [spree_orders.sum_gross_revenue_ex_discount_in_gbp, calculation_2,
      calculation_1]
    filters:
      calendar_weeks.calendar_date_date: 1 month ago for 2 months
      spree_orders.completed_date: before 0 days ago
#    filters:
#      calendar_weeks.calendar_date_month: 2 months ago for 2 months
    sorts: [calendar_weeks.calendar_date_month desc, spree_orders.completed_day_of_month]
    limit: 31
    stacking: ''
    colors: [purple, skyblue]
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: true
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: false
    point_style: none
    interpolation: monotone
    height: 8
    width: 12
    top: 27
    left: 0
    
#### Slide 5

  - name: newsletter_subscribers_last_12_weeks
    title: New Newsletter Subscribers - Last 12 Weeks
    type: looker_column
    model: finery_data
    explore: mc_newsletter_subscribers
    dimensions: [mc_newsletter_subscribers.member_subscribed_time_week]
    measures: [mc_newsletter_subscribers.unique_email_addresses]
    filters:
      mc_newsletter_subscribers.member_subscribed_time_week: 12 weeks ago for 12 weeks
    sorts: [mc_newsletter_subscribers.member_subscribed_time_week desc]
    limit: 500
    stacking: ''
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
      '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_labels: [New Subscribers]
    y_axis_tick_density: default
    y_axis_value_format: 0.0, "k"
    show_x_axis_label: true
    x_axis_label: Week
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_labels: false
    height: 8
    width: 12
    top: 36
    left: 0

#### Slide 6

  - name: return_rate_last_12_weeks
    title: Return Rate - Last 12 Complete Return Weeks
    type: looker_line
    model: finery_data
    explore: spree_order_items
    dimensions: [calendar_weeks.year_week_number]
    measures: [spree_order_items.return_rate]
    filters:
      calendar_weeks.calendar_date_week: 16 weeks ago for 12 weeks
    sorts: [spree_order_items.return_rate desc]
    limit: 500
    stacking: ''
    colors: ['#000000', '#191919', '#292929', '#3c3c3c', '#4e4e4e', '#626262', '#777777',
      '#8d8d8d', '#a3a3a3', '#b9b9b9', '#d0d0d0', '#e7e7e7']
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    y_axis_min: ['0.35']
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_labels: [Return Rate]
    y_axis_tick_density: default
    y_axis_value_format: '#0%'
    show_x_axis_label: true
    x_axis_label: Week
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    point_style: none
    interpolation: linear
    height: 8
    width: 12
    top: 45
    left: 0
