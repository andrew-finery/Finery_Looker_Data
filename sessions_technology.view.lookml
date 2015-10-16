- view: sessions_technology
  derived_table:
    sql: |
      SELECT
        domain_userid,
        domain_sessionidx,
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
        br_viewwidth,
        br_viewheight,
        os_name,
        os_family,
        os_manufacturer,
        os_timezone,
        dvce_type,
        dvce_ismobile,
        dvce_screenwidth,
        dvce_screenheight
      FROM (
        SELECT
          domain_userid,
          domain_sessionidx,
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
          br_viewwidth,
          br_viewheight,
          os_name,
          os_family,
          os_manufacturer,
          os_timezone,
          dvce_type,
          dvce_ismobile,
          dvce_screenwidth,
          dvce_screenheight,
          RANK() OVER (PARTITION BY domain_userid, domain_sessionidx 
            ORDER BY dvce_created_tstamp, br_name, br_family, br_version, br_type, br_renderengine, br_lang, br_features_director, br_features_flash, 
            br_features_gears, br_features_java, br_features_pdf, br_features_quicktime, br_features_realplayer, br_features_silverlight,
            br_features_windowsmedia, br_cookies, os_name, os_family, os_manufacturer, os_timezone, dvce_type, dvce_ismobile, dvce_screenwidth,
            dvce_screenheight) AS "rank"
        FROM "atomic"."events"
        WHERE domain_userid IS NOT NULL
        AND app_id = 'production') AS a
      WHERE rank = 1  
      GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28
    
    sql_trigger_value: SELECT COUNT(*) FROM ${sessions_source.SQL_TABLE_NAME}
    
    distkey: domain_userid
    sortkeys: [domain_userid, domain_sessionidx]
    
  fields:
  
  # DIMENSIONS #
  
  # Basic dimensions #
  
  - dimension: user_id
    sql: ${TABLE}.domain_userid
    
  - dimension: session_index
    type: int
    sql: ${TABLE}.domain_sessionidx
    
  # Device fields #
    
  - dimension: device_type
    sql: ${TABLE}.dvce_type
    
  - dimension: device_is_mobile
    sql: ${TABLE}.dvce_ismobile
    
  - dimension: device_screen_width
    sql: ${TABLE}.dvce_screenwidth
    
  - dimension: device_screen_height
    sql: ${TABLE}.dvce_screenheight
    
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
    
  # MEASURES #
  
  - measure: device_count
    type: count_distinct
    sql: ${device_type}
    detail: detail*
  
  - measure: operating_system_count
    type: count_distinct
    sql: ${operating_system}
    detail: detail*
  
  - measure: browser_count
    type: count_distinct
    sql: ${browser}
    detail: detail*
    
  - measure: count
    type: count