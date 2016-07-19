- dashboard: facebook_api_funnel_segment
  title: Facebook API Segments
  layout: static
  tile_size: 100


  filters:
  - name: facebook_country
    title: "Facebook Country"
    type: field_filter
    explore: facebook_api_ad_performance
    field: facebook_api_ad_performance.country
    default_value:
  
  #- name: sessions_country
  #  title: "Sessions Country"
  #  type: field_filter
  #  explore: sessions
  #  field: sessions.geography_country
  #  default_value:

  elements:
  
  - name: total_spend
    title: Total Spend
    type: looker_area
    model: finery_data
    explore: facebook_api_ad_performance
    dimensions: [facebook_api_ad_performance.calendar_date, facebook_api_ad_performance.audience_segment]
    pivots: [facebook_api_ad_performance.audience_segment]
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
    pivots: [facebook_api_ad_performance.audience_segment]
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
    pivots: [facebook_api_ad_performance.audience_segment]
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
    width: 4
    height: 4
    top: 0
    left: 8
    
  - name: cpm_last_30_days
    title: Cost per 1000 Impressions
    type: looker_area
    model: finery_data
    explore: facebook_api_ad_performance
    pivots: [facebook_api_ad_performance.audience_segment]
    dimensions: [facebook_api_ad_performance.calendar_date]
    measures: [facebook_api_ad_performance.cost_per_mille]
    filters:
      facebook_api_ad_performance.calendar_date: 30 days ago for 30 days
    listen: 
      country: facebook_api_ad_performance.country
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
    width: 4
    height: 4
    top: 4
    left: 0
    
  - name: cpc_last_30_days
    title: Cost per Click
    type: looker_area
    model: finery_data
    explore: facebook_api_ad_performance
    dimensions: [facebook_api_ad_performance.calendar_date]
    pivots: [facebook_api_ad_performance.audience_segment]
    measures: [facebook_api_ad_performance.cost_per_click]
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
    width: 4
    height: 4
    top: 4
    left: 8
    
  - name: ctr_last_30_days
    title: Click Through Rate
    type: looker_area
    model: finery_data
    explore: facebook_api_ad_performance
    pivots: [facebook_api_ad_performance.audience_segment]
    dimensions: [facebook_api_ad_performance.calendar_date]
    measures: [facebook_api_ad_performance.click_through_rate]
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
    width: 4
    height: 4
    top: 4
    left: 4