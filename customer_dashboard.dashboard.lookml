- dashboard: customer_dashboard
  title: Customer Dashboard
  layout: tile
  tile_size: 100

#  filters:

  elements:

  - name: no_of_signups
    title: Number of Signups
    type: single_value
    model: finery_data
    explore: register_success
    measures: [register_success.number_of_signups]
    sorts: [register_success.number_of_signups desc]
    limit: 500
    
  - name: no_of_invites
    title: Number of Invites Sent (Mailchimp)
    type: single_value
    model: finery_data
    explore: mailchimp_invites
    measures: [mailchimp_invites.number_of_invites_sent]
    sorts: [mailchimp_invites.number_of_invites_sent desc]
    limit: 500
    
  - name: no_of_referrals
    title: Number of Referrals Sent (Mandrill)
    type: single_value
    model: finery_data
    explore: mandrill_referrals
    measures: [mandrill_referrals.number_of_invites_sent]
    sorts: [mandrill_referrals.number_of_invites_sent desc]
    limit: 500



