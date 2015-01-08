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
        closing_stock_wb.closing_stock as closing_stock_wb
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
        
        left join (select year_week_number, min(calendar_date) as week_start_date, max(calendar_date) as week_end_date from lookup.calendar group by 1) week_info_tw
        on week_matrix.year_week_number_tw = week_info_tw.year_week_number
        
        left join (select year_week_number, min(calendar_date) as week_start_date, max(calendar_date) as week_end_date from lookup.calendar group by 1) week_info_lw
        on week_matrix.year_week_number_lw = week_info_lw.year_week_number
        
        left join (select year_week_number, min(calendar_date) as week_start_date, max(calendar_date) as week_end_date from lookup.calendar group by 1) week_info_tw_ly
        on week_matrix.year_week_number_tw_ly = week_info_tw_ly.year_week_number
        
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
        on aaa.variant_id = conv.id) closing_stock_wb
        on closing_stock_wb.year_week_number = week_matrix.year_week_number_wb
        and closing_stock_wb.sku = tw.sku
        
        where tw.year_week_number > 201446 -- when finery started trading


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
  
  # Other Dimensions
  
  - dimension: available_on
    type: date
    
  
  - dimension: online_flag
  
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
    
  # WEEK ON WEEK measures
  
  - measure: gross_item_revenue_wow
    type: number
    decimals: 2
    sql: 100.0 * ${sum_gross_item_revenue_gbp_tw}/NULLIF(${sum_gross_item_revenue_gbp_lw},0)::REAL
    format: "%0.2f%"
  
  - measure: net_item_revenue_wow
    type: number
    decimals: 2
    sql: 100.0 * ${sum_net_item_revenue_gbp_tw}/NULLIF(${sum_net_item_revenue_gbp_lw},0)::REAL
    format: "%0.2f%"
  
  # YEAR ON YEAR measures
  
  
  - measure: gross_item_revenue_yoy
    type: number
    decimals: 2
    sql: 100.0 * ${sum_gross_item_revenue_gbp_tw}/NULLIF(${sum_gross_item_revenue_gbp_tw_ly},0)::REAL
    format: "%0.2f%"
  
  - measure: net_item_revenue_yoy
    type: number
    decimals: 2
    sql: 100.0 * ${sum_net_item_revenue_gbp_tw}/NULLIF(${sum_net_item_revenue_gbp_tw_ly},0)::REAL
    format: "%0.2f%"
    
  # Other measures
  
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