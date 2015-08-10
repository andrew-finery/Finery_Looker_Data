- view: snowplow_transaction_attribution
  derived_table:
    sql: |
          select
          transaction_sessions.order_id,
          sessions.domain_userid,
          sessions.domain_sessionidx,
          sessions.session_start_ts,
          
          case
          when sessions.session_index = 1 and transaction_sessions.session_index = 1 then 10000.0000        --full attribution to a first session conversion
          when sessions.session_index in (1,2) and transaction_sessions.session_index = 2 then 5000.0000    -- 50/50 attribution to a second session conversion
          when sessions.session_index = 1 then 4000.0000                                                    -- 40% first-click attribution
          when sessions.session_index = transaction_sessions.session_index then 4000.0000                   -- 40% last-click attribution                                
          else cast(2000.0000 / (transaction_sessions.session_index - 2) as decimal(10,4))                  -- 20% attribution spread over assists
          end
          as attribution_percentage
          
          
          from
          
                  (select ses.blended_user_id, ses.session_index, trans.order_id
                  from ${transactions.SQL_TABLE_NAME} trans
                  left join ${sessions.SQL_TABLE_NAME} ses
                  on trans.domain_userid = ses.domain_userid and trans.domain_sessionidx = ses.domain_sessionidx) transaction_sessions
          
          left join ${sessions.SQL_TABLE_NAME} sessions
          on transaction_sessions.blended_user_id = sessions.blended_user_id
          
          where transaction_sessions.session_index >= sessions.session_index

    sql_trigger_value: SELECT COUNT(*) FROM ${sessions.SQL_TABLE_NAME}
    distkey: domain_userid
    sortkeys: [domain_userid, domain_sessionidx, session_start_ts]

  fields:
  
    ###################################################################################################################################
  ################################## DIMENSIONS #####################################################################################
###################################################################################################################################

   - dimension: user_id
     sql: ${TABLE}.domain_userid
     hidden: true
  
   - dimension: domain_session_index
     sql: ${TABLE}.domain_sessionidx
     hidden: true

   - dimension: order_id
     sql: ${TABLE}.order_id
   
   - dimension: attribution_ratio
     type: number
     decimals: 4
     sql: ${TABLE}.attribution_percentage * 0.0001
   
    ###################################################################################################################################
  ################################## MEASURES #######################################################################################
###################################################################################################################################   
   
   - measure: attributed_orders
     label: ATTRIBUTED ORDERS
     type: sum
     decimals: 2
     sql: ${attribution_ratio}

   - measure: attributed_new_customers
     label: ATTRIBUTED NEW CUSTOMERS
     type: sum
     decimals: 2
     sql: ${attribution_ratio}
     filters:
      transactions.new_customer_flag: yes
     
   - measure: attributed_revenue_ex_discount_ex_vat
     label: ATTRIBUTED REVENUE EX. DISCOUNT, VAT
     type: sum
     decimals: 2
     value_format: '#,##0.00'
     sql: ${attribution_ratio} * ${transactions.revenue_ex_coupon_and_vat} / ${transactions.exchange_rate}