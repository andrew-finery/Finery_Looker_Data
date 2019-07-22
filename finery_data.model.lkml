connection: "finery-redshift"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

named_value_format: pounds_k {
  value_format: "\£#,##0.0,\" k\""
}

named_value_format: pounds {
  value_format: "\£#,##0"
}

named_value_format: thousands {
  value_format: "#,##0.0,\" k\""
}

explore: sessions {
  symmetric_aggregates: yes

  join: visitors {
    sql_on: ${sessions.blended_user_id} = ${visitors.blended_user_id} ;;
    relationship: many_to_one
  }

  join: newsletter_subscribers {
    from: mc_newsletter_subscribers
    sql_on: lower(${newsletter_subscribers.email_address}) = lower(${visitors.blended_user_id}) ;;
    relationship: many_to_one
  }

  join: customer_info {
    from: spree_customers
    sql_on: lower(${customer_info.email}) = lower(${visitors.email_address}) ;;
    relationship: many_to_one
  }

  join: transactions {
    sql_on: ${transactions.domain_userid} = ${sessions.domain_user_id} and ${transactions.domain_sessionidx} = ${sessions.domain_session_index} ;;
    relationship: one_to_many
  }

  join: session_start_calendar {
    from: calendar_weeks
    sql_on: ${session_start_calendar.calendar_date_date} = ${sessions.start_date} ;;
    relationship: many_to_one
  }

  join: email_campaign_tests {
    from: mc_campaigns_tests
    sql_on: ${email_campaign_tests.test_id} = ${sessions.campaign_name} ;;
    relationship: many_to_one
  }

  join: email_campaigns {
    from: mc_campaigns
    sql_on: ${email_campaigns.campaign_id} = ${email_campaign_tests.campaign_id} ;;
    relationship: many_to_one
  }

  join: coming_soon_emails {
    from: coming_soon_email_summary
    sql_on: ${coming_soon_emails.sku} = ${sessions.campaign_name} and cast(to_char(${coming_soon_emails.email_sent_date}, 'dd/mm/yyyy') as varchar(255)) = ${sessions.campaign_term} ;;
    relationship: many_to_one
  }

  join: affiliate_lookup {
    sql_on: cast(${affiliate_lookup.campaign_id} as varchar(255)) = ${sessions.campaign_name} ;;
    relationship: many_to_one
  }

  join: adwords_campaigns {
    from: adwords_campaigns
    sql_on: ${adwords_campaigns.campaign_id} = ${sessions.campaign_name} ;;
    relationship: many_to_one
  }
}

explore: website_products {
  from: website_product_stats

  join: visits {
    from: sessions
    sql_on: ${website_products.domain_userid} = ${visits.domain_user_id} and ${website_products.domain_sessionidx} = ${visits.domain_session_index} ;;
    relationship: many_to_one
  }

  join: option_info {
    from: product_info_options
    sql_on: ${website_products.id} = ${option_info.product_id} ;;
    relationship: many_to_one
  }

  join: option_info_daily {
    from: product_info_option_daily
    sql_on: ${visits.start_date} = ${option_info_daily.calendar_date_date} ;;
    relationship: many_to_one
  }

  join: coming_soon_emails {
    from: coming_soon_email_summary
    sql_on: ${coming_soon_emails.sku} = ${visits.campaign_name} and cast(to_char(${coming_soon_emails.email_sent_date}, 'dd/mm/yyyy') as varchar(255)) = ${visits.campaign_term} ;;
    relationship: many_to_one
  }
}

explore: snowplow_transaction_attribution {
  join: transactions {
    sql_on: ${snowplow_transaction_attribution.order_id} = ${transactions.order_id} ;;
    relationship: many_to_one
  }

  join: sessions {
    sql_on: ${snowplow_transaction_attribution.user_id} = ${sessions.domain_user_id} and ${snowplow_transaction_attribution.domain_session_index} = ${sessions.domain_session_index} ;;
    relationship: many_to_one
  }

  join: coming_soon_emails {
    from: coming_soon_email_summary
    sql_on: ${coming_soon_emails.sku} = ${sessions.campaign_name} and cast(to_char(${coming_soon_emails.email_sent_date}, 'dd/mm/yyyy') as varchar(255)) = ${sessions.campaign_term} ;;
    relationship: many_to_one
  }
}

