- dashboard: website_yesterday_summary
  title: Web Dashbaord - Yesterday - Overview
  layout: static
  tile_size: 50

  elements:

  - name: summary chart
    title: Yesterday's Summary - Sessions vs Orders by Hour
    type: looker_line
    model: finery_data
    explore: atomic_events
    dimensions: [atomic_events.event_time_hour_of_day]
    measures: [atomic_events.count_sessions, transactions.count_transactions]
    filters:
      atomic_events.event_time_date: yesterday
    sorts: [atomic_events.event_time_hour_of_day desc]
    show_null_points: false
    interpolation: monotone
    show_value_labels: false
    show_view_names: false
    colors: [orange, purple]
    point_style: none
    hide_legend: true
    x_axis_gridlines: true
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_label: Hour of Day
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_labels: [Sessions, Orders]
    y_axis_orientation: [left, right]
    stacking: ''
    x_axis_scale: auto
    height: 9
    width: 27
    top: 0
    left: 0



#### conversion rate tiles

  - name: conversion_rate_yesterday
    title: CR Yesterday
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.conversion_rate]
    filters:
      atomic_events.event_time_date: 1 day ago for 1 day
    font_size: small
    height: 3
    width: 3
    top: 9
    left: 0

  - name: conversion_rate_last_week
    title: CR Last Week
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.conversion_rate]
    filters:
      atomic_events.event_time_date: 8 days ago for 1 day
    font_size: small
    height: 3
    width: 3
    top: 9
    left: 3

  - name: conversion_rate_wow
    title: CR WoW
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.conversion_rate_wow]
    sorts: [atomic_events.conversion_rate_wow desc]
    limit: 500
    total: false
    font_size: small
    height: 3
    width: 3
    top: 9
    left: 6

#### order tiles

  - name: orders_yesterday
    title: Orders Yesterday
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [transactions.count_transactions]
    filters:
      atomic_events.event_time_date: 1 day ago for 1 day
    limit: 500
    total: false
    font_size: small
    height: 3
    width: 3
    top: 12
    left: 0

  - name: orders_last_week
    title: Orders Last Week
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [transactions.count_transactions]
    filters:
      atomic_events.event_time_date: 8 days ago for 1 day
    limit: 500
    total: false
    font_size: small
    height: 3
    width: 3
    top: 12
    left: 3

  - name: orders_wow
    title: Orders WoW
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.orders_wow]
    sorts: [atomic_events.orders_wow desc]
    limit: 500
    total: false
    font_size: small
    height: 3
    width: 3
    top: 12
    left: 6

#### items purchased tiles

  - name: items_yesterday
    title: Items Yesterday
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.items_purchased]
    filters:
      atomic_events.event_time_date: 1 day ago for 1 day
    font_size: small
    height: 3
    width: 3
    top: 15
    left: 0

  - name: items_last_week
    title: Items Last Week
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.items_purchased]
    filters:
      atomic_events.event_time_date: 8 days ago for 1 day
    font_size: small
    height: 3
    width: 3
    top: 15
    left: 3

  - name: items_wow
    title: Items Purchased WoW
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.items_purchased_wow]
    font_size: small
    height: 3
    width: 3
    top: 15
    left: 6

