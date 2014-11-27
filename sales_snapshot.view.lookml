- view: sales_snapshot
  derived_table:
    sql: |
        select
        sku,
        
        --yesterday vs day before
        sum(case when date_trunc ('day', order_tstamp) = date_trunc('day', current_date) - 1 then price*quantity else 0 end) as sales_yesterday,
        sum(case when date_trunc ('day', order_tstamp) = date_trunc('day', current_date) - 2 then price*quantity else 0 end) as sales_day_before_yest,
        
        --last 7 days vs previous 7 days
        sum(case when date_trunc ('day', order_tstamp) between date_trunc('day', current_date) - 7 and date_trunc('day', current_date) - 1 then price*quantity else 0 end) as sales_last_7_days,
        sum(case when date_trunc ('day', order_tstamp) between date_trunc('day', current_date) - 14 and date_trunc('day', current_date) - 8 then price*quantity else 0 end) as sales_previous_7_days,
        
        --last 28 days vs previous 28 days
        sum(case when date_trunc ('day', order_tstamp) between date_trunc('day', current_date) - 28 and date_trunc('day', current_date) - 1 then price*quantity else 0 end) as sales_last_28_days,
        sum(case when date_trunc ('day', order_tstamp) between date_trunc('day', current_date) - 56 and date_trunc('day', current_date) - 29 then price*quantity else 0 end) as sales_previous_28_days
        
        
        from
        ${spree_order_items.SQL_TABLE_NAME}
        group by 1
        
    sql_trigger_value: SELECT COUNT(*) FROM ${spree_order_items.SQL_TABLE_NAME}
    distkey: sku
    sortkeys: [sku]


  fields:

  - dimension: sku
    sql: ${TABLE}.sku
   
  - dimension: sales_yesterday
    type: number
    decimals: 2
    sql: ${TABLE}.sales_yesterday
    format: "%0.2f"
   
  - dimension: sales_day_before_yest
    type: number
    decimals: 2
    sql: ${TABLE}.sales_day_before_yest
    format: "%0.2f"
    
  - dimension: sales_last_7_days
    type: number
    decimals: 2
    sql: ${TABLE}.sales_last_7_days
    format: "%0.2f"
    
  - dimension: sales_previous_7_days
    type: number
    decimals: 2
    sql: ${TABLE}.sales_previous_7_days
    format: "%0.2f"

  - dimension: sales_last_28_days
    type: number
    decimals: 2
    sql: ${TABLE}.sales_last_28_days
    format: "%0.2f"
  
  - dimension: sales_previous_28_days
    type: number
    decimals: 2
    sql: ${TABLE}.sales_previous_28_days
    format: "%0.2f"
    
  #measures#
  
  - measure: sum_sales_yesterday
    type: sum
    sql: ${sales_yesterday}
    format: "%0.2f"
  
  - measure: sum_sales_day_before_yest
    type: sum
    sql: ${sales_day_before_yest}
    format: "%0.2f"
  
  - measure: sum_sales_last_7_days
    type: sum
    sql: ${sales_last_7_days}
    format: "%0.2f"
    
  - measure: sum_sales_previous_7_days
    type: sum
    sql: ${sales_previous_7_days}
    format: "%0.2f"
    
  
  - measure: sum_sales_last_28_days
    type: sum
    sql: ${sales_last_28_days}
    format: "%0.2f"
    
  - measure: sum_sales_previous_28_days
    type: sum
    sql: ${sales_previous_28_days}
    format: "%0.2f"
    
  # comparison measures
  
  - measure: day_on_day
    type: number
    decimals: 2
    sql: 100.0 * ${sum_sales_yesterday}/NULLIF(${sum_sales_day_before_yest},0)::REAL
    format: "%0.2f%"
   
  - measure: week_on_week
    type: number
    decimals: 2
    sql: 100.0 * ${sum_sales_last_7_days}/NULLIF(${sum_sales_previous_7_days},0)::REAL
    format: "%0.2f%"
 
  - measure: month_on_month
    type: number
    decimals: 2
    sql: 100.0 * ${sum_sales_last_28_days}/NULLIF(${sum_sales_previous_28_days},0)::REAL
    format: "%0.2f%"