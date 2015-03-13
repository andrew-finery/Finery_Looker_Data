- dashboard: website_today_summary
  title: Web Dashboard - Today Summary
  layout: static
  tile_size: 50

  elements:

  - name: latest_snowplow_update
    title: Latest Data Available
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.latest_update]
    font_size: small
    height: 2
    width: 6
    top: 0
    left: 0
    
# CONVERSION RATE

  - name: conversion_rate_today
    title: CR - So Far Today
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.conversion_rate]
    filters:
      atomic_events.event_time_date: 0 days ago for 1 day
      atomic_events.event_time_time: before 1 hour ago
    font_size: small
    height: 2
    width: 3
    top: 2
    left: 0

  - name: conversion_lw
    title: CR - Same Point Last Week
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.conversion_rate]
    filters:
      atomic_events.event_time_date: 7 days ago for 1 day
      atomic_events.event_time_time: before 169 hours ago
    font_size: small
    height: 2
    width: 3
    top: 2
    left: 3

  - name: conversion_rate_last_week_tot
    title: TARGET - CR Last Week
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.conversion_rate]
    filters:
      atomic_events.event_time_date: 7 days ago for 1 day
    font_size: small
    height: 2
    width: 3
    top: 2
    left: 6

  - name: conv_rate_today_vs_lw
    title: Conversion Rate - Today vs Last Week
    type: looker_line
    model: finery_data
    explore: atomic_events
    dimensions: [atomic_events.event_time_hour_of_day, atomic_events.today_tw_lw_flag]
    pivots: [atomic_events.today_tw_lw_flag]
    measures: [atomic_events.conversion_rate]
    filters:
      atomic_events.event_time_time: before 1 hours ago
      atomic_events.today_tw_lw_flag: -NULL
    sorts: [atomic_events.event_time_hour_of_day, atomic_events.today_tw_lw_flag desc]
    limit: 500
    total: false
    show_null_points: false
    font_size: small
    show_value_labels: false
    show_view_names: true
    x_axis_gridlines: true
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_gridlines: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    x_axis_datetime_label: ''
    x_axis_label: Hour of Day
    stacking: ''
    x_axis_scale: auto
    point_style: none
    interpolation: monotone
    colors: [blue, red]
    height: 6
    width: 9
    top: 4
    left: 0

# ORDERS

  - name: orders_today
    title: Orders - So Far Today
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [transactions.count_transactions]
    filters:
      atomic_events.event_time_date: 0 days ago for 1 day
      atomic_events.event_time_time: before 1 hour ago
    font_size: small
    height: 2
    width: 3
    top: 10
    left: 0

  - name: orders_lw
    title: Orders - Same Point Last Week
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [transactions.count_transactions]
    filters:
      atomic_events.event_time_date: 7 days ago for 1 day
      atomic_events.event_time_time: before 169 hours ago
    font_size: small
    height: 2
    width: 3
    top: 10
    left: 3

  - name: orders_last_week_tot
    title: TARGET - Orders Last Week
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [transactions.count_transactions]
    filters:
      atomic_events.event_time_date: 7 days ago for 1 day
    font_size: small
    height: 2
    width: 3
    top: 10
    left: 6

  - name: orders_today_vs_lw
    title: Orders - Today vs Last Week
    type: looker_line
    model: finery_data
    explore: atomic_events
    dimensions: [atomic_events.event_time_hour_of_day, atomic_events.today_tw_lw_flag]
    pivots: [atomic_events.today_tw_lw_flag]
    measures: [transactions.count_transactions]
    filters:
      atomic_events.event_time_time: before 1 hours ago
      atomic_events.today_tw_lw_flag: -NULL
    sorts: [atomic_events.event_time_hour_of_day, atomic_events.today_tw_lw_flag desc]
    limit: 500
    total: false
    show_null_points: false
    font_size: small
    show_value_labels: false
    show_view_names: true
    x_axis_gridlines: true
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_gridlines: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    x_axis_datetime_label: ''
    x_axis_label: Hour of Day
    stacking: ''
    x_axis_scale: auto
    point_style: none
    interpolation: monotone
    colors: [blue, red]
    height: 6
    width: 9
    top: 12
    left: 0

