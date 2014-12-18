- view: sales_snapshot
  derived_table:
    sql: |
        select
            a.sku,
            a.count_on_hand,
            b.max_selling_price_gbp,
            
            --yesterday vs day before
            sum(case when date_trunc ('day', order_tstamp) = date_trunc('day', current_date) - 1 then price*quantity*exchange_rate else 0 end) as sales_yesterday,
            sum(case when date_trunc ('day', order_tstamp) = date_trunc('day', current_date) - 2 then price*quantity*exchange_rate else 0 end) as sales_day_before_yest,
            
            --last 7 days vs previous 7 days
            sum(case when date_trunc ('day', order_tstamp) between date_trunc('day', current_date) - 7 and date_trunc('day', current_date) - 1 then price*quantity*exchange_rate else 0 end) as sales_last_7_days,
            sum(case when date_trunc ('day', order_tstamp) between date_trunc('day', current_date) - 14 and date_trunc('day', current_date) - 8 then price*quantity*exchange_rate else 0 end) as sales_previous_7_days,
            
            --last 28 days vs previous 28 days
            sum(case when date_trunc ('day', order_tstamp) between date_trunc('day', current_date) - 28 and date_trunc('day', current_date) - 1 then price*quantity*exchange_rate else 0 end) as sales_last_28_days,
            sum(case when date_trunc ('day', order_tstamp) between date_trunc('day', current_date) - 56 and date_trunc('day', current_date) - 29 then price*quantity*exchange_rate else 0 end) as sales_previous_28_days,
            
            --QUANTITIES
            --yesterday vs day before
            sum(case when date_trunc ('day', order_tstamp) = date_trunc('day', current_date) - 1 then quantity else 0 end) as sales_yesterday_qty,
            sum(case when date_trunc ('day', order_tstamp) = date_trunc('day', current_date) - 2 then quantity else 0 end) as sales_day_before_yest_qty,
            
            --last 7 days vs previous 7 days
            sum(case when date_trunc ('day', order_tstamp) between date_trunc('day', current_date) - 7 and date_trunc('day', current_date) - 1 then quantity else 0 end) as sales_last_7_days_qty,
            sum(case when date_trunc ('day', order_tstamp) between date_trunc('day', current_date) - 14 and date_trunc('day', current_date) - 8 then quantity else 0 end) as sales_previous_7_days_qty,
            
            --last 28 days vs previous 28 days
            sum(case when date_trunc ('day', order_tstamp) between date_trunc('day', current_date) - 28 and date_trunc('day', current_date) - 1 then quantity else 0 end) as sales_last_28_days_qty,
            sum(case when date_trunc ('day', order_tstamp) between date_trunc('day', current_date) - 56 and date_trunc('day', current_date) - 29 then quantity else 0 end) as sales_previous_28_days_qty
                        
            
            from
            
            ${spree_stock_items.SQL_TABLE_NAME} a
            
            left join
            
            (select a.order_tstamp as order_tstamp,
            a.order_id as order_id,
            a.customer_id as customer_id,
            a.order_code as order_code,
            a.sku as sku,
            a.price as price,
            a.currency as currency,
            a.quantity as quantity,
            a.max_selling_price_gbp as max_selling_price_gbp,
            b.exchange_rate as exchange_rate
            from ${spree_order_items.SQL_TABLE_NAME} a
            left join lookup.exchange_rates b
            on date_trunc ('day', a.order_tstamp) = b."date"
            and a.currency = b.currency) b
            on a.sku = b.sku
            
            group by 1,2,3

    sql_trigger_value: SELECT max(spree_timestamp) FROM ${spree_order_items.SQL_TABLE_NAME}
    distkey: sku
    sortkeys: [sku]


  fields:

  - dimension: sku
    sql: ${TABLE}.sku
    
  - dimension: max_selling_price_gbp
    type: number
    decimals: 2
    sql: ${TABLE}.max_selling_price_gbp
    format: "£%0.2f"
  
  - dimension: selling_price_tiered
    type: tier
    tiers: [0, 20, 40, 60, 80, 100, 150, 200, 250, 300]
    sql: ${max_selling_price_gbp}
   
  - dimension: sales_yesterday
    type: number
    decimals: 2
    sql: ${TABLE}.sales_yesterday
    format: "£%0.2f"
   
  - dimension: sales_day_before_yest
    type: number
    decimals: 2
    sql: ${TABLE}.sales_day_before_yest
    format: "£%0.2f"
    
  - dimension: sales_last_7_days
    type: number
    decimals: 2
    sql: ${TABLE}.sales_last_7_days
    format: "£%0.2f"
    
  - dimension: sales_previous_7_days
    type: number
    decimals: 2
    sql: ${TABLE}.sales_previous_7_days
    format: "£%0.2f"

  - dimension: sales_last_28_days
    type: number
    decimals: 2
    sql: ${TABLE}.sales_last_28_days
    format: "£%0.2f"
  
  - dimension: sales_previous_28_days
    type: number
    decimals: 2
    sql: ${TABLE}.sales_previous_28_days
    format: "£%0.2f"
  
  - dimension: sales_yesterday_qty
    type: int
    sql: ${TABLE}.sales_yesterday_qty

  - dimension: sales_day_before_yest_qty
    type: int
    sql: ${TABLE}.sales_day_before_yest_qty

  - dimension: sales_last_7_days_qty
    type: int
    sql: ${TABLE}.sales_last_7_days_qty

  - dimension: sales_previous_7_days_qty
    type: int
    sql: ${TABLE}.sales_previous_7_days_qty

  - dimension: sales_last_28_days_qty
    type: int
    sql: ${TABLE}.sales_last_28_days_qty

  - dimension: sales_previous_28_days_qty
    type: int
    sql: ${TABLE}.sales_previous_28_days_qty
  
  - dimension: count_on_hand_qty
    sql: ${TABLE}.count_on_hand  
  
  - dimension: count_on_hand_gbp
    sql: ${TABLE}.count_on_hand*${line_detail_re15.uk_selling_price}
  
  - dimension: days_cover
    type: number
    decimals: 2
    sql: 7.0 * ${count_on_hand_qty}/NULLIF(${sales_last_7_days_qty},0)::REAL

  #measures#
  
  - measure: sum_sales_yesterday
    type: sum
    sql: ${sales_yesterday}
    format: "£%0.2f"
  
  - measure: sum_sales_day_before_yest
    type: sum
    sql: ${sales_day_before_yest}
    format: "£%0.2f"
  
  - measure: sum_sales_last_7_days
    type: sum
    sql: ${sales_last_7_days}
    format: "£%0.2f"
    
  - measure: sum_sales_previous_7_days
    type: sum
    sql: ${sales_previous_7_days}
    format: "%0.2f"
    
  
  - measure: sum_sales_last_28_days
    type: sum
    sql: ${sales_last_28_days}
    format: "£%0.2f"
    
  - measure: sum_sales_previous_28_days
    type: sum
    sql: ${sales_previous_28_days}
    format: "£%0.2f"
    
  - measure: sum_sales_yesterday_qty
    type: sum
    sql: ${sales_yesterday_qty}
  
  - measure: sum_sales_day_before_yest_qty
    type: sum
    sql: ${sales_day_before_yest_qty}
  
  - measure: sum_sales_last_7_days_qty
    type: sum
    sql: ${sales_last_7_days_qty}
    
  - measure: sum_sales_previous_7_days_qty
    type: sum
    sql: ${sales_previous_7_days_qty}
  
  - measure: sum_sales_last_28_days_qty
    type: sum
    sql: ${sales_last_28_days_qty}
    
  - measure: sum_sales_previous_28_days_qty
    type: sum
    sql: ${sales_previous_28_days_qty}
    
  # comparison measures
  
  - measure: day_on_day
    type: number
    decimals: 2
    sql: 100.0 * ${sum_sales_yesterday}/NULLIF(${sum_sales_day_before_yest},0)::REAL - 100
    format: "%0.2f%"
    html: |
      {% if value < 0 - Red' %}
        <p style="color: black; background-color: #D77070; font-size:100%; text-align:center">{{ rendered_value }}</p>
      {% elsif value > 0 - Green' %}
        <p style="color: black; background-color: #A2D68F; font-size:100%; text-align:center">{{ rendered_value }}</p>
      {% else %}
        <p style="color: black; background-color: #FFFFFF; font-size:100%; text-align:center">{{ rendered_value }}</p>
      {% endif %}
   
  - measure: week_on_week
    type: number
    decimals: 2
    sql: 100.0 * ${sum_sales_last_7_days}/NULLIF(${sum_sales_previous_7_days},0)::REAL - 100
    format: "%0.2f%"
    html: |
      {% if value < 0 - Red' %}
        <p style="color: black; background-color: #D77070; font-size:100%; text-align:center">{{ rendered_value }}</p>
      {% elsif value > 0 - Green' %}
        <p style="color: black; background-color: #A2D68F; font-size:100%; text-align:center">{{ rendered_value }}</p>
      {% else %}
        <p style="color: black; background-color: #FFFFFF; font-size:100%; text-align:center">{{ rendered_value }}</p>
      {% endif %}
 
  - measure: month_on_month
    type: number
    decimals: 2
    sql: 100.0 * ${sum_sales_last_28_days}/NULLIF(${sum_sales_previous_28_days},0)::REAL - 100
    format: "%0.2f%"
    html: |
      {% if value < 0 - Red' %}
        <p style="color: black; background-color: #D77070; font-size:100%; text-align:center">{{ rendered_value }}</p>
      {% elsif value > 0 - Green' %}
        <p style="color: black; background-color: #A2D68F; font-size:100%; text-align:center">{{ rendered_value }}</p>
      {% else %}
        <p style="color: black; background-color: #FFFFFF; font-size:100%; text-align:center">{{ rendered_value }}</p>
      {% endif %}
      
  - measure: sum_count_on_hand_qty
    type: sum
    sql: ${count_on_hand_qty}
    
  - measure: sum_count_on_hand_gbp
    type: sum
    sql: ${count_on_hand_gbp}
    format: "£%0.2f"

  - measure: avg_days_cover
    type: number
    decimals: 1
    sql: 7.0 * ${sum_count_on_hand_qty}/NULLIF(${sum_sales_last_7_days_qty},0)::REAL
    format: "%0.1f"
    
  - measure: avg_weeks_cover
    type: number
    decimals: 1
    sql: ${sum_count_on_hand_qty}/NULLIF(${sum_sales_last_7_days_qty},0)::REAL
    format: "%0.1f"