explore: facebook_api_ad_performance {}

explore: ometria_email_data {}

explore: facebook_api_ad_performance_breakdown {}

#explore: facebook_carousel_breakdown {}

explore: fb_automated_ads_creatives {
  join: option_info {
    from: product_info_options
    sql_on: ${option_info.product_id} = ${fb_automated_ads_creatives.product_id} ;;
    relationship: many_to_one
  }

  join: facebook_ads_copy {
    type: cross
    relationship: many_to_one
  }
}

explore: fb_automated_ads_creatives_sale {
  join: option_info {
    from: product_info_options
    sql_on: ${option_info.product_id} = ${fb_automated_ads_creatives_sale.product_id} ;;
    relationship: many_to_one
  }

  join: facebook_ads_copy {
    type: cross
    relationship: many_to_one
  }
}

explore: adwords_criteria_performance {}

explore: adwords_search_query_performance {}

explore: spree_customers {
  join: newsletter_subscribers {
    from: mc_newsletter_subscribers
    sql_on: lower(${newsletter_subscribers.email_address}) = lower(${spree_customers.email}) ;;
    relationship: many_to_one
  }

  join: visitors {
    sql_on: lower(${spree_customers.email}) = lower(${visitors.email_address}) ;;
    relationship: one_to_one
  }

  join: spree_users {
    sql_on: lower(${spree_customers.email}) = lower(${spree_users.email_address}) ;;
    relationship: one_to_one
  }
}

explore: transactions {
  label: "Website Orders"

  join: website_visits {
    from: sessions
    sql_on: ${transactions.domain_userid} = ${website_visits.domain_user_id} and ${transactions.domain_sessionidx} = ${website_visits.domain_session_index} ;;
    relationship: many_to_one
  }

  join: website_visitors {
    from: visitors
    sql_on: ${website_visits.blended_user_id} = ${website_visitors.blended_user_id} ;;
    relationship: many_to_one
  }

  join: order_address_info {
    from: spree_addresses
    sql_on: ${transactions.ship_address_id} = ${order_address_info.address_id} ;;
    relationship: many_to_one
  }

  join: customer_info {
    from: spree_customers
    sql_on: ${customer_info.email} = ${transactions.blended_email} ;;
    relationship: many_to_one
  }

  join: coming_soon_emails {
    from: coming_soon_email_summary
    sql_on: ${coming_soon_emails.sku} = ${website_visits.campaign_name} and cast(to_char(${coming_soon_emails.email_sent_date}, 'dd/mm/yyyy') as varchar(255)) = ${website_visits.campaign_term} ;;
    relationship: many_to_one
  }
}

#- explore: atomic_events
#  fields: [ALL_FIELDS]
#  joins:
#  - join: transactions
#    sql_on: transactions.event_id = atomic_events.event_id
#    relationship: one_to_one
#  - join: email_subscriptions
#    sql_on: email_subscriptions.root_id = atomic_events.event_id
#    relationship: one_to_one
#  - join: newsletter_subscriptions
#    sql_on: newsletter_subscriptions.root_id = atomic_events.event_id
#    relationship: one_to_one
#  - join: sessions
#    sql_on: sessions.domain_userid = atomic_events.domain_userid and sessions.domain_sessionidx = atomic_events.domain_sessionidx
#    relationship: many_to_one
#  - join: mailchimp_campaigns_1
#    from: mailchimp_campaigns
#    sql_on: atomic_events.se_label = mailchimp_campaigns_1.email_id
#    relationship: many_to_one
#  - join: mailchimp_campaigns_2
#    from: mailchimp_campaigns
#    sql_on: sessions.mkt_campaign_ga = mailchimp_campaigns_2.email_id
#    relationship: many_to_one
#  - join: spree_products
#    from: spree_products
#    sql_on: ${atomic_events.product_id} = ${spree_products.product_id}
#    relationship: many_to_one
#  - join: snowplow_link_clicks
#    sql_on: ${atomic_events.event_id} = ${snowplow_link_clicks.root_id}
#    relationship: many_to_one
#  - join: event_calendar
#    from: calendar_weeks
#    sql_on: ${event_calendar.calendar_date_date} = ${atomic_events.event_time_date}
#    relationship: many_to_one

