view: product_info_option_daily {
  sql_table_name: sales.daily_option_stats ;;
  #################################################################################################################################################
  ######################################################## DIMENSIONS #############################################################################
  #################################################################################################################################################

  dimension_group: calendar_date {
    type: time
    label: "Calendar"
    sql: ${TABLE}.calendar_date ;;
    timeframes: [
      time,
      date,
      hour_of_day,
      hour,
      time_of_day,
      day_of_week_index,
      day_of_week,
      week,
      week_of_year,
      day_of_month,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year
    ]
  }

  dimension: product_id {
    sql: ${TABLE}.product_id ;;
    hidden: yes
  }

  dimension: option_id {
    sql: ${TABLE}.option_id ;;
    hidden: yes
  }

  dimension: closing_stock {
    sql: ${TABLE}.closing_stock ;;
    hidden: yes
  }

  dimension: opening_stock {
    sql: ${TABLE}.opening_stock ;;
    hidden: yes
  }

  dimension: items_sold {
    sql: ${TABLE}.items_sold ;;
    hidden: yes
  }

  dimension: items_returned {
    sql: ${TABLE}.items_returned ;;
    hidden: yes
  }

  dimension: return_intake_units {
    sql: ${TABLE}.return_intake_units ;;
    hidden: yes
  }

  dimension: gross_revenue_gbp {
    sql: ${TABLE}.gross_revenue_gbp ;;
    hidden: yes
  }

  dimension: gross_revenue_gbp_ex_vat {
    sql: ${TABLE}.gross_revenue_gbp_ex_vat ;;
    hidden: yes
  }

  dimension: gross_revenue_gbp_ex_discount {
    sql: ${TABLE}.gross_revenue_gbp_ex_discount ;;
    hidden: yes
  }

  dimension: gross_revenue_pre_retail_md {
    sql: ${TABLE}.gross_revenue_pre_retail_md ;;
    hidden: yes
  }

  dimension: total_discount_md_voucher {
    sql: ${gross_revenue_pre_retail_md} - ${gross_revenue_gbp_ex_discount} ;;
    hidden: yes
  }

  dimension: gross_revenue_gbp_ex_vat_ex_discount {
    sql: ${TABLE}.gross_revenue_gbp_ex_vat_ex_discount ;;
    hidden: yes
  }

  dimension: net_revenue_gbp {
    sql: ${TABLE}.net_revenue_gbp ;;
    hidden: yes
  }

  dimension: net_revenue_gbp_ex_vat_ex_discount {
    sql: ${TABLE}.net_revenue_gbp_ex_vat_ex_discount ;;
    hidden: yes
  }

  dimension: product_page_views {
    sql: coalesce(${TABLE}.product_views, '0') ;;
    hidden: yes
  }

  dimension: product_impressions {
    type: number
    value_format_name: decimal_0
    sql: coalesce(${TABLE}.category_impressions, '0') ;;
    hidden: yes
  }

  dimension: product_clicks {
    sql: coalesce(${TABLE}.category_clicks, '0') ;;
    hidden: yes
  }

  dimension: product_quick_views {
    sql: coalesce(${TABLE}.quick_views, '0') ;;
    hidden: yes
  }

  dimension: products_added_to_cart {
    sql: coalesce(${TABLE}.quantity_added_to_cart, '0') ;;
    hidden: yes
  }

  dimension: product_coming_soon_requests {
    sql: coalesce(${TABLE}.coming_soon_requests, '0') ;;
    hidden: yes
  }

  dimension: is_live {
    sql: ${TABLE}.is_live ;;
    hidden: yes
  }

  dimension: is_coming_soon {
    sql: ${TABLE}.is_coming_soon ;;
    hidden: yes
  }

  dimension: display_rule {
    sql: ${TABLE}.display_rule ;;
    hidden: yes
  }

  dimension: available_on {
    sql: ${TABLE}.available_on ;;
    hidden: yes
  }

  dimension: pre_sale_price {
    label: "Was Price"
    sql: ${TABLE}.pre_sale_price ;;
  }

  dimension: price {
    label: "Price"
    type: number
    sql: ${TABLE}.price ;;
  }

  dimension: cost_of_goods_sold{
    type: number
    sql: ${TABLE}.total_cost ;;
    hidden: yes
  }

  dimension: on_sale_flag {
    type: yesno
    sql: ${pre_sale_price} is not null
      and ${pre_sale_price} != 0
      and ${pre_sale_price} > ${price}
       ;;
  }

  dimension: discount_level_tier {
    sql: case
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
       ;;
  }

  dimension: on_site_flag {
    sql: ${TABLE}.product_on_site_flag ;;
  }

  dimension: variants_in_spree {
    sql: ${TABLE}.variants_in_spree ;;
    hidden: yes
  }

  dimension: variants_in_stock {
    sql: ${TABLE}.variants_in_stock ;;
    hidden: yes
  }

  dimension: variants_in_spree_and_in_stock {
    sql: ${TABLE}.variants_in_spree_and_in_stock ;;
    hidden: yes
  }

  dimension: full_option_availability_flag {
    type: yesno
    sql: ${TABLE}.full_size_availability_flag = 'yes' ;;
  }

  dimension: size_availability {
    type: number
    value_format_name: decimal_4
    sql: ${variants_in_spree_and_in_stock}/NULLIF(${variants_in_spree},0)::REAL ;;
  }

  dimension: low_stock_flag {
    type: yesno
    sql: ${size_availability} < 0.6 ;;
  }

  #################################################################################################################################################
  ######################################################## MEASURES ###############################################################################
  #################################################################################################################################################

  measure: sum_items_sold {
    type: sum
    label: "Items Sold"
    sql: ${items_sold} ;;
    group_label: "Items Sold"
  }

  measure: sum_items_sold_yesterday {
    type: number
    label: "Items Sold Yesterday"
    sql: sum(case when ${calendar_date_date} = current_date - 1 then ${items_sold} else 0 end) ;;
    group_label: "Items Sold"
  }

  measure: sum_items_sold_wtd {
    type: number
    label: "Items Sold WTD"
    sql: sum(case when ${calendar_date_date} between date_trunc('week', current_date - 1) and current_date - 1 then ${items_sold} else 0 end) ;;
    group_label: "Items Sold"
  }

  measure: sum_items_sold_wtd_lw {
    type: number
    label: "Items Sold WTD LW"
    sql: sum(case when ${calendar_date_date} between date_trunc('week', current_date - 8) and current_date - 8 then ${items_sold} else 0 end) ;;
    group_label: "Items Sold"
  }

  measure: sum_items_sold_week_to_date_wow {
    label: "Items Sold WTD WoW"
    type: number
    value_format_name: percent_0
    group_label: "Items Sold"
    sql: (${sum_items_sold_wtd} - ${sum_items_sold_wtd_lw})/NULLIF(${sum_items_sold_wtd_lw},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: sum_items_sold_last_week {
    type: sum
    label: "Items Sold LW"
    sql: ${items_sold} ;;

    filters: {
      field: calendar_date_date
      value: "last week"
    }
  }

  measure: sum_items_returned {
    type: sum
    label: "Items Returned"
    sql: ${items_returned} ;;
  }

  measure: return_rate {
    type: number
    value_format_name: percent_1
    label: "Return Rate"
    sql: ${sum_items_returned}/NULLIF(${sum_items_sold},0)::REAL ;;
  }

  measure: sum_closing_stock_yesterday {
    type: sum
    label: "Closing Stock Yesterday"
    sql: ${closing_stock} ;;

    filters: {
      field: calendar_date_date
      value: "yesterday"
    }
  }

  measure: closing_stock_end_of_week {
    label: "Closing Stock End of Week"
    type: sum
    sql: ${closing_stock} ;;

    filters: {
      field: calendar_date_day_of_week_index
      value: "6"
    }
  }

  measure: sum_gross_revenue_gbp {
    type: sum
    value_format_name: decimal_2
    label: "Gross Revenue"
    sql: ${gross_revenue_gbp} ;;
  }

  measure: sum_gross_revenue_gbp_ex_vat {
    type: sum
    value_format_name: decimal_2
    label: "Gross Revenue ex. VAT"
    sql: ${gross_revenue_gbp_ex_vat} ;;
  }

  measure: sum_gross_revenue_gbp_ex_vdiscount {
    type: sum
    value_format_name: decimal_2
    label: "Gross Revenue ex. Discount"
    sql: ${gross_revenue_gbp_ex_discount} ;;
    group_label: "Gross Revenue Ex Discount"
  }

  measure: sum_gross_revenue_gbp_ex_discount_yesterday {
    type: number
    value_format_name: gbp_0
    label: "Gross Revenue ex. Discount Yesterday"
    sql: sum(case when ${calendar_date_date} = current_date - 1 then ${gross_revenue_gbp_ex_discount} else 0 end) ;;
    group_label: "Gross Revenue Ex Discount"
  }

  measure: sum_gross_revenue_gbp_ex_discount_wtd {
    type: number
    value_format_name: gbp_0
    label: "Gross Revenue ex. Discount WTD"
    sql: sum(case when ${calendar_date_date} between date_trunc('week', current_date - 1) and current_date - 1 then ${gross_revenue_gbp_ex_discount} else 0 end) ;;
    group_label: "Gross Revenue Ex Discount"
  }

  measure: sum_gross_revenue_gbp_ex_discount_wtd_lw {
    type: number
    value_format_name: gbp_0
    label: "Gross Revenue ex. Discount WTD LW"
    sql: sum(case when ${calendar_date_date} between date_trunc('week', current_date - 8) and current_date - 8 then ${gross_revenue_gbp_ex_discount} else 0 end) ;;
    group_label: "Gross Revenue Ex Discount"
  }

  measure: sum_gross_revenue_gbp_ex_discount_week_to_date_wow {
    label: "Gross Revenue ex. Discount WTD WoW"
    type: number
    value_format_name: percent_0
    group_label: "Gross Revenue Ex Discount"
    sql: (${sum_gross_revenue_gbp_ex_discount_wtd} - ${sum_gross_revenue_gbp_ex_discount_wtd_lw})/NULLIF(${sum_gross_revenue_gbp_ex_discount_wtd_lw},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: sum_gross_revenue_gbp_ex_vat_ex_discount {
    type: sum
    value_format_name: decimal_2
    label: "Gross Revenue ex. VAT, Discount"
    sql: ${gross_revenue_gbp_ex_vat_ex_discount} ;;
  }

  measure: sum_gross_revenue_gbp_ex_vat_ex_discount_last_week {
    type: sum
    value_format_name: decimal_2
    label: "Gross Revenue ex. VAT, Discount LW"
    sql: ${gross_revenue_gbp_ex_vat_ex_discount} ;;

    filters: {
      field: calendar_date_date
      value: "last week"
    }
  }

  measure: sum_product_page_views {
    type: number
    label: "Page Views"
    sql: sum(${product_page_views}) ;;
  }

  measure: sum_product_page_views_yesterday {
    type: number
    label: "Page Views Yesterday"
    sql: sum(case when ${calendar_date_date} = current_date - 1 then ${product_page_views} else 0 end) ;;
    group_label: "Page Views"
  }

  measure: sum_products_page_views_lcw {
    label: "Page Views LCW"
    type: sum
    sql:  case when (((${calendar_date_date}) >= ((DATEADD(week,-1, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())) ))) AND ( ${calendar_date_date} ) < ((DATEADD(week,1, DATEADD(week,-1, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())))))))) then ${product_page_views} else 0 end ;;
    group_label: "Page Views"
  }

  measure: sum_product_page_views_wtd {
    type: number
    label: "Page Views WTD"
    sql: sum(case when ${calendar_date_date} between date_trunc('week', current_date - 1) and current_date - 1 then ${product_page_views} else 0 end) ;;
    group_label: "Page Views"
  }

  measure: sum_product_page_views_wtd_lw {
    type: number
    label: "Page Views WTD LW"
    sql: sum(case when ${calendar_date_date} between date_trunc('week', current_date - 8) and current_date - 8 then ${product_page_views} else 0 end) ;;
    group_label: "Page Views"
  }

  measure: sum_product_page_views_week_to_date_wow {
    label: "Page Views WTD WoW"
    type: number
    value_format_name: percent_0
    group_label: "Page Views"
    sql: (${sum_product_page_views_wtd} - ${sum_product_page_views_wtd_lw})/NULLIF(${sum_product_page_views_wtd_lw},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: sum_product_impressions {
    type: sum
    label: "Impressions"
    sql: ${product_impressions} ;;
  }

  measure: sum_product_clicks {
    type: sum
    label: "Clicks"
    sql: ${product_clicks} ;;
  }

  measure: sum_product_quick_views {
    type: sum
    label: "Quick Views"
    sql: ${product_quick_views} ;;
  }

  measure: add_to_carts {
    type: sum
    sql: ${products_added_to_cart} ;;
  }

  measure: add_to_carts_lcw {
    label: "Add To Carts LCW"
    type: sum
    sql:  case when (((${calendar_date_date}) >= ((DATEADD(week,-1, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())) ))) AND ( ${calendar_date_date} ) < ((DATEADD(week,1, DATEADD(week,-1, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())))))))) then ${products_added_to_cart} else 0 end ;;
  }

  measure: coming_soon_requests {
    type: sum
    sql: ${product_coming_soon_requests} ;;
  }

  measure: click_through_rate {
    type: number
    value_format_name: percent_2
    label: "Click-Through Rate"
    sql: ${sum_product_clicks}/NULLIF(${sum_product_impressions},0)::REAL ;;
  }

  measure: conversion_rate {
    type: number
    value_format_name: percent_2
    label: "Conversion Rate"
    sql: ${sum_items_sold}/NULLIF(${sum_product_page_views},0)::REAL ;;
    group_label: "Conversion Rate"
  }

  measure: conversion_rate_yesterday {
    type: number
    value_format_name: percent_2
    label: "Conversion Rate Yesterday"
    sql: ${sum_items_sold_yesterday}/NULLIF(${sum_product_page_views_yesterday},0)::REAL ;;
    group_label: "Conversion Rate"
  }

  measure: conversion_rate_lcw {
    type: number
    value_format_name: percent_2
    label: "Conversion Rate LCW"
    sql: ${items_sold_lcw}/NULLIF(${sum_products_page_views_lcw},0)::REAL ;;
    group_label: "Conversion Rate"
  }

  measure: conversion_rate_wtd {
    type: number
    value_format_name: percent_2
    label: "Conversion Rate WTD"
    sql: ${sum_items_sold_wtd}/NULLIF(${sum_product_page_views_wtd},0)::REAL ;;
    group_label: "Conversion Rate"
  }

  measure: conversion_rate_wtd_lw {
    type: number
    value_format_name: percent_2
    label: "Conversion Rate WTD LW"
    sql: ${sum_items_sold_wtd_lw}/NULLIF(${sum_product_page_views_wtd_lw},0)::REAL ;;
    group_label: "Conversion Rate"
  }

  measure: conversion_rate_week_to_date_wow {
    label: "Conversion Rate WTD WoW"
    type: number
    value_format_name: percent_0
    group_label: "Conversion Rate"
    sql: (${conversion_rate_wtd} - ${conversion_rate_wtd_lw})/NULLIF(${conversion_rate_wtd_lw},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }


  measure: go_live_date {
    type: string
    label: "Go-Live Date"
    sql: min(case when ${on_site_flag} = 'no' then null else ${calendar_date_date} end) ;;
  }

  measure: options_online {
    type: count_distinct
    label: "Options Online"
    sql: ${product_id} ;;

    filters: {
      field: on_site_flag
      value: "yes"
    }
  }

  measure: revenue_per_1k_impressions {
    type: number
    sql: 1000*${sum_gross_revenue_gbp_ex_vat_ex_discount}/NULLIF(${sum_product_impressions},0)::REAL ;;
    value_format: "\"£\"#,##0"
  }

  #################################### REPORTING MEASURES ###################################

  measure: impressions_tw {
    type: sum
    sql: ${product_impressions} ;;

    filters: {
      field: calendar_date_date
      value: "last week"
    }
  }

  measure: clicks_tw {
    type: sum
    sql: ${product_clicks} ;;

    filters: {
      field: calendar_date_date
      value: "last week"
    }
  }

  measure: page_views_tw {
    type: sum
    sql: ${product_page_views} ;;

    filters: {
      field: calendar_date_date
      value: "last week"
    }
  }

  measure: options_online_tw {
    type: count_distinct
    sql: ${product_id} ;;

    filters: {
      field: calendar_date_date
      value: "last week"
    }

    filters: {
      field: on_site_flag
      value: "yes"
    }
  }

  #product_impressions: '>50'

  measure: options_online_lw {
    type: count_distinct
    sql: ${product_id} ;;

    filters: {
      field: calendar_date_date
      value: "2 weeks ago for 1 week"
    }

    filters: {
      field: on_site_flag
      value: "yes"
    }
  }

  measure: add_to_cart_rate {
    type: number
    value_format_name: percent_1
    sql: ${add_to_carts}/nullif(${sum_product_page_views},0)::REAL ;;
    label: "Add To Cart Rate"
  }

  measure: add_to_cart_rate_lcw {
    type: number
    label: "Add To Cart Rate LCW"
    value_format_name: percent_1
    sql:  ${add_to_carts_lcw}/NULLIF(${sum_products_page_views_lcw},0)::REAL ;;
  }

############################# BYUING REPORT MEASURES

  measure: gross_revenue_lw {
    label: "Gross Revenue LW"
    group_label: "Buying Report Measures"
    type: sum
    value_format_name: pounds_k
    sql: ${gross_revenue_gbp_ex_discount} ;;
    filters: {
      field: calendar_date_date
      value: "1 week ago for 1 week"
    }
  }

  measure: gross_revenue_pw {
    label: "Gross Revenue PW"
    group_label: "Buying Report Measures"
    type: sum
    value_format_name: pounds_k
    sql: ${gross_revenue_gbp_ex_discount} ;;
    filters: {
      field: calendar_date_date
      value: "2 weeks ago for 1 week"
    }
  }

  measure: gross_revenue_wow {
    label: "Gross Revenue WoW"
    group_label: "Buying Report Measures"
    type: number
    value_format_name: percent_0
    sql: (${gross_revenue_lw} - ${gross_revenue_pw})/NULLIF(${gross_revenue_pw},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: gross_revenue_ly {
    label: "Gross Revenue LY"
    group_label: "Buying Report Measures"
    type: number
    sql: sum (
      case when ${calendar_date_week_of_year} = EXTRACT(WEEK FROM current_date - 7)
      and ${calendar_date_date} between current_date - 400 and current_date - 300
      then ${gross_revenue_gbp_ex_discount} else null end
      )
       ;;
    value_format_name: pounds_k
  }

  measure: gross_revenue_yoy {
    label: "Gross Revenue YoY"
    group_label: "Buying Report Measures"
    type: number
    value_format_name: percent_0
    sql: (${gross_revenue_lw} - ${gross_revenue_ly})/NULLIF(${gross_revenue_ly},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: gross_revenue_ex_vat_lw {
    hidden: yes
    type: sum
    sql: ${gross_revenue_gbp_ex_vat_ex_discount} ;;
    filters: {
      field: calendar_date_date
      value: "1 week ago for 1 week"
    }
  }

  measure: gross_revenue_ex_vat_ly {
    hidden: yes
    type: number
    sql: sum (
      case when ${calendar_date_week_of_year} = EXTRACT(WEEK FROM current_date - 7)
      and ${calendar_date_date} between current_date - 400 and current_date - 300
      then ${gross_revenue_gbp_ex_vat_ex_discount} else null end
      )
       ;;
  }

  measure: gross_revenue_lcw {
    type: sum
    value_format_name: gbp_0
    label: "Gross Revenue LCW"
    sql: case when (((${calendar_date_date}) >= ((DATEADD(week,-1, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())) ))) AND ( ${calendar_date_date} ) < ((DATEADD(week,1, DATEADD(week,-1, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())))))))) then ${gross_revenue_gbp_ex_discount} else 0 end ;;
  }

  measure: cogs_lw {
    hidden: yes
    type: sum
    sql: ${cost_of_goods_sold} ;;
    filters: {
      field: calendar_date_date
      value: "1 week ago for 1 week"
    }
  }

  measure: cogs_ly {
    hidden: yes
    type: number
    sql: sum (
      case when ${calendar_date_week_of_year} = EXTRACT(WEEK FROM current_date - 7)
      and ${calendar_date_date} between current_date - 400 and current_date - 300
      then ${cost_of_goods_sold} else null end
      )
       ;;
  }

  measure: margin_lw {
    label: "Margin LW"
    group_label: "Buying Report Measures"
    type: number
    value_format_name: percent_0
    sql: (${gross_revenue_ex_vat_lw} - ${cogs_lw})/NULLIF(${gross_revenue_ex_vat_lw},0)::REAL ;;
  }

  measure: margin_ly {
    label: "Margin LY"
    group_label: "Buying Report Measures"
    type: number
    value_format_name: percent_0
    sql: (${gross_revenue_ex_vat_ly} - ${cogs_ly})/NULLIF(${gross_revenue_ex_vat_ly},0)::REAL ;;
  }

  measure: gross_revenue_pre_retail_md_lw {
    hidden: yes
    type: sum
    sql: ${gross_revenue_pre_retail_md} ;;
    filters: {
      field: calendar_date_date
      value: "1 week ago for 1 week"
    }
  }

  measure: total_discount_md_voucher_lw {
    hidden: yes
    type: sum
    sql: ${total_discount_md_voucher} ;;
    filters: {
      field: calendar_date_date
      value: "1 week ago for 1 week"
    }
  }

  measure: total_discount_lw {
    label: "Discount LW"
    group_label: "Buying Report Measures"
    type: number
    value_format_name: percent_0
    sql: (${total_discount_md_voucher_lw})/NULLIF(${gross_revenue_pre_retail_md_lw},0)::REAL ;;
  }

  measure: items_sold_28d {
    type: sum
    hidden:  yes
    sql: ${items_sold} ;;
    filters: {
      field: calendar_date_date
      value: "before 28 days ago"
    }
  }

  measure: items_returned_28d {
    type: sum
    hidden:  yes
    sql: ${items_returned} ;;
    filters: {
      field: calendar_date_date
      value: "before 28 days ago"
    }
  }

  measure: avg_return_rate {
    label: "Avg. Return Rate"
    group_label: "Buying Report Measures"
    type: number
    value_format_name: percent_0
    sql: (${items_returned_28d})/NULLIF(${items_sold_28d},0)::REAL ;;
  }

  measure: sales_mix {
    label: "Sales Mix"
    group_label: "Buying Report Measures"
    type: percent_of_total
    sql: ${gross_revenue_lw} ;;
  }

  measure: items_sold_lw {
    label: "Units Sold LW"
    group_label: "Buying Report Measures"
    type: sum
    value_format_name: decimal_0
    sql: ${items_sold} ;;
    filters: {
      field: calendar_date_date
      value: "1 week ago for 1 week"
    }
  }

  measure: items_sold_pw {
    label: "Units Sold PW"
    group_label: "Buying Report Measures"
    type: sum
    value_format_name: decimal_0
    sql: ${items_sold} ;;
    filters: {
      field: calendar_date_date
      value: "2 weeks ago for 1 week"
    }
  }

  measure: items_sold_wow {
    label: "Units Sold WoW"
    group_label: "Buying Report Measures"
    type: number
    value_format_name: percent_0
    sql: (${items_sold_lw} - ${items_sold_pw})/NULLIF(${items_sold_pw},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: items_sold_lcw {
    label: "Items Sold LCW"
    type: sum
    sql:  case when (((${calendar_date_date}) >= ((DATEADD(week,-1, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())) ))) AND ( ${calendar_date_date} ) < ((DATEADD(week,1, DATEADD(week,-1, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())))))))) then ${items_sold} else 0 end ;;
  }

  measure: return_intake_lw {
    label: "Returns Intake LW"
    group_label: "Buying Report Measures"
    type: sum
    value_format_name: decimal_0
    sql: ${return_intake_units} ;;
    filters: {
      field: calendar_date_date
      value: "1 week ago for 1 week"
    }
  }

  measure: closing_stock_units {
    type: sum
    label: "Stock Units"
    sql: ${closing_stock} ;;
  }

  measure: closing_stock_units_yesterday {
    type: sum
    label: "Stock Units Yesterday"
    sql: case when ${calendar_date_date}  = current_date - 1 then ${closing_stock} else 0 end ;;
  }

  measure: closing_stock_units_lw {
    type: sum
    label: "Stock Units LW"
    group_label: "Buying Report Measures"
    value_format_name: thousands
    sql: ${closing_stock} ;;
    filters: {
      field: calendar_date_date
      value: "1 weeks ago for 1 week"
    }

    filters: {
      field: calendar_date_day_of_week_index
      value: "6"
    }
  }

  measure: closing_stock_value {
    type: sum
    label: "Stock Value"
    value_format_name: pounds
    sql: ${closing_stock}*NULLIF(${price},0) ;;
  }

  measure: closing_stock_value_yesterday {
    type: sum
    label: "Stock Value Yesterday"
    value_format_name: pounds
    sql: case when ${calendar_date_date}  = current_date - 1 then (${closing_stock}*NULLIF(${price},0)) else 0 end ;;
  }

  measure: closing_stock_value_lw {
    type: sum
    group_label: "Buying Report Measures"
    label: "Stock Value LW"
    value_format_name: pounds_k
    sql: ${closing_stock}*NULLIF(${price},0) ;;
    filters: {
      field: calendar_date_date
      value: "1 weeks ago for 1 week"
    }

    filters: {
      field: calendar_date_day_of_week_index
      value: "6"
    }
  }

  measure: closing_stock_value_pw {
    type: sum
    group_label: "Buying Report Measures"
    label: "Stock Value PW"
    value_format_name: pounds_k
    sql: ${closing_stock}*NULLIF(${price},0) ;;
    filters: {
      field: calendar_date_date
      value: "2 weeks ago for 1 week"
    }

    filters: {
      field: calendar_date_day_of_week_index
      value: "6"
    }
  }

  measure: closing_stock_units_pw {
    type: sum
    group_label: "Buying Report Measures"
    label: "Stock Units PW"
    value_format_name: thousands
    sql: ${closing_stock} ;;
    filters: {
      field: calendar_date_date
      value: "2 weeks ago for 1 week"
    }

    filters: {
      field: calendar_date_day_of_week_index
      value: "6"
    }
  }

  measure: stock_mix {
    label: "Stock Mix"
    group_label: "Buying Report Measures"
    type: percent_of_total
    sql: ${closing_stock_value_lw} ;;
  }

  measure: net_cover_lw {
    label: "Net Cover LW"
    group_label: "Buying Report Measures"
    type: number
    value_format_name: decimal_0
    sql: ((${closing_stock_units_lw})/NULLIF(${items_sold_lw},0))/(1-${avg_return_rate}) ;;
  }

  measure: net_cover_pw {
    label: "Net Cover PW"
    group_label: "Buying Report Measures"
    type: number
    value_format_name: decimal_0
    sql: ((${closing_stock_units_pw})/NULLIF(${items_sold_pw},0))/(1-${avg_return_rate}) ;;
  }



  measure: options_online_last_week {
    label: "Options Online LW"
    group_label: "Buying Report Measures"
    type:  count_distinct
    sql: ${option_id}  ;;

    filters: {
      field: calendar_date_date
      value: "last week"
    }

    filters: {
      field: on_site_flag
      value: "yes"
    }

    filters: {
      field: calendar_date_day_of_week_index
      value: "6"
    }
  }

  measure: options_online_pw {
    label: "Options Online PW"
    group_label: "Buying Report Measures"
    type:  count_distinct
    sql: ${option_id}  ;;

    filters: {
      field: calendar_date_date
      value: "2 weeks ago for 1 week"
    }

    filters: {
      field: on_site_flag
      value: "yes"
    }

    filters: {
      field: calendar_date_day_of_week_index
      value: "6"
    }
  }

  measure: options_with_under_70_size_availability_number {
    group_label: "Buying Report Measures"
    hidden:  yes
    type:  count_distinct
    sql: ${option_id}  ;;

    filters: {
      field: size_availability
      value: "<0.7"
    }

    filters: {
      field: calendar_date_date
      value: "last week"
    }

    filters: {
      field: on_site_flag
      value: "yes"
    }

    filters: {
      field: calendar_date_day_of_week_index
      value: "6"
    }
  }

  measure: options_with_under_70_size_availability_percent {
    label: "<70% Size Avail."
    group_label: "Buying Report Measures"
    type:  number
    value_format_name: percent_0
    sql:  ${options_with_under_70_size_availability_number}/NULLIF(${options_online_lw},0)::REAL ;;
  }

  measure: zero_selling_options_lw {
    group_label: "Buying Report Measures"
    hidden:  yes
    type:  count_distinct
    sql: ${option_id}  ;;

    filters: {
      field: calendar_date_date
      value: "last week"
    }

    filters: {
      field: on_site_flag
      value: "yes"
    }

    filters: {
      field: calendar_date_day_of_week_index
      value: "6"
    }

    filters: {
      field: option_info.items_sold_lw
      value: "0"
    }

  }

  measure: zero_selling_options_lw_percent {
    label: "Zero Selling Options LW"
    group_label: "Buying Report Measures"
    type:  number
    value_format_name: percent_0
    sql:  ${zero_selling_options_lw}/NULLIF(${options_online_lw},0)::REAL ;;
    }

  measure: options_12wks_lw {
    group_label: "Buying Report Measures"
    hidden:  yes
    type:  count_distinct
    sql: ${option_id}  ;;

    filters: {
      field: calendar_date_date
      value: "last week"
    }

    filters: {
      field: on_site_flag
      value: "yes"
    }

    filters: {
      field: calendar_date_day_of_week_index
      value: "6"
    }

    filters: {
      field: option_info.cover_lw
      value: ">12"
    }

  }

  measure: options_12kwks_lw_percent {
    label: "Options >12Wks Cover"
    group_label: "Buying Report Measures"
    type:  number
    value_format_name: percent_0
    sql:  ${options_12wks_lw}/NULLIF(${options_online_lw},0)::REAL ;;
  }

  measure: product_views_lw {
    type: sum
    label: "Product Views LW"
    group_label: "Buying Report Measures"
    value_format_name: thousands
    sql: ${product_page_views} ;;
    filters: {
      field: calendar_date_date
      value: "last week"
    }

  }

  measure: product_conversion_lw {
    label: "Product Conversion LW"
    group_label: "Buying Report Measures"
    type:  number
    value_format_name: percent_1
    sql:  ${items_sold_lw}/NULLIF(${product_views_lw},0)::REAL ;;
  }

  measure: product_impressions_lw {
    type: sum
    label: "Product Impressions LW"
    group_label: "Buying Report Measures"
    value_format_name: thousands
    sql: ${product_impressions} ;;
    filters: {
      field: calendar_date_date
      value: "last week"
    }

  }

  measure: gross_cover_lw {
    label: "Gross Cover LW"
    group_label: "Buying Report Measures"
    type:  number
    value_format_name:decimal_1
    sql:  ${closing_stock_units_lw}/NULLIF(${items_sold_lw},0)::REAL ;;
  }

  measure: product_views_last_wk {
    type: sum
    label: "Product Views Last Week"
    group_label: "Buying Report Measures"
    value_format_name: decimal_0
    sql: ${product_page_views} ;;
    filters: {
      field: calendar_date_date
      value: "last week"
    }

  }

  measure: closing_stock_units_last_week {
    type: sum
    group_label: "Buying Report Measures"
    label: "Stock Units Last Week"
    value_format_name: decimal_0
    sql: ${closing_stock} ;;
    filters: {
      field: calendar_date_date
      value: "1 weeks ago for 1 week"
    }

    filters: {
      field: calendar_date_day_of_week_index
      value: "6"
    }
  }

  measure: gross_revenue_last_week {
    label: "Gross Revenue Last Week"
    group_label: "Buying Report Measures"
    type: sum
    value_format_name: pounds
    sql: ${gross_revenue_gbp_ex_discount} ;;
    filters: {
      field: calendar_date_date
      value: "1 week ago for 1 week"
    }
  }

}
