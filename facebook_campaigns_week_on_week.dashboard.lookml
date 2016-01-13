- dashboard: facebook_campaigns_week_on_week
  title: Facebook Campaigns Week on Week
  layout: static
  tile_size: 100

#  filters:

  elements:
  
  
  #11111111111111111111111111111111111111***************************************************************************************************************************************************
  - name: add_a_unique_name_1452623003542
    title: Desktop Brand-Spend
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
    pivots: [facebook_daily_ad_performance.calendar_week]
    measures: [facebook_daily_ad_performance.total_spend]
    filters:
      facebook_daily_ad_performance.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance.campaign_name: '"Brand - Desktop"'
    sorts: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
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
    show_dropoff: false
    top: 0
    left: 0
    height: 3
    width: 2
    
  - name: add_a_unique_name_1452624394788
    title: Desktop Brand-IMP
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
    pivots: [facebook_daily_ad_performance.calendar_week]
    measures: [facebook_daily_ad_performance.total_impressions]
    filters:
      facebook_daily_ad_performance.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance.campaign_name: '"Brand - Desktop"'
    sorts: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
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
    show_dropoff: false
    top: 0
    left: 2
    height: 3
    width: 2

    
  - name: add_a_unique_name_1452624324842
    title: Desktop Brand-CPM
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
    pivots: [facebook_daily_ad_performance.calendar_week]
    measures: [facebook_daily_ad_performance.cost_per_mille]
    filters:
      facebook_daily_ad_performance.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance.campaign_name: '"Brand - Desktop"'
    sorts: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
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
    show_dropoff: false
    top: 0
    left: 4
    height: 3
    width: 2
    
  - name: add_a_unique_name_1452627849318
    title: Desktop Brand CTR
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
    pivots: [facebook_daily_ad_performance.calendar_week]
    measures: [facebook_daily_ad_performance.click_through_rate]
    filters:
      facebook_daily_ad_performance.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance.campaign_name: '"Brand - Desktop"'
    sorts: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.click_through_rate]
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
    show_dropoff: false
    top: 0
    left: 6
    height: 3
    width: 2
    
  
  - name: add_a_unique_name_1452625028839
    title: Desktop Brand-Actions
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
    measures: [facebook_daily_ad_performance.total_website_clicks, facebook_daily_ad_performance.total_action_visit,
      facebook_daily_ad_performance.total_action_product_detail_page, facebook_daily_ad_performance.total_action_add_to_cart,
      facebook_daily_ad_performance.total_action_sale]
    filters:
      facebook_daily_ad_performance.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance.campaign_name: '"Brand - Desktop"'
    sorts: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
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
    top: 0
    left: 8
    height: 3
    width: 6
    
  - name: add_a_unique_name_1452625300234
    title: Desktop Brand-CPA
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
    measures: [facebook_daily_ad_performance.cost_per_website_click, facebook_daily_ad_performance.cpa_visit,
      facebook_daily_ad_performance.cpa_product_detail_page, facebook_daily_ad_performance.cpa_add_to_cart,
      facebook_daily_ad_performance.cpa_sale]
    filters:
      facebook_daily_ad_performance.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance.campaign_name: '"Brand - Desktop"'
    sorts: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
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
    top: 0
    left: 14
    height: 3
    width: 6
    
    
    #22222222222222222222222222222222222***************************************************************************************************************************************************
    
  - name: desktop_lookalikes_spend
    title: Desktop Lookalikes-Spend
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
    pivots: [facebook_daily_ad_performance.calendar_week]
    measures: [facebook_daily_ad_performance.total_spend]
    filters:
      facebook_daily_ad_performance.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance.campaign_name: '"Lookalikes - Desktop"'
    sorts: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
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
    show_dropoff: false
    top: 3
    left: 0
    height: 3
    width: 2
    
  - name: desktop_lookalikes_imp
    title: Desktop Lookalikes-IMP
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
    pivots: [facebook_daily_ad_performance.calendar_week]
    measures: [facebook_daily_ad_performance.total_impressions]
    filters:
      facebook_daily_ad_performance.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance.campaign_name: '"Lookalikes - Desktop"'
    sorts: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
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
    show_dropoff: false
    top: 3
    left: 2
    height: 3
    width: 2

    
  - name: desktop_lookalikes_cpm
    title: Desktop Lookalikes-CPM
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
    pivots: [facebook_daily_ad_performance.calendar_week]
    measures: [facebook_daily_ad_performance.cost_per_mille]
    filters:
      facebook_daily_ad_performance.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance.campaign_name: '"Lookalikes - Desktop"'
    sorts: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
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
    show_dropoff: false
    top: 3
    left: 4
    height: 3
    width: 2
    
  - name: desktop_lookalikes_ctr
    title: Desktop Lookalikes-CTR
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
    pivots: [facebook_daily_ad_performance.calendar_week]
    measures: [facebook_daily_ad_performance.click_through_rate]
    filters:
      facebook_daily_ad_performance.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance.campaign_name: '"Lookalikes - Desktop"'
    sorts: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.click_through_rate]
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
    show_dropoff: false
    top: 3
    left: 6
    height: 3
    width: 2
    
  
  - name: desktop_lookalikes_actions
    title: Desktop Lookalikes-Actions
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
    measures: [facebook_daily_ad_performance.total_website_clicks, facebook_daily_ad_performance.total_action_visit,
      facebook_daily_ad_performance.total_action_product_detail_page, facebook_daily_ad_performance.total_action_add_to_cart,
      facebook_daily_ad_performance.total_action_sale]
    filters:
      facebook_daily_ad_performance.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance.campaign_name: '"Lookalikes - Desktop"'
    sorts: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
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
    top: 3
    left: 8
    height: 3
    width: 6
    
  - name: desktop_lookalikes_cpa
    title: Desktop Lookalikes-CPA
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
    measures: [facebook_daily_ad_performance.cost_per_website_click, facebook_daily_ad_performance.cpa_visit,
      facebook_daily_ad_performance.cpa_product_detail_page, facebook_daily_ad_performance.cpa_add_to_cart,
      facebook_daily_ad_performance.cpa_sale]
    filters:
      facebook_daily_ad_performance.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance.campaign_name: '"Lookalikes - Desktop"'
    sorts: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
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
    top: 3
    left: 14
    height: 3
    width: 6
    
    #33333333333333333333333333333333333333333333*************************************************************************************************************************
    
  - name: desktop_ca_spend
    title: Desktop CA-Spend
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
    pivots: [facebook_daily_ad_performance.calendar_week]
    measures: [facebook_daily_ad_performance.total_spend]
    filters:
      facebook_daily_ad_performance.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance.campaign_name: '"Custom Audience - Desktop"'
    sorts: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
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
    show_dropoff: false
    top: 6
    left: 0
    height: 3
    width: 2
    
  - name: desktop_ca_imp
    title: Desktop CA-IMP
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
    pivots: [facebook_daily_ad_performance.calendar_week]
    measures: [facebook_daily_ad_performance.total_impressions]
    filters:
      facebook_daily_ad_performance.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance.campaign_name: '"Custom Audience - Desktop"'
    sorts: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
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
    show_dropoff: false
    top: 6
    left: 2
    height: 3
    width: 2

    
  - name: desktop_ca_cpm
    title: Desktop CA-CPM
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
    pivots: [facebook_daily_ad_performance.calendar_week]
    measures: [facebook_daily_ad_performance.cost_per_mille]
    filters:
      facebook_daily_ad_performance.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance.campaign_name: '"Custom Audience - Desktop"'
    sorts: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
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
    show_dropoff: false
    top: 6
    left: 4
    height: 3
    width: 2
    
  - name: desktop_ca_ctr
    title: Desktop CA-CTR
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
    pivots: [facebook_daily_ad_performance.calendar_week]
    measures: [facebook_daily_ad_performance.click_through_rate]
    filters:
      facebook_daily_ad_performance.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance.campaign_name: '"Custom Audience - Desktop"'
    sorts: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.click_through_rate]
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
    show_dropoff: false
    top: 6
    left: 6
    height: 3
    width: 2
    
  
  - name: desktop_ca_actions
    title: Desktop CA-Actions
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
    measures: [facebook_daily_ad_performance.total_website_clicks, facebook_daily_ad_performance.total_action_visit,
      facebook_daily_ad_performance.total_action_product_detail_page, facebook_daily_ad_performance.total_action_add_to_cart,
      facebook_daily_ad_performance.total_action_sale]
    filters:
      facebook_daily_ad_performance.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance.campaign_name: '"Custom Audience - Desktop"'
    sorts: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
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
    top: 6
    left: 8
    height: 3
    width: 6
    
  - name: desktop_ca_cpa
    title: Desktop CA-CPA
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
    measures: [facebook_daily_ad_performance.cost_per_website_click, facebook_daily_ad_performance.cpa_visit,
      facebook_daily_ad_performance.cpa_product_detail_page, facebook_daily_ad_performance.cpa_add_to_cart,
      facebook_daily_ad_performance.cpa_sale]
    filters:
      facebook_daily_ad_performance.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance.campaign_name: '"Custom Audience - Desktop"'
    sorts: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
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
    top: 6
    left: 14
    height: 3
    width: 6
    
    #44444444444444444444444444444444444444444444444444444444444444*************************************************************************************************************************

  - name: mobile_brand_spend
    title: Mobile Brand-Spend
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
    pivots: [facebook_daily_ad_performance.calendar_week]
    measures: [facebook_daily_ad_performance.total_spend]
    filters:
      facebook_daily_ad_performance.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance.campaign_name: '"Brand - Mobile"'
    sorts: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
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
    show_dropoff: false
    top: 10
    left: 0
    height: 3
    width: 2
    
  - name: mobile_brand_imp
    title: Mobile Brand-IMP
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
    pivots: [facebook_daily_ad_performance.calendar_week]
    measures: [facebook_daily_ad_performance.total_impressions]
    filters:
      facebook_daily_ad_performance.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance.campaign_name: '"Brand - Mobile"'
    sorts: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
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
    show_dropoff: false
    top: 10
    left: 2
    height: 3
    width: 2

    
  - name: mobile_brand_cpm
    title: Mobile Brand-CPM
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
    pivots: [facebook_daily_ad_performance.calendar_week]
    measures: [facebook_daily_ad_performance.cost_per_mille]
    filters:
      facebook_daily_ad_performance.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance.campaign_name: '"Brand - Mobile"'
    sorts: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
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
    show_dropoff: false
    top: 10
    left: 4
    height: 3
    width: 2
    
  - name: mobile_brand_ctr
    title: Mobile Brand CTR
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
    pivots: [facebook_daily_ad_performance.calendar_week]
    measures: [facebook_daily_ad_performance.click_through_rate]
    filters:
      facebook_daily_ad_performance.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance.campaign_name: '"Brand - Mobile"'
    sorts: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.click_through_rate]
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
    show_dropoff: false
    top: 10
    left: 6
    height: 3
    width: 2
    
  
  - name: mobile_brand_actions
    title: Mobile Brand-Actions
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
    measures: [facebook_daily_ad_performance.total_website_clicks, facebook_daily_ad_performance.total_action_visit,
      facebook_daily_ad_performance.total_action_product_detail_page, facebook_daily_ad_performance.total_action_add_to_cart,
      facebook_daily_ad_performance.total_action_sale]
    filters:
      facebook_daily_ad_performance.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance.campaign_name: '"Brand - Mobile"'
    sorts: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
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
    top: 10
    left: 8
    height: 3
    width: 6
    
  - name: mobile_brand_cpa
    title: Mobile Brand-CPA
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
    measures: [facebook_daily_ad_performance.cost_per_website_click, facebook_daily_ad_performance.cpa_visit,
      facebook_daily_ad_performance.cpa_product_detail_page, facebook_daily_ad_performance.cpa_add_to_cart,
      facebook_daily_ad_performance.cpa_sale]
    filters:
      facebook_daily_ad_performance.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance.campaign_name: '"Brand - Mobile"'
    sorts: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
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
    top: 10
    left: 14
    height: 3
    width: 6
    
    #55555555555555555555555555555555555555555555555555555555555555*************************************************************************************************************************
    
  - name: mobile_lookalikes_spend
    title: Mobile Lookalikes-Spend
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
    pivots: [facebook_daily_ad_performance.calendar_week]
    measures: [facebook_daily_ad_performance.total_spend]
    filters:
      facebook_daily_ad_performance.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance.campaign_name: '"Lookalikes - Mobile"'
    sorts: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
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
    top: 13
    left: 0
    height: 3
    width: 2
    
  - name: mobile_lookalikes_imp
    title: Mobile Lookalikes-IMP
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
    pivots: [facebook_daily_ad_performance.calendar_week]
    measures: [facebook_daily_ad_performance.total_impressions]
    filters:
      facebook_daily_ad_performance.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance.campaign_name: '"Lookalikes - Mobile"'
    sorts: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
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
    top: 13
    left: 2
    height: 3
    width: 2

    
  - name: mobile_lookalikes_cpm
    title: Mobile Lookalikes-CPM
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
    pivots: [facebook_daily_ad_performance.calendar_week]
    measures: [facebook_daily_ad_performance.cost_per_mille]
    filters:
      facebook_daily_ad_performance.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance.campaign_name: '"Lookalikes - Mobile"'
    sorts: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
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
    top: 13
    left: 4
    height: 3
    width: 2
    
  - name: mobile_lookalikes_ctr
    title: Mobile Lookalikes CTR
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
    pivots: [facebook_daily_ad_performance.calendar_week]
    measures: [facebook_daily_ad_performance.click_through_rate]
    filters:
      facebook_daily_ad_performance.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance.campaign_name: '"Lookalikes - Mobile"'
    sorts: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.click_through_rate]
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
    top: 13
    left: 6
    height: 3
    width: 2
    
  
  - name: mobile_lookalikes_actions
    title: Mobile Lookalikes-Actions
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
    measures: [facebook_daily_ad_performance.total_website_clicks, facebook_daily_ad_performance.total_action_visit,
      facebook_daily_ad_performance.total_action_product_detail_page, facebook_daily_ad_performance.total_action_add_to_cart,
      facebook_daily_ad_performance.total_action_sale]
    filters:
      facebook_daily_ad_performance.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance.campaign_name: '"Lookalikes - Mobile"'
    sorts: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
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
    top: 13
    left: 8
    height: 3
    width: 6
    
  - name: mobile_lookalikes_cpa
    title: Mobile Lookalikes-CPA
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
    measures: [facebook_daily_ad_performance.cost_per_website_click, facebook_daily_ad_performance.cpa_visit,
      facebook_daily_ad_performance.cpa_product_detail_page, facebook_daily_ad_performance.cpa_add_to_cart,
      facebook_daily_ad_performance.cpa_sale]
    filters:
      facebook_daily_ad_performance.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance.campaign_name: '"Lookalikes - Mobile"'
    sorts: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
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
    top: 13
    left: 14
    height: 3
    width: 6
    
    #66666666666666666666666666666666666666666666666****************************************************************************************************
  
  - name: mobile_ca_spend
    title: Mobile CA-Spend
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
    pivots: [facebook_daily_ad_performance.calendar_week]
    measures: [facebook_daily_ad_performance.total_spend]
    filters:
      facebook_daily_ad_performance.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance.campaign_name: '"Custom Audience - Mobile"'
    sorts: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
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
    top: 16
    left: 0
    height: 3
    width: 2
    
  - name: mobile_ca_imp
    title: Mobile CA-IMP
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
    pivots: [facebook_daily_ad_performance.calendar_week]
    measures: [facebook_daily_ad_performance.total_impressions]
    filters:
      facebook_daily_ad_performance.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance.campaign_name: '"Custom Audience - Mobile"'
    sorts: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
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
    top: 16
    left: 2
    height: 3
    width: 2

    
  - name: mobile_ca_cpm
    title: Mobile CA-CPM
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
    pivots: [facebook_daily_ad_performance.calendar_week]
    measures: [facebook_daily_ad_performance.cost_per_mille]
    filters:
      facebook_daily_ad_performance.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance.campaign_name: '"Custom Audience - Mobile"'
    sorts: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
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
    top: 16
    left: 4
    height: 3
    width: 2
    
  - name: mobile_ca_ctr
    title: Mobile CA CTR
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
    pivots: [facebook_daily_ad_performance.calendar_week]
    measures: [facebook_daily_ad_performance.click_through_rate]
    filters:
      facebook_daily_ad_performance.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance.campaign_name: '"Custom Audience - Mobile"'
    sorts: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.click_through_rate]
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
    top: 16
    left: 6
    height: 3
    width: 2
    
  
  - name: mobile_ca_actions
    title: Mobile CA-Actions
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
    measures: [facebook_daily_ad_performance.total_website_clicks, facebook_daily_ad_performance.total_action_visit,
      facebook_daily_ad_performance.total_action_product_detail_page, facebook_daily_ad_performance.total_action_add_to_cart,
      facebook_daily_ad_performance.total_action_sale]
    filters:
      facebook_daily_ad_performance.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance.campaign_name: '"Custom Audience - Mobile"'
    sorts: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
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
    top: 16
    left: 8
    height: 3
    width: 6
    
  - name: mobile_ca_cpa
    title: Mobile CA-CPA
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
    measures: [facebook_daily_ad_performance.cost_per_website_click, facebook_daily_ad_performance.cpa_visit,
      facebook_daily_ad_performance.cpa_product_detail_page, facebook_daily_ad_performance.cpa_add_to_cart,
      facebook_daily_ad_performance.cpa_sale]
    filters:
      facebook_daily_ad_performance.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance.campaign_name: '"Custom Audience - Mobile"'
    sorts: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
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
    top: 16
    left: 14
    height: 3
    width: 6

