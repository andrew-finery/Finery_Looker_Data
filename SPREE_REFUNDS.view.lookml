- view: spree_refunds
  derived_table:
    sql: |
        select  c.order_id,
        d.source_type,
        coalesce(d.created_at, a.created_at) as refund_processed_at, -- if there is a return authorisation with no associated payment, assume refund made at time return authorization created
        coalesce(d.payment_method_id, 3) as payment_method_id, -- if there is a return authorisation with no associated payment, assume full payment made in store credits
        coalesce(max(d.amount),  sum(b.pre_tax_amount)) as amount_refunded, -- if there is a return authorisation with no associated payment, assume full payment made in store credits
        e.currency,
        f.exchange_rate,
        coalesce(max(d.amount*f.exchange_rate),  sum(b.pre_tax_amount*f.exchange_rate)) as amount_refunded_gbp,
        max(a.spree_timestamp) as spree_timestamp
                
      
        from
        (select * from daily_snapshot.spree_return_authorizations where date(spree_timestamp) = current_date) a
        left join
        (select * from daily_snapshot.spree_return_items where date(spree_timestamp) = current_date) b
        on a.id = b.return_authorization_id
        left join
        (select * from daily_snapshot.spree_inventory_units where date(spree_timestamp) = current_date) c
        on b.inventory_unit_id = c.id
        LEFT JOIN
        (select aaa.created_at, bbb.order_id, bbb.source_type, bbb.payment_method_id, sum(aaa.amount) as amount from 
            (select * from daily_snapshot.spree_refunds where date(spree_timestamp) = current_date) aaa
            left join
            (select * from daily_snapshot.spree_payments where date(spree_timestamp) = current_date) bbb
            on aaa.payment_id = bbb.id group by 1,2,3,4) d
        on c.order_id = d.order_id
        left join 
        (select * from daily_snapshot.spree_orders where date(spree_timestamp) = current_date) e
        on e.id = c.order_id
        left join
        lookup.exchange_rates f
        on f.currency = e.currency
        and f."date" = coalesce(date(d.created_at), date(a.created_at))
        
        where b.id is not null -- making sure that the return authorizations row has a corresponsing row in the spree return items table
          and b.reception_status = 'received'
          and b.acceptance_status = 'accepted'        

        group by 1,2,3,4,6,7
        
        
    sql_trigger_value: SELECT max(spree_timestamp) FROM ${returns.SQL_TABLE_NAME}
    distkey: order_id
    sortkeys: [order_id, refund_processed_at]

  fields:
#  Dimensions
  - dimension: order_id
    sql: ${TABLE}.order_id
    
  - dimension: currency
    sql: ${TABLE}.currency
       
  - dimension: refund_method
    sql_case:
      Credit Card: ${TABLE}.payment_method_id = 1
      PayPal: ${TABLE}.payment_method_id = 2
      Store Credit: ${TABLE}.payment_method_id = 3
    
  - dimension_group: refund_processed_at
    type: time
    timeframes: [time, date, hod, hour, week, month]
    sql: ${TABLE}.refund_processed_at
       
  - dimension: amount_refunded
    type: number
    decimals: 2
    sql: ${TABLE}.amount_refunded
    format: "%0.2f"
       
  - dimension: amount_refunded_gbp
    type: number
    decimals: 2
    sql: ${TABLE}.amount_refunded_gbp
    format: "£%0.2f"
  
    


#  Measures
  - measure: count_orders
    type: count_distinct
    sql: ${order_id}
       
  - measure: total_refunded
    type: sum
    sql: ${amount_refunded}
    format: "%0.2f"
           
  - measure: total_refunded_gbp
    type: sum
    sql: ${amount_refunded_gbp}
    format: "£%0.2f"