explore: spree_users {
  join: newsletter_subscriber_info {
    from: mc_newsletter_subscribers
    sql_on: lower(${newsletter_subscriber_info.email_address}) = lower(${spree_users.email_address}) ;;
    relationship: one_to_one
  }

  join: customer_info {
    from: spree_customers
    sql_on: lower(${spree_users.email_address}) = lower(${customer_info.email}) ;;
    relationship: one_to_one
  }
}

explore: spree_orders {
  always_join: [parcel_tracking]

  join: calendar_weeks {
    sql_on: date(spree_orders.completed_at) = calendar_weeks.calendar_date ;;
    relationship: many_to_one
  }

  join: spree_users {
    sql_on: spree_orders.customer_id = spree_users.user_id ;;
    relationship: many_to_one
  }

  join: spree_addresses {
    sql_on: spree_orders.ship_address_id = spree_addresses.address_id ;;
    relationship: many_to_one
  }

  join: spree_customers {
    sql_on: spree_customers.email = spree_orders.blended_email ;;
    relationship: many_to_one
  }

  join: visitors {
    sql_on: ${spree_customers.email} = ${visitors.email_address} ;;
    relationship: many_to_one
  }

  join: parcel_lifetime_events {
    sql_on: spree_orders.shipment_number = parcel_lifetime_events.senders_reference and spree_orders.tracking_number = parcel_lifetime_events.item_code ;;
    relationship: many_to_one
  }

  join: parcel_tracking {
    sql_on: spree_orders.shipment_number = parcel_tracking.senders_reference and spree_orders.tracking_number = parcel_tracking.item_code ;;
    relationship: one_to_one
  }
}

explore: spree_order_items {
  fields: [ALL_FIELDS*, -option_info.option_for_returns_report]
  always_join: [spree_orders]

  join: spree_orders {
    sql_on: spree_orders.order_id = spree_order_items.order_id ;;
    relationship: many_to_one
  }

  join: spree_customers {
    sql_on: spree_customers.email = spree_orders.blended_email ;;
    relationship: many_to_one
  }

  join: visitors {
    sql_on: ${spree_customers.email} = ${visitors.email_address} ;;
    relationship: many_to_one
  }

  join: spree_users {
    sql_on: spree_orders.customer_id = spree_users.user_id ;;
    relationship: many_to_one
  }

  join: spree_addresses {
    sql_on: spree_orders.ship_address_id = spree_addresses.address_id ;;
    relationship: many_to_one
  }

  join: calendar_weeks {
    sql_on: date(spree_order_items.order_tstamp) = calendar_weeks.calendar_date ;;
    relationship: many_to_one
  }

  join: variant_info {
    from: product_info_variants
    sql_on: ${spree_order_items.sku} = ${variant_info.ean} ;;
    relationship: many_to_one
  }

  join: option_info {
    from: product_info_options
    #sql_on: ${variant_info.option_id} = ${option_info.option_id} ;;
    relationship: many_to_one
    sql: RIGHT JOIN product_info_options AS option_info ON ${variant_info.option_id} = option_info.option_id ;;
  }
}

