- dashboard: abandoned_cart_email
  title: Abandoned Cart Email
  layout: tile
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
    font_size: medium
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
    font_size: medium
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
    font_size: medium
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

  - name: web_visits_last_30_days
    title: Web Visits - Last 30 Days
    type: single_value
    model: finery_data
    explore: sessions
    measures: [sessions.count]
    filters:
      session_start_calendar.calendar_date_date: 30 days ago for 30 days
      sessions.campaign_name: abandon_cart
    sorts: [sessions.count desc]
    limit: 500
    column_limit: ''
    ordering: none
    show_null_labels: false
    font_size: medium
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

  - name: orders_last_30_days
    title: Orders - Last 30 Days
    type: single_value
    model: finery_data
    explore: sessions
    measures: [transactions.count_transactions]
    filters:
      session_start_calendar.calendar_date_date: 30 days ago for 30 days
      sessions.campaign_name: abandon_cart
    sorts: [transactions.count_transactions desc]
    limit: 500
    column_limit: ''
    ordering: none
    show_null_labels: false
    font_size: medium
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

  - name: cr_30_days
    title: Conversion Rate - Last 30 Days
    type: single_value
    model: finery_data
    explore: sessions
    measures: [sessions.conversion_rate]
    filters:
      session_start_calendar.calendar_date_date: 30 days ago for 30 days
      sessions.campaign_name: abandon_cart
    sorts: [sessions.conversion_rate desc]
    limit: 500
    column_limit: ''
    ordering: none
    show_null_labels: false
    font_size: medium
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

  - name: email_sent
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

  - name: open_rate
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

  - name: click_rate
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

  - name: visits_to_site
    title: Visits to Site - Last 30 Days
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_date]
    measures: [sessions.count]
    filters:
      session_start_calendar.calendar_date_date: 30 days ago for 30 days
      sessions.campaign_name: '"abandon^_cart"'
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

  - name: orders_last_30_days
    title: Orders - Last 30 Days
    type: looker_column
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_date]
    measures: [transactions.count_transactions]
    filters:
      session_start_calendar.calendar_date_date: 30 days ago for 30 days
      sessions.campaign_name: '"abandon^_cart"'
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

