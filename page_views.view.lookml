- view: page_views
  derived_table:
    sql: |
      SELECT
      
      domain_userid,
      domain_sessionidx,
      event_id,
      
      br_name,
      br_family,
      br_version,
      br_type,
      br_renderengine,
      br_lang,
      br_features_director,
      br_features_flash,
      br_features_gears,
      br_features_java,
      br_features_pdf,
      br_features_quicktime,
      br_features_realplayer,
      br_features_silverlight,
      br_features_windowsmedia,
      br_cookies,
      os_name,
      os_family,
      os_manufacturer,
      os_timezone,
      dvce_type,
      dvce_ismobile,
      dvce_screenwidth,
      dvce_screenheight,
      
      page_urlhost,
      page_urlpath,
      page_url,
      
      case when (page_urlpath like '%clothing%') then 2
            when (page_urlpath like '%products%') then 3
            when (page_urlpath like '%cart%') then 4
            when (page_urlpath like '%checkout/address%') then 5
            when (page_urlpath like '%checkout/delivery%') then 6
            when (page_urlpath like '%checkout/payment%') then 7
            when (page_urlpath like '%orders%') then 8
      else 1 end as site_progress,
      
      case when (page_urlpath like '%clothing%') then '2 - Category Page'
            when (page_urlpath like '%products%') then '3 - Product Page'
            when (page_urlpath like '%cart%') then '4 - View Cart'
            when (page_urlpath like '%checkout/address%') then '5 - Checkout - Enter Address'
            when (page_urlpath like '%checkout/delivery%') then '6 - Checkout - Delivery'
            when (page_urlpath like '%checkout/payment%') then '7 - Checkout - Payment'
            when (page_urlpath like '%orders%') then '8 - Order Completed'
      else '1 - Home Page/Other' end as page_type
      
      
      FROM atomic.events
      
      where event = 'page_view'

    
    sql_trigger_value: SELECT COUNT(*) FROM ${events.SQL_TABLE_NAME}
    distkey: domain_userid
    sortkeys: [domain_userid, domain_sessionidx]

  fields:
  
    # DIMENSIONS #
  
  - dimension: user_id
    sql: ${TABLE}.domain_userid
    
  - dimension: session_index
    type: int
    sql: ${TABLE}.domain_sessionidx

  - dimension: event_id
    sql: ${TABLE}.event_id
    
  - dimension: page_path
    sql: ${TABLE}.page_urlpath

  - dimension: page_type
    sql: ${TABLE}.page_type
  
  - dimension: exit_page_flag
    type: yesno
    sql: ${sessions_last_page.event_id} is not null
  
  # OS fields #  
  
  - dimension: operating_system
    sql: ${TABLE}.os_name
    
  - dimension: operating_system_family
    sql: ${TABLE}.os_family
    
  - dimension: operating_system_manufacturer
    sql: ${TABLE}.os_manufacturer
    
  # Browser fields #
  
  - dimension: browser
    sql: ${TABLE}.br_name
    
  - dimension: browser_family
    sql: ${TABLE}.br_family  
    
  - dimension: browser_version
    sql: ${TABLE}.br_version
    
  - dimension: browser_type
    sql: ${TABLE}.br_type
    
  - dimension: browser_renderengine
    sql: ${TABLE}.br_renderengine
    
  - dimension: browser_language
    sql: ${TABLE}.br_lang
    
  - dimension: browser_has_director_plugin
    sql: ${TABLE}.br_features_director
    
  - dimension: browser_has_flash_plugin
    sql: ${TABLE}.br_features_flash
    
  - dimension: browser_has_gears_plugin
    sql: ${TABLE}.br_features_gears
    
  - dimension: browser_has_java_plugin
    sql: ${TABLE}.br_features_java
    
  - dimension: browser_has_pdf_plugin
    sql: ${TABLE}.br_features_pdf
    
  - dimension: browser_has_quicktime_plugin
    sql: ${TABLE}.br_features_quicktime
    
  - dimension: browser_has_realplayer_plugin
    sql: ${TABLE}.br_features_realplayer
    
  - dimension: browser_has_silverlight_plugin
    sql: ${TABLE}.br_features_silverlight
    
  - dimension: browser_has_windowsmedia_plugin
    sql: ${TABLE}.br_features_windowsmedia
    
  - dimension: browser_supports_cookies
    sql: ${TABLE}.br_cookies
    
  # Measures #
    
  - measure: count_views
    type: count
    
  - measure: count_exits
    type: count_distinct
    sql: ${sessions_last_page.event_id}

  - measure: exit_rate
    type: number
    decimals: 2
    sql: 100.00 * ${count_exits} / ${count_views}
    format: "%0.2f%"
    