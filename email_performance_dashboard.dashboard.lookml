- dashboard: crm_summary
  title: CRM Summary
  layout: tile
  tile_size: 100
  show_applied_filters: true

  elements:

  - name: total_newsletter_subscribers
    title: Total Newsletter Subscribers
    type: single_value
    model: finery_data
    explore: mailchimp_subscribe
    measures: [mailchimp_subscribe.count_current_emails]
    filters:
      mailchimp_subscribe.email_list: Newsletter Subscribers
    font_size: medium
    height: 2
    width: 3
    top: 0
    left: 0
    
  - name: nl_welcome_chain_current
    title: People Currently in Newsletter Welcome Chain
    type: single_value
    model: finery_data
    explore: mailchimp_subscribe
    measures: [mailchimp_subscribe.count_current_emails]
    filters:
      mailchimp_subscribe.email_list: Newsletter Welcome Chain
      mailchimp_subscribe.subscribe_time_time: 8 days ago for 8 days
    font_size: medium
    height: 2
    width: 3
    top: 0
    left: 3

  - name: referral_chain_current
    title: People Currently in Referral Welcome Chain
    type: single_value
    model: finery_data
    explore: mailchimp_subscribe
    measures: [mailchimp_subscribe.count_current_emails]
    filters:
      mailchimp_subscribe.email_list: Referral Welcome Chain
      mailchimp_subscribe.subscribe_time_time: 9 days ago for 9 days
    font_size: medium
    height: 2
    width: 2
    top: 0
    left: 6

  - name: create_account_welcome_chain_current
    title: People Currently in Create Account Welcome Chain
    type: single_value
    model: finery_data
    explore: mailchimp_subscribe
    measures: [mailchimp_subscribe.count_current_emails]
    filters:
      mailchimp_subscribe.email_list: Create Account Welcome Chain
      mailchimp_subscribe.subscribe_time_time: 8 days ago for 8 days
    font_size: medium
    height: 2
    width: 2
    top: 0
    left: 8

  - name: unsub_rates
    title: Unsubscription Rates
    type: looker_column
    model: finery_data
    explore: mailchimp_subscribe
    dimensions: [mailchimp_subscribe.email_list]
    measures: [mailchimp_subscribe.unsubscription_rate]
    filters:
      mailchimp_subscribe.email_list: -Other
    sorts: [mailchimp_subscribe.email_list desc]
    limit: 500
    show_null_points: true
    stacking: ''
    show_value_labels: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    show_null_labels: false
    colors: [red]
    height: 3
    width: 4
    top: 0
    left: 10

  - name: time_ev_nl_subscribers
    title: Time Evolution of Newsletter Subscribers List
    type: looker_area
    model: finery_data
    explore: mailchimp_subscribe
    dimensions: [mailchimp_subscribe.subscribe_time_date]
    measures: [mailchimp_subscribe.list_size_running_total]
    filters:
      mailchimp_subscribe.email_list: Newsletter Subscribers
    sorts: [mailchimp_subscribe.subscribe_time_date asc]
    limit: 500
    show_null_points: true
    x_axis_gridlines: false
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_datetime_label: '%d/%m'
    x_axis_label: Date
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_labels: [Size of List]
    x_axis_scale: auto
    interpolation: monotone
    stacking: ''
    show_value_labels: false
    show_view_names: true
    colors: [green]
    point_style: none
    height: 4
    width: 5
    top: 2
    left: 0

  - name: nl_sub_last_30_days
    title: Newsletter Subscribers by Day - Last 30 Days
    type: looker_line
    model: finery_data
    explore: mailchimp_subscribe
    dimensions: [mailchimp_subscribe.subscribe_time_date]
    measures: [mailchimp_subscribe.count_all_time_subscribers]
    filters:
      mailchimp_subscribe.email_list: Newsletter Subscribers
      mailchimp_subscribe.subscribe_time_date: 30 days ago for 30 days
    sorts: [mailchimp_subscribe.subscribe_time_date desc]
    limit: 500
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_labels: [Subscribers]
    y_axis_combined: true
    show_null_points: true
    interpolation: monotone
    show_value_labels: false
    show_view_names: true
    colors: [green]
    point_style: none
    x_axis_gridlines: false
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    x_axis_datetime_label: '%d/%m'
    x_axis_label: Date
    stacking: ''
    reference_lines:
      - value: mean
        label: "Avg {{mean}}"
    height: 4
    width: 5
    top: 2
    left: 5

  - name: cleaned_rates
    title: Cleaned Email Rates
    type: looker_column
    model: finery_data
    explore: mailchimp_subscribe
    dimensions: [mailchimp_subscribe.email_list]
    measures: [mailchimp_subscribe.cleaned_email_rate]
    filters:
      mailchimp_subscribe.email_list: -Other
    sorts: [mailchimp_subscribe.email_list desc]
    limit: 500
    show_null_points: true
    stacking: ''
    show_value_labels: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    show_null_labels: false
    colors: [orange]
    height: 3
    width: 4
    top: 3
    left: 10

  - name: last_5_newsletters
    title: Latest Newsletter Performance
    type: table
    model: finery_data
    explore: atomic_events
    dimensions: [atomic_events.email_latest_send_date, atomic_events.email_campaign]
    measures: [atomic_events.count_total_opens, atomic_events.count_unique_opens, atomic_events.count_sessions,
      atomic_events.count_users, transactions.count_transactions, atomic_events.sum_revenue_ex_coupon_and_vat,
      atomic_events.conversion_rate]
    filters:
      atomic_events.email_description: '"Weekly Newsletter"'
      atomic_events.email_latest_send_date: 50 days ago for 51 days
      atomic_events.email_list: '"Newsletter Subscribers"'
    sorts: [atomic_events.email_latest_send_date desc]
    limit: 5
    height: 3
    width: 10
    top: 6
    left: 0

  - name: unsub_nl_campaigns
    title: Unsubscriptions from Latest Newsletters
    type: looker_column
    model: finery_data
    explore: mailchimp_campaigns
    dimensions: [mailchimp_campaigns.email_subject, mailchimp_campaigns.latest_send_date]
    measures: [mailchimp_unsubscribe.count_unsubscriptions]
    filters:
      mailchimp_campaigns.email_description: '"Weekly Newsletter"'
      mailchimp_campaigns.latest_send_date: 50 days ago for 51 days
      mailchimp_campaigns.email_list: '"Newsletter Subscribers"'
    sorts: [mailchimp_campaigns.latest_send_date desc]
    limit: 5
    stacking: ''
    show_value_labels: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    show_y_axis_labels: true
    y_axis_labels: [Unsubscriptions]
    show_y_axis_ticks: true
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    show_null_labels: false
    colors: [lightblue]
    height: 3
    width: 4
    top: 6
    left: 10

  - name: newsletter_wc_email_performance
    title: Newsletter Welcome Chain Email Performance - Last 30 Days
    type: table
    model: finery_data
    explore: atomic_events
    dimensions: [atomic_events.email_campaign, atomic_events.email_description]
    measures: [atomic_events.count_total_opens, atomic_events.count_unique_opens, atomic_events.count_sessions,
      atomic_events.count_users, transactions.count_transactions, atomic_events.sum_revenue_ex_coupon_and_vat,
      atomic_events.conversion_rate]
    filters:
      atomic_events.email_description: '"Newsletter Subscription Email","Newsletter WC Reminder 1","Newsletter WC Reminder 2","Newsletter WC Reminder 3"'
      atomic_events.event_time_date: 30 days ago for 30 days
    sorts: [atomic_events.email_description]
    limit: 10
    height: 3
    width: 10
    top: 9
    left: 0

  - name: newsletter_wc_unsubscriptions
    title: Newsletter Welcome Chain Unsubscriptions by Campaign - Last 30 Days
    type: looker_column
    model: finery_data
    explore: mailchimp_campaigns
    dimensions: [mailchimp_campaigns.email_description]
    measures: [mailchimp_unsubscribe.count_unsubscriptions]
    filters:
      mailchimp_campaigns.email_description: '"Newsletter Subscription Email","Newsletter
        WC Reminder 1","Newsletter WC Reminder 2","Newsletter WC Reminder 3"'
      mailchimp_unsubscribe.unsubscribe_time: 30 days ago for 30 days
    sorts: [mailchimp_campaigns.email_description]
    limit: 500
    stacking: ''
    show_value_labels: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_labels: [Unsubscriptions]
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    show_null_labels: false
    colors: [lightblue]
    height: 3
    width: 4
    top: 9
    left: 10

  - name: referral_wc_email_performance
    title: Referral Welcome Chain Email Performance - Last 30 Days
    type: table
    model: finery_data
    explore: atomic_events
    dimensions: [atomic_events.email_campaign, atomic_events.email_description]
    measures: [atomic_events.count_total_opens, atomic_events.count_unique_opens, atomic_events.count_sessions,
      atomic_events.count_users, transactions.count_transactions, atomic_events.sum_revenue_ex_coupon_and_vat,
      atomic_events.conversion_rate]
    filters:
      atomic_events.email_list: '"Referral Welcome Chain"'
      atomic_events.event_time_date: 30 days ago for 30 days
    sorts: [atomic_events.email_description]
    limit: 100
    height: 3
    width: 10
    top: 12
    left: 0

  - name: referral_wc_unsubscriptions
    title: Referral Welcome Chain Unsubscriptions by Campaign - Last 30 Days
    type: looker_column
    model: finery_data
    explore: mailchimp_campaigns
    dimensions: [mailchimp_campaigns.email_description]
    measures: [mailchimp_unsubscribe.count_unsubscriptions]
    filters:
      mailchimp_campaigns.email_list: '"Referral Welcome Chain"'
      mailchimp_unsubscribe.unsubscribe_time: 30 days ago for 30 days
    sorts: [mailchimp_campaigns.email_description]
    limit: 500
    stacking: ''
    show_value_labels: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    show_y_axis_labels: true
    y_axis_labels: [Unsubscriptions]
    show_y_axis_ticks: true
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    show_null_labels: false
    colors: [lightblue]
    height: 3
    width: 4
    top: 12
    left: 10

  - name: create_account_wc_performance
    title: Create Account Welcome CHain Performance - Last 30 Days
    type: table
    model: finery_data
    explore: atomic_events
    dimensions: [atomic_events.email_campaign, atomic_events.email_description]
    measures: [atomic_events.count_total_opens, atomic_events.count_unique_opens, atomic_events.count_sessions,
      atomic_events.count_users, transactions.count_transactions, atomic_events.sum_revenue_ex_coupon_and_vat,
      atomic_events.conversion_rate]
    filters:
      atomic_events.email_list: '"Create Account Welcome Chain"'
      atomic_events.event_time_date: 30 days ago for 30 days
    sorts: [atomic_events.email_description]
    limit: 100
    height: 3
    width: 10
    top: 15
    left: 0

  - name: ca_wc_unsubscriptions
    title: Create Account Welcome Chain Unsubscriptions by Campaign - Last 30 Days
    type: looker_column
    model: finery_data
    explore: mailchimp_campaigns
    dimensions: [mailchimp_campaigns.email_description]
    measures: [mailchimp_unsubscribe.count_unsubscriptions]
    filters:
      mailchimp_campaigns.email_list: '"Create Account Welcome Chain"'
      mailchimp_unsubscribe.unsubscribe_time: 30 days ago for 30 days
    sorts: [mailchimp_campaigns.email_description]
    limit: 500
    stacking: ''
    show_value_labels: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    y_axis_labels: [Unsubscriptions]
    show_view_names: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    show_null_labels: false
    colors: [lightblue]
    height: 3
    width: 4
    top: 15
    left: 10