- dashboard: yearly_report
  title: Yearly Report
  layout: static
  tile_size: 100


  elements:
  - name: traffic_ytd
    title: Traffic
    model: finery_data
    explore: sessions
    type: looker_area
    fields: [sessions.visits_year_to_date, sessions.visits_year_to_date_last_year, session_start_calendar.calendar_date_month_num]
    fill_fields: [session_start_calendar.calendar_date_month_num]
    sorts: [session_start_calendar.calendar_date_month_num]
    limit: 500
    query_timezone: Europe/London
    stacking: ''
    colors: ["#5245ed", "#ed6168", "#1ea8df", "#353b49", "#49cec1", "#b3a0dd", "#db7f2a",
      "#706080", "#a2dcf3", "#776fdf", "#e9b404", "#635189"]
    show_value_labels: false
    label_density: 25
    legend_position: center
    hide_legend: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    point_style: none
    series_colors: {}
    series_types: {}
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    show_null_points: false
    interpolation: linear
    discontinuous_nulls: true
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    height: 4
    width: 12
    top: 0
    left: 0