# REVENUE

  - name: rev_today
    title: Revenue - So Far Today
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.sum_revenue_ex_coupon_and_vat]
    filters:
      atomic_events.event_time_date: 0 days ago for 1 day
      atomic_events.event_time_time: before 1 hour ago
    font_size: small
    height: 2
    width: 3
    top: 18
    left: 0

  - name: rev_lw
    title: Revenue - Same Point Last Week
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.sum_revenue_ex_coupon_and_vat]
    filters:
      atomic_events.event_time_date: 7 days ago for 1 day
      atomic_events.event_time_time: before 169 hours ago
    font_size: small
    height: 2
    width: 3
    top: 18
    left: 3

  - name: rev_last_week_tot
    title: TARGET - Revenue Last Week
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.sum_revenue_ex_coupon_and_vat]
    filters:
      atomic_events.event_time_date: 7 days ago for 1 day
    font_size: small
    height: 2
    width: 3
    top: 18
    left: 6

  - name: rev_today_vs_lw
    title: Revenue - Today vs Last Week
    type: looker_line
    model: finery_data
    explore: atomic_events
    dimensions: [atomic_events.event_time_hour_of_day, atomic_events.today_tw_lw_flag]
    pivots: [atomic_events.today_tw_lw_flag]
    measures: [atomic_events.sum_revenue_ex_coupon_and_vat]
    filters:
      atomic_events.event_time_time: before 1 hours ago
      atomic_events.today_tw_lw_flag: -NULL
    sorts: [atomic_events.event_time_hour_of_day, atomic_events.today_tw_lw_flag desc]
    limit: 500
    total: false
    show_null_points: false
    font_size: small
    show_value_labels: false
    show_view_names: true
    x_axis_gridlines: true
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_gridlines: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    x_axis_datetime_label: ''
    x_axis_label: Hour of Day
    stacking: ''
    x_axis_scale: auto
    point_style: none
    interpolation: monotone
    colors: [blue, red]
    height: 6
    width: 9
    top: 20
    left: 0

# BOUNCE RATE

  - name: bounce_rate_today
    title: Bounce Rate - So Far Today
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.bounce_rate]
    filters:
      atomic_events.event_time_date: 0 days ago for 1 day
      atomic_events.event_time_time: before 1 hour ago
    font_size: small
    height: 2
    width: 3
    top: 26
    left: 0

  - name: bounce_rate_lw
    title: Bounce Rate - Same Point Last Week
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.bounce_rate]
    filters:
      atomic_events.event_time_date: 7 days ago for 1 day
      atomic_events.event_time_time: before 169 hours ago
    font_size: small
    height: 2
    width: 3
    top: 26
    left: 3

  - name: bounce_rate_last_week_tot
    title: TARGET - Bounce Rate Last Week
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.bounce_rate]
    filters:
      atomic_events.event_time_date: 7 days ago for 1 day
    font_size: small
    height: 2
    width: 3
    top: 26
    left: 6

  - name: bounce_rate_today_vs_lw
    title: Bounce Rate - Today vs Last Week
    type: looker_line
    model: finery_data
    explore: atomic_events
    dimensions: [atomic_events.event_time_hour_of_day, atomic_events.today_tw_lw_flag]
    pivots: [atomic_events.today_tw_lw_flag]
    measures: [atomic_events.bounce_rate]
    filters:
      atomic_events.event_time_time: before 1 hours ago
      atomic_events.today_tw_lw_flag: -NULL
    sorts: [atomic_events.event_time_hour_of_day, atomic_events.today_tw_lw_flag desc]
    limit: 500
    total: false
    show_null_points: false
    font_size: small
    show_value_labels: false
    show_view_names: true
    x_axis_gridlines: true
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_gridlines: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    x_axis_datetime_label: ''
    x_axis_label: Hour of Day
    stacking: ''
    x_axis_scale: auto
    point_style: none
    interpolation: monotone
    colors: [blue, red]
    height: 6
    width: 9
    top: 28
    left: 0


