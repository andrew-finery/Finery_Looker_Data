- dashboard: facebook_campaigns_mobile
  title: Facebook Campaigns - Mobile
  layout: static
  tile_size: 100

  filters:
  - name: date
    title: "Select date range"
    type: date_filter
    default_value: 7 days ago for 7 days
  - name: campaign
    title: "Select campaign"
    type: field_filter
    model: finery_data
    explore: facebook_daily_ad_performance
    field: facebook_daily_ad_performance.campaign_name
    default_value: 'Brand - Mobile,Lookalikes - Mobile,Custom Audience - Mobile'
    
  elements:

  - name: spend_by_campaign
    title: Spend by Campaign
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.campaign_name]
    measures: [facebook_daily_ad_performance.total_spend]
    listen:
     date: facebook_daily_ad_performance.calendar_date
     campaign: facebook_daily_ad_performance.campaign_name
    sorts: [facebook_daily_ad_performance.campaign_name]
    limit: 500
    colors: ['#a6cee3']
    show_value_labels: true
    label_density: 25
    label_color: [red]
    font_size: 20px
    legend_position: center
    y_axis_gridlines: true
    y_axis_combined: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_ticks: true
    show_x_axis_label: false
    x_axis_scale: auto
    label_value_format: '"£" 0'
    top: 0
    left: 0
    height: 3
    width: 12
    
  - name: total_spend_for_campaign
    title: Total Spend
    type: looker_line
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_date]
    pivots: [facebook_daily_ad_performance.campaign_name]
    measures: [facebook_daily_ad_performance.total_spend]
    listen:
     date: facebook_daily_ad_performance.calendar_date
     campaign: facebook_daily_ad_performance.campaign_name
    sorts: [facebook_daily_ad_performance.calendar_date]
    limit: 500
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
    '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    label_density: '25'
    legend_position: center
    y_axis_gridlines: true
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    point_style: none
    interpolation: monotone
    top: 3
    left: 0
    height: 4
    width: 4

  - name: total_impressions_for_campaign
    title: Total Impressions
    type: looker_line
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_date]
    pivots: [facebook_daily_ad_performance.campaign_name]
    measures: [facebook_daily_ad_performance.total_impressions]
    listen:
     date: facebook_daily_ad_performance.calendar_date
     campaign: facebook_daily_ad_performance.campaign_name
    sorts: [facebook_daily_ad_performance.calendar_date]
    limit: 500
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
    '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    label_density: '25'
    legend_position: center
    y_axis_gridlines: true
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    point_style: none
    interpolation: monotone
    top: 3
    left: 4
    height: 4
    width: 4

  - name: total_website_clicks_for_campaign
    title: Total Website Clicks
    type: looker_line
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_date]
    pivots: [facebook_daily_ad_performance.campaign_name]
    measures: [facebook_daily_ad_performance.total_website_clicks]
    listen:
     date: facebook_daily_ad_performance.calendar_date
     campaign: facebook_daily_ad_performance.campaign_name
    sorts: [facebook_daily_ad_performance.calendar_date]
    limit: 500
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
    '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    label_density: '25'
    legend_position: center
    y_axis_gridlines: true
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    point_style: none
    interpolation: monotone
    top: 3
    left: 8
    height: 4
    width: 4

  - name: cpm_for_campaign
    title: CPM
    type: looker_line
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_date]
    pivots: [facebook_daily_ad_performance.campaign_name]
    measures: [facebook_daily_ad_performance.cost_per_mille]
    listen:
     date: facebook_daily_ad_performance.calendar_date
     campaign: facebook_daily_ad_performance.campaign_name
    sorts: [facebook_daily_ad_performance.calendar_date]
    limit: 500
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
    '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    label_density: '25'
    legend_position: center
    y_axis_gridlines: true
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    point_style: none
    interpolation: monotone
    top: 7
    left: 0
    height: 4
    width: 4

  - name: cpwc_for_campaign
    title: CPWC
    type: looker_line
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_date]
    pivots: [facebook_daily_ad_performance.campaign_name]
    measures: [facebook_daily_ad_performance.cost_per_website_click]
    listen:
     date: facebook_daily_ad_performance.calendar_date
     campaign: facebook_daily_ad_performance.campaign_name
    sorts: [facebook_daily_ad_performance.calendar_date]
    limit: 500
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
    '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    label_density: '25'
    legend_position: center
    y_axis_gridlines: true
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    point_style: none
    interpolation: monotone
    top: 7
    left: 4
    height: 4
    width: 4

  - name: ctr_for_campaign
    title: CTR
    type: looker_line
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_date]
    pivots: [facebook_daily_ad_performance.campaign_name]
    measures: [facebook_daily_ad_performance.click_through_rate]
    listen:
     date: facebook_daily_ad_performance.calendar_date
     campaign: facebook_daily_ad_performance.campaign_name
    sorts: [facebook_daily_ad_performance.calendar_date]
    limit: 500
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
    '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    label_density: '25'
    legend_position: center
    y_axis_gridlines: true
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    point_style: none
    interpolation: monotone
    top: 7
    left: 8
    height: 4
    width: 4

  - name: product_detail_for_campaign
    title: Product Detail Actions
    type: looker_line
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_date]
    pivots: [facebook_daily_ad_performance.campaign_name]
    measures: [facebook_daily_ad_performance.total_action_product_detail_page]
    listen:
     date: facebook_daily_ad_performance.calendar_date
     campaign: facebook_daily_ad_performance.campaign_name
    sorts: [facebook_daily_ad_performance.calendar_date]
    limit: 500
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
    '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    label_density: '25'
    legend_position: center
    y_axis_gridlines: true
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    point_style: none
    interpolation: monotone
    top: 11
    left: 0
    height: 4
    width: 6

  - name: cpa_product_detail_for_campaign
    title: CPA Product Detail
    type: looker_line
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_date]
    pivots: [facebook_daily_ad_performance.campaign_name]
    measures: [facebook_daily_ad_performance.cpa_product_detail_page]
    listen:
     date: facebook_daily_ad_performance.calendar_date
     campaign: facebook_daily_ad_performance.campaign_name
    sorts: [facebook_daily_ad_performance.calendar_date]
    limit: 500
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
    '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    label_density: '25'
    legend_position: center
    y_axis_gridlines: true
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    point_style: none
    interpolation: monotone
    top: 11
    left: 6
    height: 4
    width: 6

  - name: add_to_cart_for_campaign
    title: Add to Cart Actions
    type: looker_line
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_date]
    pivots: [facebook_daily_ad_performance.campaign_name]
    measures: [facebook_daily_ad_performance.total_action_add_to_cart]
    listen:
     date: facebook_daily_ad_performance.calendar_date
     campaign: facebook_daily_ad_performance.campaign_name
    sorts: [facebook_daily_ad_performance.calendar_date]
    limit: 500
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
    '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    label_density: '25'
    legend_position: center
    y_axis_gridlines: true
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    point_style: none
    interpolation: monotone
    top: 15
    left: 0
    height: 4
    width: 6

  - name: cpa_add_to_cart_for_campaign
    title: CPA Add to Cart
    type: looker_line
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_date]
    pivots: [facebook_daily_ad_performance.campaign_name]
    measures: [facebook_daily_ad_performance.cpa_add_to_cart]
    listen:
     date: facebook_daily_ad_performance.calendar_date
     campaign: facebook_daily_ad_performance.campaign_name
    sorts: [facebook_daily_ad_performance.calendar_date]
    limit: 500
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
    '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    label_density: '25'
    legend_position: center
    y_axis_gridlines: true
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    point_style: none
    interpolation: monotone
    top: 15
    left: 6
    height: 4
    width: 6

  - name: orders_for_campaign
    title: Orders
    type: looker_line
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_date]
    pivots: [facebook_daily_ad_performance.campaign_name]
    measures: [facebook_daily_ad_performance.total_action_sale]
    listen:
     date: facebook_daily_ad_performance.calendar_date
     campaign: facebook_daily_ad_performance.campaign_name
    sorts: [facebook_daily_ad_performance.calendar_date]
    limit: 500
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
    '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    label_density: '25'
    legend_position: center
    y_axis_gridlines: true
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    point_style: none
    interpolation: monotone
    top: 19
    left: 0
    height: 4
    width: 6

  - name: cpa_sale_for_campaign
    title: Cost per Order
    type: looker_line
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_date]
    pivots: [facebook_daily_ad_performance.campaign_name]
    measures: [facebook_daily_ad_performance.cpa_sale]
    listen:
     date: facebook_daily_ad_performance.calendar_date
     campaign: facebook_daily_ad_performance.campaign_name
    sorts: [facebook_daily_ad_performance.calendar_date]
    limit: 500
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
    '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    label_density: '25'
    legend_position: center
    y_axis_gridlines: true
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    point_style: none
    interpolation: monotone
    top: 19
    left: 6
    height: 4
