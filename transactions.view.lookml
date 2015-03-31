- view: transactions
  derived_table:
    sql: |
         select domain_userid, domain_sessionidx, blended_user_id, collector_tstamp, event_id, customer_id, currency_code, order_id, revenue, shipping, tax, net_value, qty_total, total_adjustment, adjustment_label, rank() over(partition by blended_user_id order by collector_tstamp asc) as customer_order_number
          FROM
          (select domain_userid, domain_sessionidx, blended_user_id, collector_tstamp, event_id, customer_id, currency_code, order_id, revenue, shipping, tax, net_value, qty_total, total_adjustment, adjustment_label from
          (select
          first_value(domain_userid) over(partition by order_id order by collector_tstamp asc rows between unbounded preceding and unbounded following) as domain_userid,
          first_value(domain_sessionidx) over(partition by order_id order by collector_tstamp asc rows between unbounded preceding and unbounded following) as domain_sessionidx,
          first_value(blended_user_id) over(partition by order_id order by collector_tstamp asc rows between unbounded preceding and unbounded following) as blended_user_id,
          first_value(collector_tstamp) over(partition by order_id order by collector_tstamp asc rows between unbounded preceding and unbounded following) as collector_tstamp,
          first_value(event_id) over(partition by order_id order by collector_tstamp asc rows between unbounded preceding and unbounded following) as event_id,
          first_value(customer_id) over(partition by order_id order by collector_tstamp asc rows between unbounded preceding and unbounded following) as customer_id,
          first_value(currency_code) over(partition by order_id order by collector_tstamp asc rows between unbounded preceding and unbounded following) as currency_code,
          first_value(order_id) over(partition by order_id order by collector_tstamp asc rows between unbounded preceding and unbounded following) as order_id,
          first_value(revenue) over(partition by order_id order by collector_tstamp asc rows between unbounded preceding and unbounded following) as revenue,
          first_value(shipping) over(partition by order_id order by collector_tstamp asc rows between unbounded preceding and unbounded following) as shipping,
          first_value(tax) over(partition by order_id order by collector_tstamp asc rows between unbounded preceding and unbounded following) as tax,
          first_value(net_value) over(partition by order_id order by collector_tstamp asc rows between unbounded preceding and unbounded following) as net_value,
          first_value(qty_total) over(partition by order_id order by collector_tstamp asc rows between unbounded preceding and unbounded following) as qty_total,
          first_value(total_adjustment) over(partition by order_id order by collector_tstamp asc rows between unbounded preceding and unbounded following) as total_adjustment,
          first_value(adjustment_label) over(partition by order_id order by collector_tstamp asc rows between unbounded preceding and unbounded following) as adjustment_label
          from
          (SELECT events.domain_userid, events.domain_sessionidx, id_stitch.blended_user_id, events.collector_tstamp, events.event_id, trans.customer_id, trans.currency_code, trans.id AS order_id, trans.revenue, trans.shipping, trans.tax, trans.net_value, trans.qty_total, COALESCE(SUM(adj.amount),'0') AS total_adjustment, MAX(adj.label) AS adjustment_label
                    FROM atomic.com_finerylondon_transaction_1 trans
                      LEFT JOIN atomic.events events ON trans.root_id = events.event_id
                      LEFT JOIN atomic.com_finerylondon_order_adjustments_1 adj ON adj.root_id = trans.root_id
                      LEFT JOIN ${identity_stitching.SQL_TABLE_NAME} id_stitch on id_stitch.domain_userid = events.domain_userid
                    WHERE events.app_id = 'production'
                   GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13)
          )
          GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15)

    sql_trigger_value: SELECT MAX(collector_tstamp) FROM atomic.events
    distkey: event_id
    sortkeys: [domain_userid, domain_sessionidx, collector_tstamp]

  fields:

    ###########################################################################################################################################################
  #############################################################  DIMENSIONS  ################################################################################
###########################################################################################################################################################

  - dimension: domain_userid
    sql: ${TABLE}.domain_userid
    hidden: true
    
  - dimension: blended_user_id
    sql: ${TABLE}.blended_user_id
    hidden: true
    
  - dimension: domain_sessionidx
    type: int
    sql: ${TABLE}.domain_sessionidx
    hidden: true
    
  - dimension: session_id
    sql: ${TABLE}.domain_userid || '-' || ${TABLE}.domain_sessionidx
    hidden: true
    
  - dimension: event_id
    primary_key: true
    sql: ${TABLE}.event_id
    hidden: true
    
  - dimension_group: trans_time
    type: time
    timeframes: [time, hour, date, hour_of_day, day_of_week, week, month]
    sql: ${TABLE}.collector_tstamp
    hidden: true
    
  - dimension: customer_id
    sql: ${TABLE}.customer_id
    hidden: true
  
  - dimension: currency_code
    sql: ${TABLE}.currency_code
    hidden: true
  
  - dimension: exchange_rate
    sql: ${spree_exchange_rates.exchange_rate}
    hidden: true
  
  - dimension: order_id
    sql: ${TABLE}.order_id
    hidden: true
  
  - dimension: revenue_inc_vat
    sql: ${TABLE}.revenue
    hidden: true
     
  - dimension: shipping
    sql: ${TABLE}.shipping
    hidden: true
    
  - dimension: revenue_ex_coupon_and_vat
    sql: ${TABLE}.net_value
    
  - dimension: number_of_items
    sql: ${TABLE}.qty_total
  
  - dimension: new_customer_flag
    type: yesno
    sql: ${TABLE}.customer_order_number = 1
  
  - dimension: guest_checkout_flag
    type: yesno
    sql: ${TABLE}.customer_id is null

###########################################################################################################################################################
  #############################################################  MEASURES  ##################################################################################
    ###########################################################################################################################################################
    
  - measure: count_transactions
    label: NUMBER OF ORDERS
    type: count_distinct
    sql: ${order_id}

  - measure: count_new_customers
    label: NEW CUSTOMERS
    type: count_distinct
    sql: ${order_id}
    filters:
      new_customer_flag: yes

  - measure: count_customers
    label: NUMBER OF CUSTOMERS
    type: count_distinct
    sql: ${blended_user_id}
  
  - measure: count_guest_checkouts
    type: count_distinct
    sql: ${order_id}
    filters:
      guest_checkout_flag: Yes
  
  - measure: guest_checkout_percentage
    type: number
    decimals: 2
    sql: 100.0 * ${count_guest_checkouts}/NULLIF(${count_transactions},0)::REAL
    format: "%0.1f%"

############################# Week on Week Measures

  - measure: count_transactions_yesterday
    type: count_distinct
    label: ORDERS YESTERDAY
    sql: ${order_id}
    filters:
      trans_time_date: 1 day ago for 1 day
    hidden: true

  - measure: count_transactions_last_week
    label: ORDERS LAST WEEK
    type: count_distinct
    sql: ${order_id}
    filters:
      trans_time_date: 8 days ago for 1 day
    hidden: true

  - measure: count_new_customers_yesterday
    label: NEW CUSTOMERS
    type: count_distinct
    sql: ${order_id}
    filters:
      new_customer_flag: yes
      trans_time_date: 1 day ago for 1 day
    hidden: true
    
  - measure: count_new_customers_last_week
    label: NUMBER OF NEW CUSTOMERS
    type: count_distinct
    sql: ${order_id}
    filters:
      new_customer_flag: yes
      trans_time_date: 8 days ago for 1 day
    hidden: true  