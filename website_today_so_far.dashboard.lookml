- dashboard: website_today_summary
  title: Website - Today so Far
  layout: grid
  tile_size: 50

  elements:

  - name: latest_snowplow_update
    title: Latest Data Available
    type: single_value
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_hour]
    filters:
      sessions.start_date: today
    sorts: [sessions.start_hour desc]
    limit: 1
    font_size: small
    show_null_points: false
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
    height: 3
    width: 9
    top: 0
    left: 0
    
# CONVERSION RATE

  - name: conversion_rate_today
    title: CR - So Far Today
    type: single_value
    model: finery_data
    explore: sessions
    measures: [sessions.conversion_rate]
    filters:
      sessions.start_date: 0 days ago for 1 day
      sessions.start_time: before 0 hours ago
    font_size: small
    height: 3
    width: 3
    top: 3
    left: 0

  - name: conversion_lw
    title: CR - Same Point Last Week
    type: single_value
    model: finery_data
    explore: sessions
    measures: [sessions.conversion_rate]
    filters:
      sessions.start_date: 7 days ago for 1 day
      sessions.start_time: before 169 hours ago
    font_size: small
    height: 3
    width: 3
    top: 3
    left: 3

  - name: conversion_rate_last_week_tot
    title: TARGET - CR Last Week
    type: single_value
    model: finery_data
    explore: sessions
    measures: [sessions.conversion_rate]
    filters:
      sessions.start_date: 7 days ago for 1 day
    font_size: small
    height: 3
    width: 3
    top: 3
    left: 6

  - name: conv_rate_today_vs_lw
    title: Conversion Rate - Today vs Last Week
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_hour_of_day, sessions.start_date]
    pivots: [sessions.start_date]
    measures: [sessions.conversion_rate]
    filters:
      sessions.start_date: 7 days ago, today
      sessions.start_time: before 1 hours ago
    sorts: [sessions.start_hour_of_day, sessions.start_date desc]
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
    top: 6
    left: 0

# ORDERS

  - name: orders_today
    title: Orders - So Far Today
    type: single_value
    model: finery_data
    explore: sessions
    measures: [transactions.count_transactions]
    filters:
      sessions.start_date: 0 days ago for 1 day
      sessions.start_time: before 0 hours ago
    font_size: small
    height: 3
    width: 3
    top: 12
    left: 0

  - name: orders_lw
    title: Orders - Same Point Last Week
    type: single_value
    model: finery_data
    explore: sessions
    measures: [transactions.count_transactions]
    filters:
      sessions.start_date: 7 days ago for 1 day
      sessions.start_time: before 169 hours ago
    font_size: small
    height: 3
    width: 3
    top: 12
    left: 3

  - name: orders_last_week_tot
    title: TARGET - Orders Last Week
    type: single_value
    model: finery_data
    explore: sessions
    measures: [transactions.count_transactions]
    filters:
      sessions.start_date: 7 days ago for 1 day
    font_size: small
    height: 3
    width: 3
    top: 12
    left: 6

  - name: orders_today_vs_lw
    title: Orders - Today vs Last Week
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_hour_of_day, sessions.start_date]
    pivots: [sessions.start_date]
    measures: [transactions.count_transactions]
    filters:
      sessions.start_time: before 1 hours ago
      sessions.start_date: 7 days ago, today
    sorts: [sessions.start_hour_of_day, sessions.start_date desc]
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
    top: 15
    left: 0

# REVENUE

  - name: rev_today
    title: Revenue - So Far Today
    type: single_value
    model: finery_data
    explore: sessions
    measures: [transactions.gross_revenue_ex_discount_ex_vat]
    filters:
      sessions.start_date: 0 days ago for 1 day
      sessions.start_time: before 0 hours ago
    font_size: small
    height: 3
    width: 3
    top: 21
    left: 0

  - name: rev_lw
    title: Revenue - Same Point Last Week
    type: single_value
    model: finery_data
    explore: sessions
    measures: [transactions.gross_revenue_ex_discount_ex_vat]
    filters:
      sessions.start_date: 7 days ago for 1 day
      sessions.start_time: before 169 hours ago
    font_size: small
    height: 3
    width: 3
    top: 21
    left: 3

  - name: rev_last_week_tot
    title: TARGET - Revenue Last Week
    type: single_value
    model: finery_data
    explore: sessions
    measures: [transactions.gross_revenue_ex_discount_ex_vat]
    filters:
      sessions.start_date: 7 days ago for 1 day
    font_size: small
    height: 3
    width: 3
    top: 21
    left: 6

  - name: rev_today_vs_lw
    title: Revenue - Today vs Last Week
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_hour_of_day, sessions.start_date]
    pivots: [sessions.start_date]
    measures: [transactions.gross_revenue_ex_discount_ex_vat]
    filters:
      sessions.start_time: before 1 hours ago
      sessions.start_date: 7 days ago, today
    sorts: [sessions.start_hour_of_day, sessions.start_date desc]
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
    top: 24
    left: 0

