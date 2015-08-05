- view: daily_option_info
  derived_table:
    sql: |
          select
          option_date_matrix.calendar_date,
          option_date_matrix.product_id,
          sales.items_sold,
          sales.gross_revenue_gbp,
          sales.gross_revenue_gbp_ex_vat,
          sales.gross_revenue_gbp_ex_vat_ex_discount,
          sales.items_returned,
          sales.net_revenue_gbp,
          sales.net_revenue_gbp_ex_vat_ex_discount,
          sales.closing_stock,
          page_views.product_page_views,
          click_through.distinct_impressions,
          click_through.distinct_clicks
          
          from
          (select product_id, calendar_date from (select product_id from ${online_products.SQL_TABLE_NAME} group by 1) cross join (select calendar_date from finery.calendar where calendar_date < current_date)) option_date_matrix
          
          left join (select calendar_date, product_id, items_sold, gross_revenue_gbp, gross_revenue_gbp_ex_vat, gross_revenue_gbp_ex_vat_ex_discount, items_returned, net_revenue_gbp, net_revenue_gbp_ex_vat_ex_discount, closing_stock from ${daily_sales_option.SQL_TABLE_NAME}) sales
          on option_date_matrix.calendar_date = sales.calendar_date and option_date_matrix.product_id = sales.product_id
          
          left join (select calendar_date, product_id, product_page_views from ${snowplow_product_page_views_daily.SQL_TABLE_NAME}) page_views
          on option_date_matrix.calendar_date = page_views.calendar_date and option_date_matrix.product_id = page_views.product_id
          
          left join (select calendar_date, id, sum(product_impressions) as product_impressions, sum(product_clicks) as product_clicks from ${snowplow_product_click_through_daily.SQL_TABLE_NAME} group by 1,2) click_through
          on option_date_matrix.calendar_date = click_through.calendar_date and option_date_matrix.product_id = click_through.id

    sql_trigger_value: |
                        select sum(calendar_date)
                        from
                        (select calendar_date from
                        (select max(extract(epoch from calendar_date)) as calendar_date from ${daily_sales_option.SQL_TABLE_NAME})
                        union
                        (select max(extract(epoch from calendar_date))as calendar_date from ${snowplow_product_page_views_daily.SQL_TABLE_NAME}))
    distkey: product_id
    sortkeys: [product_id, calendar_date]

  fields:

    #################################################################################################################################################
  ######################################################## DIMENSIONS #############################################################################
#################################################################################################################################################

   - dimension_group: calendar_date
     type: time
     label: CALENDAR
     sql: ${TABLE}.calendar_date
     timeframes: [date, week, month]
     
   - dimension: product_id
     sql: ${TABLE}.product_id
     hidden: true

   - dimension: closing_stock
     sql: ${TABLE}.closing_stock
     hidden: true
     
   - dimension: items_sold
     sql: ${TABLE}.items_sold
     hidden: true

   - dimension: items_returned
     sql: ${TABLE}.items_returned
     hidden: true
   
   - dimension: gross_revenue_gbp
     sql: ${TABLE}.gross_revenue_gbp
     hidden: true

   - dimension: gross_revenue_gbp_ex_vat
     sql: ${TABLE}.gross_revenue_gbp_ex_vat
     hidden: true
     
   - dimension: gross_revenue_gbp_ex_vat_ex_discount
     sql: ${TABLE}.gross_revenue_gbp_ex_vat_ex_discount
     hidden: true

   - dimension: net_revenue_gbp
     sql: ${TABLE}.net_revenue_gbp
     hidden: true

   - dimension: net_revenue_gbp_ex_vat_ex_discount
     sql: ${TABLE}.net_revenue_gbp_ex_vat_ex_discount
     hidden: true

   - dimension: product_page_views
     sql: ${TABLE}.product_page_views
     hidden: true
     
   - dimension: product_impressions
     type: int
     sql: coalesce(${TABLE}.product_impressions, '0')
     hidden: true
     
   - dimension: product_clicks
     sql: ${TABLE}.product_clicks
     hidden: true

    #################################################################################################################################################
  ######################################################## MEASURES ###############################################################################
