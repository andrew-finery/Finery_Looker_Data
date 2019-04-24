- dashboard: weekly_dashboard
  title: Weekly Dashboard
  layout: newspaper


  elements:

  - name: traffic_last_week
    title: Traffic Last Week
    model: finery_data
    explore: sessions
    type: single_value
    fields: [sessions.count]
    filters:
      session_start_calendar.calendar_date_date: 1 weeks ago for 1 weeks
    limit: 500
    column_limit: 50
    query_timezone: Europe/London
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    single_value_title: Traffic Last Week
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    series_types: {}
    height: 6
    width: 6


  - name: total_orders
    title: Orders
    model: finery_data
    explore: spree_order_items
    type: single_value
    fields: [spree_orders.count_orders]
    filters:
      calendar_weeks.calendar_date_date: 1 weeks ago for 1 weeks
    limit: 500
    query_timezone: Europe/London
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    single_value_title: Total Orders Last week
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    series_types: {}
    height: 6
    width: 6
    col: 6


  - name: add_a_unique_name_1556121909
    title: Untitled Visualization
    model: finery_data
    explore: sessions
    type: single_value
    fields: [sessions.conversion_rate]
    filters:
      session_start_calendar.calendar_date_date: 1 weeks ago for 1 weeks
    limit: 500
    column_limit: 50
    query_timezone: Europe/London
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    single_value_title: Conversion Rate Last Week
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    series_types: {}
    height: 6
    width: 6
    col: 12


  - name: aov_last_week
    title: AOV Last Week
    model: finery_data
    explore: spree_order_items
    type: single_value
    fields: [spree_orders.avg_gross_revenue_ex_discount_in_gbp]
    filters:
      calendar_weeks.calendar_date_date: 1 weeks ago for 1 weeks
    limit: 500
    dynamic_fields:
    - table_calculation: calculation_1
      label: Calculation 1
      expression: "${spree_orders.avg_gross_revenue_ex_discount_in_gbp}"
      value_format:
      value_format_name: gbp_0
      _kind_hint: measure
      _type_hint: number
    query_timezone: Europe/London
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    single_value_title: AOV Last Week
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    series_types: {}
    height: 6
    width: 6
    col: 18



  - name: new_customers_yoy
    title: New Customers
    model: finery_data
    explore: spree_orders
    type: looker_area
    fields: [spree_orders.count_new_customers_ytd, calendar_weeks.week_number, spree_orders.count_new_customers_ytd_ly]
    filters:
      spree_orders.count_new_customers_ytd_ly: not 0
    sorts: [calendar_weeks.week_number]
    limit: 500
    color_application:
      collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
      custom:
        id: 6efd826c-c970-65a7-e409-c28776430cb6
        label: Custom
        type: continuous
        stops:
        - color: "#c73011"
          offset: 0
        - color: "#2344c7"
          offset: 100
      options:
        steps: 5
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    y_axes: [{label: '', orientation: left, series: [{axisId: spree_orders.count_new_customers_ytd,
            id: spree_orders.count_new_customers_ytd, name: New Customers YTD}, {axisId: spree_orders.count_new_customers_ytd_ly,
            id: spree_orders.count_new_customers_ytd_ly, name: New Customers YTD LY}],
        showLabels: true, showValues: true, unpinAxis: true, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    limit_displayed_rows_values:
      show_hide: hide
      first_last: last
      num_rows: '20'
    hidden_series: []
    legend_position: center
    series_types: {}
    point_style: circle_outline
    series_colors: {}
    series_labels:
      spree_orders.count_new_customers_ytd: '2019'
      spree_orders.count_new_customers_ytd_ly: '2018'
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    trend_lines: []
    swap_axes: false
    show_null_points: false
    interpolation: monotone
    discontinuous_nulls: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    width: 12
    height: 8


  - name: customer_second_order_yoy
    title: Customer Placed Second Order
    model: finery_data
    explore: spree_orders
    type: looker_area
    fields: [calendar_weeks.week_number, spree_orders.count_second_order_customers_ytd,
      spree_orders.count_second_order_customers_ytd_ly]
    filters:
      spree_orders.count_new_customers_ytd_ly: not 0
    sorts: [calendar_weeks.week_number]
    limit: 500
    color_application:
      collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
      custom:
        id: a7e7dba4-ed36-8c11-342e-e8fd09c16da1
        label: Custom
        type: continuous
        stops:
        - color: "#46c73b"
          offset: 0
        - color: "#bb6bc7"
          offset: 100
      options:
        steps: 5
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    y_axes: [{label: '', orientation: left, series: [{axisId: spree_orders.count_second_order_customers_ytd,
            id: spree_orders.count_second_order_customers_ytd, name: Second Purchase
              Customers YTD}, {axisId: spree_orders.count_second_order_customers_ytd_ly,
            id: spree_orders.count_second_order_customers_ytd_ly, name: Second Purchase
              Customers YTD LY}], showLabels: true, showValues: true, unpinAxis: true,
        tickDensity: default, type: linear}]
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    limit_displayed_rows_values:
      show_hide: hide
      first_last: last
      num_rows: '20'
    hidden_series: []
    legend_position: center
    series_types: {}
    point_style: circle_outline
    series_colors: {}
    series_labels:
      spree_orders.count_new_customers_ytd: '2019'
      spree_orders.count_new_customers_ytd_ly: '2018'
      spree_orders.count_second_order_customers_ytd: '2019'
      spree_orders.count_second_order_customers_ytd_ly: '2018'
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    trend_lines: []
    swap_axes: false
    show_null_points: false
    interpolation: monotone
    discontinuous_nulls: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    col: 12
    width: 12
    height: 8


