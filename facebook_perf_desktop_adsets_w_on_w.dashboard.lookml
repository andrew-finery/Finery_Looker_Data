- dashboard: facebook_desktop_adsets_week_on_week_1day
  title: Facebook Perf Desktop Adsets WonW 1day
  layout: static
  tile_size: 100

#  filters:

  elements:

  #ad0.1***************************************************************************************************************************************************
  - name: Desktop_Brand_Budget_Spend_Last_Week
    title: Desktop Brand Budget Spend-Last Week
    type: looker_pie
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.adset_name]
    measures: [facebook_daily_ad_performance_1day.total_spend]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 1 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Brand - Desktop"'
    sorts: [facebook_daily_ad_performance_1day.adset_name desc]
    limit: 500
    column_limit: 50
    value_labels: labels
    label_type: per
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_view_names: false
    top: 0
    left: 0
    height: 2
    width: 6
    
    #ad0.2***************************************************************************************************************************************************
  - name: Desktop_Brand_Budget_Spend_This_Week
    title: Desktop Brand Budget Spend-This Week
    type: looker_pie
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.adset_name]
    measures: [facebook_daily_ad_performance_1day.total_spend]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 1 weeks ago for 1 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Brand - Desktop"'
    sorts: [facebook_daily_ad_performance_1day.adset_name desc]
    limit: 500
    column_limit: 50
    value_labels: labels
    label_type: per
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_view_names: false
    top: 0
    left: 6
    height: 2
    width: 6

  

  #ad1.1***************************************************************************************************************************************************
  - name: Desktop_Brand_Beauty_Brands-Spend
    title: Desktop Brand Beauty Brands-Spend
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.total_spend]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Brand - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Beauty Brands"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
    '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 15px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 2
    left: 0
    height: 3
    width: 2
    
  - name: Desktop_Brand_Beauty_Brands_IMP
    title: Desktop Brand Beauty Brands-IMP
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.total_impressions]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Brand - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Beauty Brands"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 15px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 2
    left: 2
    height: 3
    width: 2

    
  - name: Desktop_Brand_Beauty_Brands_CPM
    title: Desktop Brand Beauty Brands-CPM
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.cost_per_mille]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Brand - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Beauty Brands"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 15px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 2
    left: 4
    height: 3
    width: 2
    
  - name: Desktop_Brand_Beauty_Brands_CTR
    title: Desktop Brand Beauty Brands-CTR
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.click_through_rate]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Brand - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Beauty Brands"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.click_through_rate]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 2
    left: 6
    height: 3
    width: 2
    
  
  - name: Desktop_Brand_Beauty_Brands_Actions
    title: Desktop Brand Beauty Brands-Actions
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    measures: [facebook_daily_ad_performance_1day.total_website_clicks, facebook_daily_ad_performance_1day.total_action_visit,
      facebook_daily_ad_performance_1day.total_action_product_detail_page, facebook_daily_ad_performance_1day.total_action_add_to_cart,
      facebook_daily_ad_performance_1day.total_action_sale]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Brand - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Beauty Brands"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 16px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 2
    left: 8
    height: 3
    width: 6
    
  - name: Desktop_Brand_Beauty_Brands_CPA
    title: Desktop Brand Beauty Brands-CPA
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    measures: [facebook_daily_ad_performance_1day.cost_per_website_click, facebook_daily_ad_performance_1day.cpa_visit,
      facebook_daily_ad_performance_1day.cpa_product_detail_page, facebook_daily_ad_performance_1day.cpa_add_to_cart,
      facebook_daily_ad_performance_1day.cpa_sale]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Brand - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Beauty Brands"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 16px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: false
    top: 2
    left: 14
    height: 3
    width: 6
    
    
    #ad1.2***************************************************************************************************************************************************
    
  - name: desktop_brand_fashion_brands_spend
    title: Desktop Brand Fashion Brands-Spend
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.total_spend]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Brand - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Fashion Brands"'
      
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
    '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 15px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 5
    left: 0
    height: 3
    width: 2
    
  - name: desktop_brand_fashion_brands_imp
    title: Desktop Brand Fashion Brands-IMP
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.total_impressions]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Brand - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Fashion Brands"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 15px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 5
    left: 2
    height: 3
    width: 2

    
  - name: desktop_brand_fashion_brands_cpm
    title: Desktop Brand Fashion Brands-CPM
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.cost_per_mille]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Brand - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Fashion Brands"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 15px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 5
    left: 4
    height: 3
    width: 2
    
  - name: desktop_brand_fashion_brands_ctr
    title: Desktop Brand Fashion Brands-CTR
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.click_through_rate]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Brand - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Fashion Brands"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.click_through_rate]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 5
    left: 6
    height: 3
    width: 2
    
  
  - name: desktop_brand_fashion_brands_actions
    title: Desktop Brand Fashion Brands-Actions
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    measures: [facebook_daily_ad_performance_1day.total_website_clicks, facebook_daily_ad_performance_1day.total_action_visit,
      facebook_daily_ad_performance_1day.total_action_product_detail_page, facebook_daily_ad_performance_1day.total_action_add_to_cart,
      facebook_daily_ad_performance_1day.total_action_sale]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Brand - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Fashion Brands"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 16px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 5
    left: 8
    height: 3
    width: 6
    
  - name: desktop_brand_fashion_brands_cpa
    title: Desktop Brand Fashion Brands-CPA
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    measures: [facebook_daily_ad_performance_1day.cost_per_website_click, facebook_daily_ad_performance_1day.cpa_visit,
      facebook_daily_ad_performance_1day.cpa_product_detail_page, facebook_daily_ad_performance_1day.cpa_add_to_cart,
      facebook_daily_ad_performance_1day.cpa_sale]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Brand - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Fashion Brands"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 16px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: false
    top: 5
    left: 14
    height: 3
    width: 6
    
    #ad1.3*************************************************************************************************************************
    
  - name: desktop_brand_fashion_magazines_spend
    title: Desktop Brand Fashion Magazines-Spend
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.total_spend]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Brand - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Fashion Magazines"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
    '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 15px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 8
    left: 0
    height: 3
    width: 2
    
  - name: desktop_brand_fashion_magazines_imp
    title: Desktop Brand Fashion Magazines-IMP
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.total_impressions]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Brand - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Fashion Magazines"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 15px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 8
    left: 2
    height: 3
    width: 2

    
  - name: desktop_brand_fashion_magazines_cpm
    title: Desktop Brand Fashion Magazines-CPM
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.cost_per_mille]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Brand - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Fashion Magazines"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 15px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 8
    left: 4
    height: 3
    width: 2
    
  - name: desktop_brand_fashion_magazines_ctr
    title: Desktop Brand Fashion Magazines-CTR
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.click_through_rate]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Brand - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Fashion Magazines"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.click_through_rate]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 8
    left: 6
    height: 3
    width: 2
    
  
  - name: desktop_brand_fashion_magazines_actions
    title: Desktop Brand Fashion Magazines-Actions
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    measures: [facebook_daily_ad_performance_1day.total_website_clicks, facebook_daily_ad_performance_1day.total_action_visit,
      facebook_daily_ad_performance_1day.total_action_product_detail_page, facebook_daily_ad_performance_1day.total_action_add_to_cart,
      facebook_daily_ad_performance_1day.total_action_sale]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Brand - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Fashion Magazines"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 16px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 8
    left: 8
    height: 3
    width: 6
    
  - name: desktop_brand_fashion_magazines_cpa
    title: Desktop Brand Fashion Magazines-CPA
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    measures: [facebook_daily_ad_performance_1day.cost_per_website_click, facebook_daily_ad_performance_1day.cpa_visit,
      facebook_daily_ad_performance_1day.cpa_product_detail_page, facebook_daily_ad_performance_1day.cpa_add_to_cart,
      facebook_daily_ad_performance_1day.cpa_sale]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Brand - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Fashion Magazines"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 16px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: false
    top: 8
    left: 14
    height: 3
    width: 6
    
    #ad1.4**********************************************************************************************************************

  - name: desktop_brand_travel_interests_spend
    title: Desktop Brand Travel Interests-Spend
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.total_spend]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Brand - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Travel Interests"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
    '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 15px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 11
    left: 0
    height: 3
    width: 2
    
  - name: desktop_brand_travel_interests_imp
    title: Desktop Brand Travel Interests-IMP
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.total_impressions]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Brand - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Travel Interests"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 15px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 11
    left: 2
    height: 3
    width: 2

    
  - name: desktop_brand_travel_interests_cpm
    title: Desktop Brand Travel Interests-CPM
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.cost_per_mille]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Brand - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Travel Interests"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 15px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 11
    left: 4
    height: 3
    width: 2
    
  - name: desktop_brand_travel_interests_ctr
    title: Desktop Brand Travel Interests CTR
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.click_through_rate]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Brand - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Travel Interests"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.click_through_rate]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 11
    left: 6
    height: 3
    width: 2
    
  
  - name: desktop_brand_travel_interests_actions
    title: Desktop Brand Travel Interests-Actions
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    measures: [facebook_daily_ad_performance_1day.total_website_clicks, facebook_daily_ad_performance_1day.total_action_visit,
      facebook_daily_ad_performance_1day.total_action_product_detail_page, facebook_daily_ad_performance_1day.total_action_add_to_cart,
      facebook_daily_ad_performance_1day.total_action_sale]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Brand - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Travel Interests"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 16px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 11
    left: 8
    height: 3
    width: 6
    
  - name: desktop_brand_travel_interests_cpa
    title: Desktop Brand Travel Interests-CPA
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    measures: [facebook_daily_ad_performance_1day.cost_per_website_click, facebook_daily_ad_performance_1day.cpa_visit,
      facebook_daily_ad_performance_1day.cpa_product_detail_page, facebook_daily_ad_performance_1day.cpa_add_to_cart,
      facebook_daily_ad_performance_1day.cpa_sale]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Brand - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Travel Interests"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 16px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: false
    top: 11
    left: 14
    height: 3
    width: 6
    
    #ad1.5************************************************************************************************************************
    
  - name: desktop_brand_dept_stores_spend
    title: Desktop Brand Dept Stores-Spend
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.total_spend]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Brand - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Dept Stores - Other Brands"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
    '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 15px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 14
    left: 0
    height: 3
    width: 2
    
  - name: desktop_brand_dept_stores_imp
    title: Desktop Brand Dept Stores-IMP
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.total_impressions]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Brand - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Dept Stores - Other Brands"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 15px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 14
    left: 2
    height: 3
    width: 2

    
  - name: desktop_brand_dept_stores_cpm
    title: Desktop Brand Dept Stores-CPM
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.cost_per_mille]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Brand - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Dept Stores - Other Brands"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 15px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 14
    left: 4
    height: 3
    width: 2
    
  - name: desktop_brand_dept_stores_ctr
    title: Desktop Brand Dept Stores CTR
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.click_through_rate]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Brand - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Dept Stores - Other Brands"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.click_through_rate]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 14
    left: 6
    height: 3
    width: 2
    
  
  - name: desktop_brand_dept_stores_actions
    title: Desktop Brand Dept Stores-Actions
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    measures: [facebook_daily_ad_performance_1day.total_website_clicks, facebook_daily_ad_performance_1day.total_action_visit,
      facebook_daily_ad_performance_1day.total_action_product_detail_page, facebook_daily_ad_performance_1day.total_action_add_to_cart,
      facebook_daily_ad_performance_1day.total_action_sale]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Brand - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Dept Stores - Other Brands"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 16px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 14
    left: 8
    height: 3
    width: 6
    
  - name: desktop_brand_dept_stores_cpa
    title: Desktop Brand Dept Stores-CPA
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    measures: [facebook_daily_ad_performance_1day.cost_per_website_click, facebook_daily_ad_performance_1day.cpa_visit,
      facebook_daily_ad_performance_1day.cpa_product_detail_page, facebook_daily_ad_performance_1day.cpa_add_to_cart,
      facebook_daily_ad_performance_1day.cpa_sale]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Brand - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Dept Stores - Other Brands"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 16px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: false
    top: 14
    left: 14
    height: 3
    width: 6
  
    #ad0.3**************************************************************************************************************************************
  - name: Desktop_Lookalikes_Budget_Spend_Last_Week
    title: Desktop Lookalikes Budget Spend-Last Week
    type: looker_pie
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.adset_name]
    measures: [facebook_daily_ad_performance_1day.total_spend]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 1 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
    sorts: [facebook_daily_ad_performance_1day.adset_name desc]
    limit: 500
    column_limit: 50
    value_labels: labels
    label_type: per
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_view_names: false
    top: 17
    left: 0
    height: 2
    width: 6
    
    #ad0.4***************************************************************************************************************************************************
  - name: Desktop_Lookalikes_Budget_Spend_This_Week
    title: Desktop Lookalikes Budget Spend-This Week
    type: looker_pie
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.adset_name]
    measures: [facebook_daily_ad_performance_1day.total_spend]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 1 weeks ago for 1 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
    sorts: [facebook_daily_ad_performance_1day.adset_name desc]
    limit: 500
    column_limit: 50
    value_labels: labels
    label_type: per
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_view_names: false
    top: 17
    left: 6
    height: 2
    width: 6
  
    
    #ad2.1***************************************************************************************************************************************************
  - name: desktop_lookalikes_email_list_1_spend
    title: Desktop Lookalikes Email List 1%-Spend
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.total_spend]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Email List Lookalike 1%"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
    '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 15px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 19
    left: 0
    height: 3
    width: 2
    
  - name: desktop_lookalikes_email_list_1_imp
    title: Desktop Lookalikes Email List 1%-IMP
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.total_impressions]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: 'Email List Lookalike 1%"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 15px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 19
    left: 2
    height: 3
    width: 2

    
  - name: desktop_lookalikes_email_list_1_cpm
    title: Desktop Lookalikes Email List 1%-CPM
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.cost_per_mille]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Email List Lookalike 1%"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 15px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 19
    left: 4
    height: 3
    width: 2
    
  - name: desktop_lookalikes_email_list_1_ctr
    title: Desktop Lookalikes Email List 1%-CTR
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.click_through_rate]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Email List Lookalike 1%"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.click_through_rate]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 19
    left: 6
    height: 3
    width: 2
    
  
  - name: desktop_lookalikes_email_list_1_actions
    title: Desktop Lookalikes Email List 1%-Actions
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    measures: [facebook_daily_ad_performance_1day.total_website_clicks, facebook_daily_ad_performance_1day.total_action_visit,
      facebook_daily_ad_performance_1day.total_action_product_detail_page, facebook_daily_ad_performance_1day.total_action_add_to_cart,
      facebook_daily_ad_performance_1day.total_action_sale]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Email List Lookalike 1%"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 16px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 19
    left: 8
    height: 3
    width: 6
    
  - name: desktop_lookalikes_email_list_1_cpa
    title: Desktop Lookalikes Email List 1%-CPA
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    measures: [facebook_daily_ad_performance_1day.cost_per_website_click, facebook_daily_ad_performance_1day.cpa_visit,
      facebook_daily_ad_performance_1day.cpa_product_detail_page, facebook_daily_ad_performance_1day.cpa_add_to_cart,
      facebook_daily_ad_performance_1day.cpa_sale]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Email List Lookalike 1%"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 16px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: false
    top: 19
    left: 14
    height: 3
    width: 6
    
    
    #ad2.2***************************************************************************************************************************************************
    
  - name: desktop_lookalikes_email_list_3%_spend
    title: Desktop Lookalikes Email List 3%-Spend
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.total_spend]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Email List Lookalike 3%"'
      
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
    '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 15px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 22
    left: 0
    height: 3
    width: 2
    
  - name: desktop_lookalikes_email_list_3%_imp
    title: Desktop Lookalikes Email List 3%-IMP
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.total_impressions]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Email List Lookalike 3%"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 15px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 22
    left: 2
    height: 3
    width: 2

    
  - name: desktop_lookalikes_email_list_3%_cpm
    title: Desktop Lookalikes Email List 3%-CPM
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.cost_per_mille]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Email List Lookalike 3%"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 15px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 22
    left: 4
    height: 3
    width: 2
    
  - name: desktop_lookalikes_email_list_3%_ctr
    title: Desktop Lookalikes Email List 3%-CTR
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.click_through_rate]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Email List Lookalike 3%"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.click_through_rate]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 22
    left: 6
    height: 3
    width: 2
    
  
  - name: desktop_lookalikes_email_list_3%_actions
    title: Desktop Lookalikes Email List 3%-Actions
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    measures: [facebook_daily_ad_performance_1day.total_website_clicks, facebook_daily_ad_performance_1day.total_action_visit,
      facebook_daily_ad_performance_1day.total_action_product_detail_page, facebook_daily_ad_performance_1day.total_action_add_to_cart,
      facebook_daily_ad_performance_1day.total_action_sale]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Email List Lookalike 3%"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 16px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 22
    left: 8
    height: 3
    width: 6
    
  - name: desktop_lookalikes_email_list_3%_cpa
    title: Desktop Lookalikes Email List 3%-CPA
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    measures: [facebook_daily_ad_performance_1day.cost_per_website_click, facebook_daily_ad_performance_1day.cpa_visit,
      facebook_daily_ad_performance_1day.cpa_product_detail_page, facebook_daily_ad_performance_1day.cpa_add_to_cart,
      facebook_daily_ad_performance_1day.cpa_sale]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Email List Lookalike 3%"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 16px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: false
    top: 22
    left: 14
    height: 3
    width: 6
    
    #ad2.3*************************************************************************************************************************
    
  - name: desktop_lookalikes_email_list_5%_spend
    title: Desktop Lookalikes Email List 5%-Spend
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.total_spend]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Email List Lookalike 5%"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
    '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 15px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 25
    left: 0
    height: 3
    width: 2
    
  - name: desktop_lookalikes_email_list_5%_imp
    title: Desktop Lookalikes Email List 5%-IMP
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.total_impressions]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Email List Lookalike 5%"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 15px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 25
    left: 2
    height: 3
    width: 2

    
  - name: desktop_lookalikes_email_list_5%_cpm
    title: Desktop Lookalikes Email List 5%-CPM
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.cost_per_mille]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Email List Lookalike 5%"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 15px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 25
    left: 4
    height: 3
    width: 2
    
  - name: desktop_lookalikes_email_list_5%_ctr
    title: Desktop Lookalikes Email List 5%-CTR
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.click_through_rate]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Email List Lookalike 5%"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.click_through_rate]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 25
    left: 6
    height: 3
    width: 2
    
  
  - name: desktop_lookalikes_email_list_5%_actions
    title: Desktop Lookalikes Email List 5%-Actions
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    measures: [facebook_daily_ad_performance_1day.total_website_clicks, facebook_daily_ad_performance_1day.total_action_visit,
      facebook_daily_ad_performance_1day.total_action_product_detail_page, facebook_daily_ad_performance_1day.total_action_add_to_cart,
      facebook_daily_ad_performance_1day.total_action_sale]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Email List Lookalike 5%"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 16px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 25
    left: 8
    height: 3
    width: 6
    
  - name: desktop_lookalikes_email_list_5%_cpa
    title: Desktop Lookalikes Email List 5%-CPA
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    measures: [facebook_daily_ad_performance_1day.cost_per_website_click, facebook_daily_ad_performance_1day.cpa_visit,
      facebook_daily_ad_performance_1day.cpa_product_detail_page, facebook_daily_ad_performance_1day.cpa_add_to_cart,
      facebook_daily_ad_performance_1day.cpa_sale]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Email List Lookalike 5%"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 16px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: false
    top: 25
    left: 14
    height: 3
    width: 6
    
    #ad2.4*************************************************************************************************************************

  - name: desktop_lookalikes_email_list_7%_spend
    title: Desktop Lookalikes Email List 7%-Spend
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.total_spend]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Email List Lookalike 7%"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
    '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 15px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 28
    left: 0
    height: 3
    width: 2
    
  - name: desktop_lookalikes_email_list_7%_imp
    title: Desktop Lookalikes Email List 7%-IMP
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.total_impressions]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Email List Lookalike 7%"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 15px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 28
    left: 2
    height: 3
    width: 2

    
  - name: desktop_lookalikes_email_list_7%_cpm
    title: Desktop Lookalikes Email List 7%-CPM
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.cost_per_mille]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Email List Lookalike 7%"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 15px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 28
    left: 4
    height: 3
    width: 2
    
  - name: desktop_lookalikes_email_list_7%_ctr
    title: Desktop Lookalikes Email List 7% CTR
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.click_through_rate]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Email List Lookalike 7%"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.click_through_rate]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 28
    left: 6
    height: 3
    width: 2
    
  
  - name: desktop_lookalikes_email_list_7%_actions
    title: Desktop Lookalikes Email List 7%-Actions
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    measures: [facebook_daily_ad_performance_1day.total_website_clicks, facebook_daily_ad_performance_1day.total_action_visit,
      facebook_daily_ad_performance_1day.total_action_product_detail_page, facebook_daily_ad_performance_1day.total_action_add_to_cart,
      facebook_daily_ad_performance_1day.total_action_sale]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Email List Lookalike 7%"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 16px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 28
    left: 8
    height: 3
    width: 6
    
  - name: desktop_lookalikes_email_list_7%_cpa
    title: Desktop Lookalikes Email List 7%-CPA
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    measures: [facebook_daily_ad_performance_1day.cost_per_website_click, facebook_daily_ad_performance_1day.cpa_visit,
      facebook_daily_ad_performance_1day.cpa_product_detail_page, facebook_daily_ad_performance_1day.cpa_add_to_cart,
      facebook_daily_ad_performance_1day.cpa_sale]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Email List Lookalike 7%"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 16px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: false
    top: 28
    left: 14
    height: 3
    width: 6
    
    #ad2.5*************************************************************************************************************************
    
  - name: desktop_lookalikes_buyers_1_spend
    title: Desktop Lookalikes Buyers 1%-Spend
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.total_spend]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Buyers Lookalike 1%"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
    '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 15px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 31
    left: 0
    height: 3
    width: 2
    
  - name: desktop_lookalikes_Buyers_1_imp
    title: Desktop Lookalikes Buyers 1%-IMP
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.total_impressions]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: 'Buyers Lookalike 1%"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 15px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 31
    left: 2
    height: 3
    width: 2

    
  - name: desktop_lookalikes_Buyers_1_cpm
    title: Desktop Lookalikes Buyers 1%-CPM
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.cost_per_mille]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Buyers Lookalike 1%"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 15px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 31
    left: 4
    height: 3
    width: 2
    
  - name: desktop_lookalikes_Buyers_1_ctr
    title: Desktop Lookalikes Buyers 1%-CTR
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.click_through_rate]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Buyers Lookalike 1%"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.click_through_rate]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 31
    left: 6
    height: 3
    width: 2
    
  
  - name: desktop_lookalikes_Buyers_1_actions
    title: Desktop Lookalikes Buyers 1%-Actions
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    measures: [facebook_daily_ad_performance_1day.total_website_clicks, facebook_daily_ad_performance_1day.total_action_visit,
      facebook_daily_ad_performance_1day.total_action_product_detail_page, facebook_daily_ad_performance_1day.total_action_add_to_cart,
      facebook_daily_ad_performance_1day.total_action_sale]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Buyers Lookalike 1%"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 16px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 31
    left: 8
    height: 3
    width: 6
    
  - name: desktop_lookalikes_Buyers_1_cpa
    title: Desktop Lookalikes Buyers 1%-CPA
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    measures: [facebook_daily_ad_performance_1day.cost_per_website_click, facebook_daily_ad_performance_1day.cpa_visit,
      facebook_daily_ad_performance_1day.cpa_product_detail_page, facebook_daily_ad_performance_1day.cpa_add_to_cart,
      facebook_daily_ad_performance_1day.cpa_sale]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Buyers Lookalike 1%"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 16px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: false
    top: 31
    left: 14
    height: 3
    width: 6
    
    
    #ad2.6***************************************************************************************************************************************************
    
  - name: desktop_lookalikes_Buyers_3%_spend
    title: Desktop Lookalikes Buyers 3%-Spend
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.total_spend]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Buyers Lookalike 3%"'
      
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
    '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 15px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 34
    left: 0
    height: 3
    width: 2
    
  - name: desktop_lookalikes_Buyers_3%_imp
    title: Desktop Lookalikes Buyers 3%-IMP
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.total_impressions]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Buyers Lookalike 3%"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 15px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 34
    left: 2
    height: 3
    width: 2

    
  - name: desktop_lookalikes_Buyerst_3%_cpm
    title: Desktop Lookalikes Buyers 3%-CPM
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.cost_per_mille]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Buyers Lookalike 3%"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 15px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 34
    left: 4
    height: 3
    width: 2
    
  - name: desktop_lookalikes_Buyers_3%_ctr
    title: Desktop Lookalikes Buyers 3%-CTR
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.click_through_rate]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Buyers Lookalike 3%"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.click_through_rate]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 34
    left: 6
    height: 3
    width: 2
    
  
  - name: desktop_lookalikes_Buyers_3%_actions
    title: Desktop Lookalikes Buyers 3%-Actions
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    measures: [facebook_daily_ad_performance_1day.total_website_clicks, facebook_daily_ad_performance_1day.total_action_visit,
      facebook_daily_ad_performance_1day.total_action_product_detail_page, facebook_daily_ad_performance_1day.total_action_add_to_cart,
      facebook_daily_ad_performance_1day.total_action_sale]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Buyers Lookalike 3%"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 16px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 34
    left: 8
    height: 3
    width: 6
    
  - name: desktop_lookalikes_Buyers_3%_cpa
    title: Desktop Lookalikes Buyers 3%-CPA
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    measures: [facebook_daily_ad_performance_1day.cost_per_website_click, facebook_daily_ad_performance_1day.cpa_visit,
      facebook_daily_ad_performance_1day.cpa_product_detail_page, facebook_daily_ad_performance_1day.cpa_add_to_cart,
      facebook_daily_ad_performance_1day.cpa_sale]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Buyers Lookalike 3%"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 16px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: false
    top: 34
    left: 14
    height: 3
    width: 6
    
    #ad2.7******************************************************************************************************************************************************************
    
  - name: desktop_lookalikes_Buyerst_5%_spend
    title: Desktop Lookalikes Buyers 5%-Spend
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.total_spend]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Buyers Lookalike 5%"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
    '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 15px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 37
    left: 0
    height: 3
    width: 2
    
  - name: desktop_lookalikes_Buyers_5%_imp
    title: Desktop Lookalikes Buyers 5%-IMP
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.total_impressions]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Buyers Lookalike 5%"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 15px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 37
    left: 2
    height: 3
    width: 2

    
  - name: desktop_lookalikes_Buyers_5%_cpm
    title: Desktop Lookalikes Buyers 5%-CPM
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.cost_per_mille]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Buyers Lookalike 5%"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 15px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 37
    left: 4
    height: 3
    width: 2
    
  - name: desktop_lookalikes_Buyers_5%_ctr
    title: Desktop Lookalikes Buyers 5%-CTR
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.click_through_rate]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Buyers Lookalike 5%"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.click_through_rate]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 37
    left: 6
    height: 3
    width: 2
    
  
  - name: desktop_lookalikes_Buyers_5%_actions
    title: Desktop Lookalikes Buyers 5%-Actions
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    measures: [facebook_daily_ad_performance_1day.total_website_clicks, facebook_daily_ad_performance_1day.total_action_visit,
      facebook_daily_ad_performance_1day.total_action_product_detail_page, facebook_daily_ad_performance_1day.total_action_add_to_cart,
      facebook_daily_ad_performance_1day.total_action_sale]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Buyers Lookalike 5%"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 16px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 37
    left: 8
    height: 3
    width: 6
    
  - name: desktop_lookalikes_Buyers_5%_cpa
    title: Desktop Lookalikes Buyers 5%-CPA
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    measures: [facebook_daily_ad_performance_1day.cost_per_website_click, facebook_daily_ad_performance_1day.cpa_visit,
      facebook_daily_ad_performance_1day.cpa_product_detail_page, facebook_daily_ad_performance_1day.cpa_add_to_cart,
      facebook_daily_ad_performance_1day.cpa_sale]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Buyers Lookalike 5%"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 16px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: false
    top: 37
    left: 14
    height: 3
    width: 6
    
    #ad2.8*****************************************************************************************************************************************************************

  - name: desktop_lookalikes_Buyers_7%_spend
    title: Desktop Lookalikes Buyers 7%-Spend
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.total_spend]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Buyers Lookalike 7%"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
    '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 15px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 40
    left: 0
    height: 3
    width: 2
    
  - name: desktop_lookalikes_Buyers_7%_imp
    title: Desktop Lookalikes Buyers 7%-IMP
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.total_impressions]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Buyers Lookalike 7%"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 15px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 40
    left: 2
    height: 3
    width: 2

    
  - name: desktop_lookalikes_Buyers_7%_cpm
    title: Desktop Lookalikes Buyers 7%-CPM
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.cost_per_mille]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Buyers Lookalike 7%"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 15px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 40
    left: 4
    height: 3
    width: 2
    
  - name: desktop_lookalikes_Buyers_7%_ctr
    title: Desktop Lookalikes Buyers 7% CTR
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.click_through_rate]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Buyers Lookalike 7%"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.click_through_rate]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 40
    left: 6
    height: 3
    width: 2
    
  
  - name: desktop_lookalikes_Buyers_7%_actions
    title: Desktop Lookalikes Buyers 7%-Actions
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    measures: [facebook_daily_ad_performance_1day.total_website_clicks, facebook_daily_ad_performance_1day.total_action_visit,
      facebook_daily_ad_performance_1day.total_action_product_detail_page, facebook_daily_ad_performance_1day.total_action_add_to_cart,
      facebook_daily_ad_performance_1day.total_action_sale]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Buyers Lookalike 7%"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 16px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 40
    left: 8
    height: 3
    width: 6
    
  - name: desktop_lookalikes_Buyers_7%_cpa
    title: Desktop Lookalikes Buyers 7%-CPA
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    measures: [facebook_daily_ad_performance_1day.cost_per_website_click, facebook_daily_ad_performance_1day.cpa_visit,
      facebook_daily_ad_performance_1day.cpa_product_detail_page, facebook_daily_ad_performance_1day.cpa_add_to_cart,
      facebook_daily_ad_performance_1day.cpa_sale]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Buyers Lookalike 7%"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 16px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: false
    top: 40
    left: 14
    height: 3
    width: 6
    
  #ad2.9***************************************************************************************************************************
  
  - name: desktop_visitors_3_spend
    title: Desktop Lookalikes Visitors 3%-Spend
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.total_spend]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Visitors Lookalike 3%"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
    '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 15px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 43
    left: 0
    height: 3
    width: 2
    
  - name: desktop_lookalikes_Visitors_3_imp
    title: Desktop Lookalikes Visitors 3%-IMP
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.total_impressions]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: 'Visitors Lookalike 3%"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 15px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 43
    left: 2
    height: 3
    width: 2

    
  - name: desktop_lookalikes_Visitors_3_cpm
    title: Desktop Lookalikes Visitors 3%-CPM
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.cost_per_mille]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Visitors Lookalike 3%"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 15px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 43
    left: 4
    height: 3
    width: 2
    
  - name: desktop_lookalikes_Visitors_3_ctr
    title: Desktop Lookalikes Visitors 3%-CTR
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.click_through_rate]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Visitors Lookalike 3%"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.click_through_rate]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 43
    left: 6
    height: 3
    width: 2
    
  
  - name: desktop_lookalikes_Visitors_3_actions
    title: Desktop Lookalikes Visitors 3%-Actions
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    measures: [facebook_daily_ad_performance_1day.total_website_clicks, facebook_daily_ad_performance_1day.total_action_visit,
      facebook_daily_ad_performance_1day.total_action_product_detail_page, facebook_daily_ad_performance_1day.total_action_add_to_cart,
      facebook_daily_ad_performance_1day.total_action_sale]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Visitors Lookalike 3%"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 16px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 43
    left: 8
    height: 3
    width: 6
    
  - name: desktop_lookalikes_Visitors_3_cpa
    title: Desktop Lookalikes Visitors 3%-CPA
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    measures: [facebook_daily_ad_performance_1day.cost_per_website_click, facebook_daily_ad_performance_1day.cpa_visit,
      facebook_daily_ad_performance_1day.cpa_product_detail_page, facebook_daily_ad_performance_1day.cpa_add_to_cart,
      facebook_daily_ad_performance_1day.cpa_sale]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Visitors Lookalike 3%"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 16px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: false
    top: 43
    left: 14
    height: 3
    width: 6
    
    
    #ad2.10***************************************************************************************************************************************************
    
  
  - name: desktop_lookalikes_Visitors_5%_spend
    title: Desktop Lookalikes Visitors 5%-Spend
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.total_spend]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Visitors Lookalike 5%"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
    '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 15px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 46
    left: 0
    height: 3
    width: 2
    
  - name: desktop_lookalikes_Visitors_5%_imp
    title: Desktop Lookalikes Visitors 5%-IMP
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.total_impressions]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Visitors Lookalike 5%"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 15px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 46
    left: 2
    height: 3
    width: 2

    
  - name: desktop_lookalikes_Visitorss_5%_cpm
    title: Desktop Lookalikes Visitors 5%-CPM
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.cost_per_mille]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Visitors Lookalike 5%"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 15px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 46
    left: 4
    height: 3
    width: 2
    
  - name: desktop_lookalikes_Visitors_5%_ctr
    title: Desktop Lookalikes Visitors 5%-CTR
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.click_through_rate]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Visitors Lookalike 5%"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.click_through_rate]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 46
    left: 6
    height: 3
    width: 2
    
  
  - name: desktop_lookalikes_Visitors_5%_actions
    title: Desktop Lookalikes Visitors 5%-Actions
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    measures: [facebook_daily_ad_performance_1day.total_website_clicks, facebook_daily_ad_performance_1day.total_action_visit,
      facebook_daily_ad_performance_1day.total_action_product_detail_page, facebook_daily_ad_performance_1day.total_action_add_to_cart,
      facebook_daily_ad_performance_1day.total_action_sale]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Visitors Lookalike 5%"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 16px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 46
    left: 8
    height: 3
    width: 6
    
  - name: desktop_lookalikes_Visitors_5%_cpa
    title: Desktop Lookalikes Visitors 5%-CPA
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    measures: [facebook_daily_ad_performance_1day.cost_per_website_click, facebook_daily_ad_performance_1day.cpa_visit,
      facebook_daily_ad_performance_1day.cpa_product_detail_page, facebook_daily_ad_performance_1day.cpa_add_to_cart,
      facebook_daily_ad_performance_1day.cpa_sale]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Visitors Lookalike 5%"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 16px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: false
    top: 46
    left: 14
    height: 3
    width: 6
    
    #ad2.11*****************************************************************************************************************************************************************

  - name: desktop_add_to_cart_3_spend
    title: Desktop Lookalikes Add To Cart 3%-Spend
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.total_spend]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Add To Cart Lookalike 3%"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
    '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 15px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 49
    left: 0
    height: 3
    width: 2
    
  - name: desktop_lookalikes_add_to_cart_3_imp
    title: Desktop Lookalikes Add To Cart 3%-IMP
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.total_impressions]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Add To Cart Lookalike 3%"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 15px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 49
    left: 2
    height: 3
    width: 2

    
  - name: desktop_lookalikes_add_to_cart_3_cpm
    title: Desktop Lookalikes Add To Cart 3%-CPM
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.cost_per_mille]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Add To Cart Lookalike 3%"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 15px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 49
    left: 4
    height: 3
    width: 2
    
  - name: desktop_lookalikes_add_to_cart_3_ctr
    title: Desktop Lookalikes Add To Cart 3%-CTR
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.click_through_rate]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Add To Cart Lookalike 3%"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.click_through_rate]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 49
    left: 6
    height: 3
    width: 2
    
  
  - name: desktop_lookalikes_add_to_cart_3_actions
    title: Desktop Lookalikes Add To Cart 3%-Actions
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    measures: [facebook_daily_ad_performance_1day.total_website_clicks, facebook_daily_ad_performance_1day.total_action_visit,
      facebook_daily_ad_performance_1day.total_action_product_detail_page, facebook_daily_ad_performance_1day.total_action_add_to_cart,
      facebook_daily_ad_performance_1day.total_action_sale]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Add To Cart Lookalike 3%"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 16px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 49
    left: 8
    height: 3
    width: 6
    
  - name: desktop_lookalikes_add_to_cart_3_cpa
    title: Desktop Lookalikes Add To Cart 3%-CPA
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    measures: [facebook_daily_ad_performance_1day.cost_per_website_click, facebook_daily_ad_performance_1day.cpa_visit,
      facebook_daily_ad_performance_1day.cpa_product_detail_page, facebook_daily_ad_performance_1day.cpa_add_to_cart,
      facebook_daily_ad_performance_1day.cpa_sale]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Add To Cart Lookalike 3%"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 16px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: false
    top: 49
    left: 14
    height: 3
    width: 6
    
    
    #ad2.12***************************************************************************************************************************************************
    
  
  - name: desktop_lookalikes_add_to_cart_5%_spend
    title: Desktop Lookalikes Add To Cart 5%-Spend
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.total_spend]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Add To Cart Lookalike 5%"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
    '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 15px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 52
    left: 0
    height: 3
    width: 2
    
  - name: desktop_lookalikes_add_to_cart_5%_imp
    title: Desktop Lookalikes Add To Cart 5%-IMP
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.total_impressions]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Add To Cart Lookalike 5%"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 15px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 52
    left: 2
    height: 3
    width: 2

    
  - name: desktop_lookalikes_add_to_cart_5%_cpm
    title: Desktop Lookalikes Add To Cart 5%-CPM
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.cost_per_mille]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Add To Cart Lookalike 5%"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 15px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 52
    left: 4
    height: 3
    width: 2
    
  - name: desktop_lookalikes_add_to_cart_5%_ctr
    title: Desktop Lookalikes Add To Cart 5%-CTR
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.click_through_rate]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Add To Cart Lookalike 5%"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.click_through_rate]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 52
    left: 6
    height: 3
    width: 2
    
  
  - name: desktop_lookalikes_add_to_cart_5%_actions
    title: Desktop Lookalikes Add To Cart 5%-Actions
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    measures: [facebook_daily_ad_performance_1day.total_website_clicks, facebook_daily_ad_performance_1day.total_action_visit,
      facebook_daily_ad_performance_1day.total_action_product_detail_page, facebook_daily_ad_performance_1day.total_action_add_to_cart,
      facebook_daily_ad_performance_1day.total_action_sale]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Add To Cart Lookalike 5%"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 16px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 52
    left: 8
    height: 3
    width: 6
    
  - name: desktop_lookalikes_add_to_cart_5%_cpa
    title: Desktop Lookalikes Add To Cart 5%-CPA
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    measures: [facebook_daily_ad_performance_1day.cost_per_website_click, facebook_daily_ad_performance_1day.cpa_visit,
      facebook_daily_ad_performance_1day.cpa_product_detail_page, facebook_daily_ad_performance_1day.cpa_add_to_cart,
      facebook_daily_ad_performance_1day.cpa_sale]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Lookalikes - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Add To Cart Lookalike 5%"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 16px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: false
    top: 52
    left: 14
    height: 3
    width: 6
    
    #ad0.5**************************************************************************************************************************************
  - name: Desktop_CA_Budget_Spend_Last_Week
    title: Desktop CA Budget Spend-Last Week
    type: looker_pie
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.adset_name]
    measures: [facebook_daily_ad_performance_1day.total_spend]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 1 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Custom Audience - Desktop"'
    sorts: [facebook_daily_ad_performance_1day.adset_name desc]
    limit: 500
    column_limit: 50
    value_labels: labels
    label_type: per
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_view_names: false
    top: 55
    left: 0
    height: 2
    width: 6
    
    #ad0.6***************************************************************************************************************************************************
  - name: Desktop_CA_Budget_Spend_This_Week
    title: Desktop CA Budget Spend-This Week
    type: looker_pie
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.adset_name]
    measures: [facebook_daily_ad_performance_1day.total_spend]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 1 weeks ago for 1 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Custom Audience - Desktop"'
    sorts: [facebook_daily_ad_performance_1day.adset_name desc]
    limit: 500
    column_limit: 50
    value_labels: labels
    label_type: per
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_view_names: false
    top: 55
    left: 6
    height: 2
    width: 6

    
    #ad3.1**************************************************************************************************************************************
    
  - name: desktop_ca_email_list_not_bought_spend
    title: Desktop CA Email List Not Bought-Spend
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.total_spend]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Custom Audience - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Email List Not Bought _NF All_20-55"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
    '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 15px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 57
    left: 0
    height: 3
    width: 2
    
  - name: desktop_ca_email_list_not_bought_imp
    title: Desktop CA Email List Not Bought-IMP
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.total_impressions]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Custom Audience - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Email List Not Bought _NF All_20-55"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 15px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 57
    left: 2
    height: 3
    width: 2

    
  - name: desktop_ca_email_list_not_bought_cpm
    title: Desktop CA Email List Not Bought-CPM
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.cost_per_mille]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Custom Audience - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Email List Not Bought _NF All_20-55"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 15px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 57
    left: 4
    height: 3
    width: 2
    
  - name: desktop_ca_email_list_not_bought_ctr
    title: Desktop CA Email List Not Bought-CTR
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.click_through_rate]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Custom Audience - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Email List Not Bought _NF All_20-55"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.click_through_rate]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 57
    left: 6
    height: 3
    width: 2
    
  
  - name: desktop_ca_email_list_not_bought_actions
    title: Desktop CA Email List Not Bought-Actions
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    measures: [facebook_daily_ad_performance_1day.total_website_clicks, facebook_daily_ad_performance_1day.total_action_visit,
      facebook_daily_ad_performance_1day.total_action_product_detail_page, facebook_daily_ad_performance_1day.total_action_add_to_cart,
      facebook_daily_ad_performance_1day.total_action_sale]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Custom Audience - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Email List Not Bought _NF All_20-55"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 16px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 57
    left: 8
    height: 3
    width: 6
    
  - name: desktop_ca_email_list_not_bought_cpa
    title: Desktop CA Email List Not Bought-CPA
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    measures: [facebook_daily_ad_performance_1day.cost_per_website_click, facebook_daily_ad_performance_1day.cpa_visit,
      facebook_daily_ad_performance_1day.cpa_product_detail_page, facebook_daily_ad_performance_1day.cpa_add_to_cart,
      facebook_daily_ad_performance_1day.cpa_sale]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Custom Audience - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Email List Not Bought _NF All_20-55"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 16px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: false
    top: 57
    left: 14
    height: 3
    width: 6
    
    #ad3.2**************************************************************************************************************************************
    
  - name: desktop_ca_add_to_cart_bought_spend
    title: Desktop CA Add To Cartt Not Bought-Spend
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.total_spend]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Custom Audience - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Add To Cart Not Bought_NF_All"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
    '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 15px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 60
    left: 0
    height: 3
    width: 2
    
  - name: desktop_ca_add_to_cart_bought_imp
    title: Desktop CA Add To Cart Not Bought-IMP
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.total_impressions]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Custom Audience - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Add To Cart Not Bought_NF_All"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 15px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 60
    left: 2
    height: 3
    width: 2

    
  - name: desktop_ca_add_to_cart_not_bought_cpm
    title: Desktop CA Add To Cart Not Bought-CPM
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.cost_per_mille]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Custom Audience - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Add To Cart Not Bought_NF_All"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 15px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 60
    left: 4
    height: 3
    width: 2
    
  - name: desktop_ca_add_to_cart_not_bought_ctr
    title: Desktop CA Add To Cart Not Bought-CTR
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.click_through_rate]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Custom Audience - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Add To Cart Not Bought_NF_All"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.click_through_rate]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 60
    left: 6
    height: 3
    width: 2
    
  
  - name: desktop_ca_add_to_cart_not_bought_actions
    title: Desktop CA Add To Cart Not Bought-Actions
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    measures: [facebook_daily_ad_performance_1day.total_website_clicks, facebook_daily_ad_performance_1day.total_action_visit,
      facebook_daily_ad_performance_1day.total_action_product_detail_page, facebook_daily_ad_performance_1day.total_action_add_to_cart,
      facebook_daily_ad_performance_1day.total_action_sale]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Custom Audience - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Add To Cart Not Bought_NF_All"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 16px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 60
    left: 8
    height: 3
    width: 6
    
  - name: desktop_ca_add_to_cart_not_bought_cpa
    title: Desktop CA Add To Cart Not Bought-CPA
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    measures: [facebook_daily_ad_performance_1day.cost_per_website_click, facebook_daily_ad_performance_1day.cpa_visit,
      facebook_daily_ad_performance_1day.cpa_product_detail_page, facebook_daily_ad_performance_1day.cpa_add_to_cart,
      facebook_daily_ad_performance_1day.cpa_sale]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Custom Audience - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Add To Cart Not Bought_NF_All"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 16px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: false
    top: 60
    left: 14
    height: 3
    width: 6
    
    #ad3.3**************************************************************************************************************************************
    
  - name: desktop_ca_visitors_non_bounce_spend
    title: Desktop CA Visitors Non Bounce-Spend
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.total_spend]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Custom Audience - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Visitors Non Bounce_NF_All"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
    '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 15px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 63
    left: 0
    height: 3
    width: 2
    
  - name: desktop_ca_visitors_non_bounce_imp
    title: Desktop CA Visitors Non Bounce-IMP
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.total_impressions]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Custom Audience - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Visitors Non Bounce_NF_All"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 15px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 63
    left: 2
    height: 3
    width: 2

    
  - name: desktop_ca_visitors_non_bounce_cpm
    title: Desktop CA Visitors Non Bounce-CPM
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.cost_per_mille]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Custom Audience - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Visitors Non Bounce_NF_All"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 15px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 63
    left: 4
    height: 3
    width: 2
    
  - name: desktop_ca_visitors_non_bounce_ctr
    title: Desktop CA Visitors Non Bounce-CTR
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.click_through_rate]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Custom Audience - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Visitors Non Bounce_NF_All"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.click_through_rate]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 63
    left: 6
    height: 3
    width: 2
    
  
  - name: desktop_ca_visitors_non_bounce_actions
    title: Desktop CA Visitors Non Bounce-Actions
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    measures: [facebook_daily_ad_performance_1day.total_website_clicks, facebook_daily_ad_performance_1day.total_action_visit,
      facebook_daily_ad_performance_1day.total_action_product_detail_page, facebook_daily_ad_performance_1day.total_action_add_to_cart,
      facebook_daily_ad_performance_1day.total_action_sale]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Custom Audience - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Visitors Non Bounce_NF_All"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 16px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 63
    left: 8
    height: 3
    width: 6
    
  - name: desktop_ca_visitors_non_bounce_cpa
    title: Desktop CA Visitors Non Bounce-CPA
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    measures: [facebook_daily_ad_performance_1day.cost_per_website_click, facebook_daily_ad_performance_1day.cpa_visit,
      facebook_daily_ad_performance_1day.cpa_product_detail_page, facebook_daily_ad_performance_1day.cpa_add_to_cart,
      facebook_daily_ad_performance_1day.cpa_sale]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"Custom Audience - Desktop"'
      facebook_daily_ad_performance_1day.adset_name: '"Visitors Non Bounce_NF_All"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 16px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: false
    top: 63
    left: 14
    height: 3
    width: 6
    
    #ad4.1**************************************************************************************************************************************
    
  - name: desktop_dpa_allvisitors_viewed_rhs_spend
    title: Desktop DPA All Visitors Viewed RHS-Spend
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.total_spend]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"DPA"'
      facebook_daily_ad_performance_1day.adset_name: '"All Visitors Viewed - RHS"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
    '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 15px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 69
    left: 0
    height: 3
    width: 2
    
  - name: desktop_dpa_allvisitors_viewed_rhs_imp
    title: Desktop DPA All Visitors Viewed RHS-IMP
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.total_impressions]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"DPA"'
      facebook_daily_ad_performance_1day.adset_name: '"All Visitors Viewed - RHS"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 15px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 69
    left: 2
    height: 3
    width: 2

    
  - name: desktop_dpa_allvisitors_viewed_rhs_cpm
    title: Desktop DPA All Visitors Viewed RHS-CPM
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.cost_per_mille]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"DPA"'
      facebook_daily_ad_performance_1day.adset_name: '"All Visitors Viewed - RHS"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 15px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 69
    left: 4
    height: 3
    width: 2
    
  - name: desktop_dpa_allvisitors_viewed_rhs_ctr
    title: Desktop DPA All Visitors Viewed RHS-CTR
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.click_through_rate]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"DPA"'
      facebook_daily_ad_performance_1day.adset_name: '"All Visitors Viewed - RHS"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.click_through_rate]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 69
    left: 6
    height: 3
    width: 2
    
  
  - name: desktop_dpa_allvisitors_viewed_rhs_actions
    title: Desktop DPA All Visitors Viewed RHS-Actions
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    measures: [facebook_daily_ad_performance_1day.total_website_clicks, facebook_daily_ad_performance_1day.total_action_visit,
      facebook_daily_ad_performance_1day.total_action_product_detail_page, facebook_daily_ad_performance_1day.total_action_add_to_cart,
      facebook_daily_ad_performance_1day.total_action_sale]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"DPA"'
      facebook_daily_ad_performance_1day.adset_name: '"All Visitors Viewed - RHS"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 16px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 69
    left: 8
    height: 3
    width: 6
    
  - name: desktop_dpa_allvisitors_viewed_rhs_cpa
    title: Desktop DPA All Visitors Viewed RHS-CPA
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    measures: [facebook_daily_ad_performance_1day.cost_per_website_click, facebook_daily_ad_performance_1day.cpa_visit,
      facebook_daily_ad_performance_1day.cpa_product_detail_page, facebook_daily_ad_performance_1day.cpa_add_to_cart,
      facebook_daily_ad_performance_1day.cpa_sale]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"DPA"'
      facebook_daily_ad_performance_1day.adset_name: '"All Visitors Viewed - RHS"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 16px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: false
    top: 69
    left: 14
    height: 3
    width: 6
  
  #ad4.2*************************************************************************************************************************************  
  - name: desktop_dpa_allvisitors_viewed_nfd_spend
    title: Desktop DPA All Visitors Viewed NFD-Spend
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.total_spend]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"DPA"'
      facebook_daily_ad_performance_1day.adset_name: '"All Visitors Viewed - NFD"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
    '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 15px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 72
    left: 0
    height: 3
    width: 2
    
  - name: desktop_dpa_allvisitors_viewed_NFD_imp
    title: Desktop DPA All Visitors Viewed NFD-IMP
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.total_impressions]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"DPA"'
      facebook_daily_ad_performance_1day.adset_name: '"All Visitors Viewed - NFD"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 15px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 72
    left: 2
    height: 3
    width: 2

    
  - name: desktop_dpa_allvisitors_viewed_NFDs_cpm
    title: Desktop DPA All Visitors Viewed NFD-CPM
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.cost_per_mille]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"DPA"'
      facebook_daily_ad_performance_1day.adset_name: '"All Visitors Viewed - NFD"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 15px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 72
    left: 4
    height: 3
    width: 2
    
  - name: desktop_dpa_allvisitors_viewed_NFD_ctr
    title: Desktop DPA All Visitors Viewed NFD-CTR
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    pivots: [facebook_daily_ad_performance_1day.calendar_week]
    measures: [facebook_daily_ad_performance_1day.click_through_rate]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"DPA"'
      facebook_daily_ad_performance_1day.adset_name: '"All Visitors Viewed - NFD"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.click_through_rate]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 72
    left: 6
    height: 3
    width: 2
    
  
  - name: desktop_dpa_allvisitors_viewed_NFD_actions
    title: Desktop DPA All Visitors Viewed NFD-Actions
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    measures: [facebook_daily_ad_performance_1day.total_website_clicks, facebook_daily_ad_performance_1day.total_action_visit,
      facebook_daily_ad_performance_1day.total_action_product_detail_page, facebook_daily_ad_performance_1day.total_action_add_to_cart,
      facebook_daily_ad_performance_1day.total_action_sale]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"DPA"'
      facebook_daily_ad_performance_1day.adset_name: '"All Visitors Viewed - NFD"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 16px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: true
    top: 72
    left: 8
    height: 3
    width: 6
    
  - name: desktop_dpa_allvisitors_viewed_NFD_cpa
    title: Desktop DPA All Visitors Viewed NFD-CPA
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance_1day
    dimensions: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    measures: [facebook_daily_ad_performance_1day.cost_per_website_click, facebook_daily_ad_performance_1day.cpa_visit,
      facebook_daily_ad_performance_1day.cpa_product_detail_page, facebook_daily_ad_performance_1day.cpa_add_to_cart,
      facebook_daily_ad_performance_1day.cpa_sale]
    filters:
      facebook_daily_ad_performance_1day.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance_1day.campaign_name: '"DPA"'
      facebook_daily_ad_performance_1day.adset_name: '"All Visitors Viewed - NFD"'
    sorts: [facebook_daily_ad_performance_1day.calendar_week, facebook_daily_ad_performance_1day.campaign_name]
    limit: 500
    column_limit: 50
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    font_size: 16px
    hide_legend: true
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: false
    top: 72
    left: 14
    height: 3
    width: 6
    
