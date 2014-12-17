- view: spree_order_items
  derived_table:
    sql: |
      select 

        a.completed_at as order_tstamp,
        b.order_id as order_id,
        a.customer_id as customer_id,
        a.order_code as order_code,
        c.sku,
        b.price,
        b.currency,
        f.exchange_rate,
        b.price*f.exchange_rate as price_gbp,
        b.quantity,
        d.max_selling_price_gbp,
        e.items_returned,
        e.return_reason
        
        from

        ${spree_orders.SQL_TABLE_NAME} a
        inner join
        (select * from daily_snapshot.spree_line_items where date(spree_timestamp) = current_date) b
        on a.order_id = b.order_id
        left join 
        (select id, sku from (select * from daily_snapshot.spree_variants where date(spree_timestamp) = current_date) where deleted_at is null group by 1,2) c
        on b.variant_id = c.id
        left join
        (select variant_id, max(amount) as max_selling_price_gbp from (select * from daily_snapshot.spree_prices where date(spree_timestamp) = current_date) where currency = 'GBP' group by 1) d
        on b.variant_id = d.variant_id
        left join
        (select order_id, sku, count(*) as items_returned, max(name) as return_reason from ${returns.SQL_TABLE_NAME} where reception_status = 'received' and acceptance_status = 'accepted' and reimbursement_status = 'reimbursed' group by 1,2) e
        on a.order_id = e.order_id
        and c.sku = e.sku
        left join lookup.exchange_rates f
        on date_trunc ('day', a.completed_at) = f."date"
        and a.currency = f.currency

        
    sql_trigger_value: SELECT COUNT(*) FROM ${spree_orders.SQL_TABLE_NAME}
    distkey: order_id
    sortkeys: [order_id, order_tstamp]

  fields:

  - dimension_group: order_time
    type: time
    timeframes: [time, date, hod, week, month]
    sql: ${TABLE}.order_tstamp
    
  - dimension: order_id
    primary_key: true
    sql: ${TABLE}.order_id
  
  - dimension: customer_id
    sql: ${TABLE}.customer_id
    
  - dimension: order_code
    sql: ${TABLE}.order_code

  - dimension: sku
    sql: ${TABLE}.sku
    
  - dimension: price
    type: number
    decimals: 2
    sql: ${TABLE}.price
    format: "%0.2f"
    
  - dimension: currency
    sql: ${TABLE}.currency
  
  - dimension: quantity
    sql: ${TABLE}.quantity
  
  - dimension: gross_revenue
    type: number
    decimals: 2
    sql: ${TABLE}.price * ${TABLE}.quantity
    format: "%0.2f"
    
  - dimension: price_in_gbp
    type: number
    decimals: 2
    sql: ${TABLE}.price_gbp
    format: "£%0.2f"
  
  - dimension: gross_item_revenue_in_gbp
    type: number
    decimals: 2
    sql: ${TABLE}.price_gbp * ${TABLE}.quantity
    format: "£%0.2f"
  
  - dimension: max_selling_price_gbp
    type: number
    decimals: 2
    sql: ${TABLE}.max_selling_price_gbp
    format: "£%0.2f"
  
  - dimension: max_selling_price_tiered
    type: tier
    tiers: [0, 20, 40, 60, 80, 100, 150, 200, 250, 300]
    sql: ${max_selling_price_gbp}

  - dimension: items_returned
    sql: ${TABLE}.items_returned
  
  - dimension: return_reason
    sql: ${TABLE}.return_reason
    
  - dimension: net_reveune_after_returns_gbp
    type: number
    decimals: 2
    sql: ${TABLE}.price_gbp * (${TABLE}.quantity - ${TABLE}.items_returned)
    format: "£%0.2f"

   # MEASURES #
  
  - measure: count_orders
    type: count_distinct
    sql: ${TABLE}.order_id
    
  - measure: count_customers
    type: count_distinct
    sql: ${TABLE}.customer_id  
    
  - measure: distinct_skus_sold
    type: count_distinct
    sql: ${TABLE}.sku
  
  - measure: total_items_sold
    type: sum
    sql: ${TABLE}.quantity
    
  - measure: total_items_returned
    type: sum
    sql: ${TABLE}.items_returned
  
  - measure: items_sold_after_returns
    type: number
    sql: ${total_items_sold} - ${total_items_returned}
    
  - measure: return_rate
    type: number
    decimals: 2
    sql: 100.0 * ${total_items_returned}/NULLIF(${total_items_sold},0)::REAL
    format: "%0.2f%"
    
  - measure: sum_gross_item_revenue_in_gbp
    type: sum
    sql: ${gross_item_revenue_in_gbp}
    format: "£%0.2f"
    
  - dimension: net_item_reveune_after_returns_gbp
    type: sum
    sql: ${net_reveune_after_returns_gbp}
    format: "£%0.2f"
    


