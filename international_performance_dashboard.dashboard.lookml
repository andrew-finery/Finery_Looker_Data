- dashboard: international_performance_dashboard
  title: International Performance Dashboard
  layout: static
  tile_size: 100

  elements:

  - name: revenue_all
    title: Revenue By Location
    model: finery_data
    explore: spree_orders
    type: table
    fields: [spree_addresses.country_group, spree_orders.revenue_yesterday, spree_orders.gross_cogs_yesterday,
      spree_orders.gross_cogs_year_to_date, spree_orders.revenue_yesterday_last_week,
      spree_orders.revenue_yesterday_week_on_week, spree_orders.revenue_yesterday_last_year,
      spree_orders.revenue_yesterday_year_on_year, spree_orders.revenue_month_to_date,
      spree_orders.revenue_month_to_date_month_on_month, spree_orders.revenue_year_to_date,
      spree_orders.revenue_year_to_date_last_year, spree_orders.revenue_year_to_date_year_on_year]
    sorts: [spree_orders.revenue_yesterday desc]
    limit: 100
    column_limit: 50
    total: true
    dynamic_fields:
    - table_calculation: of_total_revenue_yest
      label: "% of Total Revenue Yest."
      expression: "${spree_orders.revenue_yesterday}/sum(${spree_orders.revenue_yesterday})"
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
    - table_calculation: gross_margin_ytd
      label: "% Gross Margin YTD"
      expression: "(${spree_orders.revenue_year_to_date}-${spree_orders.gross_cogs_year_to_date})/${spree_orders.revenue_year_to_date}"
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
    - table_calculation: gross_revenue_mix_ytd
      label: Gross Revenue mix YTD
      expression: "${spree_orders.revenue_year_to_date}/sum(${spree_orders.revenue_year_to_date})"
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
    - table_calculation: gross_profit_mix_ytd
      label: Gross Profit Mix YTD %
      expression: "(${spree_orders.revenue_year_to_date}-${spree_orders.gross_cogs_year_to_date})/sum(${spree_orders.revenue_year_to_date}-${spree_orders.gross_cogs_year_to_date})"
      value_format:
      value_format_name: percent_0
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
    hidden_fields: [spree_orders.gross_cogs_yesterday, spree_orders.gross_cogs_year_to_date]
    width: 12
    height: 3
    top: 0
    left: 0


  - name: other_revenue_breakdown
    title: Revenue Breakdown - (Not UK/US/Ireland)
    model: finery_data
    explore: spree_orders
    type: table
    fields: [spree_orders.revenue_yesterday, spree_orders.gross_cogs_yesterday, spree_orders.gross_cogs_year_to_date,
      spree_orders.revenue_yesterday_last_week, spree_orders.revenue_yesterday_week_on_week,
      spree_orders.revenue_yesterday_last_year, spree_orders.revenue_yesterday_year_on_year,
      spree_orders.revenue_month_to_date, spree_orders.revenue_month_to_date_month_on_month,
      spree_orders.revenue_year_to_date, spree_orders.revenue_year_to_date_last_year,
      spree_orders.revenue_year_to_date_year_on_year, spree_addresses.country]
    filters:
      spree_addresses.country: "-United Kingdom,-United States,-Ireland"
    sorts: [spree_orders.revenue_yesterday desc]
    limit: 100
    column_limit: 50
    total: true
    dynamic_fields:
    - table_calculation: of_total_revenue_yest
      label: "% of Total Revenue Yest."
      expression: "${spree_orders.revenue_yesterday}/sum(${spree_orders.revenue_yesterday})"
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
    - table_calculation: gross_margin_ytd
      label: "% Gross Margin YTD"
      expression: "(${spree_orders.revenue_year_to_date}-${spree_orders.gross_cogs_year_to_date})/${spree_orders.revenue_year_to_date}"
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
    - table_calculation: gross_revenue_mix_ytd
      label: Gross Revenue mix YTD
      expression: "${spree_orders.revenue_year_to_date}/sum(${spree_orders.revenue_year_to_date})"
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
    - table_calculation: gross_profit_mix_ytd
      label: Gross Profit Mix YTD %
      expression: "(${spree_orders.revenue_year_to_date}-${spree_orders.gross_cogs_year_to_date})/sum(${spree_orders.revenue_year_to_date}-${spree_orders.gross_cogs_year_to_date})"
      value_format:
      value_format_name: percent_0
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
    hidden_fields: [spree_orders.gross_cogs_yesterday, spree_orders.gross_cogs_year_to_date]
    width: 12
    height: 7
    top: 3
    left: 0


  - name: average_basket__by_location
    title: Average Basket Size By Location
    model: finery_data
    explore: spree_orders
    type: table
    fields: [spree_addresses.country_group, spree_orders.basket_yesterday, spree_orders.basket_yesterday_last_week,
      spree_orders.basket_yesterday_wow, spree_orders.basket_yesterday_last_year, spree_orders.basket_yesterday_yoy,
      spree_orders.basket_month_to_date, spree_orders.basket_month_to_date_last_month,
      spree_orders.basket_month_to_date_mom, spree_orders.basket_month_to_date_last_year,
      spree_orders.basket_month_to_date_yoy, spree_orders.basket_year_to_date, spree_orders.basket_year_to_date_last_year,
      spree_orders.basket_year_to_date_yoy]
    sorts: [spree_orders.basket_yesterday desc]
    limit: 100
    column_limit: 50
    total: true
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
    width: 12
    height: 3
    top: 10
    left: 0


  - name: uk_revenue_graph_last_30_days
    title: UK Revenue - Last 30 Days
    model: finery_data
    explore: spree_orders
    type: looker_line
    fields: [calendar_weeks.calendar_date_date, spree_orders.sum_gross_revenue_ex_discount_in_gbp]
    fill_fields: [calendar_weeks.calendar_date_date]
    filters:
      calendar_weeks.calendar_date_date: 30 days ago for 30 days
      spree_addresses.country: United Kingdom
      spree_orders.completed_date: before 0 days ago
    sorts: [calendar_weeks.calendar_date_date]
    limit: 100
    column_limit: 50
    total: true
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
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
    show_null_points: true
    point_style: none
    interpolation: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    query_timezone: Europe/London
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    hidden_series: [2017-07 - Spree Orders Gross Revenue ex. Voucher, 2017-07 - Spree
        Orders Avg Basket Size ex. Voucher, 2017-07 - Revenue mix, 2017-08 - Spree Orders
        Orders, 2017-08 - Spree Orders Gross Revenue ex. Voucher, 2017-08 - Spree Orders
        Avg Basket Size ex. Voucher, 2017-08 - Revenue mix]
    hide_legend: false
    y_axes: [{label: '', maxValue: !!null '', minValue: !!null '', orientation: left,
        showLabels: true, showValues: true, tickDensity: default, tickDensityCustom: 5,
        type: linear, unpinAxis: false, valueFormat: '"£"###,"k"', series: [{id: spree_orders.sum_gross_revenue_ex_discount_in_gbp,
            name: Gross Revenue ex. Voucher}]}]
    width: 12
    height: 4
    top: 13
    left: 0


  - name: ie_us_revenue_graph_last_30_days
    title: Ireland & US Revenue - Last 30 Days
    model: finery_data
    explore: spree_orders
    type: looker_line
    fields: [spree_orders.sum_gross_revenue_ex_discount_in_gbp, calendar_weeks.calendar_date_date]
    fill_fields: [calendar_weeks.calendar_date_date]
    filters:
      calendar_weeks.calendar_date_date: 30 days ago for 30 days
      spree_addresses.country: Ireland,United States
    sorts: [calendar_weeks.calendar_date_date desc]
    limit: 100
    column_limit: 50
    total: true
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
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
    show_null_points: true
    point_style: none
    interpolation: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    query_timezone: Europe/London
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    hidden_series: [2017-07 - Spree Orders Gross Revenue ex. Voucher, 2017-07 - Spree
        Orders Avg Basket Size ex. Voucher, 2017-07 - Revenue mix, 2017-08 - Spree Orders
        Orders, 2017-08 - Spree Orders Gross Revenue ex. Voucher, 2017-08 - Spree Orders
        Avg Basket Size ex. Voucher, 2017-08 - Revenue mix]
    hide_legend: false
    y_axes: [{label: '', maxValue: !!null '', minValue: !!null '', orientation: left,
        showLabels: true, showValues: true, tickDensity: default, tickDensityCustom: 5,
        type: linear, unpinAxis: false, valueFormat: '"£"###.0,"k"', series: [{id: spree_orders.sum_gross_revenue_ex_discount_in_gbp,
            name: Gross Revenue ex. Voucher, __FILE: finery_data/international_performance_dashboard.dashboard.lookml,
            __LINE_NUM: 437}], __FILE: finery_data/international_performance_dashboard.dashboard.lookml,
        __LINE_NUM: 435}]
    width: 12
    height: 4
    top: 17
    left: 0



  - name: other_revenue_graph_last_30_days
    title: Other Revenue - Last 30 Days
    model: finery_data
    explore: spree_orders
    type: looker_line
    fields: [spree_orders.sum_gross_revenue_ex_discount_in_gbp, calendar_weeks.calendar_date_date]
    fill_fields: [calendar_weeks.calendar_date_date]
    filters:
      calendar_weeks.calendar_date_date: 30 days ago for 30 days
      spree_addresses.country: "-Ireland,-United States,-United Kingdom"
    sorts: [calendar_weeks.calendar_date_date desc]
    limit: 100
    column_limit: 50
    total: true
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
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
    show_null_points: true
    point_style: none
    interpolation: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    query_timezone: Europe/London
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    hidden_series: [2017-07 - Spree Orders Gross Revenue ex. Voucher, 2017-07 - Spree
        Orders Avg Basket Size ex. Voucher, 2017-07 - Revenue mix, 2017-08 - Spree Orders
        Orders, 2017-08 - Spree Orders Gross Revenue ex. Voucher, 2017-08 - Spree Orders
        Avg Basket Size ex. Voucher, 2017-08 - Revenue mix]
    hide_legend: false
    y_axes: [{label: '', maxValue: !!null '', minValue: !!null '', orientation: left,
        showLabels: true, showValues: true, tickDensity: default, tickDensityCustom: 5,
        type: linear, unpinAxis: false, valueFormat: '"£"###0.0,"k"', series: [{id: spree_orders.sum_gross_revenue_ex_discount_in_gbp,
            name: Gross Revenue ex. Voucher, __FILE: finery_data/international_performance_dashboard.dashboard.lookml,
            __LINE_NUM: 634}], __FILE: finery_data/international_performance_dashboard.dashboard.lookml,
            __LINE_NUM: 632}]
    width: 12
    height: 4
    top: 21
    left: 0



  - name: uk_revenue_graph_last_26_weeks
    title: UK Revenue - Last 26 Weeks
    model: finery_data
    explore: spree_orders
    type: looker_line
    fields: [spree_orders.sum_gross_revenue_ex_discount_in_gbp, calendar_weeks.calendar_date_week]
    fill_fields: [calendar_weeks.calendar_date_week]
    filters:
      calendar_weeks.calendar_date_week: 26 weeks ago for 26 weeks
      spree_addresses.country: United Kingdom
    sorts: [calendar_weeks.calendar_date_week desc]
    limit: 100
    column_limit: 50
    total: true
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
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
    show_null_points: true
    point_style: none
    interpolation: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    query_timezone: Europe/London
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    hidden_series: [2017-07 - Spree Orders Gross Revenue ex. Voucher, 2017-07 - Spree
        Orders Avg Basket Size ex. Voucher, 2017-07 - Revenue mix, 2017-08 - Spree Orders
        Orders, 2017-08 - Spree Orders Gross Revenue ex. Voucher, 2017-08 - Spree Orders
        Avg Basket Size ex. Voucher, 2017-08 - Revenue mix]
    hide_legend: false
    y_axes: [{label: '', maxValue: !!null '', minValue: !!null '', orientation: left,
        showLabels: true, showValues: true, tickDensity: default, tickDensityCustom: 5,
        type: linear, unpinAxis: false, valueFormat: '"£"###,"k"', series: [{id: spree_orders.sum_gross_revenue_ex_discount_in_gbp,
            name: Gross Revenue ex. Voucher, __FILE: finery_data/international_performance_dashboard.dashboard.lookml,
            __LINE_NUM: 305}], __FILE: finery_data/international_performance_dashboard.dashboard.lookml,
        __LINE_NUM: 303}]
    width: 12
    height: 4
    top: 25
    left: 0



  - name: ie_us_revenue_graph_last_26_weeks
    title: Ireland & US Revenue - Last 26 Weeks
    model: finery_data
    explore: spree_orders
    type: looker_line
    fields: [spree_orders.sum_gross_revenue_ex_discount_in_gbp, calendar_weeks.calendar_date_week]
    fill_fields: [calendar_weeks.calendar_date_week]
    filters:
      calendar_weeks.calendar_date_week: 26 weeks ago for 26 weeks
      spree_addresses.country: Ireland,United States
    sorts: [calendar_weeks.calendar_date_week desc]
    limit: 100
    column_limit: 50
    total: true
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
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
    show_null_points: true
    point_style: none
    interpolation: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    query_timezone: Europe/London
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    hidden_series: [2017-07 - Spree Orders Gross Revenue ex. Voucher, 2017-07 - Spree
        Orders Avg Basket Size ex. Voucher, 2017-07 - Revenue mix, 2017-08 - Spree Orders
        Orders, 2017-08 - Spree Orders Gross Revenue ex. Voucher, 2017-08 - Spree Orders
        Avg Basket Size ex. Voucher, 2017-08 - Revenue mix]
    hide_legend: false
    y_axes: [{label: '', maxValue: !!null '', minValue: !!null '', orientation: left,
        showLabels: true, showValues: true, tickDensity: default, tickDensityCustom: 5,
        type: linear, unpinAxis: false, valueFormat: '"£"###,"k"', series: [{id: spree_orders.sum_gross_revenue_ex_discount_in_gbp,
            name: Gross Revenue ex. Voucher}]}]
    width: 12
    height: 4
    top: 29
    left: 0



  - name: other_revenue_graph_last_26_weeks
    title: Other Revenue - Last 26 Weeks
    model: finery_data
    explore: spree_orders
    type: looker_line
    fields: [spree_orders.sum_gross_revenue_ex_discount_in_gbp, calendar_weeks.calendar_date_week]
    fill_fields: [calendar_weeks.calendar_date_week]
    filters:
      calendar_weeks.calendar_date_week: 26 weeks ago for 26 weeks
      spree_addresses.country: "-Ireland,-United States,-United Kingdom"
    sorts: [calendar_weeks.calendar_date_week desc]
    limit: 100
    column_limit: 50
    total: true
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
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
    show_null_points: true
    point_style: none
    interpolation: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    query_timezone: Europe/London
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    hidden_series: [2017-07 - Spree Orders Gross Revenue ex. Voucher, 2017-07 - Spree
        Orders Avg Basket Size ex. Voucher, 2017-07 - Revenue mix, 2017-08 - Spree Orders
        Orders, 2017-08 - Spree Orders Gross Revenue ex. Voucher, 2017-08 - Spree Orders
        Avg Basket Size ex. Voucher, 2017-08 - Revenue mix]
    hide_legend: false
    y_axes: [{label: '', maxValue: !!null '', minValue: !!null '', orientation: left,
        showLabels: true, showValues: true, tickDensity: default, tickDensityCustom: 5,
        type: linear, unpinAxis: false, valueFormat: '"£"###,"k"', series: [{id: spree_orders.sum_gross_revenue_ex_discount_in_gbp,
            name: Gross Revenue ex. Voucher, __FILE: finery_data/international_performance_dashboard.dashboard.lookml,
            __LINE_NUM: 700}], __FILE: finery_data/international_performance_dashboard.dashboard.lookml,
        __LINE_NUM: 698}]
    width: 12
    height: 4
    top: 33
    left: 0



  - name: uk_revenue_graph_last_24_months
    title: UK Revenue - Last 24 Months
    model: finery_data
    explore: spree_orders
    type: looker_line
    fields: [spree_orders.sum_gross_revenue_ex_discount_in_gbp, calendar_weeks.calendar_date_month]
    fill_fields: [calendar_weeks.calendar_date_month]
    filters:
      calendar_weeks.calendar_date_month: 24 months ago for 24 months
      spree_addresses.country: United Kingdom
    sorts: [calendar_weeks.calendar_date_month desc]
    limit: 100
    column_limit: 50
    total: true
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
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
    show_null_points: true
    point_style: none
    interpolation: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    query_timezone: Europe/London
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    hidden_series: [2017-07 - Spree Orders Gross Revenue ex. Voucher, 2017-07 - Spree
        Orders Avg Basket Size ex. Voucher, 2017-07 - Revenue mix, 2017-08 - Spree Orders
        Orders, 2017-08 - Spree Orders Gross Revenue ex. Voucher, 2017-08 - Spree Orders
        Avg Basket Size ex. Voucher, 2017-08 - Revenue mix]
    hide_legend: false
    y_axes: [{label: '', maxValue: !!null '', minValue: !!null '', orientation: left,
        showLabels: true, showValues: true, tickDensity: default, tickDensityCustom: 5,
        type: linear, unpinAxis: false, valueFormat: '"£"###,"k"', series: [{id: spree_orders.sum_gross_revenue_ex_discount_in_gbp,
            name: Gross Revenue ex. Voucher, __FILE: finery_data/international_performance_dashboard.dashboard.lookml,
            __LINE_NUM: 371}], __FILE: finery_data/international_performance_dashboard.dashboard.lookml,
        __LINE_NUM: 369}]
    width: 12
    height: 4
    top: 37
    left: 0



  - name: ie_us_revenue_graph_last_24_months
    title: Ireland & US Revenue - Last 24 Months
    model: finery_data
    explore: spree_orders
    type: looker_line
    fields: [spree_orders.sum_gross_revenue_ex_discount_in_gbp, calendar_weeks.calendar_date_month]
    fill_fields: [calendar_weeks.calendar_date_month]
    filters:
      calendar_weeks.calendar_date_month: 24 months ago for 24 months
      spree_addresses.country: Ireland,United States
    sorts: [calendar_weeks.calendar_date_month desc]
    limit: 100
    column_limit: 50
    total: true
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
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
    show_null_points: true
    point_style: none
    interpolation: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    query_timezone: Europe/London
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    hidden_series: [2017-07 - Spree Orders Gross Revenue ex. Voucher, 2017-07 - Spree
        Orders Avg Basket Size ex. Voucher, 2017-07 - Revenue mix, 2017-08 - Spree Orders
        Orders, 2017-08 - Spree Orders Gross Revenue ex. Voucher, 2017-08 - Spree Orders
        Avg Basket Size ex. Voucher, 2017-08 - Revenue mix]
    hide_legend: false
    y_axes: [{label: '', maxValue: !!null '', minValue: !!null '', orientation: left,
        showLabels: true, showValues: true, tickDensity: default, tickDensityCustom: 5,
        type: linear, unpinAxis: false, valueFormat: '"£"###,"k"', series: [{id: spree_orders.sum_gross_revenue_ex_discount_in_gbp,
            name: Gross Revenue ex. Voucher, __FILE: finery_data/international_performance_dashboard.dashboard.lookml,
            __LINE_NUM: 371}], __FILE: finery_data/international_performance_dashboard.dashboard.lookml,
        __LINE_NUM: 369}]
    width: 12
    height: 4
    top: 41
    left: 0


  - name: other_revenue_graph_last_24_months
    title: Other Country Revenue - Last 24 Months
    model: finery_data
    explore: spree_orders
    type: looker_line
    fields: [spree_orders.sum_gross_revenue_ex_discount_in_gbp, calendar_weeks.calendar_date_month]
    fill_fields: [calendar_weeks.calendar_date_month]
    filters:
      calendar_weeks.calendar_date_month: 24 months ago for 24 months
      spree_addresses.country: "-Ireland,-United States,-United Kingdom"
    sorts: [calendar_weeks.calendar_date_month desc]
    limit: 100
    column_limit: 50
    total: true
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
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
    show_null_points: true
    point_style: none
    interpolation: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    query_timezone: Europe/London
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    hidden_series: [2017-07 - Spree Orders Gross Revenue ex. Voucher, 2017-07 - Spree
        Orders Avg Basket Size ex. Voucher, 2017-07 - Revenue mix, 2017-08 - Spree Orders
        Orders, 2017-08 - Spree Orders Gross Revenue ex. Voucher, 2017-08 - Spree Orders
        Avg Basket Size ex. Voucher, 2017-08 - Revenue mix]
    hide_legend: false
    y_axes: [{label: '', maxValue: !!null '', minValue: !!null '', orientation: left,
        showLabels: true, showValues: true, tickDensity: default, tickDensityCustom: 5,
        type: linear, unpinAxis: false, valueFormat: '"£"###,"k"', series: [{id: spree_orders.sum_gross_revenue_ex_discount_in_gbp,
            name: Gross Revenue ex. Voucher}]}]
    width: 12
    height: 4
    top: 45
    left: 0