explore: daily_sales {
  always_join: [variant_info, option_info, option_info_daily]
  fields: [ALL_FIELDS*, -option_info.option_for_returns_report]

  join: calendar_weeks {
    sql_on: ${daily_sales.calendar_date_date} = ${calendar_weeks.calendar_date_date} ;;
    relationship: many_to_one
  }

  join: variant_info {
    from: product_info_variants
    sql_on: ${daily_sales.sku} = ${variant_info.ean} ;;
    relationship: many_to_one
  }

  join: option_info {
    from: product_info_options
    sql_on: ${option_info.option_id} = ${variant_info.option_id} ;;
    relationship: many_to_one
  }

  join: option_info_daily {
    from: product_info_option_daily
    sql_on: ${daily_sales.calendar_date_date} = ${option_info_daily.calendar_date_date} and ${variant_info.option_id} = ${option_info_daily.option_id} ;;
    relationship: many_to_one
  }

  join: facebook_ads_copy {
    type: cross
    relationship: many_to_one
  }
}

explore: mandrill_email_summary {}

explore: spree_refunds {
  join: spree_orders {
    sql_on: ${spree_orders.order_id} = ${spree_refunds.order_id} ;;
    relationship: many_to_one
  }

  join: spree_addresses {
    sql_on: ${spree_orders.ship_address_id} = ${spree_addresses.address_id} ;;
    relationship: many_to_one
  }
}

explore: goods_in {
  fields: [ALL_FIELDS*, -option_info.option_for_returns_report]

  join: calendar_weeks {
    sql_on: goods_in.confirm_date = calendar_weeks.calendar_date ;;
    relationship: many_to_one
  }

  join: variant_info {
    from: product_info_variants
    sql_on: ${goods_in.ean} = ${variant_info.ean} ;;
    relationship: many_to_one
  }

  join: option_info {
    from: product_info_options
    sql_on: ${variant_info.option_id} = ${option_info.option_id} ;;
    relationship: many_to_one
  }
}

explore: snowplow_product_click_through_daily {
  join: option_info_daily {
    from: product_info_option_daily
    sql_on: ${snowplow_product_click_through_daily.product_id} = ${option_info_daily.product_id} and ${snowplow_product_click_through_daily.impression_date_date} = ${option_info_daily.calendar_date_date} ;;
    relationship: one_to_one
  }

  join: option_info {
    from: product_info_options
    sql_on: ${option_info.product_id} = ${snowplow_product_click_through_daily.product_id} ;;
    relationship: many_to_one
  }
}

explore: product_info_option_daily {
  label: "Daily Option Stats"

  join: option_info {
    from: product_info_options
    sql_on: ${option_info.option_id} = ${product_info_option_daily.option_id} ;;
    relationship: many_to_one
  }

  join: calendar_weeks {
    sql_on: ${product_info_option_daily.calendar_date_date} = ${calendar_weeks.calendar_date_date} ;;
    relationship: many_to_one
  }

#  join: variant_info {
  #  from: product_info_variants
   # sql_on: ${product_info_option_daily.option_id} = ${variant_info.option_id} ;;
  #  relationship: many_to_one
 # }
}

explore: visitors {
  join: customers {
    from: spree_customers
    sql_on: ${customers.email} = ${visitors.email_address} ;;
    relationship: one_to_one
  }
}

#explore: spree_cms_product_information {}

explore: website_page_views {
  join: visits {
    from: sessions
    sql_on: ${website_page_views.domain_userid} = ${visits.domain_user_id} and ${website_page_views.domain_sessionidx} = ${visits.domain_session_index} ;;
    relationship: many_to_one
  }

  join: coming_soon_emails {
    from: coming_soon_email_summary
    sql_on: ${coming_soon_emails.sku} = ${visits.campaign_name} and cast(to_char(${coming_soon_emails.email_sent_date}, 'dd/mm/yyyy') as varchar(255)) = ${visits.campaign_term} ;;
    relationship: many_to_one
  }
}

