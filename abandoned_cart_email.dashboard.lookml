- dashboard: abandoned_cart_email
  title: Abandoned Cart Email
  layout: tile
  tile_size: 100

  elements:

  - name: email_sent
    title: Emails Sent - Last 30 Days
    type: looker_line
    model: finery_data
    explore: mandrill_message_sent
    dimensions: [mandrill_message_sent.email_sent_date]
    measures: [mandrill_message_sent.count_messages_sent]
    filters:
      mandrill_message_sent.email_group: Abandoned Cart
      mandrill_message_sent.email_sent_date: 30 days ago for 30 days
    sorts: [mandrill_message_sent.email_sent_date]
    limit: 500
    column_limit: ''
    stacking: ''
    show_value_labels: false
    label_density: 10
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    show_null_labels: false
    show_null_points: true
    point_style: none
    interpolation: linear

  - name: open_rate
    title: Open Rate - Last 30 Days
    type: looker_line
    model: finery_data
    explore: mandrill_message_sent
    dimensions: [mandrill_message_sent.email_sent_date]
    measures: [mandrill_message_sent.open_rate]
    filters:
      mandrill_message_sent.email_group: Abandoned Cart
      mandrill_message_sent.email_sent_date: 30 days ago for 30 days
    sorts: [mandrill_message_sent.email_sent_date]
    limit: 500
    column_limit: ''
    stacking: ''
    show_value_labels: false
    label_density: 10
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    show_null_labels: false
    show_null_points: true
    point_style: none
    interpolation: linear
    colors: [orange]

  - name: click_rate
    title: Click Rate - Last 30 Days
    type: looker_line
    model: finery_data
    explore: mandrill_message_sent
    dimensions: [mandrill_message_sent.email_sent_date]
    measures: [mandrill_message_sent.click_rate]
    filters:
      mandrill_message_sent.email_group: Abandoned Cart
      mandrill_message_sent.email_sent_date: 30 days ago for 30 days
    sorts: [mandrill_message_sent.email_sent_date]
    limit: 500
    column_limit: ''
    stacking: ''
    show_value_labels: false
    label_density: 10
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    show_null_labels: false
    show_null_points: true
    point_style: none
    interpolation: linear
    colors: [purple]

