- view: atomic_events
  derived_table:
    sql: |
      SELECT
          a.app_id,
          a.platform,
          a.etl_tstamp,
          a.collector_tstamp,
          a.dvce_tstamp,
          a.event,
          a.event_id,
          a.txn_id,
          a.name_tracker,
          a.v_tracker,
          a.v_collector,
          a.v_etl,
          a.user_id,
          a.user_ipaddress,
          a.user_fingerprint,
          a.domain_userid,
          a.domain_sessionidx,
          a.network_userid,
          a.geo_country,
          a.geo_region,
          a.geo_city,
          a.geo_zipcode,
          a.geo_latitude,
          a.geo_longitude,
          a.geo_region_name,
          a.ip_isp,
          a.ip_organization,
          a.ip_domain,
          a.ip_netspeed,
          a.page_url,
          a.page_title,
          a.page_referrer,
          a.page_urlscheme,
          a.page_urlhost,
          a.page_urlport,
          a.page_urlpath,
          a.page_urlquery,
          a.page_urlfragment,
          a.refr_urlscheme,
          a.refr_urlhost,
          a.refr_urlport,
          a.refr_urlpath,
          a.refr_urlquery,
          a.refr_urlfragment,
          a.refr_medium,
          a.refr_source,
          a.refr_term,
          a.mkt_medium,
          a.mkt_source,
          a.mkt_term,
          a.mkt_content,
          a.mkt_campaign,
          a.contexts,
          a.se_category,
          a.se_action,
          a.se_label,
          a.se_property,
          a.se_value,
          a.unstruct_event,
          a.tr_orderid,
          a.tr_affiliation,
          a.tr_total,
          a.tr_tax,
          a.tr_shipping,
          a.tr_city,
          a.tr_state,
          a.tr_country,
          a.ti_orderid,
          a.ti_sku,
          a.ti_name,
          a.ti_category,
          a.ti_price,
          a.ti_quantity,
          a.pp_xoffset_min,
          a.pp_xoffset_max,
          a.pp_yoffset_min,
          a.pp_yoffset_max,
          a.useragent,
          a.br_name,
          a.br_family,
          a.br_version,
          a.br_type,
          a.br_renderengine,
          a.br_lang,
          a.br_features_pdf,
          a.br_features_flash,
          a.br_features_java,
          a.br_features_director,
          a.br_features_quicktime,
          a.br_features_realplayer,
          a.br_features_windowsmedia,
          a.br_features_gears,
          a.br_features_silverlight,
          a.br_cookies,
          a.br_colordepth,
          a.br_viewwidth,
          a.br_viewheight,
          a.os_name,
          a.os_family,
          a.os_manufacturer,
          a.os_timezone,
          a.dvce_type,
          a.dvce_ismobile,
          a.dvce_screenwidth,
          a.dvce_screenheight,
          a.doc_charset,
          a.doc_width,
          a.doc_height,
          b.root_id as root_id_trans,
          c.root_id as root_id_reg
          
          from atomic.events a
          
          left join atomic.com_finerylondon_transaction_1 b
          on a.event_id = b.root_id
          
          left join atomic.com_finerylondon_registration_success_1 c
          on a.event_id = c.root_id
          
          where a.app_id = 'production'
          
    sql_trigger_value: SELECT MAX(collector_tstamp) FROM atomic.events
    distkey: event_id
    sortkeys: [domain_userid, domain_sessionidx, collector_tstamp]
    
  fields:
  # DIMENSIONS #
  
  - dimension: event_id
    primary_key: true
    sql: ${TABLE}.event_id
  
  - dimension: event_id_trans
    sql: ${TABLE}.root_id_trans

  - dimension: event_id_reg
    sql: ${TABLE}.root_id_reg
  
  - dimension_group: event_time
    type: time
    timeframes: [time, hour, date, hod, dow, week, month]
    sql: ${TABLE}.collector_tstamp
  
  - dimension: event_time_tier
    type: tier
    tiers: [0,8,12,16,20]
    sql: ${event_time_hod}
    
  - dimension: domain_userid
    sql: ${TABLE}.domain_userid
  
  - dimension: domain_sessionidx
    sql: ${TABLE}.domain_sessionidx
  
  - dimension: session_id
    sql: ${TABLE}.domain_userid || '-' || ${TABLE}.domain_sessionidx
  
  - measure: count_orders
    type: count_distinct
    sql: ${event_id_trans}
  
  - measure: count_signups
    type: count_distinct
    sql: ${event_id_reg}
  
  - measure: count_sessions
    type: count_distinct
    sql: ${session_id}
    
  - measure: latest_update
    type: string
    sql: max(${event_time_time})
    


    