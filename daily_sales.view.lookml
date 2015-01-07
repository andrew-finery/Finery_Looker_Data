- view: daily_sales
  derived_table:
   sql: |
          select
            matrix.calendar_date,
            matrix.year_week_number,
            matrix.sku,
            coalesce(opening.opening_stock, '0') as opening_stock,
            coalesce(closing.closing_stock, '0') as closing_stock,
            coalesce(sales.items_sold, '0') as items_sold,
            coalesce(sales.items_returned, '0') as items_returned,
            coalesce(sales.items_sold_after_returns, '0') as items_sold_after_returns,
            coalesce(sales.gross_item_revenue_gbp, '0') as gross_item_revenue_gbp,
            coalesce(sales.net_item_revenue_gbp, '0') as net_item_revenue_gbp,
            coalesce(sales.gross_item_revenue_post_returns_gbp, '0') as gross_item_revenue_post_returns_gbp,
            coalesce(sales.net_item_revenue_post_returns_gbp, '0') as net_item_revenue_post_returns_gbp
            
            from 
            
            (select aaa.sku, aaa.variant_id, bbb.calendar_date, bbb.year_week_number from
            (select a.variant_id, b.sku from      
            (select * from daily_snapshot.spree_stock_items where date(spree_timestamp) = current_date) a
            inner join
            (select * from daily_snapshot.spree_variants where date(spree_timestamp) = current_date and deleted_at is null) b
            on a.variant_id = b.id
            and a.updated_at > date '2014-11-11'
            and b.sku <> ' '
            group by 1,2) aaa
            cross join
            (select calendar_date, year_week_number from lookup.calendar)bbb
            where bbb.calendar_date < current_date) matrix
            
            left join
            
            (select abc.calendar_date, abc.variant_id, def.count_on_hand as opening_stock from
            (select date(spree_timestamp) as calendar_date, variant_id, min(spree_timestamp) as spree_timestamp from daily_snapshot.spree_stock_items group by 1,2) abc
            left join
            daily_snapshot.spree_stock_items def
            on abc.variant_id = def.variant_id
            and abc.spree_timestamp = def.spree_timestamp) opening
            on opening.calendar_date = matrix.calendar_date
            and opening.variant_id = matrix.variant_id
            
            left join
            
            (select abc.calendar_date - 1 as calendar_date, abc.variant_id, def.count_on_hand as closing_stock from
            (select date(spree_timestamp) as calendar_date, variant_id, min(spree_timestamp) as spree_timestamp from daily_snapshot.spree_stock_items group by 1,2) abc
            left join
            daily_snapshot.spree_stock_items def
            on abc.variant_id = def.variant_id
            and abc.spree_timestamp = def.spree_timestamp) closing
            on closing.calendar_date = matrix.calendar_date
            and closing.variant_id = matrix.variant_id
            
            left join
            
            (select
            date(order_tstamp) as sales_date,
            sku,
            sum(quantity) as items_sold,
            sum(items_returned) as items_returned,
            sum(quantity - items_returned) as items_sold_after_returns,
            count(distinct order_id) as orders_placed,
            sum(max_selling_price_gbp * quantity) as gross_item_revenue_gbp,
            sum(price_gbp * quantity) as net_item_revenue_gbp,
            sum(max_selling_price_gbp * (quantity - items_returned)) as gross_item_revenue_post_returns_gbp,
            sum(price_gbp * (quantity - items_returned)) as net_item_revenue_post_returns_gbp
            from
            ${spree_order_items.SQL_TABLE_NAME}
            group by 1,2) sales
            on sales.sales_date = matrix.calendar_date
            and sales.sku = matrix.sku
            
   sql_trigger_value: SELECT max(spree_timestamp) FROM ${spree_order_items.SQL_TABLE_NAME}
   distkey: sku
   sortkeys: [sku]



  fields:
  
  - dimension_group: calendar_date
    type: time
    timeframes: [date, dow, dow_num, week, dom, month, month_num]
    convert_tz: false
    sql: ${TABLE}.calendar_date

  - dimension: year_week_number
    sql: ${TABLE}.year_week_number
    
  - dimension: sku
    sql: ${TABLE}.sku
    
  - dimension: opening_stock
    type: int
    sql: ${TABLE}.opening_stock
    
  - dimension: closing_stock
    type: int
    sql: ${TABLE}.closing_stock
    
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
  
  - measure: first_date
    type: date
    sql: MIN(${calendar_date_date})
    convert_tz: false
    
  - measure: last_date
    type: date
    sql: MAX(${calendar_date_date})
    convert_tz: false
    
    #Nicole Trying Stuff
  - measure: start_week_value
    type: number
    required_fields: [year_week_number, opening_stock]
    sql: FIRST_VALUE(${opening_stock}) OVER (PARTITION BY ${year_week_number}) # ORDER BY ${calendar_date_date} rows between unbounded preceding and unbounded following)
    
  
     
    
  
    
    
    