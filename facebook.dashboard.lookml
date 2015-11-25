- dashboard: facebook
  title: Facebook
  layout: tile
  tile_size: 100

#  filters:

  elements:

  - name: Impressions
    title: Impressions /Day
    type: looker_line
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_date]
    measures: [facebook_daily_ad_performance.sum_impressions]
    sorts: [facebook_daily_ad_performance.sum_impressions desc]
    limit: 500
    show_view_names: true
    value_labels: legend
    label_type: labPer
    show_null_points: true
    point_style: circle
    font_size: medium
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 3
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    show_row_numbers: true
    ordering: none
    show_null_labels: false
    interpolation: monotone
    swap_axes: false
    hide_legend: false
