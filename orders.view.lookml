- view: orders
  derived_table:
    sql: |
      select

          max(a.root_tstamp) as order_tstamp,
          a.root_id as event_id,
          a.id as order_id,
          d.user_id as user_id,
          c.payment_method as payment_method,
          c.state,
          B.item_total + B.shipment_total as gross_revenue,
          B.item_total as total_of_items,
          B.shipment_total as shipment_total,
          -B.adjustment_total as total_discount,
          b.total-c.amount as store_credit_used,
          B.included_tax_total as tax_total,
          c.amount as net_revenue,
          dd.domain_userid,
          dd.domain_sessionidx,
          e.number_of_parent_skus as number_of_products,
          e.number_of_child_skus as number_of_variants,
          B.currency as currency_code,
          b.use_credit as use_credit,
          RIGHT(dd.page_urlpath, 10) as customer_order_code
          
          
          from
          
          atomic.com_finerylondon_transaction_1 a
          
          left join atomic.com_finerylondon_order_1 b
          on a.id = b.id
          
          left join atomic.com_finerylondon_payment_completed_1 c
          on b.root_id = c.root_id
          
          left join atomic.events d
          on b.root_id = d.event_id
          
          left join atomic.events dd
          on a.root_id = dd.event_id
          
          left join (select root_id as root_id, count(distinct id) as number_of_parent_skus, count(distinct variant_id) as number_of_child_skus from atomic.com_finerylondon_product_in_order_1 group by 1) e
          on e.root_id = a.root_id
          
          left join spree_orders f
          on a.id = f.id
          
          where c.state = 'completed'
          and d.app_id = 'production'
          and dd.app_id = 'production'
          and a.root_tstamp > date '2014-11-22'
          and f.state <> '"canceled"'
          
          group by 2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20


    sql_trigger_value: SELECT COUNT(*) FROM ${sessions.SQL_TABLE_NAME}
    distkey: domain_userid
    sortkeys: [domain_userid, domain_sessionidx, order_tstamp]
    
  fields:

# User and order measures

  - dimension: domain_userid
    sql: ${TABLE}.domain_userid
    
  - dimension: session_index
    type: int
    sql: ${TABLE}.domain_sessionidx
  
  - dimension: session_id
    sql: ${TABLE}.domain_userid || '-' || ${TABLE}.domain_sessionidx

  - dimension: order_id
    primary_key: true
    sql: ${TABLE}.id
  
  - dimension: event_id
    sql: ${TABLE}.event_id

  - dimension: customer_order_code
    sql: ${TABLE}.customer_order_code

  - dimension: currency_code
    sql: ${TABLE}.currency_code

  - dimension: customer_id
    sql: ${TABLE}.user_id
    
  - dimension: payment_method
    sql: ${TABLE}.payment_method
    
  - dimension: use_credit
    type: yesno
    sql: ${TABLE}.use_credit = 'true'
    
  - dimension_group: order_time
    type: time
    timeframes: [time, date, hod, week, month]
    sql: ${TABLE}.collector_tstamp


# Revenue Measures


  - dimension: gross_revenue
    type: number
    decimals: 2
    sql: ${TABLE}.gross_revenue
    format: "£%0.2f"

  - dimension: total_of_items
    type: number
    decimals: 2
    sql: ${TABLE}.total_of_items
    format: "£%0.2f"
    
  - dimension: shipping_total
    type: number
    decimals: 2
    sql: ${TABLE}.shipping_total
    format: "£%0.2f"
    
  - dimension: total_discount
    type: number
    decimals: 2
    sql: ${TABLE}.total_discount
    format: "£%0.2f"
  
  - dimension: store_credit_used
    type: number
    decimals: 2
    sql: ${TABLE}.store_credit_used
    format: "£%0.2f"
  
  - dimension: payment_received
    type: number
    decimals: 2
    sql: ${TABLE}.payment_received
    format: "£%0.2f"
  
  - dimension: net_revenue
    type: number
    decimals: 2
    sql: ${TABLE}.net_revenue
    format: "£%0.2f"

