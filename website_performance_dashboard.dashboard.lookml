- dashboard: website_performance_dashboard
  title: Website Performance Dashboard
  layout: static
  tile_size: 50

  filters:
  - name: date
    title: "Date"
    type: date_filter
    default_value: 30 days

  elements:

  - name: latest_homepage_screenshot
    title: Latest Homepage Check
    type: table
    model: finery_data
    explore: website_performance_checks
    dimensions: [website_performance_checks.calendar_date, website_performance_checks.screenshot]
    hidden_fields: [website_performance_checks.calendar_date]
    filters:
      website_performance_checks.page_type: Home Page
    sorts: [website_performance_checks.calendar_date desc]
    limit: 1
    show_view_names: false
    show_row_numbers: false
    truncate_column_names: false
    series_labels:
      website_performance_checks.screenshot: 
    table_theme: transparent
    limit_displayed_rows: false
    height: 7
    width: 8
    top: 0
    left: 0

  - name: current_plp_screenshot
    title: Latest Category Page Check
    type: table
    model: finery_data
    explore: website_performance_checks
    dimensions: [website_performance_checks.calendar_date, website_performance_checks.screenshot]
    hidden_fields: [website_performance_checks.calendar_date]
    filters:
      website_performance_checks.page_type: Category Page
    sorts: [website_performance_checks.calendar_date desc]
    limit: 1
    show_view_names: false
    show_row_numbers: false
    truncate_column_names: false
    series_labels:
      website_performance_checks.screenshot: Category Page
    table_theme: transparent
    limit_displayed_rows: false
    height: 7
    width: 8
    top: 0
    left: 8
    
  - name: current_pdp_screenshot
    title: Latest Product Page Check
    type: table
    model: finery_data
    explore: website_performance_checks
    dimensions: [website_performance_checks.calendar_date, website_performance_checks.screenshot]
    hidden_fields: [website_performance_checks.calendar_date]
    filters:
      website_performance_checks.page_type: Product Page
    sorts: [website_performance_checks.calendar_date desc]
    limit: 1
    show_view_names: false
    show_row_numbers: false
    truncate_column_names: false
    series_labels:
      website_performance_checks.screenshot: Product Page
    table_theme: transparent
    limit_displayed_rows: false
    height: 7
    width: 8
    top: 0
    left: 16
    
  - name: site_speed_by_page_desktop
    title: Desktop Page Speeds
    type: looker_line
    model: finery_data
    explore: website_performance_checks
    dimensions: [website_performance_checks.calendar_date, website_performance_checks.page_type]
    pivots: [website_performance_checks.page_type]
    measures: [website_performance_checks.average_site_speed]
    filters:
      website_performance_checks.platform: desktop
    listen:
      date: website_performance_checks.calendar_date
    sorts: [website_performance_checks.calendar_date desc, website_performance_checks.page_type]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
      '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    y_axis_min: ['50']
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    point_style: none
    interpolation: linear
    height: 7
    width: 12
    top: 8
    left: 0
    
  - name: site_speed_by_page_mobile
    title: Mobile Page Speeds
    type: looker_line
    model: finery_data
    explore: website_performance_checks
    dimensions: [website_performance_checks.calendar_date, website_performance_checks.page_type]
    pivots: [website_performance_checks.page_type]
    measures: [website_performance_checks.average_site_speed]
    filters:
      website_performance_checks.platform: mobile
    listen:
      date: website_performance_checks.calendar_date
    sorts: [website_performance_checks.calendar_date desc, website_performance_checks.page_type]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
      '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    y_axis_min: ['50']
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    point_style: none
    interpolation: linear
    height: 7
    width: 12
    top: 8
    left: 12
    
  - name: total_request_size_by_page_desktop
    title: Desktop Page Request Sizes
    type: looker_line
    model: finery_data
    explore: website_performance_checks
    dimensions: [website_performance_checks.calendar_date, website_performance_checks.page_type]
    pivots: [website_performance_checks.page_type]
    measures: [website_performance_checks.average_total_request_bytes]
    filters:
      website_performance_checks.platform: desktop
    listen:
      date: website_performance_checks.calendar_date
    sorts: [website_performance_checks.calendar_date desc, website_performance_checks.page_type]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
      '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    y_axis_min: ['10000']
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    point_style: none
    interpolation: linear
    height: 7
    width: 12
    top: 15
    left: 0
    
  - name: total_request_size_by_page_mobile
    title: Mobile Page Request Sizes
    type: looker_line
    model: finery_data
    explore: website_performance_checks
    dimensions: [website_performance_checks.calendar_date, website_performance_checks.page_type]
    pivots: [website_performance_checks.page_type]
    measures: [website_performance_checks.average_total_request_bytes]
    filters:
      website_performance_checks.platform: mobile
    listen:
      date: website_performance_checks.calendar_date
    sorts: [website_performance_checks.calendar_date desc, website_performance_checks.page_type]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
      '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    y_axis_min: ['10000']
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    point_style: none
    interpolation: linear
    height: 7
    width: 12
    top: 15
    left: 12
    
  - name: no_resources_by_page_desktop
    title: Desktop Numbers of Resources
    type: looker_line
    model: finery_data
    explore: website_performance_checks
    dimensions: [website_performance_checks.calendar_date, website_performance_checks.page_type]
    pivots: [website_performance_checks.page_type]
    measures: [website_performance_checks.average_number_of_resources]
    filters:
      website_performance_checks.platform: desktop
    listen:
      date: website_performance_checks.calendar_date
    sorts: [website_performance_checks.calendar_date desc, website_performance_checks.page_type]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
      '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    y_axis_min: ['50']
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    point_style: none
    interpolation: linear
    height: 7
    width: 12
    top: 22
    left: 0
    
  - name: no_resources_by_page_mobile
    title: Mobile Numbers of Resources
    type: looker_line
    model: finery_data
    explore: website_performance_checks
    dimensions: [website_performance_checks.calendar_date, website_performance_checks.page_type]
    pivots: [website_performance_checks.page_type]
    measures: [website_performance_checks.average_number_of_resources]
    filters:
      website_performance_checks.platform: mobile
    listen:
      date: website_performance_checks.calendar_date
    sorts: [website_performance_checks.calendar_date desc, website_performance_checks.page_type]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
      '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    y_axis_min: ['50']
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    point_style: none
    interpolation: linear
    height: 7
    width: 12
    top: 22
    left: 12

  - name: no_js_resources_by_page_desktop
    title: Desktop Numbers of JS Resources
    type: looker_line
    model: finery_data
    explore: website_performance_checks
    dimensions: [website_performance_checks.calendar_date, website_performance_checks.page_type]
    pivots: [website_performance_checks.page_type]
    measures: [website_performance_checks.average_number_of_js_resources]
    filters:
      website_performance_checks.platform: desktop
    listen:
      date: website_performance_checks.calendar_date
    sorts: [website_performance_checks.calendar_date desc, website_performance_checks.page_type]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
      '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
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
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    point_style: none
    interpolation: linear
    height: 7
    width: 12
    top: 29
    left: 0
    
  - name: no_js_resources_by_page_mobile
    title: Mobile Numbers of JS Resources
    type: looker_line
    model: finery_data
    explore: website_performance_checks
    dimensions: [website_performance_checks.calendar_date, website_performance_checks.page_type]
    pivots: [website_performance_checks.page_type]
    measures: [website_performance_checks.average_number_of_js_resources]
    filters:
      website_performance_checks.platform: mobile
    listen:
      date: website_performance_checks.calendar_date
    sorts: [website_performance_checks.calendar_date desc, website_performance_checks.page_type]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
      '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
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
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    point_style: none
    interpolation: linear
    height: 7
    width: 12
    top: 29
    left: 12
      
    
  - name: homepage_desktop_size_breakdown
    title: Homepage - Desktop - Response Size Breakdown
    type: looker_area
    model: finery_data
    explore: website_performance_checks
    dimensions: [website_performance_checks.calendar_date]
    measures: [website_performance_checks.average_text_response_bytes, website_performance_checks.average_other_response_bytes,
      website_performance_checks.average_javascript_response_bytes, website_performance_checks.average_image_response_bytes,
      website_performance_checks.average_html_response_bytes, website_performance_checks.average_css_response_bytes]
    filters:
      website_performance_checks.page_type: Home Page
      website_performance_checks.platform: desktop
    listen:
      date: website_performance_checks.calendar_date
    sorts: [website_performance_checks.calendar_date desc]
    limit: 500
    column_limit: 50
    stacking: normal
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
      '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    series_labels:
      website_performance_checks.screenshot: Homepage
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    point_style: none
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: '#808080'
    height: 10
    width: 12
    top: 38
    left: 0

  - name: homepage_mobile_size_breakdown
    title: Homepage - Mobile - Response Size Breakdown
    type: looker_area
    model: finery_data
    explore: website_performance_checks
    dimensions: [website_performance_checks.calendar_date]
    measures: [website_performance_checks.average_text_response_bytes, website_performance_checks.average_other_response_bytes,
      website_performance_checks.average_javascript_response_bytes, website_performance_checks.average_image_response_bytes,
      website_performance_checks.average_html_response_bytes, website_performance_checks.average_css_response_bytes]
    filters:
      website_performance_checks.page_type: Home Page
      website_performance_checks.platform: mobile
    listen:
      date: website_performance_checks.calendar_date
    sorts: [website_performance_checks.calendar_date desc]
    limit: 500
    column_limit: 50
    stacking: normal
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
      '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    series_labels:
      website_performance_checks.screenshot: Homepage
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    point_style: none
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: '#808080'
    height: 10
    width: 12
    top: 38
    left: 12

  - name: category_page_desktop_size_breakdown
    title: Category Page - Desktop - Response Size Breakdown
    type: looker_area
    model: finery_data
    explore: website_performance_checks
    dimensions: [website_performance_checks.calendar_date]
    measures: [website_performance_checks.average_text_response_bytes, website_performance_checks.average_other_response_bytes,
      website_performance_checks.average_javascript_response_bytes, website_performance_checks.average_image_response_bytes,
      website_performance_checks.average_html_response_bytes, website_performance_checks.average_css_response_bytes]
    listen:
      date: website_performance_checks.calendar_date
    filters:
      website_performance_checks.page_type: Category Page
      website_performance_checks.platform: desktop
    sorts: [website_performance_checks.calendar_date desc]
    limit: 500
    column_limit: 50
    stacking: normal
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
      '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
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
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    point_style: none
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: '#808080'
    height: 10
    width: 12
    top: 48
    left: 0

  - name: category_page__mobile_size_breakdown
    title: Category Page - Mobile - Response Size Breakdown
    type: looker_area
    model: finery_data
    explore: website_performance_checks
    dimensions: [website_performance_checks.calendar_date]
    measures: [website_performance_checks.average_text_response_bytes, website_performance_checks.average_other_response_bytes,
      website_performance_checks.average_javascript_response_bytes, website_performance_checks.average_image_response_bytes,
      website_performance_checks.average_html_response_bytes, website_performance_checks.average_css_response_bytes]
    listen:
      date: website_performance_checks.calendar_date
    filters:
      website_performance_checks.page_type: Category Page
      website_performance_checks.platform: mobile
    sorts: [website_performance_checks.calendar_date desc]
    limit: 500
    column_limit: 50
    stacking: normal
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
      '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
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
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    point_style: none
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: '#808080'
    height: 10
    width: 12
    top: 48
    left: 12

  - name: product_page_desktop_size_breakdown
    title: Product Page - Desktop - Response Size Breakdown
    type: looker_area
    model: finery_data
    explore: website_performance_checks
    dimensions: [website_performance_checks.calendar_date]
    measures: [website_performance_checks.average_text_response_bytes, website_performance_checks.average_other_response_bytes,
      website_performance_checks.average_javascript_response_bytes, website_performance_checks.average_image_response_bytes,
      website_performance_checks.average_html_response_bytes, website_performance_checks.average_css_response_bytes]
    listen:
      date: website_performance_checks.calendar_date
    filters:
      website_performance_checks.page_type: Product Page
      website_performance_checks.platform: desktop
    sorts: [website_performance_checks.calendar_date desc]
    limit: 500
    column_limit: 50
    stacking: normal
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
      '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
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
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    point_style: none
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: '#808080'
    height: 10
    width: 12
    top: 58
    left: 0

  - name: product_page__mobile_size_breakdown
    title: Product Page - Mobile - Response Size Breakdown
    type: looker_area
    model: finery_data
    explore: website_performance_checks
    dimensions: [website_performance_checks.calendar_date]
    measures: [website_performance_checks.average_text_response_bytes, website_performance_checks.average_other_response_bytes,
      website_performance_checks.average_javascript_response_bytes, website_performance_checks.average_image_response_bytes,
      website_performance_checks.average_html_response_bytes, website_performance_checks.average_css_response_bytes]
    listen:
      date: website_performance_checks.calendar_date
    filters:
      website_performance_checks.page_type: Product Page
      website_performance_checks.platform: mobile
    sorts: [website_performance_checks.calendar_date desc]
    limit: 500
    column_limit: 50
    stacking: normal
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
      '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
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
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    point_style: none
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: '#808080'
    height: 10
    width: 12
    top: 58
    left: 12