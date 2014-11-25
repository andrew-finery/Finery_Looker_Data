- dashboard: customer_dashboard
  title: Customer Dashboard
  layout: tile
  tile_size: 100

#  filters:

  elements:

  - name: add_a_unique_name_891
    title: Untitled Table
    type: table
    model: finery_data
    explore: users_signup
    dimensions: [users_signup.source]
    measures: [users_signup.emails_sent, users_signup.sign_ups, users_signup.sign_up_rate]
    sorts: [users_signup.emails_sent desc]
    limit: 500


