- dashboard: facebook_dashboard
  title: Facebook Dashboard
  layout: static
  tile_size: 100


  filters:
  - name: facebook_country
    title: "Country"
    type: field_filter
    explore: facebook_api_ad_performance
    field: facebook_api_ad_performance.country
    default_value:

  - name: facebook_acquisition_retention
    title: "Acquisition | Retention"
    type: field_filter
    explore: facebook_api_ad_performance
    field: facebook_api_ad_performance.buyers_vs_nonbuyers
    default_value:

  elements:

  - name: spend_last_30_days
    title: Spend
    type: looker_area
    model: finery_data
    explore: facebook_api_ad_performance
    dimensions: [facebook_api_ad_performance.calendar_date]
    measures: [facebook_api_ad_performance.total_spend]
    filters:
      facebook_api_ad_performance.calendar_date: 30 days ago for 30 days
    listen:
      facebook_country: facebook_api_ad_performance.country
      facebook_acquisition_retention: facebook_api_ad_performance.buyers_vs_nonbuyers
    sorts: [facebook_api_ad_performance.calendar_date desc]
    stacking: ''
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
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    show_null_points: true
    point_style: circle
    interpolation: monotone
    colors: [orange]
    width: 4
    height: 4
    top: 0
    left: 0

  - name: impressions_last_30_days
    title: Impressions
    type: looker_area
    model: finery_data
    explore: facebook_api_ad_performance
    dimensions: [facebook_api_ad_performance.calendar_date]
    measures: [facebook_api_ad_performance.total_impressions]
    filters:
      facebook_api_ad_performance.calendar_date: 30 days ago for 30 days
    listen:
      facebook_country: facebook_api_ad_performance.country
      facebook_acquisition_retention: facebook_api_ad_performance.buyers_vs_nonbuyers
    sorts: [facebook_api_ad_performance.calendar_date desc]
    stacking: ''
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
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    show_null_points: true
    point_style: circle
    interpolation: monotone
    colors: [orange]
    width: 4
    height: 4
    top: 0
    left: 4

  - name: clicks_last_30_days
    title: Clicks
    type: looker_area
    model: finery_data
    explore: facebook_api_ad_performance
    dimensions: [facebook_api_ad_performance.calendar_date]
    measures: [facebook_api_ad_performance.total_clicks]
    filters:
      facebook_api_ad_performance.calendar_date: 30 days ago for 30 days
    listen:
      facebook_country: facebook_api_ad_performance.country
      facebook_acquisition_retention: facebook_api_ad_performance.buyers_vs_nonbuyers
    sorts: [facebook_api_ad_performance.calendar_date desc]
    stacking: ''
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
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    show_null_points: true
    point_style: circle
    interpolation: monotone
    colors: [orange]
    width: 4
    height: 4
    top: 0
    left: 8

  - name: cpm_last_30_days
    title: Cost per 1000 Impressions
    type: looker_line
    model: finery_data
    explore: facebook_api_ad_performance
    dimensions: [facebook_api_ad_performance.calendar_date]
    measures: [facebook_api_ad_performance.cost_per_mille]
    filters:
      facebook_api_ad_performance.calendar_date: 30 days ago for 30 days
    listen:
      facebook_country: facebook_api_ad_performance.country
      facebook_acquisition_retention: facebook_api_ad_performance.buyers_vs_nonbuyers
    sorts: [facebook_api_ad_performance.calendar_date desc]
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axis_combined: false
    show_y_axis_labels: false
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    colors: [salmon]
    show_null_points: true
    interpolation: monotone
    ordering: none
    show_null_labels: false
    y_axis_orientation: [left, left, right]
    width: 4
    height: 3
    top: 4
    left: 0

  - name: cpc_last_30_days
    title: Cost per Click
    type: looker_line
    model: finery_data
    explore: facebook_api_ad_performance
    dimensions: [facebook_api_ad_performance.calendar_date]
    measures: [facebook_api_ad_performance.cost_per_click]
    filters:
      facebook_api_ad_performance.calendar_date: 30 days ago for 30 days
    listen:
      facebook_country: facebook_api_ad_performance.country
      facebook_acquisition_retention: facebook_api_ad_performance.buyers_vs_nonbuyers
    sorts: [facebook_api_ad_performance.calendar_date desc]
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axis_combined: false
    show_y_axis_labels: false
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    colors: [salmon]
    show_null_points: true
    interpolation: monotone
    ordering: none
    show_null_labels: false
    y_axis_orientation: [left, left, right]
    width: 4
    height: 3
    top: 4
    left: 8

  - name: ctr_last_30_days
    title: Click Through Rate
    type: looker_line
    model: finery_data
    explore: facebook_api_ad_performance
    dimensions: [facebook_api_ad_performance.calendar_date]
    measures: [facebook_api_ad_performance.click_through_rate]
    filters:
      facebook_api_ad_performance.calendar_date: 30 days ago for 30 days
    listen:
      facebook_country: facebook_api_ad_performance.country
      facebook_acquisition_retention: facebook_api_ad_performance.buyers_vs_nonbuyers
    sorts: [facebook_api_ad_performance.calendar_date desc]
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axis_combined: false
    show_y_axis_labels: false
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    colors: [salmon]
    show_null_points: true
    interpolation: monotone
    ordering: none
    show_null_labels: false
    y_axis_orientation: [left, left, right]
    width: 4
    height: 3
    top: 4
    left: 4

  - name: cpa_view_content_last_30_days
    title: CPA View Content (1d)
    type: looker_line
    model: finery_data
    explore: facebook_api_ad_performance
    dimensions: [facebook_api_ad_performance.calendar_date]
    measures: [facebook_api_ad_performance.1d_cpa_product_view_content]
    filters:
      facebook_api_ad_performance.calendar_date: 30 days ago for 30 days
    listen:
      facebook_country: facebook_api_ad_performance.country
      facebook_acquisition_retention: facebook_api_ad_performance.buyers_vs_nonbuyers
    sorts: [facebook_api_ad_performance.calendar_date desc]
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axis_combined: false
    show_y_axis_labels: false
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    colors: [salmon]
    show_null_points: true
    interpolation: monotone
    ordering: none
    show_null_labels: false
    y_axis_orientation: [left, left, right]
    width: 4
    height: 3
    top: 7
    left: 0

  - name: cpa_atc_last_30_days
    title: CPA Add to Cart (1d)
    type: looker_line
    model: finery_data
    explore: facebook_api_ad_performance
    dimensions: [facebook_api_ad_performance.calendar_date]
    measures: [facebook_api_ad_performance.1d_cpa_add_to_cart]
    filters:
      facebook_api_ad_performance.calendar_date: 30 days ago for 30 days
    listen:
      facebook_country: facebook_api_ad_performance.country
      facebook_acquisition_retention: facebook_api_ad_performance.buyers_vs_nonbuyers
    sorts: [facebook_api_ad_performance.calendar_date desc]
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axis_combined: false
    show_y_axis_labels: false
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    colors: [salmon]
    show_null_points: true
    interpolation: monotone
    ordering: none
    show_null_labels: false
    y_axis_orientation: [left, left, right]
    width: 4
    height: 3
    top: 7
    left: 4

  - name: cpa_sale_last_30_days
    title: CPA Sale (1d)
    type: looker_line
    model: finery_data
    explore: facebook_api_ad_performance
    dimensions: [facebook_api_ad_performance.calendar_date]
    measures: [facebook_api_ad_performance.1d_cpa_purchase]
    filters:
      facebook_api_ad_performance.calendar_date: 30 days ago for 30 days
    listen:
      facebook_country: facebook_api_ad_performance.country
      facebook_acquisition_retention: facebook_api_ad_performance.buyers_vs_nonbuyers
    sorts: [facebook_api_ad_performance.calendar_date desc]
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axis_combined: false
    show_y_axis_labels: false
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    colors: [salmon]
    show_null_points: true
    interpolation: monotone
    ordering: none
    show_null_labels: false
    y_axis_orientation: [left, left, right]
    width: 4
    height: 3
    top: 7
    left: 8

  - name: view_content_clicks_ratio
    title: 'View Content: Clicks (1d)'
    type: looker_line
    model: finery_data
    explore: facebook_api_ad_performance
    dimensions: [facebook_api_ad_performance.calendar_date]
    measures: [facebook_api_ad_performance.total_clicks, facebook_api_ad_performance.1d_total_action_view_content]
    dynamic_fields:
    - table_calculation: view_content_clicks_1d
      label: 'View Content: Clicks (1d)'
      expression: ${facebook_api_ad_performance.1d_total_action_view_content}/${facebook_api_ad_performance.total_clicks}
      value_format:
      value_format_name: percent_2
    filters:
      facebook_api_ad_performance.calendar_date: 30 days ago for 30 days
    listen:
      facebook_country: facebook_api_ad_performance.country
      facebook_acquisition_retention: facebook_api_ad_performance.buyers_vs_nonbuyers
    sorts: [facebook_api_ad_performance.calendar_date desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axis_combined: false
    show_y_axis_labels: false
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    colors: ['#7FCDAE', '#7ED09C', '#7DD389', '#85D67C', '#9AD97B', '#B1DB7A', '#CADF79',
      '#E2DF78', '#E5C877', '#E7AF75', '#EB9474', '#EE7772']
    show_null_points: true
    interpolation: monotone
    ordering: none
    show_null_labels: false
    y_axis_orientation: [left, left, right]
    hidden_fields: [facebook_api_ad_performance.total_clicks, facebook_api_ad_performance.1d_total_action_view_content]
    y_axis_value_format: 0%
    series_colors: {}
    width: 4
    height: 3
    top: 10
    left: 0

  - name: add_to_cart_view_content_ratio
    title: 'Add to Cart: View Content (1d)'
    type: looker_line
    model: finery_data
    explore: facebook_api_ad_performance
    dimensions: [facebook_api_ad_performance.calendar_date]
    measures: [facebook_api_ad_performance.1d_total_action_add_to_cart, facebook_api_ad_performance.1d_total_action_view_content]
    dynamic_fields:
    - table_calculation: add_to_cart_view_content_1d
      label: 'Add to Cart: View Content (1d)'
      expression: ${facebook_api_ad_performance.1d_total_action_add_to_cart}/${facebook_api_ad_performance.1d_total_action_view_content}
      value_format:
      value_format_name: percent_2
    filters:
      facebook_api_ad_performance.calendar_date: 30 days ago for 30 days
    listen:
      facebook_country: facebook_api_ad_performance.country
      facebook_acquisition_retention: facebook_api_ad_performance.buyers_vs_nonbuyers
    sorts: [facebook_api_ad_performance.calendar_date desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axis_combined: false
    show_y_axis_labels: false
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    colors: ['#7FCDAE', '#7ED09C', '#7DD389', '#85D67C', '#9AD97B', '#B1DB7A', '#CADF79',
      '#E2DF78', '#E5C877', '#E7AF75', '#EB9474', '#EE7772']
    show_null_points: true
    interpolation: monotone
    ordering: none
    show_null_labels: false
    y_axis_orientation: [left, left, right]
    hidden_fields: [facebook_api_ad_performance.1d_total_action_add_to_cart, facebook_api_ad_performance.1d_total_action_view_content]
    y_axis_value_format: 0%
    series_colors: {}
    width: 4
    height: 3
    top: 10
    left: 4

  - name: sale_add_to_cart_ratio
    title: 'Sale: Add to Cart (1d)'
    type: looker_line
    model: finery_data
    explore: facebook_api_ad_performance
    dimensions: [facebook_api_ad_performance.calendar_date]
    measures: [facebook_api_ad_performance.1d_total_action_add_to_cart, facebook_api_ad_performance.1d_total_action_purchase]
    dynamic_fields:
    - table_calculation: add_to_cart_view_content_1d
      label: 'Sale: Add to Cart (1d)'
      expression: ${facebook_api_ad_performance.1d_total_action_purchase}/${facebook_api_ad_performance.1d_total_action_add_to_cart}
      value_format:
      value_format_name: percent_2
    filters:
      facebook_api_ad_performance.calendar_date: 30 days ago for 30 days
    listen:
      facebook_country: facebook_api_ad_performance.country
      facebook_acquisition_retention: facebook_api_ad_performance.buyers_vs_nonbuyers
    sorts: [facebook_api_ad_performance.calendar_date desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axis_combined: false
    show_y_axis_labels: false
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    colors: ['#7FCDAE', '#7ED09C', '#7DD389', '#85D67C', '#9AD97B', '#B1DB7A', '#CADF79',
      '#E2DF78', '#E5C877', '#E7AF75', '#EB9474', '#EE7772']
    show_null_points: true
    interpolation: monotone
    ordering: none
    show_null_labels: false
    y_axis_orientation: [left, left, right]
    hidden_fields: [facebook_api_ad_performance.1d_total_action_add_to_cart, facebook_api_ad_performance.1d_total_action_purchase]
    y_axis_value_format: 0%
    series_colors: {}
    width: 4
    height: 3
    top: 10
    left: 8

  - name: fb_visits_and_orders_last_30_days
    title: FB Visits and Orders Last 30 Days
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [session_start_calendar.calendar_date_date]
    measures: [sessions.sum_orders, sessions.count]
    filters:
      session_start_calendar.calendar_date_date: 30 days ago for 30 days
      sessions.acquisition_channel: Facebook - Paid Marketing
    sorts: [session_start_calendar.calendar_date_date]
    limit: 500
    stacking: ''
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
      '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    show_value_labels: false
    label_density: 25
    legend_position: center
    y_axis_gridlines: true
    show_view_names: false
    series_colors:
      sessions.count: lightblue
      sessions.sum_orders: darkgreen
    series_types:
      sessions.count: column
      sessions.sum_orders: line
    y_axis_combined: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: true
    show_x_axis_ticks: false
    x_axis_scale: ordinal
    y_axis_orientation: [left, right]
    show_null_points: false
    point_style: none
    interpolation: monotone
    width: 6
    height: 4
    top: 13
    left: 0

  - name: fb_tracker
    title: Performance Overiew - Last 10 Weeks
    type: table
    model: finery_data
    explore: facebook_api_ad_performance
    dimensions: [facebook_api_ad_performance.calendar_week]
    measures: [facebook_api_ad_performance.total_spend, facebook_api_ad_performance.1d_total_action_purchase,
      facebook_api_ad_performance.1d_cpa_purchase, facebook_api_ad_performance.28d_cpa_purchase,
      facebook_api_ad_performance.28d_total_action_purchase, facebook_api_ad_performance.28d_average_basket]
    listen:
      facebook_country: facebook_api_ad_performance.country
      facebook_acquisition_retention: facebook_api_ad_performance.buyers_vs_nonbuyers
    filters:
      facebook_api_ad_performance.calendar_date: 9 weeks ago for 10 weeks
    sorts: [facebook_api_ad_performance.calendar_week]
    limit: 500
    show_view_names: true
    table_theme: editable
    width: 6
    height: 4
    top: 13
    left: 6

  - name: avg_relevance_score
    title: Avg Relevance Score
    type: looker_line
    model: finery_data
    explore: facebook_api_ad_performance
    dimensions: [facebook_api_ad_performance.calendar_date]
    measures: [facebook_api_ad_performance.avg_relevance_score]
    filters:
      facebook_api_ad_performance.calendar_date: 30 days ago for 30 days
    listen:
      facebook_country: facebook_api_ad_performance.country
      facebook_acquisition_retention: facebook_api_ad_performance.buyers_vs_nonbuyers
    sorts: [facebook_api_ad_performance.avg_relevance_score desc]
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
    limit_displayed_rows: false
    y_axis_combined: true
    y_axis_min: ['5']
    show_y_axis_labels: false
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    point_style: none
    interpolation: linear
    width: 6
    height: 4
    top: 17
    left: 0

  - name: avg_frequency
    title: Avg Frequency
    type: looker_line
    model: finery_data
    explore: facebook_api_ad_performance
    dimensions: [facebook_api_ad_performance.calendar_date]
    measures: [facebook_api_ad_performance.avg_frequency]
    filters:
      facebook_api_ad_performance.calendar_date: 30 days ago for 30 days
    listen:
      facebook_country: facebook_api_ad_performance.country
      facebook_acquisition_retention: facebook_api_ad_performance.buyers_vs_nonbuyers
    sorts: [facebook_api_ad_performance.avg_frequency desc]
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
    limit_displayed_rows: false
    y_axis_combined: true
    y_axis_min: ['1']
    show_y_axis_labels: false
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    point_style: none
    interpolation: linear
    width: 6
    height: 4
    top: 17
    left: 6
