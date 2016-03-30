- dashboard: top_products_dashboard
  title: Top Products
  layout: static
  tile_size: 100


  elements:

  - name: top_products_yesterday
    title: Top Products - Yesterday
    type: table
    model: finery_data
    explore: product_info_option_daily
    dimensions: [option_info.dpa_image, option_info.option]
    measures: [product_info_option_daily.sum_gross_revenue_gbp_ex_vat_ex_discount, product_info_option_daily.sum_items_sold, product_info_option_daily.sum_closing_stock_yesterday]
    filters:
      product_info_option_daily.calendar_date_date: yesterday
    sorts: [product_info_option_daily.sum_gross_revenue_gbp_ex_vat_ex_discount desc]
    limit: 15
    show_view_names: false
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
    ordering: none
    show_null_labels: false
    show_row_numbers: true
    top: 0
    left: 0
    height: 22
    width: 5

  - name: top_products_last_7_days
    title: Top Products - Last 7 Days
    type: table
    model: finery_data
    explore: product_info_option_daily
    dimensions: [option_info.dpa_image, option_info.option]
    measures: [product_info_option_daily.sum_gross_revenue_gbp_ex_vat_ex_discount, product_info_option_daily.sum_items_sold, product_info_option_daily.sum_closing_stock_yesterday]
    filters:
      product_info_option_daily.calendar_date_date: 7 days ago for 7 days
    sorts: [product_info_option_daily.sum_gross_revenue_gbp_ex_vat_ex_discount desc]
    limit: 15
    show_view_names: false
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
    ordering: none
    show_null_labels: false
    show_row_numbers: true
    top: 0
    left: 6
    height: 22
    width: 5