#################################################################################################################################################

   - measure: sum_items_sold
     type: sum
     label: Items Sold
     sql: ${items_sold}

   - measure: sum_items_sold_last_week
     type: sum
     label: Items Sold LW
     sql: ${items_sold}
     filters:
      calendar_date_date: last week

   - measure: sum_items_returned
     type: sum
     label: Items Returned
     sql: ${items_returned}

   - measure: return_rate
     type: number
     decimals: 4
     label: Return Rate
     sql: ${sum_items_returned}/NULLIF(${sum_items_sold},0)::REAL
     value_format: '0.00%'

   - measure: sum_closing_stock_yesterday
     type: sum
     label: Closing Stock Yesterday
     sql: ${closing_stock}
     filters:
      calendar_date_date: yesterday
   
   - measure: sum_gross_revenue_gbp
     type: sum
     decimals: 2
     label: Gross Revenue
     sql: ${gross_revenue_gbp}
     value_format: '"£"#,##0.00'
     
   - measure: sum_gross_revenue_gbp_ex_vat
     type: sum
     decimals: 2
     label: Gross Revenue ex. VAT
     sql: ${gross_revenue_gbp_ex_vat}
     value_format: '"£"#,##0.00'
     
   - measure: sum_gross_revenue_gbp_ex_vat_ex_discount
     type: sum
     decimals: 2
     label: Gross Revenue ex. VAT, Discount
     sql: ${gross_revenue_gbp_ex_vat_ex_discount}
     value_format: '"£"#,##0.00'

   - measure: sum_gross_revenue_gbp_ex_vat_ex_discount_last_week
     type: sum
     decimals: 2
     label: Gross Revenue ex. VAT, DIscount LW
     sql: ${gross_revenue_gbp_ex_vat_ex_discount}
     value_format: '"£"#,##0.00'
     filters:
      calendar_date_date: last week
      
   - measure: sum_product_page_views
     type: sum
     label: Page Views
     sql: ${product_page_views}
     
   - measure: sum_product_impressions
     type: sum
     label: Impressions
     sql: ${product_impressions}
     
   - measure: sum_product_clicks
     type: sum
     label: Clicks
     sql: ${product_clicks}

   - measure: click_through_rate
     type: number
     decimals: 4
     label: Click-Through Rate
     sql: ${sum_product_clicks}/NULLIF(${sum_product_impressions},0)::REAL
     value_format: '0.00%'

   - measure: conversion_rate
     type: number
     decimals: 4
     label: Conversion Rate
     sql: ${sum_items_sold}/NULLIF(${sum_product_page_views},0)::REAL
     value_format: '0.00%'
  
   - measure: go_live_date
     type: string
     label: Go-Live Date
     sql: min(case when ${product_impressions} < 50 then null else ${calendar_date_date} end)
  
   - measure: options_online
     type: count_distinct
     label: Options Online
     sql: ${product_id}
     filters:
      product_impressions: '>50'

#################################### REPORTING MEASURES ###################################

   - measure: impressions_tw
     type: sum
     sql: ${product_impressions}
     filters:
      calendar_date_date: last week

   - measure: clicks_tw
     type: sum
     sql: ${product_clicks}
     filters:
      calendar_date_date: last week

   - measure: page_views_tw
     type: sum
     sql: ${product_page_views}
     filters:
      calendar_date_date: last week
      
   - measure: options_online_tw
     type: count_distinct
     sql: ${product_id}
     filters:
      calendar_date_date: last week
      product_impressions: '>50'
      
   - measure: options_online_lw
     type: count_distinct
     sql: ${product_id}
     filters:
      calendar_date_date: 2 weeks ago for 1 week
      product_impressions: '>50'