# BOUNCE RATE

  - name: bounce_rate_today
    title: Bounce Rate - So Far Today
    type: single_value
    model: finery_data
    explore: sessions
    measures: [sessions.bounce_rate]
    filters:
      sessions.start_date: 0 days ago for 1 day
      sessions.start_time: before 0 hours ago
    font_size: small
    height: 3
    width: 3
    top: 30
    left: 0

  - name: bounce_rate_lw
    title: Bounce Rate - Same Point Last Week
    type: single_value
    model: finery_data
    explore: sessions
    measures: [sessions.bounce_rate]
    filters:
      sessions.start_date: 7 days ago for 1 day
      sessions.start_time: before 169 hours ago
    font_size: small
    height: 3
    width: 3
    top: 30
    left: 3

  - name: bounce_rate_last_week_tot
    title: TARGET - Bounce Rate Last Week
    type: single_value
    model: finery_data
    explore: sessions
    measures: [sessions.bounce_rate]
    filters:
      sessions.start_date: 7 days ago for 1 day
    font_size: small
    height: 3
    width: 3
    top: 30
    left: 6

  - name: bounce_rate_today_vs_lw
    title: Bounce Rate - Today vs Last Week
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_hour_of_day, sessions.start_date]
    pivots: [sessions.start_date]
    measures: [sessions.bounce_rate]
    filters:
      sessions.start_time: before 1 hours ago
      sessions.start_date: 7 days ago, today
    sorts: [sessions.start_hour_of_day, sessions.start_date desc]
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
    top: 33
    left: 0


# VISITS

  - name: visits_today
    title: Visits - So Far Today
    type: single_value
    model: finery_data
    explore: sessions
    measures: [sessions.count]
    filters:
      sessions.start_date: 0 days ago for 1 day
      sessions.start_time: before 0 hours ago
    font_size: small
    height: 3
    width: 3
    top: 3
    left: 10

  - name: visits_lw
    title: Visits - Same point Last Week
    type: single_value
    model: finery_data
    explore: sessions
    measures: [sessions.count]
    filters:
      sessions.start_date: 7 days ago for 1 day
      sessions.start_time: before 169 hours ago
    font_size: small
    height: 3
    width: 3
    top: 3
    left: 13

  - name: visits_last_week_tot
    title: TARGET - Visits Last Week
    type: single_value
    model: finery_data
    explore: sessions
    measures: [sessions.count]
    filters:
      sessions.start_date: 7 days ago for 1 day
    font_size: small
    height: 3
    width: 3
    top: 3
    left: 16

  - name: sessions_vs_lw
    title: Visits - Today vs Last Week
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_hour_of_day, sessions.start_date]
    pivots: [sessions.start_date]
    measures: [sessions.count]
    filters:
      sessions.start_time: before 1 hours ago
      sessions.start_date: 7 days ago, today
    sorts: [sessions.start_hour_of_day, sessions.start_date desc]
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
    top: 6
    left: 10

