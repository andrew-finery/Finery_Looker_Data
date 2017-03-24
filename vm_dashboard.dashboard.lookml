- dashboard: vm_dashboard
  title: VM Dashboard
  layout: static
  tile_size: 100

  filters:
  - name: date
    title: "Select date range"
    type: date_filter
    default_value: yesterday

  elements:

  - name: product_impressions
    title: Product Impressions
    type: table
    model: finery_data
    explore: product_info_option_daily
    dimensions: [option_info.option]
    measures: [product_info_option_daily.sum_product_impressions, product_info_option_daily.revenue_per_1k_impressions,
      product_info_option_daily.sum_items_sold, product_info_option_daily.sum_closing_stock_yesterday]
    listen:
     date: product_info_option_daily.calendar_date_date
    filters:
      option_info.on_sale_flag: '"Full Price"'
      product_info_option_daily.sum_product_clicks: '>0'
      product_info_option_daily.sum_product_impressions: '>200'
    sorts: [product_info_option_daily.revenue_per_impression desc, product_info_option_daily.sum_product_impressions desc]
    limit: 5000
    show_view_names: false
    stacking: ''
    colors: ['#294987', '#5a1038', '#ff947c', '#1f6b62', '#764173', '#910303', '#b2947c',
      '#192d54', '#a31e67', '#a16154', '#0f544b', '#ffd9ba']
    show_value_labels: false
    top: 0
    left: 0
    height: 10
    width: 6

  - name: revenue_per_impression_plot
    title: Revenue per Impression Plot
    type: looker_scatter
    model: finery_data
    explore: product_info_option_daily
    dimensions: [option_info.option]
    measures: [product_info_option_daily.revenue_per_1k_impressions, product_info_option_daily.sum_product_impressions]
    hidden_fields: [option_info.option]
    listen:
     date: product_info_option_daily.calendar_date_date
    filters:
      option_info.on_sale_flag: '"Full Price"'
      product_info_option_daily.sum_product_clicks: '>0'
      product_info_option_daily.sum_product_impressions: '>200'
    sorts: [product_info_option_daily.revenue_per_impression desc, product_info_option_daily.sum_product_impressions desc]
    limit: 5000
    stacking: ''
    colors: ['#294987', '#5a1038', '#ff947c', '#1f6b62', '#764173', '#910303', '#b2947c',
      '#192d54', '#a31e67', '#a16154', '#0f544b', '#ffd9ba']
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: true
    y_axis_gridlines: true
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    reference_lines: [{reference_type: range, line_value: mean, range_start: max, range_end: mean,
        margin_top: deviation, margin_value: mean, margin_bottom: deviation, label: '',
        color: lightgreen}, {reference_type: range, line_value: mean, range_start: mean,
        range_end: min, margin_top: deviation, margin_value: mean, margin_bottom: deviation,
        color: lightpink, label: ''}]
    swap_axes: false
    show_null_points: true
    point_style: circle_outline
    top: 0
    left: 6
    height: 5
    width: 6

  - name: zero_selling_options_impressions
    title: Zero Selling Options
    type: table
    model: finery_data
    explore: product_info_option_daily
    dimensions: [option_info.option]
    measures: [product_info_option_daily.sum_product_impressions, product_info_option_daily.revenue_per_1k_impressions,
      product_info_option_daily.sum_items_sold, product_info_option_daily.sum_closing_stock_yesterday]
    listen:
     date: product_info_option_daily.calendar_date_date
    filters:
      option_info.on_sale_flag: '"Full Price"'
      product_info_option_daily.sum_items_sold: '0'
      product_info_option_daily.sum_product_clicks: '>0'
      product_info_option_daily.sum_product_impressions: '>200'
    sorts: [product_info_option_daily.revenue_per_impression desc, product_info_option_daily.sum_product_impressions desc]
    limit: 5000
    show_view_names: false
    stacking: ''
    colors: ['#294987', '#5a1038', '#ff947c', '#1f6b62', '#764173', '#910303', '#b2947c',
      '#192d54', '#a31e67', '#a16154', '#0f544b', '#ffd9ba']
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: true
    y_axis_gridlines: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    reference_lines: [{reference_type: range, line_value: mean, range_start: max, range_end: mean,
        margin_top: deviation, margin_value: mean, margin_bottom: deviation, label: '',
        color: lightgreen, __FILE: finery_data/vm_dashboard.dashboard.lookml, __LINE_NUM: 39},
      {reference_type: range, line_value: mean, range_start: mean, range_end: min, margin_top: deviation,
        margin_value: mean, margin_bottom: deviation, color: lightpink, label: '', __FILE: finery_data/vm_dashboard.dashboard.lookml,
        __LINE_NUM: 42}]
    swap_axes: false
    show_null_points: true
    point_style: circle
    y_axis_tick_density_custom: 5
    show_row_numbers: true
    top: 5
    left: 6
    height: 5
    width: 6

  - name: product
    title: Product Views
    type: table
    model: finery_data
    explore: product_info_option_daily
    dimensions: [option_info.option]
    measures: [product_info_option_daily.sum_product_page_views, product_info_option_daily.sum_items_sold,
      product_info_option_daily.conversion_rate, product_info_option_daily.sum_closing_stock_yesterday]
    listen:
     date: product_info_option_daily.calendar_date_date
    filters:
      product_info_option_daily.sum_product_page_views: '>2'
    sorts: [product_info_option_daily.sum_product_page_views desc]
    limit: 500
    show_view_names: false
    ordering: none
    top: 11
    left: 0
    height: 10
    width: 6

  - name: product_conversion_rate_plot_yesterday
    title: Product Conversion Rate Plot - Yesterday
    type: looker_scatter
    model: finery_data
    explore: product_info_option_daily
    dimensions: [option_info.option]
    measures: [product_info_option_daily.conversion_rate, product_info_option_daily.sum_product_page_views]
    hidden_fields: [option_info.option]
    listen:
     date: product_info_option_daily.calendar_date_date
    filters:
      product_info_option_daily.sum_product_page_views: '>2'
    sorts: [product_info_option_daily.sum_product_page_views desc]
    limit: 500
    stacking: ''
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
      '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    reference_lines: [{reference_type: range, line_value: mean, range_start: max, range_end: mean,
        margin_top: deviation, margin_value: mean, margin_bottom: deviation, color: green},
      {reference_type: range, line_value: mean, range_start: mean, range_end: min, margin_top: deviation,
        margin_value: mean, margin_bottom: deviation, label: '', color: red}]
    point_style: circle_outline
    top: 11
    left: 6
    height: 5
    width: 6

  - name: zero_selling_options_product_views
    title: Zero Selling Options - Product View Info
    type: table
    model: finery_data
    explore: product_info_option_daily
    dimensions: [option_info.option]
    measures: [product_info_option_daily.sum_product_page_views, product_info_option_daily.sum_items_sold,
      product_info_option_daily.sum_closing_stock_yesterday]
    listen:
     date: product_info_option_daily.calendar_date_date
    filters:
      product_info_option_daily.sum_items_sold: '0'
      product_info_option_daily.sum_product_page_views: '>2'
    sorts: [product_info_option_daily.sum_product_page_views desc]
    limit: 500
    show_view_names: false
    ordering: none
    show_null_labels: false
    color_palette: Santa Cruz
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
    point_style: circle
    reference_lines: [{reference_type: range, line_value: mean, range_start: max, range_end: mean,
        margin_top: deviation, margin_value: mean, margin_bottom: deviation, color: green},
      {reference_type: range, line_value: mean, range_start: mean, range_end: min, margin_top: deviation,
        margin_value: mean, margin_bottom: deviation, label: '', color: red}]
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
      '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    show_null_points: true
    top: 16
    left: 6
    height: 5
    width: 6
