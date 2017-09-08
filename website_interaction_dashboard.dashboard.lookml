- dashboard: website_interaction_dashboard
  title: Website Interaction Dashboard
  layout: tile
  tile_size: 100

  filters:

  elements:
    - name: page_views_per_visit
      title: Page Views Per Visit
      model: finery_data
      explore: website_page_views
      type: looker_column
      fields: [visits.start_week, visits.page_views_per_visit]
      fill_fields: [visits.start_week]
      filters:
        visits.start_week: 2 weeks ago for 2 weeks
      sorts: [visits.start_week desc]
      limit: 500
      column_limit: 50
      stacking: ''
      show_value_labels: false
      label_density: 25
      legend_position: center
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_view_names: true
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
      ordering: none
      show_null_labels: false
      show_totals_labels: false
      show_silhouette: false
      totals_color: "#808080"
      show_row_numbers: true
      truncate_column_names: false
      hide_totals: false
      hide_row_totals: false
      table_theme: editable
      enable_conditional_formatting: false
      conditional_formatting_ignored_fields: []
      conditional_formatting_include_totals: false
      conditional_formatting_include_nulls: false
      show_null_points: true
      point_style: circle
      interpolation: linear
      series_types: {}
