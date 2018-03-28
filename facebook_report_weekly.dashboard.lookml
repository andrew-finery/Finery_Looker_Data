- dashboard: facebook_report_weekly
  title: Facebook Report Weekly
  layout: static
  tile_size: 100


  elements:
  - name: revenue_and_roi
    title: Revenue & ROI By Campaign
    model: finery_data
    explore: facebook_api_ad_performance
    type: table
    fields: [facebook_api_ad_performance.campaign_name, facebook_api_ad_performance.revenue_1_day_after_clicking_lcw,
      facebook_api_ad_performance.revenue_1_day_after_clicking_pcw, facebook_api_ad_performance.revenue_1_day_after_clicking_lcw_wow,
      facebook_api_ad_performance.return_on_investment_lcw, facebook_api_ad_performance.return_on_investment_pcw,
      facebook_api_ad_performance.return_on_investment_lcw_wow]
    filters:
      facebook_api_ad_performance.campaign_name: UK^_Non^_Buyers,UK^_Buyers,UK^_AA^_Acquisition,UK^_AA^_DPA,US^_AA^_DPA,IE^_AA^_DPA
    sorts: [facebook_api_ad_performance.revenue_1_day_after_clicking_lcw desc]
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
      facebook_api_ad_performance.revenue_1_day_after_clicking_lcw: Revenue LCW
      facebook_api_ad_performance.revenue_1_day_after_clicking_pcw: Revenue PCW
      facebook_api_ad_performance.revenue_1_day_after_clicking_lcw_wow: "%"
      facebook_api_ad_performance.return_on_investment_lcw: ROI LCW
      facebook_api_ad_performance.return_on_investment_pcw: ROI PCW
      facebook_api_ad_performance.return_on_investment_lcw_wow: "%"
    height: 3
    width: 12
    top: 0
    left: 0


  - name: advert_revenue_roi
    title: Revenue & ROI By Advert
    model: finery_data
    explore: facebook_api_ad_performance
    type: table
    fields: [facebook_api_ad_performance.revenue_1_day_after_clicking_lcw, facebook_api_ad_performance.return_on_investment_lcw,
      facebook_api_ad_performance.advert_name_short]
    filters:
      facebook_api_ad_performance.campaign_name: UK^_Non^_Buyers,UK^_Buyers,UK^_AA^_Acquisition,UK^_AA^_DPA,US^_AA^_DPA,IE^_AA^_DPA
      facebook_api_ad_performance.advert_name_short: "-%Dynamic%"
      facebook_api_ad_performance.revenue_1_day_after_clicking_lcw: ">0"
    sorts: [facebook_api_ad_performance.revenue_1_day_after_clicking_lcw desc]
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
      facebook_api_ad_performance.revenue_1_day_after_clicking_lcw: Revenue LCW
      facebook_api_ad_performance.revenue_1_day_after_clicking_pcw: Revenue PCW
      facebook_api_ad_performance.revenue_1_day_after_clicking_lcw_wow: "%"
      facebook_api_ad_performance.return_on_investment_lcw: ROI LCW
      facebook_api_ad_performance.return_on_investment_pcw: ROI PCW
      facebook_api_ad_performance.return_on_investment_lcw_wow: "%"
    height: 2
    width: 12
    top: 3
    left: 0


  - name: revenue_wow_by_country
    title: Revenue By Country
    model: finery_data
    explore: facebook_api_ad_performance
    type: table
    fields: [facebook_api_ad_performance.country, facebook_api_ad_performance.revenue_1_day_after_clicking_lcw,
      facebook_api_ad_performance.revenue_1_day_after_clicking_pcw, facebook_api_ad_performance.revenue_1_day_after_clicking_lcw_wow]
    sorts: [facebook_api_ad_performance.revenue_1_day_after_clicking_lcw desc]
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
    height: 2
    width: 12
    top: 5
    left: 0
