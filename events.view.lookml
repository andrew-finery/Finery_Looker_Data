- view: events
  derived_table:
    sql: |
      SELECT
      domain_userid, 
      domain_sessionidx,
      event_id,
      event,
      convert_timezone('UTC', 'Europe/London', collector_tstamp) as collector_tstamp,
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
      l.target_url AS link_click_target_url
      FROM atomic.events e
      LEFT JOIN atomic.com_snowplowanalytics_snowplow_link_click_1 l
      ON e.event_id = l.root_id
      WHERE e.domain_userid IS NOT NULL
      AND e.app_id = 'production'
    
#    sql_trigger_value: SELECT MAX(collector_tstamp) FROM atomic.events
#    distkey: domain_userid
#    sortkeys: [domain_userid, domain_sessionidx, collector_tstamp]
    
  fields:
  
    ##############################################################################################################################################################################################
  ##########################################################################  DIMENSIONS  ######################################################################################################
##############################################################################################################################################################################################

  - dimension: event_id
    primary_key: true
    sql: ${TABLE}.event_id
  
  - dimension: event_type
    sql: ${TABLE}.event
    
  - dimension_group: timestamp
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.collector_tstamp

  - dimension: session_index
    type: number
    sql: ${TABLE}.domain_sessionidx

  - dimension: domain_userid
    sql: ${TABLE}.domain_userid

  - dimension: session_id
    sql: ${TABLE}.domain_userid || '-' || ${TABLE}.domain_sessionidx

  - dimension: blended_user_id
    sql: ${identity_stitching.blended_user_id}

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

  # Link click dimensions #
  - dimension: is_click_event
    type: yesno
    sql: ${TABLE}.link_click_event_id IS NOT NULL

  - dimension: link_id
    sql: ${TABLE}.link_click_element_id

  - dimension: link_classes
    sql: ${TABLE}.link_click_element_classes

  - dimension: link_target
    sql: ${TABLE}.link_click_element_target

  - dimension: target_url
    sql: ${TABLE}.link_click_target_url  
    
  
##############################################################################################################################################################################################
  ##########################################################################  MEASURES  ########################################################################################################
    ##############################################################################################################################################################################################
  
  - measure: page_views_count
    type: count
    filters:
      event_type: page_view

  - measure: distinct_pages_viewed_count
    type: count_distinct
    sql: ${page_url_path}
  
  - measure: links_clicked
    type: count_distinct
    sql: ${event_id}
    filters:
      is_click_event: yes
    
  - measure: sessions_count
    type: count_distinct
    sql: ${session_id}

  - measure: devices_count
    type: count_distinct
    sql: ${domain_userid}

  - measure: visitors_count
    type: count_distinct
    sql: ${blended_user_id}

  - measure: new_visitors_count
    type: count_distinct
    sql: ${blended_user_id}
    filters:
      session_index: 1

  - measure: approx_total_usage_time_minutes
    type: number
    decimals: 2
    sql: APPROXIMATE COUNT( DISTINCT CONCAT(FLOOR(EXTRACT (EPOCH FROM ${TABLE}.collector_tstamp)/10), ${TABLE}.domain_userid) ) /6    

    
######## Per Session Measures

  - measure: page_views_per_session
    type: number
    decimals: 2
    sql: ${page_views_count}/NULLIF(${sessions_count},0)::REAL
    
  - measure: approx_usage_per_visit_in_minutes
    type: number
    decimals: 2
    sql: ${approx_total_usage_time_minutes}/NULLIF(${sessions_count}, 0)::REAL    


######### Per Visitor Measures

  - measure: page_views_per_visitor
    type: number
    decimals: 2
    sql: ${page_views_count}/NULLIF(${visitors_count},0)::REAL
    
  - measure: approx_usage_per_visitor_in_minutes
    type: number
    decimals: 2
    sql: ${approx_total_usage_time_minutes}/NULLIF(${visitors_count}, 0)::REAL

  - measure: engagement_time_per_visitor
    type: string
    sql: floor(${approx_usage_per_visitor_in_minutes}) || ':' || right(cast('00' as varchar) || cast(((${approx_usage_per_visitor_in_minutes} - floor(${approx_usage_per_visitor_in_minutes})) * 60) as integer), 2)

