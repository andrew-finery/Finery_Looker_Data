- dashboard: marketing_overview_dashboard
  title: Marketing Overview Dashboard
  layout: tile
  tile_size: 100

  filters:
  - name: date
    title: "Date Filter"
    type: date_filter
    default_value: "Today"

  elements:

  - name: email_campaigns
    title: Email Campaigns
    type: table
    model: finery_data
    explore: atomic_events
    dimensions: [sessions_source.campaign_name]
    measures: [atomic_events.count_sessions, atomic_events.count_users, atomic_events.count_new_users,
      transactions.count_transactions, atomic_events.sum_revenue_ex_coupon_and_vat]
    listen:
     date: atomic_events.event_time_date
    filters:
      sessions_source.campaign_medium: '"email"'
    sorts: [atomic_events.count_sessions desc]
    limit: 500
    total: false
    
  - name: other_campaigns
    title: Online Marketing Campaigns
    type: table
    model: finery_data
    explore: atomic_events
    dimensions: [sessions_source.campaign_name]
    measures: [atomic_events.count_sessions, atomic_events.count_users, atomic_events.count_new_users,
      transactions.count_transactions, atomic_events.sum_revenue_ex_coupon_and_vat]
    listen:
     date: atomic_events.event_time_date
    filters:
      sessions_source.campaign_medium: -"email"
      sessions_source.campaign_name: -NULL
    sorts: [atomic_events.count_sessions desc]
    limit: 500
    total: false
    
  - name: add_a_unique_name_366
    title: Untitled Table
    type: table
    model: finery_data
    explore: atomic_events
    dimensions: [sessions_source.referer_source]
    measures: [atomic_events.count_sessions, atomic_events.count_users, atomic_events.count_new_users,
      transactions.count_transactions, atomic_events.sum_revenue_ex_coupon_and_vat]
    filters:
      atomic_events.event_time_date: today
      sessions_source.referer_source: -NULL
    sorts: [atomic_events.count_sessions desc]
    limit: 500
    total: false
  
