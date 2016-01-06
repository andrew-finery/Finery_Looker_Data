- dashboard: facebook_creative_performance
  title: Facebook Creative Performance
  layout: static
  tile_size: 100
  show_applied_filters: true

  filters:
  - name: date
    title: "Select date range"
    type: date_filter
    default_value: 7 days ago for 7 days

  elements:

  - name: overall_creative_performance_table
    title: All Creatives Performance
    type: table
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.creative_group]
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
    top: 0
    left: 0
    height: 3
    width: 12

  - name: creative_performance_desktop
    title: Creative Performance - Desktop Campaigns
    type: table
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.creative_group]
    measures: [facebook_daily_ad_performance.total_spend, facebook_daily_ad_performance.total_impressions,
      facebook_daily_ad_performance.cost_per_mille, facebook_daily_ad_performance.total_website_clicks,
      facebook_daily_ad_performance.cost_per_website_click, facebook_daily_ad_performance.click_through_rate,
      facebook_daily_ad_performance.total_action_product_detail_page, facebook_daily_ad_performance.cpa_product_detail_page,
      facebook_daily_ad_performance.total_action_add_to_cart, facebook_daily_ad_performance.cpa_add_to_cart,
      facebook_daily_ad_performance.total_action_sale, facebook_daily_ad_performance.cpa_sale]
    listen:
     date: facebook_daily_ad_performance.calendar_date
    filters:
      facebook_daily_ad_performance.campaign_name: 'Lookalikes - Desktop,Custom Audience - Desktop,Brand - Desktop'

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
    top: 3
    left: 0
    height: 3
    width: 12

  - name: creative_performance_mobile
    title: Creative Performance - Mobile Campaigns
    type: table
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.creative_group]
    measures: [facebook_daily_ad_performance.total_spend, facebook_daily_ad_performance.total_impressions,
      facebook_daily_ad_performance.cost_per_mille, facebook_daily_ad_performance.total_website_clicks,
      facebook_daily_ad_performance.cost_per_website_click, facebook_daily_ad_performance.click_through_rate,
      facebook_daily_ad_performance.total_action_product_detail_page, facebook_daily_ad_performance.cpa_product_detail_page,
      facebook_daily_ad_performance.total_action_add_to_cart, facebook_daily_ad_performance.cpa_add_to_cart,
      facebook_daily_ad_performance.total_action_sale, facebook_daily_ad_performance.cpa_sale]
    listen:
     date: facebook_daily_ad_performance.calendar_date
    filters:
      facebook_daily_ad_performance.campaign_name: 'Lookalikes - Mobile,Custom Audience - Mobile,Brand - Mobile'
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
    top: 6
    left: 0
    height: 3
    width: 12

  - name: creative_performance_dr
    title: Creative Performance - Custom Audiences and Lookalike Campaigns
    type: table
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.creative_group]
    measures: [facebook_daily_ad_performance.total_spend, facebook_daily_ad_performance.total_impressions,
      facebook_daily_ad_performance.cost_per_mille, facebook_daily_ad_performance.total_website_clicks,
      facebook_daily_ad_performance.cost_per_website_click, facebook_daily_ad_performance.click_through_rate,
      facebook_daily_ad_performance.total_action_product_detail_page, facebook_daily_ad_performance.cpa_product_detail_page,
      facebook_daily_ad_performance.total_action_add_to_cart, facebook_daily_ad_performance.cpa_add_to_cart,
      facebook_daily_ad_performance.total_action_sale, facebook_daily_ad_performance.cpa_sale]
    listen:
     date: facebook_daily_ad_performance.calendar_date
    filters:
      facebook_daily_ad_performance.campaign_name: 'Lookalikes - Desktop,Custom Audience - Desktop,Lookalikes - Mobile,Custom Audience - Mobile'
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
    top: 9
    left: 0
    height: 3
    width: 12

  - name: creative_performance_brand
    title: Creative Performance - Brand Campaigns
    type: table
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.creative_group]
    measures: [facebook_daily_ad_performance.total_spend, facebook_daily_ad_performance.total_impressions,
      facebook_daily_ad_performance.cost_per_mille, facebook_daily_ad_performance.total_website_clicks,
      facebook_daily_ad_performance.cost_per_website_click, facebook_daily_ad_performance.click_through_rate,
      facebook_daily_ad_performance.total_action_product_detail_page, facebook_daily_ad_performance.cpa_product_detail_page,
      facebook_daily_ad_performance.total_action_add_to_cart, facebook_daily_ad_performance.cpa_add_to_cart,
      facebook_daily_ad_performance.total_action_sale, facebook_daily_ad_performance.cpa_sale]
    listen:
     date: facebook_daily_ad_performance.calendar_date
    filters:
      facebook_daily_ad_performance.campaign_name: 'Brand - Mobile,Brand - Desktop'
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
    top: 12
    left: 0
    height: 3
    width: 12