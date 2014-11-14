- view: page_views
  derived_table:
    sql: |
          select
                    a.domain_userid,
                    a.domain_sessionidx,
                    a.page_urlhost,
                    a.page_urlpath,
                    a.page_url,
                    a.dvce_tstamp,
          
                    case when (a.page_urlpath like '%clothing%') then 2
                         when (a.page_urlpath like '%products%') then 3
                         when (a.page_urlpath like '%cart%') then 4
                         when (a.page_urlpath like '%checkout/address%') then 5
                         when (a.page_urlpath like '%checkout/delivery%') then 6
                         when (a.page_urlpath like '%checkout/payment%') then 7
                         when (a.page_urlpath like '%orders%') then 8
                         else 1 end as site_progress,
                    
                    case when (a.page_urlpath like '%clothing%') then '2 - Category Page'
                         when (a.page_urlpath like '%products%') then '3 - Product Page'
                         when (a.page_urlpath like '%cart%') then '4 - View Cart'
                         when (a.page_urlpath like '%checkout/address%') then '5 - Checkout - Enter Address'
                         when (a.page_urlpath like '%checkout/delivery%') then '6 - Checkout - Delivery'
                         when (a.page_urlpath like '%checkout/payment%') then '7 - Checkout - Payment'
                         when (a.page_urlpath like '%orders%') then '8 - Order Completed'
                         else '1 - Home Page/Other' end as page_type,
                    
                    t.br_name,
                    t.br_family,
                    t.br_version,
                    t.br_type,
                    t.br_renderengine,
                    t.br_lang,
                    t.br_features_director,
                    t.br_features_flash,
                    t.br_features_gears,
                    t.br_features_java,
                    t.br_features_pdf,
                    t.br_features_quicktime,
                    t.br_features_realplayer,
                    t.br_features_silverlight,
                    t.br_features_windowsmedia,
                    t.br_cookies,
                    t.os_name,
                    t.os_family,
                    t.os_manufacturer,
                    t.os_timezone,
                    t.dvce_type,
                    t.dvce_ismobile,
                    t.dvce_screenwidth,
                    t.dvce_screenheight,
                    
                    case when (c.domain_userid is null and c.domain_sessionidx is null) then 0 else 1 end as exit_page_flag
                    
                    from
                    
                    ((--statement for those sessions we take the 'page view' event from to determine page views
                    select
                    
                    atm.domain_userid, 
                    atm.domain_sessionidx,
                    
                    --atm.br_name,atm.br_family,atm.br_version,atm.br_type,atm.br_renderengine,atm.br_lang,atm.br_features_director,atm.br_features_flash,atm.br_features_gears,atm.br_features_java,atm.br_features_pdf,atm.br_features_quicktime,atm.br_features_realplayer,atm.br_features_silverlight,atm.br_features_windowsmedia,atm.br_cookies,atm.os_name,atm.os_family,atm.os_manufacturer,atm.os_timezone,atm.dvce_type,atm.dvce_ismobile,atm.dvce_screenwidth,atm.dvce_screenheight,
                    
                    atm.page_urlhost,
                    atm.page_urlpath,
                    atm.page_url,
                    atm.dvce_tstamp
                    
                    from atomic.events atm
                    
                    left join
                    
                    (select
                    events.domain_userid as domain_userid,
                    events.domain_sessionidx as domain_sessionidx,
                    sum(case when event = 'page_view' then 1 else 0 end) as page_views,
                    count(distinct page_url) as distinct_pages,
                    case when (count(distinct page_url)) > (sum(case when event = 'page_view' then 1 else 0 end)) then 'DP' else 'PV' end as final_pv
                    from atomic.events
                    group by 1,2) pvdp
                    -- this table calculates how to generate the page views for each session
                    -- final_pv = PV means use the page_view events
                    -- final_pv = DP means use the distinct pages viewed
                    
                    on atm.domain_userid = pvdp.domain_userid
                    and atm.domain_sessionidx = pvdp.domain_sessionidx
                    
                    where pvdp.final_pv = 'PV'
                    and atm.event = 'page_view')
                    
                    
                    union all
                    
                    
                    (--statement for those sessions we take the distinct pages viewed from to determine page views
                    select
                    
                    atm.domain_userid, 
                    atm.domain_sessionidx,
                    
                    atm.page_urlhost,
                    atm.page_urlpath,
                    atm.page_url,
                    max(atm.dvce_tstamp)
                    
                    from atomic.events atm
                    
                    left join
                    
                    (select
                    events.domain_userid as domain_userid,
                    events.domain_sessionidx as domain_sessionidx,
                    sum(case when event = 'page_view' then 1 else 0 end) as page_views,
                    count(distinct page_url) as distinct_pages,
                    case when (count(distinct page_url)) > (sum(case when event = 'page_view' then 1 else 0 end)) then 'DP' else 'PV' end as final_pv
                    from atomic.events
                    group by 1,2) pvdp
                    -- this table calculates how to generate the page views for each session
                    -- final_pv = PV means use the page_view events
                    -- final_pv = DP means use the distinct pages viewed
                    
                    on atm.domain_userid = pvdp.domain_userid
                    and atm.domain_sessionidx = pvdp.domain_sessionidx
                    
                    where pvdp.final_pv = 'DP'
                    group by 1,2,3,4,5)) a
                    
                    left join ${sessions_technology.SQL_TABLE_NAME} t
                    
                    on a.domain_userid = t.domain_userid
                    and a.domain_sessionidx = t.domain_sessionidx
                    
                    left join ${sessions_last_page.SQL_TABLE_NAME}  c
                    
                    on a.domain_userid = c.domain_userid
                    and a.domain_sessionidx = c.domain_sessionidx
                    and a.dvce_tstamp = c.dvce_tstamp
                    and a.page_urlhost = c.page_urlhost --join on url to get rid of any instances of different urls being sent out at exactly the same time for within a session
                    and a.page_urlpath = c.page_urlpath
                    
                    group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33 --group to eliminate any events that could be collected twice in error

    sql_trigger_value: SELECT COUNT(*) FROM ${sessions_technology.SQL_TABLE_NAME}
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
    sql: ${TABLE}.exit_page_flag = 1
  
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
    type: count
    filters:
      exit_page_flag: yes
    sql: ${exit_page_flag}

  - measure: exit_rate
    type: number
    decimals: 2
    sql: 100.00 * ${count_exits} / ${count_views}
    format: "%0.2f%"
    