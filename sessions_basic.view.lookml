- view: sessions_basic
  derived_table:
    sql: |
          with step_1 as (
          select event_id, domain_userid, domain_sessionidx, app_id, user_id, page_urlpath, event, unstruct_event, se_action, se_value, min(collector_tstamp) as collector_tstamp
          from atomic.events
          group by 1,2,3,4,5,6,7,8,9,10
          ), step_2 as (
          select root_id, customer_id from atomic.com_finerylondon_registration_success_1 group by 1,2
          ), step_3 as (
          select root_id, email from atomic.com_finerylondon_newsletter_subscription_1 group by 1,2
          ), step_4 as (
          select root_id from atomic.com_finerylondon_add_to_cart_1 group by 1
          ), step_5 as (
          select root_id from atomic.com_finerylondon_remove_from_cart_1 group by 1
          ), step_6 as (
          select root_id from atomic.com_finerylondon_cart_1 group by 1
          ), step_7 as (
          select root_id, checkout_step from atomic.com_finerylondon_checkout_1 group by 1,2
          ), step_8_1 as (
          select root_id from atomic.com_finerylondon_product_impression_1 group by 1
          ), step_8_2 as (
          select root_id, id from atomic.com_finerylondon_product_impression_context_1 group by 1,2
          ), step_8 as (
          select a.root_id, count(*) as impressions from step_8_1 a left join step_8_2 b on a.root_id = b.root_id group by 1
          ), step_9 as (
          select root_id from atomic.com_finerylondon_product_clicked_1 group by 1
          ), step_10 as (
          select root_id, prod_id, page_type from atomic.com_finerylondon_page_view_context_1 group by 1,2,3
          ), step_11 as (
          select root_id, target_url from atomic.com_snowplowanalytics_snowplow_link_click_1 group by 1,2
          )
          
          select
          events.domain_userid,
          events.domain_sessionidx,
          min(convert_timezone('UTC', 'Europe/London', events.collector_tstamp)) as session_start_ts,
          max(convert_timezone('UTC', 'Europe/London', events.collector_tstamp)) as session_end_ts,
          count(*) AS number_of_events,
          sum(case when (events.event = 'page_ping' or events.unstruct_event like '%product_impression%') then 0 else 1 end) as interaction_events,
          sum(case when events.se_action = 'freeGiftClick' then 1 else 0 end) as free_gift_click_events,
          sum(case when events.se_action = 'inviteFriends' then se_value else 0 end) as referrals_sent,
          COUNT(DISTINCT events.page_urlpath) AS distinct_pages_viewed,
          max(events.user_id) as user_id,
          count(distinct reg.customer_id) as accounts_created,
          count(nl.root_id) as newsletter_signups,
          count(atc.root_id) as products_added_to_cart,
          count(rfc.root_id) as product_removed_from_cart,
          count(cart.root_id) as cart_events,
          coalesce(max(case when chk.checkout_step = 'started' then 1 when chk.checkout_step = 'address' then 2 when chk.checkout_step = 'delivery' then 3 when chk.checkout_step = 'payment' then 3 else cast(chk.checkout_step as int) end), '0') as checkout_progress,
          coalesce(sum(pim.impressions), '0') as product_impressions,
          count(pcl.root_id) as product_clicks,
          count(distinct case when events.event = 'page_view' and pv.page_type = 'products/show' then pv.prod_id else null end) as product_views,
          count(case when lc.target_url like '%final-call%' then lc.root_id else null end) as sale_link_clicks,
          sum(case when events.unstruct_event like '%login_success%' then 1 else 0 end) as successful_logins,
          sum(case when events.unstruct_event like '%login_failure%' then 1 else 0 end) as unsuccessful_logins,
          sum(case when events.unstruct_event like '%registration_failure%' then 1 else 0 end) as unsuccessful_registrations,
          sum(case when events.page_urlpath like '%final-call%' then 1 else 0 end) as sale_events
          
          from
          
          step_1 events
          left join step_2 reg on events.event_id = reg.root_id
          left join step_3 nl on events.event_id = nl.root_id
          left join step_4 atc on events.event_id = atc.root_id
          left join step_5 rfc on events.event_id = rfc.root_id
          left join step_6 cart on events.event_id = cart.root_id
          left join step_7 chk on events.event_id = chk.root_id
          left join step_8 pim on events.event_id = pim.root_id
          left join step_9 pcl on events.event_id = pcl.root_id
          left join step_10 pv on events.event_id = pv.root_id
          left join step_11 lc on events.event_id = lc.root_id
          
          where events.app_id = 'production'
          
          group by 1,2

    sql_trigger_value: SELECT FLOOR((EXTRACT(epoch from NOW()) - 60*60*3)/(60*60*24)) # Trigger table generation when new data loaded into atomic.events
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
  
  - dimension: session_id
    sql: ${TABLE}.domain_userid || '-' || ${TABLE}.domain_sessionidx

  - dimension: session_index_tier
    type: tier
    tiers: [1,2,3,4,5,10,25,100,1000]
    sql: ${session_index}
  
  - dimension: start
    sql: ${TABLE}.session_start_ts
  
  - dimension_group: start
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.session_start_ts
    
  - dimension: end
    sql: ${TABLE}.session_end_ts
    
  # Session duration #

  - dimension: session_duration_seconds
    type: int
    sql: EXTRACT(EPOCH FROM (${TABLE}.session_end_ts - ${TABLE}.session_start_ts))

  - dimension: session_duration_seconds_tiered
    type: tier
    tiers: [0,1,5,10,30,60,300,900]
    sql: ${session_duration_seconds}

  # Events per visit and bounces (infered) #

  - dimension: events_during_session
    type: int
    sql: ${TABLE}.number_of_events
    
  - dimension: bounce
    type: yesno
    sql: ${TABLE}.number_of_events = 1
  
  # New vs returning visitor #
  - dimension: new_vs_returning_visitor
    sql_case:
      new: ${TABLE}.domain_sessionidx = 1
      returning: ${TABLE}.domain_sessionidx > 1
      else: unknown

  # Pages visited #
  - dimension: distinct_pages_viewed
    sql: ${TABLE}.distinct_pages_viewed
    
  - dimension: distinct_pages_viewed_tiered
    type: tier
    tiers: [1,2,3,4,5,10,25,100,1000]
    sql: ${TABLE}.distinct_pages_viewed
  
  - dimension: history
    sql: ${session_id}
    html: |
      <a href=events?fields=events.event_detail*&f[events.visit_id]=<%= value%>>Event Stream</a>
  
  

  
  # MEASURES #

  - measure: count
    type: count_distinct
    sql: ${session_id}
    detail: detail*

  - measure: visitors_count
    type: count_distinct
    sql: ${user_id}
    detail: detail*
    hidden: true
    
  - measure: bounced_sessions_count
    type: count_distinct
    sql: ${session_id}
    filters:
      bounce: yes
    detail: detail*

  - measure: bounce_rate
    type: number
    decimals: 2
    sql: ${bounced_sessions_count}/NULLIF(${count},0)::REAL
  
  - measure: sessions_from_new_visitors_count
    type: count_distinct
    sql: ${session_id}
    filters:
      session_index: 1
    detail: detail*
  
  - measure: sessions_from_returning_visitor_count
    type: number
    sql: ${count} - ${sessions_from_new_visitors_count}
    detail: detail*
  
  - measure: new_visitors_count_over_total_visitors_count
    type: number
    decimals: 2
    sql: ${sessions_from_new_visitors_count}/NULLIF(${count},0)::REAL
    detail: detail*

  - measure: returning_visitors_count_over_total_visitors_count
    type: number
    decimals: 2
    sql: ${sessions_from_returning_visitor_count}/NULLIF(${count},0)::REAL
    detail: detail*
  
  - measure: average_session_duration_seconds
    type: average
    sql: EXTRACT(EPOCH FROM (${end}-${start}))
    
  - measure: average_session_duration
    type: string
    sql: cast(${average_session_duration_seconds}/60 as int)||':'||mod(cast(${average_session_duration_seconds} as int), 60)
      