#### revenue tiles

  - name: revenue_yesterday
    title: Gross Revenue
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.sum_revenue_ex_coupon_and_vat]
    filters:
      atomic_events.event_time_date: 1 day ago for 1 day
    font_size: small
    height: 3
    width: 3
    top: 18
    left: 0

  - name: revenue_last_week
    title: Revenue Last Week
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.sum_revenue_ex_coupon_and_vat]
    filters:
      atomic_events.event_time_date: 8 days ago for 1 day
    font_size: small
    height: 3
    width: 3
    top: 18
    left: 3

  - name: revenue_wow
    title: Revenue WoW
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.revenue_wow]
    font_size: small
    height: 3
    width: 3
    top: 18
    left: 6
  
  #### sessions tiles

  - name: sessions_yesterday
    title: Visits Yesterday
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.count_sessions]
    filters:
      atomic_events.event_time_date: 1 day ago for 1 day
    limit: 500
    total: false
    font_size: small
    height: 3
    width: 3
    top: 21
    left: 0

  - name: sessions_last_week
    title: Visits Last Week
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.count_sessions]
    filters:
      atomic_events.event_time_date: 8 days ago for 1 day
    limit: 500
    total: false
    font_size: small
    height: 3
    width: 3
    top: 21
    left: 3

  - name: sessions_wow
    title: Visits WoW
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.sessions_wow]
    limit: 500
    total: false
    font_size: small
    height: 3
    width: 3
    top: 21
    left: 6

  #### new sessions tiles

  - name: sessions_yesterday
    title: New Visits Yesterday
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.new_session_percentage]
    filters:
      atomic_events.event_time_date: 1 day ago for 1 day
    limit: 500
    total: false
    font_size: small
    height: 3
    width: 3
    top: 24
    left: 0

  - name: sessions_last_week
    title: New Visits Last Week
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.new_session_percentage]
    filters:
      atomic_events.event_time_date: 8 days ago for 1 day
    limit: 500
    total: false
    font_size: small
    height: 3
    width: 3
    top: 24
    left: 3

  - name: sessions_wow
    title: New Visits WoW
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.new_session_perc_wow]
    limit: 500
    total: false
    font_size: small
    height: 3
    width: 3
    top: 24
    left: 6

#### page_views sessions tiles

  - name: page_views_yesterday
    title: Page Views Yesterday
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.count_page_views]
    filters:
      atomic_events.event_time_date: 1 day ago for 1 day
    limit: 500
    total: false
    font_size: small
    height: 3
    width: 3
    top: 27
    left: 0

  - name: page_views_last_week
    title: Page Views Last Week
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.count_page_views]
    filters:
      atomic_events.event_time_date: 8 days ago for 1 day
    limit: 500
    total: false
    font_size: small
    height: 3
    width: 3
    top: 27
    left: 3

  - name: page_views_wow
    title: Page Views WoW
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.page_views_wow]
    limit: 500
    total: false
    font_size: small
    height: 3
    width: 3
    top: 27
    left: 6
    
#### page_views_per_session tiles

  - name: pv_per_session_yesterday
    title: Page Views/Visit Yesterday
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.page_views_per_session]
    filters:
      atomic_events.event_time_date: 1 day ago for 1 day
    limit: 500
    total: false
    font_size: small
    height: 3
    width: 3
    top: 30
    left: 0

  - name: pv_per_session_last_week
    title: Page Views/Visit Last Week
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.page_views_per_session]
    filters:
      atomic_events.event_time_date: 8 days ago for 1 day
    limit: 500
    total: false
    font_size: small
    height: 3
    width: 3
    top: 30
    left: 3

  - name: pv_per_session_wow
    title: Page Views/Visit WoW
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.page_views_per_session_wow]
    limit: 500
    total: false
    font_size: small
    height: 3
    width: 3
    top: 30
    left: 6

#### engagement_time_per_session tiles

  - name: engag_per_session_yesterday
    title: Avg Visit Duration Yesterday
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.engagement_time_per_session_minutes]
    filters:
      atomic_events.event_time_date: 1 day ago for 1 day
    limit: 500
    total: false
    font_size: small
    height: 3
    width: 3
    top: 33
    left: 0

  - name: engag_per_session_last_week
    title: Avg Visit Duration Last Week
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.engagement_time_per_session_minutes]
    filters:
      atomic_events.event_time_date: 8 days ago for 1 day
    limit: 500
    total: false
    font_size: small
    height: 3
    width: 3
    top: 33
    left: 3

  - name: engag_per_session_wow
    title: Avg Visit Duration WoW
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.engagement_time_per_session_wow]
    limit: 500
    total: false
    font_size: small
    height: 3
    width: 3
    top: 33
    left: 6

