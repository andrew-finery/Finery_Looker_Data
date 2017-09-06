- dashboard: international_performance_dashboard
  title: International Performance Dashboard
  layout: static
  tile_size: 100

  filters:

  elements:

  - name: uk_performance_last_1_weeks
    title: UK Performance - Yesterday
    model: finery_data
    explore: spree_orders
    type: table
    fields: [spree_addresses.country, spree_orders.count_orders, spree_orders.sum_gross_revenue_ex_discount_in_gbp,
      spree_orders.avg_gross_revenue_ex_discount_in_gbp]
    filters:
      spree_addresses.country: United Kingdom
      spree_orders.completed_date: 1 days ago for 1 days
    sorts: [spree_orders.count_orders desc]
    limit: 100
    column_limit: 50
    total: true
    dynamic_fields:
    - table_calculation: revenue_mix
      label: Revenue mix
      expression: "${spree_orders.sum_gross_revenue_ex_discount_in_gbp}/sum(${spree_orders.sum_gross_revenue_ex_discount_in_gbp})"
      value_format:
      value_format_name: percent_1
      _kind_hint: measure
    show_view_names: false
    show_row_numbers: true
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
    show_null_points: true
    point_style: none
    interpolation: linear
    query_timezone: Europe/London
    series_types: {}
