- dashboard: marketing_report_weekly
  title: Marketing Report Weekly
  layout: static
  tile_size: 100


  elements:
  - name: visits_chart
    title: Visits - Last Week
    model: finery_data
    explore: sessions
    type: looker_pie
    fields: [sessions.count, sessions.channel_grouping_3]
    fill_fields: [sessions.channel_grouping_3]
    filters:
      session_start_calendar.calendar_date_week: 1 weeks ago for 1 weeks
    sorts: [sessions.count desc]
    limit: 500
    column_limit: 50
    value_labels: labels
    label_type: labPer
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
    series_types: {}
    inner_radius: 0
    colors: ["#62bad4", "#a9c574", "#929292", "#9fdee0", "#1f3e5a", "#90c8ae", "#875876",
      "#c5c6a6", "#82c2ca", "#cee0a0", "#928fb4", "#9fc190"]
    series_colors: {}
    width: 6
    height: 6
    top: 0
    left: 0


  - name: revenue_chart
    title: Revenue - Last Week
    model: finery_data
    explore: sessions
    type: looker_pie
    fields: [sessions.channel_grouping_3, sessions.sum_gross_revenue_ex_discount]
    fill_fields: [sessions.channel_grouping_3]
    filters:
      session_start_calendar.calendar_date_week: 1 weeks ago for 1 weeks
    sorts: [sessions.sum_gross_revenue_ex_discount desc]
    limit: 500
    column_limit: 50
    value_labels: labels
    label_type: labPer
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
    series_types: {}
    inner_radius: 0
    colors: ["#62bad4", "#a9c574", "#929292", "#9fdee0", "#1f3e5a", "#90c8ae", "#875876",
      "#c5c6a6", "#82c2ca", "#cee0a0", "#928fb4", "#9fc190"]
    series_colors: {}
    width: 6
    height: 6
    top: 0
    left: 6


  - name: orders_chart
    title: Orders - Last Week
    model: finery_data
    explore: sessions
    type: looker_pie
    fields: [sessions.channel_grouping_3, sessions.sum_orders]
    fill_fields: [sessions.channel_grouping_3]
    filters:
      session_start_calendar.calendar_date_week: 1 weeks ago for 1 weeks
    sorts: [sessions.sum_orders desc]
    limit: 500
    column_limit: 50
    value_labels: labels
    label_type: labPer
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
    series_types: {}
    inner_radius: 0
    colors: ["#62bad4", "#a9c574", "#929292", "#9fdee0", "#1f3e5a", "#90c8ae", "#875876",
      "#c5c6a6", "#82c2ca", "#cee0a0", "#928fb4", "#9fc190"]
    series_colors: {}
    width: 6
    height: 6
    top: 6
    left: 3


  - name: kpi_performance
    title: KPI Performance - Last Week
    model: finery_data
    explore: sessions
    type: table
    fields: [sessions.channel_grouping_3, sessions.count, sessions.sum_gross_revenue_ex_discount,
      sessions.sum_orders, sessions.conversion_rate, sessions.average_basket_size]
    fill_fields: [sessions.channel_grouping_3]
    filters:
      session_start_calendar.calendar_date_date: 1 weeks ago for 1 weeks
    sorts: [sessions.sum_gross_revenue_ex_discount desc]
    limit: 500
    column_limit: 50
    total: true
    show_view_names: false
    show_row_numbers: false
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    value_labels: legend
    label_type: labPer
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    series_labels:
      sessions.orders_yesterday: Orders
      sessions.visits_yesterday: Visits
      sessions.conversion_yesterday: Conversion Rate
      sessions.average_basket_ex_discount_yesterday: Average Basket Size
    width: 12
    height: 3
    top: 12
    left: 0


  - name: facebook_spend_graph
    title: Facebook Spend (26 Weeks)
    model: finery_data
    explore: facebook_api_ad_performance
    type: looker_area
    fields: [facebook_api_ad_performance.total_spend, facebook_api_ad_performance.calendar_week]
    fill_fields: [facebook_api_ad_performance.calendar_week]
    filters:
      facebook_api_ad_performance.calendar_date: 30 weeks ago for 30 weeks
    sorts: [facebook_api_ad_performance.calendar_week desc]
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
    show_y_axis_labels: false
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    ordering: none
    show_null_labels: false
    series_types: {}
    y_axes: [{label: Total Spend, maxValue: !!null '', minValue: !!null '', orientation: left,
        showLabels: false, showValues: true, tickDensity: default, tickDensityCustom: 5,
        type: linear, unpinAxis: false, valueFormat: !!null '', series: [{id: facebook_api_ad_performance.total_spend,
            name: Facebook API Ad Performance Total Spend, axisId: facebook_api_ad_performance.total_spend,
            __FILE: finery_data/marketing_report.dashboard.lookml, __LINE_NUM: 240}],
        __FILE: finery_data/marketing_report.dashboard.lookml, __LINE_NUM: 238}]
    x_axis_label: Calendar Date
    width: 12
    height: 4
    top: 15
    left: 0
