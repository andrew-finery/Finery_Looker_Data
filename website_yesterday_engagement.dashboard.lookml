- dashboard: website_yesterday_engagement
  title: Website Engagement Dashboard - Yesterday
  layout: static
  tile_size: 50

  elements:

  - name: payment_funnel_yesterday
    title: Depth of Engagement - Yesterday
    type: looker_column
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.perc_all_sessions, atomic_events.perc_sessions_catalog,
      atomic_events.perc_sessions_product, atomic_events.perc_sessions_cart, atomic_events.perc_sessions_checkout_1,
      atomic_events.perc_sessions_transaction]
    filters:
      atomic_events.event_time_date: yesterday
    sorts: [atomic_events.perc_all_sessions desc]
    series_labels:
      atomic_events.perc_all_sessions: All Sessions
      atomic_events.perc_sessions_catalog: Catalogue Page
      atomic_events.perc_sessions_product: Product Page
      atomic_events.perc_sessions_cart: Add to Cart
      atomic_events.perc_sessions_checkout_1: Start Checkout
      atomic_events.perc_sessions_transaction: Order
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_gridlines: true
    y_axis_combined: true
    show_dropoff: true
    show_value_labels: false
    show_view_names: true
    show_null_labels: false
    stacking: ''
    x_axis_gridlines: false
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    height: 9
    width: 12
    top: 0
    left: 0
    
  - name: dropout_rates_yesterday
    title: Dropout Rates Yesterday
    type: looker_column
    model: finery_data
    explore: atomic_events
    measures: [atomic_events.dropout_rate_visitor, atomic_events.dropout_rate_catalogue,
      atomic_events.dropout_rate_product, atomic_events.dropout_rate_cart, atomic_events.dropout_rate_checkout]
    filters:
      atomic_events.event_time_date: yesterday
    sorts: [atomic_events.dropout_rate_visitor desc]
    series_labels:
      atomic_events.dropout_rate_visitor: Visitor
      atomic_events.dropout_rate_catalogue: Cataglogue
      atomic_events.dropout_rate_product: Product Page
      atomic_events.dropout_rate_cart: Cart
      atomic_events.dropout_rate_checkout: Checkout
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_combined: true
    stacking: ''
    show_value_labels: false
    x_axis_gridlines: false
    show_view_names: true
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    show_null_labels: false
    height: 9
    width: 12
    top: 0
    left: 12

  - name: payment_funnel_yesterday_vs_lw
    title: Depth of Engagement - Yesterday vs Last Week
    type: table
    model: finery_data
    explore: atomic_events
    dimensions: [atomic_events.yesterday_tw_lw_flag]
    measures: [atomic_events.perc_all_sessions, atomic_events.perc_sessions_catalog,
      atomic_events.perc_sessions_product, atomic_events.perc_sessions_cart, atomic_events.perc_sessions_checkout_1,
      atomic_events.perc_sessions_transaction]
    filters:
      atomic_events.yesterday_tw_lw_flag: -NULL
    sorts: [atomic_events.yesterday_tw_lw_flag desc]
    height: 4
    width: 12
    top: 9
    left: 0
  
  - name: dropout_rates_yesterday_vs_lw
    title: Dropout Rates - Yesterday vs Last Week
    type: table
    model: finery_data
    explore: atomic_events
    dimensions: [atomic_events.yesterday_tw_lw_flag]
    measures: [atomic_events.dropout_rate_visitor, atomic_events.dropout_rate_catalogue,
      atomic_events.dropout_rate_product, atomic_events.dropout_rate_cart, atomic_events.dropout_rate_checkout]
    filters:
      atomic_events.yesterday_tw_lw_flag: -NULL
    sorts: [atomic_events.yesterday_tw_lw_flag desc]
    height: 4
    width: 12
    top: 9
    left: 12

