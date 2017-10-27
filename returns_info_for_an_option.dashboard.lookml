- dashboard: returns_info_for_an_option
  title: Returns Info for An Option
  layout: static
  tile_size: 60

  filters:
  - name: option
    title: "Choose 1 Option Only"
    type: field_filter
    explore: spree_order_items
    field: option_info.option
    default_value: Arno Studded Dress with Belt - Black

  elements:

  - name: image
    title: Image
    type: table
    model: finery_data
    explore: spree_order_items
    dimensions: [option_info.option_image]
    filters:
      calendar_weeks.calendar_date_date: before 28 days ago
    listen:
      option: option_info.option
    sorts: [option_info.option_image]
    limit: 1
    show_view_names: false
    show_row_numbers: false
    truncate_column_names: false
    series_labels:
      option_info.option_image: Image
    table_theme: transparent
    limit_displayed_rows: false
    show_title: false
    height: 4
    width: 3
    top: 0
    left: 0

  - name: style_name
    title: Style
    type: single_value
    model: finery_data
    explore: spree_order_items
    dimensions: [option_info.style]
    listen:
      option: option_info.option
    sorts: [option_info.style]
    limit: 1
    custom_color_enabled: false
    show_single_value_title: true
    show_comparison: false
    height: 2
    width: 12
    top: 0
    left: 3

  - name: colour
    title: Colour
    type: single_value
    model: finery_data
    explore: spree_order_items
    dimensions: [option_info.colour]
    listen:
      option: option_info.option
    sorts: [option_info.colour]
    limit: 1
    custom_color_enabled: false
    show_single_value_title: true
    show_comparison: false
    height: 2
    width: 7
    top: 0
    left: 15

  - name: return_rate
    title: Return Rate
    type: single_value
    model: finery_data
    explore: spree_order_items
    measures: [spree_order_items.return_rate]
    filters:
      calendar_weeks.calendar_date_date: before 28 days ago
    listen:
      option: option_info.option
    sorts: [spree_order_items.return_rate desc]
    limit: 1
    custom_color_enabled: false
    show_single_value_title: true
    show_comparison: false
    value_format: 0.0%
    height: 2
    width: 4
    top: 2
    left: 3

  - name: items_sold
    title: Items Sold
    type: single_value
    model: finery_data
    explore: spree_order_items
    measures: [spree_order_items.total_items_sold]
    filters:
      calendar_weeks.calendar_date_date: before 28 days ago
    listen:
      option: option_info.option
    sorts: [spree_order_items.total_items_sold desc]
    limit: 1
    custom_color_enabled: false
    show_single_value_title: true
    show_comparison: false
    height: 2
    width: 4
    top: 2
    left: 7

  - name: items_returned
    title: Items Returned
    type: single_value
    model: finery_data
    explore: spree_order_items
    measures: [spree_order_items.total_items_returned]
    filters:
      calendar_weeks.calendar_date_date: before 28 days ago
    listen:
      option: option_info.option
    sorts: [spree_order_items.total_items_returned desc]
    limit: 1
    custom_color_enabled: false
    show_single_value_title: true
    show_comparison: false
    height: 2
    width: 4
    top: 2
    left: 11

  - name: department
    title: Department
    type: single_value
    model: finery_data
    explore: spree_order_items
    dimensions: [option_info.category]
    listen:
      option: option_info.option
    sorts: [option_info.category]
    limit: 1
    custom_color_enabled: false
    show_single_value_title: true
    show_comparison: false
    height: 2
    width: 7
    top: 2
    left: 15

  - name: return_rates_by_size
    title: Return Rates by Size
    type: looker_bar
    model: finery_data
    explore: spree_order_items
    dimensions: [variant_info.size]
    measures: [spree_order_items.return_rate]
    dynamic_fields:
    - table_calculation: size
      label: Size
      expression: if(${variant_info.size}="6", 6, if(${variant_info.size}="8", 8, if(${variant_info.size}="10", 10, if(${variant_info.size}="12", 12, if(${variant_info.size}="14", 14, if(${variant_info.size}="16", if(${variant_info.size}="18", 18, if(${variant_info.size}="36", 36, if(${variant_info.size}="37", 37, if(${variant_info.size}="38", 38, if(${variant_info.size}="39", 39, if(${variant_info.size}="40", 40, if(${variant_info.size}="41", 41, if(${variant_info.size}="42", 42, 0)))))))))))))
    hidden_fields: [variant_info.size]
    filters:
      calendar_weeks.calendar_date_date: before 28 days ago
    listen:
      option: option_info.option
    sorts: [size]
    limit: 10
    stacking: ''
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
    show_value_labels: true
    label_density: 25
    label_color: [red]
    font_size: 16px
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: false
    show_y_axis_ticks: false
    y_axis_tick_density: default
    y_axis_value_format: 0%
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    label_value_format: 0%
    label_rotation: 0
    show_null_labels: false
    height: 8
    width: 8
    top: 4
    left: 0

  - name: return_reason_breakdown
    title: Return Reason Breakdown
    type: looker_bar
    model: finery_data
    explore: spree_order_items
    dimensions: [spree_order_items.return_reason]
    measures: [spree_order_items.total_items_returned]
    dynamic_fields:
    - table_calculation: items_returned
      label: Items Returned %
      expression: ${spree_order_items.total_items_returned}/sum(${spree_order_items.total_items_returned})
      value_format_name: percent_0
    hidden_fields: [spree_order_items.total_items_returned]
    filters:
      spree_order_items.return_reason: -NULL
    listen:
      option: option_info.option
    sorts: [size, spree_order_items.total_items_returned desc]
    limit: 100
    stacking: ''
    colors: ['#7FCDAE', '#7ED09C', '#7DD389', '#85D67C', '#9AD97B', '#B1DB7A', '#CADF79',
      '#E2DF78', '#E5C877', '#E7AF75', '#EB9474', '#EE7772']
    show_value_labels: true
    label_density: 25
    label_color: [red]
    legend_position: center
    x_axis_gridlines: false
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: false
    show_y_axis_ticks: false
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_labels: false
    height: 8
    width: 14
    top: 4
    left: 8
