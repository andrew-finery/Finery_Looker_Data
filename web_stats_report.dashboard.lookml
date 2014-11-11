- dashboard: web_stats_report
  title: Web Stats Report
  layout: tile
  tile_size: 100

  filters:
  - name: date
    title: "Date"
    type: date_filter
    default_value: 7 Days

  
  
  elements:
  - name: add_a_unique_name_65
    title: Untitled Visualization
    type: single_value
    base_view: sessions
    measures: [sessions.bounce_rate]
    sorts: [sessions.bounce_rate desc]
    empty_color: [red]
    limit: 500
    show_null_labels: false

  - name: web_stats_by_device
    title: Web Stats by Device
    type: table
    base_view: sessions
    dimensions: [sessions.device_type]
    measures: [sessions.count, visitors.count, sessions.average_pages_per_session, sessions.average_session_duration_seconds,
    sessions.bounce_rate, sessions.new_visitors_count_over_total_visitors_count]
    listen:
     date: sessions.start_date
    sorts: [sessions.count desc]
    limit: 500
    width: 7
    height: 2

  - name: web_stats_by_browser
    title: Web Stats by Browser
    type: table
    base_view: sessions
    dimensions: [sessions.browser]
    measures: [sessions.count, visitors.count, sessions.average_pages_per_session, sessions.average_session_duration_seconds,
    sessions.bounce_rate, sessions.new_visitors_count_over_total_visitors_count]
    listen:
     date: sessions.start_date
    sorts: [sessions.count desc]
    limit: 500
    width: 7
    height: 4
  
  - name: visits_by_day
    title: Visits
    type: looker_line
    base_view: sessions
    dimensions: [sessions.start_date]
    measures: [sessions.count, sessions.sessions_from_new_visitors_count]
    listen:
     date: sessions.start_date
    series_labels:
     "sessions.count": "Total"
     "sessions.sessions_from_new_visitors_count": "New Visitors"
    colors: [red, blue]
    sorts: [sessions.start_date desc]
    limit: 500
    show_null_labels: false
    show_null_points: true
    point_style: circle
    x_axis_scale: ordinal
    y_axis_combined: true
    y_axis_labels: "Visits"
    interpolation: linear
    width: 8
    height: 3

  
