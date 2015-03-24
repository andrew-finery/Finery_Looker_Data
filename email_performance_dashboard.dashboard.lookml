- dashboard: email_performance_dashboard
  title: Email Dashboard - Overview
  layout: tile
  tile_size: 100
  show_applied_filters: true

  filters:

  - name: list_name
    title: "Email List"
    type: field_filter
    explore: mailchimp_campaigns
    field: mailchimp_campaigns.email_list
    default_value: Newsletter Subscribers

  elements:

  - name: total_newsletter_subscribers
    title: Total Newsletter Subscribers
    type: single_value
    model: finery_data
    explore: mailchimp_subscribe
    measures: [mailchimp_subscribe.count_current_emails]
    filters:
      mailchimp_subscribe.email_list: Newsletter Subscribers
    sorts: [mailchimp_subscribe.count_current_emails desc]
    limit: 500
    font_size: medium
    height: 2
    width: 3

  - name: nl_welcome_chain_current
    title: People Currently in Newsletter Welcome Chain
    type: single_value
    model: finery_data
    explore: mailchimp_subscribe
    measures: [mailchimp_subscribe.count_current_emails]
    filters:
      mailchimp_subscribe.email_list: Newsletter Welcome Chain
      mailchimp_subscribe.subscribe_time_time: 8 days ago for 8 days
    sorts: [mailchimp_subscribe.count_current_emails desc]
    limit: 500
    font_size: medium
    height: 2
    width: 3
    
  - name: create_account_welcome_chain_current
    title: People Currently in Create Account Welcome Chain
    type: single_value
    model: finery_data
    explore: mailchimp_subscribe
    measures: [mailchimp_subscribe.count_current_emails]
    filters:
      mailchimp_subscribe.email_list: Create Account Welcome Chain
      mailchimp_subscribe.subscribe_time_time: 8 days ago for 8 days
    sorts: [mailchimp_subscribe.count_current_emails desc]
    limit: 500
    font_size: medium
    height: 2
    width: 3
    
  - name: referral_chain_current
    title: People Currently in Referral Welcome Chain
    type: single_value
    model: finery_data
    explore: mailchimp_subscribe
    measures: [mailchimp_subscribe.count_current_emails]
    filters:
      mailchimp_subscribe.email_list: Referral Welcome Chain
      mailchimp_subscribe.subscribe_time_time: 9 days ago for 9 days
    sorts: [mailchimp_subscribe.count_current_emails desc]
    limit: 500
    font_size: medium
    height: 2
    width: 3
  
  - name: unsub_clean_list
    title: Unsubscription and Email Cleaning Rates by List
    type: table
    model: finery_data
    explore: mailchimp_subscribe
    dimensions: [mailchimp_subscribe.email_list]
    measures: [mailchimp_subscribe.unsubscription_rate, mailchimp_subscribe.cleaned_email_rate]
    filters:
      mailchimp_subscribe.email_list: -Other
    sorts: [mailchimp_subscribe.unsubscription_rate desc]
    limit: 500
    height: 2
    width: 5
    
  - name: unsub_by_campaign
    title: Campaigns with Most Unsubscriptions - Last 30 Days
    type: table
    model: finery_data
    explore: mailchimp_campaigns
    dimensions: [mailchimp_campaigns.email_description, mailchimp_campaigns.email_subject, mailchimp_campaigns.latest_send_time_date]
    measures: [mailchimp_unsubscribe.count_unsubscriptions]
    filters:
      latest_send_time_date: 30 days ago for 31 days
    listen:
      list_name: mailchimp_campaigns.email_list
    sorts: [mailchimp_unsubscribe.count_unsubscriptions desc]
    limit: 5
    height: 4
    width: 5

  - name: add_a_unique_name_669
    title: Untitled Table
    type: table
    model: finery_data
    explore: atomic_events
    dimensions: [atomic_events.email_description, atomic_events.email_campaign, atomic_events.email_list]
    measures: [atomic_events.count_unique_opens, atomic_events.count_total_opens, atomic_events.count_sessions,
      transactions.count_transactions, atomic_events.sum_revenue_ex_coupon_and_vat,
      atomic_events.conversion_rate]
    listen:
      list_name: atomic_events.email_list
    filters:
      atomic_events.event_time_date: 7 days ago for 7 days
    sorts: [atomic_events.count_transactions desc]
    limit: 5
    height: 4
    width: 8




