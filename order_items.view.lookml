- view: order_items
  derived_table:
    sql: |
        select
          
          a.order_tstamp,
          a.order_id,
          a.user_id,
          a.customer_order_code,
          a.domain_userid,
          a.domain_sessionidx,
          a.customer_order_code,
          
          b.root_id,
          b.sku,
          b.price,
          b.quantity,
          
          a.br_name,
          a.br_family,
          a.br_version,
          a.br_type,
          a.br_renderengine,
          a.br_lang,
          a.br_features_director,
          a.br_features_flash,
          a.br_features_gears,
          a.br_features_java,
          a.br_features_pdf,
          a.br_features_quicktime,
          a.br_features_realplayer,
          a.br_features_silverlight,
          a.br_features_windowsmedia,
          a.br_cookies,
          a.os_name,
          a.os_family,
          a.os_manufacturer,
          a.os_timezone,
          a.dvce_type,
          a.dvce_ismobile,
          a.dvce_screenwidth,
          a.dvce_screenheight
  
        from ${orders.SQL_TABLE_NAME} a
        left join atomic.com_finerylondon_product_in_order_1 b
        on a.event_id = b.root_id
        
    sql_trigger_value: SELECT COUNT(*) FROM ${orders.SQL_TABLE_NAME}
    distkey: domain_userid
    sortkeys: [domain_userid, domain_sessionidx, root_tstamp]

  fields:

  - dimension_group: order_time
    type: time
    timeframes: [time, date, hod, week, month]
    sql: ${TABLE}.collector_tstamp
    
  - dimension: order_id
    primary_key: true
    sql: ${TABLE}.id
  
  - dimension: customer_id
    sql: ${TABLE}.customer_id
    
  - dimension: customer_order_code
    sql: ${TABLE}.customer_order_code
  
  - dimension: domain_userid
    sql: ${TABLE}.domain_userid
    
  - dimension: session_index
    type: int
    sql: ${TABLE}.domain_sessionidx
  
  - dimension: session_id
    sql: ${TABLE}.domain_userid || '-' || ${TABLE}.domain_sessionidx  
    
  - dimension: sku
    sql: ${TABLE}.sku
    
  - dimension: price
    sql: ${TABLE}.price
  
  - dimension: quantity
    sql: ${TABLE}.quantity
  
  - dimension: gross_revenue
    sql: ${TABLE}.price * ${TABLE}.quantity
    
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
    
  - dimension: browser_family
    sql: ${TABLE}.br_family
    
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
  
  - measure: count_orders
    type: count distinct
    sql: ${TABLE}.order_id
    
  - measure: count_customers
    type: count distinct
    sql: ${TABLE}.user_id  
    
  - measure: distinct_skus_sold
    type: count distinct
    sql: ${TABLE}.sku
  
  - measure: items_sold
    type: sum
    sql: ${TABLE}.quantity
    
  - measure: sum_gross_revenue
    type: sum
    sql: ${TABLE}.gross_revenue
    
    
    
    