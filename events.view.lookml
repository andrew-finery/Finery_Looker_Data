- view: events
  derived_table:
    sql: |
      SELECT
      domain_userid, 
      domain_sessionidx,
      event_id,
      event,
      collector_tstamp,
      dvce_tstamp,
      page_title,
      page_urlscheme,
      page_urlhost,
      page_urlpath,
      page_urlport,
      page_urlquery,
      page_urlfragment,
      refr_medium,
      refr_source,
      refr_term,
      refr_urlhost,
      refr_urlpath,
      pp_xoffset_max,
      pp_xoffset_min,
      pp_yoffset_max,
      pp_yoffset_min,
      se_category,
      se_action,
      se_label,
      se_property,
      se_value,
      doc_height,
      doc_width,
      l.root_id AS link_click_event_id,
      l.element_id AS link_click_element_id,
      l.element_classes AS link_click_element_classes,
      l.element_target AS link_click_element_target,
      l.target_url AS link_click_target_url,
      w.root_id AS web_page_event_id,
      w.breadcrumb AS web_page_breadcrumb,
      w.genre AS web_page_genre,
      w.author AS web_page_author,
      w.date_created AS web_page_date_created,
      w.date_modified AS web_page_date_modified,
      w.date_published AS web_page_date_published,
      w.in_language AS web_page_in_language,
      sfs.name AS sfs_name,
      sfs.email AS sfs_email,
      sfs.company AS sfs_company,
      sfs.events_per_month AS sfs_events_per_month,
      sfs.service_type AS sfs_service_type,
      tfs.name AS tfs_name,
      tfs.email AS tfs_email,
      tfs.company AS tfs_company,
      tfs.events_per_month AS tfs_events_per_month
      FROM atomic.events e
      LEFT JOIN atomic.org_schema_web_page_1 w
      ON e.event_id = w.root_id
      LEFT JOIN atomic.com_snowplowanalytics_snowplow_link_click_1 l
      ON e.event_id = l.root_id
      LEFT JOIN atomic.com_snowplowanalytics_snowplow_website_signup_form_submitted_1 sfs
      ON e.event_id = sfs.root_id
      LEFT JOIN atomic.com_snowplowanalytics_snowplow_website_trial_form_submitted_1 tfs
      ON e.event_id = tfs.root_id
      WHERE domain_userid IS NOT NULL
    
    sql_trigger_value: SELECT MAX(collector_tstamp) FROM atomic.events
    distkey: domain_userid
    sortkeys: [domain_userid, domain_sessionidx, collector_tstamp]
    
  fields:
  # DIMENSIONS #
  
  - dimension: event_id
    primary_key: true
    sql: ${TABLE}.event_id
  
  - dimension: event_type
    sql: ${TABLE}.event
    
  - dimension: timestamp
    sql: ${TABLE}.collector_tstamp

  - dimension_group: timestamp
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.collector_tstamp

  - dimension: session_index
    type: number
    sql: ${TABLE}.domain_sessionidx

  - dimension: user_id
    sql: ${TABLE}.domain_userid

  - dimension: session_id
    sql: ${TABLE}.domain_userid || '-' || ${TABLE}.domain_sessionidx

  - dimension_group: device_timestamp
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.dvce_tstamp
    hidden: true

  - dimension: page_title
    sql: ${TABLE}.page_title

  - dimension: page_url_scheme
    sql: ${TABLE}.page_urlscheme

  - dimension: page_url_host
    sql: ${TABLE}.page_urlhost
      
  - dimension: page_url_path
    sql: ${TABLE}.page_urlpath

  - dimension: page_url_port
    type: int
    sql: ${TABLE}.page_urlport
    hidden: true

  - dimension: page_url_query
    sql: ${TABLE}.page_urlquery
    hidden: true

  - dimension: page_url_fragment
    sql: ${TABLE}.page_urlfragment
    hidden: true
    
  - dimension: refr_medium
    sql: ${TABLE}.refr_medium
    
  - dimension: first_event_in_session
    type: yesno
    sql: ${TABLE}.refr_medium != 'internal'
    
  - dimension: first_event_for_visitor
    type: yesno
    sql: ${TABLE}.refr_medium != 'internal' AND ${TABLE}.domain_sessionidx = 1
    
  - dimension: refr_source
    sql: ${TABLE}.refr_source
    
  - dimension: refr_term
    sql: ${TABLE}.refr_term
    
  - dimension: refr_url_host
    sql: ${TABLE}.refr_urlhost
    
  - dimension: refr_url_path
    sql: ${TABLE}.refr_urlpath

  - dimension: x_offset
    type: int
    sql: ${TABLE}.pp_xoffset_max

  - dimension: pp_xoffset_min
    type: int
    sql: ${TABLE}.pp_xoffset_min
    hidden: true

  - dimension: y_offset
    type: int
    sql: ${TABLE}.pp_yoffset_max

  - dimension: pp_yoffset_min
    type: int
    sql: ${TABLE}.pp_yoffset_min
    hidden: true

  - dimension: structured_event_action
    sql: ${TABLE}.se_action

  - dimension: structured_event_category
    sql: ${TABLE}.se_category

  - dimension: structured_event_label
    sql: ${TABLE}.se_label

  - dimension: structured_event_property
    sql: ${TABLE}.se_property

  - dimension: structured_event_value
    type: number
    sql: ${TABLE}.se_value
    
  - dimension: user_agent
    sql: ${TABLE}.useragent
    hidden: true
    
  - dimension: page_height
    type: int
    sql: ${TABLE}.doc_height
    
  - dimension: page_width
    type: int
    sql: ${TABLE}.doc_width
    
  # Link click dimensions #
  - dimension: is_click_event
    type: yesno
    sql: ${TABLE}.link_click_id IS NOT NULL

  - dimension: link_id
    sql: ${TABLE}.link_click_element_id

  - dimension: link_classes
    sql: ${TABLE}.link_click_element_classes

  - dimension: link_target
    sql: ${TABLE}.link_click_element_target

  - dimension: target_url
    sql: ${TABLE}.link_click_target_url  
    
  # schema.org web page dimensions #
  - dimension: has_schema_org_dimensions
    type: yesno
    sql: ${TABLE}.web_page_event_id IS NOT NULL
  
  - dimension: bread_crumb
    sql: ${TABLE}.breadcrumb

  - dimension: genre
    sql: ${TABLE}.genre

  - dimension: author
    sql: ${TABLE}.web_page_author

  - dimension: date_created
    sql: ${TABLE}.date_created

  - dimension_group: date_created
    type: time
    timeframes: [time, hour, date, week, month]
    sql: ${TABLE}.date_created

  - dimension: date_modified
    sql: ${TABLE}.date_modified

  - dimension_group: date_modified
    type: time
    timeframes: [time, hour, date, week, month]
    sql: ${TABLE}.date_modified

  - dimension: date_published
    sql: ${TABLE}.date_published

  - dimension_group: date_published
    type: time
    timeframes: [time, hour, date, week, month]
    sql: ${TABLE}.date_published

  - dimension: in_language
    sql: ${TABLE}.in_language
    
  # Trial and signup form submitted fields
  - dimension: name
    sql: NVL(${TABLE}.sfs_name , ${TABLE}.tfs_name)
    
  - dimension: email
    sql: NVL(${TABLE}.sfs_email , ${TABLE}.tfs_email)
    
  - dimension: company
    sql: NVL(${TABLE}.sfs_company , ${TABLE}.tfs_company)
    
  - dimension: events_per_month
    sql: NVL(${TABLE}.sfs_events_per_month , ${TABLE}.tfs_events_per_month)
    
  - dimension: service_type
    sql: ${TABLE}.sfs_service_type
    
  # Conversion events
  - dimension: product_funnel_1_viewed_product_page
    type: yesno
    sql: ${TABLE}.page_urlpath LIKE '%product%'
    
  - dimension: product_funnel_2_viewed_get_started_page
    type: yesno
    sql: ${TABLE}.page_urlpath LIKE '%product/get-started.html%'
    
  - dimension: product_funnel_3a_viewed_trial_form
    type: yesno
    sql: ${TABLE}.page_urlpath LIKE '%product/free-trial.html%'
    
  - dimension: product_funnel_4a_submitted_trial_form
    type: yesno
    sql: ${TABLE}.tfs_email IS NOT NULL 
    
  - dimension: product_funnel_3b_viewed_signup_form
    type: yesno
    sql: ${TABLE}.page_urlpath LIKE '%product/sign-up-for-snowplow-as-a-service.html%'
    
  - dimension: product_funnel_4b_submitted_signup_form
    type: yesno
    sql: ${TABLE}.sfs_email IS NOT NULL
    
  - dimension: product_funnel_3_viewed_trial_form_or_signup_form
    type: yesno
    sql: ${product_funnel_3a_viewed_trial_form} OR ${product_funnel_3b_viewed_signup_form}
    
  - dimension: product_funnel_4_submitted_signup_or_trial_form
    type: yesno
    sql: ${product_funnel_4a_submitted_trial_form} OR ${product_funnel_4b_submitted_signup_form}

