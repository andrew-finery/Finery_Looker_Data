- dashboard: facebook_buyers_and_non_buyers
  title: Facebook Buyers and Non Buyers
  layout: static
  tile_size: 100

  filters:

  elements:

  - name: facebook_spend
    title: Facebook Spend
    model: finery_data
    explore: facebook_api_ad_performance
    type: table
    fields: [facebook_api_ad_performance.total_spend_including_smartly_commission_yesterday,
      facebook_api_ad_performance.total_spend_including_smartly_commission_lw, facebook_api_ad_performance.total_spend_including_smartly_commission_wow,
      facebook_api_ad_performance.total_spend_including_smartly_commission_l3d_average,
      facebook_api_ad_performance.total_spend_including_smartly_commission_l3d_vs_yesterday,
      facebook_api_ad_performance.total_spend_including_smartly_commission_l7d_average,
      facebook_api_ad_performance.total_spend_including_smartly_commission_l7d_vs_yesterday]
    limit: 500
    column_limit: 50
    show_view_names: true
    show_row_numbers: false
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
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
    series_types: {}

