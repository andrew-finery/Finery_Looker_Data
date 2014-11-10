- dashboard: web_stats_report
  title: Web Stats Report
  layout: tile
  tile_size: 100

#  filters:

  elements:
  - name: add_a_unique_name_280
    title: Untitled Visualization
    type: looker_line
    base_view: sessions
    dimensions: [sessions.start_date]
    measures: [sessions.count, sessions.sessions_from_new_visitors_count]
    filters:
     sessions.start_date: 7 days
    sorts: [sessions.start_date desc]
    limit: 500
    show_null_labels: false
    show_null_points: true
    point_style: circle
    hide_legend: false
    stacking: ''
    x_axis_scale: auto
    interpolation: linear

  - name: add_a_unique_name_104
    title: Untitled Table
    type: table
    base_view: sessions
    dimensions: [sessions.browser]
    measures: [sessions.count, visitors.count, sessions.average_pages_per_session, sessions.average_session_duration_seconds,
    sessions.bounce_rate, sessions.new_visitors_count_over_total_visitors_count, sessions.sessions_from_new_visitors_count]
    sorts: [sessions.count desc]
    limit: 500