# MEASURES #
  
  # Basic measures

  - measure: count
    type: count
    detail: events_detail*

  - measure: page_pings_count
    type: count
    detail: events_detail*
    filters:
      event_type: page_ping
      
  - measure: page_views_count
    type: count
    detail: page_views_detail*
    filters:
      event_type: page_view

  - measure: distinct_pages_viewed_count
    type: count_distinct
    detail: page_views_detail*
    sql: ${page_url_path}
    
  - measure: sessions_count
    type: count_distinct
    sql: ${session_id}
    detail: sessions_detail*
    
  - measure: page_pings_per_session
    type: number
    decimals: 2
    sql: NULLIF(${page_pings_count},0)/NULLIF(${sessions_count},0)::REAL

  - measure: page_pings_per_visitor
    type: number
    decimals: 2
    sql: NULLIF(${page_pings_count},0)/NULLIF(${visitors_count},0)::REAL

  - measure: visitors_count
    type: count_distinct
    sql: ${user_id}
    detail: visitors_detail
    hidden: true  # Not to be shown in the UI (in UI only show visitors count for visitors table)
    
  - measure: events_per_session
    type: number
    decimals: 2
    sql: ${count}/NULLIF(${sessions_count},0)::REAL
    
  - measure: events_per_visitor
    type: number
    decimals: 2
    sql: ${count}/NULLIF(${visitors_count},0)::REAL

  - measure: page_views_per_sessions
    type: number
    decimals: 2
    sql: ${page_views_count}/NULLIF(${sessions_count},0)::REAL
    
  - measure: page_views_per_visitor
    type: number
    decimals: 2
    sql: ${page_views_count}/NULLIF(${visitors_count},0)::REAL
  
  - measure: landing_page_views_count
    type: count
    filters:
      event_type: page_view
      first_event_in_session: yes
    
  - measure: internal_page_views_count
    type: count
    filters: 
      event_type: page_view
      first_event_in_session: no
      
  - measure: approx_user_usage_in_minutes
    type: number
    decimals: 2
    sql: APPROXIMATE COUNT( DISTINCT CONCAT(FLOOR(EXTRACT (EPOCH FROM ${TABLE}.collector_tstamp)/10), ${TABLE}.domain_userid) ) /6
    
  - measure: approx_usage_per_visitor_in_minutes
    type: number
    decimals: 2
    sql: ${approx_user_usage_in_minutes}/NULLIF(${visitors_count}, 0)::REAL
    
  - measure: approx_usage_per_visit_in_minutes
    type: number
    decimals: 2
    sql: ${approx_user_usage_in_minutes}/NULLIF(${sessions_count}, 0)::REAL


  # Conversion measures
  - measure: product_funnel_1_viewed_product_page_session_count
    type: count_distinct
    sql: ${session_id}
    detail: sessions_detail*
    filters:
      product_funnel_1_viewed_product_page: yes
  
  - measure: product_funnel_2_viewed_get_started_page_count
    type: count_distinct
    sql: ${session_id}
    detail: sessions_detail*
    filters:
      product_funnel_2_viewed_get_started_page: yes
      
  - measure: product_funnel_3_viewed_trial_form_or_signup_form_session_count
    type: count_distinct
    sql: ${session_id}
    detail: sessions_detail*
    filters:
      product_funnel_3_viewed_trial_form_or_signup_form: yes

  - measure: product_funnel_3a_viewed_trial_form_session_count
    type: count_distinct
    sql: ${session_id}
    detail: sessions_detail*
    filters:
      product_funnel_3a_viewed_trial_form: yes
      
  - measure: product_funnel_3b_viewed_signup_form_session_count
    type: count_distinct
    sql: ${session_id}
    detail: sessions_detail*
    filters:
      product_funnel_3b_viewed_signup_form: yes

  - measure: product_funnel_4_submitted_signup_or_trial_form_session_count
    type: count_distinct
    sql: ${session_id}
    detail: sessions_detail*
    filters:
      product_funnel_4_submitted_signup_or_trial_form: yes
      
  - measure: product_funnel_4a_submitted_trial_form_session_count
    type: count_distinct
    sql: ${session_id}
    detail: sessions_detail*
    filters:
      product_funnel_4a_submitted_trial_form: yes
      
  - measure: product_funnel_4b_submitted_signup_form_session_count
    type: count_distinct
    sql: ${session_id}
    detail: sessions_detail*
    filters:
      product_funnel_4b_submitted_signup_form: yes
      
  - measure: form_submissions_count
    type: count
    detail: form_submits_detail*
    filters:
      product_funnel_4b_submitted_signup_form: yes
  
  
  # ----- Detail ------
  sets:
    form_submits_detail:
      - session_index
      - sessions.start_time
      - sessions.referer_url_host
      - sessions.referer_url_path
      - sessions.landing_page_path
      - timestamp_time
      - name
      - email
      - company_name
      - events_per_month
      - service_type
  
    events_detail:
      - session_index
      - event_type
      - timestamp_time
      - device_timestamp
      - page_url_host
      - page_url_path
      - name
      - email
    
    page_views_detail:
      - page_url_host
      - page_url_path
      - timestamp_time
      - device_timestamp
    
    sessions_detail:
      - user_id
      - session_index
      - sessions.start_time
      - sessions.referer_url_host
      - sessions.referer_url_path
      - sessions.landing_page_path
      - sessions.session_duration_seconds
      - count
      - sessions.distinct_pages_viewed
      - sessions.event_stream 
      
    visitors_detail:
      - user_id
      - visitors.first_touch_time
      - source_first_visit.refr_url_host
      - source_first_visit.refr_url_path
      - landing_page_first_visit.page_url_path
      - visitors.last_touch_time
      - visitors.lifetime_sessions
      - visitors.visit_history
      - visitors.lifetime_distinct_pages_viewed
      - visitors.lifetime_events
      - visitors.event_history
      - visitors.history