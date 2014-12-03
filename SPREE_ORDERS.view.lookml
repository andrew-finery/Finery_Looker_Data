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
                 CASE
                   WHEN b.store_credit IS NULL THEN 0
                   ELSE b.store_credit
                 END AS store_credit_used
          FROM spree.orders_snapshot a
            LEFT JOIN (SELECT order_id,
                              SUM(amount) AS store_credit
                       FROM spree.payments_snapshot
                       WHERE source_type = 'Spree::StoreCredit'
                       GROUP BY 1) b ON a.id = b.order_id
          WHERE a.state = 'complete'
          AND a.created_at > DATE '2014-11-22'
    
    sql_trigger_value: SELECT COUNT(*) FROM spree.orders_snapshot
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
    
  
