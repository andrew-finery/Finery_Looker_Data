- view: daily_option_info
  sql_table_name: sales.daily_option_stats

  fields:

    #################################################################################################################################################
  ######################################################## DIMENSIONS #############################################################################
#################################################################################################################################################

   - dimension_group: calendar_date
     type: time
     label: Calendar
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
     sql: coalesce(${TABLE}.product_views, '0')
     hidden: true
     
   - dimension: product_impressions
     type: int
     sql: coalesce(${TABLE}.category_impressions, '0')
     hidden: true
     
   - dimension: product_clicks
     sql: coalesce(${TABLE}.category_clicks, '0')
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
     value_format: '#,##0.00'
     
   - measure: sum_gross_revenue_gbp_ex_vat
     type: sum
     decimals: 2
     label: Gross Revenue ex. VAT
     sql: ${gross_revenue_gbp_ex_vat}
     value_format: '#,##0.00'
     
   - measure: sum_gross_revenue_gbp_ex_vat_ex_discount
     type: sum
     decimals: 2
     label: Gross Revenue ex. VAT, Discount
     sql: ${gross_revenue_gbp_ex_vat_ex_discount}
     value_format: '#,##0.00'

   - measure: sum_gross_revenue_gbp_ex_vat_ex_discount_last_week
     type: sum
     decimals: 2
     label: Gross Revenue ex. VAT, DIscount LW
     sql: ${gross_revenue_gbp_ex_vat_ex_discount}
     value_format: '#,##0.00'
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
  
   - measure: revenue_per_impression
     type: number
     sql: ${sum_gross_revenue_gbp_ex_vat_ex_discount}/NULLIF(${sum_product_impressions},0)::REAL
     value_format: '"£"#,##0.00'
  
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