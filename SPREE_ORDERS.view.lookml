- view: spree_orders
  derived_table:
    sql: |
     SELECT a.id AS order_id,
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
                coalesce(d.total_amount_refunded, '0') as total_amount_refunded,
                coalesce(d.returns_included_tax, '0') as returns_included_tax,
                coalesce(d.returns_additional_tax, '0') as returns_additional_tax,
                coalesce(d.items_returned, '0') as items_returned,
                
                coalesce(d.return_item_total*c.exchange_rate, '0') as return_item_total_gbp,
                coalesce(d.total_amount_refunded*c.exchange_rate, '0') as total_amount_refunded_gbp,
                coalesce(d.returns_included_tax*c.exchange_rate, '0') as returns_included_tax_gbp,
                coalesce(d.returns_additional_tax*c.exchange_rate, '0') as returns_additional_tax_gbp,
                
                coalesce(a.item_count - d.items_returned, '0') as items_purchased_post_returns,
                coalesce((a.item_total - d.return_item_total)*c.exchange_rate, '0') as item_total_post_returns_gbp,
                coalesce((a.total - d.total_amount_refunded)*c.exchange_rate, '0') as order_total_post_returns_gbp,
                coalesce((a.total - d.total_amount_refunded - a.shipment_total)*c.exchange_rate, '0') as ord_tot_post_ship_and_returns_gbp,
                coalesce((a.total - d.total_amount_refunded)*c.exchange_rate, '0') as total_paid_after_returns_gbp
                

 
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

          WHERE a.state in ('complete', 'returned')
          AND a.created_at > DATE '2014-11-22'

    
    sql_trigger_value: SELECT COUNT(*) FROM daily_snapshot.spree_orders
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
    
  - dimension: net_revenue_ex_tax
    type: number
    sql: ${gross_revenue} - ${TABLE}.included_tax_total - ${TABLE}.additional_tax_total
    format: "%0.2f"
    
  - dimension: net_revenue_ex_tax_and_discount
    type: number
    sql: ${net_revenue_ex_tax} - ${discount}
    format: "%0.2f"

  - dimension: store_credit_used
    type: number
    sql: ${TABLE}.store_credit_used
    format: "%0.2f"
    
  - dimension: store_credit_used_boolean
    type: yesno
    sql: ${store_credit_used} > 0
    
  - dimension: discount_used_boolean
    type: yesno
    sql: ${discount} > 0


