- dashboard: crm_newsletter_dashboard
  title: Crm Newsletter Dashboard
  layout:  static
  tile_size: 100

#  filters:

  elements:
  - name: current_newsletter_subscribers
    title: Current Newsletter Subscribers
    type: single_value
    model: finery_data
    explore: mc_newsletter_subscribers
    measures: [mc_newsletter_subscribers.unique_email_addresses]
    filters:
      mc_newsletter_subscribers.status: '"subscribed"'
    sorts: [mc_newsletter_subscribers.unique_email_addresses desc]
    limit: 500
    column_limit: 50
    font_size: fit
    value_format: 0.#, "k"
    top: 0
    left: 0
    height: 2
    width: 2


  - name: running_total_newsletter_subscribers
    title: Newsletter List Size - Time Evolution
    type: looker_area
    model: finery_data
    explore: mc_newsletter_subscribers
    dimensions: [mc_newsletter_subscribers.member_subscribed_time_month, mc_newsletter_subscribers.status]
    pivots: [mc_newsletter_subscribers.status]
    measures: [mc_newsletter_subscribers.unique_email_addresses]
    dynamic_fields:
    - table_calculation: running_total
      label: Running Total
      expression: running_total(${mc_newsletter_subscribers.unique_email_addresses})
    filters:
      mc_newsletter_subscribers.status: '"subscribed"'
    sorts: [mc_newsletter_subscribers.member_subscribed_time_month, mc_newsletter_subscribers.status]
    limit: 500
    column_limit: 50
    total: true
    colors: ['#5245ed']
    label_density: 25
    legend_position: center
    show_view_names: false
    hidden_series: [subscribed - Mc Newsletter Subscribers Unique Emails Total]
    y_axis_combined: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_ticks: true
    x_axis_datetime_label: '%b %Y'
    x_axis_scale: ordinal
    show_null_points: true
    point_style: none
    interpolation: linear
    show_x_axis_label: false
    hide_legend: true
    top: 0
    left: 2
    height: 4
    width: 5

  - name: last_10_nls_engagement_trend
    title: Newsletter Engagement Trends
    type: looker_line
    model: finery_data
    explore: mc_campaigns
    dimensions: [mc_campaigns.email_sent_at_date]
    measures: [mc_campaigns.open_rate, mc_campaigns.click_rate]
    filters:
      mc_campaigns.folder_name: '"Newsletters"'
    sorts: [mc_campaigns.email_sent_at_date desc]
    limit: 10
    colors: ['#62bad4', '#a9c574']
    label_density: 25
    hide_legend: true
    show_y_axis_labels: true
    y_axis_combined: false
    show_y_axis_ticks: true
    y_axis_value_format: 0%
    y_axis_orientation: [left, right]
    y_axis_tick_density: default
    show_x_axis_ticks: true
    x_axis_datetime_label: '%d %b %y'
    x_axis_scale: auto
    show_null_points: true
    point_style: none
    interpolation: linear
    show_x_axis_label: false
    show_view_names: false
    top: 0
    left: 7
    height: 4
    width: 5

  - name: last_10_newsletters
    title: Last 10 Newsletters - Performance
    type: table
    model: finery_data
    explore: sessions
    dimensions: [email_campaigns.email_sent_at_time, email_campaigns.campaign_title,
      email_campaigns.emails_sent, email_campaigns.unique_opens, email_campaigns.campaign_open_rate,
      email_campaigns.subscriber_clicks, email_campaigns.campaign_click_rate]
    measures: [sessions.count, sessions.engagement_rate, sessions.sum_gross_revenue_ex_discount_ex_vat,
      sessions.revenue_per_session, sessions.sum_orders, sessions.conversion_rate]
    filters:
      email_campaigns.email_sent_at_date: 3 months
      email_campaigns.folder_name: '"Newsletters"'
    sorts: [email_campaigns.email_sent_at_time desc]
    limit: 10
    show_view_names: false
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
    ordering: none
    show_null_labels: false
    show_row_numbers: false
    top: 4
    left: 0
    height: 5
    width: 12

