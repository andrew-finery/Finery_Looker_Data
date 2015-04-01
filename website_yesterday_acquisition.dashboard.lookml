- dashboard: website_yesterday_acquisition
  title: Web Dashbaord - Yesterday - Acquisition
  layout: static
  tile_size: 100
  show_applied_filters: true

  filters:
  
  - name: select_channel
    title: "Channel"
    type: field_filter
    explore: atomic_events
    field: sessions.acquisition_channel
    default_value: Email

  elements:

  - name: summary_by_channel
    title: Summary by Acquisition Channel - Yesterday
    type: table
    model: finery_data
    explore: atomic_events
    dimensions: [sessions.acquisition_channel]
    measures: [atomic_events.engagement_rate_yesterday, atomic_events.engagement_rate_last_week, atomic_events.engagement_rate_wow, atomic_events.conversion_rate_yesterday, atomic_events.conversion_rate_last_week, atomic_events.conversion_rate_wow, atomic_events.count_sessions_yesterday, atomic_events.count_sessions_last_week, atomic_events.sessions_wow, atomic_event.new_session_perc_yesterday, atomic_events.new_session_perc_last_week, new_session_perc_yesterday.new_session_perc_wow, transactions.count_transactions_yesterday, transactions.count_transactions_last_week, atomic_events.orders_wow, atomic_events.new_customer_perc_yesterday, atomic_events.new_customer_perc_last_week, atomic_events.new_customer_perc_wow, atomic_events.sum_revenue_yesterday, atomic_events.sum_revenue_last_week, atomic_events.revenue_wow, atomic_events.bounce_rate_yesterday, atomic_events.bounce_rate_last_week, atomic_events.bounce_rate_wow]
    sorts: [atomic_events.count_sessions_yesterday desc]
    filters:
      atomic_events.event_time_date: 8 days ago for 8 days
    total: true
    height: 5
    width: 20
    top: 0
    left: 0

  - name: summary_by_channel
    title: Selected Acquisition Channel - Summary by Campaign
    type: table
    model: finery_data
    explore: atomic_events
    dimensions: [atomic_events.campaign]
    measures: [atomic_events.engagement_rate_yesterday, atomic_events.engagement_rate_last_week, atomic_events.engagement_rate_wow, atomic_events.conversion_rate_yesterday, atomic_events.conversion_rate_last_week, atomic_events.conversion_rate_wow, atomic_events.count_sessions_yesterday, atomic_events.count_sessions_last_week, atomic_events.sessions_wow, atomic_event.new_session_perc_yesterday, atomic_events.new_session_perc_last_week, new_session_perc_yesterday.new_session_perc_wow, transactions.count_transactions_yesterday, transactions.count_transactions_last_week, atomic_events.orders_wow, atomic_events.new_customer_perc_yesterday, atomic_events.new_customer_perc_last_week, atomic_events.new_customer_perc_wow, atomic_events.sum_revenue_yesterday, atomic_events.sum_revenue_last_week, atomic_events.revenue_wow, atomic_events.bounce_rate_yesterday, atomic_events.bounce_rate_last_week, atomic_events.bounce_rate_wow]
    sorts: [atomic_events.count_sessions_yesterday desc]
    filters:
      atomic_events.event_time_date: 8 days ago for 8 days
    listen:
      select_channel: sessions.acquisition_channel
    total: true
    height: 8
    width: 20
    top: 5
    left: 0


