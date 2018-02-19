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
      facebook_api_ad_performance.buyers_vs_nonbuyers]
    filters:
      facebook_api_ad_performance.buyers_vs_nonbuyers: "-EMPTY"
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
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    top: 0
    left: 0
    height: 2
    width: 7


  - name: revenue_1_day_after_clicking
    title: Revenue
    model: finery_data
    explore: facebook_api_ad_performance
    type: table
    fields: [facebook_api_ad_performance.revenue_1_day_after_clicking_yesterday, facebook_api_ad_performance.revenue_1_day_after_clicking_lw,
      facebook_api_ad_performance.revenue_1_day_after_clicking_wow, facebook_api_ad_performance.revenue_1_day_after_clicking_l3d_average,
      facebook_api_ad_performance.revenue_1_day_after_clicking_l3d_vs_yesterday, facebook_api_ad_performance.revenue_1_day_after_clicking_l7d_average,
      facebook_api_ad_performance.revenue_1_day_after_clicking_l7d_vs_yesterday, facebook_api_ad_performance.buyers_vs_nonbuyers]
    filters:
      facebook_api_ad_performance.buyers_vs_nonbuyers: "-EMPTY"
    sorts: [facebook_api_ad_performance.revenue_1_day_after_clicking_yesterday desc]
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
    left: 7
    height: 2
    width: 7


  - name: return_on_investment
    title: ROI
    model: finery_data
    explore: facebook_api_ad_performance
    type: table
    fields: [facebook_api_ad_performance.return_on_investment_yesterday, facebook_api_ad_performance.return_on_investment_lw,
      facebook_api_ad_performance.return_on_investment_wow, facebook_api_ad_performance.return_on_investment_l3d_average,
      facebook_api_ad_performance.return_on_investment_l3d_vs_yesterday, facebook_api_ad_performance.return_on_investment_l7d_average,
      facebook_api_ad_performance.return_on_investment_l7d_vs_yesterday, facebook_api_ad_performance.buyers_vs_nonbuyers]
    filters:
      facebook_api_ad_performance.buyers_vs_nonbuyers: "-EMPTY"
    sorts: [facebook_api_ad_performance.return_on_investment_yesterday desc]
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
    top: 2
    left: 0
    height: 2
    width: 7



  - name: cost_per_order
    title: CPO
    model: finery_data
    explore: facebook_api_ad_performance
    type: table
    fields: [facebook_api_ad_performance.buyers_vs_nonbuyers, facebook_api_ad_performance.cost_per_order_yesterday,
      facebook_api_ad_performance.cost_per_order_lw, facebook_api_ad_performance.cost_per_order_wow,
      facebook_api_ad_performance.cost_per_order_l3d_average, facebook_api_ad_performance.cost_per_order_l3d_vs_yesterday,
      facebook_api_ad_performance.cost_per_order_l7d_average, facebook_api_ad_performance.cost_per_order_l7d_vs_yesterday]
    filters:
      facebook_api_ad_performance.buyers_vs_nonbuyers: "-EMPTY"
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
    top: 2
    left: 7
    height: 2
    width: 7


  - name: cost_per_add_to_cart
    title: ATC Cost
    model: finery_data
    explore: facebook_api_ad_performance
    type: table
    fields: [facebook_api_ad_performance.cost_per_add_to_cart_yesterday, facebook_api_ad_performance.cost_per_add_to_cart_lw,
      facebook_api_ad_performance.cost_per_add_to_cart_wow, facebook_api_ad_performance.cost_per_add_to_cart_l3d_average,
      facebook_api_ad_performance.cost_per_add_to_cart_l3d_vs_yesterday, facebook_api_ad_performance.cost_per_add_to_cart_l7d_average,
      facebook_api_ad_performance.cost_per_add_to_cart_l7d_vs_yesterday, facebook_api_ad_performance.buyers_vs_nonbuyers]
    filters:
      facebook_api_ad_performance.buyers_vs_nonbuyers: "-EMPTY"
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
    top: 4
    left: 0
    height: 2
    width: 7


  - name: audience_segment_facebook_spend
    title: Buyers Spend
    model: finery_data
    explore: facebook_api_ad_performance
    type: table
    fields: [facebook_api_ad_performance.total_spend_including_smartly_commission_yesterday,
      facebook_api_ad_performance.total_spend_including_smartly_commission_lw, facebook_api_ad_performance.total_spend_including_smartly_commission_wow,
      facebook_api_ad_performance.total_spend_including_smartly_commission_l3d_average,
      facebook_api_ad_performance.total_spend_including_smartly_commission_l3d_vs_yesterday,
      facebook_api_ad_performance.total_spend_including_smartly_commission_l7d_average,
      facebook_api_ad_performance.total_spend_including_smartly_commission_l7d_vs_yesterday,
      facebook_api_ad_performance.audience_segment]
    filters:
      facebook_api_ad_performance.audience_segment: Buyers - CA,Buyers - DPA
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
    top: 4
    left: 7
    height: 2
    width: 7


  - name: cost_per_order_buyers
    title: Buyers CPO
    model: finery_data
    explore: facebook_api_ad_performance
    type: table
    fields: [facebook_api_ad_performance.cost_per_order_yesterday, facebook_api_ad_performance.cost_per_order_lw,
      facebook_api_ad_performance.cost_per_order_wow, facebook_api_ad_performance.cost_per_order_l3d_average,
      facebook_api_ad_performance.cost_per_order_l3d_vs_yesterday, facebook_api_ad_performance.cost_per_order_l7d_average,
      facebook_api_ad_performance.cost_per_order_l7d_vs_yesterday, facebook_api_ad_performance.audience_segment]
    filters:
      facebook_api_ad_performance.audience_segment: Buyers - CA,Buyers - DPA
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
    top: 6
    left: 0
    height: 2
    width: 7


  - name: cost_per_add_to_cart_buyers
    title: Buyers ATC Cost
    model: finery_data
    explore: facebook_api_ad_performance
    type: table
    fields: [facebook_api_ad_performance.cost_per_add_to_cart_yesterday, facebook_api_ad_performance.cost_per_add_to_cart_lw,
      facebook_api_ad_performance.cost_per_add_to_cart_wow, facebook_api_ad_performance.cost_per_add_to_cart_l3d_average,
      facebook_api_ad_performance.cost_per_add_to_cart_l3d_vs_yesterday, facebook_api_ad_performance.cost_per_add_to_cart_l7d_average,
      facebook_api_ad_performance.cost_per_add_to_cart_l7d_vs_yesterday, facebook_api_ad_performance.audience_segment]
    filters:
      facebook_api_ad_performance.audience_segment: Buyers%
      facebook_api_ad_performance.buyers_vs_nonbuyers: Buyers
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
    top: 6
    left: 7
    height: 2
    width: 7



  - name: non_buyers_facebook_spend
    title: Non Buyers Spend
    model: finery_data
    explore: facebook_api_ad_performance
    type: table
    fields: [facebook_api_ad_performance.total_spend_including_smartly_commission_yesterday,
      facebook_api_ad_performance.total_spend_including_smartly_commission_lw, facebook_api_ad_performance.total_spend_including_smartly_commission_wow,
      facebook_api_ad_performance.total_spend_including_smartly_commission_l3d_average,
      facebook_api_ad_performance.total_spend_including_smartly_commission_l3d_vs_yesterday,
      facebook_api_ad_performance.total_spend_including_smartly_commission_l7d_average,
      facebook_api_ad_performance.total_spend_including_smartly_commission_l7d_vs_yesterday,
      facebook_api_ad_performance.audience_segment]
    filters:
      facebook_api_ad_performance.buyers_vs_nonbuyers: NonBuyers
      facebook_api_ad_performance.total_spend_including_smartly_commission_yesterday: ">0"
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
    top: 8
    left: 0
    height: 2
    width: 7


  - name: cost_per_order_non_buyers
    title: Non Buyers CPO
    model: finery_data
    explore: facebook_api_ad_performance
    type: table
    fields: [facebook_api_ad_performance.audience_segment, facebook_api_ad_performance.cost_per_order_yesterday,
      facebook_api_ad_performance.cost_per_order_lw, facebook_api_ad_performance.cost_per_order_wow,
      facebook_api_ad_performance.cost_per_order_l3d_average, facebook_api_ad_performance.cost_per_order_l3d_vs_yesterday,
      facebook_api_ad_performance.cost_per_order_l7d_average, facebook_api_ad_performance.cost_per_order_l7d_vs_yesterday]
    filters:
      facebook_api_ad_performance.buyers_vs_nonbuyers: NonBuyers
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
    top: 8
    left: 7
    height: 2
    width: 7


  - name: cost_per_add_to_cart_non_buyers
    title: Non Buyers ATC Cost
    model: finery_data
    explore: facebook_api_ad_performance
    type: table
    fields: [facebook_api_ad_performance.cost_per_add_to_cart_yesterday, facebook_api_ad_performance.cost_per_add_to_cart_lw,
      facebook_api_ad_performance.cost_per_add_to_cart_wow, facebook_api_ad_performance.cost_per_add_to_cart_l3d_average,
      facebook_api_ad_performance.cost_per_add_to_cart_l3d_vs_yesterday, facebook_api_ad_performance.cost_per_add_to_cart_l7d_average,
      facebook_api_ad_performance.cost_per_add_to_cart_l7d_vs_yesterday, facebook_api_ad_performance.audience_segment]
    filters:
      facebook_api_ad_performance.buyers_vs_nonbuyers: NonBuyers
      facebook_api_ad_performance.cost_per_add_to_cart_yesterday: ">0"
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
    left: 3
    height: 2
    width: 7


  - name: facebook_spend_dpa_campaigns_by_type
    title: DPA vs Non DPA Spend
    model: finery_data
    explore: facebook_api_ad_performance
    type: table
    fields: [facebook_api_ad_performance.total_spend_including_smartly_commission_yesterday,
      facebook_api_ad_performance.total_spend_including_smartly_commission_lw, facebook_api_ad_performance.total_spend_including_smartly_commission_wow,
      facebook_api_ad_performance.total_spend_including_smartly_commission_l3d_average,
      facebook_api_ad_performance.total_spend_including_smartly_commission_l3d_vs_yesterday,
      facebook_api_ad_performance.total_spend_including_smartly_commission_l7d_average,
      facebook_api_ad_performance.total_spend_including_smartly_commission_l7d_vs_yesterday,
      facebook_api_ad_performance.dpa_vs_non_dpa]
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
    top: 12
    left: 0
    height: 2
    width: 7


  - name: cost_per_order_by_dpa_type
    title: DPA vs Non DPA CPO
    model: finery_data
    explore: facebook_api_ad_performance
    type: table
    fields: [facebook_api_ad_performance.cost_per_order_yesterday, facebook_api_ad_performance.cost_per_order_lw,
      facebook_api_ad_performance.cost_per_order_wow, facebook_api_ad_performance.cost_per_order_l3d_average,
      facebook_api_ad_performance.cost_per_order_l3d_vs_yesterday, facebook_api_ad_performance.cost_per_order_l7d_average,
      facebook_api_ad_performance.cost_per_order_l7d_vs_yesterday, facebook_api_ad_performance.dpa_vs_non_dpa]
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
    left: 7
    height: 2
    width: 7


  - name: add_to_cart_cost_by_dpa
    title: DPA vs Non DPA ATC Cost
    model: finery_data
    explore: facebook_api_ad_performance
    type: table
    fields: [facebook_api_ad_performance.cost_per_add_to_cart_yesterday, facebook_api_ad_performance.cost_per_add_to_cart_lw,
      facebook_api_ad_performance.cost_per_add_to_cart_wow, facebook_api_ad_performance.cost_per_add_to_cart_l3d_average,
      facebook_api_ad_performance.cost_per_add_to_cart_l3d_vs_yesterday, facebook_api_ad_performance.cost_per_add_to_cart_l7d_average,
      facebook_api_ad_performance.cost_per_add_to_cart_l7d_vs_yesterday, facebook_api_ad_performance.dpa_vs_non_dpa]
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
    top: 14
    left: 3
    height: 2
    width: 7


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
      facebook_api_ad_performance.aa_vs_custom: Custom
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
    top: 16
    left: 2
    height: 2
    width: 9


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
      facebook_api_ad_performance.aa_vs_custom: Custom
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
    top: 18
    left: 2
    height: 2
    width: 9

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
      facebook_api_ad_performance.aa_vs_custom: Custom
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
    left: 2
    height: 2
    width: 9
