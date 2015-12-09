- dashboard: facebook_campaigns
  title: Facebook Campaign Performance
  layout: static
  tile_size: 100

  filters:
  - name: date
    title: "Select date range"
    type: date_filter
    default_value: 7 days ago for 7 days
  - name: campaign
    title: "Select campaign"
    type: string_filter
    default_value: 'Brand Traffic Gen_Interest Audiences_NFM'

  elements:

  - name: all_campaigns_cpa
    title: All Campaigns - Cost per Order
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.campaign_name]
    measures: [facebook_daily_ad_performance.cpa_sale]
    filters:
      facebook_daily_ad_performance.calendar_date: 7 days ago for 7 days
    sorts: [facebook_daily_ad_performance.cpa_sale desc]
    limit: 500
    colors: ['#a6cee3']
    show_value_labels: true
    label_density: 25
    label_color: [red]
    font_size: 20px
    legend_position: center
    y_axis_gridlines: true
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_labels: [Cost per Order]
    y_axis_tick_density: default
    show_x_axis_ticks: true
    show_x_axis_label: false
    x_axis_scale: auto
    label_value_format: '"£" 0'
    top: 0
    left: 0
    height: 4
    width: 12
    
  - name: overall_campaign_performance_table
    title: All Campaigns Performance
    type: table
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.campaign_name]
    measures: [facebook_daily_ad_performance.total_spend, facebook_daily_ad_performance.total_impressions,
      facebook_daily_ad_performance.cost_per_mille, facebook_daily_ad_performance.total_website_clicks,
      facebook_daily_ad_performance.cost_per_website_click, facebook_daily_ad_performance.click_through_rate,
      facebook_daily_ad_performance.total_action_product_detail_page, facebook_daily_ad_performance.cpa_product_detail_page,
      facebook_daily_ad_performance.total_action_add_to_cart, facebook_daily_ad_performance.cpa_add_to_cart,
      facebook_daily_ad_performance.total_action_sale, facebook_daily_ad_performance.cpa_sale]
    listen:
     date: facebook_daily_ad_performance.calendar_date
    sorts: [facebook_daily_ad_performance.total_spend desc]
    limit: 500
    total: true
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
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    ordering: none
    show_null_labels: false
    show_row_numbers: false
    top: 4
    left: 0
    height: 5
    width: 12

  - name: adset_performance
    title: Adset Performance
    type: table
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.campaign_name, facebook_daily_ad_performance.adset_name]
    measures: [facebook_daily_ad_performance.total_spend, facebook_daily_ad_performance.total_impressions,
      facebook_daily_ad_performance.cost_per_mille, facebook_daily_ad_performance.total_website_clicks,
      facebook_daily_ad_performance.cost_per_website_click, facebook_daily_ad_performance.click_through_rate,
      facebook_daily_ad_performance.total_action_product_detail_page, facebook_daily_ad_performance.cpa_product_detail_page,
      facebook_daily_ad_performance.total_action_add_to_cart, facebook_daily_ad_performance.cpa_add_to_cart,
      facebook_daily_ad_performance.total_action_sale, facebook_daily_ad_performance.cpa_sale]
    listen:
     date: facebook_daily_ad_performance.calendar_date
     campaign: facebook_daily_ad_performance.campaign_name
    sorts: [facebook_daily_ad_performance.campaign_name desc, facebook_daily_ad_performance.adset_name desc]
    limit: 500
    total: true
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
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    ordering: none
    show_null_labels: false
    show_row_numbers: false
    top: 9
    left: 0
    height: 4
    width: 12

  - name: total_spend_for_campaign
    title: Total Spend
    type: looker_line
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_date]
    measures: [facebook_daily_ad_performance.total_spend]
    listen:
     date: facebook_daily_ad_performance.calendar_date
     campaign: facebook_daily_ad_performance.campaign_name
    sorts: [facebook_daily_ad_performance.calendar_date]
    limit: 500
    colors: ['#0000FF']
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
    top: 13
    left: 0
    height: 4
    width: 4

  - name: total_impressions_for_campaign
    title: Total Impressions
    type: looker_line
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_date]
    measures: [facebook_daily_ad_performance.total_impressions]
    listen:
     date: facebook_daily_ad_performance.calendar_date
     campaign: facebook_daily_ad_performance.campaign_name
    sorts: [facebook_daily_ad_performance.calendar_date]
    limit: 500
    colors: ['#800080']
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
    top: 13
    left: 4
    height: 4
    width: 4

  - name: total_website_clicks_for_campaign
    title: Total Website Clicks
    type: looker_line
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_date]
    measures: [facebook_daily_ad_performance.total_website_clicks]
    listen:
     date: facebook_daily_ad_performance.calendar_date
     campaign: facebook_daily_ad_performance.campaign_name
    sorts: [facebook_daily_ad_performance.calendar_date]
    limit: 500
    colors: ['#FF00FF']
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
    top: 13
    left: 8
    height: 4
    width: 4

  - name: cpm_for_campaign
    title: CPM
    type: looker_line
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_date]
    measures: [facebook_daily_ad_performance.cost_per_mille]
    listen:
     date: facebook_daily_ad_performance.calendar_date
     campaign: facebook_daily_ad_performance.campaign_name
    sorts: [facebook_daily_ad_performance.calendar_date]
    limit: 500
    colors: ['#A52A2A']
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
    top: 17
    left: 0
    height: 4
    width: 4

  - name: cpwc_for_campaign
    title: CPWC
    type: looker_line
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_date]
    measures: [facebook_daily_ad_performance.cost_per_website_click]
    listen:
     date: facebook_daily_ad_performance.calendar_date
     campaign: facebook_daily_ad_performance.campaign_name
    sorts: [facebook_daily_ad_performance.calendar_date]
    limit: 500
    colors: ['#808000']
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
    top: 17
    left: 4
    height: 4
    width: 4

  - name: ctr_for_campaign
    title: CTR
    type: looker_line
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_date]
    measures: [facebook_daily_ad_performance.click_through_rate]
    listen:
     date: facebook_daily_ad_performance.calendar_date
     campaign: facebook_daily_ad_performance.campaign_name
    sorts: [facebook_daily_ad_performance.calendar_date]
    limit: 500
    colors: ['#000000']
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
    top: 17
    left: 8
    height: 4
    width: 4

  - name: product_detail_for_campaign
    title: Product Detail Actions
    type: looker_line
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_date]
    measures: [facebook_daily_ad_performance.total_action_product_detail_page]
    listen:
     date: facebook_daily_ad_performance.calendar_date
     campaign: facebook_daily_ad_performance.campaign_name
    sorts: [facebook_daily_ad_performance.calendar_date]
    limit: 500
    colors: ['#808080']
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
    top: 21
    left: 0
    height: 4
    width: 6

  - name: cpa_product_detail_for_campaign
    title: CPA Product Detail
    type: looker_line
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_date]
    measures: [facebook_daily_ad_performance.cpa_product_detail_page]
    listen:
     date: facebook_daily_ad_performance.calendar_date
     campaign: facebook_daily_ad_performance.campaign_name
    sorts: [facebook_daily_ad_performance.calendar_date]
    limit: 500
    colors: ['#808080']
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
    reference_lines: [{reference_type: line, line_value: mean, range_start: max, range_end: min, margin_top: deviation, margin_value: mean, margin_bottom: deviation, color: Red, label: 'Averageg {{mean}}'}]
    top: 21
    left: 6
    height: 4
    width: 6

  - name: add_to_cart_for_campaign
    title: Add to Cart Actions
    type: looker_line
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_date]
    measures: [facebook_daily_ad_performance.total_action_add_to_cart]
    listen:
     date: facebook_daily_ad_performance.calendar_date
     campaign: facebook_daily_ad_performance.campaign_name
    sorts: [facebook_daily_ad_performance.calendar_date]
    limit: 500
    colors: ['#800080']
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
    top: 25
    left: 0
    height: 4
    width: 6

  - name: cpa_add_to_cart_for_campaign
    title: CPA Add to Cart
    type: looker_line
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_date]
    measures: [facebook_daily_ad_performance.cpa_add_to_cart]
    listen:
     date: facebook_daily_ad_performance.calendar_date
     campaign: facebook_daily_ad_performance.campaign_name
    sorts: [facebook_daily_ad_performance.calendar_date]
    limit: 500
    colors: ['#800080']
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
    reference_lines: [{reference_type: line, line_value: mean, range_start: max, range_end: min, margin_top: deviation, margin_value: mean, margin_bottom: deviation, color: Red, label: 'Averageg {{mean}}'}]
    top: 25
    left: 6
    height: 4
    width: 6

  - name: orders_for_campaign
    title: Orders
    type: looker_line
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_date]
    measures: [facebook_daily_ad_performance.total_action_sale]
    listen:
     date: facebook_daily_ad_performance.calendar_date
     campaign: facebook_daily_ad_performance.campaign_name
    sorts: [facebook_daily_ad_performance.calendar_date]
    limit: 500
    colors: ['#800000']
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
    top: 29
    left: 0
    height: 4
    width: 6

  - name: cpa_sale_for_campaign
    title: Cost per Order
    type: looker_line
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_date]
    measures: [facebook_daily_ad_performance.cpa_sale]
    listen:
     date: facebook_daily_ad_performance.calendar_date
     campaign: facebook_daily_ad_performance.campaign_name
    sorts: [facebook_daily_ad_performance.calendar_date]
    limit: 500
    colors: ['#800000']
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
    reference_lines: [{reference_type: line, line_value: mean, range_start: max, range_end: min, margin_top: deviation, margin_value: mean, margin_bottom: deviation, color: Red, label: 'Averageg {{mean}}'}]
    top: 29
    left: 6
    height: 4

  - name: web_data_all_campaigns
    title: Web Data - All Campaigns
    type: table
    model: finery_data
    explore: sessions
    dimensions: [sessions.campaign_name]
    measures: [sessions.count, sessions.engagement_rate, sessions.sum_orders, sessions.conversion_rate]
    listen:
     date: session_start_calendar.calendar_date_date
    filters:
      sessions.acquisition_channel: Facebook - Paid Marketing
      sessions.campaign_name: -NULL
      sessions.direct_session_flag: 'No'
      sessions.count: '>10'
    sorts: [sessions.count desc]
    limit: 500
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
    show_row_numbers: false
    top: 33
    left: 0
    height: 5
    width: 6

  - name: web_data_adset_performance
    title: Web Data - Adsets
    type: table
    model: finery_data
    explore: sessions
    dimensions: [sessions.campaign_name, sessions.campaign_content]
    measures: [sessions.count, sessions.engagement_rate, sessions.sum_orders, sessions.conversion_rate]
    listen:
     date: session_start_calendar.calendar_date_date
     campaign: sessions.campaign_name
    filters:
      sessions.acquisition_channel: Facebook - Paid Marketing
      sessions.direct_session_flag: 'No'
    sorts: [sessions.count desc]
    limit: 500
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
    show_row_numbers: false
    top: 33
    left: 6
    height: 5
    width: 6

