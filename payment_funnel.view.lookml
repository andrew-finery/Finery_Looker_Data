- view: payment_funnel
  derived_table:
    sql: |
      select
        a.domain_userid,
        a.domain_sessionidx,
        
        case when max(f.customer_id) is not null then max(f.customer_id) else (case when max(e.customer_id) is not null then max(e.customer_id) else (case when max(d.customer_id) is not null then max(d.customer_id) else(case when max(c.customer_id) is not null then max(c.customer_id) else max(a.user_id) end)end)end)end as user_id,
        
        case when max(a.user_id) is not null then 1 else 0 end as logged_in_boolean,
        
        case when max(f.root_id) is not null then 1 else (case when max(e.root_id) is not null then 1 else (case when max(d.root_id) is not null then 1 else (case when max(c.root_id) is not null then 1 else (case when max(b.root_id) is not null then 1 else 0 end)end)end)end)end as added_to_cart_boolean,
        
        case when max(f.root_id) is not null then 1 else (case when max(e.root_id) is not null then 1 else (case when max(d.root_id) is not null then 1 else (case when max(c.root_id) is not null then 1 else 0 end)end)end)end as checkout_started_boolean,
        
        case when max(f.root_id) is not null then 1 else (case when max(e.root_id) is not null then 1 else (case when max(d.root_id) is not null then 1 else 0 end)end)end as address_entered_boolean,
        
        case when max(f.root_id) is not null then 1 else (case when max(e.root_id) is not null then 1 else 0 end)end as delivery_method_boolean,
        
        case when max(f.root_id) is not null then 1 else 0 end as transaction_completed_boolean
        
        
        from
        
        atomic.events a
        
        left join atomic.com_finerylondon_cart_1 b
        on a.event_id = b.root_id
        
        left join (select * from atomic.com_finerylondon_checkout_1 where checkout_step = 'started') c
        on a.event_id = c.root_id
        
        left join (select * from atomic.com_finerylondon_checkout_1 where checkout_step = 'address') d
        on a.event_id = d.root_id
        
        left join (select * from atomic.com_finerylondon_checkout_1 where checkout_step = 'delivery') e
        on a.event_id = e.root_id
        
        left join atomic.com_finerylondon_transaction_1 f
        on a.event_id = f.root_id
        
        where a.app_id = 'production'
        and a.domain_sessionidx is not null
        
      group by 1,2

    sql_trigger_value: SELECT COUNT(*) FROM ${visitors.SQL_TABLE_NAME}
    distkey: domain_userid
    sortkeys: [domain_userid, domain_sessionidx]

  fields:
 # Dimensions

  - dimension: user_id
    sql: ${TABLE}.domain_userid

  - dimension: session_index
    sql: ${TABLE}.domain_sessionidx
  
  - dimension: customer_id
    sql: ${TABLE}.user_id
  
  - dimension: logged_in
    type: yesno
    sql: ${TABLE}.logged_in_boolean = 1
  
  - dimension: added_to_cart
    type: yesno
    sql: ${TABLE}.added_to_cart_boolean = 1
  
  - dimension: checkout_started
    type: yesno
    sql: ${TABLE}.checkout_started_boolean = 1
  
  - dimension: address_entered
    type: yesno
    sql: ${TABLE}.address_entered_boolean = 1
  
  - dimension: delivery_method
    type: yesno
    sql: ${TABLE}.delivery_method_boolean = 1
  
  - dimension: transaction_completed
    type: yesno
    sql: ${TABLE}.transaction_completed_boolean = 1
  
# Measures
  
  - measure: sessions_count
    type: count_distinct
    sql: ${TABLE}.domain_userid || '-' || ${TABLE}.domain_sessionidx
  
  - measure: logged_in_count
    type: count
    sql: ${logged_in}
    filters:
      logged_in: yes
      
  - measure: added_to_cart_count
    type: count
    sql: ${added_to_cart}
    filters:
      logged_in: yes
      
  
  - measure: checkout_started_count
    type: count
    sql: ${checkout_started}
    filters:
      logged_in: yes
      
  
  - measure: address_entered_count
    type: count
    sql: ${address_entered}
    filters:
      logged_in: yes
      
  
  - measure: delivery_method_count
    type: count
    sql: ${delivery_method}
    filters:
      logged_in: yes
      
  
  - measure: order_completed_count
    type: count
    sql: ${order_completed}
    filters:
      logged_in: yes
      
  - measure: logged_in_percentage
    type: number
    decimals: 2
    sql: 100.0 * ${logged_in_count}/NULLIF(${sessions_count},0)::REAL
    format: "%0.2f%" 
    
  
  - measure: added_to_cart_percentage
    type: number
    decimals: 2
    sql: 100.0 * ${added_to_cart_count}/NULLIF(${sessions_count},0)::REAL
    format: "%0.2f%" 
  
  - measure: checkout_started_percentage
    type: number
    decimals: 2
    sql: 100.0 * ${checkout_started_count}/NULLIF(${sessions_count},0)::REAL
    format: "%0.2f%" 
  
  - measure: address_entered_percentage
    type: number
    decimals: 2
    sql: 100.0 * ${address_entered_count}/NULLIF(${sessions_count},0)::REAL
    format: "%0.2f%" 
  
  - measure: delivery_method_percentage
    type: number
    decimals: 2
    sql: 100.0 * ${delivery_method_count}/NULLIF(${sessions_count},0)::REAL
    format: "%0.2f%" 
  
  - measure: order_completed_percentage
    type: number
    decimals: 2
    sql: 100.0 * ${order_completed_count}/NULLIF(${sessions_count},0)::REAL
    format: "%0.2f%" 