# Revenue Measures Converted into GBP

  - dimension: gross_revenue_in_gbp
    type: number
    decimals: 2
    sql:  |
          case
          when ${TABLE}.currency = 'GBP' then ${gross_revenue}*1.00
          when ${TABLE}.currency = 'USD' then ${gross_revenue}*0.64
          when ${TABLE}.currency = 'CAD' then ${gross_revenue}*0.56
          else ${gross_revenue} end
    format: "£%0.2f"
  
  - dimension: total_of_items_in_gbp
    type: number
    decimals: 2
    sql:  |
          case
          when ${TABLE}.currency = 'GBP' then ${TABLE}.item_total*1.00
          when ${TABLE}.currency = 'USD' then ${TABLE}.item_total*0.64
          when ${TABLE}.currency = 'CAD' then ${TABLE}.item_total*0.56
          else ${TABLE}.item_total end
    format: "£%0.2f"
          
  
  - dimension: shipping_total_in_gbp
    type: number
    decimals: 2
    sql:  |
          case
          when ${TABLE}.currency = 'GBP' then ${TABLE}.shipment_total*1.00
          when ${TABLE}.currency = 'USD' then ${TABLE}.shipment_total*0.64
          when ${TABLE}.currency = 'CAD' then ${TABLE}.shipment_total*0.56
          else ${TABLE}.shipment_total end
    format: "£%0.2f"
          
   
  - dimension: total_discount_in_gbp
    type: number
    decimals: 2
    sql:  |
          case
          when ${TABLE}.currency = 'GBP' then ${TABLE}.adjustment_total*(-1.00)
          when ${TABLE}.currency = 'USD' then ${TABLE}.adjustment_total*(-0.64)
          when ${TABLE}.currency = 'CAD' then ${TABLE}.adjustment_total*(-0.56)
          else ${TABLE}.adjustment_total*(-1.00) end
    format: "£%0.2f"
          
  - dimension: net_revenue_ex_tax_in_gbp
    type: number
    decimals: 2
    sql:  |
          case
          when ${TABLE}.currency = 'GBP' then ${net_revenue_ex_tax}*1.00
          when ${TABLE}.currency = 'USD' then ${net_revenue_ex_tax}*0.64
          when ${TABLE}.currency = 'CAD' then ${net_revenue_ex_tax}*0.56
          else ${net_revenue_ex_tax} end
    format: "£%0.2f"

  - dimension: net_revenue_ex_tax_and_discount_in_gbp
    type: number
    decimals: 2
    sql:  |
          case
          when ${TABLE}.currency = 'GBP' then ${net_revenue_ex_tax_and_discount}*1.00
          when ${TABLE}.currency = 'USD' then ${net_revenue_ex_tax_and_discount}*0.64
          when ${TABLE}.currency = 'CAD' then ${net_revenue_ex_tax_and_discount}*0.56
          else ${net_revenue_ex_tax_and_discount} end
    format: "£%0.2f"
    
  - dimension: store_credit_used_in_gbp
    type: number
    decimals: 2
    sql:  |
          case
          when ${TABLE}.currency = 'GBP' then ${store_credit_used}*1.00
          when ${TABLE}.currency = 'USD' then ${store_credit_used}*0.64
          when ${TABLE}.currency = 'CAD' then ${store_credit_used}*0.56
          else ${store_credit_used} end
    format: "£%0.2f"

# MEASURES #
  
  - measure: count_orders
    type: count_distinct
    sql: ${TABLE}.order_id
    
  - measure: count_customers
    type: count_distinct
    sql: ${TABLE}.customer_id  
    
  - measure: total_items
    type: sum
    sql: ${TABLE}.item_count

  # revenue sums

  - measure: sum_gross_revenue_gbp
    type: sum
    sql: ${gross_revenue_in_gbp}
    format: "£%0.2f"

  - measure: sum_total_of_items_gbp
    type: sum
    sql: ${total_of_items_in_gbp}
    format: "£%0.2f"

  - measure: sum_shipping_total_gbp
    type: sum
    sql: ${shipping_total_in_gbp}
    format: "£%0.2f"

  - measure: sum_total_discount_gbp
    type: sum
    sql: ${total_discount_in_gbp}
    format: "£%0.2f"
  
  - measure: sum_net_revenue_ex_tax_gbp
    type: sum
    sql: ${net_revenue_ex_tax_in_gbp}
    format: "£%0.2f"
    
  - measure: sum_net_revenue_ex_tax_and_discount_gbp
    type: sum
    sql: ${net_revenue_ex_tax_and_discount_in_gbp}
    format: "£%0.2f"
    
  - measure: sum_store_credit_used_gbp
    type: sum
    sql: ${store_credit_used_in_gbp}
    format: "£%0.2f"
    
  # revenue averages

  - measure: avg_gross_revenue_gbp
    type: average
    sql: ${gross_revenue_in_gbp}
    format: "£%0.2f"
      
  - measure: avg_net_revenue_ex_tax_in_gbp
    type: average
    sql: ${net_revenue_ex_tax_in_gbp}
    format: "£%0.2f"
    
  - measure: avg_net_revenue_ex_tax_and_discount_gbp
    type: average
    sql: ${net_revenue_ex_tax_and_discount_in_gbp}
    format: "£%0.2f"
    
  # revenue running totals
  
  - measure: gross_revenue_gbp_running_total
    type: running_total
    sql: ${sum_gross_revenue_gbp}
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

  - measure: avg_store_credit_used_gbp
    type: average
    sql: ${store_credit_used_in_gbp}
    format: "£%0.2f"
    
  
