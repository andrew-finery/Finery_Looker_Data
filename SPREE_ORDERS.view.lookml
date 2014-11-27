- view: spree_orders
  derived_table:
    sql: |
     select
        id as order_id,
        "number" as order_code,
        user_id as customer_id,
        bill_address_id,
        ship_address_id,
        item_total,
        total as order_total,
        state,
        adjustment_total,
        shipment_total,
        included_tax_total,
        additional_tax_total,
        completed_at,
        shipment_state,
        currency,
        item_count
        
        from spree.orders_snapshot
        where state = 'complete'
        and created_at > date '2014-11-22'
    
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
    
  - dimension: net_revenue
    type: number
    sql: ${TABLE}.order_total - ${TABLE}.included_tax_total - ${TABLE}.additional_tax_total
    format: "%0.2f"

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
          
  - dimension: payment_received_in_gbp
    type: number
    decimals: 2
    sql:  |
          case
          when ${TABLE}.currency = 'GBP' then ${TABLE}.order_total*1.00
          when ${TABLE}.currency = 'USD' then ${TABLE}.order_total*0.64
          when ${TABLE}.currency = 'CAD' then ${TABLE}.order_total*0.56
          else ${TABLE}.order_total end
    format: "£%0.2f"
          
  - dimension: net_revenue_in_gbp
    type: number
    decimals: 2
    sql:  |
          case
          when ${TABLE}.currency = 'GBP' then ${net_revenue}*1.00
          when ${TABLE}.currency = 'USD' then ${net_revenue}*0.64
          when ${TABLE}.currency = 'CAD' then ${net_revenue}*0.56
          else ${net_revenue} end
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
    
    
  
