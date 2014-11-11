- view: page_views
  derived_table:
    sql: |
      SELECT
      
      domain_userid,
      domain_sessionidx,
      event_id,
      
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

    
    sql_trigger_value: SELECT COUNT(*) FROM ${sessions.SQL_TABLE_NAME}
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
    
  - measure: count_views
    type: count
    
  - measure: count_exits
    type: count_distinct
    sql: ${sessions_last_page.event_id}
    
  - measure: count_exits_2
    type: count
    sql: ${TABLE}.exit_page_flag = 'yes'
    