# Revenue Measures Converted into GBP

  - dimension: gross_revenue_in_gbp
    type: number
    decimals: 2
    sql:  |
          case
          when ${TABLE}.currency_code = 'GBP' then ${TABLE}.gross_revenue*1.00
          when ${TABLE}.currency_code = 'USD' then ${TABLE}.gross_revenue*0.64
          when ${TABLE}.currency_code = 'CAD' then ${TABLE}.gross_revenue*0.56
          else ${TABLE}.gross_revenue end
    format: "£%0.2f"
  
  - dimension: total_of_items_in_gbp
    type: number
    decimals: 2
    sql:  |
          case
          when ${TABLE}.currency_code = 'GBP' then ${TABLE}.total_of_items*1.00
          when ${TABLE}.currency_code = 'USD' then ${TABLE}.total_of_items*0.64
          when ${TABLE}.currency_code = 'CAD' then ${TABLE}.total_of_items*0.56
          else ${TABLE}.total_of_items end
    format: "£%0.2f"
          
  
  - dimension: shipping_total_in_gbp
    type: number
    decimals: 2
    sql:  |
          case
          when ${TABLE}.currency_code = 'GBP' then ${TABLE}.shipping_total*1.00
          when ${TABLE}.currency_code = 'USD' then ${TABLE}.shipping_total*0.64
          when ${TABLE}.currency_code = 'CAD' then ${TABLE}.shipping_total*0.56
          else ${TABLE}.shipping_total end
    format: "£%0.2f"
          
   
  - dimension: total_discount_in_gbp
    type: number
    decimals: 2
    sql:  |
          case
          when ${TABLE}.currency_code = 'GBP' then ${TABLE}.total_discount*1.00
          when ${TABLE}.currency_code = 'USD' then ${TABLE}.total_discount*0.64
          when ${TABLE}.currency_code = 'CAD' then ${TABLE}.total_discount*0.56
          else ${TABLE}.total_discount end
    format: "£%0.2f"
          
  - dimension: store_credit_used_in_gbp
    type: number
    decimals: 2
    sql:  |
          case
          when ${TABLE}.currency_code = 'GBP' then ${TABLE}.store_credit_used*1.00
          when ${TABLE}.currency_code = 'USD' then ${TABLE}.store_credit_used*0.64
          when ${TABLE}.currency_code = 'CAD' then ${TABLE}.store_credit_used*0.56
          else ${TABLE}.store_credit_used end
    format: "£%0.2f"
  
  - dimension: payment_received_in_gbp
    type: number
    decimals: 2
    sql:  |
          case
          when ${TABLE}.currency_code = 'GBP' then ${TABLE}.payment_received*1.00
          when ${TABLE}.currency_code = 'USD' then ${TABLE}.payment_received*0.64
          when ${TABLE}.currency_code = 'CAD' then ${TABLE}.payment_received*0.56
          else ${TABLE}.payment_received end
    format: "£%0.2f"
          
  - dimension: net_revenue_in_gbp
    type: number
    decimals: 2
    sql:  |
          case
          when ${TABLE}.currency_code = 'GBP' then ${TABLE}.net_revenue*1.00
          when ${TABLE}.currency_code = 'USD' then ${TABLE}.net_revenue*0.64
          when ${TABLE}.currency_code = 'CAD' then ${TABLE}.net_revenue*0.56
          else ${TABLE}.net_revenue end
    format: "£%0.2f"

  - dimension: number_of_items
    type: number
    decimals: 2
    sql: ${TABLE}.number_of_items
  
  - dimension: number_of_products
    type: number
    decimals: 2
    sql: ${TABLE}.number_of_products
    
  - dimension: number_of_variants
    type: number
    decimals: 2
    sql: ${TABLE}.number_of_variants

# MEASURES #
  
  - measure: count_orders
    type: count_distinct
    sql: ${TABLE}.order_id
    
  - measure: count_customers
    type: count_distinct
    sql: ${TABLE}.user_id  
    
  - measure: total_items
    type: sum
    sql: ${TABLE}.number_of_items

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
  
  - measure: sum_store_credit_used_gbp
    type: sum
    sql: ${store_credit_used_in_gbp}
    format: "£%0.2f"
  
  - measure: sum_net_revenue_gbp
    type: sum
    sql: ${net_revenue_in_gbp}
    format: "£%0.2f"
    
  # revenue averages

  - measure: avg_gross_revenue_gbp
    type: average
    sql: ${gross_revenue_in_gbp}
    format: "£%0.2f"
      
  - measure: avg_net_revenue_gbp
    type: average
    sql: ${net_revenue_in_gbp}
    format: "£%0.2f"
      
   # basket size averages
  
  - measure: avg_items_in_bag
    type: average
    sql: ${TABLE}.number_of_items
    format: "%0.2f"
      
  - measure: avg_skus_in_bag
    type: average
    decimals: 2
    sql: ${TABLE}.number_of_products
    format: "%0.2f"
