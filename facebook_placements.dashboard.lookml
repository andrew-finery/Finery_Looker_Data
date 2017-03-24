- dashboard: facebook_placements
  title: Facebook Placements Dashboard
  layout: static
  tile_size: 100

  filters:
  - name: facebook_country
    title: "Facebook Country"
    type: field_filter
    explore: facebook_api_ad_performance
    field: facebook_api_ad_performance.country
    default_value:

  elements:
  
  - name: total_spend
    title: Total Spend
    type: looker_area
    model: finery_data
    explore: facebook_api_ad_performance
    dimensions: [facebook_api_ad_performance.calendar_date, facebook_api_ad_performance.placement]
    pivots: [facebook_api_ad_performance.placement]
    measures: [facebook_api_ad_performance.total_spend]
    filters:
      facebook_api_ad_performance.calendar_date: 30 days ago for 30 days
    sorts: [facebook_api_ad_performance.calendar_date desc]
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
    show_y_axis_labels: false
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    point_style: circle
    interpolation: monotone
    show_totals_labels: false
    show_silhouette: false
    totals_color: '#808080'
    show_null_points: false
    discontinuous_nulls: true
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
    pivots: [facebook_api_ad_performance.placement]
    measures: [facebook_api_ad_performance.total_impressions]
    filters:
      facebook_api_ad_performance.calendar_date: 30 days ago for 30 days
    listen: 
      facebook_country: facebook_api_ad_performance.country
    sorts: [facebook_api_ad_performance.calendar_date desc]
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
    show_y_axis_labels: false
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    point_style: circle
    interpolation: monotone
    show_totals_labels: false
    show_silhouette: false
    totals_color: '#808080'
    show_null_points: false
    discontinuous_nulls: true
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
    pivots: [facebook_api_ad_performance.placement]
    measures: [facebook_api_ad_performance.total_clicks]
    filters:
      facebook_api_ad_performance.calendar_date: 30 days ago for 30 days
    listen: 
      facebook_country: facebook_api_ad_performance.country
    sorts: [facebook_api_ad_performance.calendar_date desc]
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
    show_y_axis_labels: false
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    point_style: circle
    interpolation: monotone
    show_totals_labels: false
    show_silhouette: false
    totals_color: '#808080'
    show_null_points: false
    discontinuous_nulls: true
    width: 4
    height: 4
    top: 0
    left: 8
    
  - name: cpm_last_30_days
    title: Cost per 1000 Impressions
    type: looker_line
    model: finery_data
    explore: facebook_api_ad_performance
    pivots: [facebook_api_ad_performance.placement]
    dimensions: [facebook_api_ad_performance.calendar_date]
    measures: [facebook_api_ad_performance.cost_per_mille]
    filters:
      facebook_api_ad_performance.calendar_date: 30 days ago for 30 days
    listen: 
      facebook_country: facebook_api_ad_performance.country
    sorts: [facebook_api_ad_performance.calendar_date desc]
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
    show_y_axis_labels: false
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    point_style: none
    interpolation: monotone
    show_totals_labels: false
    show_silhouette: false
    totals_color: '#808080'
    show_null_points: false
    discontinuous_nulls: true
    width: 4
    height: 4
    top: 4
    left: 0
    
  - name: cpc_last_30_days
    title: Cost per Click
    type: looker_line
    model: finery_data
    explore: facebook_api_ad_performance
    dimensions: [facebook_api_ad_performance.calendar_date]
    pivots: [facebook_api_ad_performance.placement]
    measures: [facebook_api_ad_performance.cost_per_click]
    filters:
      facebook_api_ad_performance.calendar_date: 30 days ago for 30 days
    listen: 
      facebook_country: facebook_api_ad_performance.country
    sorts: [facebook_api_ad_performance.calendar_date desc]
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
    show_y_axis_labels: false
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    point_style: none
    interpolation: monotone
    show_totals_labels: false
    show_silhouette: false
    totals_color: '#808080'
    show_null_points: false
    discontinuous_nulls: true
    width: 4
    height: 4
    top: 4
    left: 8
    
  - name: ctr_last_30_days
    title: Click Through Rate
    type: looker_line
    model: finery_data
    explore: facebook_api_ad_performance
    pivots: [facebook_api_ad_performance.placement]
    dimensions: [facebook_api_ad_performance.calendar_date]
    measures: [facebook_api_ad_performance.click_through_rate]
    filters:
      facebook_api_ad_performance.calendar_date: 30 days ago for 30 days
    listen: 
      facebook_country: facebook_api_ad_performance.country
    sorts: [facebook_api_ad_performance.calendar_date desc]
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
    show_y_axis_labels: false
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    point_style: none
    interpolation: monotone
    show_totals_labels: false
    show_silhouette: false
    totals_color: '#808080'
    show_null_points: false
    discontinuous_nulls: true
    width: 4
    height: 4
    top: 4
    left: 4
    
  - name: view_content_cpa
    title: View Content CPA
    type: looker_line
    model: finery_data
    explore: facebook_api_ad_performance
    pivots: [facebook_api_ad_performance.placement]
    dimensions: [facebook_api_ad_performance.calendar_date]
    measures: [facebook_api_ad_performance.1d_cpa_product_view_content]
    filters:
      facebook_api_ad_performance.calendar_date: 30 days ago for 30 days
    listen: 
      facebook_country: facebook_api_ad_performance.country
    sorts: [facebook_api_ad_performance.calendar_date desc]
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
    show_y_axis_labels: false
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    point_style: none
    interpolation: monotone
    show_totals_labels: false
    show_silhouette: false
    totals_color: '#808080'
    show_null_points: false
    discontinuous_nulls: true
    width: 4
    height: 4
    top: 8
    left: 0
    
  - name: add_to_cart_cpa
    title: Add to Cart CPA
    type: looker_line
    model: finery_data
    explore: facebook_api_ad_performance
    pivots: [facebook_api_ad_performance.placement]
    dimensions: [facebook_api_ad_performance.calendar_date]
    measures: [facebook_api_ad_performance.1d_cpa_add_to_cart]
    filters:
      facebook_api_ad_performance.calendar_date: 30 days ago for 30 days
    listen: 
      facebook_country: facebook_api_ad_performance.country
    sorts: [facebook_api_ad_performance.calendar_date desc]
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
    show_y_axis_labels: false
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    point_style: none
    interpolation: monotone
    show_totals_labels: false
    show_silhouette: false
    totals_color: '#808080'
    show_null_points: false
    discontinuous_nulls: true
    width: 4
    height: 4
    top: 8
    left: 4
    
  - name: purchase_cpa
    title: Purchase CPA
    type: looker_line
    model: finery_data
    explore: facebook_api_ad_performance
    pivots: [facebook_api_ad_performance.placement]
    dimensions: [facebook_api_ad_performance.calendar_date]
    measures: [facebook_api_ad_performance.1d_cpa_purchase]
    filters:
      facebook_api_ad_performance.calendar_date: 30 days ago for 30 days
    listen: 
      facebook_country: facebook_api_ad_performance.country
    sorts: [facebook_api_ad_performance.calendar_date desc]
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
    show_y_axis_labels: false
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    point_style: none
    interpolation: monotone
    show_totals_labels: false
    show_silhouette: false
    totals_color: '#808080'
    show_null_points: false
    discontinuous_nulls: true
    width: 4
    height: 4
    top: 8
    left: 8
    
  - name: fb_tracker_mobile
    title: 10 Week Performance - Mobile
    type: table
    model: finery_data
    explore: facebook_api_ad_performance
    dimensions: [facebook_api_ad_performance.calendar_week]
    measures: [facebook_api_ad_performance.total_spend, facebook_api_ad_performance.1d_cpa_purchase,
      facebook_api_ad_performance.1d_total_action_purchase, facebook_api_ad_performance.28d_cpa_purchase,
      facebook_api_ad_performance.28d_total_action_purchase]
    filters:
      facebook_api_ad_performance.placement: Mobile
      facebook_api_ad_performance.calendar_date: 9 weeks ago for 10 weeks
    sorts: [facebook_api_ad_performance.calendar_week desc]
    limit: 500
    column_limit: 50
    show_view_names: false
    table_theme: editable
    limit_displayed_rows: false
    width: 6
    height: 4
    top: 12
    left: 0
    
  - name: fb_tracker_desktop
    title: 10 Week Performance - Desktop
    type: table
    model: finery_data
    explore: facebook_api_ad_performance
    dimensions: [facebook_api_ad_performance.calendar_week]
    measures: [facebook_api_ad_performance.total_spend, facebook_api_ad_performance.1d_cpa_purchase,
      facebook_api_ad_performance.1d_total_action_purchase, facebook_api_ad_performance.28d_cpa_purchase,
      facebook_api_ad_performance.28d_total_action_purchase]
    filters:
      facebook_api_ad_performance.placement: Desktop
      facebook_api_ad_performance.calendar_date: 9 weeks ago for 10 weeks
    sorts: [facebook_api_ad_performance.calendar_week desc]
    limit: 500
    column_limit: 50
    show_view_names: false
    table_theme: editable
    limit_displayed_rows: false
    width: 6
    height: 4
    top: 12
    left: 6
    
  - name: fb_tracker_instagram
    title: 10 Week Performance - Instagram
    type: table
    model: finery_data
    explore: facebook_api_ad_performance
    dimensions: [facebook_api_ad_performance.calendar_week]
    measures: [facebook_api_ad_performance.total_spend, facebook_api_ad_performance.1d_cpa_purchase,
      facebook_api_ad_performance.1d_total_action_purchase, facebook_api_ad_performance.28d_cpa_purchase,
      facebook_api_ad_performance.28d_total_action_purchase]
    filters:
      facebook_api_ad_performance.placement: Instagram
      facebook_api_ad_performance.calendar_date: 9 weeks ago for 10 weeks
    sorts: [facebook_api_ad_performance.calendar_week desc]
    limit: 500
    column_limit: 50
    show_view_names: false
    table_theme: editable
    limit_displayed_rows: false
    width: 6
    height: 4
    top: 16
    left: 0
    
  - name: segment_spend_split
    title: Spend Split - Last 10 Weeks
    type: looker_column
    model: finery_data
    explore: facebook_api_ad_performance_breakdown
    dimensions: [facebook_api_ad_performance_breakdown.calendar_week, facebook_api_ad_performance_breakdown.placement_general]
    pivots: [facebook_api_ad_performance_breakdown.placement_general]
    measures: [facebook_api_ad_performance_breakdown.total_spend]
    filters:
      facebook_api_ad_performance_breakdown.breakdown_type: placement
      facebook_api_ad_performance_breakdown.calendar_date: 10 weeks
    sorts: [facebook_api_ad_performance_breakdown.calendar_week desc, facebook_api_ad_performance_breakdown.placement_general]
    limit: 500
    column_limit: 50
    stacking: percent
    colors: ['#8dd3c7', '#ffed6f', '#bebada', '#fb8072', '#80b1d3', '#fdb462', '#b3de69',
      '#fccde5', '#d9d9d9', '#bc80bd', '#ccebc5', '#a3a3ff']
    show_value_labels: false
    label_density: 25
    legend_position: center
    hide_legend: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    ordering: none
    show_null_labels: false
    width: 6
    height: 4
    top: 16
    left: 6
    
  - name: avg_relevance_score
    title: Avg Relevance Score
    type: looker_line
    model: finery_data
    explore: facebook_api_ad_performance
    dimensions: [facebook_api_ad_performance.calendar_date]
    pivots: [facebook_api_ad_performance.placement]
    measures: [facebook_api_ad_performance.avg_relevance_score]
    filters:
      facebook_api_ad_performance.calendar_date: 30 days ago for 30 days
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
    y_axis_min: ['4']
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
    top: 20
    left: 0
    
  - name: avg_frequency
    title: Avg Frequency
    type: looker_line
    model: finery_data
    explore: facebook_api_ad_performance
    dimensions: [facebook_api_ad_performance.calendar_date]
    pivots: [facebook_api_ad_performance.placement]
    measures: [facebook_api_ad_performance.avg_frequency]
    filters:
      facebook_api_ad_performance.calendar_date: 30 days ago for 30 days
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
    top: 20
    left: 6
