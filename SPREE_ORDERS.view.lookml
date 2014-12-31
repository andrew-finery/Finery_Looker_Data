- view: spree_orders
  derived_table:
    sql: |
     SELECT a.spree_timestamp,
                 a.id AS order_id,
                 a."number" AS order_code,
                 a.user_id AS customer_id,
                 a.bill_address_id,
                 a.ship_address_id,
                 a.item_total,
                 a.total AS order_total,
                 a.state,
                 adjustment_total,
                 shipment_total,
                 a.included_tax_total,
                 a.additional_tax_total,
                 a.completed_at,
                 a.shipment_state,
                 a.currency,
                 a.item_count,
                 CASE WHEN b.store_credit IS NULL THEN 0 ELSE b.store_credit END AS store_credit_used,
                 
                 c.exchange_rate,
                 a.item_total*c.exchange_rate AS item_total_gbp,
                 a.total*c.exchange_rate AS order_total_gbp,
                 adjustment_total*c.exchange_rate as adjustment_total_gbp,
                 shipment_total*c.exchange_rate as shipment_total_gbp,
                 a.included_tax_total*c.exchange_rate as included_tax_total_gbp,
                 a.additional_tax_total*c.exchange_rate as additional_tax_total_gbp,
                 CASE WHEN b.store_credit IS NULL THEN 0 ELSE b.store_credit*c.exchange_rate END AS store_credit_used_gbp,
                 
                coalesce(d.return_item_total, '0') as return_item_total,
                coalesce(d.items_returned, '0') as items_returned,
                coalesce(d.return_item_total*c.exchange_rate, '0') as return_item_total_gbp,
                
                a.item_count - coalesce(d.items_returned, '0') as items_purchased_post_returns,
                
                coalesce(e.amount_refunded, '0') as amount_refunded,
                coalesce(e.store_credit_refunded, '0') as store_credit_refunded,
                coalesce(e.cash_refunded, '0') as cash_refunded,
                coalesce(e.amount_refunded_gbp, '0') as amount_refunded_gbp,
                coalesce(e.store_credit_refunded_gbp, '0') as store_credit_refunded_gbp,
                coalesce(e.cash_refunded_gbp, '0') as cash_refunded_gbp
                

 
          FROM (select * from daily_snapshot.spree_orders where date(spree_timestamp) = current_date) a
            LEFT JOIN (SELECT order_id,
                              SUM(amount) AS store_credit
                       FROM (select * from daily_snapshot.spree_payments where date(spree_timestamp) = current_date)
                       WHERE source_type = 'Spree::StoreCredit'
                       GROUP BY 1) b ON a.id = b.order_id
                       
            left join lookup.exchange_rates c
            on date_trunc ('day', a.completed_at) = c."date"
            and a.currency = c.currency
            
            left join (select aaa.order_id, sum(bbb.price) as return_item_total, sum(aaa.pre_tax_amount) as total_amount_refunded, sum(aaa.included_tax_total) as returns_included_tax, sum(aaa.additional_tax_total) as returns_additional_tax, count(*) as items_returned
                      from ${returns.SQL_TABLE_NAME} aaa
                      left join
                      (select * from daily_snapshot.spree_line_items where date(spree_timestamp) = current_date) bbb
                      on aaa.order_id = bbb.order_id
                      and aaa.variant_id = bbb.variant_id
                      where aaa.reception_status = 'received' and aaa.acceptance_status = 'accepted' and aaa.reimbursement_status = 'reimbursed'
                      group by 1) d
                      on a.id = d.order_id
                      
            left join (select
                      bbb.order_id,
                      sum(bbb.amount_refunded) as amount_refunded,
                      sum(bbb.amount_refunded) - sum(case when bbb.payment_method_id = 3 then bbb.amount_refunded else 0 end) as cash_refunded,
                      sum(case when bbb.payment_method_id = 3 then bbb.amount_refunded else 0 end) as store_credit_refunded,
                      sum(bbb.amount_refunded_gbp) as amount_refunded_gbp,
                      sum(bbb.amount_refunded_gbp) - sum(case when bbb.payment_method_id = 3 then bbb.amount_refunded_gbp else 0 end) as cash_refunded_gbp,
                      sum(case when bbb.payment_method_id = 3 then bbb.amount_refunded_gbp else 0 end) as store_credit_refunded_gbp
                      from ${spree_refunds.SQL_TABLE_NAME} bbb
                      group by 1) e
                      on a.id = e.order_id

          WHERE a.state in ('complete', 'returned', 'canceled')
          AND a.created_at > DATE '2014-11-22'

    
    sql_trigger_value: SELECT max(spree_timestamp) FROM ${spree_refunds.SQL_TABLE_NAME}
    distkey: order_id
    sortkeys: [order_id, completed_at]

  fields:

  - dimension: order_id
    primary_key: true
    type: int
    sql: ${TABLE}.order_id

  - dimension: discount
    type: number
    decimals: 2
    sql: ${TABLE}.adjustment_total * (-1)
    format: "£%0.2f"

  - dimension_group: completed
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.completed_at

  - dimension: currency
    sql: ${TABLE}.currency

  - dimension: item_count
    type: int
    sql: ${TABLE}.item_count

  - dimension: item_total
    type: number
    decimals: 2
    sql: ${TABLE}.item_total
    format: "%0.2f"
 
  - dimension: payment_total
    type: number
    decimals: 2
    sql: ${TABLE}.order_total
    format: "%0.2f"

  - dimension: order_code
    sql: ${TABLE}.order_code

  - dimension: shipment_state
    sql: ${TABLE}.shipment_state

  - dimension: shipping_total
    type: number
    decimals: 2
    sql: ${TABLE}.shipment_total
    format: "%0.2f"

  - dimension: state
    sql: ${TABLE}.state

  - dimension: customer_id
    type: int
    sql: ${TABLE}.customer_id

  - dimension: gross_revenue
    type: number
    decimals: 2
    sql: ${TABLE}.item_total + ${TABLE}.shipment_total
    format: "%0.2f"
    
  - dimension: gross_revenue_ex_discount
    type: number
    sql: ${gross_revenue} - ${discount}
    format: "%0.2f"
  
  - dimension: store_credit_used
    type: number
    sql: ${TABLE}.store_credit_used
    format: "%0.2f"
    
  - dimension: gross_revenue_ex_discount_and_store_credit
    type: number
    sql: ${gross_revenue_ex_discount} - ${store_credit_used}
    format: "%0.2f"

  - dimension: store_credit_used_boolean
    type: yesno
    sql: ${store_credit_used} > 0
    
  - dimension: discount_used_boolean
    type: yesno
    sql: ${discount} > 0


