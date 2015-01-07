- view: weekly_sales
  derived_table:
     sql: |
       select
        tw.year_week_number,
        tw.sku,
        
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
        looker_scratch.LKR$G27AYBYCK26P3NF5VXF_daily_sales
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
        looker_scratch.LKR$G27AYBYCK26P3NF5VXF_daily_sales
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
        looker_scratch.LKR$G27AYBYCK26P3NF5VXF_daily_sales
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