- dashboard: site_visitors_cohorts
  title: Monthly Visitor Cohort Dashboard
  layout: static
  tile_size: 100

#  filters:

  elements:

  - name: visitor_cohort_sizes
    title: Visitor Cohort Sizes (New Visitors in each Month)
    type: looker_column
    model: finery_data
    explore: sessions
    dimensions: [visitors.first_touch_month]
    measures: [sessions.visitors_count]
    filters:
      session_start_calendar.calendar_date_date: before this month
      session_start_calendar.calendar_date_month: after 2015/02/01
      visitors.first_touch_month: after 2015/02/01
    sorts: [visitors.first_touch_month]
    limit: 500
    column_limit: 50
    colors: ['#66CDAA']
    show_value_labels: true
    label_density: 25
    label_color: [red]
    font_size: 20px
    legend_position: center
    show_y_axis_labels: true
    y_axis_labels: [New Visitors]
    y_axis_tick_density: default
    show_x_axis_ticks: true
    x_axis_datetime_label: '%b %y'
    x_axis_scale: ordinal
    show_view_names: false
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_x_axis_label: false
    label_value_format: 0, "k"
    top: 0
    left: 0
    height: 3
    width: 10
    
  - name: visitor_cohorts_visits_per_visitor
    title: Visitor Cohorts - Visits/Unique Visitors (running total)
    type: table
    model: finery_data
    explore: sessions
    dimensions: [visitors.first_touch_month, session_start_calendar.calendar_date_month]
    pivots: [visitors.first_touch_month]
    measures: [sessions.count, sessions.visitors_count]
    dynamic_fields:
    - table_calculation: total_visits_per_user
      label: Total Visits per User
      expression: offset(if(is_null(${sessions.visitors_count})="Yes", null, running_total(${sessions.count})/max(${sessions.visitors_count})), max(diff_months(${session_start_calendar.calendar_date_month},${visitors.first_touch_month})))
      value_format: '#0.00'
    - table_calculation: months_after_first_visit
      label: Months After First Visit
      expression: concat("Month + ", row()-1)
    filters:
      session_start_calendar.calendar_date_date: before this month
      session_start_calendar.calendar_date_month: after 2015/02/01
      visitors.first_touch_month: after 2015/02/01
    sorts: [session_start_calendar.calendar_date_month, visitors.first_touch_month]
    limit: 500
    column_limit: 50
    show_view_names: true
    ordering: none
    show_null_labels: false
    hidden_fields: [session_start_calendar.calendar_date_month, sessions.count, sessions.visitors_count]
    show_row_numbers: true
    stacking: normal
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    point_style: none
    interpolation: linear
    show_null_points: true
    height: 4
    width: 10
    top: 3
    left: 0
    
  - name: visits_by_month_by_cohort
    title: Visits by Month
    type: looker_area
    model: finery_data
    explore: sessions
    dimensions: [visitors.first_touch_month, session_start_calendar.calendar_date_month]
    pivots: [visitors.first_touch_month]
    measures: [sessions.count]
    filters:
      session_start_calendar.calendar_date_date: before this month
      session_start_calendar.calendar_date_month: after 2015/02/01
      visitors.first_touch_month: after 2014/11/01
    sorts: [session_start_calendar.calendar_date_month, visitors.first_touch_month]
    limit: 500
    column_limit: 50
    stacking: normal
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
      '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    label_density: 25
    legend_position: center
    y_axis_gridlines: true
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
    show_x_axis_label: false
    x_axis_gridlines: false
    height: 6
    width: 10
    top: 7
    left: 0
