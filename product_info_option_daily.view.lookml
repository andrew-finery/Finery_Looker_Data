- view: product_info_option_daily
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
     
   - dimension: option_id
     sql: ${TABLE}.option_id
     hidden: true
     
   - dimension: closing_stock
     sql: ${TABLE}.closing_stock
     hidden: true

   - dimension: opening_stock
     sql: ${TABLE}.opening_stock
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
     type: number
     value_format_name: decimal_0
     sql: coalesce(${TABLE}.category_impressions, '0')
     hidden: true
     
   - dimension: product_clicks
     sql: coalesce(${TABLE}.category_clicks, '0')
     hidden: true

   - dimension: product_quick_views
     sql: coalesce(${TABLE}.quick_views, '0')
     hidden: true

   - dimension: products_added_to_cart
     sql: coalesce(${TABLE}.quantity_added_to_cart, '0')
     hidden: true

   - dimension: product_coming_soon_requests
     sql: coalesce(${TABLE}.coming_soon_requests, '0')
     hidden: true

   - dimension: is_live
     sql: ${TABLE}.is_live
     hidden: true

   - dimension: is_coming_soon
     sql: ${TABLE}.is_coming_soon
     hidden: true

   - dimension: display_rule
     sql: ${TABLE}.display_rule
     hidden: true

   - dimension: available_on
     sql: ${TABLE}.available_on
     hidden: true

   - dimension: pre_sale_price
     label: Was Price
     sql: ${TABLE}.pre_sale_price

   - dimension: price
     label: Price
     type: number
     sql: ${TABLE}.price

   - dimension: on_sale_flag
     type: yesno
     sql: |
          ${pre_sale_price} is not null
          and ${pre_sale_price} != 0
          and ${pre_sale_price} > ${price}
   
   - dimension: discount_level_tier
     sql: |
          case
          when ${pre_sale_price} = 0 then '0%'
          when ${pre_sale_price} is null then '0%'
          when (${pre_sale_price} - ${price})/pre_sale_price < 0.085 then '0% - 8.5%'
          when (${pre_sale_price} - ${price})/pre_sale_price < 0.185 then '08.5% - 18.5%'
          when (${pre_sale_price} - ${price})/pre_sale_price < 0.285 then '18.5% - 28.5%'
          when (${pre_sale_price} - ${price})/pre_sale_price < 0.385 then '28.5% - 38.5%'
          when (${pre_sale_price} - ${price})/pre_sale_price < 0.485 then '38.5% - 48.5%'
          when (${pre_sale_price} - ${price})/pre_sale_price < 0.585 then '48.5% - 58.5%'
          when (${pre_sale_price} - ${price})/pre_sale_price < 0.685 then '58.5% - 68.5%'
          when (${pre_sale_price} - ${price})/pre_sale_price < 0.785 then '68.5% - 78.5%'
          when (${pre_sale_price} - ${price})/pre_sale_price >= 0.785 then '78.5% +'
          else '0%' end
   
   - dimension: on_site_flag
     sql: ${TABLE}.product_on_site_flag

   - dimension: variants_in_spree
     sql: ${TABLE}.variants_in_spree
     hidden: true

   - dimension: variants_in_stock
     sql: ${TABLE}.variants_in_stock
     hidden: true
     
   - dimension: variants_in_spree_and_in_stock
     sql: ${TABLE}.variants_in_spree_and_in_stock
     hidden: true
  
   - dimension: full_option_availability_flag
     type: yesno
     sql: ${TABLE}.full_size_availability_flag = 'yes'
   
   - dimension: size_availability
     type: number
     value_format_name: decimal_4
     sql: ${variants_in_spree_and_in_stock}/NULLIF(${variants_in_spree},0)::REAL
   
   - dimension: low_stock_flag
     type: yesno
     sql: ${size_availability} < 0.6
      
    
     

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
     value_format_name: decimal_4
     label: Return Rate
     sql: ${sum_items_returned}/NULLIF(${sum_items_sold},0)::REAL
     

   - measure: sum_closing_stock_yesterday
     type: sum
     label: Closing Stock Yesterday
     sql: ${closing_stock}
     filters:
      calendar_date_date: yesterday
   
   - measure: sum_gross_revenue_gbp
     type: sum
     value_format_name: decimal_2
     label: Gross Revenue
     sql: ${gross_revenue_gbp}
     
   - measure: sum_gross_revenue_gbp_ex_vat
     type: sum
     value_format_name: decimal_2
     label: Gross Revenue ex. VAT
     sql: ${gross_revenue_gbp_ex_vat}
     
   - measure: sum_gross_revenue_gbp_ex_vat_ex_discount
     type: sum
     value_format_name: decimal_2
     label: Gross Revenue ex. VAT, Discount
     sql: ${gross_revenue_gbp_ex_vat_ex_discount}

   - measure: sum_gross_revenue_gbp_ex_vat_ex_discount_last_week
     type: sum
     value_format_name: decimal_2
     label: Gross Revenue ex. VAT, DIscount LW
     sql: ${gross_revenue_gbp_ex_vat_ex_discount}
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

   - measure: sum_product_quick_views
     type: sum
     label: Quick Views
     sql: ${product_quick_views}

   - measure: add_to_carts
     type: sum
     sql: ${products_added_to_cart}

   - measure: coming_soon_requests
     type: sum
     sql: ${product_coming_soon_requests}

   - measure: click_through_rate
     type: number
     value_format_name: decimal_4
     label: Click-Through Rate
     sql: ${sum_product_clicks}/NULLIF(${sum_product_impressions},0)::REAL
     

   - measure: conversion_rate
     type: number
     value_format_name: decimal_4
     label: Conversion Rate
     sql: ${sum_items_sold}/NULLIF(${sum_product_page_views},0)::REAL
     
  
   - measure: go_live_date
     type: string
     label: Go-Live Date
     sql: min(case when ${on_site_flag} = 'no' then null else ${calendar_date_date} end)
  
   - measure: options_online
     type: count_distinct
     label: Options Online
     sql: ${product_id}
     filters:
      on_site_flag: 'yes'

   - measure: revenue_per_1k_impressions
     type: number
     sql: 1000*${sum_gross_revenue_gbp_ex_vat_ex_discount}/NULLIF(${sum_product_impressions},0)::REAL
     value_format: '"£"#,##0'
     
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
      on_site_flag: 'yes'
      #product_impressions: '>50'
      
   - measure: options_online_lw
     type: count_distinct
     sql: ${product_id}
     filters:
      calendar_date_date: 2 weeks ago for 1 week
      on_site_flag: 'yes'
      #product_impressions: '>50'