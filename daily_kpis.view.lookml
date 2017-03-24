- view: daily_kpis
  derived_table:
     sql: |
           with step_1 as (
            SELECT 
            DATE(cast(reporting_starts as date)) AS calendar_date,
            COALESCE(SUM((amount_spent_gbp * (1 + 0.0155))), 0) AS facebook_spend
            FROM facebook_data.facebook_ad_performance
            GROUP BY 1
           )
           
           , step_2 as (
            SELECT 
            DATE(completed_at) AS calendar_date,
            COUNT(DISTINCT order_id) AS orders,
            COALESCE(SUM((item_total + shipment_total - (adjustment_total * (-1)) ) / exchange_rate), 0) AS gross_revenue
            FROM sales.orders
            WHERE reason_to_strip_out is null
            group by 1
           )
           
           , step_3 as (
           SELECT 
           DATE(cast(date as date)) AS calendar_date, 
           spend as daily_affiliate_fix_spend
           FROM affiliate_data.fixed_fee_daily
           )

           
           select
           a.calendar_date,
           a.facebook_spend,
           b.orders,
           b.gross_revenue,
           c.daily_affiliate_fix_spend
           from
           step_1 a
           left join step_2 b on a.calendar_date = b.calendar_date
           left join step_3 c on a.calendar_date = c.calendar_date

  fields:

# Dimensions

  - dimension_group: calendar
    type: time
    timeframes: [date, day_of_week_index, day_of_week, week, week_of_year, day_of_month, month, month_num, year, quarter, quarter_of_year]
    sql: ${TABLE}.calendar_date
  
  - dimension: facebook_spend
    type: number
    value_format_name: decimal_2
    sql: ${TABLE}.facebook_spend
    
  - dimension: daily_affiliate_fix_spend
    type: number
    value_format_name: decimal_2
    sql: ${TABLE}.daily_affiliate_fix_spend
  
  - dimension: orders
    type: number
    sql: ${TABLE}.orders
    
  - dimension: gross_revenue
    type: number
    value_format_name: decimal_2
    sql: ${TABLE}.gross_revenue


# Measures

  - measure: sum_daily_affiliate_fix_spend
    type: sum
    value_format_name: decimal_2
    sql: ${daily_affiliate_fix_spend}
    
  - measure: sum_facebook_spend
    type: sum
    sql: ${facebook_spend}
  
  - measure: sum_orders
    type: sum
    sql: ${orders}
    
  - measure: sum_gross_revenue
    type: sum
    sql: ${gross_revenue}
  