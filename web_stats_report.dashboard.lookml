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
