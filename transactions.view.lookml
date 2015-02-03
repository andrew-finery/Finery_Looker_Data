- view: transactions
  derived_table:
    sql: |
         SELECT events.domain_userid,
                events.domain_sessionidx,
                events.collector_tstamp,
                events.event_id,
                trans.customer_id,
                trans.currency_code,
                trans.id AS order_id,
                trans.revenue,
                trans.shipping,
                trans.tax,
                trans.net_value,
                trans.qty_total,
                COALESCE(SUM(adj.amount),'0') AS total_adjustment,
                MAX(adj.label) AS adjustment_label
          FROM atomic.com_finerylondon_transaction_1 trans
            LEFT JOIN atomic.events events ON trans.root_id = events.event_id
            LEFT JOIN atomic.com_finerylondon_order_adjustments_1 adj ON adj.root_id = trans.root_id
          WHERE events.app_id = 'production'
          GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12

    sql_trigger_value: SELECT MAX(collector_tstamp) FROM atomic.events
    distkey: event_id
    sortkeys: [domain_userid, domain_sessionidx, collector_tstamp]
    ## NB. Optimised for joining to 'atomic_events' view

  fields:

    ###########################################################################################################################################################
  #############################################################  DIMENSIONS  ################################################################################
###########################################################################################################################################################

  - dimension: domain_userid
    sql: ${TABLE}.domain_userid
  
  - dimension: blended_user_id
    sql: ${TABLE}.blended_user_id
    
  - dimension: domain_sessionidx
    type: int
    sql: ${TABLE}.domain_sessionidx
  
  - dimension: session_id
    sql: ${TABLE}.domain_userid || '-' || ${TABLE}.domain_sessionidx
  
  - dimension: event_id
    primary_key: true
    sql: ${TABLE}.event_id
  
  - dimension_group: trans_time
    type: time
    timeframes: [time, hour, date, hod, dow, week, month]
    sql: ${TABLE}.collector_tstamp
  
  - dimension: customer_id
    sql: ${TABLE}.customer_id
  
  - dimension: currency_code
    sql: ${TABLE}.currency_code
  
  - dimension: order_id
    sql: ${TABLE}.order_id
  
  - dimension: revenue_inc_vat
    sql: ${TABLE}.revenue
     
  - dimension: shipping
    sql: ${TABLE}.shipping
    
  - dimension: revenue_ex_coupon_and_vat
    sql: ${TABLE}.net_value
    
  - dimension: number_of_items
    sql: ${TABLE}.number_of_items

###########################################################################################################################################################
  #############################################################  MEASURES  ##################################################################################
    ###########################################################################################################################################################
    
  - measure: count_transactions
    type: count_distinct
    sql: ${order_id}
  