# Revenue Dimensions Converted into GBP

  - dimension: gross_revenue_in_gbp
    type: number
    decimals: 2
    sql: ${TABLE}.item_total_gbp + ${TABLE}.shipment_total_gbp
    format: "£%0.2f"
  
  - dimension: total_of_items_in_gbp
    type: number
    decimals: 2
    sql: ${TABLE}.item_total_gbp 
    format: "£%0.2f"

  - dimension: shipping_total_in_gbp
    type: number
    decimals: 2
    sql:  ${TABLE}.shipment_total_gbp
    format: "£%0.2f"

  - dimension: total_discount_in_gbp
    type: number
    decimals: 2
    sql:  ${TABLE}.adjustment_total_gbp * (-1)
    format: "£%0.2f"
          
  - dimension: gross_revenue_ex_discount_in_gbp
    type: number
    decimals: 2
    sql:  ${gross_revenue_in_gbp} - ${total_discount_in_gbp}
    format: "£%0.2f"
    
  - dimension: store_credit_used_in_gbp
    type: number
    decimals: 2
    sql:  ${TABLE}.store_credit_used_gbp
    format: "£%0.2f"

  - dimension: gross_revenue_ex_discount_and_store_credit_in_gbp
    type: number
    decimals: 2
    sql:  ${gross_revenue_ex_discount_in_gbp} - ${store_credit_used_in_gbp}
    format: "£%0.2f"


# Returns Dimensions

  - dimension: items_returned
    sql:  ${TABLE}.items_returned

  - dimension: return_item_total
    type: number
    decimals: 2
    sql:  ${TABLE}.return_item_total
    format: "%0.2f"

  - dimension: return_item_total_gbp
    type: number
    decimals: 2
    sql:  ${TABLE}.return_item_total_gbp
    format: "£%0.2f"

  - dimension: amount_refunded
    type: number
    decimals: 2
    sql:  ${TABLE}.amount_refunded
    format: "%0.2f"

  - dimension: amount_refunded_gbp
    type: number
    decimals: 2
    sql:  ${TABLE}.amount_refunded_gbp
    format: "£%0.2f"

  - dimension: store_credit_refunded
    type: number
    decimals: 2
    sql:  ${TABLE}.store_credit_refunded
    format: "%0.2f"

  - dimension: store_credit_refunded_gbp
    type: number
    decimals: 2
    sql:  ${TABLE}.store_credit_refunded_gbp
    format: "£%0.2f"

  - dimension: cash_refunded
    type: number
    decimals: 2
    sql:  ${TABLE}.cash_refunded
    format: "%0.2f"

  - dimension: cash_refunded_gbp
    type: number
    decimals: 2
    sql:  ${TABLE}.cash_refunded_gbp
    format: "£%0.2f"