# VISITS

  - name: visits_today
    title: Visits - So Far Today
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.count_sessions]
    filters:
      atomic_events.event_time_date: 0 days ago for 1 day
      atomic_events.event_time_time: before 1 hour ago
    font_size: small
    height: 2
    width: 3
    top: 2
    left: 10

  - name: visits_lw
    title: Visits - Same point Last Week
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.count_sessions]
    filters:
      atomic_events.event_time_date: 7 days ago for 1 day
      atomic_events.event_time_time: before 169 hours ago
    font_size: small
    height: 2
    width: 3
    top: 2
    left: 13

  - name: visits_last_week_tot
    title: TARGET - Visits Last Week
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.count_sessions]
    filters:
      atomic_events.event_time_date: 7 days ago for 1 day
    font_size: small
    height: 2
    width: 3
    top: 2
    left: 16

  - name: sessions_vs_lw
    title: Visits - Today vs Last Week
    type: looker_line
    model: finery_data
    explore: atomic_events
    dimensions: [atomic_events.event_time_hour_of_day, atomic_events.today_tw_lw_flag]
    pivots: [atomic_events.today_tw_lw_flag]
    measures: [atomic_events.count_sessions]
    filters:
      atomic_events.event_time_time: before 1 hours ago
      atomic_events.today_tw_lw_flag: -NULL
    sorts: [atomic_events.event_time_hour_of_day, atomic_events.today_tw_lw_flag desc]
    limit: 500
    total: false
    show_null_points: false
    font_size: small
    show_value_labels: false
    show_view_names: true
    x_axis_gridlines: true
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_gridlines: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    x_axis_datetime_label: ''
    x_axis_label: Hour of Day
    stacking: ''
    x_axis_scale: auto
    point_style: none
    interpolation: monotone
    colors: [blue, red]
    height: 6
    width: 9
    top: 4
    left: 10

# NEWSLETTER SUBSCRIPTIONS

  - name: nl_sub_today
    title: Newsletter Sub - So Far Today
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [email_subscriptions.count_newsletter_subscribers]
    filters:
      atomic_events.event_time_date: 0 days ago for 1 day
      atomic_events.event_time_time: before 1 hour ago
    font_size: small
    height: 2
    width: 3
    top: 10
    left: 10

  - name: nl_sub_lw
    title: NL Sub - Same Point Last Week
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [email_subscriptions.count_newsletter_subscribers]
    filters:
      atomic_events.event_time_date: 7 days ago for 1 day
      atomic_events.event_time_time: before 169 hours ago
    font_size: small
    height: 2
    width: 3
    top: 10
    left: 13

  - name: nl_sub_last_week_tot
    title: TARGET - NL Sub Last Week
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [email_subscriptions.count_newsletter_subscribers]
    filters:
      atomic_events.event_time_date: 7 days ago for 1 day
    font_size: small
    height: 2
    width: 3
    top: 10
    left: 16

  - name: nl_sub_vs_lw
    title: Newsletter Subscriptions - Today vs Last Week
    type: looker_line
    model: finery_data
    explore: atomic_events
    dimensions: [atomic_events.event_time_hour_of_day, atomic_events.today_tw_lw_flag]
    pivots: [atomic_events.today_tw_lw_flag]
    measures: [email_subscriptions.count_newsletter_subscribers]
    filters:
      atomic_events.event_time_time: before 1 hours ago
      atomic_events.today_tw_lw_flag: -NULL
    sorts: [atomic_events.event_time_hour_of_day, atomic_events.today_tw_lw_flag desc]
    limit: 500
    total: false
    show_null_points: false
    font_size: small
    show_value_labels: false
    show_view_names: true
    x_axis_gridlines: true
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_gridlines: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    x_axis_datetime_label: ''
    x_axis_label: Hour of Day
    stacking: ''
    x_axis_scale: auto
    point_style: none
    interpolation: monotone
    colors: [blue, red]
    height: 6
    width: 9
    top: 12
    left: 10

