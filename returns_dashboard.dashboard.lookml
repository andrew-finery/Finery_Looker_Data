- dashboard: returns_dashboard
  title: Returns Dashboard
  layout: static
  tile_size: 100

#  filters:

  elements:

  - name: AW16_worst_30_returners
    title: Worst 30 Returning Options (AW16)
    type: table
    model: finery_data
    explore: spree_order_items
    dimensions: [option_info.dpa_image, option_info.style, option_info.colour]
    measures: [spree_order_items.return_rate, spree_order_items.total_items_sold, spree_order_items.total_items_returned,
      spree_order_items.total_items_returned_too_big, spree_order_items.total_items_returned_too_small,
      spree_order_items.total_items_returned_doesnt_suit, spree_order_items.total_items_returned_not_as_pictured,
      spree_order_items.total_items_returned_not_as_described, spree_order_items.total_items_returned_faulty]
    filters:
      calendar_weeks.calendar_date_date: before 28 days ago
      option_info.sub_season: AW16
      spree_order_items.total_items_sold: '>10'
    sorts: [spree_order_items.return_rate desc]
    limit: 30
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    series_labels:
      spree_order_items.items_returned: Total Items Returned
      spree_order_items.total_items_returned_too_big: Too Big
      spree_order_items.total_items_returned_too_small: Too Small
      spree_order_items.total_items_returned_doesnt_suit: It Doesn't Suit Me
      spree_order_items.total_items_returned_not_as_pictured: Not as Pictured
      spree_order_items.total_items_returned_not_as_described: Not as Described
      spree_order_items.total_items_returned_faulty: Faulty
      option_info.dpa_image: Image
    table_theme: editable
    limit_displayed_rows: false
    top: 0
    left: 0
    height: 42
    width: 10

  - name: season_return_rate
    title: AW16 Stock - Return Rate
    type: single_value
    model: finery_data
    explore: spree_order_items
    measures: [spree_order_items.return_rate]
    filters:
      calendar_weeks.calendar_date_date: before 28 days ago
      option_info.sub_season: AW16
    sorts: [spree_order_items.return_rate desc]
    limit: 1
    value_format: '#0.0%'
    show_comparison: false
    top: 0
    left: 10
    height: 2
    width: 3

  - name: sub_season_return_rates
    title: Return Rate by Sub-Season
    type: looker_bar
    model: finery_data
    explore: spree_order_items
    dimensions: [option_info.sub_season]
    measures: [spree_order_items.return_rate]
    filters:
      calendar_weeks.calendar_date_date: before 28 days ago
      option_info.sub_season: -EMPTY,-Unknown
    sorts: [spree_order_items.return_rate desc]
    limit: 30
    stacking: ''
    colors: ['#7FCDAE']
    show_value_labels: true
    label_density: 25
    label_color: [purple]
    font_size: 20px
    legend_position: center
    x_axis_gridlines: false
    show_view_names: false
    series_labels:
      spree_order_items.items_returned: Total Items Returned
      spree_order_items.total_items_returned_too_big: Too Big
      spree_order_items.total_items_returned_too_small: Too Small
      spree_order_items.total_items_returned_doesnt_suit: It Doesn't Suit Me
      spree_order_items.total_items_returned_not_as_pictured: Not as Pictured
      spree_order_items.total_items_returned_not_as_described: Not as Described
      spree_order_items.total_items_returned_faulty: Faulty
      option_info.dpa_image: Image
      __FILE: finery_data/returns_dashboard_2.dashboard.lookml
      __LINE_NUM: 86
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    label_value_format: '#%'
    show_null_labels: false
    top: 2
    left: 10
    height: 6
    width: 3

  - name: season_category_return_rates
    title: AW16 Category Return Rates
    type: looker_bar
    model: finery_data
    explore: spree_order_items
    dimensions: [option_info.category]
    measures: [spree_order_items.return_rate]
    filters:
      calendar_weeks.calendar_date_date: before 28 days ago
      option_info.sub_season: AW16
    sorts: [spree_order_items.return_rate desc]
    limit: 30
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    label_color: [red]
    font_size: 20px
    legend_position: center
    x_axis_gridlines: false
    show_view_names: false
    series_labels:
      spree_order_items.items_returned: Total Items Returned
      spree_order_items.total_items_returned_too_big: Too Big
      spree_order_items.total_items_returned_too_small: Too Small
      spree_order_items.total_items_returned_doesnt_suit: It Doesn't Suit Me
      spree_order_items.total_items_returned_not_as_pictured: Not as Pictured
      spree_order_items.total_items_returned_not_as_described: Not as Described
      spree_order_items.total_items_returned_faulty: Faulty
      option_info.dpa_image: Image
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    label_value_format: '#%'
    show_null_labels: false
    top: 8
    left: 10
    height: 6
    width: 3

  - name: size_category_return_rates
    title: AW16 Size Return Rates
    type: looker_bar
    model: finery_data
    explore: spree_order_items
    dimensions: [variant_info.size]
    measures: [spree_order_items.return_rate]
    filters:
      calendar_weeks.calendar_date_date: before 28 days ago
      option_info.sub_season: AW16
      variant_info.size: '6,8,10,12,14,16'
    sorts: [spree_order_items.return_rate desc]
    limit: 30
    stacking: ''
    colors: ['#F16358', '#E0635E', '#D06464', '#BF656B', '#AF6671', '#9F6777', '#8E687E',
      '#7E6984', '#6E6A8A', '#5D6B91', '#4D6C97', '#3D6D9E']
    show_value_labels: true
    label_density: 25
    label_color: [green]
    font_size: 20px
    legend_position: center
    x_axis_gridlines: false
    show_view_names: false
    series_labels:
      spree_order_items.items_returned: Total Items Returned
      spree_order_items.total_items_returned_too_big: Too Big
      spree_order_items.total_items_returned_too_small: Too Small
      spree_order_items.total_items_returned_doesnt_suit: It Doesn't Suit Me
      spree_order_items.total_items_returned_not_as_pictured: Not as Pictured
      spree_order_items.total_items_returned_not_as_described: Not as Described
      spree_order_items.total_items_returned_faulty: Faulty
      option_info.dpa_image: Image
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    label_value_format: '#%'
    show_null_labels: false
    top: 14
    left: 10
    height: 4
    width: 3

