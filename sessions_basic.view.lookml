- view: sessions_basic
  derived_table:
    sql: |
      SELECT
      sessions.domain_userid,
      sessions.domain_sessionidx,
      convert_timezone('UTC', 'Europe/London', sessions.session_start_ts) as session_start_ts,
      convert_timezone('UTC', 'Europe/London', sessions.session_end_ts) as session_end_ts,
      sessions.number_of_events,
      sessions.interaction_events,
      sessions.free_gift_click_events,
      coalesce(sessions.referrals_sent, '0') as referrals_sent,
      sessions.distinct_pages_viewed,
      sessions.user_id as user_id,
      coalesce(signups.accounts_created,'0') as accounts_created,
      coalesce(newsletter.newsletter_signups,'0') as newsletter_signups,
      coalesce(add_cart.products_added_to_cart,'0') as products_added_to_cart,
      coalesce(remove_cart.products_removed_from_cart,'0') as product_removed_from_cart,
      coalesce(cart.cart_events,'0') as cart_events,
      coalesce(checkout.checkout_progress,'0') as checkout_progress,
      coalesce(product_impressions.product_impressions, '0') as product_impressions,
      coalesce(product_clicks.product_clicks, '0') as product_clicks,
      coalesce(product_views.distinct_product_views, '0') as product_views,
      coalesce(sale_link_clicks.sale_link_clicks, '0') as sale_link_clicks,
      sessions.successful_logins,
      sessions.unsuccessful_logins,
      sessions.unsuccessful_registrations,
      sessions.sale_events
      
      FROM
      
      (SELECT
        domain_userid,
        domain_sessionidx,
        MIN(collector_tstamp) AS session_start_ts,
        MAX(collector_tstamp) AS session_end_ts,
        count(*) AS number_of_events,
        sum(case when (event = 'page_ping' or unstruct_event like '%product_impression%') then 0 else 1 end) as interaction_events,
        sum(case when se_action = 'freeGiftClick' then 1 else 0 end) as free_gift_click_events,
        sum(case when se_action = 'inviteFriends' then se_value else 0 end) as referrals_sent,
        sum(case when unstruct_event like '%login_success%' then 1 else 0 end) as successful_logins,
        sum(case when unstruct_event like '%login_failure%' then 1 else 0 end) as unsuccessful_logins,
        sum(case when unstruct_event like '%registration_failure%' then 1 else 0 end) as unsuccessful_registrations,
        sum(case when page_urlpath like '%final-call%' then 1 else 0 end) as sale_events,
        COUNT(DISTINCT page_urlpath) AS distinct_pages_viewed,
        max(user_id) as user_id
      FROM
        atomic.events
      WHERE domain_userid IS NOT NULL
        AND domain_userid <> ''
        AND app_id = 'production'
        AND domain_sessionidx IS NOT NULL
      GROUP BY 1,2) sessions
      
      LEFT JOIN (select events.domain_userid, events.domain_sessionidx, count(distinct customer_id) as accounts_created from atomic.com_finerylondon_registration_success_1 reg left join atomic.events events on reg.root_id = events.event_id group by 1,2) signups
        ON signups.domain_userid = sessions.domain_userid and signups.domain_sessionidx = sessions.domain_sessionidx
      LEFT JOIN (select events.domain_userid, events.domain_sessionidx, count(*) as newsletter_signups from atomic.com_finerylondon_newsletter_subscription_1 sub left join atomic.events events on sub.root_id = events.event_id group by 1,2) newsletter
        ON newsletter.domain_userid = sessions.domain_userid and newsletter.domain_sessionidx = sessions.domain_sessionidx
      LEFT JOIN (select events.domain_userid, events.domain_sessionidx, count(*) as products_added_to_cart from atomic.com_finerylondon_add_to_cart_1 cart left join atomic.events events on cart.root_id = events.event_id group by 1,2) add_cart
        ON add_cart.domain_userid = sessions.domain_userid and add_cart.domain_sessionidx = sessions.domain_sessionidx
      LEFT JOIN (select events.domain_userid, events.domain_sessionidx, count(*) as products_removed_from_cart from atomic.com_finerylondon_remove_from_cart_1 cart left join atomic.events events on cart.root_id = events.event_id group by 1,2) remove_cart
        ON remove_cart.domain_userid = sessions.domain_userid and remove_cart.domain_sessionidx = sessions.domain_sessionidx
      LEFT JOIN (select events.domain_userid, events.domain_sessionidx, count(*) as cart_events from atomic.com_finerylondon_cart_1 cart left join atomic.events events on cart.root_id = events.event_id group by 1,2) cart
        ON cart.domain_userid = sessions.domain_userid and cart.domain_sessionidx = sessions.domain_sessionidx
      LEFT JOIN (select events.domain_userid, events.domain_sessionidx, max(case when checkout.checkout_step = 'started' then 1 when checkout.checkout_step = 'address' then 2 when checkout.checkout_step = 'delivery' then 3 when checkout.checkout_step = 'payment' then 3 else cast(checkout.checkout_step as int) end) as checkout_progress from atomic.com_finerylondon_checkout_1 checkout left join atomic.events events on checkout.root_id = events.event_id group by 1,2) checkout
        ON checkout.domain_userid = sessions.domain_userid and checkout.domain_sessionidx = sessions.domain_sessionidx
      LEFT JOIN (select events.domain_userid, events.domain_sessionidx, count(*) as product_impressions from atomic.com_finerylondon_product_impression_1 prod_impression left join atomic.events events on prod_impression.root_id = events.event_id left join atomic.com_finerylondon_product_impression_context_1 prod_impression_context on prod_impression.root_id = prod_impression_context.root_id group by 1,2) product_impressions
        ON product_impressions.domain_userid = sessions.domain_userid and product_impressions.domain_sessionidx = sessions.domain_sessionidx
      LEFT JOIN (select events.domain_userid, events.domain_sessionidx, count(*) as product_clicks from atomic.com_finerylondon_product_clicked_1 prod_clicks left join atomic.events events on prod_clicks.root_id = events.event_id group by 1,2) product_clicks
        ON product_clicks.domain_userid = sessions.domain_userid and product_clicks.domain_sessionidx = sessions.domain_sessionidx
      LEFT JOIN (select events.domain_userid, events.domain_sessionidx, count(distinct prod_views.prod_id) as distinct_product_views from atomic.com_finerylondon_page_view_context_1 prod_views left join atomic.events events on prod_views.root_id = events.event_id where events.event = 'page_view' and page_type = 'products/show' group by 1,2) product_views
        ON product_views.domain_userid = sessions.domain_userid and product_views.domain_sessionidx = sessions.domain_sessionidx
      LEFT JOIN (select events.domain_userid, events.domain_sessionidx, count(*) as sale_link_clicks from atomic.com_snowplowanalytics_snowplow_link_click_1 sale_link left join atomic.events events on sale_link.root_id = events.event_id where target_url like '%final-call%' group by 1,2) sale_link_clicks
        ON sale_link_clicks.domain_userid = sessions.domain_userid and sale_link_clicks.domain_sessionidx = sessions.domain_sessionidx

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
      