#### bounce_rate tiles

  - name: bounce_rate_yesterday
    title: Bounce Rate Yesterday
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.bounce_rate]
    filters:
      atomic_events.event_time_date: 1 day ago for 1 day
    font_size: small
    height: 3
    width: 3
    top: 36
    left: 0

  - name: bounce_rate_last_week
    title: Bounce Rate Last Week
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.bounce_rate]
    filters:
      atomic_events.event_time_date: 8 days ago for 1 day
    font_size: small
    height: 3
    width: 3
    top: 36
    left: 3

  - name: bounce_rate_wow
    title: Bounce Rate WoW
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.bounce_rate_wow]
    font_size: small
    height: 3
    width: 3
    top: 36
    left: 6

#### newsletter_subscribers tiles

  - name: newsletter_subscribers_yesterday
    title: NL Sub Yesterday
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [email_subscriptions.count_newsletter_subscribers]
    filters:
      atomic_events.event_time_date: 1 day ago for 1 day
    font_size: small
    height: 3
    width: 3
    top: 39
    left: 0

  - name: newsletter_subscribers_last_week
    title: NL Sub Last Week
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [email_subscriptions.count_newsletter_subscribers]
    filters:
      atomic_events.event_time_date: 8 days ago for 1 day
    font_size: small
    height: 3
    width: 3
    top: 39
    left: 3

  - name: newsletter_subscribers_wow
    title: NL Sub WoW
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [email_subscriptions.newsletter_subscribers_wow]
    font_size: small
    height: 3
    width: 3
    top: 39
    left: 6

#### referrals tiles

  - name: referrals_yesterday
    title: Referrals Yesterday
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [email_subscriptions.count_referrals]
    filters:
      atomic_events.event_time_date: 1 day ago for 1 day
    font_size: small
    height: 3
    width: 3
    top: 42
    left: 0

  - name: referrals_last_week
    title: Referrals Last Week
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [email_subscriptions.count_referrals]
    filters:
      atomic_events.event_time_date: 8 days ago for 1 day
    font_size: small
    height: 3
    width: 3
    top: 42
    left: 3

  - name: referrals_wow
    title: Referrals WoW
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [email_subscriptions.referrals_wow]
    font_size: small
    height: 3
    width: 3
    top: 42
    left: 6

#### avg basket size tiles

  - name: avg_basket_size_yesterday
    title: Avg Basket Size Yesterday
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.avg_basket_size]
    filters:
      atomic_events.event_time_date: 1 day ago for 1 day
    font_size: small
    height: 3
    width: 3
    top: 45
    left: 0

  - name: avg_basket_size_last_week
    title: Avg Basket Size Last Week
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.avg_basket_size]
    filters:
      atomic_events.event_time_date: 8 days ago for 1 day
    font_size: small
    height: 3
    width: 3
    top: 45
    left: 3

  - name: avg_basket_size_wow
    title: Avg Basket Size WoW
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.basket_size_wow]
    font_size: small
    height: 3
    width: 3
    top: 45
    left: 6

#### avg basket value tiles

  - name: avg_basket_value_yesterday
    title: Avg Basket Value Yesterday
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.avg_basket_value]
    filters:
      atomic_events.event_time_date: 1 day ago for 1 day
    font_size: small
    height: 3
    width: 3
    top: 48
    left: 0

  - name: avg_basket_value_last_week
    title: Avg Basket Value Last Week
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.avg_basket_value]
    filters:
      atomic_events.event_time_date: 8 days ago for 1 day
    font_size: small
    height: 3
    width: 3
    top: 48
    left: 3

  - name: avg_basket_value_wow
    title: Avg Basket Value WoW
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.basket_value_wow]
    font_size: small
    height: 3
    width: 3
    top: 48
    left: 6
    