# REFERRALS SUBSCRIPTIONS

  - name: referrals_today
    title: Referrals - So Far Today
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [email_subscriptions.count_referrals]
    filters:
      atomic_events.event_time_date: 0 days ago for 1 day
      atomic_events.event_time_time: before 1 hour ago
    font_size: small
    height: 2
    width: 3
    top: 18
    left: 10

  - name: referrals_lw
    title: Referrals - Same Point Last Week
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [email_subscriptions.count_referrals]
    filters:
      atomic_events.event_time_date: 7 days ago for 1 day
      atomic_events.event_time_time: before 169 hours ago
    font_size: small
    height: 2
    width: 3
    top: 18
    left: 13

  - name: referrals_last_week_tot
    title: TARGET - Referrals Last Week
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [email_subscriptions.count_referrals]
    filters:
      atomic_events.event_time_date: 7 days ago for 1 day
    font_size: small
    height: 2
    width: 3
    top: 18
    left: 16

  - name: referrals_vs_lw
    title: Referrals - Today vs Last Week
    type: looker_line
    model: finery_data
    explore: atomic_events
    dimensions: [atomic_events.event_time_hour_of_day, atomic_events.today_tw_lw_flag]
    pivots: [atomic_events.today_tw_lw_flag]
    measures: [email_subscriptions.count_referrals]
    filters:
      atomic_events.event_time_time: before 1 hours ago
      atomic_events.today_tw_lw_flag: -NULL
    sorts: [atomic_events.event_time_hour_of_day, atomic_events.today_tw_lw_flag desc]
    limit: 500
    total: false
    show_null_points: false
    font_size: small
    show_value_labels: false
    show_view_names: true
    x_axis_gridlines: true
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_gridlines: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    x_axis_datetime_label: ''
    x_axis_label: Hour of Day
    stacking: ''
    x_axis_scale: auto
    point_style: none
    interpolation: monotone
    colors: [blue, red]
    height: 6
    width: 9
    top: 20
    left: 10

# NEW SESSIONS

  - name: new_sessions_today
    title: New Session % - So Far Today
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.new_session_percentage]
    filters:
      atomic_events.event_time_date: 0 days ago for 1 day
      atomic_events.event_time_time: before 1 hour ago
    font_size: small
    height: 2
    width: 3
    top: 26
    left: 10

  - name: new_sessions_lw
    title: New Session % - Same Point Last Week
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.new_session_percentage]
    filters:
      atomic_events.event_time_date: 7 days ago for 1 day
      atomic_events.event_time_time: before 169 hours ago
    font_size: small
    height: 2
    width: 3
    top: 26
    left: 13

  - name: new_sessions_last_week_tot
    title: TARGET - New Session % Last Week
    type: single_value
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.new_session_percentage]
    filters:
      atomic_events.event_time_date: 7 days ago for 1 day
    font_size: small
    height: 2
    width: 3
    top: 26
    left: 16

  - name: new_sessions_vs_lw
    title: New Session % - Today vs Last Week
    type: looker_line
    model: finery_data
    explore: atomic_events
    dimensions: [atomic_events.event_time_hour_of_day, atomic_events.today_tw_lw_flag]
    pivots: [atomic_events.today_tw_lw_flag]
    measures: [atomic_events.new_session_percentage]
    filters:
      atomic_events.event_time_time: before 1 hours ago
      atomic_events.today_tw_lw_flag: -NULL
    sorts: [atomic_events.event_time_hour_of_day, atomic_events.today_tw_lw_flag desc]
    limit: 500
    total: false
    show_null_points: false
    font_size: small
    show_value_labels: false
    show_view_names: true
    x_axis_gridlines: true
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_gridlines: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    x_axis_datetime_label: ''
    x_axis_label: Hour of Day
    stacking: ''
    x_axis_scale: auto
    point_style: none
    interpolation: monotone
    colors: [blue, red]
    height: 6
    width: 9
    top: 28
    left: 10
