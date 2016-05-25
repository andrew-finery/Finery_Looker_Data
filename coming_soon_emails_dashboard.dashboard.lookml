- dashboard: coming_soon_emails_dashboard
  title: Coming Soon Emails Dashboard
  layout: static
  tile_size: 100

  elements:

  - name: current_coming_soon_lists
    title: Current Coming Soon Lists
    type: table
    model: finery_data
    explore: coming_soon_email_lists
    dimensions: [option_info.option, coming_soon_email_lists.sku]
    measures: [coming_soon_email_lists.list_members]
    sorts: [coming_soon_email_lists.list_members desc]
    limit: 500
    show_view_names: false
    show_row_numbers: false
    truncate_column_names: false
    table_theme: editable
    limit_displayed_rows: false
    height: 4
    width: 4
    top: 0
    left: 0

  - name: coming_soon_channel_performance
    title: Coming Soon Channel Performance
    type: looker_column
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_week]
    measures: [sessions.sum_gross_revenue_ex_discount, sessions.count]
    filters:
      coming_soon_emails.email_description: -NULL
      session_start_calendar.calendar_date_date: before today
      session_start_calendar.calendar_date_week: after 2016/04/11
    sorts: [session_start_calendar.calendar_date_week]
    limit: 20
    stacking: ''
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
      '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    show_value_labels: false
    label_density: 25
    hide_legend: true
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    series_colors:
      sessions.sum_gross_revenue_ex_discount: blue
      sessions.count: lightpink
    series_types:
      sessions.sum_gross_revenue_ex_discount: line
      sessions.count: column
    limit_displayed_rows: false
    y_axis_combined: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: true
    x_axis_label: Week
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    y_axis_orientation: [left, right]
    show_null_labels: false
    height: 4
    width: 8
    top: 0
    left: 4

  - name: coming_soon_email_performance
    title: Coming Soon Email Performance
    type: table
    model: finery_data
    explore: sessions
    dimensions: [coming_soon_emails.email_sent_date, coming_soon_emails.option_name,
      coming_soon_emails.emails_sent, coming_soon_emails.unique_opens, coming_soon_emails.campaign_open_rate,
      coming_soon_emails.unique_clicks, coming_soon_emails.campaign_click_rate, coming_soon_emails.campaign_click_through_rate]
    measures: [sessions.count, sessions.sum_orders, sessions.conversion_rate, sessions.sum_gross_revenue_ex_discount]
    filters:
      coming_soon_emails.email_description: -NULL
      coming_soon_emails.email_type: Coming Soon Notification
    sorts: [coming_soon_emails.email_sent_date desc]
    limit: 20
    show_view_names: false
    show_row_numbers: false
    truncate_column_names: false
    series_labels:
      coming_soon_emails.email_sent_date: Date
      coming_soon_emails.option_name: Option
      sessions.count: Visits
      sessions.sum_orders: Orders
      sessions.sum_gross_revenue_ex_discount: Revenue
    table_theme: editable
    limit_displayed_rows: false
    height: 6
    width: 12
    top: 4
    left: 0

  - name: coming_soon_reminder_performance
    title: Coming Soon Reminder Performance
    type: table
    model: finery_data
    explore: sessions
    dimensions: [coming_soon_emails.email_sent_date, coming_soon_emails.option_name,
      coming_soon_emails.emails_sent, coming_soon_emails.unique_opens, coming_soon_emails.campaign_open_rate,
      coming_soon_emails.unique_clicks, coming_soon_emails.campaign_click_rate, coming_soon_emails.campaign_click_through_rate]
    measures: [sessions.count, sessions.sum_orders, sessions.conversion_rate, sessions.sum_gross_revenue_ex_discount]
    filters:
      coming_soon_emails.email_description: -NULL
      coming_soon_emails.email_type: No Purchase Reminder,No Open Reminder
    sorts: [coming_soon_emails.email_sent_date desc]
    limit: 20
    show_view_names: false
    show_row_numbers: false
    truncate_column_names: false
    series_labels:
      coming_soon_emails.email_sent_date: Date
      coming_soon_emails.option_name: Option
      sessions.count: Visits
      sessions.sum_orders: Orders
      sessions.sum_gross_revenue_ex_discount: Revenue
    table_theme: editable
    limit_displayed_rows: false
    height: 6
    width: 12
    top: 10
    left: 0
