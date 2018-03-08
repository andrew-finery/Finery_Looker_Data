- dashboard: daily_facebook_report
  title: Daily Facebook Report
  layout: static
  tile_size: 100

  filters:

  elements:

  - name: facebook_spend
    title: Spend
    model: finery_data
    explore: facebook_api_ad_performance
    type: table
    fields: [facebook_api_ad_performance.total_spend_including_smartly_commission_yesterday,
      facebook_api_ad_performance.total_spend_including_smartly_commission_lw, facebook_api_ad_performance.total_spend_including_smartly_commission_wow,
      facebook_api_ad_performance.total_spend_including_smartly_commission_l3d_average,
      facebook_api_ad_performance.total_spend_including_smartly_commission_l3d_vs_yesterday,
      facebook_api_ad_performance.total_spend_including_smartly_commission_l7d_average,
      facebook_api_ad_performance.total_spend_including_smartly_commission_l7d_vs_yesterday,
      facebook_api_ad_performance.buyers_vs_non_buyers]
    sorts: [facebook_api_ad_performance.total_spend_including_smartly_commission_yesterday
        desc]
    limit: 500
    column_limit: 50
    total: true
    show_view_names: false
    show_row_numbers: false
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
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
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: true
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    top: 0
    left: 0
    height: 2
    width: 12


  - name: facebook_revenue_1d_click
    title: Revenue 1d Click
    model: finery_data
    explore: facebook_api_ad_performance
    type: table
    fields: [facebook_api_ad_performance.buyers_vs_non_buyers, facebook_api_ad_performance.revenue_1_day_after_clicking_yesterday,
      facebook_api_ad_performance.revenue_1_day_after_clicking_lw, facebook_api_ad_performance.revenue_1_day_after_clicking_wow,
      facebook_api_ad_performance.revenue_1_day_after_clicking_l3d_average, facebook_api_ad_performance.revenue_1_day_after_clicking_l3d_vs_yesterday,
      facebook_api_ad_performance.revenue_1_day_after_clicking_l7d_average, facebook_api_ad_performance.revenue_1_day_after_clicking_l7d_vs_yesterday]
    sorts: [facebook_api_ad_performance.revenue_1_day_after_clicking_yesterday desc]
    limit: 500
    total: true
    query_timezone: Europe/London
    show_view_names: false
    show_row_numbers: false
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
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
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    top: 2
    left: 0
    height: 2
    width: 12


  - name: facebook_roi
    title: ROI
    model: finery_data
    explore: facebook_api_ad_performance
    type: table
    fields: [facebook_api_ad_performance.return_on_investment_yesterday, facebook_api_ad_performance.return_on_investment_lw,
      facebook_api_ad_performance.return_on_investment_wow, facebook_api_ad_performance.return_on_investment_l3d_average,
      facebook_api_ad_performance.return_on_investment_l3d_vs_yesterday, facebook_api_ad_performance.return_on_investment_l7d_average,
      facebook_api_ad_performance.return_on_investment_l7d_vs_yesterday, facebook_api_ad_performance.buyers_vs_non_buyers]
    sorts: [facebook_api_ad_performance.return_on_investment_yesterday desc]
    limit: 500
    column_limit: 50
    total: true
    query_timezone: Europe/London
    show_view_names: false
    show_row_numbers: false
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
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
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    top: 4
    left: 0
    height: 2
    width: 12


  - name: facebook_cpm
    title: CPM
    model: finery_data
    explore: facebook_api_ad_performance
    type: table
    fields: [facebook_api_ad_performance.buyers_vs_non_buyers, facebook_api_ad_performance.cost_per_mille_yesterday,
      facebook_api_ad_performance.cost_per_mille_lw, facebook_api_ad_performance.cost_per_mille_yesterday_wow,
      facebook_api_ad_performance.cost_per_mille_l3d_avg, facebook_api_ad_performance.cost_per_mille_vs_l3d_avg,
      facebook_api_ad_performance.cost_per_mille_l7d_avg, facebook_api_ad_performance.cost_per_mille_vs_l7d_avg]
    sorts: [facebook_api_ad_performance.cost_per_mille_yesterday desc]
    limit: 500
    total: true
    query_timezone: Europe/London
    show_view_names: false
    show_row_numbers: false
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
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
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    top: 6
    left: 0
    height: 2
    width: 12


  - name: facebook_cpc
    title: CPC
    model: finery_data
    explore: facebook_api_ad_performance
    type: table
    fields: [facebook_api_ad_performance.buyers_vs_non_buyers, facebook_api_ad_performance.cost_per_click_yesterday,
      facebook_api_ad_performance.cost_per_click_lw, facebook_api_ad_performance.cost_per_click_yesterday_wow,
      facebook_api_ad_performance.cost_per_click_l3d_avg, facebook_api_ad_performance.cost_per_click_vs_l3d_avg,
      facebook_api_ad_performance.cost_per_click_l7d_avg, facebook_api_ad_performance.cost_per_click_vs_l7d_avg]
    sorts: [facebook_api_ad_performance.cost_per_click_yesterday desc]
    limit: 500
    total: true
    query_timezone: Europe/London
    show_view_names: false
    show_row_numbers: false
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
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
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    series_labels:
      facebook_api_ad_performance.cost_per_click_yesterday: Actual
    top: 8
    left: 0
    height: 2
    width: 12


  - name: add_to_cart_cost_by_dpa
    title: ATC Cost
    model: finery_data
    explore: facebook_api_ad_performance
    type: table
    fields: [facebook_api_ad_performance.cost_per_add_to_cart_yesterday, facebook_api_ad_performance.cost_per_add_to_cart_lw,
      facebook_api_ad_performance.cost_per_add_to_cart_wow, facebook_api_ad_performance.cost_per_add_to_cart_l3d_average,
      facebook_api_ad_performance.cost_per_add_to_cart_l3d_vs_yesterday, facebook_api_ad_performance.cost_per_add_to_cart_l7d_average,
      facebook_api_ad_performance.cost_per_add_to_cart_l7d_vs_yesterday, facebook_api_ad_performance.buyers_vs_non_buyers]
    sorts: [facebook_api_ad_performance.cost_per_add_to_cart_yesterday desc]
    limit: 500
    column_limit: 50
    total: true
    show_view_names: false
    show_row_numbers: false
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
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
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: true
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    top: 10
    left: 0
    height: 2
    width: 12


  - name: cost_per_order_by_dpa_type
    title: CPO
    model: finery_data
    explore: facebook_api_ad_performance
    type: table
    fields: [facebook_api_ad_performance.cost_per_order_yesterday, facebook_api_ad_performance.cost_per_order_lw,
      facebook_api_ad_performance.cost_per_order_wow, facebook_api_ad_performance.cost_per_order_l3d_average,
      facebook_api_ad_performance.cost_per_order_l3d_vs_yesterday, facebook_api_ad_performance.cost_per_order_l7d_average,
      facebook_api_ad_performance.cost_per_order_l7d_vs_yesterday, facebook_api_ad_performance.buyers_vs_non_buyers]
    sorts: [facebook_api_ad_performance.cost_per_order_yesterday desc]
    limit: 500
    column_limit: 50
    total: true
    show_view_names: false
    show_row_numbers: false
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
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
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: true
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    top: 12
    left: 0
    height: 2
    width: 12


  - name: facebook_ctr
    title: CTR
    model: finery_data
    explore: facebook_api_ad_performance
    type: table
    fields: [facebook_api_ad_performance.buyers_vs_non_buyers, facebook_api_ad_performance.click_through_rate_yesterday,
      facebook_api_ad_performance.click_through_rate_lw, facebook_api_ad_performance.click_through_rate_yesterday_wow,
      facebook_api_ad_performance.click_through_rate_l3d_avg, facebook_api_ad_performance.click_through_rate_vs_l3d_avg,
      facebook_api_ad_performance.click_through_rate_l7d_avg, facebook_api_ad_performance.click_through_rate_vs_l7d_avg]
    sorts: [facebook_api_ad_performance.click_through_rate_yesterday desc]
    limit: 500
    total: true
    query_timezone: Europe/London
    show_view_names: false
    show_row_numbers: false
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
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
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    top: 14
    left: 0
    height: 2
    width: 12


  - name: country_facebook_revenue
    title: Revenue By Country
    model: finery_data
    explore: facebook_api_ad_performance
    type: table
    fields: [facebook_api_ad_performance.country, facebook_api_ad_performance.revenue_1_day_after_clicking_yesterday,
      facebook_api_ad_performance.revenue_1_day_after_clicking_lw, facebook_api_ad_performance.revenue_1_day_after_clicking_wow,
      facebook_api_ad_performance.revenue_1_day_after_clicking_l3d_average, facebook_api_ad_performance.revenue_1_day_after_clicking_l3d_vs_yesterday,
      facebook_api_ad_performance.revenue_1_day_after_clicking_l7d_average, facebook_api_ad_performance.revenue_1_day_after_clicking_l7d_vs_yesterday]
    filters:
      facebook_api_ad_performance.country: "-Unknown,-AUS"
    sorts: [facebook_api_ad_performance.revenue_1_day_after_clicking_yesterday desc]
    limit: 500
    total: true
    query_timezone: Europe/London
    show_view_names: false
    show_row_numbers: false
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
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
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    top: 16
    left: 0
    height: 2
    width: 12


  - name: facebook_advert_cost
    title: Advert Cost
    model: finery_data
    explore: facebook_api_ad_performance
    type: table
    fields: [facebook_api_ad_performance.total_spend_including_smartly_commission_yesterday,
      facebook_api_ad_performance.total_spend_including_smartly_commission_lw, facebook_api_ad_performance.total_spend_including_smartly_commission_wow,
      facebook_api_ad_performance.total_spend_including_smartly_commission_l3d_average,
      facebook_api_ad_performance.total_spend_including_smartly_commission_l3d_vs_yesterday,
      facebook_api_ad_performance.total_spend_including_smartly_commission_l7d_average,
      facebook_api_ad_performance.total_spend_including_smartly_commission_l7d_vs_yesterday,
      facebook_api_ad_performance.advert_name_short]
    filters:
      facebook_api_ad_performance.dpa_vs_non_dpa: Non DPA
      facebook_api_ad_performance.total_spend_including_smartly_commission_yesterday: ">0"
    sorts: [facebook_api_ad_performance.total_spend_including_smartly_commission_yesterday
        desc]
    limit: 10
    column_limit: 50
    total: true
    show_view_names: false
    show_row_numbers: false
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
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
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: true
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    top: 18
    left: 0
    height: 2
    width: 12


  - name: add_to_cart_advert_cost
    title: Advert ATC Cost
    model: finery_data
    explore: facebook_api_ad_performance
    type: table
    fields: [facebook_api_ad_performance.cost_per_add_to_cart_yesterday, facebook_api_ad_performance.cost_per_add_to_cart_lw,
      facebook_api_ad_performance.cost_per_add_to_cart_wow, facebook_api_ad_performance.cost_per_add_to_cart_l3d_average,
      facebook_api_ad_performance.cost_per_add_to_cart_l3d_vs_yesterday, facebook_api_ad_performance.cost_per_add_to_cart_l7d_average,
      facebook_api_ad_performance.cost_per_add_to_cart_l7d_vs_yesterday, facebook_api_ad_performance.total_spend_including_smartly_commission_yesterday,
      facebook_api_ad_performance.advert_name_short]
    filters:
      facebook_api_ad_performance.dpa_vs_non_dpa: Non DPA
      facebook_api_ad_performance.total_spend_including_smartly_commission_yesterday: ">0"
    sorts: [facebook_api_ad_performance.cost_per_add_to_cart_yesterday desc]
    limit: 1000
    column_limit: 50
    total: true
    show_view_names: false
    show_row_numbers: false
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
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
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: true
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    hidden_fields: [facebook_api_ad_performance.total_spend_including_smartly_commission_yesterday]
    top: 20
    left: 0
    height: 2
    width: 12


  - name: advert_cost_per_order
    title: Advert CPO
    model: finery_data
    explore: facebook_api_ad_performance
    type: table
    fields: [facebook_api_ad_performance.cost_per_order_yesterday, facebook_api_ad_performance.cost_per_order_lw,
      facebook_api_ad_performance.cost_per_order_wow, facebook_api_ad_performance.cost_per_order_l3d_average,
      facebook_api_ad_performance.cost_per_order_l3d_vs_yesterday, facebook_api_ad_performance.cost_per_order_l7d_average,
      facebook_api_ad_performance.cost_per_order_l7d_vs_yesterday, facebook_api_ad_performance.total_spend_including_smartly_commission_yesterday,
      facebook_api_ad_performance.advert_name_short]
    filters:
      facebook_api_ad_performance.dpa_vs_non_dpa: Non DPA
      facebook_api_ad_performance.total_spend_including_smartly_commission_yesterday: ">0"
    sorts: [facebook_api_ad_performance.cost_per_order_yesterday desc]
    limit: 500
    column_limit: 50
    total: true
    show_view_names: false
    show_row_numbers: false
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
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
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: true
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    hidden_fields: [facebook_api_ad_performance.total_spend_including_smartly_commission_yesterday]
    top: 22
    left: 0
    height: 2
    width: 12