explore: mc_newsletter_subscribers {
  label: "Mailchimp Newsletter Subscribers"
  description: "Finery newsletter subscriber information"

  join: customer_info {
    from: spree_customers
    sql_on: lower(${mc_newsletter_subscribers.email_address}) = lower(${customer_info.email}) ;;
    relationship: one_to_one
  }

  join: web_visitor_info {
    from: visitors
    sql_on: lower(${mc_newsletter_subscribers.email_address}) = lower(${web_visitor_info.email_address}) ;;
    relationship: one_to_one
  }

  join: spree_users {
    sql_on: lower(${mc_newsletter_subscribers.email_address}) = lower(${spree_users.email_address}) ;;
    relationship: one_to_one
  }
}

explore: mc_referrals {
  label: "Mailchimp Referrals"
  description: "Customer referral scheme info"

  join: customer_info {
    from: spree_customers
    sql_on: lower(${mc_referrals.email_address}) = lower(${customer_info.email}) ;;
    relationship: one_to_one
  }

  join: web_visitor_info {
    from: visitors
    sql_on: lower(${mc_referrals.email_address}) = lower(${web_visitor_info.email_address}) ;;
    relationship: one_to_one
  }

  join: newsletter_subscribers {
    from: mc_newsletter_subscribers
    sql_on: lower(${mc_referrals.email_address}) = lower(${newsletter_subscribers.email_address}) ;;
    relationship: one_to_one
  }
}

explore: mc_campaign_member_activity {
  label: "Mailchimp Newsletter Subscriber Activity"
  description: "Finery newsletter subscriber activity"

  join: newsletter_subscribers {
    from: mc_newsletter_subscribers
    type: inner
    sql_on: lower(${newsletter_subscribers.email_address}) = lower(${mc_campaign_member_activity.email_address}) ;;
    relationship: many_to_one
  }

  join: email_campaign_tests {
    from: mc_campaigns_tests
    sql_on: ${email_campaign_tests.test_id} = ${mc_campaign_member_activity.campaign_id} ;;
    relationship: many_to_one
  }

  join: email_campaigns {
    from: mc_campaigns
    sql_on: ${email_campaign_tests.campaign_id} = ${email_campaigns.campaign_id} ;;
    relationship: many_to_one
  }

  join: customer_info {
    from: spree_customers
    sql_on: lower(${customer_info.email}) = lower(${mc_campaign_member_activity.email_address}) ;;
    relationship: many_to_one
  }
}

explore: mc_campaigns {
  label: "Mailchimp Campaigns"
  description: "Finery Mailchimp account campaign information"
}

explore: coming_soon_email_lists {
  label: "Coming Soon Email Lists"
  description: "Details of all people on coming soon lists who have not yet been notified"

  join: option_info {
    from: product_info_options
    sql_on: ${option_info.product_id} = ${coming_soon_email_lists.product_id} ;;
    relationship: many_to_one
  }
}

explore: webgains_orders {
  label: "Webgains Orders"
  description: "Information on all orders tracked by Webgains"

  join: affiliate_lookup {
    sql_on: cast(${affiliate_lookup.campaign_id} as varchar(255)) = ${webgains_orders.campaign_id} ;;
    relationship: many_to_one
  }
}

explore: spree_stripped_out_orders {
  label: "Non-Reported Orders"
  description: "Information on all orders that are not reported on for revenue purposes"

  join: calendar_weeks {
    sql_on: ${spree_stripped_out_orders.completed_date} = calendar_weeks.calendar_date ;;
    relationship: many_to_one
  }
}

