- dashboard: email_marketing_dashboard
  title: Email Marketing Dashboard
  layout: tile
  tile_size: 100

#  filters:

  elements:

  - name: crm_sub_channel_performance_l8w
    title: CRM Sub-Channel Performance - Last 8 Weeks
    type: table
    model: finery_data
    explore: sessions
    dimensions: [sessions.crm_sub_channel, sessions.start_week]
    pivots: [sessions.crm_sub_channel]
    fill_fields: [sessions.start_week]
    measures: [sessions.count, sessions.sum_orders, sessions.conversion_rate]
    dynamic_fields:
    - table_calculation: visits
      label: Visits
      expression: ${sessions.count}
      value_format:
      value_format_name: decimal_0
    - table_calculation: visits_wow
      label: Visits WoW
      expression: |-
        concat(
          if((${sessions.count} - offset(${sessions.count}, -1))/offset(${sessions.count}, -1) > 0,
            "✔️ ",
            if ((${sessions.count} - offset(${sessions.count}, -1))/offset(${sessions.count}, -1) < 0,
              "✖️", " "
              )
              ), " ", concat(round(100 * ((${sessions.count} - offset(${sessions.count}, -1))/offset(${sessions.count}, -1)), 0), "%")
        )
      value_format:
      value_format_name: percent_0
    - table_calculation: orders
      label: Orders
      expression: ${sessions.sum_orders}
      value_format:
      value_format_name: decimal_0
    - table_calculation: orders_wow
      label: Orders WoW
      expression: |-
        concat(
          if((${sessions.sum_orders} - offset(${sessions.sum_orders}, -1))/offset(${sessions.sum_orders}, -1) > 0,
            "✔️ ",
            if ((${sessions.sum_orders} - offset(${sessions.sum_orders}, -1))/offset(${sessions.sum_orders}, -1) < 0,
              "✖️", " "
              )
              ), " ", concat(round(100 * ((${sessions.sum_orders} - offset(${sessions.sum_orders}, -1))/offset(${sessions.sum_orders}, -1)), 0), "%")
        )
      value_format:
      value_format_name: percent_0
    - table_calculation: conversion_rate
      label: Conversion Rate
      expression: ${sessions.conversion_rate}
      value_format:
      value_format_name: percent_1
    - table_calculation: conversion_rate_wow
      label: Conversion Rate WoW
      expression: |-
        concat(
          if((${sessions.conversion_rate} - offset(${sessions.conversion_rate}, -1))/offset(${sessions.conversion_rate}, -1) > 0,
            "✔️ ",
            if ((${sessions.conversion_rate} - offset(${sessions.conversion_rate}, -1))/offset(${sessions.conversion_rate}, -1) < 0,
              "✖️", " "
              )
              ), " ", concat(round(100 * ((${sessions.conversion_rate} - offset(${sessions.conversion_rate}, -1))/offset(${sessions.conversion_rate}, -1)), 0), "%")
        )
      value_format:
      value_format_name: percent_0
    filters:
      sessions.acquisition_channel: CRM
      sessions.start_week: 8 weeks ago for 8 weeks
    sorts: [sessions.start_week, sessions.crm_sub_channel]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
    show_view_names: false
    show_row_numbers: false
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: gray
    limit_displayed_rows: false
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
    series_types: {}
    hidden_fields: [sessions.count, sessions.sum_orders, sessions.conversion_rate]

