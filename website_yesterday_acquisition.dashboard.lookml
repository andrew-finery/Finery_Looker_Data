- dashboard: website_yesterday_acquisition
  title: Website Yesterday Acquisition
  layout: static
  tile_size: 50
  show_applied_filters: true

  filters:
  
  - name: select_channel
    title: "Channel"
    type: field_filter
    explore: atomic_events
    field: sessions.acquisition_channel
    default_value: Search

  elements:

  - name: summary_by_channel
    title: Yesterday's Summary by Acquisition Channel
    type: table
    model: finery_data
    explore: atomic_events
    dimensions: [sessions.acquisition_channel]
    measures: [atomic_events.conversion_rate_yesterday, atomic_events.conversion_rate_last_week, atomic_events.conversion_rate_wow, atomic_events.count_sessions_yesterday, atomic_events.count_sessions_last_week, atomic_events.sessions_wow, transactions.count_transactions_yesterday, transactions.count_transactions_last_week, atomic_events.orders_wow, atomic_events.sum_revenue_yesterday, atomic_events.sum_revenue_last_week, atomic_events.revenue_wow, atomic_events.bounce_rate_yesterday, atomic_events.bounce_rate_last_week, atomic_events.bounce_rate_wow, atomic_events.engagement_rate_yesterday, atomic_events.engagment_rate_last_week, atomic_events.engagement_rate_wow]
    sorts: [atomic_events.count_sessions_yesterday desc]
    total: true
    height: 8
    width: 26
    top: 0
    left: 0

  - name: dashboard_note
    type: single_value
    title: ' '
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.dashboard_title_1]
    font_size: small
    height: 2
    width: 26
    top: 8
    left: 0

  - name: summary_by_hour
    title: Summary by Hour - Yesterday
    type: looker_line
    model: finery_data
    explore: atomic_events
    dimensions: [atomic_events.event_time_hour_of_day]
    measures: [atomic_events.count_sessions, transactions.count_transactions]
    listen:
      select_channel: sessions.acquisition_channel
    filters:
      atomic_events.event_time_date: yesterday
    sorts: [atomic_events.event_time_hour_of_day]
    limit: 500
    total: false
    show_null_points: false
    interpolation: monotone
    show_value_labels: false
    show_view_names: false
    colors: [orange, purple]
    point_style: none
    hide_legend: true
    x_axis_gridlines: true
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_label: Hour of Day
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_labels: [Sessions, Orders]
    y_axis_orientation: [left, right]
    stacking: ''
    x_axis_scale: auto
    height: 6
    width: 8
    top: 10
    left: 0