########################################### Graphs

  - name: cr_tw_vs_lw
    title: Conversion Rate This Week vs Last Week vs Week Before Last
    type: looker_line
    model: finery_data
    explore: atomic_events
    dimensions: [atomic_events.event_time_day_of_week, atomic_events.tw_lw_flag, atomic_events.event_time_week]
    pivots: [atomic_events.tw_lw_flag, atomic_events.event_time_week]
    measures: [atomic_events.conversion_rate]
    filters:
      atomic_events.event_time_date: 2 weeks ago for 3 weeks
      atomic_events.event_time_time: before 0 days ago
    sorts: [atomic_events.event_time_day_of_week, atomic_events.event_time_week desc]
    font_size: small
    show_null_points: false
    show_value_labels: false
    show_view_names: true
    show_x_axis_label: true
    show_x_axis_ticks: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    x_axis_datetime_label: ''
    x_axis_label: Hour of Day
    discontinuous_nulls: false
    interpolation: monotone
    colors: [blue, red, lightgreen]
    stacking: ''
    x_axis_scale: auto
    point_style: none
    height: 6
    width: 9
    top: 9
    left: 9

  - name: cr_lt
    title: Conversion Rate - Last 28 Days
    type: looker_line
    model: finery_data
    explore: atomic_events
    dimensions: [atomic_events.event_time_date]
    measures: [atomic_events.conversion_rate]
    filters:
      atomic_events.event_time_date: 28 days ago for 28 days
    sorts: [atomic_events.event_time_date desc]
    limit: 500
    total: false
    font_size: small
    show_null_points: false
    show_value_labels: false
    show_view_names: true
    show_x_axis_label: true
    show_x_axis_ticks: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    x_axis_datetime_label: ''
    x_axis_label: Hour of Day
    discontinuous_nulls: false
    interpolation: monotone
    colors: [orange]
    stacking: ''
    x_axis_scale: auto
    point_style: none
    reference_lines:
      - value: [deviation, mean, deviation]
        label: "Avg {{mean}}"
    height: 6
    width: 9
    top: 9
    left: 18

  - name: orders_tw_vs_lw
    title: Orders This Week vs Last Week vs Week Before Last
    type: looker_line
    model: finery_data
    explore: atomic_events
    dimensions: [atomic_events.event_time_day_of_week, atomic_events.tw_lw_flag, atomic_events.event_time_week]
    pivots: [atomic_events.tw_lw_flag, atomic_events.event_time_week]
    measures: [transactions.count_transactions]
    filters:
      atomic_events.event_time_date: 2 weeks ago for 3 weeks
      atomic_events.event_time_time: before 0 days ago
    sorts: [atomic_events.event_time_day_of_week, atomic_events.event_time_week desc]
    limit: 500
    total: false
    font_size: small
    show_null_points: false
    show_value_labels: false
    show_view_names: true
    show_x_axis_label: true
    show_x_axis_ticks: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    x_axis_datetime_label: ''
    x_axis_label: Hour of Day
    discontinuous_nulls: false
    interpolation: monotone
    colors: [blue, red, lightgreen]
    stacking: ''
    x_axis_scale: auto
    point_style: none
    height: 6
    width: 9
    top: 15
    left: 9

  - name: orders_lt
    title: Orders - Last 28 Days
    type: looker_line
    model: finery_data
    explore: atomic_events
    dimensions: [atomic_events.event_time_date]
    measures: [transactions.count_transactions]
    filters:
      atomic_events.event_time_date: 28 days ago for 28 days
    sorts: [atomic_events.event_time_date desc]
    limit: 500
    total: false
    font_size: small
    show_null_points: false
    show_value_labels: false
    show_view_names: true
    show_x_axis_label: true
    show_x_axis_ticks: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    x_axis_datetime_label: ''
    x_axis_label: Hour of Day
    discontinuous_nulls: false
    interpolation: monotone
    colors: [orange]
    stacking: ''
    x_axis_scale: auto
    point_style: none
    reference_lines:
      - value: mean
        label: "Avg {{mean}}"
    height: 6
    width: 9
    top: 15
    left: 18

  - name: sessions_tw_vs_lw
    title: Visits This Week vs Last Week vs Week Before Last
    type: looker_line
    model: finery_data
    explore: atomic_events
    dimensions: [atomic_events.event_time_day_of_week, atomic_events.tw_lw_flag, atomic_events.event_time_week]
    pivots: [atomic_events.tw_lw_flag, atomic_events.event_time_week]
    measures: [atomic_events.count_sessions]
    filters:
      atomic_events.event_time_date: 2 weeks ago for 3 weeks
      atomic_events.event_time_time: before 0 days ago
    sorts: [atomic_events.event_time_day_of_week, atomic_events.event_time_week desc]
    limit: 500
    total: false
    font_size: small
    show_null_points: false
    show_value_labels: false
    show_view_names: true
    show_x_axis_label: true
    show_x_axis_ticks: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    x_axis_datetime_label: ''
    x_axis_label: Hour of Day
    discontinuous_nulls: false
    interpolation: monotone
    colors: [blue, red, lightgreen]
    stacking: ''
    x_axis_scale: auto
    point_style: none
    height: 6
    width: 9
    top: 21
    left: 9

  - name: sessions_lt
    title: Visits - Last 28 Days
    type: looker_line
    model: finery_data
    explore: atomic_events
    dimensions: [atomic_events.event_time_date]
    measures: [atomic_events.count_sessions]
    filters:
      atomic_events.event_time_date: 28 days ago for 28 days
    sorts: [atomic_events.event_time_date desc]
    limit: 500
    total: false
    font_size: small
    show_null_points: false
    show_value_labels: false
    show_view_names: true
    show_x_axis_label: true
    show_x_axis_ticks: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    x_axis_datetime_label: ''
    x_axis_label: Hour of Day
    discontinuous_nulls: false
    interpolation: monotone
    colors: [orange]
    stacking: ''
    x_axis_scale: auto
    point_style: none
    reference_lines:
      - value: mean
        label: "Avg {{mean}}"
    height: 6
    width: 9
    top: 21
    left: 18

  - name: new_sessions_tw_vs_lw
    title: New Session % This Week vs Last Week vs Week Before Last
    type: looker_line
    model: finery_data
    explore: atomic_events
    dimensions: [atomic_events.event_time_day_of_week, atomic_events.tw_lw_flag, atomic_events.event_time_week]
    pivots: [atomic_events.tw_lw_flag, atomic_events.event_time_week]
    measures: [atomic_events.new_session_percentage]
    filters:
      atomic_events.event_time_date: 2 weeks ago for 3 weeks
      atomic_events.event_time_time: before 0 days ago
    sorts: [atomic_events.event_time_day_of_week, atomic_events.event_time_week desc]
    limit: 500
    total: false
    font_size: small
    show_null_points: false
    show_value_labels: false
    show_view_names: true
    show_x_axis_label: true
    show_x_axis_ticks: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    x_axis_datetime_label: ''
    x_axis_label: Hour of Day
    discontinuous_nulls: false
    interpolation: monotone
    colors: [blue, red, lightgreen]
    stacking: ''
    x_axis_scale: auto
    point_style: none
    height: 6
    width: 9
    top: 27
    left: 9

  - name: new_sessions_lt
    title: New Session % - Last 28 Days
    type: looker_line
    model: finery_data
    explore: atomic_events
    dimensions: [atomic_events.event_time_date]
    measures: [atomic_events.new_session_percentage]
    filters:
      atomic_events.event_time_date: 28 days ago for 28 days
    sorts: [atomic_events.event_time_date desc]
    limit: 500
    total: false
    font_size: small
    show_null_points: false
    show_value_labels: false
    show_view_names: true
    show_x_axis_label: true
    show_x_axis_ticks: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    x_axis_datetime_label: ''
    x_axis_label: Hour of Day
    discontinuous_nulls: false
    interpolation: monotone
    colors: [orange]
    stacking: ''
    x_axis_scale: auto
    point_style: none
    reference_lines:
      - value: mean
        label: "Avg {{mean}}"
    height: 6
    width: 9
    top: 27
    left: 18

  - name: nl_sub_tw_vs_lw
    title: Newsletter Subscriptions This Week vs Last Week vs Week Before Last
    type: looker_line
    model: finery_data
    explore: atomic_events
    dimensions: [atomic_events.event_time_day_of_week, atomic_events.tw_lw_flag, atomic_events.event_time_week]
    pivots: [atomic_events.tw_lw_flag, atomic_events.event_time_week]
    measures: [email_subscriptions.count_newsletter_subscribers]
    filters:
      atomic_events.event_time_date: 2 weeks ago for 3 weeks
      atomic_events.event_time_time: before 0 days ago
    sorts: [atomic_events.event_time_day_of_week, atomic_events.event_time_week desc]
    limit: 500
    total: false
    font_size: small
    show_null_points: false
    show_value_labels: false
    show_view_names: true
    show_x_axis_label: true
    show_x_axis_ticks: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    x_axis_datetime_label: ''
    x_axis_label: Hour of Day
    discontinuous_nulls: false
    interpolation: monotone
    colors: [blue, red, lightgreen]
    stacking: ''
    x_axis_scale: auto
    point_style: none
    height: 6
    width: 9
    top: 33
    left: 9

  - name: nl_sub_lt
    title: Newsletter Subscriptions - Last 28 Days
    type: looker_line
    model: finery_data
    explore: atomic_events
    dimensions: [atomic_events.event_time_date]
    measures: [email_subscriptions.count_newsletter_subscribers]
    filters:
      atomic_events.event_time_date: 28 days ago for 28 days
    sorts: [atomic_events.event_time_date desc]
    limit: 500
    total: false
    font_size: small
    show_null_points: false
    show_value_labels: false
    show_view_names: true
    show_x_axis_label: true
    show_x_axis_ticks: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    x_axis_datetime_label: ''
    x_axis_label: Hour of Day
    discontinuous_nulls: false
    interpolation: monotone
    colors: [orange]
    stacking: ''
    x_axis_scale: auto
    point_style: none
    reference_lines:
      - value: mean
        label: "Avg {{mean}}"
    height: 6
    width: 9
    top: 33
    left: 18


  - name: ref_tw_vs_lw
    title: Referrals This Week vs Last Week vs Week Before Last
    type: looker_line
    model: finery_data
    explore: atomic_events
    dimensions: [atomic_events.event_time_day_of_week, atomic_events.tw_lw_flag, atomic_events.event_time_week]
    pivots: [atomic_events.tw_lw_flag, atomic_events.event_time_week]
    measures: [email_subscriptions.count_referrals]
    filters:
      atomic_events.event_time_date: 2 weeks ago for 3 weeks
      atomic_events.event_time_time: before 0 days ago
    sorts: [atomic_events.event_time_day_of_week, atomic_events.event_time_week desc]
    limit: 500
    total: false
    font_size: small
    show_null_points: false
    show_value_labels: false
    show_view_names: true
    show_x_axis_label: true
    show_x_axis_ticks: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    x_axis_datetime_label: ''
    x_axis_label: Hour of Day
    discontinuous_nulls: false
    interpolation: monotone
    colors: [blue, red, lightgreen]
    stacking: ''
    x_axis_scale: auto
    point_style: none
    height: 6
    width: 9
    top: 39
    left: 9

  - name: ref_lt
    title: Referrals - Last 28 Days
    type: looker_line
    model: finery_data
    explore: atomic_events
    dimensions: [atomic_events.event_time_date]
    measures: [email_subscriptions.count_referrals]
    filters:
      atomic_events.event_time_date: 28 days ago for 28 days
    sorts: [atomic_events.event_time_date desc]
    limit: 500
    total: false
    font_size: small
    show_null_points: false
    show_value_labels: false
    show_view_names: true
    show_x_axis_label: true
    show_x_axis_ticks: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    x_axis_datetime_label: ''
    x_axis_label: Hour of Day
    discontinuous_nulls: false
    interpolation: monotone
    colors: [orange]
    stacking: ''
    x_axis_scale: auto
    point_style: none
    reference_lines:
      - value: mean
        label: "Avg {{mean}}"
    height: 6
    width: 9
    top: 39
    left: 18