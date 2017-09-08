- dashboard: international_performance_dashboard
  title: International Performance Dashboard
  layout: static
  tile_size: 100

  elements:

  - name: uk_performance_revenue
    title: UK Performance - Revenue
    model: finery_data
    explore: spree_orders
    type: table
    fields: [spree_addresses.country_group, spree_orders.revenue_yesterday, spree_orders.revenue_yesterday_last_week,
      spree_orders.revenue_week_to_date, spree_orders.revenue_week_to_date_lw, spree_orders.revenue_week_to_date_ly,
      spree_orders.revenue_month_to_date, spree_orders.revenue_month_to_date_last_month,
      spree_orders.revenue_month_to_date_last_year, spree_orders.revenue_yesterday_last_year,
      spree_orders.revenue_year_to_date, spree_orders.revenue_year_to_date_last_year]
    filters:
      spree_addresses.country_group: UK
    sorts: [spree_orders.revenue_yesterday desc]
    limit: 100
    column_limit: 50
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
    width: 6
    height: 2
    top: 0
    left: 0


  - name: ie_us_performance_revenue
    title: Ireland & US Performance - Revenue
    model: finery_data
    explore: spree_orders
    type: table
    fields: [spree_addresses.country_group, spree_orders.revenue_yesterday, spree_orders.revenue_yesterday_last_week,
      spree_orders.revenue_week_to_date, spree_orders.revenue_week_to_date_lw, spree_orders.revenue_week_to_date_ly,
      spree_orders.revenue_month_to_date, spree_orders.revenue_month_to_date_last_month,
      spree_orders.revenue_month_to_date_last_year, spree_orders.revenue_yesterday_last_year,
      spree_orders.revenue_year_to_date, spree_orders.revenue_year_to_date_last_year]
    filters:
      spree_addresses.country_group: IE/US
    sorts: [spree_orders.revenue_yesterday desc]
    limit: 100
    column_limit: 50
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
    width: 6
    height: 2
    top: 2
    left: 3

  - name: other_performance_revenue
    title: Other Country Performance - Revenue
    model: finery_data
    explore: spree_orders
    type: table
    fields: [spree_addresses.country_group, spree_orders.revenue_yesterday, spree_orders.revenue_yesterday_last_week,
      spree_orders.revenue_week_to_date, spree_orders.revenue_week_to_date_lw, spree_orders.revenue_week_to_date_ly,
      spree_orders.revenue_month_to_date, spree_orders.revenue_month_to_date_last_month,
      spree_orders.revenue_month_to_date_last_year, spree_orders.revenue_yesterday_last_year,
      spree_orders.revenue_year_to_date, spree_orders.revenue_year_to_date_last_year]
    filters:
      spree_addresses.country_group: Other
    sorts: [spree_orders.revenue_yesterday desc]
    limit: 100
    column_limit: 50
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
    width: 6
    height: 2
    top: 2
    left: 9



  - name: uk_performance_avg_basket
    title: Uk Performance - Average Basket
    model: finery_data
    explore: spree_orders
    type: table
    fields: [spree_addresses.country_group, spree_orders.basket_yesterday, spree_orders.basket_yesterday_last_week,
      spree_orders.basket_week_to_date, spree_orders.basket_week_to_date_last_week,
      spree_orders.basket_week_to_date_last_year, spree_orders.basket_month_to_date,
      spree_orders.basket_month_to_date_last_month, spree_orders.basket_month_to_date_last_year,
      spree_orders.basket_yesterday_last_year, spree_orders.basket_year_to_date, spree_orders.basket_year_to_date_last_year]
    filters:
      spree_addresses.country_group: UK
    sorts: [spree_orders.basket_yesterday desc]
    limit: 100
    column_limit: 50
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
    width: 6
    height: 2
    top: 4
    left: -3



  - name: ie_us_performance_avg_basket
    title: Ireland & Us Performance - Average Basket
    model: finery_data
    explore: spree_orders
    type: table
    fields: [spree_addresses.country_group, spree_orders.basket_yesterday, spree_orders.basket_yesterday_last_week,
      spree_orders.basket_week_to_date, spree_orders.basket_week_to_date_last_week,
      spree_orders.basket_week_to_date_last_year, spree_orders.basket_month_to_date,
      spree_orders.basket_month_to_date_last_month, spree_orders.basket_month_to_date_last_year,
      spree_orders.basket_yesterday_last_year, spree_orders.basket_year_to_date, spree_orders.basket_year_to_date_last_year]
    filters:
      spree_addresses.country_group: IE/US
    sorts: [spree_orders.basket_yesterday desc]
    limit: 100
    column_limit: 50
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
    width: 6
    height: 2
    top: 4
    left: 3


  - name: other_country_performance_avg_basket
    title: Other Country Performance - Average Basket
    model: finery_data
    explore: spree_orders
    type: table
    fields: [spree_addresses.country_group, spree_orders.basket_yesterday, spree_orders.basket_yesterday_last_week,
      spree_orders.basket_week_to_date, spree_orders.basket_week_to_date_last_week,
      spree_orders.basket_week_to_date_last_year, spree_orders.basket_month_to_date,
      spree_orders.basket_month_to_date_last_month, spree_orders.basket_month_to_date_last_year,
      spree_orders.basket_yesterday_last_year, spree_orders.basket_year_to_date, spree_orders.basket_year_to_date_last_year]
    filters:
      spree_addresses.country_group: Other
    sorts: [spree_orders.basket_yesterday desc]
    limit: 100
    column_limit: 50
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
    width: 6
    height: 2
    top: 4
    left: 9


  - name: uk_performance_gross_margin
    title: UK Performance - Gross Margin
    model: finery_data
    explore: spree_orders
    type: table
    fields: [spree_addresses.country_group, spree_orders.revenue_yesterday, spree_orders.sum_gross_cogs_gbp]
    filters:
      calendar_weeks.calendar_date_date: 1 days ago for 1 days
      spree_addresses.country_group: UK
    sorts: [spree_orders.revenue_yesterday desc]
    limit: 100
    column_limit: 50
    dynamic_fields:
    - table_calculation: gross_margin
      label: Gross Margin
      expression: "${spree_orders.revenue_yesterday}-${spree_orders.sum_gross_cogs_gbp}\n"
      value_format:
      value_format_name: pounds
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
    hidden_fields:
    width: 6
    height: 1
    top: 6
    left: -3



  - name: ie_us_performance_gross_margin
    title: Ireland & US Performance - Gross Margin
    model: finery_data
    explore: spree_orders
    type: table
    fields: [spree_addresses.country_group, spree_orders.revenue_yesterday, spree_orders.sum_gross_cogs_gbp]
    filters:
      calendar_weeks.calendar_date_date: 1 days ago for 1 days
      spree_addresses.country_group: IE/US
    sorts: [spree_orders.revenue_yesterday desc]
    limit: 100
    column_limit: 50
    dynamic_fields:
    - table_calculation: gross_margin
      label: Gross Margin
      expression: "${spree_orders.revenue_yesterday}-${spree_orders.sum_gross_cogs_gbp}\n"
      value_format:
      value_format_name: pounds
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
    hidden_fields:
    width: 6
    height: 1
    top: 6
    left: 3


  - name: other_country_performance_gross_margin
    title: Other Country Performance - Gross Margin
    model: finery_data
    explore: spree_orders
    type: table
    fields: [spree_addresses.country_group, spree_orders.revenue_yesterday, spree_orders.sum_gross_cogs_gbp]
    filters:
      calendar_weeks.calendar_date_date: 1 days ago for 1 days
      spree_addresses.country_group: Other
    sorts: [spree_orders.revenue_yesterday desc]
    limit: 100
    column_limit: 50
    dynamic_fields:
    - table_calculation: gross_margin
      label: Gross Margin
      expression: "${spree_orders.revenue_yesterday}-${spree_orders.sum_gross_cogs_gbp}\n"
      value_format:
      value_format_name: pounds
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
    hidden_fields:
    width: 6
    height: 1
    top: 6
    left: 9



  - name: revenue_mix
    title: Percentage Of Total Revenue
    model: finery_data
    explore: spree_orders
    type: table
    fields: [spree_addresses.country_group, spree_orders.revenue_week_to_date, spree_orders.revenue_week_to_date_lw]
    sorts: [of_total_rev_wtd desc]
    limit: 100
    column_limit: 50
    dynamic_fields:
    - table_calculation: of_total_rev_wtd
      label: "% of total rev WTD"
      expression: "${spree_orders.revenue_week_to_date}/sum(${spree_orders.revenue_week_to_date})"
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
    - table_calculation: of_total_rev_wtd_lw
      label: "% of total rev WTD LW"
      expression: "${spree_orders.revenue_week_to_date_lw}/sum(${spree_orders.revenue_week_to_date_lw})"
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
    hidden_fields:
    width: 18
    height: 2
    top: 7
    left: -3


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
    width: 6
    height: 4
    top: 9
    left: -3


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
            name: Gross Revenue ex. Voucher}]}]
    width: 6
    height: 4
    top: 9
    left: 3



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
            name: Gross Revenue ex. Voucher}]}]
    width: 6
    height: 4
    top: 9
    left: 9



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
            name: Gross Revenue ex. Voucher}]}]
    width: 6
    height: 4
    top: 13
    left: -3



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
    width: 6
    height: 4
    top: 13
    left: 3



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
            name: Gross Revenue ex. Voucher}]}]
    width: 6
    height: 4
    top: 13
    left: 9


  - name: other_revenue_graph_last_30_days
    title: Other Country Revenue - Last 30 Days
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
            name: Gross Revenue ex. Voucher}]}]
    width: 6
    height: 4
    top: 17
    left: -3



  - name: other_revenue_graph_last_26_weeks
    title: Other Country Revenue - Last 26 Weeks
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
            name: Gross Revenue ex. Voucher}]}]
    width: 6
    height: 4
    top: 17
    left: 3


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
    width: 6
    height: 4
    top: 17
    left: 9