# Revenue dimensions post returns

  - dimension: items_purchased_post_returns
    sql:  ${TABLE}.items_purchased_post_returns

  - dimension: gross_revenue_post_returns
    type: number
    decimals: 2
    sql:  ${gross_revenue} - ${return_item_total}
    format: "%0.2f"
      
  - dimension: gross_revenue_post_returns_gbp
    type: number
    decimals: 2
    sql:  ${gross_revenue_in_gbp} - ${return_item_total_gbp}
    format: "£%0.2f"
    
  - dimension: revenue_ex_discount_store_credit_and_refund
    type: number
    decimals: 2
    sql:  ${gross_revenue_ex_discount_and_store_credit} - ${cash_refunded}
    format: "%0.2f"
    
  - dimension: revenue_ex_discount_store_credit_and_refund_gbp
    type: number
    decimals: 2
    sql:  ${gross_revenue_ex_discount_and_store_credit_in_gbp} - ${cash_refunded_gbp}
    format: "£%0.2f"

# MEASURES #
  
  - measure: count_orders
    type: count_distinct
    sql: ${TABLE}.order_id
    filters:
      state: -canceled

  - measure: count_orders_inc_canceled
    type: count_distinct
    sql: ${TABLE}.order_id

  - measure: orders_with_returns
    type: count_distinct
    sql: ${TABLE}.order_id
    filters:
      items_returned: '>0'
  
  - measure: count_customers
    type: count_distinct
    sql: ${TABLE}.customer_id
    filters:
      state: -canceled
  
  - measure: count_customers_inc_canceled
    type: count_distinct
    sql: ${TABLE}.customer_id  
    
  - measure: total_items
    type: sum
    sql: ${TABLE}.item_count
    filters:
      state: -canceled

  - measure: total_items_inc_canceled
    type: sum
    sql: ${TABLE}.item_count

  # SUM GROSS REVENUE

  - measure: sum_gross_revenue
    type: sum
    sql: ${gross_revenue}
    format: "%0.2f"
    filters:
      state: -canceled
  
  - measure: sum_gross_revenue_in_gbp
    type: sum
    sql: ${gross_revenue_in_gbp}
    format: "£%0.2f"
    filters:
      state: -canceled

  - measure: sum_gross_revenue_inc_canceled
    type: sum
    sql: ${gross_revenue}
    format: "%0.2f"
  
  - measure: sum_gross_revenue_in_gbp_inc_canceled
    type: sum
    sql: ${gross_revenue_in_gbp}
    format: "£%0.2f"

  # SUM GROSS REVENUE EX DISCOUNT

  - measure: sum_gross_revenue_ex_discount
    type: sum
    sql: ${gross_revenue_ex_discount}
    format: "%0.2f"
    filters:
      state: -canceled
  
  - measure: sum_gross_revenue_ex_discount_in_gbp
    type: sum
    sql: ${gross_revenue_ex_discount_in_gbp}
    format: "£%0.2f"
    filters:
      state: -canceled

 # SUM GROSS REVENUE EX DISCOUNT AND STORE CREDIT

  - measure: sum_gross_revenue_ex_discount_and_store_credit
    type: sum
    sql: ${gross_revenue_ex_discount_and_store_credit}
    format: "%0.2f"
    filters:
      state: -canceled
  
  - measure: sum_gross_revenue_ex_discount_and_store_credit_in_gbp
    type: sum
    sql: ${gross_revenue_ex_discount_and_store_credit_in_gbp}
    format: "£%0.2f"
    filters:
      state: -canceled

 # OTHER SUMS

  - measure: sum_total_of_items
    type: sum
    sql: ${item_total}
    format: "%0.2f"
    filters:
      state: -canceled

  - measure: sum_total_of_items_gbp
    type: sum
    sql: ${total_of_items_in_gbp}
    format: "£%0.2f"
    filters:
      state: -canceled

  - measure: sum_shipping_total
    type: sum
    sql: ${shipping_total}
    format: "%0.2f"
    filters:
      state: -canceled

  - measure: sum_shipping_total_gbp
    type: sum
    sql: ${shipping_total_in_gbp}
    format: "£%0.2f"
    filters:
      state: -canceled

  - measure: sum_total_discount
    type: sum
    sql: ${discount}
    format: "%0.2f"
    filters:
      state: -canceled

  - measure: sum_total_discount_gbp
    type: sum
    sql: ${total_discount_in_gbp}
    format: "£%0.2f"
    filters:
      state: -canceled
  
  - measure: sum_store_credit_used
    type: sum
    sql: ${store_credit_used}
    format: "%0.2f"
    filters:
      state: -canceled
  
  - measure: sum_store_credit_used_gbp
    type: sum
    sql: ${store_credit_used_in_gbp}
    format: "£%0.2f"
    filters:
      state: -canceled
    
  # revenue averages

  - measure: avg_gross_revenue_gbp
    type: average
    sql: ${gross_revenue_in_gbp}
    format: "£%0.2f"
    filters:
      state: -canceled
      
  - measure: avg_gross_revenue_ex_discount_in_gbp
    type: average
    sql: ${gross_revenue_ex_discount_in_gbp}
    format: "£%0.2f"
    filters:
      state: -canceled
    
  - measure: avg_gross_revenue_ex_discount_and_store_credit_in_gbp
    type: average
    sql: ${gross_revenue_ex_discount_and_store_credit_in_gbp}
    format: "£%0.2f"
    filters:
      state: -canceled
    
  # revenue running totals
  
  - measure: gross_revenue_gbp_running_total
    type: running_total
    sql: ${sum_gross_revenue_in_gbp}
    format: "£%0.2f"
      
   # basket size averages
  - measure: avg_items_in_bag
    type: number
    decimals: 2
    sql: ${total_items}/${count_orders}
    format: "%0.2f"
    
  - measure: avg_discount_in_gbp
    type: average
    sql: ${total_discount_in_gbp}
    format: "£%0.2f"
    filters:
      state: -canceled

  - measure: avg_store_credit_used_gbp
    type: average
    sql: ${store_credit_used_in_gbp}
    format: "£%0.2f"
    filters:
      state: -canceled


