- dashboard: buying_report
  title: Buying Report
  layout: newspaper

  filters:

  elements:
  - name: fp_sales_by_dept
    title: Full Price - Sales by Department
    model: finery_data
    explore: product_info_option_daily
    type: table
    fields: [option_info.category, product_info_option_daily.gross_revenue_lw, product_info_option_daily.gross_revenue_pw,
      product_info_option_daily.gross_revenue_wow, product_info_option_daily.gross_revenue_ly,
      product_info_option_daily.gross_revenue_yoy, product_info_option_daily.margin_lw,
      product_info_option_daily.margin_ly, product_info_option_daily.total_discount_lw,
      product_info_option_daily.avg_return_rate, product_info_option_daily.sales_mix,
      product_info_option_daily.stock_mix, product_info_option_daily.items_sold_lw,
      product_info_option_daily.items_sold_pw, product_info_option_daily.items_sold_wow,
      product_info_option_daily.return_intake_lw, product_info_option_daily.closing_stock_units_lw,
      product_info_option_daily.closing_stock_value_lw, product_info_option_daily.net_cover_lw,
      product_info_option_daily.net_cover_pw, product_info_option_daily.options_online_last_week,
      product_info_option_daily.options_online_pw, product_info_option_daily.options_with_under_70_size_availability_percent,
      product_info_option_daily.zero_selling_options_lw_percent, product_info_option_daily.options_12kwks_lw_percent,
      product_info_option_daily.product_views_lw, product_info_option_daily.product_conversion_lw,
      product_info_option_daily.product_impressions_lw]
    filters:
      product_info_option_daily.on_sale_flag: 'No'
    sorts: [product_info_option_daily.gross_revenue_lw desc]
    limit: 500
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
    height: 12
    width: 32


  - name: fp_sales_by_season
    title: Full Price - Sales by Season
    model: finery_data
    explore: product_info_option_daily
    type: table
    fields: [option_info.sub_season, product_info_option_daily.gross_revenue_lw, product_info_option_daily.gross_revenue_pw,
      product_info_option_daily.gross_revenue_wow, product_info_option_daily.gross_revenue_ly,
      product_info_option_daily.gross_revenue_yoy, product_info_option_daily.margin_lw,
      product_info_option_daily.margin_ly, product_info_option_daily.total_discount_lw,
      product_info_option_daily.avg_return_rate, product_info_option_daily.sales_mix,
      product_info_option_daily.stock_mix, product_info_option_daily.items_sold_lw,
      product_info_option_daily.items_sold_pw, product_info_option_daily.items_sold_wow,
      product_info_option_daily.return_intake_lw, product_info_option_daily.closing_stock_units_lw,
      product_info_option_daily.closing_stock_value_lw, product_info_option_daily.net_cover_lw,
      product_info_option_daily.net_cover_pw, product_info_option_daily.options_online_last_week,
      product_info_option_daily.options_online_pw, product_info_option_daily.options_with_under_70_size_availability_percent,
      product_info_option_daily.zero_selling_options_lw_percent, product_info_option_daily.options_12kwks_lw_percent,
      product_info_option_daily.product_views_lw, product_info_option_daily.product_conversion_lw,
      product_info_option_daily.product_impressions_lw]
    filters:
      product_info_option_daily.on_sale_flag: 'No'
    sorts: [product_info_option_daily.gross_revenue_lw desc]
    limit: 500
    total: true
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
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
    height: 4
    width: 32

  - name: fp_sales_by_area
    title: Full Price - Sales by Area
    model: finery_data
    explore: product_info_option_daily
    type: table
    fields: [option_info.product_area, product_info_option_daily.gross_revenue_lw, product_info_option_daily.gross_revenue_pw,
      product_info_option_daily.gross_revenue_wow, product_info_option_daily.gross_revenue_ly,
      product_info_option_daily.gross_revenue_yoy, product_info_option_daily.margin_lw,
      product_info_option_daily.margin_ly, product_info_option_daily.total_discount_lw,
      product_info_option_daily.avg_return_rate, product_info_option_daily.sales_mix,
      product_info_option_daily.stock_mix, product_info_option_daily.items_sold_lw,
      product_info_option_daily.items_sold_pw, product_info_option_daily.items_sold_wow,
      product_info_option_daily.return_intake_lw, product_info_option_daily.closing_stock_units_lw,
      product_info_option_daily.closing_stock_value_lw, product_info_option_daily.net_cover_lw,
      product_info_option_daily.net_cover_pw, product_info_option_daily.options_online_last_week,
      product_info_option_daily.options_online_pw, product_info_option_daily.options_with_under_70_size_availability_percent,
      product_info_option_daily.zero_selling_options_lw_percent, product_info_option_daily.options_12kwks_lw_percent,
      product_info_option_daily.product_views_lw, product_info_option_daily.product_conversion_lw,
      product_info_option_daily.product_impressions_lw]
    filters:
      product_info_option_daily.on_sale_flag: 'No'
    sorts: [product_info_option_daily.gross_revenue_lw desc]
    limit: 500
    total: true
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
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
    height: 3
    width: 32

  - name: md_sales_by_dept
    title: Markdown - Sales by Department
    model: finery_data
    explore: product_info_option_daily
    type: table
    fields: [option_info.category, product_info_option_daily.gross_revenue_lw, product_info_option_daily.gross_revenue_pw,
      product_info_option_daily.gross_revenue_wow, product_info_option_daily.gross_revenue_ly,
      product_info_option_daily.gross_revenue_yoy, product_info_option_daily.margin_lw,
      product_info_option_daily.margin_ly, product_info_option_daily.total_discount_lw,
      product_info_option_daily.avg_return_rate, product_info_option_daily.sales_mix,
      product_info_option_daily.stock_mix, product_info_option_daily.items_sold_lw,
      product_info_option_daily.items_sold_pw, product_info_option_daily.items_sold_wow,
      product_info_option_daily.return_intake_lw, product_info_option_daily.closing_stock_units_lw,
      product_info_option_daily.closing_stock_value_lw, product_info_option_daily.net_cover_lw,
      product_info_option_daily.net_cover_pw, product_info_option_daily.options_online_last_week,
      product_info_option_daily.options_online_pw, product_info_option_daily.options_with_under_70_size_availability_percent,
      product_info_option_daily.zero_selling_options_lw_percent, product_info_option_daily.options_12kwks_lw_percent,
      product_info_option_daily.product_views_lw, product_info_option_daily.product_conversion_lw,
      product_info_option_daily.product_impressions_lw]
    filters:
      product_info_option_daily.on_sale_flag: 'Yes'
    sorts: [product_info_option_daily.gross_revenue_lw desc]
    limit: 500
    total: true
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
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
    height: 6
    width: 32

  - name: md_sales_by_season
    title: Markdown - Sales by Season
    model: finery_data
    explore: product_info_option_daily
    type: table
    fields: [option_info.sub_season, product_info_option_daily.gross_revenue_lw, product_info_option_daily.gross_revenue_pw,
      product_info_option_daily.gross_revenue_wow, product_info_option_daily.gross_revenue_ly,
      product_info_option_daily.gross_revenue_yoy, product_info_option_daily.margin_lw,
      product_info_option_daily.margin_ly, product_info_option_daily.total_discount_lw,
      product_info_option_daily.avg_return_rate, product_info_option_daily.sales_mix,
      product_info_option_daily.stock_mix, product_info_option_daily.items_sold_lw,
      product_info_option_daily.items_sold_pw, product_info_option_daily.items_sold_wow,
      product_info_option_daily.return_intake_lw, product_info_option_daily.closing_stock_units_lw,
      product_info_option_daily.closing_stock_value_lw, product_info_option_daily.net_cover_lw,
      product_info_option_daily.net_cover_pw, product_info_option_daily.options_online_last_week,
      product_info_option_daily.options_online_pw, product_info_option_daily.options_with_under_70_size_availability_percent,
      product_info_option_daily.zero_selling_options_lw_percent, product_info_option_daily.options_12kwks_lw_percent,
      product_info_option_daily.product_views_lw, product_info_option_daily.product_conversion_lw,
      product_info_option_daily.product_impressions_lw]
    filters:
      product_info_option_daily.on_sale_flag: 'Yes'
    sorts: [product_info_option_daily.gross_revenue_lw desc]
    limit: 500
    total: true
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
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
    height: 4
    width: 32

  - name: md_sales_by_area
    title: Markdown - Sales by Area
    model: finery_data
    explore: product_info_option_daily
    type: table
    fields: [option_info.product_area, product_info_option_daily.gross_revenue_lw, product_info_option_daily.gross_revenue_pw,
      product_info_option_daily.gross_revenue_wow, product_info_option_daily.gross_revenue_ly,
      product_info_option_daily.gross_revenue_yoy, product_info_option_daily.margin_lw,
      product_info_option_daily.margin_ly, product_info_option_daily.total_discount_lw,
      product_info_option_daily.avg_return_rate, product_info_option_daily.sales_mix,
      product_info_option_daily.stock_mix, product_info_option_daily.items_sold_lw,
      product_info_option_daily.items_sold_pw, product_info_option_daily.items_sold_wow,
      product_info_option_daily.return_intake_lw, product_info_option_daily.closing_stock_units_lw,
      product_info_option_daily.closing_stock_value_lw, product_info_option_daily.net_cover_lw,
      product_info_option_daily.net_cover_pw, product_info_option_daily.options_online_last_week,
      product_info_option_daily.options_online_pw, product_info_option_daily.options_with_under_70_size_availability_percent,
      product_info_option_daily.zero_selling_options_lw_percent, product_info_option_daily.options_12kwks_lw_percent,
      product_info_option_daily.product_views_lw, product_info_option_daily.product_conversion_lw,
      product_info_option_daily.product_impressions_lw]
    filters:
      product_info_option_daily.on_sale_flag: 'Yes'
    sorts: [product_info_option_daily.gross_revenue_lw desc]
    limit: 500
    total: true
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
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
    height: 3
    width: 32

  - name: fp_md_sales_by_dept
    title: Full Price + Markdown - Sales by Department
    model: finery_data
    explore: product_info_option_daily
    type: table
    fields: [option_info.category, product_info_option_daily.gross_revenue_lw, product_info_option_daily.gross_revenue_pw,
      product_info_option_daily.gross_revenue_wow, product_info_option_daily.gross_revenue_ly,
      product_info_option_daily.gross_revenue_yoy, product_info_option_daily.margin_lw,
      product_info_option_daily.margin_ly, product_info_option_daily.total_discount_lw,
      product_info_option_daily.avg_return_rate, product_info_option_daily.sales_mix,
      product_info_option_daily.stock_mix, product_info_option_daily.items_sold_lw,
      product_info_option_daily.items_sold_pw, product_info_option_daily.items_sold_wow,
      product_info_option_daily.return_intake_lw, product_info_option_daily.closing_stock_units_lw,
      product_info_option_daily.closing_stock_value_lw, product_info_option_daily.net_cover_lw,
      product_info_option_daily.net_cover_pw, product_info_option_daily.options_online_last_week,
      product_info_option_daily.options_online_pw, product_info_option_daily.options_with_under_70_size_availability_percent,
      product_info_option_daily.zero_selling_options_lw_percent, product_info_option_daily.options_12kwks_lw_percent,
      product_info_option_daily.product_views_lw, product_info_option_daily.product_conversion_lw,
      product_info_option_daily.product_impressions_lw]
    sorts: [product_info_option_daily.gross_revenue_lw desc]
    limit: 500
    total: true
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
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
    height: 6
    width: 32

  - name: fp_md_sales_by_season
    title: Full Price + Markdown - Sales by Season
    model: finery_data
    explore: product_info_option_daily
    type: table
    fields: [option_info.sub_season, product_info_option_daily.gross_revenue_lw, product_info_option_daily.gross_revenue_pw,
      product_info_option_daily.gross_revenue_wow, product_info_option_daily.gross_revenue_ly,
      product_info_option_daily.gross_revenue_yoy, product_info_option_daily.margin_lw,
      product_info_option_daily.margin_ly, product_info_option_daily.total_discount_lw,
      product_info_option_daily.avg_return_rate, product_info_option_daily.sales_mix,
      product_info_option_daily.stock_mix, product_info_option_daily.items_sold_lw,
      product_info_option_daily.items_sold_pw, product_info_option_daily.items_sold_wow,
      product_info_option_daily.return_intake_lw, product_info_option_daily.closing_stock_units_lw,
      product_info_option_daily.closing_stock_value_lw, product_info_option_daily.net_cover_lw,
      product_info_option_daily.net_cover_pw, product_info_option_daily.options_online_last_week,
      product_info_option_daily.options_online_pw, product_info_option_daily.options_with_under_70_size_availability_percent,
      product_info_option_daily.zero_selling_options_lw_percent, product_info_option_daily.options_12kwks_lw_percent,
      product_info_option_daily.product_views_lw, product_info_option_daily.product_conversion_lw,
      product_info_option_daily.product_impressions_lw]
    sorts: [product_info_option_daily.gross_revenue_lw desc]
    limit: 500
    total: true
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
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
    height: 4
    width: 32

  - name: fp_md_sales_by_area
    title: Full Price + Markdown - Sales by Area
    model: finery_data
    explore: product_info_option_daily
    type: table
    fields: [option_info.product_area, product_info_option_daily.gross_revenue_lw, product_info_option_daily.gross_revenue_pw,
      product_info_option_daily.gross_revenue_wow, product_info_option_daily.gross_revenue_ly,
      product_info_option_daily.gross_revenue_yoy, product_info_option_daily.margin_lw,
      product_info_option_daily.margin_ly, product_info_option_daily.total_discount_lw,
      product_info_option_daily.avg_return_rate, product_info_option_daily.sales_mix,
      product_info_option_daily.stock_mix, product_info_option_daily.items_sold_lw,
      product_info_option_daily.items_sold_pw, product_info_option_daily.items_sold_wow,
      product_info_option_daily.return_intake_lw, product_info_option_daily.closing_stock_units_lw,
      product_info_option_daily.closing_stock_value_lw, product_info_option_daily.net_cover_lw,
      product_info_option_daily.net_cover_pw, product_info_option_daily.options_online_last_week,
      product_info_option_daily.options_online_pw, product_info_option_daily.options_with_under_70_size_availability_percent,
      product_info_option_daily.zero_selling_options_lw_percent, product_info_option_daily.options_12kwks_lw_percent,
      product_info_option_daily.product_views_lw, product_info_option_daily.product_conversion_lw,
      product_info_option_daily.product_impressions_lw]
    sorts: [product_info_option_daily.gross_revenue_lw desc]
    limit: 500
    total: true
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
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
    height: 3
    width: 32

  - name: jl_sales
    title: John Lewis Sales
    model: finery_data
    explore: john_lewis_sor
    type: table
    fields: [john_lewis_sor.gross_revenue_last_week, john_lewis_sor.gross_revenue_week_before_last,
      john_lewis_sor.gross_revenue_last_week_wow, john_lewis_sor.net_revenue_last_week,
      john_lewis_sor.net_revenue_week_before_last, john_lewis_sor.net_revenue_last_week_wow,
      john_lewis_sor.units_gross_last_week, john_lewis_sor.units_gross_week_before_last,
      john_lewis_sor.units_gross_revenue_last_week_wow, john_lewis_sor.units_net_last_week,
      john_lewis_sor.units_net_week_before_last, john_lewis_sor.units_net_last_week_wow,
      john_lewis_sor.intake_units_last_week, john_lewis_sor.intake_retail_last_week,
      john_lewis_sor.stock_units_last_week_end_of_week, john_lewis_sor.stock_value_last_week_end_of_week,
      john_lewis_sor.net_cover_lw, john_lewis_sor.net_cover_pw]
    limit: 500
    column_limit: 50
    show_view_names: false
    height: 2
    width: 32

  - name: top_10_value
    title: Top 10 Products - Value
    model: finery_data
    explore: product_info_option_daily
    type: table
    fields: [option_info.shorthand_name, option_info.option_image_small, option_info.current_price_gbp,
      option_info.category, option_info.weeks_online, option_info.size_availability,
      option_info.on_sale_flag, product_info_option_daily.gross_revenue_last_week, product_info_option_daily.margin_lw,
      product_info_option_daily.items_sold_lw, product_info_option_daily.closing_stock_units_last_week,
      product_info_option_daily.product_views_last_wk, product_info_option_daily.gross_cover_lw]
    sorts: [product_info_option_daily.gross_revenue_last_week desc]
    limit: 10
    column_limit: 50
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    height: 4
    width: 32

  - name: top_10_units
    title: Top 10 Products - Units
    model: finery_data
    explore: product_info_option_daily
    type: table
    fields: [option_info.shorthand_name, option_info.option_image_small, option_info.current_price_gbp,
      option_info.category, option_info.weeks_online, option_info.size_availability,
      option_info.on_sale_flag, product_info_option_daily.gross_revenue_last_week, product_info_option_daily.margin_lw,
      product_info_option_daily.items_sold_lw, product_info_option_daily.closing_stock_units_last_week,
      product_info_option_daily.product_views_last_wk, product_info_option_daily.gross_cover_lw]
    sorts: [product_info_option_daily.items_sold_lw desc]
    limit: 10
    column_limit: 50
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    height: 4
    width: 32

  - name: top_10_lowest_cover
    title: Top 10 Products - Lowest Cover
    model: finery_data
    explore: product_info_option_daily
    type: table
    fields: [option_info.shorthand_name, option_info.option_image_small, option_info.current_price_gbp,
      option_info.category, option_info.weeks_online, option_info.size_availability,
      option_info.on_sale_flag, product_info_option_daily.gross_revenue_last_week, product_info_option_daily.margin_lw,
      product_info_option_daily.items_sold_lw, product_info_option_daily.closing_stock_units_last_week,
      product_info_option_daily.product_views_last_wk, product_info_option_daily.gross_cover_lw]
    filters:
      product_info_option_daily.gross_cover_lw: NOT NULL
      product_info_option_daily.closing_stock_units_last_week: ">0"
    sorts: [product_info_option_daily.gross_cover_lw]
    limit: 10
    column_limit: 50
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    height: 4
    width: 32

  - name: top_10_highest_cover
    title: Top 10 Products - Highest Cover
    model: finery_data
    explore: product_info_option_daily
    type: table
    fields: [option_info.shorthand_name, option_info.option_image_small, option_info.current_price_gbp,
      option_info.category, option_info.weeks_online, option_info.size_availability,
      option_info.on_sale_flag, product_info_option_daily.gross_revenue_last_week, product_info_option_daily.margin_lw,
      product_info_option_daily.items_sold_lw, product_info_option_daily.closing_stock_units_last_week,
      product_info_option_daily.product_views_last_wk, product_info_option_daily.gross_cover_lw]
    filters:
      product_info_option_daily.gross_cover_lw: NOT NULL
      product_info_option_daily.closing_stock_units_last_week: ">0"
    sorts: [product_info_option_daily.gross_cover_lw desc]
    limit: 10
    column_limit: 50
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    height: 4
    width: 32

  - name: zero_selling_options
    title: Zero Selling Options (Top 10 Stock Units)
    model: finery_data
    explore: product_info_option_daily
    type: table
    fields: [option_info.shorthand_name, option_info.option_image_small, option_info.current_price_gbp,
      option_info.category, option_info.weeks_online, option_info.size_availability,
      option_info.on_sale_flag, product_info_option_daily.gross_revenue_last_week, product_info_option_daily.margin_lw,
      product_info_option_daily.items_sold_lw, product_info_option_daily.closing_stock_units_last_week,
      product_info_option_daily.product_views_last_wk, product_info_option_daily.gross_cover_lw]
    filters:
      product_info_option_daily.closing_stock_units_last_week: ">0"
      product_info_option_daily.items_sold_lw: '0'
    sorts: [product_info_option_daily.closing_stock_units_last_week desc]
    limit: 10
    column_limit: 50
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    height: 4
    width: 32