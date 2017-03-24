- dashboard: abandoned_cart_email_dashboard
  title: Abandoned Cart Email Dashboard
  layout: static
  tile_size: 100

  elements:

  - name: abandon_cart_email_sent_30_day
    title: Emails Sent - Last 30 Days
    type: single_value
    model: finery_data
    explore: mandrill_email_summary
    measures: [mandrill_email_summary.count_messages_sent]
    filters:
      mandrill_email_summary.email_group: Abandoned Cart
      mandrill_email_summary.email_sent_date: 30 days ago for 30 days
    sorts: [mandrill_email_summary.count_messages_sent desc]
    limit: 500
    column_limit: ''
    show_null_labels: false
    font_size: small
    stacking: ''
    show_value_labels: false
    label_density: 10
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    show_null_points: true
    point_style: none
    interpolation: linear
    legend_position: center
    y_axis_combined: true
    top: 0
    left: 0
    height: 2
    width: 4

  - name: abaondon_cart_open_rate_30_day
    title: Open Rate - Last 30 Days
    type: single_value
    model: finery_data
    explore: mandrill_email_summary
    measures: [mandrill_email_summary.open_rate]
    filters:
      mandrill_email_summary.email_group: Abandoned Cart
      mandrill_email_summary.email_sent_date: 30 days ago for 30 days
    limit: 500
    column_limit: ''
    show_null_labels: false
    font_size: small
    stacking: ''
    show_value_labels: false
    label_density: 10
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    show_null_points: true
    point_style: none
    interpolation: linear
    colors: [orange]
    legend_position: center
    y_axis_combined: true
    top: 0
    left: 4
    height: 2
    width: 4
    
  - name: abaondon_cart_click_rate_30_day
    title: Click Rate - Last 30 Days
    type: single_value
    model: finery_data
    explore: mandrill_email_summary
    measures: [mandrill_email_summary.click_rate]
    filters:
      mandrill_email_summary.email_group: Abandoned Cart
      mandrill_email_summary.email_sent_date: 30 days ago for 30 days
    sorts: [mandrill_email_summary.click_rate desc]
    limit: 500
    column_limit: ''
    show_null_labels: false
    font_size: small
    stacking: ''
    show_value_labels: false
    label_density: 10
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    show_null_points: true
    point_style: none
    interpolation: linear
    colors: [orange]
    legend_position: center
    y_axis_combined: true
    top: 0
    left: 8
    height: 2
    width: 4
    
  - name: abandon_cart_web_visits_last_30_days
    title: Web Visits - Last 30 Days
    type: single_value
    model: finery_data
    explore: sessions
    measures: [sessions.count]
    filters:
      session_start_calendar.calendar_date_date: 30 days ago for 30 days
      sessions.crm_sub_channel: Abandon Cart
    sorts: [sessions.count desc]
    limit: 500
    column_limit: ''
    ordering: none
    show_null_labels: false
    font_size: small
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    show_null_points: true
    point_style: none
    interpolation: linear
    top: 2
    left: 0
    height: 2
    width: 4
    
  - name: abandon_cart_orders_last_30_days
    title: Orders - Last 30 Days
    type: single_value
    model: finery_data
    explore: sessions
    measures: [sessions.sum_orders]
    filters:
      session_start_calendar.calendar_date_date: 30 days ago for 30 days
      sessions.crm_sub_channel: Abandon Cart
    sorts: [sessions.sum_orders desc]
    limit: 500
    column_limit: ''
    ordering: none
    show_null_labels: false
    font_size: small
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    show_null_points: true
    point_style: none
    interpolation: linear
    top: 2
    left: 4
    height: 2
    width: 4
    
  - name: abandon_cart_cr_30_days
    title: Conversion Rate - Last 30 Days
    type: single_value
    model: finery_data
    explore: sessions
    measures: [sessions.conversion_rate]
    filters:
      session_start_calendar.calendar_date_date: 30 days ago for 30 days
      sessions.crm_sub_channel: Abandon Cart
    sorts: [sessions.conversion_rate desc]
    limit: 500
    column_limit: ''
    ordering: none
    show_null_labels: false
    font_size: small
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    show_null_points: true
    point_style: none
    interpolation: linear
    top: 2
    left: 8
    height: 2
    width: 4
    
  - name: abandon_cart_email_sent
    title: Emails Sent - Last 30 Days
    type: looker_line
    model: finery_data
    explore: mandrill_email_summary
    dimensions: [mandrill_email_summary.email_sent_date]
    measures: [mandrill_email_summary.count_messages_sent]
    filters:
      mandrill_email_summary.email_group: Abandoned Cart
      mandrill_email_summary.email_sent_date: 30 days ago for 30 days
    sorts: [mandrill_email_summary.email_sent_date]
    limit: 500
    column_limit: ''
    stacking: ''
    show_value_labels: false
    label_density: 10
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    show_null_labels: false
    show_null_points: true
    point_style: none
    interpolation: linear
    top: 5
    left: 0
    height: 4
    width: 6
    
  - name: abandon_cart_open_rate
    title: Open Rate - Last 30 Days
    type: looker_line
    model: finery_data
    explore: mandrill_email_summary
    dimensions: [mandrill_email_summary.email_sent_date]
    measures: [mandrill_email_summary.open_rate]
    filters:
      mandrill_email_summary.email_group: Abandoned Cart
      mandrill_email_summary.email_sent_date: 30 days ago for 30 days
    sorts: [mandrill_email_summary.email_sent_date]
    limit: 500
    column_limit: ''
    stacking: ''
    show_value_labels: false
    label_density: 10
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    show_null_labels: false
    show_null_points: true
    point_style: none
    interpolation: linear
    colors: [orange]
    top: 5
    left: 6
    height: 4
    width: 6

  - name: abandon_cart_click_rate
    title: Click Rate - Last 30 Days
    type: looker_line
    model: finery_data
    explore: mandrill_email_summary
    dimensions: [mandrill_email_summary.email_sent_date]
    measures: [mandrill_email_summary.click_rate]
    filters:
      mandrill_email_summary.email_group: Abandoned Cart
      mandrill_email_summary.email_sent_date: 30 days ago for 30 days
    sorts: [mandrill_email_summary.email_sent_date]
    limit: 500
    column_limit: ''
    stacking: ''
    show_value_labels: false
    label_density: 10
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    show_null_labels: false
    show_null_points: true
    point_style: none
    interpolation: linear
    colors: [purple]
    top: 9
    left: 0
    height: 4
    width: 6
    
  - name: abandon_cart_visits_to_site
    title: Visits to Site - Last 30 Days
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_date]
    measures: [sessions.count]
    filters:
      session_start_calendar.calendar_date_date: 30 days ago for 30 days
      sessions.crm_sub_channel: Abandon Cart
    sorts: [session_start_calendar.calendar_date_date desc]
    limit: 500
    column_limit: ''
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    show_null_points: true
    point_style: none
    interpolation: linear
    ordering: none
    show_null_labels: false
    top: 9
    left: 6
    height: 4
    width: 6
    
  - name: abandon_cart_orders
    title: Orders - Last 30 Days
    type: looker_column
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_date]
    measures: [sessions.sum_orders]
    filters:
      session_start_calendar.calendar_date_date: 30 days ago for 30 days
      sessions.crm_sub_channel: Abandon Cart
    sorts: [session_start_calendar.calendar_date_date desc]
    limit: 500
    column_limit: ''
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    ordering: none
    show_null_labels: false
    show_null_points: true
    point_style: none
    interpolation: linear
    top: 13
    left: 0
    height: 4
    width: 6

  - name: abandon_cart_revenue
    title: Gross Revenue - Last 30 Days
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_date]
    measures: [sessions.sum_gross_revenue_ex_discount]
    filters:
      session_start_calendar.calendar_date_date: 30 days ago for 30 days
      sessions.crm_sub_channel: Abandon Cart
    sorts: [session_start_calendar.calendar_date_date desc]
    limit: 500
    stacking: ''
    colors: ['#F16358']
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    top: 13
    left: 6
    height: 4
    width: 6