# NEWSLETTER SUBSCRIPTIONS


  - name: nl_sub_today
    title: Newsletter Sub - So Far Today
    type: single_value
    model: finery_data
    explore: sessions
    measures: [sessions.sum_newsletter_signups]
    filters:
      sessions.start_date: 0 days ago for 1 day
      sessions.start_time: before 0 hours ago
    font_size: small
    height: 3
    width: 3
    top: 12
    left: 10

  - name: nl_sub_lw
    title: NL Sub - Same Point Last Week
    type: single_value
    model: finery_data
    explore: sessions
    measures: [sessions.sum_newsletter_signups]
    filters:
      sessions.start_date: 7 days ago for 1 day
      sessions.start_time: before 169 hours ago
    font_size: small
    height: 3
    width: 3
    top: 12
    left: 13

  - name: nl_sub_last_week_tot
    title: TARGET - NL Sub Last Week
    type: single_value
    model: finery_data
    explore: sessions
    measures: [sessions.sum_newsletter_signups]
    filters:
      sessions.start_date: 7 days ago for 1 day
    font_size: small
    height: 3
    width: 3
    top: 12
    left: 16

  - name: nl_sub_vs_lw
    title: Newsletter Subscriptions - Today vs Last Week
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_hour_of_day, sessions.start_date]
    pivots: [sessions.start_date]
    measures: [sessions.sum_newsletter_signups]
    filters:
      sessions.start_time: before 1 hours ago
      sessions.start_date: 7 days ago, today
    sorts: [sessions.start_hour_of_day, sessions.start_date desc]
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
    top: 15
    left: 10

# REFERRALS SUBSCRIPTIONS

  - name: referrals_today
    title: Referrals - So Far Today
    type: single_value
    model: finery_data
    explore: sessions
    measures: [sessions.sum_referrals_sent]
    filters:
      sessions.start_date: 0 days ago for 1 day
      sessions.start_time: before 0 hours ago
    font_size: small
    height: 3
    width: 3
    top: 21
    left: 10

  - name: referrals_lw
    title: Referrals - Same Point Last Week
    type: single_value
    model: finery_data
    explore: sessions
    measures: [sessions.sum_referrals_sent]
    filters:
      sessions.start_date: 7 days ago for 1 day
      sessions.start_time: before 169 hours ago
    font_size: small
    height: 3
    width: 3
    top: 21
    left: 13

  - name: referrals_last_week_tot
    title: TARGET - Referrals Last Week
    type: single_value
    model: finery_data
    explore: sessions
    measures: [sessions.sum_referrals_sent]
    filters:
      sessions.start_date: 7 days ago for 1 day
    font_size: small
    height: 3
    width: 3
    top: 21
    left: 16

  - name: referrals_vs_lw
    title: Referrals - Today vs Last Week
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_hour_of_day, sessions.start_date]
    pivots: [sessions.start_date]
    measures: [sessions.sum_referrals_sent]
    filters:
      sessions.start_time: before 1 hours ago
      sessions.start_date: 7 days ago, today
    sorts: [sessions.start_hour_of_day, sessions.start_date desc]
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
    top: 24
    left: 10



# NEW SESSIONS

  - name: new_sessions_today
    title: New Session % - So Far Today
    type: single_value
    model: finery_data
    explore: sessions
    measures: [sessions.new_visitor_percentage]
    filters:
      sessions.start_date: 0 days ago for 1 day
      sessions.start_time: before 0 hours ago
    font_size: small
    height: 3
    width: 3
    top: 30
    left: 10

  - name: new_sessions_lw
    title: New Session % - Same Point Last Week
    type: single_value
    model: finery_data
    explore: sessions
    measures: [sessions.new_visitor_percentage]
    filters:
      sessions.start_date: 7 days ago for 1 day
      sessions.start_time: before 169 hours ago
    font_size: small
    height: 3
    width: 3
    top: 30
    left: 13

  - name: new_sessions_last_week_tot
    title: TARGET - New Session % Last Week
    type: single_value
    model: finery_data
    explore: sessions
    measures: [sessions.new_visitor_percentage]
    filters:
      sessions.start_date: 7 days ago for 1 day
    font_size: small
    height: 3
    width: 3
    top: 30
    left: 16

  - name: new_sessions_vs_lw
    title: New Session % - Today vs Last Week
    type: looker_line
    model: finery_data
    explore: sessions
    dimensions: [sessions.start_hour_of_day, sessions.start_date]
    pivots: [sessions.start_date]
    measures: [sessions.new_visitor_percentage]
    filters:
      sessions.start_date: 7 days ago, today
      sessions.start_time: before 1 hours ago
    sorts: [sessions.start_hour_of_day, sessions.start_date desc]
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
    top: 33
    left: 10