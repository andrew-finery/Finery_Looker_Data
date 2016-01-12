- dashboard: facebook_campaigns_week_on_week
  title: Facebook Campaigns Week on Week
  layout: static
  tile_size: 100

#  filters:

  elements:
  
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
    
    
    #***************************************************************************************************************************************************
    
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
    
    #*************************************************************************************************************************







  - name: mobie_desktop_impressions
    title: Brand Mobile Imp
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
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
    legend_position: center
    hide_legend: false
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: false
    top: 9
    left: 0
    height: 3
    width: 2
    
  - name: mobile_desktop_spend
    title: Untitled Visualization
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
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
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: false
    top: 9
    left: 2
    height: 3
    width: 2

    
  - name: mobile_desktop_CPM
    title: Untitled Visualization
    layout: static
    type: looker_column
    model: finery_data
    explore: facebook_daily_ad_performance
    dimensions: [facebook_daily_ad_performance.calendar_week, facebook_daily_ad_performance.campaign_name]
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
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    show_null_labels: false
    show_dropoff: false
    top: 9
    left: 4
    height: 3
    width: 2
 

  
  
  
  
  
  
  
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
    top: 11
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
    top: 16
    left: 0
    height: 5
    width: 14  
    
    
