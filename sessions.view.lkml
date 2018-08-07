view: sessions {
  sql_table_name: web.sessions ;;
  #######################################################################################################################################################################
  ################################################################ DIMENSIONS ###########################################################################################
  #######################################################################################################################################################################

  # Basic dimensions #

  dimension: domain_user_id {
    sql: ${TABLE}.domain_userid ;;
  }

  dimension: domain_session_index {
    sql: ${TABLE}.domain_sessionidx ;;
  }

  dimension: blended_user_id {
    sql: ${TABLE}.blended_user_id ;;
    hidden: yes
  }

  dimension: session_index {
    label: "Visit Number"
    type: number
    sql: ${TABLE}.session_index ;;
  }

  dimension: session_id {
    sql: ${TABLE}.domain_userid || '-' || ${TABLE}.domain_sessionidx ;;
    hidden: yes
    primary_key: yes
  }

  dimension: session_index_tier {
    label: "Visit Number Tier"
    type: tier
    tiers: [
      1,
      2,
      3,
      4,
      5,
      10,
      25,
      100,
      1000
    ]
    sql: ${session_index} ;;
  }

  dimension_group: start {
    label: "Visit Start"
    type: time
    timeframes: [
      time,
      hour,
      date,
      hour_of_day,
      day_of_week,
      week,
      week_of_year,
      month,
      year
    ]
    sql: ${TABLE}.session_start_ts ;;
  }

  dimension: start {
    sql: ${TABLE}.session_start_ts ;;
    hidden: yes
  }

  dimension: end {
    sql: ${TABLE}.session_end_ts ;;
    hidden: yes
  }

  dimension: session_duration_seconds {
    label: "Session Duration Seconds"
    sql: extract(epoch from ${end}) - extract(epoch from ${start}) ;;
  }

  # Events per visit and bounces (infered) #

  dimension: events_during_session {
    type: number
    sql: ${TABLE}.number_of_events ;;
    hidden: yes
  }

  dimension: events_during_session_tiered {
    type: tier
    tiers: [
      1,
      2,
      5,
      10,
      25,
      50,
      100,
      1000,
      10000
    ]
    sql: ${TABLE}.number_of_events ;;
    hidden: yes
  }

  dimension: log_in_flag {
    label: "Login Flag"
    type: yesno
    sql: ${TABLE}.user_id is not null ;;
  }

  dimension: bounce {
    label: "Bounce"
    type: yesno
    sql: ${TABLE}.interaction_events < 2 and ${TABLE}.distinct_pages_viewed = 1 ;;
  }

  dimension: accounts_created {
    type: number
    sql: ${TABLE}.accounts_created ;;
    hidden: yes
  }

  dimension: newsletter_signups {
    type: number
    sql: ${TABLE}.newsletter_signups ;;
    hidden: yes
  }

  dimension: products_added_to_cart {
    type: number
    sql: ${TABLE}.products_added_to_cart ;;
    hidden: yes
  }

  dimension: add_to_cart {
    label: "Added To Cart (Y/N)"
    type: yesno
    sql:${cart_page_view_flag} = 1
      OR ${checkout_reg_page_view_flag} = 1
      OR ${cart_events} > 0
      OR ${products_added_to_cart} > 0
      OR ${orders} > 0
      OR ${checkout_progress} > 0
      ;;
  }

  dimension: product_removed_from_cart {
    type: number
    sql: ${TABLE}.product_removed_from_cart ;;
    hidden: yes
  }

  dimension: cart_events {
    type: number
    sql: ${TABLE}.cart_events ;;
    hidden: yes
  }

  dimension: referrals_sent {
    type: number
    sql: ${TABLE}.referrals_sent ;;
    hidden: yes
  }

  dimension: checkout_progress {
    type: number
    sql: ${TABLE}.checkout_progress ;;
    hidden: yes
  }

  dimension: product_impressions {
    type: number
    sql: ${TABLE}.category_impressions ;;
    hidden: yes
  }

  dimension: is_existing_customer {
    type: yesno
    sql: ${TABLE}.customer_at_start_of_visit_flag = 1 ;;
  }

  dimension: product_views {
    type: number
    sql: ${TABLE}.product_views ;;
  }

  dimension: product_views_tier {
    type: tier
    tiers: [
      0,
      1,
      2,
      3,
      4,
      5
    ]
    style: integer
    sql: case when ${product_views} is null then 0 else ${product_views} end ;;
  }

  dimension: products_purchased {
    type: number
    sql: ${TABLE}.products_purchased ;;
    hidden: yes
  }

  dimension: orders {
    type: number
    sql: ${TABLE}.orders ;;
  }

  dimension: gross_revenue_ex_discount {
    type: number
    value_format_name: decimal_2
    sql: ${TABLE}.gross_revenue_ex_discount ;;
  }

  dimension: gross_revenue_ex_discount_ex_vat {
    type: number
    value_format_name: decimal_2
    sql: ${TABLE}.gross_revenue_ex_discount_ex_vat ;;
  }

  dimension: shipping_revenue {
    type: number
    value_format_name: decimal_2
    sql: ${TABLE}.shipping_revenue ;;
  }

  dimension: engaged_session {
    label: "Engaged Visit"
    type: yesno
    sql: ${distinct_pages_viewed} > 6
      or ${accounts_created} > 0
      or ${newsletter_signups} > 0
      or ${products_added_to_cart} > 0
      or ${cart_events} > 0
      or ${checkout_progress} > 0
      or ${orders} > 0
      or ${session_duration_seconds} > 239
       ;;
  }

  dimension: engagement_goal_1 {
    label: "Engagement Goal 1 (>6 Pages)"
    type: yesno
    sql: ${distinct_pages_viewed} > 6 ;;
  }

  dimension: engagement_goal_2 {
    label: "Engagement Goal 2 (Create Account)"
    type: yesno
    sql: ${accounts_created} > 0 ;;
  }

  dimension: engagement_goal_3 {
    label: "Engagement Goal 3 (NL Signup)"
    type: yesno
    sql: ${newsletter_signups} > 0 ;;
  }

  dimension: engagement_goal_4 {
    label: "Engagement Goal 4 (>4 mins)"
    type: yesno
    sql: ${session_duration_seconds} > 239 ;;
  }

  dimension: engagement_goal_5 {
    label: "Engagement Goal 5 (Add to Cart)"
    type: yesno
    sql: ${cart_events} > 0
      or ${checkout_progress} > 0
      or ${orders} > 0
       ;;
  }

  # New vs returning visitor #
  dimension: new_vs_returning_visitor {
    label: "New vs Returning Visitor"

    case: {
      when: {
        sql: ${session_index} = 1 ;;
        label: "new"
      }

      when: {
        sql: ${session_index} > 1 ;;
        label: "returning"
      }

      else: "unknown"
    }
  }

  dimension: referral_sent_flag {
    type: yesno
    sql: ${referrals_sent} > 0 ;;
  }

  # Pages visited #
  dimension: distinct_pages_viewed {
    sql: ${TABLE}.distinct_pages_viewed ;;
    hidden: yes
  }

  dimension: distinct_pages_viewed_tiered {
    type: tier
    tiers: [
      1,
      2,
      3,
      4,
      5,
      10,
      25,
      100,
      1000
    ]
    sql: ${TABLE}.distinct_pages_viewed ;;
    hidden: yes
  }

  dimension: event_stream {
    sql: ${session_id} ;;
    hidden: yes
  }

  # Geo fields #
  dimension: geography_country_two_letter_iso_code {
    label: "Geo - Country Code"
    sql: ${TABLE}.geo_country_code_2_characters ;;
  }

  dimension: geography_country_uk_flag {
    sql: case when ${TABLE}.geo_country_code_2_characters = 'GB' then 'UK' else 'Non-UK' end ;;
  }

  dimension: geography_country {
    label: "Geo - Country"

    case: {
      when: {
        sql: ${geography_country_two_letter_iso_code} = 'GB' ;;
        label: "UK"
      }

      when: {
        sql: ${geography_country_two_letter_iso_code} = 'US' ;;
        label: "USA"
      }

      when: {
        sql: ${geography_country_two_letter_iso_code} = 'AU' ;;
        label: "Australia"
      }

      when: {
        sql: ${geography_country_two_letter_iso_code} = 'HK' ;;
        label: "Hong Kong"
      }

      when: {
        sql: ${geography_country_two_letter_iso_code} = 'IE' ;;
        label: "Ireland"
      }

      when: {
        sql: ${geography_country_two_letter_iso_code} = 'SG' ;;
        label: "Singapore"
      }

      when: {
        sql: ${geography_country_two_letter_iso_code} = 'AE' ;;
        label: "UAE"
      }

      when: {
        sql: ${geography_country_two_letter_iso_code} = 'CA' ;;
        label: "Canada"
      }

      when: {
        sql: ${geography_country_two_letter_iso_code} = 'CN' ;;
        label: "China"
      }

      else: "Other"
    }
  }

  dimension: geography_region {
    label: "Geo - Region"
    sql: ${TABLE}.geo_region ;;
  }

  dimension: geography_city {
    label: "Geo - City"
    sql: ${TABLE}.geo_city ;;
  }

  dimension: geography_zipcode {
    sql: ${TABLE}.geo_zipcode ;;
    hidden: yes
  }

  dimension: geography_latitude {
    sql: ${TABLE}.geo_latitude ;;
    hidden: yes
  }

  dimension: geography_longitude {
    sql: ${TABLE}.geo_longitude ;;
    hidden: yes
  }

  # Landing page

  dimension: landing_page_host {
    sql: ${TABLE}.landing_page_host ;;
    hidden: yes
  }

  dimension: landing_page_path {
    label: "Landing Page Path"
    sql: ${TABLE}.landing_page_path ;;
  }

  dimension: landing_page_query {
    label: "Landing Page Query"
    sql: ${TABLE}.landing_page_query ;;
  }

  dimension: landing_page {
    label: "Landing Page Full"
    sql: ${TABLE}.landing_page_host || ${TABLE}.landing_page_path ;;
    hidden: yes
  }

  dimension: landing_page_type {
    sql: case
       when ${landing_page_path} in ('/', '//', '/uk', '/uk/', '/us', '/us/', '/ie', '/ie/', '/ca', '/ca/', '/hk', '/hk/', '/ae', '/ae/','/sg', '/sg/','/au', '/au/') or ${landing_page_path} is null then 'Homepage'
       when ${landing_page_path} like '%/products/%' then 'Product Page'
       when ${landing_page_path} like '%/t/%' then 'Category Page'
       else 'Other' end
       ;;
  }

  # Exit page

  dimension: exit_page_host {
    sql: ${TABLE}.exit_page_host ;;
    hidden: yes
  }

  dimension: exit_page_path {
    label: "Exit Page Path"
    sql: ${TABLE}.exit_page_path ;;
  }

  dimension: exit_page {
    label: "Exit Page Full"
    sql: ${TABLE}.exit_page_host || ${TABLE}.exit_page_path ;;
    hidden: yes
  }

  ################################ MARKETING #################################################################################################

  dimension: acquisition_channel {
    label: "Acquisition Channel"
    sql: ${TABLE}.acquisition_channel ;;
  }

  dimension: crm_sub_channel {
    sql: case
      when ${acquisition_channel} <> 'CRM' then null

      when ${campaign_source} = 'ometria'
           or  ${TABLE}.email_folder_name = 'Newsletters'
           or (${TABLE}.email_test_id is not null and ${TABLE}.email_folder_name is null)
           or ${campaign_name} in ('Introducing spring\'s need-to-know neutral', 'Meet the new arrivals', 'Open now! Visit us at the Finery Fitting Room', 'Next level layers')
           then 'Newsletters'

      when ${campaign_name} in ('om_57f680befde1_Abandoned_basket', 'om_3092a235a0bc_Abandoned_Basket_Black_Friday', 'om_49921c675983_Abandoned_Basket_Sale_7_days')
           or ${campaign_name} = 'abandon_cart'
           then 'Abandon Cart'

      when ${TABLE}.email_folder_name in ('Feb 2016 CRM', 'May 2016 CRM', 'August 2016 CRM', 'September Acquisition Emails', 'October Batch 2 Acquisition', '  October Batch 1 Acquisition', 'October Retention Emails', 'October Batch 1 Acquisition')
           or ${campaign_name} like 'om_%'
           then 'Lifecycle Marketing'

      when ${campaign_name} in ('Nice to meet you', 'Don’t forget your discount is waiting', 'Use it, don’t lose it', 'You’re so in the know', 'Donâ€™t forget your discount is waiting', 'Use it, donâ€™t lose it', 'Youâ€™re so in the know')
           or ${TABLE}.email_folder_name = 'Welcome Chain'
           then 'Welcome Chain'

      when ${coming_soon_emails.option_name} is not null
           or ${TABLE}.email_folder_name = 'Coming Soon Emails'
           then 'Coming Soon Emails'

      when ${TABLE}.mkt_medium_ga = 'transactional' then 'Transactional'

      else 'Other'
      end
       ;;
  }

  # before we tagged the URL's with campaign ID's we tagged them with the subject line of the email, which is why you have so many manual additions to the buckets in this dimension.

  dimension: traffic_source {
    label: "CRM/Brand/Paid"

    case: {
      when: {
        sql: ${acquisition_channel} = 'CRM' ;;
        label: "CRM"
      }

      when: {
        sql: ${acquisition_channel} in ('SEM Non-Brand', 'Affiliates', 'Facebook - Paid Marketing') ;;
        label: "Paid"
      }

      else: "Brand"
    }
  }

  dimension: paid_unpaid_traffic_flag {
    label: "Paid/Unpaid"

    case: {
      when: {
        sql: ${acquisition_channel} in ('SEM Brand', 'SEM Non-Brand', 'Affiliates', 'Facebook - Paid Marketing') ;;
        label: "Paid"
      }

      else: "Unpaid"
    }
  }

  dimension: channel_grouping_3 {
    label: "Channel"

    case: {
      when: {
        sql: ${acquisition_channel} in ('SEM Brand', 'Search') ;;
        label: "Search"
      }

      when: {
        sql: ${acquisition_channel} in ('Facebook - Paid Marketing') ;;
        label: "Paid Social"
      }

      when: {
        sql: ${acquisition_channel} in ('CRM', 'Email', 'Other Marketing Source') ;;
        label: "CRM (Email)"
      }

      when: {
        sql: ${acquisition_channel} in ('Social') ;;
        label: "Organic Social"
      }

      when: {
        sql: ${acquisition_channel} in ('Referrals') ;;
        label: "Referrals"
      }
      when: {
        sql: ${acquisition_channel} in ('Affiliates') ;;
        label: "Affiliates"
      }

      else: "Direct"
    }
  }

  dimension: direct_session_flag {
    label: "Direct Session Flag"
    type: yesno
    sql: ${TABLE}.mkt_source is null and
      ${TABLE}.mkt_medium is null and
      ${TABLE}.mkt_term is null and
      ${TABLE}.mkt_campaign is null and
      ${TABLE}.mkt_content is null and
      ${TABLE}.refr_source is null and
      ${TABLE}.refr_medium is null and
      ${TABLE}.refr_term is null and
      ${TABLE}.refr_urlhost is null and
      ${TABLE}.refr_urlpath is null
       ;;
  }

  dimension: referer_medium {
    label: "Referrer Medium"
    sql: ${TABLE}.refr_medium_ga ;;
  }

  dimension: referer_source {
    label: "Referrer Source"
    sql: ${TABLE}.refr_source_ga ;;
  }

  dimension: referer_term {
    label: "Referrer Term"
    sql: ${TABLE}.refr_term_ga ;;
  }

  dimension: referer_url_host {
    label: "Referrer Host"
    sql: ${TABLE}.refr_urlhost_ga ;;
  }

  dimension: referer_url_path {
    label: "Referrer Path"
    sql: ${TABLE}.refr_urlpath_ga ;;
  }

  # MKT fields (paid acquisition channels)

  dimension: fb_audience_segment {
    sql: case when ${TABLE}.mkt_campaign_ga like '%Acquisition%' then 'NonBuyers - Acquisition'
      when ${TABLE}.mkt_campaign_ga like '%Custom Audience%' and ${TABLE}.mkt_campaign_ga like '%_NonBuyers%' then 'NonBuyers - Custom Audience'
      when ${TABLE}.mkt_campaign_ga like '%_CA_%' and ${TABLE}.mkt_campaign_ga like '%_NonBuyers%' then 'NonBuyers - Custom Audience'
      when ${TABLE}.mkt_campaign_ga like '%_DPA%' and ${TABLE}.mkt_campaign_ga like '%_NonBuyers%'then 'NonBuyers - DPA'
      when ${TABLE}.mkt_campaign_ga like '%_CA_%' and ${TABLE}.mkt_campaign_ga like '%_Buyers%' then 'Buyers - CA'
      when ${TABLE}.mkt_campaign_ga like '%_DPA%' and ${TABLE}.mkt_campaign_ga like '%_Buyers%' then 'Buyers - DPA' end
       ;;
  }

  dimension: campaign_medium {
    label: "Campaign Medium"
    sql: ${TABLE}.mkt_medium_ga ;;
  }

  dimension: campaign_source {
    label: "Campaign Source"
    sql: ${TABLE}.mkt_source_ga ;;
  }

  dimension: campaign_term {
    label: "Campaign Term"
    sql: ${TABLE}.mkt_term_ga ;;
  }

  dimension: campaign_name {
    label: "Campaign Name"
    sql: ${TABLE}.mkt_campaign_ga ;;
  }

  dimension: campaign_content {
    label: "Campaign Content"
    sql: ${TABLE}.mkt_content_ga ;;
  }

  # Device fields #

  dimension: device_type {
    label: "Device Type"

    case: {
      when: {
        sql: ${TABLE}.dvce_type = 'Computer' ;;
        label: "Desktop"
      }

      when: {
        sql: ${TABLE}.dvce_type = 'Tablet' ;;
        label: "Tablet"
      }

      when: {
        sql: ${TABLE}.dvce_type = 'Mobile' ;;
        label: "Mobile"
      }

      else: "Other/Unknown"
    }
  }

  dimension: device_is_mobile {
    label: "Mobile Flag"
    sql: ${TABLE}.dvce_ismobile ;;
    hidden: yes
  }

  dimension: device_screen_width {
    sql: ${TABLE}.dvce_screenwidth ;;
    hidden: yes
  }

  dimension: device_screen_height {
    sql: ${TABLE}.dvce_screenheight ;;
    hidden: yes
  }

  # OS fields #

  dimension: operating_system {
    label: "Operating System"
    sql: ${TABLE}.os_name ;;
  }

  dimension: operating_system_family {
    label: "Operating System Family"
    sql: ${TABLE}.os_family ;;
  }

  dimension: operating_system_manufacturer {
    label: "Operating System Manufacturer"
    sql: ${TABLE}.os_manufacturer ;;
  }

  # Browser fields #

  dimension: browser {
    label: "Browser"
    sql: ${TABLE}.br_name ;;
  }

  dimension: browser_version {
    label: "Browser Version"
    sql: ${TABLE}.br_version ;;
  }

  dimension: browser_type {
    label: "Browser Type"
    sql: ${TABLE}.br_type ;;
  }

  dimension: browser_family {
    label: "Browser Family"
    sql: ${TABLE}.br_family ;;
  }

  dimension: browser_renderengine {
    sql: ${TABLE}.br_renderengine ;;
    hidden: yes
  }

  dimension: browser_language {
    sql: ${TABLE}.br_lang ;;
    hidden: yes
  }

  dimension: browser_has_director_plugin {
    sql: ${TABLE}.br_features_director ;;
    hidden: yes
  }

  dimension: browser_has_flash_plugin {
    sql: ${TABLE}.br_features_flash ;;
    hidden: yes
  }

  dimension: browser_has_gears_plugin {
    sql: ${TABLE}.br_features_gears ;;
    hidden: yes
  }

  dimension: browser_has_java_plugin {
    sql: ${TABLE}.br_features_java ;;
    hidden: yes
  }

  dimension: browser_has_pdf_plugin {
    sql: ${TABLE}.br_features_pdf ;;
    hidden: yes
  }

  dimension: browser_has_quicktime_plugin {
    sql: ${TABLE}.br_features_quicktime ;;
    hidden: yes
  }

  dimension: browser_has_realplayer_plugin {
    sql: ${TABLE}.br_features_realplayer ;;
    hidden: yes
  }

  dimension: browser_has_silverlight_plugin {
    sql: ${TABLE}.br_features_silverlight ;;
    hidden: yes
  }

  dimension: browser_has_windowsmedia_plugin {
    sql: ${TABLE}.br_features_windowsmedia ;;
    hidden: yes
  }

  dimension: browser_supports_cookies {
    sql: ${TABLE}.br_cookies ;;
    hidden: yes
  }

  dimension: browser_width {
    sql: ${TABLE}.br_viewwidth ;;
  }

  dimension: browser_height {
    sql: ${TABLE}.br_viewheight ;;
  }

  dimension: homepage_view_flag {
    sql: ${TABLE}.homepage_view_flag ;;
    hidden: yes
  }

  dimension: category_page_view_flag {
    sql: ${TABLE}.category_page_view_flag ;;
    hidden: yes
  }

  dimension: products_page_view_flag {
    sql: ${TABLE}.products_page_view_flag ;;
    hidden: yes
  }

  dimension: chapters_page_flag {
    sql: ${TABLE}.chapters_page_flag ;;
    hidden: yes
  }

  dimension: editorial_page_flag {
    sql: ${TABLE}.editorial_page_flag ;;
    hidden: yes
  }

  dimension: cart_page_view_flag {
    sql: ${TABLE}.cart_page_view_flag ;;
    hidden: yes
  }

  dimension: checkout_reg_page_view_flag {
    sql: ${TABLE}.checkout_reg_page_view_flag ;;
    hidden: yes
  }

  dimension: checkout_ad_page_view_flag {
    sql: ${TABLE}.checkout_ad_page_view_flag ;;
    hidden: yes
  }

  dimension: checkout_del_page_flag {
    sql: ${TABLE}.checkout_del_page_flag ;;
    hidden: yes
  }

  dimension: checkout_payment_page_view_flag {
    sql: ${TABLE}.checkout_payment_page_view_flag ;;
    hidden: yes
  }

  dimension: checkout_order_page_view_flag {
    sql: ${TABLE}.checkout_order_page_view_flag ;;
    hidden: yes
  }

  ## Sale

  dimension: sale_page_view_flag {
    sql: case when ${TABLE}.sale_modal_viewed_flag = 1 and ${TABLE}.sale_modal_success_flag = 0 then 0
           when ${TABLE}.sale_modal_viewed_flag = 1 and ${TABLE}.sale_modal_success_flag = 1 then 1
           else cast(${TABLE}.sale_page_view_flag_2 as smallint) end
       ;;
    hidden: yes
  }

  dimension: has_viewed_sale_page {
    type: yesno
    sql: ${sale_page_view_flag} = 1 ;;
  }

  dimension: has_viewed_sale_modal {
    type: yesno
    sql: ${TABLE}.sale_modal_viewed_flag = 1 ;;
  }

  dimension: has_passed_sale_modal {
    type: yesno
    sql: ${TABLE}.sale_modal_success_flag = 1 ;;
  }

  dimension: cart_size_value {
    type: number
    value_format_name: decimal_2
    sql: ${TABLE}.cart_size_value_gbp ;;
  }

  dimension: cart_size_value_tier {
    type: tier
    tiers: [
      0,
      25,
      50,
      75,
      100,
      150,
      200
    ]
    sql: ${cart_size_value} ;;
    style: integer
    value_format: "\"£\"0"
  }

  dimension: cart_size_items {
    type: number
    sql: ${TABLE}.cart_size_items ;;
  }

  dimension: cart_size_items_tier {
    type: tier
    tiers: [
      0,
      1,
      2,
      3,
      4,
      5
    ]
    sql: ${cart_size_items} ;;
    style: integer
  }

  dimension: visit_contains_cart {
    type: yesno
    sql: ${TABLE}.conversion_funnel_4_add_to_cart = 1 ;;
  }

  ##########################################################################################################################################################
  ######################################################## MEASURES ########################################################################################
  ##########################################################################################################################################################

  measure: latest_data {
    type: string
    sql: max(${start_time}) ;;
  }

  measure: landing_page_visits {
    label: "Landing Page Visits Yest."
    type: number
    value_format_name: decimal_0
    sql: count(distinct case when ${start_date} = current_date - 1 and ${landing_page_path} then ${session_id} else null end)::REAL ;;
  }

  measure: count {
    label: "Visits Total"
    type: count_distinct
    sql: ${session_id} ;;
  }

  measure: count_running_total {
    label: "Visits Running Total"
    type: running_total
    sql: ${count} ;;
  }

  measure: count_percent_of_total {
    label: "Visits Percent of Total"
    type: percent_of_total
    direction: "row"
    sql: ${count} ;;
  }

  measure: visits_percent_of_total_column {
    type: percent_of_total
    direction: "column"
    sql: ${count} ;;
    value_format_name: decimal_1
  }

  measure: bounced_sessions_count {
    label: "Bounced Visits Total"
    type: count_distinct
    sql: ${session_id} ;;

    filters: {
      field: bounce
      value: "yes"
    }
  }

  measure: bounce_rate {
    label: "Bounce Rate"
    type: number
    value_format_name: percent_2
    sql: ${bounced_sessions_count}/NULLIF(${count},0)::REAL ;;
  }

  measure: engaged_sessions_count {
    label: "Engaged Sessions Total"
    type: count_distinct
    sql: ${session_id} ;;

    filters: {
      field: engaged_session
      value: "yes"
    }
  }

  measure: engagement_rate_short_name {
    label: "Engag. Rate"
    type: number
    value_format_name: percent_2
    sql: ${engaged_sessions_count}/NULLIF(${count},0)::REAL ;;
  }

  measure: logged_in_sessions_count {
    label: "Logged In Visits Total"
    type: count_distinct
    sql: ${session_id} ;;

    filters: {
      field: log_in_flag
      value: "yes"
    }
  }

  measure: conversion_rate {
    label: "Conversion Rate"
    type: number
    value_format_name: percent_2
    sql: ${sum_orders}/NULLIF(${count},0)::REAL ;;
  }

  measure: conversion_rate_short_name {
    label: "Conv. Rate"
    type: number
    value_format_name: percent_2
    sql: ${sum_orders}/NULLIF(${count},0)::REAL ;;
    hidden: yes
  }

  measure: revenue_per_session {
    label: "Revenue Per Visit"
    type: number
    value_format_name: decimal_2
    sql: ${sum_gross_revenue_ex_discount_ex_vat}/NULLIF(${count},0)::REAL ;;
  }

  measure: sessions_from_new_visitors_count {
    label: "New Visits Total"
    type: count_distinct
    sql: ${session_id} ;;

    filters: {
      field: session_index
      value: "1"
    }
  }

  measure: sessions_from_returning_visitor_count {
    label: "Returning Visits Total"
    type: number
    sql: ${count} - ${sessions_from_new_visitors_count} ;;
  }

  measure: new_visitor_percentage {
    label: "New Visit %"
    type: number
    value_format_name: percent_2
    sql: ${sessions_from_new_visitors_count}/NULLIF(${count},0)::REAL ;;
  }

  measure: returning_visitor_percentage {
    label: "Returning Visit %"
    type: number
    value_format_name: percent_2
    sql: ${sessions_from_returning_visitor_count}/NULLIF(${count},0)::REAL ;;
  }

  measure: visitors_count {
    label: "Total Visitors"
    type: count_distinct
    sql: ${blended_user_id} ;;
  }

  measure: events_count {
    label: "Total Events"
    type: sum
    sql: ${TABLE}.number_of_events ;;
  }

  measure: events_per_session {
    label: "Events Per Visit"
    type: number
    value_format_name: decimal_2
    sql: ${events_count}/NULLIF(${count},0)::REAL ;;
  }

  measure: events_per_visitor {
    label: "Events Per Visitor"
    type: number
    value_format_name: decimal_2
    sql: ${events_count}/NULLIF(${visitors_count},0)::REAL ;;
  }

  measure: sum_accounts_created {
    label: "Accounts Created Total"
    type: sum
    sql: ${accounts_created} ;;
  }

  measure: sum_newsletter_signups {
    label: "Newsletter Signups Total"
    type: sum
    sql: ${newsletter_signups} ;;
  }

  measure: nl_signup_rate {
    label: "Newsletter Signup Rate"
    type: number
    value_format_name: percent_2
    sql: ${sum_newsletter_signups}/NULLIF(${count},0)::REAL ;;
  }

  measure: sale_modal_views_total {
    type: count_distinct
    sql: ${session_id} ;;

    filters: {
      field: has_viewed_sale_modal
      value: "Yes"
    }
  }

  measure: sale_modal_successes_total {
    type: count_distinct
    sql: ${session_id} ;;

    filters: {
      field: has_passed_sale_modal
      value: "Yes"
    }
  }

  measure: sale_modal_success_rate {
    type: number
    value_format_name: percent_2
    sql: ${sale_modal_successes_total}/NULLIF(${sale_modal_views_total},0)::REAL ;;
  }

  measure: sale_modal_bounce_rate {
    type: number
    value_format_name: percent_2
    sql: (${sale_modal_views_total} - ${sale_modal_successes_total})/NULLIF(${sale_modal_views_total},0)::REAL ;;
  }

  measure: sum_products_added_to_cart {
    label: "Products Added to Cart Total"
    type: sum
    sql: ${products_added_to_cart} ;;
  }

  measure: sum_product_removed_from_cart {
    label: "Products Removed from Cart Total"
    type: sum
    sql: ${product_removed_from_cart} ;;
  }

  measure: sum_cart_events {
    label: "Cart Views Total"
    type: sum
    sql: ${cart_events} ;;
  }

  measure: sum_page_views {
    label: "Page Views Total"
    type: sum
    sql: ${distinct_pages_viewed} ;;
  }

  measure: sum_page_views_yesterday {
    label: "Actual"
    type: sum
    sql: case when ${start_date} = current_date - 1 then ${distinct_pages_viewed} else 0 end ;;
    group_label: "Page Views"
    hidden: yes
  }

  measure: sum_page_views_lw {
    label: "LW"
    type: sum
    sql: case when ${start_date} = current_date - 8 then ${distinct_pages_viewed} else 0 end ;;
    group_label: "Page Views"
    hidden: yes
  }

  measure: sum_page_views_l7d {
    label: "Actual"
    type: sum
    sql: case when ${start_date} between current_date - 7 and current_date - 1 then ${distinct_pages_viewed} else 0 end ;;
    group_label: "Page Views"
    hidden: yes
  }

  measure: sum_referrals_sent {
    label: "Referrals Sent"
    type: sum
    sql: ${referrals_sent} ;;
  }

  measure: sum_product_impressions {
    label: "Product Impressions Total"
    type: sum
    sql: ${product_impressions} ;;
  }

  measure: product_add_to_cart_rate {
    type: number
    value_format_name: percent_2
    sql: ${sum_products_added_to_cart}/NULLIF(${sum_product_views},0)::REAL ;;
  }

  measure: products_impressions_per_visit {
    type: number
    value_format_name: decimal_2
    sql: ${sum_product_impressions}/NULLIF(${count},0)::REAL ;;
  }

  measure: revenue_per_1k_impressions {
    type: number
    value_format_name: decimal_2
    sql: 1000*${sum_gross_revenue_ex_discount_ex_vat}/NULLIF(${sum_product_impressions},0)::REAL ;;
  }

  measure: sum_product_views {
    label: "Product Views Total"
    type: sum
    sql: ${product_views} ;;
  }

  measure: sum_products_purchased {
    label: "Products Purchased Total"
    type: sum
    sql: ${products_purchased} ;;
  }

  measure: product_conversion_rate {
    type: number
    value_format_name: percent_2
    sql: ${sum_products_purchased}/NULLIF(${sum_product_views},0)::REAL ;;
  }

  measure: sum_orders {
    type: sum
    sql: ${orders} ;;
  }

  measure: sum_gross_revenue_ex_discount {
    type: sum
    value_format_name: decimal_2
    sql: ${gross_revenue_ex_discount} ;;
  }

  measure: sum_gross_revenue_ex_discount_ex_vat {
    type: sum
    value_format_name: decimal_2
    sql: ${gross_revenue_ex_discount_ex_vat} ;;
  }

  measure: sum_shipping_revenue {
    type: sum
    value_format_name: decimal_2
    sql: ${shipping_revenue} ;;
  }

  measure: average_basket_size {
    type: number
    value_format_name: decimal_2
    sql: ${sum_gross_revenue_ex_discount}/NULLIF(${sum_orders},0)::REAL ;;
  }

  measure: average_items_in_basket {
    type: number
    value_format_name: decimal_2
    sql: ${sum_products_purchased}/NULLIF(${sum_orders},0)::REAL ;;
  }

  measure: average_selling_price {
    type: number
    value_format_name: decimal_2
    sql: (${sum_gross_revenue_ex_discount} - ${sum_shipping_revenue})/NULLIF(${sum_products_purchased},0)::REAL ;;
  }

  # products added to cart per visit
  measure: products_added_to_cart_per_visit {
    type: number
    value_format_name: decimal_2
    sql: ${sum_products_added_to_cart}/NULLIF(${count},0)::REAL ;;
  }

  # % of product views added to cart
  measure: product_added_to_cart_view_ratio {
    type: number
    value_format_name: percent_2
    sql: ${sum_products_added_to_cart}/NULLIF(${sum_product_views},0)::REAL ;;
  }

  #################################################################################################################
  ########################################### Conversion Funnel Measures ##########################################
  #################################################################################################################


  measure: conversion_funnel_2 {
    label: "Conversion Funnel 2 - Category Page Visits"
    type: number
    sql: COUNT(DISTINCT
      CASE
      WHEN (${category_page_view_flag} = 1
            OR ${products_page_view_flag} = 1
            OR ${cart_page_view_flag} = 1
            OR ${checkout_reg_page_view_flag} = 1
            OR ${cart_events} > 0
            OR ${products_added_to_cart} > 0
            OR ${orders} > 0
            OR ${checkout_progress} > 0)
      THEN ${session_id}
      ELSE NULL
      END)
       ;;
  }

  measure: conversion_funnel_3 {
    label: "Conversion Funnel 3 - Product Page Visits"
    type: number
    sql: COUNT(DISTINCT
      CASE
      WHEN (${products_page_view_flag} = 1
            OR ${cart_page_view_flag} = 1
            OR ${checkout_reg_page_view_flag} = 1
            OR ${cart_events} > 0
            OR ${products_added_to_cart} > 0
            OR ${orders} > 0
            OR ${checkout_progress} > 0)
      THEN ${session_id}
      ELSE NULL
      END)
       ;;
  }

  measure: conversion_funnel_4 {
    label: "Conversion Funnel 4 - Add to Cart Visits"
    type: number
    sql: COUNT(DISTINCT
      CASE
      WHEN (${cart_page_view_flag} = 1
            OR ${checkout_reg_page_view_flag} = 1
            OR ${cart_events} > 0
            OR ${products_added_to_cart} > 0
            OR ${orders} > 0
            OR ${checkout_progress} > 0)
      THEN ${session_id}
      ELSE NULL
      END)
       ;;
  }

  measure: conversion_funnel_5 {
    type: number
    label: "Conversion Funnel 5 - View Cart Visits"
    sql: COUNT(DISTINCT
      CASE
      WHEN (${cart_page_view_flag} = 1
            OR ${checkout_reg_page_view_flag} = 1
            OR ${orders} > 0
            OR ${checkout_progress} > 0)
      THEN ${session_id}
      ELSE NULL
      END)
       ;;
  }

  measure: conversion_funnel_6 {
    label: "Conversion Funnel 6 - Checkout - Registration Visits"
    type: number
    sql: COUNT(DISTINCT
      CASE
      WHEN (${checkout_reg_page_view_flag} = 1
            OR ${orders} > 0
            OR ${checkout_progress} > 0)
      THEN ${session_id}
      ELSE NULL
      END)
       ;;
  }

  measure: conversion_funnel_7 {
    label: "Conversion Funnel 7 - Checkout - Enter Address Visits"
    type: number
    sql: COUNT(DISTINCT
      CASE
      WHEN (${orders} > 0
            OR ${checkout_progress} > 0)
      THEN ${session_id}
      ELSE NULL
      END)
       ;;
  }

  measure: conversion_funnel_8 {
    label: "Conversion Funnel 8 - Checkout - Delivery Method Visits"
    type: number
    sql: COUNT(DISTINCT
      CASE
      WHEN (${orders} > 0
            OR ${checkout_progress} > 1)
      THEN ${session_id}
      ELSE NULL
      END)
       ;;
  }

  measure: conversion_funnel_9 {
    label: "Conversion Funnel 9 - Checkout - Payment Visits"
    type: number
    sql: COUNT(DISTINCT
      CASE
      WHEN (${orders} > 0
            OR ${checkout_progress} > 2)
      THEN ${session_id}
      ELSE NULL
      END)
       ;;
  }

  measure: conversion_funnel_10 {
    label: "Conversion Funnel 10 - Order Completed Visits"
    type: number
    sql: COUNT(DISTINCT
      CASE
      WHEN (${orders} > 0)
      THEN ${session_id}
      ELSE NULL
      END)
       ;;
  }

  measure: 1_conversion_funnel_all_sessions {
    label: "Conversion Funnel 1 (All Sessions)"
    type: number
    value_format_name: percent_2
    sql: ${count}/NULLIF(${count},0)::REAL ;;
  }

  measure: 2_conversion_funnel_category_page {
    label: "Conversion Funnel 2 (Category Page)"
    type: number
    value_format_name: percent_2
    sql: ${conversion_funnel_2}/NULLIF(${count},0)::REAL ;;
  }

  measure: 3_conversion_funnel_product_page {
    label: "Conversion Funnel 3 (Product Page)"
    type: number
    value_format_name: percent_2
    sql: ${conversion_funnel_3}/NULLIF(${count},0)::REAL ;;
  }

  measure: 4_conversion_funnel_add_to_cart {
    label: "Conversion Funnel 4 (Add to Cart)"
    type: number
    value_format_name: percent_2
    sql: ${conversion_funnel_4}/NULLIF(${count},0)::REAL ;;
  }

  measure: 5_conversion_funnel_view_cart {
    label: "Conversion Funnel 5 (View Cart)"
    type: number
    value_format_name: percent_2
    sql: ${conversion_funnel_5}/NULLIF(${count},0)::REAL ;;
  }

  measure: 6_conversion_funnel_checkout_registration {
    label: "Conversion Funnel 6 (Checkout - Registration)"
    type: number
    value_format_name: percent_2
    sql: ${conversion_funnel_6}/NULLIF(${count},0)::REAL ;;
  }

  measure: 7_conversion_funnel_checkout_address {
    label: "Conversion Funnel 7 (Checkout - Enter Address)"
    type: number
    value_format_name: percent_2
    sql: ${conversion_funnel_7}/NULLIF(${count},0)::REAL ;;
  }

  measure: 8_conversion_funnel_checkout_delivery {
    label: "Conversion Funnel 8 (Checkout - Delivery Method)"
    type: number
    value_format_name: percent_2
    sql: ${conversion_funnel_8}/NULLIF(${count},0)::REAL ;;
  }

  measure: 9_conversion_funnel_checkout_payment {
    label: "Conversion Funnel 9 (Checkout - Payment)"
    type: number
    value_format_name: percent_2
    sql: ${conversion_funnel_9}/NULLIF(${count},0)::REAL ;;
  }

  measure: 10_conversion_funnel_order {
    label: "Conversion Funnel 10 (Placed Order)"
    type: number
    value_format_name: percent_2
    sql: ${conversion_funnel_10}/NULLIF(${count},0)::REAL ;;
  }

  measure: dropout_rate_1 {
    label: "Dropout Rate 1 (All Sessions)"
    type: number
    value_format_name: percent_2
    sql: (${count} - ${conversion_funnel_2})/NULLIF(${count},0)::REAL ;;
  }

  measure: dropout_rate_2 {
    label: "Dropout Rate 2 (Category Page)"
    type: number
    value_format_name: percent_2
    sql: (${conversion_funnel_2} - ${conversion_funnel_3})/NULLIF(${conversion_funnel_2},0)::REAL ;;
  }

  measure: dropout_rate_3 {
    label: "Dropout Rate 3 (Product Page)"
    type: number
    value_format_name: percent_2
    sql: (${conversion_funnel_3} - ${conversion_funnel_4})/NULLIF(${conversion_funnel_3},0)::REAL ;;
  }

  measure: dropout_rate_4 {
    label: "Dropout Rate 4 (Add to Cart)"
    type: number
    value_format_name: percent_2
    sql: (${conversion_funnel_4} - ${conversion_funnel_5})/NULLIF(${conversion_funnel_4},0)::REAL ;;
  }

  measure: dropout_rate_5 {
    label: "Dropout Rate 5 (View Cart)"
    type: number
    value_format_name: percent_2
    sql: (${conversion_funnel_5} - ${conversion_funnel_6})/NULLIF(${conversion_funnel_5},0)::REAL ;;
  }

  measure: dropout_rate_6 {
    label: "Dropout Rate 6 (Checkout - Registration)"
    type: number
    value_format_name: percent_2
    sql: (${conversion_funnel_6} - ${conversion_funnel_7})/NULLIF(${conversion_funnel_6},0)::REAL ;;
  }

  measure: dropout_rate_7 {
    label: "Dropout Rate 7 (Checkout - Address)"
    type: number
    value_format_name: percent_2
    sql: (${conversion_funnel_7} - ${conversion_funnel_8})/NULLIF(${conversion_funnel_7},0)::REAL ;;
  }

  measure: dropout_rate_8 {
    label: "Dropout Rate 8 (Checkout - Delivery)"
    type: number
    value_format_name: percent_2
    sql: (${conversion_funnel_8} - ${conversion_funnel_9})/NULLIF(${conversion_funnel_8},0)::REAL ;;
  }

  measure: dropout_rate_9 {
    label: "Dropout Rate 9 (Checkout - Payment)"
    type: number
    value_format_name: percent_2
    sql: (${conversion_funnel_9} - ${conversion_funnel_10})/NULLIF(${conversion_funnel_9},0)::REAL ;;
  }

  measure: cart_abandonment_rate {
    type: number
    value_format_name: percent_2
    sql: (${conversion_funnel_4} - ${conversion_funnel_10})/NULLIF(${conversion_funnel_4},0)::REAL ;;
  }

  measure: checkout_abandonment_rate {
    type: number
    value_format_name: percent_2
    sql: (${conversion_funnel_7} - ${conversion_funnel_10})/NULLIF(${conversion_funnel_7},0)::REAL ;;
  }


########################## MGMT Reporting

  measure: visits_yesterday {
    label: "Visits Yesterday"
    type: number
    sql: count(distinct case when ${start_date} = current_date - 1 then ${session_id} else null end) ;;
  }

  measure: visits_yesterday_last_week {
    label: "Visits LW"
    type: number
    sql: count(distinct case when ${start_date} = current_date - 8 then ${session_id} else null end) ;;
  }

  measure: visits_yesterday_k {
    label: "Actual"
    type: number
    sql: count(distinct case when ${start_date} = current_date - 1 then ${session_id} else null end) ;;
    value_format_name: thousands
    group_label: "Traffic Reporting Measures"
  }

  measure: visits_yesterday_last_week_k {
    label: "LW"
    type: number
    sql: count(distinct case when ${start_date} = current_date - 8 then ${session_id} else null end) ;;
    value_format_name: thousands
    group_label: "Traffic Reporting Measures"
  }

  measure: visits_last_complete_week {
    label: "LCW"
    type: number
    sql: count(distinct case when (((${start_date}) >= ((DATEADD(week,-1, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())) ))) AND ( ${start_date} ) < ((DATEADD(week,1, DATEADD(week,-1, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())))))))) then ${session_id} else null end) ;;
    value_format_name: thousands
    group_label: "Traffic Reporting Measures"
  }

  measure: visits_last_complete_month {
    label: "LCM"
    type: number
    sql: count(distinct case when (( DATEPART(m, date_created) = DATEPART(m, DATEADD(m, -1, getdate())) AND DATEPART(yyyy, date_created) = DATEPART(yyyy, DATEADD(m, -1, getdate())) then ${session_id} else null end) ;;
    value_format_name: thousands
    group_label: "Traffic Reporting Measures"
  }



  measure: visits_previous_complete_week {
    label: "PCW"
    type:  number
    sql: count(distinct case when (((${start_date}) >= ((DATEADD(week,-2, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())) ))) AND ( ${start_date} ) < ((DATEADD(week,1, DATEADD(week,-2, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())))))))) then ${session_id} else null end) ;;
    value_format_name: thousands
    group_label: "Traffic Reporting Measures"
  }

  measure: visits_last_7_days {
    label: "L7D"
    type: number
    sql: count(distinct case when ${start_date} between current_date - 7 and current_date - 1 then ${session_id} else null end) ;;
    value_format_name: thousands
    group_label: "Traffic Reporting Measures"
  }

  measure: visits_yesterday_last_year {
    label: "LY"
    type: number
    sql: count(distinct case when (${start_date} = (select calendar_date from finery.calendar where week_number = (select week_number from finery.calendar where calendar_date = current_date - 1) and dow = (select dow from finery.calendar where calendar_date = current_date - 1) and year = (select year - 1 from finery.calendar where calendar_date = current_date - 1))) then ${session_id} else null end) ;;
    value_format_name: thousands
    group_label: "Traffic Reporting Measures"
  }

  measure: visits_last_complete_week_last_year {
    label: "LCW - LY"
    type:  number
    sql: count(distinct case when ${start_week_of_year} = EXTRACT(WEEK FROM current_date - 7) and ${start_date} between current_date - 400 and current_date - 30 then ${session_id} else null end);;
    value_format_name: thousands
    group_label: "Traffic Reporting Measures"
    }

  measure: visits_week_to_date {
    label: "WTD"
    type: number
    sql: count(distinct case when ${start_date} between date_trunc('week', current_date - 1) and current_date - 1 then ${session_id} else null end) ;;
    value_format_name: thousands
    group_label: "Traffic Reporting Measures"
  }

  measure: visits_week_to_date_last_week {
    label: "WTD LW"
    type: number
    sql: count(distinct case when ${start_date} between date_trunc('week', current_date - 8) and current_date - 8 then ${session_id} else null end) ;;
    value_format_name: thousands
    group_label: "Traffic Reporting Measures"
  }

  measure: visits_week_to_date_last_year {
    label: "WTD LY"
    type: number
    sql: count(distinct case when ${start_date} between date_trunc('week', (select calendar_date from finery.calendar where week_number = (select week_number from finery.calendar where calendar_date = current_date - 1) and dow = (select dow from finery.calendar where calendar_date = current_date - 1) and year = (select year - 1 from finery.calendar where calendar_date = current_date - 1))) and (select calendar_date from finery.calendar where week_number = (select week_number from finery.calendar where calendar_date = current_date - 1) and dow = (select dow from finery.calendar where calendar_date = current_date - 1) and year = (select year - 1 from finery.calendar where calendar_date = current_date - 1)) then ${session_id} else null end) ;;
    value_format_name: thousands
    group_label: "Traffic Reporting Measures"
  }

  measure: visits_month_to_date {
    label: "MTD"
    type: number
    sql: count(distinct case when ${start_date} between date_trunc('month', current_date - 1) and current_date - 1 then ${session_id} else null end) ;;
    value_format_name: thousands
    group_label: "Traffic Reporting Measures"
  }

  measure: visits_month_to_date_last_month {
    label: "MTD LM"
    type: number
    sql: count(distinct case when ${start_date} between date_trunc('month', add_months(current_date - 1, -1)) and add_months(current_date - 1, -1) then ${session_id} else null end) ;;
    value_format_name: thousands
    group_label: "Traffic Reporting Measures"
  }

  measure: visits_month_to_date_last_year {
    label: "MTD LY"
    type: number
    sql: count(distinct case when ${start_date} between date_trunc('month', add_months(current_date - 1, -12)) and add_months(current_date - 1, -12) then ${session_id} else null end) ;;
    value_format_name: thousands
    group_label: "Traffic Reporting Measures"
  }

  measure: visits_year_to_date {
    label: "YTD"
    type: number
    sql: count(distinct case when ${start_date} between date_trunc('year',current_date) and current_date-1  then ${session_id} else null end) ;;
    value_format_name: thousands
    group_label: "Traffic Reporting Measures"
  }

  measure: visits_year_to_date_last_year {
    label: "YTD LY"
    type: number
    sql: count(distinct case when ${start_date} between date_trunc('year', add_months(current_date - 1, -12)) and add_months(current_date - 1, -12) then ${session_id} else null end) ;;
    value_format_name: thousands
    group_label: "Traffic Reporting Measures"
  }

  measure: visits_target_yesterday {
    label: "Target Yest"
    type: number
    sql: avg((select sum(Case when calendar_date = current_date - 1 then visits else null end) from finery.targets_2017)) ;;
    value_format_name: thousands
    group_label: "Traffic Reporting Measures"
  }

  measure: visits_target_week_to_date {
    label: "Target WTD"
    type: number
    sql: avg((select sum(Case when calendar_date between date_trunc('week', current_date - 1) and current_date - 1 then visits else null end) from finery.targets_2017)) ;;
    value_format_name: thousands
    group_label: "Traffic Reporting Measures"
  }
  measure: visits_target_month_to_date {
    label: "Target MTD"
    type: number
    sql: avg((select sum(Case when calendar_date between date_trunc('month', current_date - 1) and current_date - 1 then visits else null end) from finery.targets_2017)) ;;
    value_format_name: thousands
    group_label: "Traffic Reporting Measures"
  }

  measure: visits_yesterday_wow {
    label: "%"
    type: number
    value_format_name: percent_0
    group_label: "Traffic Reporting Measures"
    sql: (${visits_yesterday} - ${visits_yesterday_last_week})/NULLIF(${visits_yesterday_last_week},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: visits_last_complete_week_wow {
    label: "LCW %"
    type: number
    value_format_name: percent_0
    group_label: "Traffic Reporting Measures"
    sql: (${visits_last_complete_week} - ${visits_previous_complete_week})/NULLIF(${visits_previous_complete_week},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: visits_yesterday_yoy {
    label: "YoY"
    type: number
    value_format_name: percent_0
    group_label: "Traffic Reporting Measures"
    sql: (${visits_yesterday} - ${visits_yesterday_last_year})/NULLIF(${visits_yesterday_last_year},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: visits_last_complete_week_last_year_yoy {
    label: "LCW - LY%"
    type: number
    value_format_name: percent_0
    group_label: "Traffic Reporting Measures"
    sql: (${visits_last_complete_week} - ${visits_last_complete_week_last_year})/NULLIF(${visits_last_complete_week_last_year},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: visits_week_to_date_wow {
    label: "WTD WoW"
    type: number
    value_format_name: percent_0
    group_label: "Traffic Reporting Measures"
    sql: (${visits_week_to_date} - ${visits_week_to_date_last_week})/NULLIF(${visits_week_to_date_last_week},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: visits_week_to_date_yoy {
    label: "WTD YoY"
    type: number
    value_format_name: percent_0
    group_label: "Traffic Reporting Measures"
    sql: (${visits_week_to_date} - ${visits_week_to_date_last_year})/NULLIF(${visits_week_to_date_last_year},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: visits_month_to_date_mom {
    label: "MTD MoM"
    type: number
    value_format_name: percent_0
    group_label: "Traffic Reporting Measures"
    sql: (${visits_month_to_date} - ${visits_month_to_date_last_month})/NULLIF(${visits_month_to_date_last_month},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: visits_month_to_date_yoy {
    label: "MTD YoY"
    type: number
    value_format_name: percent_0
    group_label: "Traffic Reporting Measures"
    sql: (${visits_month_to_date} - ${visits_month_to_date_last_year})/NULLIF(${visits_month_to_date_last_year},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: visits_year_to_date_yoy {
    label: "YTD YoY"
    type: number
    value_format_name: percent_0
    group_label: "Traffic Reporting Measures"
    sql: (${visits_year_to_date} - ${visits_year_to_date_last_year})/NULLIF(${visits_year_to_date_last_year},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: visits_yeaterday_vs_target {
    label: "Yest vs Target"
    type: number
    value_format_name: percent_0
    group_label: "Traffic Reporting Measures"
    sql: (${visits_yesterday} - ${visits_target_yesterday})/NULLIF(${visits_target_yesterday},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: visits_week_to_date_vs_target {
    label: "WTD vs Target"
    type: number
    value_format_name: percent_0
    group_label: "Traffic Reporting Measures"
    sql: (${visits_week_to_date} - ${visits_target_week_to_date})/NULLIF(${visits_target_week_to_date},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: visits_month_to_date_vs_target {
    label: "MTD vs Target"
    type: number
    value_format_name: percent_0
    group_label: "Traffic Reporting Measures"
    sql: (${visits_month_to_date} - ${visits_target_month_to_date})/NULLIF(${visits_target_month_to_date},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }



  measure: orders_yesterday {
    label: "Actual"
    type: number
    sql: sum(case when ${start_date} = current_date - 1 then (${orders}) else 0 end)::REAL ;;
    group_label: "Orders Reporting Measures"
  }

  measure: orders_yesterday_last_week {
    label: "LW"
    type: number
    sql: sum(case when ${start_date} = current_date - 8 then (${orders}) else 0 end)::REAL ;;
    group_label: "Orders Reporting Measures"
  }

  measure: orders_yesterday_week_on_week {
    label: "%"
    type: number
    value_format_name: percent_0
    group_label: "Orders Reporting Measures"
    sql: (${orders_yesterday} - ${orders_yesterday_last_week})/NULLIF(${orders_yesterday_last_week},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: orders_last_7_days {
    label: "L7D"
    type: number
    sql: sum(case when ${start_date} between current_date - 7 and current_date - 1 then ${orders} else 0 end)::REAL ;;
    group_label: "Orders Reporting Measures"
  }

  measure: orders_yesterday_last_year {
    label: "LY"
    type: number
    sql: sum(case when (${start_date} = (select calendar_date from finery.calendar where week_number = (select week_number from finery.calendar where calendar_date = current_date - 1) and dow = (select dow from finery.calendar where calendar_date = current_date - 1) and year = (select year - 1 from finery.calendar where calendar_date = current_date - 1))) then (${orders}) else 0 end) ;;
    group_label: "Orders Reporting Measures"
  }

  measure: orders_last_complete_week_last_year {
    label: "LCW - LY"
    type:  number
    sql: sum(case when ${start_week_of_year} = EXTRACT(WEEK FROM current_date - 7) and ${start_date} between current_date - 400 and current_date - 30 then ${orders} else 0 end);;
    group_label: "Orders Reporting Measures"
  }

  measure: orders_yesterday_year_on_year {
    label: "YoY"
    type: number
    value_format_name: percent_0
    group_label: "Orders Reporting Measures"
    sql: (${orders_yesterday} - ${orders_yesterday_last_year})/NULLIF(${orders_yesterday_last_year},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: orders_last_complete_week_last_year_yoy {
    label: "LCW - LY%"
    type: number
    value_format_name: percent_0
    group_label: "Orders Reporting Measures"
    sql: (${orders_last_complete_week} - ${orders_last_complete_week_last_year})/NULLIF(${orders_last_complete_week_last_year},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: orders_week_to_date {
    label: "WTD"
    type: number
    sql: sum(case when ${start_date} between date_trunc('week', current_date - 1) and current_date - 1 then (${orders}) else 0 end) ;;
    group_label: "Orders Reporting Measures"
  }

  measure: orders_last_complete_week {
    label: "LCW"
    type: number
    sql: sum(case when (((${start_date}) >= ((DATEADD(week,-1, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())) ))) AND ( ${start_date} ) < ((DATEADD(week,1, DATEADD(week,-1, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())))))))) then ${orders} else 0 end) ;;
    group_label: "Orders Reporting Measures"
  }

  measure: orders_previous_complete_week {
    label: "PCW"
    type:  number
    sql: sum(case when (((${start_date}) >= ((DATEADD(week,-2, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())) ))) AND (${start_date}) < ((DATEADD(week,1, DATEADD(week,-2, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())) ) ))))) then ${orders} else 0 end) ;;
    group_label: "Orders Reporting Measures"
  }

  measure: orders_last_complete_week_wow {
    label: "LCW %"
    type: number
    value_format_name: percent_0
    group_label: "Orders Reporting Measures"
    sql: (${orders_last_complete_week} - ${orders_previous_complete_week})/NULLIF(${orders_previous_complete_week},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: orders_week_to_date_lw {
    label: "WTD LW"
    type: number
    sql: sum(case when ${start_date} between date_trunc('week', current_date - 8) and current_date - 8 then (${orders}) else 0 end) ;;
    group_label: "Orders Reporting Measures"
  }

  measure: orders_week_to_date_week_on_week {
    label: "WTD WoW"
    type: number
    value_format_name: percent_0
    group_label: "Orders Reporting Measures"
    sql: (${orders_week_to_date} - ${orders_week_to_date_lw})/NULLIF(${orders_week_to_date_lw},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: orders_week_to_date_ly {
    label: "WTD LY"
    type: number
    sql: sum(case when ${start_date} between date_trunc('week', (select calendar_date from finery.calendar where week_number = (select week_number from finery.calendar where calendar_date = current_date - 1) and dow = (select dow from finery.calendar where calendar_date = current_date - 1) and year = (select year - 1 from finery.calendar where calendar_date = current_date - 1))) and (select calendar_date from finery.calendar where week_number = (select week_number from finery.calendar where calendar_date = current_date - 1) and dow = (select dow from finery.calendar where calendar_date = current_date - 1) and year = (select year - 1 from finery.calendar where calendar_date = current_date - 1)) then (${orders}) else 0 end) ;;
    group_label: "Orders Reporting Measures"
  }

  measure: orders_week_to_date_year_on_year {
    label: "WTD YoY"
    type: number
    value_format_name: percent_0
    group_label: "Orders Reporting Measures"
    sql: (${orders_week_to_date} - ${orders_week_to_date_ly})/NULLIF(${orders_week_to_date_ly},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: orders_month_to_date {
    label: "MTD"
    type: number
    sql: sum(case when ${start_date} between date_trunc('month', current_date - 1) and current_date - 1 then (${orders}) else 0 end) ;;
    group_label: "Orders Reporting Measures"
  }

  measure: orders_month_to_date_last_month {
    label: "MTD LM"
    type: number
    sql: sum(case when ${start_date} between date_trunc('month', add_months(current_date - 1, -1)) and add_months(current_date - 1, -1) then (${orders}) else 0 end) ;;
    group_label: "Orders Reporting Measures"
  }

  measure: orders_month_to_date_month_on_month {
    label: "MTD MoM"
    type: number
    value_format_name: percent_0
    group_label: "Orders Reporting Measures"
    sql: (${orders_month_to_date} - ${orders_month_to_date_last_month})/NULLIF(${orders_month_to_date_last_month},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: orders_month_to_date_last_year {
    label: "MTD LY"
    type: number
    sql: sum(case when ${start_date} between date_trunc('month', add_months(current_date - 1, -12)) and add_months(current_date - 1, -12) then (${orders}) else 0 end) ;;
    group_label: "Orders Reporting Measures"
  }

  measure: orders_month_to_date_year_on_year {
    label: "MTD YoY"
    type: number
    value_format_name: percent_0
    group_label: "Orders Reporting Measures"
    sql: (${orders_month_to_date} - ${orders_month_to_date_last_year})/NULLIF(${orders_month_to_date_last_year},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: orders_year_to_date {
    label: "YTD"
    type: number
    sql: sum(case when ${start_date} between date_trunc('year', current_date - 1) and current_date - 1 then (${orders}) else 0 end) ;;
    group_label: "Orders Reporting Measures"
  }

  measure: orders_year_to_date_last_year {
    label: "YTD LY"
    type: number
    sql: sum(case when ${start_date} between date_trunc('year', add_months(current_date - 1, -12)) and add_months(current_date - 1, -12) then (${orders}) else 0 end) ;;
    group_label: "Orders Reporting Measures"
  }

  measure: orders_year_to_date_year_on_year {
    label: "YTD YoY"
    type: number
    value_format_name: percent_0
    group_label: "Orders Reporting Measures"
    sql: (${orders_year_to_date} - ${orders_year_to_date_last_year})/NULLIF(${orders_year_to_date_last_year},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: orders_target_yesterday {
    label: "Target Yest"
    type: number
    sql: avg((select sum(Case when calendar_date = current_date - 1 then Orders else 0 end) from finery.targets_2017)) ;;
    group_label: "Orders Reporting Measures"
  }

  measure: orders_yesterday_vs_target {
    label: "Yest vs Target"
    type: number
    value_format_name: percent_0
    group_label: "Orders Reporting Measures"
    sql: (${orders_yesterday} - ${orders_target_yesterday})/NULLIF(${orders_target_yesterday},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: orders_target_week_to_date {
    label: "Target WTD"
    type: number
    sql: avg((select sum(Case when calendar_date between date_trunc('week', current_date - 1) and current_date - 1 then Orders else 0 end) from finery.targets_2017)) ;;
    group_label: "Orders Reporting Measures"
  }

  measure: orders_week_to_date_vs_target {
    label: "WTD vs Target"
    type: number
    value_format_name: percent_0
    group_label: "Orders Reporting Measures"
    sql: (${orders_week_to_date} - ${orders_target_week_to_date})/NULLIF(${orders_target_week_to_date},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: orders_target_month_to_date {
    label: "Target MTD"
    type: number
    sql: avg((select sum(Case when calendar_date between date_trunc('month', current_date - 1) and current_date - 1 then Orders else 0 end) from finery.targets_2017)) ;;
    group_label: "Orders Reporting Measures"
  }

  measure: orders_month_to_date_vs_target {
    label: "MTD vs Target"
    type: number
    value_format_name: percent_0
    group_label: "Orders Reporting Measures"
    sql: (${orders_month_to_date} - ${orders_target_month_to_date})/NULLIF(${orders_target_month_to_date},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: conversion_yesterday {
    label: "Actual"
    type: number
    sql: ${orders_yesterday}/nullif(${visits_yesterday},0)::REAL ;;
    value_format_name: percent_1
    group_label: "Conversion Rate Reporting Measures"
  }

  measure: conversion_yesterday_last_week {
    label: "LW"
    type: number
    sql: ${orders_yesterday_last_week}/nullif(${visits_yesterday_last_week},0)::REAL ;;
    value_format_name: percent_1
    group_label: "Conversion Rate Reporting Measures"
  }

  measure: conversion_rate_last_7_days {
    label: "L7D"
    type: number
    value_format_name: percent_1
    sql: ${orders_last_7_days}/nullif(${visits_last_7_days},0)::REAL ;;
    group_label: "Conversion Rate Reporting Measures"
  }

  measure: conversion_last_7_days_percentage {
    label: "vs L7D"
    type: number
    value_format_name: percent_0
    group_label: "Conversion Rate Reporting Measures"
    sql: (${conversion_yesterday} - ${conversion_rate_last_7_days})/NULLIF(${conversion_rate_last_7_days},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: conversion_yesterday_last_year {
    label: "LY"
    type: number
    sql: ${orders_yesterday_last_year}/nullif(${visits_yesterday_last_year},0)::REAL ;;
    value_format_name: percent_1
    group_label: "Conversion Rate Reporting Measures"
  }

  measure: conversion_last_complete_week_last_year {
    label: "LCW - LY"
    type: number
    sql: ${orders_last_complete_week_last_year}/NULLIF(${visits_last_complete_week_last_year},0)::REAL ;;
    value_format_name: percent_1
    group_label: "Conversion Rate Reporting Measures"
  }

  measure: conversion_week_to_date {
    label: "WTD"
    type: number
    sql: ${orders_week_to_date}/nullif(${visits_week_to_date},0)::REAL ;;
    value_format_name: percent_1
    group_label: "Conversion Rate Reporting Measures"
  }

  measure: conversion_week_to_date_last_week {
    label: "WTD LW"
    type: number
    sql: ${orders_week_to_date_lw}/nullif(${visits_week_to_date_last_week},0)::REAL ;;
    value_format_name: percent_1
    group_label: "Conversion Rate Reporting Measures"
  }

  measure: conversion_week_to_date_last_year {
    label: "WTD LY"
    type: number
    sql: ${orders_week_to_date_ly}/nullif(${visits_week_to_date_last_year},0)::REAL ;;
    value_format_name: percent_1
    group_label: "Conversion Rate Reporting Measures"
  }

  measure: conversion_last_complete_week {
    label: "LCW"
    type: number
    sql: ${orders_last_complete_week}/nullif(${visits_last_complete_week},0)::REAL ;;
    value_format_name: percent_1
    group_label: "Conversion Rate Reporting Measures"
  }

  measure: conversion_previous_complete_week {
    label: "PCW"
    type: number
    sql: ${orders_previous_complete_week}/nullif(${visits_previous_complete_week},0)::REAL ;;
    value_format_name: percent_1
    group_label: "Conversion Rate Reporting Measures"
  }

  measure: conversion_month_to_date {
    label: "MTD"
    type: number
    sql: ${orders_month_to_date}/nullif(${visits_month_to_date},0)::REAL ;;
    value_format_name: percent_1
    group_label: "Conversion Rate Reporting Measures"
  }

  measure: conversion_month_to_date_last_month {
    label: "MTD LM"
    type: number
    sql: ${orders_month_to_date_last_month}/nullif(${visits_month_to_date_last_month},0)::REAL ;;
    value_format_name: percent_1
    group_label: "Conversion Rate Reporting Measures"
  }

  measure: conversion_month_to_date_last_year {
    label: "MTD LY"
    type: number
    sql: ${orders_month_to_date_last_year}/nullif(${visits_month_to_date_last_year},0)::REAL ;;
    value_format_name: percent_1
    group_label: "Conversion Rate Reporting Measures"
  }

  measure: conversion_year_to_date {
    label: "YTD"
    type: number
    sql: ${orders_year_to_date}/nullif(${visits_year_to_date},0)::REAL ;;
    value_format_name: percent_1
    group_label: "Conversion Rate Reporting Measures"
  }

  measure: conversion_year_to_date_last_year {
    label: "YTD LY"
    type: number
    sql: ${orders_year_to_date_last_year}/nullif(${visits_year_to_date_last_year},0)::REAL ;;
    value_format_name: percent_1
    group_label: "Conversion Rate Reporting Measures"
  }

  measure: conversion_target_yesterday {
    label: "Target Yest"
    type: number
    sql: ${orders_target_yesterday}/nullif(${visits_target_yesterday},0)::REAL ;;
    value_format_name: percent_1
    group_label: "Conversion Rate Reporting Measures"
  }

  measure: conversion_target_week_to_date {
    label: "Target WTD"
    type: number
    sql: ${orders_target_week_to_date}/nullif(${visits_target_week_to_date},0)::REAL ;;
    value_format_name: percent_1
    group_label: "Conversion Rate Reporting Measures"
  }

  measure: conversion_target_month_to_date {
    label: "Target MTD"
    type: number
    sql: ${orders_target_month_to_date}/nullif(${visits_target_month_to_date},0)::REAL ;;
    value_format_name: percent_1
    group_label: "Conversion Rate Reporting Measures"
  }

  measure: conversion_yesterday_wow {
    label: "%"
    type: number
    value_format_name: percent_0
    group_label: "Conversion Rate Reporting Measures"
    sql: (${conversion_yesterday} - ${conversion_yesterday_last_week})/NULLIF(${conversion_yesterday_last_week},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: conversion_yesterday_yoy {
    label: "YoY"
    type: number
    value_format_name: percent_0
    group_label: "Conversion Rate Reporting Measures"
    sql: (${conversion_yesterday} - ${conversion_yesterday_last_year})/NULLIF(${conversion_yesterday_last_year},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: conversion_week_to_date_wow {
    label: "WTD WoW"
    type: number
    value_format_name: percent_0
    group_label: "Conversion Rate Reporting Measures"
    sql: (${conversion_week_to_date} - ${conversion_week_to_date_last_week})/NULLIF(${conversion_week_to_date_last_week},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: conversion_week_to_date_yoy {
    label: "WTD YoY"
    type: number
    value_format_name: percent_0
    group_label: "Conversion Rate Reporting Measures"
    sql: (${conversion_week_to_date} - ${conversion_week_to_date_last_year})/NULLIF(${conversion_week_to_date_last_year},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: conversion_month_to_date_mom {
    label: "MTD MoM"
    type: number
    value_format_name: percent_0
    group_label: "Conversion Rate Reporting Measures"
    sql: (${conversion_month_to_date} - ${conversion_month_to_date_last_month})/NULLIF(${conversion_month_to_date_last_month},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: conversion_month_to_date_yoy {
    label: "MTD YoY"
    type: number
    value_format_name: percent_0
    group_label: "Conversion Rate Reporting Measures"
    sql: (${conversion_month_to_date} - ${conversion_month_to_date_last_year})/NULLIF(${conversion_month_to_date_last_year},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: conversion_last_complete_week_wow {
    label: "LCW %"
    type: number
    value_format_name: percent_0
    group_label: "Conversion Rate Reporting Measures"
    sql: (${conversion_last_complete_week} - ${conversion_previous_complete_week})/NULLIF(${conversion_previous_complete_week},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: conversion_last_complete_week_last_year_yoy {
    label: "LCW - LY%"
    type: number
    value_format_name: percent_0
    group_label: "Conversion Rate Reporting Measures"
    sql: (${conversion_last_complete_week} - ${conversion_last_complete_week_last_year})/NULLIF(${conversion_last_complete_week_last_year},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: conversion_year_to_date_yoy {
    label: "YTD YoY"
    type: number
    value_format_name: percent_0
    group_label: "Conversion Rate Reporting Measures"
    sql: (${conversion_year_to_date} - ${conversion_year_to_date_last_year})/NULLIF(${conversion_year_to_date_last_year},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: conversion_yeaterday_vs_target {
    label: "Yest vs Target"
    type: number
    value_format_name: percent_0
    group_label: "Conversion Rate Reporting Measures"
    sql: (${conversion_yesterday} - ${conversion_target_yesterday})/NULLIF(${conversion_target_yesterday},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: conversion_week_to_date_vs_target {
    label: "WTD vs Target"
    type: number
    value_format_name: percent_0
    group_label: "Conversion Rate Reporting Measures"
    sql: (${conversion_week_to_date} - ${conversion_target_week_to_date})/NULLIF(${conversion_target_week_to_date},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: conversion_month_to_date_vs_target {
    label: "MTD vs Target"
    type: number
    value_format_name: percent_0
    group_label: "Conversion Rate Reporting Measures"
    sql: (${conversion_month_to_date} - ${conversion_target_month_to_date})/NULLIF(${conversion_target_month_to_date},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }


  measure: bounced_visits_yesterday {
    label: "Actual"
    type: number
    value_format_name: decimal_0
    sql: count(distinct case when ${start_date} = current_date - 1 and ${bounce}  then ${session_id} else null end)::REAL ;;
    group_label: "Bounced Visits Reporting Measures"
    hidden: yes
  }

  measure: bounced_visits_lw {
    label: "LW"
    type: number
    value_format_name: decimal_0
    sql: count(distinct case when ${start_date} = current_date - 8 and ${bounce} then ${session_id} else null end)::REAL ;;
    group_label: "Bounced Visits Reporting Measures"
    hidden: yes
  }

  measure:bounced_visits_last_7_days {
    label: "L7D"
    type: number
    value_format_name: decimal_0
    sql: count(distinct case when ${start_date} between current_date - 7 and current_date - 1 and ${bounce} then ${session_id} else null end)::REAL ;;
    group_label: "Bounced Visits Reporting Measures"
    hidden: yes
  }

  measure: bounce_rate_yesterday {
    label: "Actual"
    type: number
    value_format_name: percent_1
    sql: ${bounced_visits_yesterday}/nullif(${visits_yesterday},0) ;;
    group_label: "Bounce Rate Reporting Measures"
  }

  measure: bounce_rate_lw {
    label: "LW"
    type: number
    value_format_name: percent_1
    sql: ${bounced_visits_lw}/nullif(${visits_yesterday_last_week},0) ;;
    group_label: "Bounce Rate Reporting Measures"
  }

  measure: bounce_rate_wow {
    label: "%"
    type: number
    value_format_name: percent_0
    group_label: "Bounce Rate Reporting Measures"
    sql: (${bounce_rate_yesterday} - ${bounce_rate_lw})/NULLIF(${bounce_rate_lw},0)::REAL ;;
    html: {% if value > 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value < 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure:bounce_rate_last_7_days {
    label: "L7D"
    type: number
    value_format_name: percent_1
    sql: ${bounced_visits_last_7_days}/Nullif(${visits_last_7_days},0)::REAL ;;
    group_label: "Bounce Rate Reporting Measures"
  }

  measure: bounce_rate_last_7_days_percentage {
    label: "vs L7D"
    type: number
    value_format_name: percent_0
    group_label: "Bounce Rate Reporting Measures"
    sql: (${bounce_rate_yesterday} - ${bounce_rate_last_7_days})/NULLIF(${bounce_rate_last_7_days},0)::REAL ;;
    html: {% if value > 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value < 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: bounce_rate_lcw {
    label: "LCW"
    type: number
    value_format_name: percent_1
    sql: count(distinct case when (((${start_date}) >= ((DATEADD(week,-1, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())) ))) AND ( ${start_date} ) < ((DATEADD(week,1, DATEADD(week,-1, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())))))))) and ${bounce} then ${session_id} else null end)/NULLIF(${visits_last_complete_week},0)::REAL ;;
    group_label: "Bounce Rate Reporting Measures"
  }

  measure: bounce_rate_pcw {
    label: "PCW"
    type: number
    value_format_name: percent_1
    sql: count(distinct case when (((${start_date}) >= ((DATEADD(week,-2, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())) ))) AND ( ${start_date} ) < ((DATEADD(week,1, DATEADD(week,-2, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())))))))) and ${bounce} then ${session_id} else null end)/NULLIF(${visits_previous_complete_week},0)::REAL ;;
    group_label: "Bounce Rate Reporting Measures"
  }

  measure: bounce_rate_lcw_wow {
    label: "LCW %"
    type: number
    value_format_name: percent_0
    group_label: "Bounce Rate Reporting Measures"
    sql: (${bounce_rate_lcw} - ${bounce_rate_pcw})/NULLIF(${bounce_rate_pcw},0)::REAL ;;
    html: {% if value > 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value < 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: bounce_rate_lcw_ly {
    label: "LCW - LY"
    type: number
    value_format_name: percent_1
    sql: count(distinct case when ${start_week_of_year} = EXTRACT(WEEK FROM current_date - 7) and ${start_date} between current_date - 400 and current_date - 30 and ${bounce} then ${session_id} else null end)/NULLIF(${visits_last_complete_week_last_year},0)::REAL ;;
    group_label: "Bounce Rate Reporting Measures"
  }

  measure: bounce_rate_lcw_ly_yoy {
    label: "LCW - LY%"
    type: number
    value_format_name: percent_0
    group_label: "Bounce Rate Reporting Measures"
    sql: (${bounce_rate_lcw} - ${bounce_rate_lcw_ly})/NULLIF(${bounce_rate_lcw_ly},0)::REAL ;;
    html: {% if value > 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value < 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: bounce_rate_mtd {
    label: "MTD"
    type: number
    value_format_name: percent_1
    sql: count(distinct case when ${start_date} between date_trunc('month', current_date - 1) and current_date - 1 and ${bounce} then ${session_id} else null end)/NULLIF(${visits_month_to_date},0)::REAL ;;
    group_label: "Bounce Rate Reporting Measures"
  }

  measure: bounce_rate_mtd_lm {
    label: "MTD LM"
    type: number
    value_format_name: percent_1
    sql: count(distinct case when ${start_date} between date_trunc('month', add_months(current_date - 1, -1)) and add_months(current_date - 1, -1) and ${bounce} then ${session_id} else null end)/NULLIF(${visits_month_to_date_last_month},0)::REAL ;;
    group_label: "Bounce Rate Reporting Measures"
  }

  measure: bounce_rate_mtd_mom {
    label: "MTD MoM"
    type: number
    value_format_name: percent_0
    group_label: "Bounce Rate Reporting Measures"
    sql: (${bounce_rate_mtd} - ${bounce_rate_mtd_lm})/NULLIF(${bounce_rate_mtd_lm},0)::REAL ;;
    html: {% if value > 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value < 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: bounce_rate_ytd {
    label: "YTD"
    type: number
    value_format_name: percent_1
    sql: count(distinct case when ${start_date} between date_trunc('year',current_date) and current_date-1 and ${bounce} then ${session_id} else null end)/NULLIF(${visits_year_to_date},0)::REAL ;;
    group_label: "Bounce Rate Reporting Measures"
  }

  measure: bounce_rate_ytd_ly {
    label: "YTD LY"
    type: number
    value_format_name: percent_1
    sql: count(distinct case when ${start_date} between date_trunc('year', add_months(current_date - 1, -12)) and add_months(current_date - 1, -12) and ${bounce} then ${session_id} else null end)/NULLIF(${visits_year_to_date_last_year},0)::REAL ;;
    group_label: "Bounce Rate Reporting Measures"
  }

  measure: bounce_rate_ytd_yoy {
    label: "YTD YoY"
    type: number
    value_format_name: percent_0
    group_label: "Bounce Rate Reporting Measures"
    sql: (${bounce_rate_ytd} - ${bounce_rate_ytd_ly})/NULLIF(${bounce_rate_ytd_ly},0)::REAL ;;
    html: {% if value > 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value < 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: engagement_rate {
    label: "Engagement Rate"
    type: number
    value_format_name: percent_1
    sql: ${engaged_sessions_count}/NULLIF(${count},0)::REAL ;;
  }

  measure: engaged_visits_yesterday {
    label: "Actual"
    type: number
    value_format_name: decimal_0
    sql: count(distinct case when ${start_date} = current_date - 1 and ${engaged_session}  then ${session_id} else null end)::REAL ;;
    group_label: "Engagement Rate Reporting Measures"
    hidden: yes
  }

  measure: engaged_visits_lw {
    label: "LW"
    type: number
    value_format_name: decimal_0
    sql: count(distinct case when ${start_date} = current_date - 8 and ${engaged_session} then ${session_id} else null end)::REAL ;;
    group_label: "Engagement Rate Reporting Measures"
    hidden: yes
  }

  measure: engaged_visit_last_7_days {
    label: "L7D"
    type: number
    value_format_name: decimal_0
    sql: count(distinct case when ${start_date} between current_date - 7 and current_date - 1 and ${engaged_session} then ${session_id} else null end)::REAL ;;
    group_label: "Engagement Rate Reporting Measures"
    hidden: yes
  }

  measure: engagement_rate_yesterday {
    label: "Actual"
    type: number
    value_format_name: percent_1
    sql: ${engaged_visits_yesterday}/nullif(${visits_yesterday},0) ;;
    group_label: "Engagement Rate Reporting Measures"
  }

  measure: engagement_rate_lw {
    label: "LW"
    type: number
    value_format_name: percent_1
    sql: ${engaged_visits_lw}/nullif(${visits_yesterday_last_week},0) ;;
    group_label: "Engagement Rate Reporting Measures"
  }

  measure: engagement_rate_wow {
    label: "%"
    type: number
    value_format_name: percent_0
    group_label: "Engagement Rate Reporting Measures"
    sql: (${engagement_rate_yesterday} - ${engagement_rate_lw})/NULLIF(${engagement_rate_lw},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure:engagement_rate_last_7_days {
    label: "L7D"
    type: number
    value_format_name: percent_1
    sql: ${engaged_visit_last_7_days}/Nullif(${visits_last_7_days},0)::REAL ;;
    group_label: "Engagement Rate Reporting Measures"
  }

  measure: engagement_rate_last_7_days_percentage {
    label: "vs L7D"
    type: number
    value_format_name: percent_0
    group_label: "Engagement Rate Reporting Measures"
    sql: (${engagement_rate_yesterday} - ${engagement_rate_last_7_days})/NULLIF(${engagement_rate_last_7_days},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: engagement_rate_lcw {
    label: "LCW"
    type: number
    value_format_name: percent_1
    sql: count(distinct case when (((${start_date}) >= ((DATEADD(week,-1, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())) ))) AND ( ${start_date} ) < ((DATEADD(week,1, DATEADD(week,-1, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())))))))) and ${engaged_session} then ${session_id} else null end)/NULLIF(${visits_last_complete_week},0)::REAL ;;
    group_label: "Engagement Rate Reporting Measures"
  }

  measure: engagement_rate_pcw {
    label: "PCW"
    type: number
    value_format_name: percent_1
    sql: count(distinct case when (((${start_date}) >= ((DATEADD(week,-2, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())) ))) AND ( ${start_date} ) < ((DATEADD(week,1, DATEADD(week,-2, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())))))))) and ${engaged_session} then ${session_id} else null end)/NULLIF(${visits_previous_complete_week},0)::REAL ;;
    group_label: "Engagement Rate Reporting Measures"
  }

  measure: engagement_rate_lcw_wow {
    label: "LCW %"
    type: number
    value_format_name: percent_0
    group_label: "Engagement Rate Reporting Measures"
    sql: (${engagement_rate_lcw} - ${engagement_rate_pcw})/NULLIF(${engagement_rate_pcw},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: engagement_rate_lcw_ly {
    label: "LCW - LY"
    type: number
    value_format_name: percent_1
    sql: count(distinct case when ${start_week_of_year} = EXTRACT(WEEK FROM current_date - 7) and ${start_date} between current_date - 400 and current_date - 30 and ${engaged_session} then ${session_id} else null end)/NULLIF(${visits_last_complete_week_last_year},0)::REAL ;;
    group_label: "Engagement Rate Reporting Measures"
  }

  measure: engagement_rate_lcw_ly_yoy {
    label: "LCW - LY%"
    type: number
    value_format_name: percent_0
    group_label: "Engagement Rate Reporting Measures"
    sql: (${engagement_rate_lcw} - ${engagement_rate_lcw_ly})/NULLIF(${engagement_rate_lcw_ly},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: engagement_rate_mtd {
    label: "MTD"
    type: number
    value_format_name: percent_1
    sql: count(distinct case when ${start_date} between date_trunc('month', current_date - 1) and current_date - 1 and ${engaged_session} then ${session_id} else null end)/NULLIF(${visits_month_to_date},0)::REAL ;;
    group_label: "Engagement Rate Reporting Measures"
    }

    measure: engagement_rate_mtd_lm {
    label: "MTD LM"
    type: number
    value_format_name: percent_1
    sql: count(distinct case when ${start_date} between date_trunc('month', add_months(current_date - 1, -1)) and add_months(current_date - 1, -1) and ${engaged_session} then ${session_id} else null end)/NULLIF(${visits_month_to_date_last_month},0)::REAL ;;
    group_label: "Engagement Rate Reporting Measures"
  }

  measure: engagement_rate_mtd_mom {
    label: "MTD MoM"
    type: number
    value_format_name: percent_0
    group_label: "Engagement Rate Reporting Measures"
    sql: (${engagement_rate_mtd} - ${engagement_rate_mtd_lm})/NULLIF(${engagement_rate_mtd_lm},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: engagement_rate_ytd {
    label: "YTD"
    type: number
    value_format_name: percent_1
    sql: count(distinct case when ${start_date} between date_trunc('year',current_date) and current_date-1 and ${engaged_session} then ${session_id} else null end)/NULLIF(${visits_year_to_date},0)::REAL ;;
    group_label: "Engagement Rate Reporting Measures"
  }

  measure: engagement_rate_ytd_ly {
    label: "YTD LY"
    type: number
    value_format_name: percent_1
    sql: count(distinct case when ${start_date} between date_trunc('year', add_months(current_date - 1, -12)) and add_months(current_date - 1, -12) and ${engaged_session} then ${session_id} else null end)/NULLIF(${visits_year_to_date_last_year},0)::REAL ;;
    group_label: "Engagement Rate Reporting Measures"
  }

  measure: engagement_rate_ytd_yoy {
    label: "YTD YoY"
    type: number
    value_format_name: percent_0
    group_label: "Engagement Rate Reporting Measures"
    sql: (${engagement_rate_ytd} - ${engagement_rate_ytd_ly})/NULLIF(${engagement_rate_ytd_ly},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: page_views_per_visit {
    label: "Actual"
    type: number
    value_format_name: decimal_2
    sql: sum(case when ${start_date} = current_date - 1 then ${distinct_pages_viewed} else 0 end)/NULLIF(${visits_yesterday},0)::REAL ;;
    group_label: "Page View Reporting Measures"
  }

  measure: page_views_per_visit_lw {
    label: "LW"
    type: number
    value_format_name: decimal_2
    sql: sum(case when ${start_date} = current_date - 8 then ${distinct_pages_viewed} else 0 end)/nullif(${visits_yesterday_last_week},0)::REAL  ;;
    group_label: "Page View Reporting Measures"
  }

  measure: page_views_per_visit_wow {
    label: "%"
    type: number
    value_format_name: percent_0
    group_label: "Page View Reporting Measures"
    sql: (${page_views_per_visit} - ${page_views_per_visit_lw})/NULLIF(${page_views_per_visit_lw},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: page_views_per_visit_last_7_days {
    label: "L7D"
    type: number
    value_format_name: decimal_2
    sql: sum(case when ${start_date} between current_date - 7 and current_date - 1 then ${distinct_pages_viewed} else 0 end)/nullif(${visits_last_7_days},0)::REAL ;;
    group_label: "Page View Reporting Measures"
  }

  measure: page_views_per_visit_last_7_days_percentage {
    label: "vs L7D"
    type: number
    value_format_name: percent_0
    group_label: "Page View Reporting Measures"
    sql: (${page_views_per_visit} - ${page_views_per_visit_last_7_days})/NULLIF(${page_views_per_visit_last_7_days},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: page_views_per_visit_lcw {
    label: "LCW"
    type: number
    value_format_name: decimal_2
    sql: sum(case when (((${start_date}) >= ((DATEADD(week,-1, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())) ))) AND ( ${start_date} ) < ((DATEADD(week,1, DATEADD(week,-1, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())))))))) then ${distinct_pages_viewed} else 0 end)/NULLIF(${visits_last_complete_week},0)::REAL ;;
    group_label: "Page View Reporting Measures"
  }

  measure: page_views_per_visit_pcw {
    label: "PCW"
    type: number
    value_format_name: decimal_2
    sql: sum(case when (((${start_date}) >= ((DATEADD(week,-2, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())) ))) AND ( ${start_date} ) < ((DATEADD(week,1, DATEADD(week,-2, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())))))))) then ${distinct_pages_viewed} else 0 end)/NULLIF(${visits_previous_complete_week},0)::REAL ;;
    group_label: "Page View Reporting Measures"
  }

  measure: page_views_per_visit_lcw_wow {
    label: "LCW %"
    type: number
    value_format_name: percent_0
    group_label: "Page View Reporting Measures"
    sql: (${page_views_per_visit_lcw} - ${page_views_per_visit_pcw})/NULLIF(${page_views_per_visit_pcw},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: page_views_per_visit_lcw_ly {
    label: "LCW - LY"
    type: number
    value_format_name: decimal_2
    sql: sum(case when ${start_week_of_year} = EXTRACT(WEEK FROM current_date - 7) and ${start_date} between current_date - 400 and current_date - 30 then ${distinct_pages_viewed} else 0 end)/NULLIF(${visits_last_complete_week_last_year},0)::REAL ;;
    group_label: "Page View Reporting Measures"
  }

  measure: page_views_per_visit_lcw_ly_yoy {
    label: "LCW - LY%"
    type: number
    value_format_name: percent_0
    group_label: "Page View Reporting Measures"
    sql: (${page_views_per_visit_lcw} - ${page_views_per_visit_lcw_ly})/NULLIF(${page_views_per_visit_lcw_ly},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: page_views_per_visit_mtd {
    label: "MTD"
    type: number
    value_format_name: decimal_2
    sql: sum(case when ${start_date} between date_trunc('month', current_date - 1) and current_date - 1 then ${distinct_pages_viewed} else 0 end)/NULLIF(${visits_month_to_date},0)::REAL ;;
    group_label: "Page View Reporting Measures"
  }

  measure: page_views_per_visit_mtd_lm {
    label: "MTD LM"
    type: number
    value_format_name: decimal_2
    sql: sum(case when ${start_date} between date_trunc('month', add_months(current_date - 1, -1)) and add_months(current_date - 1, -1) then ${distinct_pages_viewed} else 0 end)/NULLIF(${visits_month_to_date_last_month},0)::REAL ;;
    group_label: "Page View Reporting Measures"
  }

  measure: page_views_per_visit_mtd_mom {
    label: "MTD MoM"
    type: number
    value_format_name: percent_0
    group_label: "Page View Reporting Measures"
    sql: (${page_views_per_visit_mtd} - ${page_views_per_visit_mtd_lm})/NULLIF(${page_views_per_visit_mtd_lm},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: page_views_per_visit_ytd {
    label: "YTD"
    type: number
    value_format_name: decimal_2
    sql: sum(case when ${start_date} between date_trunc('year',current_date) and current_date-1 then ${distinct_pages_viewed} else 0 end)/NULLIF(${visits_year_to_date},0)::REAL ;;
    group_label: "Page View Reporting Measures"
  }

  measure: page_views_per_visit_ytd_ly {
    label: "YTD LY"
    type: number
    value_format_name: decimal_2
    sql: sum(case when ${start_date} between date_trunc('year', add_months(current_date - 1, -12)) and add_months(current_date - 1, -12) then ${distinct_pages_viewed} else 0 end)/NULLIF(${visits_year_to_date_last_year},0)::REAL ;;
    group_label: "Page View Reporting Measures"
  }

  measure: page_views_per_visit_ytd_yoy {
    label: "YTD YoY"
    type: number
    value_format_name: percent_0
    group_label: "Page View Reporting Measures"
    sql: (${page_views_per_visit_ytd} - ${page_views_per_visit_ytd_ly})/NULLIF(${page_views_per_visit_ytd_ly},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: product_views_per_visit {
    label: "Actual"
    type: number
    value_format_name: decimal_2
    sql: sum(case when ${start_date} = current_date - 1 then ${product_views} else 0 end)/NULLIF(${visits_yesterday},0)::REAL ;;
    group_label: "Product View Reporting Measures"
  }

  measure: product_views_per_visit_lw {
    label: "LW"
    type: number
    value_format_name: decimal_2
    sql: sum(case when ${start_date} = current_date - 8 then ${product_views} else 0 end)/nullif(${visits_yesterday_last_week},0)::REAL  ;;
    group_label: "Product View Reporting Measures"
  }

  measure: product_views_per_visit_wow {
    label: "%"
    type: number
    value_format_name: percent_0
    group_label: "Product View Reporting Measures"
    sql: (${product_views_per_visit} - ${product_views_per_visit_lw})/NULLIF(${product_views_per_visit_lw},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: product_views_per_visit_last_7_days {
    label: "L7D"
    type: number
    value_format_name: decimal_2
    sql: sum(case when ${start_date} between current_date - 7 and current_date - 1 then ${product_views} else 0 end)/nullif(${visits_last_7_days},0)::REAL ;;
    group_label: "Product View Reporting Measures"
  }

  measure: product_views_per_visit_last_7_days_percentage {
    label: "vs L7D"
    type: number
    value_format_name: percent_0
    group_label: "Product View Reporting Measures"
    sql: (${product_views_per_visit} - ${product_views_per_visit_last_7_days})/NULLIF(${product_views_per_visit_last_7_days},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: product_views_per_visit_lcw {
    label: "LCW"
    type: number
    value_format_name: decimal_2
    sql: sum(case when (((${start_date}) >= ((DATEADD(week,-1, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())) ))) AND ( ${start_date} ) < ((DATEADD(week,1, DATEADD(week,-1, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())))))))) then ${product_views} else 0 end)/NULLIF(${visits_last_complete_week},0)::REAL ;;
    group_label: "Product View Reporting Measures"
  }

  measure: product_views_per_visit_pcw {
    label: "PCW"
    type: number
    value_format_name: decimal_2
    sql: sum(case when (((${start_date}) >= ((DATEADD(week,-2, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())) ))) AND ( ${start_date} ) < ((DATEADD(week,1, DATEADD(week,-2, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())))))))) then ${product_views} else 0 end)/NULLIF(${visits_previous_complete_week},0)::REAL ;;
    group_label: "Product View Reporting Measures"
  }

  measure: product_views_per_visit_lcw_wow {
    label: "LCW %"
    type: number
    value_format_name: percent_0
    group_label: "Product View Reporting Measures"
    sql: (${product_views_per_visit_lcw} - ${product_views_per_visit_pcw})/NULLIF(${product_views_per_visit_pcw},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: product_views_per_visit_lcw_ly {
    label: "LCW - LY"
    type: number
    value_format_name: decimal_2
    sql: sum(case when ${start_week_of_year} = EXTRACT(WEEK FROM current_date - 7) and ${start_date} between current_date - 400 and current_date - 30 then ${product_views} else 0 end)/NULLIF(${visits_last_complete_week_last_year},0)::REAL ;;
    group_label: "Product View Reporting Measures"
  }

  measure: product_views_per_visit_lcw_ly_yoy {
    label: "LCW - LY%"
    type: number
    value_format_name: percent_0
    group_label: "Product View Reporting Measures"
    sql: (${product_views_per_visit_lcw} - ${product_views_per_visit_lcw_ly})/NULLIF(${product_views_per_visit_lcw_ly},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: product_views_per_visit_mtd {
    label: "MTD"
    type: number
    value_format_name: decimal_2
    sql: sum(case when ${start_date} between date_trunc('month', current_date - 1) and current_date - 1 then ${product_views} else 0 end)/NULLIF(${visits_month_to_date},0)::REAL ;;
    group_label: "Product View Reporting Measures"
  }

  measure: product_views_per_visit_mtd_lm {
    label: "MTD LM"
    type: number
    value_format_name: decimal_2
    sql: sum(case when ${start_date} between date_trunc('month', add_months(current_date - 1, -1)) and add_months(current_date - 1, -1) then ${product_views} else 0 end)/NULLIF(${visits_month_to_date_last_month},0)::REAL ;;
    group_label: "Product View Reporting Measures"
  }

  measure: product_views_per_visit_mtd_mom {
    label: "MTD MoM"
    type: number
    value_format_name: percent_0
    group_label: "Product View Reporting Measures"
    sql: (${product_views_per_visit_mtd} - ${product_views_per_visit_mtd_lm})/NULLIF(${product_views_per_visit_mtd_lm},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: product_views_per_visit_ytd {
    label: "YTD"
    type: number
    value_format_name: decimal_2
    sql: sum(case when ${start_date} between date_trunc('year',current_date) and current_date-1 then ${product_views} else 0 end)/NULLIF(${visits_year_to_date},0)::REAL ;;
    group_label: "Product View Reporting Measures"
  }

  measure: product_views_per_visit_ytd_ly {
    label: "YTD LY"
    type: number
    value_format_name: decimal_2
    sql: sum(case when ${start_date} between date_trunc('year', add_months(current_date - 1, -12)) and add_months(current_date - 1, -12) then ${product_views} else 0 end)/NULLIF(${visits_year_to_date_last_year},0)::REAL ;;
    group_label: "Product View Reporting Measures"
  }

  measure: product_views_per_visit_ytd_yoy {
    label: "YTD YoY"
    type: number
    value_format_name: percent_0
    group_label: "Product View Reporting Measures"
    sql: (${product_views_per_visit_ytd} - ${product_views_per_visit_ytd_ly})/NULLIF(${product_views_per_visit_ytd_ly},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: add_to_cart_rate {
    label: "Add To Cart Rate"
    type: number
    value_format_name: percent_1
    sql: count(distinct case when ${add_to_cart} then ${session_id} else null end)/NULLIF(${count},0)::REAL ;;
  }

  measure: cart_visits_yesterday {
    label: "Actual"
    type: number
    value_format_name: decimal_0
    sql: count(distinct case when ${start_date} = current_date - 1 and ${add_to_cart} then ${session_id} else null end)::REAL ;;
    group_label: "Cart Visits Reporting Measures"
    hidden: yes
  }

  measure: cart_visits_lw {
    label: "LW"
    type: number
    value_format_name: decimal_0
    sql: count(distinct case when ${start_date} = current_date - 8 and ${add_to_cart} then ${session_id} else null end)::REAL ;;
    group_label: "Cart Visits Reporting Measures"
    hidden: yes
  }

  measure: cart_visit_last_7_days {
    label: "L7D"
    type: number
    value_format_name: decimal_0
    sql: count(distinct case when ${start_date} between current_date - 7 and current_date - 1 and ${add_to_cart} then ${session_id} else null end)::REAL ;;
    group_label: "Cart Visits Reporting Measures"
    hidden: yes
  }

  measure: add_to_cart_rate_yesterday {
    label: "Actual"
    type: number
    value_format_name: percent_1
    sql: ${cart_visits_yesterday}/nullif(${visits_yesterday},0) ;;
    group_label: "Add To Cart Reporting Measures"
  }

  measure: add_to_cart_rate_lw {
    label: "LW"
    type: number
    value_format_name: percent_1
    sql: ${cart_visits_lw}/nullif(${visits_yesterday_last_week_k},0) ;;
    group_label: "Add To Cart Reporting Measures"
  }

  measure: add_to_cart_rate_wow {
    label: "%"
    type: number
    value_format_name: percent_0
    group_label: "Add To Cart Reporting Measures"
    sql: (${add_to_cart_rate_yesterday} - ${add_to_cart_rate_lw})/NULLIF(${add_to_cart_rate_lw},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: add_to_cart_rate_last_7_days {
    label: "L7D"
    type: number
    value_format_name: percent_1
    sql: ${cart_visit_last_7_days}/Nullif(${visits_last_7_days},0)::REAL ;;
    group_label: "Add To Cart Reporting Measures"
  }

  measure: add_to_cart_rate_last_7_days_percentage {
    label: "vs L7D"
    type: number
    value_format_name: percent_0
    group_label: "Add To Cart Reporting Measures"
    sql: (${add_to_cart_rate_yesterday} - ${add_to_cart_rate_last_7_days})/NULLIF(${add_to_cart_rate_last_7_days},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: add_to_cart_lcw {
    label: "LCW"
    type: number
    value_format_name: percent_1
    sql: count(distinct case when (((${start_date}) >= ((DATEADD(week,-1, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())) ))) AND ( ${start_date} ) < ((DATEADD(week,1, DATEADD(week,-1, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())))))))) and ${add_to_cart} then ${session_id} else null end)/NULLIF(${visits_last_complete_week},0)::REAL ;;
    group_label: "Add To Cart Reporting Measures"
  }

  measure: add_to_cart_pcw {
    label: "PCW"
    type: number
    value_format_name: percent_1
    sql: count(distinct case when (((${start_date}) >= ((DATEADD(week,-2, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())) ))) AND ( ${start_date} ) < ((DATEADD(week,1, DATEADD(week,-2, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())))))))) and ${add_to_cart} then ${session_id} else null end)/NULLIF(${visits_previous_complete_week},0)::REAL ;;
    group_label: "Add To Cart Reporting Measures"
  }

  measure: add_to_cart_lcw_wow {
    label: "LCW %"
    type: number
    value_format_name: percent_0
    group_label: "Add To Cart Reporting Measures"
    sql: (${add_to_cart_lcw} - ${add_to_cart_pcw})/NULLIF(${add_to_cart_pcw},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: add_to_cart_lcw_ly {
    label: "LCW - LY"
    type: number
    value_format_name: percent_1
    sql: count(distinct case when ${start_week_of_year} = EXTRACT(WEEK FROM current_date - 7) and ${start_date} between current_date - 400 and current_date - 30 and ${add_to_cart} then ${session_id} else null end)/NULLIF(${visits_last_complete_week_last_year},0)::REAL ;;
    group_label: "Add To Cart Reporting Measures"
  }

  measure: add_to_cart_lcw_ly_yoy {
    label: "LCW - LY%"
    type: number
    value_format_name: percent_0
    group_label: "Add To Cart Reporting Measures"
    sql: (${add_to_cart_lcw} - ${add_to_cart_lcw_ly})/NULLIF(${add_to_cart_lcw_ly},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: add_to_cart_mtd {
    label: "MTD"
    type: number
    value_format_name: percent_1
    sql: count(distinct case when ${start_date} between date_trunc('month', current_date - 1) and current_date - 1 and ${add_to_cart} then ${session_id} else null end)/NULLIF(${visits_month_to_date},0)::REAL ;;
    group_label: "Add To Cart Reporting Measures"
  }

  measure: add_to_cart_mtd_lm {
    label: "MTD LM"
    type: number
    value_format_name: percent_1
    sql: count(distinct case when ${start_date} between date_trunc('month', add_months(current_date - 1, -1)) and add_months(current_date - 1, -1) and ${add_to_cart} then ${session_id} else null end)/NULLIF(${visits_month_to_date_last_month},0)::REAL ;;
    group_label: "Add To Cart Reporting Measures"
  }

  measure: add_to_cart_mtd_mom {
    label: "MTD MoM"
    type: number
    value_format_name: percent_0
    group_label: "Add To Cart Reporting Measures"
    sql: (${add_to_cart_mtd} - ${add_to_cart_mtd_lm})/NULLIF(${add_to_cart_mtd_lm},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: add_to_cart_ytd {
    label: "YTD"
    type: number
    value_format_name: percent_1
    sql: count(distinct case when ${start_date} between date_trunc('year',current_date) and current_date-1 and ${add_to_cart} then ${session_id} else null end)/NULLIF(${visits_year_to_date},0)::REAL ;;
    group_label: "Add To Cart Reporting Measures"
  }

  measure: add_to_cart_ytd_ly {
    label: "YTD LY"
    type: number
    value_format_name: percent_1
    sql: count(distinct case when ${start_date} between date_trunc('year', add_months(current_date - 1, -12)) and add_months(current_date - 1, -12) and ${add_to_cart} then ${session_id} else null end)/NULLIF(${visits_year_to_date_last_year},0)::REAL ;;
    group_label: "Add To Cart Reporting Measures"
  }

  measure: add_to_cart_ytd_yoy {
    label: "YTD YoY"
    type: number
    value_format_name: percent_0
    group_label: "Add To Cart Reporting Measures"
    sql: (${add_to_cart_ytd} - ${add_to_cart_ytd_ly})/NULLIF(${add_to_cart_ytd_ly},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }


  measure: sum_product_views_yesterday {
    label: "Actual"
    type: sum
    sql: case when ${start_date} = current_date - 1 then ${product_views} else 0 end ;;
    group_label: "Product Views Reporting Measures"
    hidden: yes
  }

  measure: sum_product_views_lw {
    label: "LW"
    type: sum
    sql: case when ${start_date} = current_date - 8 then ${product_views} else 0 end ;;
    group_label: "Product Views Reporting Measures"
    hidden: yes
  }

  measure: sum_product_views_l7d {
    label: "L7D"
    type: sum
    sql: case when ${start_date} between current_date - 7 and current_date - 1 then ${product_views} else 0 end ;;
    group_label: "Product Views Reporting Measures"
    hidden: yes
  }

  measure: sum_product_views_l14d {
    label: "L14D"
    type: sum
    sql: case when ${start_date} between current_date - 14 and current_date - 1 then ${product_views} else 0 end ;;
    group_label: "Product Views Reporting Measures"
    hidden: yes
  }

  measure: sum_product_views_lcw {
    label: "LCW"
    type: sum
    sql:  case when (((${start_date}) >= ((DATEADD(week,-1, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())) ))) AND ( ${start_date} ) < ((DATEADD(week,1, DATEADD(week,-1, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())))))))) then ${product_views} else 0 end ;;
    group_label: "Product Views Reporting Measures"
  }

  measure: sum_product_views_pcw {
    label: "PCW"
    type: sum
    sql:  case when (((${start_date}) >= ((DATEADD(week,-2, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())) ))) AND ( ${start_date} ) < ((DATEADD(week,1, DATEADD(week,-2, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())))))))) then ${product_views} else 0 end ;;
    group_label: "Product Views Reporting Measures"
  }

  measure: sum_product_views_lcw_wow {
    label: "LCW %"
    type: number
    value_format_name: percent_0
    group_label: "Product Views Reporting Measures"
    sql: (${sum_product_views_lcw} - ${sum_product_views_pcw})/NULLIF(${sum_product_views_pcw},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: sum_product_views_lcw_ly {
    label: "LCW - LY"
    type: sum
    sql:  case when ${start_week_of_year} = EXTRACT(WEEK FROM current_date - 7) and ${start_date} between current_date - 400 and current_date - 30 then ${product_views} else 0 end ;;
    group_label: "Product Views Reporting Measures"
  }

  measure: sum_product_views_lcw_ly_yoy {
    label: "LCW - LY%"
    type: number
    value_format_name: percent_0
    group_label: "Product Views Reporting Measures"
    sql: (${sum_product_views_lcw} - ${sum_product_views_lcw_ly})/NULLIF(${sum_product_views_lcw_ly},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: sum_product_views_mtd {
    label: "MTD"
    type: sum
    sql:  case when ${start_date} between date_trunc('month', current_date - 1) and current_date - 1 then ${product_views} else 0 end ;;
    group_label: "Product Views Reporting Measures"
  }

  measure: sum_product_views_mtd_lm {
    label: "MTD LM"
    type: sum
    sql:  case when ${start_date} between date_trunc('month', add_months(current_date - 1, -1)) and add_months(current_date - 1, -1) then ${product_views} else 0 end ;;
    group_label: "Product Views Reporting Measures"
  }

  measure: sum_product_views_mtd_mom {
    label: "MTD MoM"
    type: number
    value_format_name: percent_0
    group_label: "Product Views Reporting Measures"
    sql: (${sum_product_views_mtd} - ${sum_product_views_mtd_lm})/NULLIF(${sum_product_views_mtd_lm},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: sum_product_views_ytd {
    label: "YTD"
    type: sum
    sql:  case when ${start_date} between date_trunc('year',current_date) and current_date-1 then ${product_views} else 0 end ;;
    group_label: "Product Views Reporting Measures"
  }

  measure: sum_product_views_ytd_ly {
    label: "YTD LY"
    type: sum
    sql:  case when ${start_date} between date_trunc('year', add_months(current_date - 1, -12)) and add_months(current_date - 1, -12) then ${product_views} else 0 end ;;
    group_label: "Product Views Reporting Measures"
  }

  measure: sum_product_views_ytd_yoy {
    label: "YTD YoY"
    type: number
    value_format_name: percent_0
    group_label: "Product Views Reporting Measures"
    sql: (${sum_product_views_ytd} - ${sum_product_views_ytd_ly})/NULLIF(${sum_product_views_ytd_ly},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: sum_products_add_to_cart_yesterday {
    label: "Actual"
    type: sum
    sql: case when ${start_date} = current_date - 1 then ${products_added_to_cart} else 0 end ;;
    group_label: "Product Count Added To Cart Reporting Measures"
    hidden: yes
  }

  measure: sum_products_add_to_cart_lw {
    label: "LW"
    type: sum
    sql: case when ${start_date} = current_date - 8 then ${products_added_to_cart} else 0 end ;;
    group_label: "Product Count Added To Cart Reporting Measures"
    hidden: yes
  }

  measure: sum_products_add_to_cart_l7d {
    label: "L7D"
    type: sum
    sql: case when ${start_date} between current_date - 7 and current_date - 1 then ${products_added_to_cart} else 0 end ;;
    group_label: "Product Count Added To Cart Reporting Measures"
    hidden: yes
  }

  measure: sum_products_add_to_cart_l14d {
    label: "L14D"
    type: sum
    sql: case when ${start_date} between current_date - 14 and current_date - 1 then ${products_added_to_cart} else 0 end ;;
    group_label: "Product Count Added To Cart Reporting Measures"
    hidden: yes
  }

  measure: sum_products_add_to_cart_lcw {
    label: "LCW"
    type: sum
    sql:  case when (((${start_date}) >= ((DATEADD(week,-1, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())) ))) AND ( ${start_date} ) < ((DATEADD(week,1, DATEADD(week,-1, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())))))))) then ${products_added_to_cart} else 0 end ;;
    group_label: "Product Count Added To Cart Reporting Measures"
  }

  measure: sum_products_add_to_cart_pcw {
    label: "PCW"
    type: sum
    sql:  case when (((${start_date}) >= ((DATEADD(week,-2, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())) ))) AND ( ${start_date} ) < ((DATEADD(week,1, DATEADD(week,-2, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())))))))) then ${products_added_to_cart} else 0 end ;;
    group_label: "Product Count Added To Cart Reporting Measures"
  }

  measure: sum_products_add_to_cart_lcw_wow {
    label: "LCW %"
    type: number
    value_format_name: percent_0
    group_label: "Product Count Added To Cart Reporting Measures"
    sql: (${sum_products_add_to_cart_lcw} - ${sum_products_add_to_cart_pcw})/NULLIF(${sum_products_add_to_cart_pcw},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: sum_products_add_to_cart_lcw_ly {
    label: "LCW - LY"
    type: sum
    sql:  case when ${start_week_of_year} = EXTRACT(WEEK FROM current_date - 7) and ${start_date} between current_date - 400 and current_date - 30 then ${products_added_to_cart} else 0 end ;;
    group_label: "Product Count Added To Cart Reporting Measures"
  }

  measure: sum_products_add_to_cart_lcw_ly_yoy {
    label: "LCW - LY%"
    type: number
    value_format_name: percent_0
    group_label: "Product Count Added To Cart Reporting Measures"
    sql: (${sum_products_add_to_cart_lcw} - ${sum_products_add_to_cart_lcw_ly})/NULLIF(${sum_products_add_to_cart_lcw_ly},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: sum_products_add_to_cart_mtd {
    label: "MTD"
    type: sum
    sql:  case when ${start_date} between date_trunc('month', current_date - 1) and current_date - 1 then ${products_added_to_cart} else 0 end ;;
    group_label: "Product Count Added To Cart Reporting Measures"
  }

  measure: sum_products_add_to_cart_mtd_lm {
    label: "MTD LM"
    type: sum
    sql:  case when ${start_date} between date_trunc('month', add_months(current_date - 1, -1)) and add_months(current_date - 1, -1) then ${products_added_to_cart} else 0 end ;;
    group_label: "Product Count Added To Cart Reporting Measures"
  }

  measure: sum_products_add_to_cart_mtd_mom {
    label: "MTD MoM"
    type: number
    value_format_name: percent_0
    group_label: "Product Count Added To Cart Reporting Measures"
    sql: (${sum_products_add_to_cart_mtd} - ${sum_products_add_to_cart_mtd_lm})/NULLIF(${sum_products_add_to_cart_mtd_lm},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: sum_products_add_to_cart_ytd {
    label: "YTD"
    type: sum
    sql:  case when ${start_date} between date_trunc('year',current_date) and current_date-1 then ${products_added_to_cart} else 0 end ;;
    group_label: "Product Count Added To Cart Reporting Measures"
  }

  measure: sum_products_add_to_cart_ytd_ly {
    label: "YTD LY"
    type: sum
    sql:  case when ${start_date} between date_trunc('year', add_months(current_date - 1, -12)) and add_months(current_date - 1, -12) then ${products_added_to_cart} else 0 end ;;
    group_label: "Product Count Added To Cart Reporting Measures"
  }

  measure: sum_products_add_to_cart_ytd_yoy {
    label: "YTD YoY"
    type: number
    value_format_name: percent_0
    group_label: "Product Count Added To Cart Reporting Measures"
    sql: (${sum_products_add_to_cart_ytd} - ${sum_products_add_to_cart_ytd_ly})/NULLIF(${sum_products_add_to_cart_ytd_ly},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }


  measure: product_add_to_cart_rate_yesterday {
    label: "Actual"
    type: number
    value_format_name: percent_2
    sql: ${sum_products_add_to_cart_yesterday}/NULLIF(${sum_product_views_yesterday},0)::REAL ;;
    group_label: "Product Add To Cart Rate Reporting Measures"
  }

  measure: product_add_to_cart_rate_lw {
    label: "LW"
    type: number
    value_format_name: percent_2
    sql: ${sum_products_add_to_cart_lw}/NULLIF(${sum_product_views_lw},0)::REAL ;;
    group_label: "Product Add To Cart Rate Reporting Measures"
  }

  measure: product_add_to_cart_rate_wow {
    label: "%"
    type: number
    value_format_name: percent_0
    group_label: "Product Add To Cart Rate Reporting Measures"
    sql: (${product_add_to_cart_rate_yesterday} - ${product_add_to_cart_rate_lw})/NULLIF(${product_add_to_cart_rate_lw},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: product_add_to_cart_rate_l7d {
    label: "L7D"
    type: number
    value_format_name: percent_2
    sql: ${sum_products_add_to_cart_l7d}/NULLIF(${sum_product_views_l7d},0)::REAL ;;
    group_label: "Product Add To Cart Rate Reporting Measures"
  }

  measure: product_add_to_cart_rate_l7d_percentage {
    label: "vs L7D"
    type: number
    value_format_name: percent_0
    group_label: "Product Add To Cart Rate Reporting Measures"
    sql: (${product_add_to_cart_rate_yesterday} - ${product_add_to_cart_rate_l7d})/NULLIF(${product_add_to_cart_rate_l7d},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: product_add_to_cart_rate_l14d {
    label: "L14D"
    type: number
    value_format_name: percent_2
    sql: ${sum_products_add_to_cart_l14d}/NULLIF(${sum_product_views_l14d},0)::REAL ;;
    group_label: "Product Add To Cart Rate Reporting Measures"
  }

  measure: product_add_to_cart_rate_lcw {
    label: "LCW"
    type: number
    value_format_name: percent_2
    sql: ${sum_products_add_to_cart_lcw}/NULLIF(${sum_product_views_lcw},0)::REAL ;;
    group_label: "Product Add To Cart Rate Reporting Measures"
  }

  measure: product_add_to_cart_rate_pcw {
    label: "PCW"
    type: number
    value_format_name: percent_2
    sql: ${sum_products_add_to_cart_pcw}/NULLIF(${sum_product_views_pcw},0)::REAL ;;
    group_label: "Product Add To Cart Rate Reporting Measures"
  }

  measure: product_add_to_cart_rate_lcw_wow {
    label: "LCW %"
    type: number
    value_format_name: percent_0
    group_label: "Product Add To Cart Rate Reporting Measures"
    sql: (${product_add_to_cart_rate_lcw} - ${product_add_to_cart_rate_pcw})/NULLIF(${product_add_to_cart_rate_pcw},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: product_add_to_cart_rate_lcw_ly {
    label: "LCW - LY"
    type: number
    value_format_name: percent_2
    sql: ${sum_products_add_to_cart_lcw_ly}/NULLIF(${sum_product_views_lcw_ly},0)::REAL ;;
    group_label: "Product Add To Cart Rate Reporting Measures"
  }

  measure: product_add_to_cart_rate_lcw_yoy {
    label: "LCW - LY%"
    type: number
    value_format_name: percent_0
    group_label: "Product Add To Cart Rate Reporting Measures"
    sql: (${product_add_to_cart_rate_lcw} - ${product_add_to_cart_rate_lcw_ly})/NULLIF(${product_add_to_cart_rate_lcw_ly},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: product_add_to_cart_rate_mtd {
    label: "MTD"
    type: number
    value_format_name: percent_2
    sql: ${sum_products_add_to_cart_mtd}/NULLIF(${sum_product_views_mtd},0)::REAL ;;
    group_label: "Product Add To Cart Rate Reporting Measures"
  }

  measure: product_add_to_cart_rate_mtd_lm {
    label: "MTD LM"
    type: number
    value_format_name: percent_2
    sql: ${sum_products_add_to_cart_mtd_lm}/NULLIF(${sum_product_views_mtd_lm},0)::REAL ;;
    group_label: "Product Add To Cart Rate Reporting Measures"
  }

  measure: product_add_to_cart_rate_mtd_mom {
    label: "MTD MoM"
    type: number
    value_format_name: percent_0
    group_label: "Product Add To Cart Rate Reporting Measures"
    sql: (${product_add_to_cart_rate_mtd} - ${product_add_to_cart_rate_mtd_lm})/NULLIF(${product_add_to_cart_rate_mtd_lm},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: product_add_to_cart_rate_ytd {
    label: "YTD"
    type: number
    value_format_name: percent_2
    sql: ${sum_products_add_to_cart_ytd}/NULLIF(${sum_product_views_ytd},0)::REAL ;;
    group_label: "Product Add To Cart Rate Reporting Measures"
  }

  measure: product_add_to_cart_rate_ytd_ly {
    label: "YTD LY"
    type: number
    value_format_name: percent_2
    sql: ${sum_products_add_to_cart_ytd_ly}/NULLIF(${sum_product_views_ytd_ly},0)::REAL ;;
    group_label: "Product Add To Cart Rate Reporting Measures"
  }

  measure: product_add_to_cart_rate_ytd_yoy {
    label: "YTD YoY"
    type: number
    value_format_name: percent_0
    group_label: "Product Add To Cart Rate Reporting Measures"
    sql: (${product_add_to_cart_rate_ytd} - ${product_add_to_cart_rate_ytd_ly})/NULLIF(${product_add_to_cart_rate_ytd_ly},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: sum_products_purchased_yesterday {
    label: "Actual"
    type: sum
    sql: case when ${start_date} = current_date - 1 then ${products_purchased} else 0 end ;;
    group_label: "Products Purchased Reporting Measures"
    hidden: yes
  }

  measure: sum_products_purchased_lw {
    label: "LW"
    type: sum
    sql: case when ${start_date} = current_date - 8 then ${products_purchased} else 0 end ;;
    group_label: "Products Purchased Reporting Measures"
    hidden: yes
  }

  measure: sum_products_purchased_l7d {
    label: "L7D"
    type: sum
    sql: case when ${start_date} between current_date - 7 and current_date -1 then ${products_purchased} else 0 end ;;
    group_label: "Products Purchased Reporting Measures"
    hidden: yes
  }

  measure: sum_products_purchased_l14d {
    label: "L14D"
    type: sum
    sql: case when ${start_date} between current_date - 14 and current_date -1 then ${products_purchased} else 0 end ;;
    group_label: "Products Purchased Reporting Measures"
    hidden: yes
  }

  measure: sum_products_purchased_lcw {
    label: "LCW"
    type: sum
    sql:  case when (((${start_date}) >= ((DATEADD(week,-1, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())) ))) AND ( ${start_date} ) < ((DATEADD(week,1, DATEADD(week,-1, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())))))))) then ${products_purchased} else 0 end ;;
    group_label: "Products Purchased Reporting Measures"
  }

  measure: sum_products_purchased_pcw {
    label: "PCW"
    type: sum
    sql:  case when (((${start_date}) >= ((DATEADD(week,-2, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())) ))) AND ( ${start_date} ) < ((DATEADD(week,1, DATEADD(week,-2, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())))))))) then ${products_purchased} else 0 end ;;
    group_label: "Products Purchased Reporting Measures"
  }

  measure: sum_products_purchased_lcw_wow {
    label: "LCW %"
    type: number
    value_format_name: percent_0
    group_label: "Products Purchased Reporting Measures"
    sql: (${sum_products_purchased_lcw} - ${sum_products_purchased_pcw})/NULLIF(${sum_products_purchased_pcw},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: sum_products_purchased_lcw_ly {
    label: "LCW - LY"
    type: sum
    sql:  case when ${start_week_of_year} = EXTRACT(WEEK FROM current_date - 7) and ${start_date} between current_date - 400 and current_date - 30 then ${products_purchased} else 0 end ;;
    group_label: "Products Purchased Reporting Measures"
  }

  measure: sum_products_purchased_lcw_ly_yoy {
    label: "LCW - LY%"
    type: number
    value_format_name: percent_0
    group_label: "Products Purchased Reporting Measures"
    sql: (${sum_products_purchased_lcw} - ${sum_products_purchased_lcw_ly})/NULLIF(${sum_products_purchased_lcw_ly},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: sum_products_purchased_mtd {
    label: "MTD"
    type: sum
    sql:  case when ${start_date} between date_trunc('month', current_date - 1) and current_date - 1 then ${products_purchased} else 0 end ;;
    group_label: "Products Purchased Reporting Measures"
  }

  measure: sum_products_purchased_mtd_lm {
    label: "MTD LM"
    type: sum
    sql:  case when ${start_date} between date_trunc('month', add_months(current_date - 1, -1)) and add_months(current_date - 1, -1) then ${products_purchased} else 0 end ;;
    group_label: "Products Purchased Reporting Measures"
  }

  measure: sum_products_purchased_mtd_mom {
    label: "MTD MoM"
    type: number
    value_format_name: percent_0
    group_label: "Products Purchased Reporting Measures"
    sql: (${sum_products_purchased_mtd} - ${sum_products_purchased_mtd_lm})/NULLIF(${sum_products_purchased_mtd_lm},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: sum_products_purchased_ytd {
    label: "YTD"
    type: sum
    sql:  case when ${start_date} between date_trunc('year',current_date) and current_date-1 then ${products_purchased} else 0 end ;;
    group_label: "Products Purchased Reporting Measures"
  }

  measure: sum_products_purchased_ytd_ly {
    label: "YTD LY"
    type: sum
    sql:  case when ${start_date} between date_trunc('year', add_months(current_date - 1, -12)) and add_months(current_date - 1, -12) then ${products_purchased} else 0 end ;;
    group_label: "Products Purchased Reporting Measures"
  }

  measure: sum_products_purchased_ytd_yoy {
    label: "YTD YoY"
    type: number
    value_format_name: percent_0
    group_label: "Products Purchased Reporting Measures"
    sql: (${sum_products_purchased_ytd} - ${sum_products_purchased_ytd_ly})/NULLIF(${sum_products_purchased_ytd_ly},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: product_conversion_rate_yesterday {
    label: "Actual"
    type: number
    value_format_name: percent_2
    sql: ${sum_products_purchased_yesterday}/NULLIF(${sum_product_views_yesterday},0)::REAL ;;
    group_label: "Product Conversion Rate Reporting Measures"
  }

  measure: product_conversion_rate_lw {
    label: "LW"
    type: number
    value_format_name: percent_2
    sql: ${sum_products_purchased_lw}/NULLIF(${sum_product_views_lw},0)::REAL ;;
    group_label: "Product Conversion Rate Reporting Measures"
  }

  measure: product_conversion_rate_wow {
    label: "%"
    type: number
    value_format_name: percent_0
    group_label: "Product Conversion Rate Reporting Measures"
    sql: (${product_conversion_rate_yesterday} - ${product_conversion_rate_lw})/NULLIF(${product_conversion_rate_lw},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: product_conversion_rate_l7d {
    label: "L7D"
    type: number
    value_format_name: percent_2
    sql: ${sum_products_purchased_l7d}/NULLIF(${sum_product_views_l7d},0)::REAL ;;
    group_label: "Product Conversion Rate Reporting Measures"
  }

  measure: product_conversion_l7d_percentage {
    label: "vs L7D"
    type: number
    value_format_name: percent_0
    group_label: "Product Conversion Rate Reporting Measures"
    sql: (${product_conversion_rate_yesterday} - ${product_conversion_rate_l7d})/NULLIF(${product_conversion_rate_l7d},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: product_conversion_rate_l14d {
    label: "L14D"
    type: number
    value_format_name: percent_2
    sql: ${sum_products_purchased_l14d}/NULLIF(${sum_product_views_l14d},0)::REAL ;;
    group_label: "Product Conversion Rate Reporting Measures"
  }

  measure: product_conversion_rate_lcw {
    label: "LCW"
    type: number
    value_format_name: percent_2
    sql: ${sum_products_purchased_lcw}/NULLIF(${sum_product_views_lcw},0)::REAL ;;
    group_label: "Product Conversion Rate Reporting Measures"
  }

  measure: product_conversion_rate_pcw {
    label: "PCW"
    type: number
    value_format_name: percent_2
    sql: ${sum_products_purchased_pcw}/NULLIF(${sum_product_views_pcw},0)::REAL ;;
    group_label: "Product Conversion Rate Reporting Measures"
  }

  measure: product_conversion_lcw_wow {
    label: "LCW %"
    type: number
    value_format_name: percent_0
    group_label: "Product Conversion Rate Reporting Measures"
    sql: (${product_conversion_rate_lcw} - ${product_conversion_rate_pcw})/NULLIF(${product_conversion_rate_pcw},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: product_conversion_rate_lcw_ly {
    label: "LCW - LY"
    type: number
    value_format_name: percent_2
    sql: ${sum_products_purchased_lcw_ly}/NULLIF(${sum_product_views_lcw_ly},0)::REAL ;;
    group_label: "Product Conversion Rate Reporting Measures"
  }

  measure: product_conversion_lcw_yoy {
    label: "LCW - LY%"
    type: number
    value_format_name: percent_0
    group_label: "Product Conversion Rate Reporting Measures"
    sql: (${product_conversion_rate_lcw} - ${product_conversion_rate_lcw_ly})/NULLIF(${product_conversion_rate_lcw_ly},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: product_conversion_rate_mtd {
    label: "MTD"
    type: number
    value_format_name: percent_2
    sql: ${sum_products_purchased_mtd}/NULLIF(${sum_product_views_mtd},0)::REAL ;;
    group_label: "Product Conversion Rate Reporting Measures"
  }

  measure: product_conversion_rate_mtd_lm {
    label: "MTD LM"
    type: number
    value_format_name: percent_2
    sql: ${sum_products_purchased_mtd_lm}/NULLIF(${sum_product_views_mtd_lm},0)::REAL ;;
    group_label: "Product Conversion Rate Reporting Measures"
  }

  measure: product_conversion_mtd_mom {
    label: "MTD MoM"
    type: number
    value_format_name: percent_0
    group_label: "Product Conversion Rate Reporting Measures"
    sql: (${product_conversion_rate_mtd} - ${product_conversion_rate_mtd_lm})/NULLIF(${product_conversion_rate_mtd_lm},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: product_conversion_rate_ytd {
    label: "YTD"
    type: number
    value_format_name: percent_2
    sql: ${sum_products_purchased_ytd}/NULLIF(${sum_product_views_ytd},0)::REAL ;;
    group_label: "Product Conversion Rate Reporting Measures"
  }

  measure: product_conversion_rate_ytd_ly {
    label: "YTD LY"
    type: number
    value_format_name: percent_2
    sql: ${sum_products_purchased_ytd_ly}/NULLIF(${sum_product_views_ytd_ly},0)::REAL ;;
    group_label: "Product Conversion Rate Reporting Measures"
  }

  measure: product_conversion_ytd_yoy {
    label: "YTD YoY"
    type: number
    value_format_name: percent_0
    group_label: "Product Conversion Rate Reporting Measures"
    sql: (${product_conversion_rate_ytd} - ${product_conversion_rate_ytd_ly})/NULLIF(${product_conversion_rate_ytd_ly},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: number_of_converted_customers_yesterday {
    label: "Actual"
    type: number
    value_format_name: decimal_0
    sql: count(distinct case when ${start_date} = current_date - 1 and ${orders}>0 then ${session_id} else null end)::REAL  ;;
    group_label: "Converted Customers"
    hidden: yes
  }

  measure: number_of_converted_customers_lw {
    label: "LW"
    type: number
    value_format_name: decimal_0
    sql: count(distinct case when ${start_date} = current_date - 8 and ${orders}>0 then ${session_id} else null end)::REAL  ;;
    group_label: "Converted Customers"
    hidden: yes
  }

  measure: number_of_converted_customers_l7d {
    label: "L7D"
    type: number
    value_format_name: decimal_0
    sql: count(distinct case when ${start_date} between current_date - 7 and current_date - 1  and ${orders}>0 then ${session_id} else null end)::REAL  ;;
    group_label: "Converted Customers"
    hidden: yes
  }

  measure: number_of_converted_customers_lcw {
    label: "LCW"
    type: number
    value_format_name: decimal_0
    sql: count(distinct case when (((${start_date}) >= ((DATEADD(week,-1, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())) ))) AND ( ${start_date} ) < ((DATEADD(week,1, DATEADD(week,-1, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())))))))) and ${orders}>0 then ${session_id} else null end)::REAL  ;;
    group_label: "Converted Customers"
    hidden: yes
  }

  measure: number_of_converted_customers_pcw {
    label: "PCW"
    type: number
    value_format_name: decimal_0
    sql: count(distinct case when (((${start_date}) >= ((DATEADD(week,-2, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())) ))) AND ( ${start_date} ) < ((DATEADD(week,1, DATEADD(week,-2, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())))))))) and ${orders}>0 then ${session_id} else null end)::REAL  ;;
    group_label: "Converted Customers"
    hidden: yes
  }

  measure: count_distinct_sessions_yesterday {
    label: "Actual"
    type: count_distinct
    value_format_name: decimal_0
    sql: case when ${start_date} = current_date - 1 then ${session_id} else null end ;;
    group_label: "Count Distinct Sessions"
    hidden: yes
  }

  measure: count_distinct_sessions_LW {
    label: "LW"
    type: count_distinct
    value_format_name: decimal_0
    sql: case when ${start_date} = current_date - 8 then ${session_id} else null end ;;
    group_label: "Count Distinct Sessions"
    hidden: yes
  }

  measure: count_distinct_sessions_l7d {
    label: "L7D"
    type: count_distinct
    value_format_name: decimal_0
    sql: case when ${start_date} between current_date - 7 and current_date - 1 then ${session_id} else null end ;;
    group_label: "Count Distinct Sessions"
    hidden: yes
  }

  measure: count_distinct_sessions_lcw {
    label: "LCW"
    type: count_distinct
    value_format_name: decimal_0
    sql: case when (((${start_date}) >= ((DATEADD(week,-1, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())) ))) AND ( ${start_date} ) < ((DATEADD(week,1, DATEADD(week,-1, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())))))))) then ${session_id} else null end  ;;
    group_label: "Count Distinct Sessions"
    hidden: yes
  }

  measure: count_distinct_sessions_pcw {
    label: "PCW"
    type: count_distinct
    value_format_name: decimal_0
    sql: case when (((${start_date}) >= ((DATEADD(week,-2, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())) ))) AND ( ${start_date} ) < ((DATEADD(week,1, DATEADD(week,-2, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())))))))) then ${session_id} else null end  ;;
    group_label: "Count Distinct Sessions"
    hidden: yes
  }

  measure: distinct_conversion_rate_yesterday {
    label: "Actual"
    type: number
    value_format_name: percent_1
    sql: ${number_of_converted_customers_yesterday}/NULLIF(${count_distinct_sessions_yesterday},0) ;;
    group_label: "Distinct Conversion Rate"
  }

  measure: distinct_conversion_rate_lw {
    label: "LW"
    type: number
    value_format_name: percent_1
    sql: ${number_of_converted_customers_lw}/NULLIF(${count_distinct_sessions_LW},0);;
    group_label: "Distinct Conversion Rate"
  }

  measure: distinct_conversion_rate_wow {
    label: "%"
    type: number
    value_format_name: percent_0
    group_label: "Distinct Conversion Rate"
    sql: (${distinct_conversion_rate_yesterday} - ${distinct_conversion_rate_lw})/NULLIF(${distinct_conversion_rate_lw},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: distinct_conversion_rate_l7d {
    label: "L7D"
    type: number
    value_format_name: percent_1
    sql: ${number_of_converted_customers_l7d}/NULLIF(${count_distinct_sessions_l7d},0);;
    group_label: "Distinct Conversion Rate"
  }

  measure:distinct_conversion_rate_l7d_percentage {
    label: "vs L7D"
    type: number
    value_format_name: percent_0
    group_label: "Distinct Conversion Rate"
    sql: (${distinct_conversion_rate_yesterday} - ${distinct_conversion_rate_l7d})/NULLIF(${distinct_conversion_rate_l7d},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: distinct_conversion_rate_lcw {
    label: "LCW"
    type: number
    value_format_name: percent_1
    sql: ${number_of_converted_customers_lcw}/NULLIF(${count_distinct_sessions_lcw},0);;
    group_label: "Distinct Conversion Rate"
  }

  measure: distinct_conversion_rate_pcw {
    label: "PCW"
    type: number
    value_format_name: percent_1
    sql: ${number_of_converted_customers_pcw}/NULLIF(${count_distinct_sessions_pcw},0);;
    group_label: "Distinct Conversion Rate"
  }

  measure:distinct_conversion_rate_lcw_percentage {
    label: "LCW %"
    type: number
    value_format_name: percent_0
    group_label: "Distinct Conversion Rate"
    sql: (${distinct_conversion_rate_lcw} - ${distinct_conversion_rate_pcw})/NULLIF(${distinct_conversion_rate_pcw},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: gross_revenue_ex_discount_yesterday {
    label: "Actual"
    type: sum
    value_format_name: pounds
    group_label: "Gross Revenue Ex. Discount Reporting Measures"
    sql:  case when ${start_date} = current_date - 1 then ${gross_revenue_ex_discount} else 0 end ;;
  }

  measure: gross_revenue_ex_discount_lw {
    label: "LW"
    type: sum
    value_format_name: pounds
    group_label: "Gross Revenue Ex. Discount Reporting Measures"
    sql:  case when ${start_date} = current_date - 8 then ${gross_revenue_ex_discount} else 0 end ;;
  }

  measure: gross_revenue_ex_discount_wow {
    label: "%"
    type: number
    value_format_name: percent_0
    group_label: "Gross Revenue Ex. Discount Reporting Measures"
    sql: (${gross_revenue_ex_discount_yesterday} - ${gross_revenue_ex_discount_lw})/NULLIF(${gross_revenue_ex_discount_lw},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: gross_revenue_ex_discount_yesterday_last_year {
    label: "LY"
    type: sum
    sql: case when ${start_date} = (select calendar_date from finery.calendar where week_number = (select week_number from finery.calendar where calendar_date = current_date - 1) and dow = (select dow from finery.calendar where calendar_date = current_date - 1) and year = (select year - 1 from finery.calendar where calendar_date = current_date - 1)) then ${gross_revenue_ex_discount} else 0 end ;;
    value_format_name: pounds
    group_label: "Gross Revenue Ex. Discount Reporting Measures"
  }

  measure: gross_revenue_ex_discount_last_complete_week_last_year {
    label: "LCW - LY"
    type:  number
    sql: sum(case when ${start_week_of_year} = EXTRACT(WEEK FROM current_date - 7) and ${start_date} between current_date - 400 and current_date - 30 then ${gross_revenue_ex_discount} else 0 end);;
    group_label: "Gross Revenue Ex. Discount Reporting Measures"
    value_format_name: pounds_k
  }

  measure: gross_revenue_ex_discount_yesterday_yoy {
    label: "YoY"
    type: number
    value_format_name: percent_0
    group_label: "Gross Revenue Ex. Discount Reporting Measures"
    sql: (${gross_revenue_ex_discount_yesterday} - ${gross_revenue_ex_discount_yesterday_last_year})/NULLIF(${gross_revenue_ex_discount_yesterday_last_year},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: gross_revenue_ex_discount_last_complete_week_last_year_yoy {
    label: "LCW - LY%"
    type: number
    value_format_name: percent_0
    group_label: "Gross Revenue Ex. Discount Reporting Measures"
    sql: (${gross_revenue_ex_discount_last_complete_week} - ${gross_revenue_ex_discount_last_complete_week_last_year})/NULLIF(${gross_revenue_ex_discount_last_complete_week_last_year},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: gross_revenue_ex_discount_last_complete_week {
    label: "LCW"
    type: sum
    sql: case when (((${start_date}) >= ((DATEADD(week,-1, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())) ))) AND ( ${start_date} ) < ((DATEADD(week,1, DATEADD(week,-1, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())))))))) then ${gross_revenue_ex_discount} else 0 end ;;
    value_format_name: pounds_k
    group_label: "Gross Revenue Ex. Discount Reporting Measures"
  }

  measure: gross_revenue_ex_discount_previous_complete_week {
    label: "PCW"
    type:  sum
    sql: case when (((${start_date}) >= ((DATEADD(week,-2, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())) ))) AND (${start_date}) < ((DATEADD(week,1, DATEADD(week,-2, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())) ) ))))) then ${gross_revenue_ex_discount} else 0 end ;;
    value_format_name: pounds_k
    group_label: "Gross Revenue Ex. Discount Reporting Measures"
  }

  measure: gross_revenue_ex_discount_last_complete_week_wow {
    label: "LCW %"
    type: number
    value_format_name: percent_0
    group_label: "Gross Revenue Ex. Discount Reporting Measures"
    sql: (${gross_revenue_ex_discount_last_complete_week} - ${gross_revenue_ex_discount_previous_complete_week})/NULLIF(${gross_revenue_ex_discount_previous_complete_week},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: gross_revenue_ex_discount_month_to_date {
    label: "MTD"
    type: sum
    sql: case when ${start_date} between date_trunc('month', current_date - 1) and current_date - 1 then ${gross_revenue_ex_discount} else 0 end ;;
    value_format_name: pounds_k
    group_label: "Gross Revenue Ex. Discount Reporting Measures"
  }

  measure: gross_revenue_ex_discount_month_to_date_last_month {
    label: "MTD LM"
    type: sum
    sql: case when ${start_date} between date_trunc('month', add_months(current_date - 1, -1)) and add_months(current_date - 1, -1) then ${gross_revenue_ex_discount} else 0 end ;;
    value_format_name: pounds_k
    group_label: "Gross Revenue Ex. Discount Reporting Measures"
  }

  measure: gross_revenue_ex_discount_month_to_date_mom {
    label: "MTD MoM"
    type: number
    value_format_name: percent_0
    group_label: "Gross Revenue Ex. Discount Reporting Measures"
    sql: (${gross_revenue_ex_discount_month_to_date} - ${gross_revenue_ex_discount_month_to_date_last_month})/NULLIF(${gross_revenue_ex_discount_month_to_date_last_month},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: gross_revenue_ex_discount_month_to_date_last_year {
    label: "MTD LY"
    type: sum
    sql: case when ${start_date} between date_trunc('month', add_months(current_date - 1, -12)) and add_months(current_date - 1, -12) then ${gross_revenue_ex_discount} else 0 end ;;
    value_format_name: pounds_k
    group_label: "Gross Revenue Ex. Discount Reporting Measures"
  }

  measure: gross_revenue_ex_discount_month_to_date_yoy {
    label: "MTD YoY"
    type: number
    value_format_name: percent_0
    group_label: "Gross Revenue Ex. Discount Reporting Measures"
    sql: (${gross_revenue_ex_discount_month_to_date} - ${gross_revenue_ex_discount_month_to_date_last_year})/NULLIF(${gross_revenue_ex_discount_month_to_date_last_year},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: gross_revenue_ex_discount_year_to_date {
    label: "YTD"
    type: sum
    sql: case when ${start_date} between date_trunc('year', current_date - 1) and current_date - 1 then ${gross_revenue_ex_discount} else 0 end ;;
    value_format_name:  pounds_k
    group_label: "Gross Revenue Ex. Discount Reporting Measures"
  }

  measure: gross_revenue_ex_discount_year_to_date_last_year {
    label: "YTD LY"
    type: sum
    sql: case when ${start_date} between date_trunc('year', add_months(current_date - 1, -12)) and add_months(current_date - 1, -12) then ${gross_revenue_ex_discount} else 0 end ;;
    value_format_name: pounds_k
    group_label: "Gross Revenue Ex. Discount Reporting Measures"
  }

  measure: gross_revenue_ex_discount_year_to_date_yoy {
    label: "YTD YoY"
    type: number
    value_format_name: percent_0
    group_label: "Gross Revenue Ex. Discount Reporting Measures"
    sql: (${gross_revenue_ex_discount_year_to_date} - ${gross_revenue_ex_discount_year_to_date_last_year})/NULLIF(${gross_revenue_ex_discount_year_to_date_last_year},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: average_basket_ex_discount_yesterday {
    label: "Actual"
    type: number
    value_format_name: pounds
    group_label: "Average Basket Ex. Discount Reporting Measures"
    sql:  ${gross_revenue_ex_discount_yesterday}/NULLIF(${orders_yesterday},0)::REAL ;;
  }

  measure: average_basket_ex_discount_lw {
    label: "LW"
    type: number
    value_format_name: pounds
    group_label: "Average Basket Ex. Discount Reporting Measures"
    sql:  ${gross_revenue_ex_discount_lw}/NULLIF(${orders_yesterday_last_week},0)::REAL ;;
  }

  measure: average_basket_ex_discount_year_to_date_yoy {
    label: "%"
    type: number
    value_format_name: percent_0
    group_label: "Average Basket Ex. Discount Reporting Measures"
    sql: (${average_basket_ex_discount_yesterday} - ${average_basket_ex_discount_lw})/NULLIF(${average_basket_ex_discount_lw},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: average_basket_ex_discount_yesterday_last_year {
    label: "LY"
    type: number
    sql: ${gross_revenue_ex_discount_yesterday_last_year}/NULLIF(${orders_yesterday_last_year},0)::REAL ;;
    value_format_name: pounds
    group_label: "Average Basket Ex. Discount Reporting Measures"
  }

  measure: average_basket_ex_discount_last_complete_week_last_year {
    label: "LCW - LY"
    type: number
    sql: ${gross_revenue_ex_discount_last_complete_week_last_year}/NULLIF(${orders_last_complete_week_last_year},0)::REAL ;;
    value_format_name: pounds
    group_label: "Average Basket Ex. Discount Reporting Measures"
  }

  measure: average_basket_ex_discount_yesterday_yoy {
    label: "YoY"
    type: number
    value_format_name: percent_0
    group_label: "Average Basket Ex. Discount Reporting Measures"
    sql: (${average_basket_ex_discount_yesterday} - ${average_basket_ex_discount_yesterday_last_year})/NULLIF(${average_basket_ex_discount_yesterday_last_year},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: average_basket_ex_discount_last_complete_week_last_year_yoy {
    label: "LCW - LY%"
    type: number
    value_format_name: percent_0
    group_label: "Average Basket Ex. Discount Reporting Measures"
    sql: (${average_basket_ex_discount_last_complete_week} - ${average_basket_ex_discount_last_complete_week_last_year})/NULLIF(${average_basket_ex_discount_last_complete_week_last_year},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: average_basket_ex_discount_month_to_date {
    label: "MTD"
    type: number
    sql: ${gross_revenue_ex_discount_month_to_date}/NULLIF(${orders_month_to_date},0)::REAL ;;
    value_format_name: pounds
    group_label: "Average Basket Ex. Discount Reporting Measures"
  }

  measure: average_basket_ex_discount_month_to_date_last_month {
    label: "MTD LM"
    type: number
    sql: ${gross_revenue_ex_discount_month_to_date_last_month}/NULLIF(${orders_month_to_date_last_month},0)::REAL ;;
    value_format_name: pounds
    group_label: "Average Basket Ex. Discount Reporting Measures"
  }

  measure: average_basket_ex_discount_month_to_date_mom {
    label: "MTD MoM"
    type: number
    value_format_name: percent_0
    group_label: "Average Basket Ex. Discount Reporting Measures"
    sql: (${average_basket_ex_discount_month_to_date} - ${average_basket_ex_discount_month_to_date_last_month})/NULLIF(${average_basket_ex_discount_month_to_date_last_month},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: average_basket_ex_discount_month_to_date_last_year {
    label: "MTD LY"
    type: number
    sql: ${gross_revenue_ex_discount_month_to_date_last_year}/NULLIF(${orders_month_to_date_last_year},0)::REAL ;;
    value_format_name: pounds
    group_label: "Average Basket Ex. Discount Reporting Measures"
  }

  measure: avereage_basket_ex_discount_month_to_date_yoy {
    label: "MTD YoY"
    type: number
    value_format_name: percent_0
    group_label: "Average Basket Ex. Discount Reporting Measures"
    sql: (${average_basket_ex_discount_month_to_date} - ${average_basket_ex_discount_month_to_date_last_year})/NULLIF(${average_basket_ex_discount_month_to_date_last_year},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: average_basket_ex_discount_last_complete_week {
    label: "LCW"
    type: number
    sql: ${gross_revenue_ex_discount_last_complete_week}/nullif(${orders_last_complete_week},0)::REAL ;;
    value_format_name: pounds
    group_label: "Average Basket Ex. Discount Reporting Measures"
  }

  measure: average_basket_ex_discount_previous_complete_week {
    label: "PCW"
    type:  number
    sql: ${gross_revenue_ex_discount_previous_complete_week}/nullif(${orders_previous_complete_week},0)::REAL ;;
    value_format_name: pounds
    group_label: "Average Basket Ex. Discount Reporting Measures"
  }

  measure: average_basket_ex_discount_last_complete_week_wow {
    label: "LCW %"
    type: number
    value_format_name: percent_0
    group_label: "Average Basket Ex. Discount Reporting Measures"
    sql: (${average_basket_ex_discount_last_complete_week} - ${average_basket_ex_discount_previous_complete_week})/NULLIF(${average_basket_ex_discount_previous_complete_week},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: average_basket_ex_discount_year_to_date {
    label: "YTD"
    type: number
    sql: ${gross_revenue_ex_discount_year_to_date}/NULLIF(${orders_year_to_date},0)::REAL ;;
    value_format_name:  pounds
    group_label: "Average Basket Ex. Discount Reporting Measures"
  }

  measure: average_basket_ex_discount_year_to_date_last_year {
    label: "YTD LY"
    type: number
    sql: ${gross_revenue_ex_discount_year_to_date_last_year}/NULLIF(${orders_year_to_date_last_year},0)::REAL ;;
    value_format_name: pounds
    group_label: "Average Basket Ex. Discount Reporting Measures"
  }

  measure: average_basket_ex_discount_year_to_date_yoy_2 {
    label: "YTD YoY"
    type: number
    value_format_name: percent_0
    group_label: "Average Basket Ex. Discount Reporting Measures"
    sql: (${average_basket_ex_discount_year_to_date} - ${average_basket_ex_discount_year_to_date_last_year})/NULLIF(${average_basket_ex_discount_year_to_date_last_year},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }





}
