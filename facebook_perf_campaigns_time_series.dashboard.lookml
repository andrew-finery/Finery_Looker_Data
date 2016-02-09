- dashboard: facebbok_campaign_performance_time_series
  title: Facebook Campaigns Performance Time Series
  layout: static
  tile_size: 100

  filters:
  - name: date
    title: "Select date range"
    type: date_filter
    default_value: last 10 days
  - name: campaign
    title: "Select campaign"
    type: string_filter
    default_value: 'Brand - Desktop'

  elements:
  
  - name: campaigns_time_series_spend
    title: Campaigns Spend
    type: looker_line
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_date, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.campaign_name]
    listen:
     date: facebook_daily_ad_performance_1day.calendar_date
     campaign: facebook_daily_ad_performance_1day.campaign_name
    measures: [facebook_daily_ad_performance_1day.total_spend]
    sorts: [facebook_daily_ad_performance_1day.calendar_date desc, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
      '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    show_value_labels: false
    label_density: 25
    legend_position: center
    hide_legend: false
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
    show_null_points: false
    point_style: circle_outline
    interpolation: linear
    discontinuous_nulls: false
    top: 0
    left: 0
    height: 4
    width: 10
    
  - name: campaign_time_series_brand_CPM
    title: Campaigns CPM
    type: looker_line
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_date, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.campaign_name]
    listen:
     date: facebook_daily_ad_performance_1day.calendar_date
     campaign: facebook_daily_ad_performance_1day.campaign_name
    measures: [facebook_daily_ad_performance_1day.cost_per_mille]
    sorts: [facebook_daily_ad_performance_1day.calendar_date desc, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
      '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    show_value_labels: false
    label_density: 25
    legend_position: center
    hide_legend: false
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
    show_null_points: false
    point_style: circle_outline
    interpolation: linear
    discontinuous_nulls: false
    top: 4
    left: 0
    height: 4
    width: 10
    
  - name: add_a_unique_name_1453996528913
    title: Campaigns Product CPA
    type: looker_line
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_date, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.campaign_name]
    listen:
     date: facebook_daily_ad_performance_1day.calendar_date
     campaign: facebook_daily_ad_performance_1day.campaign_name
    measures: [facebook_daily_ad_performance_1day.cpa_product_detail_page]
    sorts: [facebook_daily_ad_performance_1day.calendar_date desc, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
      '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    show_value_labels: false
    label_density: 25
    legend_position: center
    hide_legend: false
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
    show_null_points: false
    point_style: circle_outline
    interpolation: linear
    discontinuous_nulls: false
    top: 8
    left: 0
    height: 4
    width: 10
    
  - name: campaign_time_series_add_to_cart_cpa
    title: Campaigns AddtoCart CPA
    type: looker_line
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_date, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.campaign_name]
    listen:
     date: facebook_daily_ad_performance_1day.calendar_date
     campaign: facebook_daily_ad_performance_1day.campaign_name
    measures: [facebook_daily_ad_performance_1day.cpa_add_to_cart]
    sorts: [facebook_daily_ad_performance_1day.calendar_date desc, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
      '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    show_value_labels: false
    label_density: 25
    legend_position: center
    hide_legend: false
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
    show_null_points: false
    point_style: circle_outline
    interpolation: linear
    discontinuous_nulls: false
    top: 12
    left: 0
    height: 4
    width: 10
    
  - name: campaign_time_series_sale_cpa
    title: Campaigns Sale CPA
    type: looker_line
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_date, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.campaign_name]
    listen:
     date: facebook_daily_ad_performance_1day.calendar_date
     campaign: facebook_daily_ad_performance_1day.campaign_name
    measures: [facebook_daily_ad_performance_1day.cpa_sale]
    sorts: [facebook_daily_ad_performance_1day.calendar_date desc, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
      '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    show_value_labels: false
    label_density: 25
    legend_position: center
    hide_legend: false
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
    show_null_points: false
    point_style: circle_outline
    interpolation: linear
    discontinuous_nulls: false
    top: 16
    left: 0
    height: 4
    width: 10
    
  - name: campaign_time_series_ctr
    title: Campaigns Sale CTR
    type: looker_line
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_date, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.campaign_name]
    listen:
     date: facebook_daily_ad_performance_1day.calendar_date
     campaign: facebook_daily_ad_performance_1day.campaign_name
    measures: [facebook_daily_ad_performance_1day.click_through_rate]
    sorts: [facebook_daily_ad_performance_1day.calendar_date desc, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
      '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    show_value_labels: false
    label_density: 25
    legend_position: center
    hide_legend: false
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
    show_null_points: false
    point_style: circle_outline
    interpolation: linear
    discontinuous_nulls: false
    top: 20
    left: 0
    height: 4
    width: 10

  