#777777777777777777777777777777777******************************************************************************************************************************

  - name: dpa_spend
    title: DPA-Spend
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
    pivots: [facebook_daily_ad_performance.calendar_week]
    measures: [facebook_daily_ad_performance.total_spend]
    filters:
      facebook_daily_ad_performance.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance.campaign_name: '"DPA"'
    sorts: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
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
    top: 20
    left: 0
    height: 3
    width: 2
    
  - name: dpa_imp
    title: DPA-IMP
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
    pivots: [facebook_daily_ad_performance.calendar_week]
    measures: [facebook_daily_ad_performance.total_impressions]
    filters:
      facebook_daily_ad_performance.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance.campaign_name: '"DPA"'
    sorts: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
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
    top: 20
    left: 2
    height: 3
    width: 2

    
  - name: dpa_cpm
    title: DPA-CPM
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
    pivots: [facebook_daily_ad_performance.calendar_week]
    measures: [facebook_daily_ad_performance.cost_per_mille]
    filters:
      facebook_daily_ad_performance.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance.campaign_name: '"DPA"'
    sorts: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
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
    top: 20
    left: 4
    height: 3
    width: 2
    
  - name: dpa_ctr
    title: DPA-CTR
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
    pivots: [facebook_daily_ad_performance.calendar_week]
    measures: [facebook_daily_ad_performance.click_through_rate]
    filters:
      facebook_daily_ad_performance.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance.campaign_name: '"DPA"'
    sorts: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.click_through_rate]
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
    top: 20
    left: 6
    height: 3
    width: 2
    
  
  - name: dpa_actions
    title: DPA-Actions
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
    measures: [facebook_daily_ad_performance.total_website_clicks, facebook_daily_ad_performance.total_action_visit,
      facebook_daily_ad_performance.total_action_product_detail_page, facebook_daily_ad_performance.total_action_add_to_cart,
      facebook_daily_ad_performance.total_action_sale]
    filters:
      facebook_daily_ad_performance.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance.campaign_name: '"DPA"'
    sorts: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
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
    top: 20
    left: 8
    height: 3
    width: 6
    
  - name: dpa_cpa
    title: DPA-CPA
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
    measures: [facebook_daily_ad_performance.cost_per_website_click, facebook_daily_ad_performance.cpa_visit,
      facebook_daily_ad_performance.cpa_product_detail_page, facebook_daily_ad_performance.cpa_add_to_cart,
      facebook_daily_ad_performance.cpa_sale]
    filters:
      facebook_daily_ad_performance.calendar_week: 2 weeks ago for 2 weeks
      facebook_daily_ad_performance.campaign_name: '"DPA"'
    sorts: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
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
    top: 20
    left: 14
    height: 3
    width: 6
    
    #888888888888888888888888888888*******************************************************************************************************
  
  
  
  
  - name: this_week
    title: This Week
    type: table
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.campaign_name]
    measures: [facebook_daily_ad_performance.total_spend, facebook_daily_ad_performance.total_impressions,
      facebook_daily_ad_performance.click_through_rate, facebook_daily_ad_performance.cost_per_mille,
      facebook_daily_ad_performance.total_website_clicks, facebook_daily_ad_performance.total_action_visit,
      facebook_daily_ad_performance.total_action_product_detail_page, facebook_daily_ad_performance.total_action_add_to_cart,
      facebook_daily_ad_performance.total_action_sale, facebook_daily_ad_performance.cost_per_website_click,
      facebook_daily_ad_performance.cpa_visit, facebook_daily_ad_performance.cpa_product_detail_page,
      facebook_daily_ad_performance.cpa_add_to_cart, facebook_daily_ad_performance.cpa_sale]
    filters:
      facebook_daily_ad_performance.calendar_date: 1 week ago for 1 week
    sorts: [facebook_daily_ad_performance.total_spend desc]
    limit: 500
    column_limit: 40
    total: true
    top: 50
    left: 0
    height: 5
    width: 14
    
  - name: previous_week
    title: Previous Week
    type: table
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.campaign_name]
    measures: [facebook_daily_ad_performance.total_spend, facebook_daily_ad_performance.total_impressions,
      facebook_daily_ad_performance.click_through_rate, facebook_daily_ad_performance.cost_per_mille,
      facebook_daily_ad_performance.total_website_clicks, facebook_daily_ad_performance.total_action_visit,
      facebook_daily_ad_performance.total_action_product_detail_page, facebook_daily_ad_performance.total_action_add_to_cart,
      facebook_daily_ad_performance.total_action_sale, facebook_daily_ad_performance.cost_per_website_click,
      facebook_daily_ad_performance.cpa_visit, facebook_daily_ad_performance.cpa_product_detail_page,
      facebook_daily_ad_performance.cpa_add_to_cart, facebook_daily_ad_performance.cpa_sale]
    filters:
      facebook_daily_ad_performance.calendar_date: 2 weeks ago for 1 week
    sorts: [facebook_daily_ad_performance.total_spend desc]
    limit: 500
    column_limit: 40
    total: true
    top: 50
    left: 0
    height: 5
    width: 14  
    
    
