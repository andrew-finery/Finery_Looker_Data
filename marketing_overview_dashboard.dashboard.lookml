- dashboard: marketing_overview_dashboard
  title: Marketing Overview Dashboard
  layout: static
  show_applied_filters: true
  tile_size: 100

  filters:
  - name: date
    title: "Date Filter"
    type: date_filter
    default_value: 7 days ago for 7 days

  elements:

  - name: facebook_campaigns_users
    title: Facebook Campaigns - Users on Website
    type: looker_line
    model: finery_data
    explore: atomic_events
    dimensions: [atomic_events.event_time_date, sessions_source.campaign_name]
    pivots: [sessions_source.campaign_name]
    measures: [atomic_events.count_users]
    listen:
     date: atomic_events.event_time_date
    filters:
      sessions_source.campaign_medium: '"paid"'
      sessions_source.campaign_name: -NULL
      sessions_source.campaign_source: '"facebook"'
    sorts: [atomic_events.event_time_date desc]
    limit: 500
    total: false
    show_null_points: true
    stacking: normal
    show_value_labels: false
    show_view_names: false
    swap_axes: false
    point_style: circle
    hide_legend: false
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_gridlines: true
    x_axis_scale: auto
    x_axis_label: Date
    x_axis_datetime_label: '%a %d %b'
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_gridlines: true
    y_axis_labels: []
    y_axis_combined: false
    interpolation: linear
    x_axis_datetime_tick_count: 7
    width: 7
    height: 3
    top: 4
    left: 5


  