# revenue after returns
  
  - measure: sum_gross_revenue_post_returns
    type: sum
    sql: ${gross_revenue_post_returns}
    format: "%0.2f"
    filters:
      state: -canceled  
  
  - measure: sum_gross_revenue_post_returns_gbp
    type: sum
    sql: ${gross_revenue_post_returns_gbp}
    format: "£%0.2f"
    filters:
      state: -canceled

  - measure: sum_revenue_ex_discount_store_credit_and_refund
    type: sum
    sql: ${revenue_ex_discount_store_credit_and_refund}
    format: "%0.2f"
    filters:
      state: -canceled
  
  - measure: sum_revenue_ex_discount_store_credit_and_refund_gbp
    type: sum
    sql: ${revenue_ex_discount_store_credit_and_refund_gbp}
    format: "£%0.2f"
    filters:
      state: -canceled

    # returns totals

  - measure: sum_items_returned
    type: sum
    sql: ${items_returned}
    filters:
      state: -canceled

  - measure: sum_return_item_total
    type: sum
    sql: ${return_item_total}
    format: "%0.2f"
    filters:
      state: -canceled

  - measure: sum_return_item_total_gbp
    type: sum
    sql: ${return_item_total_gbp}
    format: "£%0.2f"
    filters:
      state: -canceled

  - measure: sum_amount_refunded
    type: sum
    sql: ${amount_refunded}
    format: "£%0.2f"
    filters:
      state: -canceled
    
  - measure: sum_amount_refunded_gbp
    type: sum
    sql: ${amount_refunded_gbp}
    format: "£%0.2f"
    filters:
      state: -canceled
  
  - measure: sum_cash_refunded
    type: sum
    sql: ${cash_refunded}
    format: "£%0.2f"
    filters:
      state: -canceled
    
  - measure: sum_cash_refunded_gbp
    type: sum
    sql: ${cash_refunded_gbp}
    format: "£%0.2f"
    filters:
      state: -canceled
      
  - measure: sum_store_credit_refunded
    type: sum
    sql: ${store_credit_refunded}
    format: "£%0.2f"
    filters:
      state: -canceled
    
  - measure: sum_store_credit_refunded_gbp
    type: sum
    sql: ${store_credit_refunded_gbp}
    format: "£%0.2f"
    filters:
      state: -canceled
  
 