- view: weekly_sales
  derived_table:
     sql: |
       select
        tw.year_week_number,
        tw.sku,
        
        week_info_tw.week_start_date as week_start_date_tw,
        week_info_tw.week_end_date as week_end_date_tw,
        week_info_lw.week_start_date as week_start_date_lw,
        week_info_lw.week_end_date as week_end_date_lw,
        week_info_tw_ly.week_start_date as week_start_date_tw_ly,
        week_info_tw_ly.week_end_date as week_end_date_tw_ly,
        
        tw.items_sold as items_sold_tw,
        tw.items_returned as items_returned_tw,
        tw.items_sold_after_returns as items_sold_after_returns_tw,
        tw.gross_item_revenue_gbp as gross_item_revenue_gbp_tw,
        tw.net_item_revenue_gbp as net_item_revenue_gbp_tw,
        tw.gross_item_revenue_post_returns_gbp as gross_item_revenue_post_returns_gbp_tw,
        tw.net_item_revenue_post_returns_gbp as net_item_revenue_post_returns_gbp_tw,
        
        lw.items_sold as items_sold_lw,
        lw.items_returned as items_returned_lw,
        lw.items_sold_after_returns as items_sold_after_returns_lw,
        lw.gross_item_revenue_gbp as gross_item_revenue_gbp_lw,
        lw.net_item_revenue_gbp as net_item_revenue_gbp_lw,
        lw.gross_item_revenue_post_returns_gbp as gross_item_revenue_post_returns_gbp_lw,
        lw.net_item_revenue_post_returns_gbp as net_item_revenue_post_returns_gbp_lw,
        
        tw_ly.items_sold as items_sold_tw_ly,
        tw_ly.items_returned as items_returned_tw_ly,
        tw_ly.items_sold_after_returns as items_sold_after_returns_tw_ly,
        tw_ly.gross_item_revenue_gbp as gross_item_revenue_gbp_tw_ly,
        tw_ly.net_item_revenue_gbp as net_item_revenue_gbp_tw_ly,
        tw_ly.gross_item_revenue_post_returns_gbp as gross_item_revenue_post_returns_gbp_tw_ly,
        tw_ly.net_item_revenue_post_returns_gbp as net_item_revenue_post_returns_gbp_tw_ly,
        
        closing_stock_tw.closing_stock as closing_stock_tw,
        closing_stock_lw.closing_stock as closing_stock_lw,
        closing_stock_tw_ly.closing_stock as closing_stock_tw_ly,
        
        prices_tw.price as price_gbp_tw,
        prices_lw.price as price_gbp_lw,
        prices_tw_ly.price as price_gbp_tw_ly
        
        from
        
        (select
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
        group by 1,2) tw
        
        inner join
        (select
        tw.year_week_number_tw,
        lw.year_week_number_lw,
        wb.year_week_number_wb,
        tw.year_week_number_tw - 100 as year_week_number_tw_ly,
        lw.year_week_number_lw - 100 as year_week_number_lw_ly
        from
        (select year_week_number as year_week_number_tw, rank() over (order by year_week_number) as tw_week_index from lookup.calendar group by 1) tw
        left join
        (select year_week_number as year_week_number_lw, rank() over (order by year_week_number) + 1 as lw_week_index from lookup.calendar group by 1) lw
        on tw.tw_week_index = lw.lw_week_index
        left join
        (select year_week_number as year_week_number_wb, rank() over (order by year_week_number) + 2 as wb_week_index from lookup.calendar group by 1) wb
        on tw.tw_week_index = wb.wb_week_index) week_matrix
        on week_matrix.year_week_number_tw = tw.year_week_number
        
        --JOINS ON WEEK INFO TABLES
        left join (select year_week_number, min(calendar_date) as week_start_date, max(calendar_date) as week_end_date from lookup.calendar group by 1) week_info_tw
        on week_matrix.year_week_number_tw = week_info_tw.year_week_number
        
        left join (select year_week_number, min(calendar_date) as week_start_date, max(calendar_date) as week_end_date from lookup.calendar group by 1) week_info_lw
        on week_matrix.year_week_number_lw = week_info_lw.year_week_number
        
        left join (select year_week_number, min(calendar_date) as week_start_date, max(calendar_date) as week_end_date from lookup.calendar group by 1) week_info_tw_ly
        on week_matrix.year_week_number_tw_ly = week_info_tw_ly.year_week_number
        
        --JOINS ON SALES TABLES FOR LAST WEEK AND LAST YEAR
        left join
        (select
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
        group by 1,2) lw
        on week_matrix.year_week_number_lw = lw.year_week_number
        and tw.sku = lw.sku
        
        left join
        (select
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
        group by 1,2) tw_ly
        on week_matrix.year_week_number_tw_ly = tw_ly.year_week_number
        and tw.sku = tw_ly.sku
        
        --JOINS TO PRICES TABLES FOR THIS WEEK, LAST WEEK AND LAST YEAR
        left join (select * from ${prices.SQL_TABLE_NAME} where currency = 'GBP') prices_tw
        on prices_tw.calendar_date = week_info_tw.week_end_date
        and prices_tw.sku = tw.sku
        
        left join (select * from ${prices.SQL_TABLE_NAME} where currency = 'GBP') prices_lw
        on prices_lw.calendar_date = week_info_lw.week_end_date
        and prices_lw.sku = tw.sku
        
        left join (select * from ${prices.SQL_TABLE_NAME} where currency = 'GBP') prices_tw_ly
        on prices_tw_ly.calendar_date = week_info_tw_ly.week_end_date
        and prices_tw_ly.sku = tw.sku
        
        
        --JOINS TO CLOSING STOCK ON HAND TABLES FOR THIS WEEK, LAST WEEK and LAST YEAR
        left join
        (select
        aaa.year_week_number,
        conv.sku,
        stock_items.count_on_hand as closing_stock
        from 
        (select cal.year_week_number, stock.variant_id, min(stock.spree_timestamp) as spree_timestamp from daily_snapshot.spree_stock_items stock
        left join
        lookup.calendar cal
        on cal.calendar_date = date(stock.spree_timestamp)
        group by 1,2) aaa
        left join
        (select spree_timestamp, variant_id, count_on_hand from daily_snapshot.spree_stock_items) stock_items
        on aaa.spree_timestamp = stock_items.spree_timestamp
        and aaa.variant_id = stock_items.variant_id
        left join
        (select id, sku from daily_snapshot.spree_variants where date(spree_timestamp) = current_date and deleted_at is null) conv
        on aaa.variant_id = conv.id) closing_stock_tw
        on closing_stock_tw.year_week_number = week_matrix.year_week_number_lw
        and closing_stock_tw.sku = tw.sku
        
        left join
        (select
        aaa.year_week_number,
        conv.sku,
        stock_items.count_on_hand as closing_stock
        from 
        (select cal.year_week_number, stock.variant_id, min(stock.spree_timestamp) as spree_timestamp from daily_snapshot.spree_stock_items stock
        left join
        lookup.calendar cal
        on cal.calendar_date = date(stock.spree_timestamp)
        group by 1,2) aaa
        left join
        (select spree_timestamp, variant_id, count_on_hand from daily_snapshot.spree_stock_items) stock_items
        on aaa.spree_timestamp = stock_items.spree_timestamp
        and aaa.variant_id = stock_items.variant_id
        left join
        (select id, sku from daily_snapshot.spree_variants where date(spree_timestamp) = current_date and deleted_at is null) conv
        on aaa.variant_id = conv.id) closing_stock_lw
        on closing_stock_lw.year_week_number = week_matrix.year_week_number_wb
        and closing_stock_lw.sku = tw.sku
        
        left join
        (select
        aaa.year_week_number,
        conv.sku,
        stock_items.count_on_hand as closing_stock
        from 
        (select cal.year_week_number, stock.variant_id, min(stock.spree_timestamp) as spree_timestamp from daily_snapshot.spree_stock_items stock
        left join
        lookup.calendar cal
        on cal.calendar_date = date(stock.spree_timestamp)
        group by 1,2) aaa
        left join
        (select spree_timestamp, variant_id, count_on_hand from daily_snapshot.spree_stock_items) stock_items
        on aaa.spree_timestamp = stock_items.spree_timestamp
        and aaa.variant_id = stock_items.variant_id
        left join
        (select id, sku from daily_snapshot.spree_variants where date(spree_timestamp) = current_date and deleted_at is null) conv
        on aaa.variant_id = conv.id) closing_stock_tw_ly
        on closing_stock_tw_ly.year_week_number = week_matrix.year_week_number_lw_ly
        and closing_stock_tw_ly.sku = tw.sku
        
        where tw.year_week_number > 201446 -- when finery started trading

     sql_trigger_value: SELECT max(calendar_date) FROM ${daily_sales.SQL_TABLE_NAME}
     distkey: sku
     sortkeys: [sku, year_week_number]


  fields:
  
  - dimension: year_week_number
    sql: ${TABLE}.year_week_number
  
  - dimension: year
    sql: left(${TABLE}.year_week_number, 4)
  
  - dimension: week_number
    sql: right(${TABLE}.year_week_number, 2)
  
  - dimension: sku
    sql: ${TABLE}.sku
  
  - dimension: week_start_date_tw
    type: date
    sql: ${TABLE}.week_start_date_tw
  
  - dimension: week_end_date_tw
    type: date
    sql: ${TABLE}.week_end_date_tw
    
  - dimension: week_start_date_lw
    type: date
    sql: ${TABLE}.week_start_date_lw
  
  - dimension: week_end_date_lw
    type: date
    sql: ${TABLE}.week_end_date_lw
    
  - dimension: week_start_date_tw_ly
    type: date
    sql: ${TABLE}.week_start_date_tw_ly
    
  - dimension: week_end_date_tw_ly
    type: date
    sql: ${TABLE}.week_end_date_tw_ly
    
  # STOCK dimensions
  
  - dimension: closing_stock_tw
    sql: ${TABLE}.closing_stock_tw
  
  - dimension: closing_stock_lw
    sql: ${TABLE}.closing_stock_lw
    
  - dimension: closing_stock_tw_ly
    sql: ${TABLE}.closing_stock_tw_ly
    
  # PRICE dimensions
  
  - dimension: price_gbp_tw
    type: number
    decimals: 2
    sql: ${TABLE}.price_gbp_tw
    format: "£%0.2f"
    
  - dimension: price_gbp_lw
    type: number
    decimals: 2
    sql: ${TABLE}.price_gbp_lw
    format: "£%0.2f"
    
  - dimension: price_gbp_tw_ly
    type: number
    decimals: 2
    sql: ${TABLE}.price_gbp_tw_ly
    format: "£%0.2f"
    
  # STOCK_VALUE dimensions
  
  - dimension: stock_value_gbp_tw
    type: number
    decimals: 2
    sql: ${TABLE}.price_gbp_tw * ${TABLE}.closing_stock_tw
    format: "£%0.2f"
    
  - dimension: stock_value_gbp_lw
    type: number
    decimals: 2
    sql: ${TABLE}.price_gbp_lw * ${TABLE}.closing_stock_lw
    format: "£%0.2f"
    
  - dimension: stock_value_gbp_tw_ly
    type: number
    decimals: 2
    sql: ${TABLE}.price_gbp_tw_ly * ${TABLE}.closing_stock_tw_ly
    format: "£%0.2f"
  
  # THIS WEEK dimensions
    
  - dimension: items_sold_tw
    type: int
    sql: ${TABLE}.items_sold_tw

  - dimension: items_returned_tw
    type: int
    sql: ${TABLE}.items_returned_tw
    
  - dimension: items_sold_after_returns_tw
    type: int
    sql: ${TABLE}.items_sold_after_returns_tw
    
  - dimension: gross_item_revenue_gbp_tw
    type: number
    decimals: 2
    sql: ${TABLE}.gross_item_revenue_gbp_tw
    format: "£%0.2f"
    
  - dimension: net_item_revenue_gbp_tw
    type: number
    decimals: 2
    sql: ${TABLE}.net_item_revenue_gbp_tw
    format: "£%0.2f"

  - dimension: gross_item_revenue_post_returns_gbp_tw
    type: number
    decimals: 2
    sql: ${TABLE}.gross_item_revenue_post_returns_gbp_tw
    format: "£%0.2f"
    
  - dimension: net_item_revenue_post_returns_gbp_tw
    type: number
    decimals: 2
    sql: ${TABLE}.net_item_revenue_post_returns_gbp_tw
    format: "£%0.2f"
  
  - dimension: gross_revenue_returned_items_gbp_tw
    type: number
    decimals: 2
    sql: ${TABLE}.gross_item_revenue_gbp_tw - ${TABLE}.gross_item_revenue_post_returns_gbp_tw
    format: "£%0.2f"
    
  - dimension: net_revenue_returned_items_gbp_tw
    type: number
    decimals: 2
    sql: ${TABLE}.net_item_revenue_gbp_tw - ${TABLE}.net_item_revenue_post_returns_gbp_tw
    format: "£%0.2f"
  
  # LAST WEEK dimensions
    
  - dimension: items_sold_lw
    type: int
    sql: ${TABLE}.items_sold_lw

  - dimension: items_returned_lw
    type: int
    sql: ${TABLE}.items_returned_lw
    
  - dimension: items_sold_after_returns_lw
    type: int
    sql: ${TABLE}.items_sold_after_returns_lw
    
  - dimension: gross_item_revenue_gbp_lw
    type: number
    decimals: 2
    sql: ${TABLE}.gross_item_revenue_gbp_lw
    format: "£%0.2f"
    
  - dimension: net_item_revenue_gbp_lw
    type: number
    decimals: 2
    sql: ${TABLE}.net_item_revenue_gbp_lw
    format: "£%0.2f"

  - dimension: gross_item_revenue_post_returns_gbp_lw
    type: number
    decimals: 2
    sql: ${TABLE}.gross_item_revenue_post_returns_gbp_lw
    format: "£%0.2f"
    
  - dimension: net_item_revenue_post_returns_gbp_lw
    type: number
    decimals: 2
    sql: ${TABLE}.net_item_revenue_post_returns_gbp_lw
    format: "£%0.2f"
  
  - dimension: gross_revenue_returned_items_gbp_lw
    type: number
    decimals: 2
    sql: ${TABLE}.gross_item_revenue_gbp_lw - ${TABLE}.gross_item_revenue_post_returns_gbp_lw
    format: "£%0.2f"
    
  - dimension: net_revenue_returned_items_gbp_lw
    type: number
    decimals: 2
    sql: ${TABLE}.net_item_revenue_gbp_lw - ${TABLE}.net_item_revenue_post_returns_gbp_lw
    format: "£%0.2f"
  
  # THIS WEEK LAST YEAR dimensions
    
  - dimension: items_sold_tw_ly
    type: int
    sql: ${TABLE}.items_sold_tw_ly

  - dimension: items_returned_tw_ly
    type: int
    sql: ${TABLE}.items_returned_tw_ly
    
  - dimension: items_sold_after_returns_tw_ly
    type: int
    sql: ${TABLE}.items_sold_after_returns_tw_ly
    
  - dimension: gross_item_revenue_gbp_tw_ly
    type: number
    decimals: 2
    sql: ${TABLE}.gross_item_revenue_gbp_tw_ly
    format: "£%0.2f"
    
  - dimension: net_item_revenue_gbp_tw_ly
    type: number
    decimals: 2
    sql: ${TABLE}.net_item_revenue_gbp_tw_ly
    format: "£%0.2f"

  - dimension: gross_item_revenue_post_returns_gbp_tw_ly
    type: number
    decimals: 2
    sql: ${TABLE}.gross_item_revenue_post_returns_gbp_tw_ly
    format: "£%0.2f"
    
  - dimension: net_item_revenue_post_returns_gbp_tw_ly
    type: number
    decimals: 2
    sql: ${TABLE}.net_item_revenue_post_returns_gbp_tw_ly
    format: "£%0.2f"
  
  - dimension: gross_revenue_returned_items_gbp_tw_ly
    type: number
    decimals: 2
    sql: ${TABLE}.gross_item_revenue_gbp_tw_ly - ${TABLE}.gross_item_revenue_post_returns_gbp_tw_ly
    format: "£%0.2f"
    
  - dimension: net_revenue_returned_items_gbp_tw_ly
    type: number
    decimals: 2
    sql: ${TABLE}.net_item_revenue_gbp_tw_ly - ${TABLE}.net_item_revenue_post_returns_gbp_tw_ly
    format: "£%0.2f"
  
  
  # Intake Dimensions
  
  - dimension: est_intake_qty_tw
    type: int
    #sql: case when (${closing_stock_tw} + ${items_sold_tw} - ${closing_stock_lw}) < 0 then 0 else (${closing_stock_tw} + ${items_sold_tw} - ${closing_stock_lw}) end
    sql: ${closing_stock_tw} + ${items_sold_tw} - ${closing_stock_lw}
  
  - dimension: est_intake_value_gbp_tw
    type: number
    decimals: 2
    sql: ${est_intake_qty_tw} * ${price_gbp_tw}
    format: "£%0.2f"
  
  # Margin Dimensions
  
  - dimension: total_landed_cost_gbp
    type: number
    decimals: 2
    sql: ${product_lookup.total_landed_cost_gbp}
    format: "£%0.2f"
    # margin dimensions this week
  - dimension: cost_of_total_items_gbp_tw
    type: number
    decimals: 2
    sql: ${product_lookup.total_landed_cost_gbp} * ${TABLE}.items_sold_tw
    format: "£%0.2f"
  
  - dimension: profit_gbp_tw
    type: number
    decimals: 2
    sql: ${net_item_revenue_gbp_tw} - ${cost_of_total_items_gbp_tw} 
    format: "£%0.2f"
    # margin dimensions last week
  - dimension: cost_of_total_items_gbp_lw
    type: number
    decimals: 2
    sql: ${product_lookup.total_landed_cost_gbp} * ${TABLE}.items_sold_lw
    format: "£%0.2f"
  
  - dimension: profit_gbp_lw
    type: number
    decimals: 2
    sql: ${net_item_revenue_gbp_lw} - ${cost_of_total_items_gbp_lw} 
    format: "£%0.2f"
    # margin dimensions last year
  - dimension: cost_of_total_items_gbp_tw_ly
    type: number
    decimals: 2
    sql: ${product_lookup.total_landed_cost_gbp} * ${TABLE}.items_sold_tw_ly
    format: "£%0.2f"
  
  - dimension: profit_gbp_tw_ly
    type: number
    decimals: 2
    sql: ${net_item_revenue_gbp_tw_ly} - ${cost_of_total_items_gbp_tw_ly} 
    format: "£%0.2f"
    
  # Availability Dimensions
  
  - dimension: available_on
    type: date
    sql: ${online_products.available_on_date}
    
  - dimension: product_online_tw
    type: yesno
    sql: ${online_products.available_on_date} <= ${week_end_date_tw}
  
  - dimension: product_online_lw
    type: yesno
    sql: ${online_products.available_on_date} <= ${week_end_date_lw}
  
  - dimension: product_online_tw_ly
    type: yesno
    sql: ${online_products.available_on_date} <= ${week_end_date_tw_ly}
    
  - dimension: product_in_stock_tw
    type: yesno
    sql: ${closing_stock_tw} > 0

  - dimension: product_in_stock_lw
    type: yesno
    sql: ${closing_stock_lw} > 0
    
  - dimension: product_in_stock_tw_ly
    type: yesno
    sql: ${closing_stock_tw_ly} > 0
    
  - dimension: style
    sql: ${product_lookup.style}
  
  - dimension: option
    sql: ${product_lookup.option_name}

  # THIS WEEK measures
  
  - measure: sum_items_sold_tw
    type: sum
    sql: ${items_sold_tw}

  - measure: sum_items_returned_tw
    type: sum
    sql: ${items_returned_tw}
    
  - measure: sum_items_sold_after_returns_tw
    type: sum
    sql: ${items_sold_after_returns_tw}
    
  - measure: sum_gross_item_revenue_gbp_tw
    type: sum
    sql: ${gross_item_revenue_gbp_tw}
    format: "£%0.2f"
    
  - measure: sum_net_item_revenue_gbp_tw
    type: sum
    sql: ${net_item_revenue_gbp_tw}
    format: "£%0.2f"

  - measure: sum_gross_item_revenue_post_returns_gbp_tw
    type: sum
    sql: ${gross_item_revenue_post_returns_gbp_tw}
    format: "£%0.2f"
    
  - measure: sum_net_item_revenue_post_returns_gbp_tw
    type: sum
    sql: ${net_item_revenue_post_returns_gbp_tw}
    format: "£%0.2f"
  
  - measure: sum_gross_revenue_returned_items_gbp_tw
    type: sum
    sql: ${gross_revenue_returned_items_gbp_tw}
    format: "£%0.2f"
    
  - measure: sum_net_revenue_returned_items_gbp_tw
    type: sum
    sql: ${net_revenue_returned_items_gbp_tw}
    format: "£%0.2f"
    
   # LAST WEEK measures
  
  - measure: sum_items_sold_lw
    type: sum
    sql: ${items_sold_lw}

  - measure: sum_items_returned_lw
    type: sum
    sql: ${items_returned_lw}
    
  - measure: sum_items_sold_after_returns_lw
    type: sum
    sql: ${items_sold_after_returns_lw}
    
  - measure: sum_gross_item_revenue_gbp_lw
    type: sum
    sql: ${gross_item_revenue_gbp_lw}
    format: "£%0.2f"
    
  - measure: sum_net_item_revenue_gbp_lw
    type: sum
    sql: ${net_item_revenue_gbp_lw}
    format: "£%0.2f"

  - measure: sum_gross_item_revenue_post_returns_gbp_lw
    type: sum
    sql: ${gross_item_revenue_post_returns_gbp_lw}
    format: "£%0.2f"
    
  - measure: sum_net_item_revenue_post_returns_gbp_lw
    type: sum
    sql: ${net_item_revenue_post_returns_gbp_lw}
    format: "£%0.2f"
  
  - measure: sum_gross_revenue_returned_items_gbp_lw
    type: sum
    sql: ${gross_revenue_returned_items_gbp_lw}
    format: "£%0.2f"
    
  - measure: sum_net_revenue_returned_items_gbp_lw
    type: sum
    sql: ${net_revenue_returned_items_gbp_lw}
    format: "£%0.2f"
    
 # THIS WEEK LAST YEAR measures
  
  - measure: sum_items_sold_tw_ly
    type: sum
    sql: ${items_sold_tw_ly}

  - measure: sum_items_returned_tw_ly
    type: sum
    sql: ${items_returned_tw_ly}
    
  - measure: sum_items_sold_after_returns_tw_ly
    type: sum
    sql: ${items_sold_after_returns_tw_ly}
    
  - measure: sum_gross_item_revenue_gbp_tw_ly
    type: sum
    sql: ${gross_item_revenue_gbp_tw_ly}
    format: "£%0.2f"
    
  - measure: sum_net_item_revenue_gbp_tw_ly
    type: sum
    sql: ${net_item_revenue_gbp_tw_ly}
    format: "£%0.2f"

  - measure: sum_gross_item_revenue_post_returns_gbp_tw_ly
    type: sum
    sql: ${gross_item_revenue_post_returns_gbp_tw_ly}
    format: "£%0.2f"
    
  - measure: sum_net_item_revenue_post_returns_gbp_tw_ly
    type: sum
    sql: ${net_item_revenue_post_returns_gbp_tw_ly}
    format: "£%0.2f"
  
  - measure: sum_gross_revenue_returned_items_gbp_tw_ly
    type: sum
    sql: ${gross_revenue_returned_items_gbp_tw_ly}
    format: "£%0.2f"
    
  - measure: sum_net_revenue_returned_items_gbp_tw_ly
    type: sum
    sql: ${net_revenue_returned_items_gbp_tw_ly}
    format: "£%0.2f"
    
  # Stock measures
  
  - measure: sum_closing_stock_tw
    type: sum
    sql: ${closing_stock_tw}
  
  - measure: sum_closing_stock_lw
    type: sum
    sql: ${closing_stock_lw}
    
  - dimension: sum_closing_stock_tw_ly
    type: sum
    sql: ${closing_stock_tw_ly}
  
  # Cover Measures
  
  - measure: weeks_cover_tw
    type: number
    decimals: 1
    sql: (${sum_closing_stock_tw}/NULLIF(${sum_items_sold_tw},0)::REAL)/7
  
  - measure: weeks_cover_lw
    type: number
    decimals: 1
    sql: (${sum_closing_stock_lw}/NULLIF(${sum_items_sold_lw},0)::REAL)/7
    
  - dimension: weeks_cover_tw_ly
    type: number
    decimals: 1
    sql: (${sum_closing_stock_tw_ly}/NULLIF(${sum_items_sold_tw_ly},0)::REAL)/7
  
  # Stock Value measures
  
  - measure: sum_stock_value_gbp_tw
    type: sum
    sql: ${stock_value_gbp_tw}
    format: "£%0.2f"
  
  - measure: sum_stock_value_gbp_lw
    type: sum
    sql: ${stock_value_gbp_lw}
    format: "£%0.2f"

  - measure: sum_stock_value_gbp_tw_ly
    type: sum
    sql: ${stock_value_gbp_tw_ly}
    format: "£%0.2f"

  # Intake Measures
  
  - measure: sum_est_intake_qty_tw
    type: sum
    sql: ${est_intake_qty_tw}
  
  - dimension: sum_est_intake_value_gbp_tw
    type: sum
    sql: ${est_intake_value_gbp_tw}
    format: "£%0.2f"

  # Availability Measures THIS WEEK
  
  - measure: styles_online_tw
    type: count_distinct
    sql: ${style}
    filters:
      product_online_tw: yes
  
  - measure: options_online_tw
    type: count_distinct
    sql: ${option}
    filters:
      product_online_tw: yes
  
  - measure: skus_online_tw
    type: count_distinct
    sql: ${sku}
    filters:
      product_online_tw: yes
  
  - measure: styles_online_in_stock_tw
    type: count_distinct
    sql: ${style}
    filters:
      product_online_tw: yes
      product_in_stock_tw: yes
  
  - measure: options_online_in_stock_tw
    type: count_distinct
    sql: ${option}
    filters:
      product_online_tw: yes
      product_in_stock_tw: yes
      
  - measure: skus_online_in_stock_tw
    type: count_distinct
    sql: ${sku}
    filters:
      product_online_tw: yes
      product_in_stock_tw: yes
      
  - measure: style_availability_tw
    type: number
    decimals: 1
    sql: 100.0 * ${styles_online_in_stock_tw}/NULLIF(${styles_online_tw},0)::REAL
    format: "%0.2f%"
  
  - measure: option_availability_tw
    type: number
    decimals: 1
    sql: 100.0 * ${options_online_in_stock_tw}/NULLIF(${options_online_tw},0)::REAL
    format: "%0.2f%"
  
  - measure: size_availability_tw
    type: number
    decimals: 1
    sql: 100.0 * ${skus_online_in_stock_tw}/NULLIF(${skus_online_tw},0)::REAL
    format: "%0.2f%"

  # Availability Measures LAST WEEK

  - measure: styles_online_lw
    type: count_distinct
    sql: ${style}
    filters:
      product_online_lw: yes
  
  - measure: options_online_lw
    type: count_distinct
    sql: ${option}
    filters:
      product_online_lw: yes
  
  - measure: skus_online_lw
    type: count_distinct
    sql: ${sku}
    filters:
      product_online_lw: yes
  
  - measure: styles_online_in_stock_lw
    type: count_distinct
    sql: ${style}
    filters:
      product_online_lw: yes
      product_in_stock_lw: yes
  
  - measure: options_online_in_stock_lw
    type: count_distinct
    sql: ${option}
    filters:
      product_online_lw: yes
      product_in_stock_lw: yes
      
  - measure: skus_online_in_stock_lw
    type: count_distinct
    sql: ${sku}
    filters:
      product_online_lw: yes
      product_in_stock_lw: yes
      
  - measure: style_availability_lw
    type: number
    decimals: 1
    sql: 100.0 * ${styles_online_in_stock_lw}/NULLIF(${styles_online_lw},0)::REAL
    format: "%0.2f%"
  
  - measure: option_availability_lw
    type: number
    decimals: 1
    sql: 100.0 * ${options_online_in_stock_lw}/NULLIF(${options_online_lw},0)::REAL
    format: "%0.2f%"
  
  - measure: size_availability_lw
    type: number
    decimals: 1
    sql: 100.0 * ${skus_online_in_stock_lw}/NULLIF(${skus_online_lw},0)::REAL
    format: "%0.2f%"

  # Availability Measures LAST YEAR
  
  - measure: styles_online_tw_ly
    type: count_distinct
    sql: ${style}
    filters:
      product_online_tw_ly: yes
  
  - measure: options_online_tw_ly
    type: count_distinct
    sql: ${option}
    filters:
      product_online_tw_ly: yes
  
  - measure: skus_online_tw_ly
    type: count_distinct
    sql: ${sku}
    filters:
      product_online_tw_ly: yes
  
  - measure: styles_online_in_stock_tw_ly
    type: count_distinct
    sql: ${style}
    filters:
      product_online_tw_ly: yes
      product_in_stock_tw_ly: yes
  
  - measure: options_online_in_stock_tw_ly
    type: count_distinct
    sql: ${option}
    filters:
      product_online_tw_ly: yes
      product_in_stock_tw_ly: yes
      
  - measure: skus_online_in_stock_tw_ly
    type: count_distinct
    sql: ${sku}
    filters:
      product_online_tw_ly: yes
      product_in_stock_tw_ly: yes
      
  - measure: style_availability_tw_ly
    type: number
    decimals: 1
    sql: 100.0 * ${styles_online_in_stock_tw_ly}/NULLIF(${styles_online_tw_ly},0)::REAL
    format: "%0.2f%"
  
  - measure: option_availability_tw_ly
    type: number
    decimals: 1
    sql: 100.0 * ${options_online_in_stock_tw_ly}/NULLIF(${options_online_tw_ly},0)::REAL
    format: "%0.2f%"
  
  - measure: size_availability_tw_ly
    type: number
    decimals: 1
    sql: 100.0 * ${skus_online_in_stock_tw_ly}/NULLIF(${skus_online_tw_ly},0)::REAL
    format: "%0.2f%"
    
  # WEEK ON WEEK measures
  
  - measure: gross_item_revenue_wow
    type: number
    decimals: 2
    sql: 100.0 * (${sum_gross_item_revenue_gbp_tw} - ${sum_gross_item_revenue_gbp_lw})/NULLIF(${sum_gross_item_revenue_gbp_lw},0)::REAL
    format: "%0.2f%"
  
  - measure: net_item_revenue_wow
    type: number
    decimals: 2
    sql: 100.0 * (${sum_net_item_revenue_gbp_tw} - ${sum_net_item_revenue_gbp_lw})/NULLIF(${sum_net_item_revenue_gbp_lw},0)::REAL
    format: "%0.2f%"
  
  
  # YEAR ON YEAR measures
  
  - measure: gross_item_revenue_yoy
    type: number
    decimals: 2
    sql: 100.0 * (${sum_gross_item_revenue_gbp_tw} - ${sum_gross_item_revenue_gbp_tw_ly})/NULLIF(${sum_gross_item_revenue_gbp_tw_ly},0)::REAL
    format: "%0.2f%"
  
  - measure: net_item_revenue_yoy
    type: number
    decimals: 2
    sql: 100.0 * (${sum_net_item_revenue_gbp_tw} - ${sum_net_item_revenue_gbp_tw_ly})/NULLIF(${sum_net_item_revenue_gbp_tw_ly},0)::REAL
    format: "%0.2f%"
    
  - measure: stock_value_yoy
    type: number
    decimals: 2
    sql: 100.0 * (${sum_stock_value_gbp_tw} - ${sum_stock_value_gbp_tw_ly}) /NULLIF(${sum_stock_value_gbp_tw_ly},0)::REAL
    format: "%0.2f%"
    
  # RETURNS measures
  
  - measure: return_rate_items
    type: number
    decimals: 2
    sql: 100.0 * ${sum_items_returned_tw}/NULLIF(${sum_items_sold_tw},0)::REAL
    format: "%0.2f%"
    
  - measure: return_rate_value
    type: number
    decimals: 2
    sql: 100.0 * ${sum_gross_revenue_returned_items_gbp_tw}/NULLIF(${sum_gross_item_revenue_gbp_tw},0)::REAL
    format: "%0.2f%"
    
  # GROSS MARGIN measures
    #this week
  - measure: sum_cost_of_total_items_gbp_tw
    type: sum
    sql: ${cost_of_total_items_gbp_tw}
    format: "£%0.2f"
  
  - measure: sum_profit_gbp_tw
    type: sum
    sql: ${profit_gbp_tw}
    format: "£%0.2f"
  
  - measure: gross_margin_tw
    type: number
    decimals: 2
    sql: 100.0 * ${sum_profit_gbp_tw}/NULLIF(${sum_net_item_revenue_gbp_tw},0)::REAL
    format: "%0.2f%"
    # last week
  - measure: sum_cost_of_total_items_gbp_lw
    type: sum
    sql: ${cost_of_total_items_gbp_lw}
    format: "£%0.2f"
  
  - measure: sum_profit_gbp_lw
    type: sum
    sql: ${profit_gbp_lw}
    format: "£%0.2f"
  
  - measure: gross_margin_lw
    type: number
    decimals: 2
    sql: 100.0 * ${sum_profit_gbp_lw}/NULLIF(${sum_net_item_revenue_gbp_lw},0)::REAL
    format: "%0.2f%"
    # last year
  - measure: sum_cost_of_total_items_gbp_tw_ly
    type: sum
    sql: ${cost_of_total_items_gbp_tw_ly}
    format: "£%0.2f"
  
  - measure: sum_profit_gbp_tw_ly
    type: sum
    sql: ${profit_gbp_tw_ly}
    format: "£%0.2f"
  
  - measure: gross_margin_tw_ly
    type: number
    decimals: 2
    sql: 100.0 * ${sum_profit_gbp_tw_ly}/NULLIF(${sum_net_item_revenue_gbp_tw_ly},0)::REAL
    format: "%0.2f%"
  
  # MIX measures
  - measure: mix_gross_item_revenue_gbp_tw
    type: percent_of_total
    decimals: 1
    sql: ${sum_gross_item_revenue_gbp_tw}
    
  - measure: mix_net_item_revenue_gbp_tw
    type: percent_of_total
    decimals: 1
    sql: ${sum_net_item_revenue_gbp_tw}
    
 