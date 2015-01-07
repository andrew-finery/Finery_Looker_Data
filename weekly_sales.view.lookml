- view: weekly_sales
  derived_table:
     sql: |
       select
        year_week_number,
        sku,
        sum(items_sold) as items_sold,
        sum(items_returned) as items_returned,
        sum(items_sold_after_returns) as items_sold_after_returns,
        sum(gross_item_revenue_gbp) as gross_item_revenue_gbp,
        sum(net_item_revenue_gbp) as net_item_revenue_gbp,
        sum(gross_item_revenue_post_returns_gbp) as gross_item_revenue_post_returns_gbp,
        sum(net_item_revenue_post_returns_gbp) as net_item_revenue_post_returns_gbp
        from
        ${daily_sales.SQL_TABLE_NAME}
        group by 1,2


  fields:
  
  - dimension: year_week_number
    sql: ${TABLE}.year_week_number
    
  - dimension: sku
    sql: ${TABLE}.sku
    
  - dimension: items_sold
    type: int
    sql: ${TABLE}.items_sold

  - dimension: items_returned
    type: int
    sql: ${TABLE}.items_returned
    
  - dimension: items_sold_after_returns
    type: int
    sql: ${TABLE}.items_sold_after_returns
    
  - dimension: gross_item_revenue_gbp
    type: number
    decimals: 2
    sql: ${TABLE}.gross_item_revenue_gbp
    format: "£%0.2f"
    
  - dimension: net_item_revenue_gbp
    type: number
    decimals: 2
    sql: ${TABLE}.net_item_revenue_gbp
    format: "£%0.2f"

  - dimension: gross_item_revenue_post_returns_gbp
    type: number
    decimals: 2
    sql: ${TABLE}.gross_item_revenue_post_returns_gbp
    format: "£%0.2f"
    
  - dimension: net_item_revenue_post_returns_gbp
    type: number
    decimals: 2
    sql: ${TABLE}.net_item_revenue_post_returns_gbp
    format: "£%0.2f"
  
  - dimension: gross_revenue_returned_items_gbp
    type: number
    decimals: 2
    sql: ${TABLE}.gross_item_revenue_gbp - ${TABLE}.gross_item_revenue_post_returns_gbp
    format: "£%0.2f"
    
  - dimension: net_revenue_returned_items_gbp
    type: number
    decimals: 2
    sql: ${TABLE}.net_item_revenue_gbp - ${TABLE}.net_item_revenue_post_returns_gbp
    format: "£%0.2f"
  
  # Measures
  
  - measure: sum_items_sold
    type: sum
    sql: ${items_sold}

  - dimension: sum_items_returned
    type: sum
    sql: ${items_returned}
    
  - dimension: sum_items_sold_after_returns
    type: sum
    sql: ${items_sold_after_returns}
    
  - dimension: sum_gross_item_revenue_gbp
    type: sum
    sql: ${gross_item_revenue_gbp}
    format: "£%0.2f"
    
  - dimension: sum_net_item_revenue_gbp
    type: sum
    sql: ${net_item_revenue_gbp}
    format: "£%0.2f"

  - dimension: sum_gross_item_revenue_post_returns_gbp
    type: sum
    sql: ${gross_item_revenue_post_returns_gbp}
    format: "£%0.2f"
    
  - dimension: sum_net_item_revenue_post_returns_gbp
    type: sum
    sql: ${net_item_revenue_post_returns_gbp}
    format: "£%0.2f"
  
  - dimension: sum_gross_revenue_returned_items_gbp
    type: sum
    sql: ${gross_revenue_returned_items_gbp}
    format: "£%0.2f"
    
  - dimension: sum_net_revenue_returned_items_gbp
    type: sum
    sql: ${net_revenue_returned_items_gbp}
    format: "£%0.2f"