explore: spree_stripped_out_order_items {
  fields: [ALL_FIELDS*, -option_info.option_for_returns_report]
  label: "Non-Reported Order Items"
  description: "Information on all items in orders that are not reported on for revenue purposes"
  always_join: [spree_stripped_out_orders]

  join: spree_stripped_out_orders {
    sql_on: ${spree_stripped_out_orders.order_id} = ${spree_stripped_out_order_items.order_id} ;;
    relationship: many_to_one
  }

  join: spree_addresses {
    sql_on: spree_stripped_out_orders.ship_address_id = spree_addresses.address_id ;;
    relationship: many_to_one
  }

  join: calendar_weeks {
    sql_on: ${spree_stripped_out_orders.completed_date} = calendar_weeks.calendar_date ;;
    relationship: many_to_one
  }

  join: variant_info {
    from: product_info_variants
    sql_on: ${spree_stripped_out_order_items.sku} = ${variant_info.ean} ;;
    relationship: many_to_one
  }

  join: option_info {
    from: product_info_options
    sql_on: ${variant_info.option_id} = ${option_info.option_id} ;;
    relationship: many_to_one
  }
}

explore: scripts_bi_server {}

explore: redshift_load_errors {}

explore: redshift_snowplow_loads {}

#explore: warehouse_consumables_yesterday {}

#explore: warehouse_stock_yesterday {}

#explore: cml_orders {}

#explore: parcel_tracking {}

explore: website_promo_block_click_through_daily {
  label: "Promo Block Click-Through"
  description: "Promo block click-through information by day"

  join: spree_promo_block_info {
    sql_on: ${website_promo_block_click_through_daily.promo_block_id} = ${spree_promo_block_info.promo_block_id} ;;
    relationship: many_to_one
  }
}

explore: website_leads {
  join: website_visitors {
    from: visitors
    sql_on: lower(${website_leads.email_address}) = lower(${website_visitors.blended_user_id}) ;;
    relationship: one_to_one
  }

  join: customer_info {
    from: spree_customers
    sql_on: lower(${customer_info.email}) = lower(${website_leads.email_address}) ;;
    relationship: one_to_one
  }

  join: newsletter_subscriber_info {
    from: mc_newsletter_subscribers
    sql_on: lower(${newsletter_subscriber_info.email_address}) = lower(${website_leads.email_address}) ;;
    relationship: many_to_one
  }
}

explore: website_performance_checks {}


explore: rakuten_orders {}


explore: affiliate_daily_spend {}

explore: redshift_table_checks {}

explore: daily_kpis {}

explore: daily_chapters_stats {}

explore: item_inventory_by_location {}

explore: missed_revenues {
  join: variant_info {
    from: product_info_variants
    sql_on: ${missed_revenues.ean} = ${variant_info.ean} ;;
    relationship: many_to_one
  }

  join: option_info {
    from: product_info_options
    sql_on: ${option_info.option_id} = ${variant_info.option_id} ;;
    relationship: many_to_one
  }
}

explore: john_lewis_sor {
  always_join: [variant_info, option_info, option_info_daily]
  fields: [ALL_FIELDS*, -option_info.option_for_returns_report]

  join: calendar_weeks {
    sql_on: ${john_lewis_sor.calendar_date} = ${calendar_weeks.calendar_date_date} ;;
    relationship: many_to_one
  }

  join: variant_info {
    from: product_info_variants
    sql_on: ${john_lewis_sor.ean} = ${variant_info.ean} ;;
    relationship: many_to_one
  }

  join: option_info {
    from: product_info_options
    sql_on: ${option_info.option_id} = ${variant_info.option_id} ;;
    relationship: many_to_one
  }

  join: option_info_daily {
    from: product_info_option_daily
    sql_on: ${john_lewis_sor.calendar_date} = ${option_info_daily.calendar_date_date} and ${variant_info.option_id} = ${option_info_daily.option_id} ;;
    relationship: many_to_one
  }

}

explore: john_lewis_replenishment_model {
  always_join: [variant_info, option_info]
  fields: [ALL_FIELDS*, -option_info.option_for_returns_report]

  join: variant_info {
    from: product_info_variants
    sql_on: ${john_lewis_replenishment_model.ean} = ${variant_info.ean} ;;
    relationship: many_to_one
  }

  join: option_info {
    from: product_info_options
    sql_on: ${option_info.option_id} = ${variant_info.option_id} ;;
    relationship: many_to_one
  }
}
