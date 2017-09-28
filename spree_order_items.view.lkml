view: spree_order_items {
  derived_table: {
    sql: select * from sales.order_items where reason_to_strip_out is null ;;
  }

  #################################################################################################################################################################################
  ############################################################ DIMENSIONS #########################################################################################################
  #################################################################################################################################################################################


  ###########################################Order dimensions######################################################################################################################

  dimension_group: order_time {
    type: time
    timeframes: [
      time,
      date,
      hour_of_day,
      hour,
      time_of_day,
      day_of_week_index,
      week,
      week_of_year,
      day_of_month,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year
    ]
    sql: ${TABLE}.order_tstamp ;;
    hidden: yes
  }

  dimension: order_id {
    primary_key: yes
    sql: ${TABLE}.order_id ;;
  }

  dimension: customer_id {
    sql: ${TABLE}.customer_id ;;
    hidden: yes
  }

  dimension: order_code {
    sql: ${TABLE}.order_code ;;
    hidden: yes
  }

  dimension: currency {
    sql: ${TABLE}.currency ;;
    hidden: yes
  }

  dimension: tax_rate {
    sql: ${TABLE}.tax_rate ;;
    hidden: yes
  }

  dimension: exchange_rate {
    sql: ${TABLE}.exchange_rate ;;
    hidden: yes
  }

  ########################################Product Dimensions###########################################################################################################################
  dimension: sku {
    sql: ${TABLE}.sku ;;
  }

  dimension: price {
    type: number
    value_format_name: decimal_2
    sql: ${TABLE}.price ;;
  }

  dimension: pre_sale_price {
    type: number
    value_format_name: decimal_2
    sql: case
      when ${TABLE}.pre_sale_price is null then ${TABLE}.price
      when ${TABLE}.price >= ${TABLE}.pre_sale_price then ${TABLE}.price
      else ${TABLE}.pre_sale_price end
       ;;
  }

  dimension: retail_markdown {
    type: number
    value_format_name: decimal_2
    sql: case when ${pre_sale_price} = 0 then 0 else (${pre_sale_price} - ${price}) / ${pre_sale_price} end ;;
  }

  dimension: retail_markdown_tier {
    case: {
      when: {
        sql: ${retail_markdown} = 0 ;;
        label: "0%"
      }

      when: {
        sql: ${retail_markdown} < 0.075 ;;
        label: "0 - 7.5%"
      }

      when: {
        sql: ${retail_markdown} < 0.15 ;;
        label: "7.5 - 15%"
      }

      when: {
        sql: ${retail_markdown} < 0.225 ;;
        label: "15% - 22.5%"
      }

      when: {
        sql: ${retail_markdown} < 0.3 ;;
        label: "22.5% - 30%"
      }

      when: {
        sql: ${retail_markdown} < 0.375 ;;
        label: "30% - 37.5%"
      }

      when: {
        sql: ${retail_markdown} < 0.45 ;;
        label: "37.5% - 45%"
      }

      when: {
        sql: ${retail_markdown} < 0.525 ;;
        label: "45% - 52.5%"
      }

      when: {
        sql: ${retail_markdown} < 0.6 ;;
        label: "52.5% - 60%"
      }

      else: "60% +"
    }
  }

  dimension: on_sale_flag {
    label: "Sale Product Flag"
    type: yesno
    sql: ${TABLE}.product_on_sale_flag = 1 ;;
  }

  dimension: pre_retail_markdown_price_gbp {
    type: number
    value_format_name: decimal_2
    sql: coalesce(${pre_sale_price}, ${price}) / ${exchange_rate} ;;
  }

  dimension: price_gbp {
    type: number
    value_format_name: decimal_2
    sql: ${price} / ${exchange_rate} ;;
  }

  dimension: max_selling_price {
    type: number
    value_format_name: decimal_2
    sql: ${TABLE}.max_selling_price ;;
  }

  dimension: max_selling_price_gbp {
    type: number
    value_format_name: decimal_2
    sql: ${max_selling_price} / ${exchange_rate} ;;
  }

  dimension: selling_price_tiered {
    case: {
      when: {
        sql: ${price_gbp} < 20 ;;
        label: "£0 - £20"
      }

      when: {
        sql: ${price_gbp} < 40 ;;
        label: "£20 - £40"
      }

      when: {
        sql: ${price_gbp} < 60 ;;
        label: "£40 - £60"
      }

      when: {
        sql: ${price_gbp} < 80 ;;
        label: "£60 - £80"
      }

      when: {
        sql: ${price_gbp} < 100 ;;
        label: "£80 - £100"
      }

      when: {
        sql: ${price_gbp} < 150 ;;
        label: "£100 - £150"
      }

      when: {
        sql: ${price_gbp} < 200 ;;
        label: "£150 - £200"
      }

      when: {
        sql: ${price_gbp} < 300 ;;
        label: "£200 - £300"
      }

      else: "£300 and over"
    }
  }

  dimension: quantity {
    sql: ${TABLE}.quantity ;;
  }

  dimension: landed_cost_per_unit_gbp {
    type: number
    value_format_name: decimal_2
    sql: ${variant_info.total_landed_cost_gbp} ;;
  }

  dimension: discount_level_tier {
    case: {
      when: {
        sql: ${price}/${max_selling_price} > 0.925 ;;
        label: "0% - 7.5%"
      }

      when: {
        sql: ${price}/${max_selling_price} > 0.825 ;;
        label: "7.5% - 17.5%"
      }

      when: {
        sql: ${price}/${max_selling_price} > 0.725 ;;
        label: "17.5% - 27.5%"
      }

      when: {
        sql: ${price}/${max_selling_price} > 0.625 ;;
        label: "27.5% - 37.5%"
      }

      else: "37.5% and over"
    }
  }

  ####################### REVENUE DIMENSIONS ##########################################################################################################################################

  dimension: gross_item_revenue {
    type: number
    value_format_name: decimal_2
    sql: ${TABLE}.price * ${TABLE}.quantity ;;
    hidden: yes
  }

  dimension: gross_item_revenue_pre_retail_markdown_gbp {
    type: number
    sql: ${pre_retail_markdown_price_gbp} * ${TABLE}.quantity ;;
  }

  dimension: gross_item_revenue_in_gbp {
    type: number
    value_format_name: decimal_2
    sql: ${price_gbp} * ${TABLE}.quantity ;;
  }

  dimension: gross_item_revenue_ex_voucher_discount_gbp {
    type: number
    value_format_name: decimal_2
    sql: case when ${TABLE}.order_total = 0 then 0 else ${gross_item_revenue_in_gbp} * ((${TABLE}.order_total + ${TABLE}.adjustment_total)/${TABLE}.order_total) end ;;
  }

  dimension: gross_item_revenue_ex_discount_ex_vat_gbp {
    type: number
    value_format_name: decimal_2
    sql: case when ${TABLE}.order_total = 0 then 0 else (${gross_item_revenue_in_gbp} * ((${TABLE}.order_total + ${TABLE}.adjustment_total)/${TABLE}.order_total) / (1+${tax_rate})) end ;;
  }

  ####
  dimension: net_item_revenue {
    type: number
    value_format_name: decimal_2
    sql: ${TABLE}.price * (${TABLE}.quantity - ${TABLE}.items_returned) ;;
    hidden: yes
  }

  dimension: net_item_revenue_pre_retail_markdown_gbp {
    type: number
    sql: ${pre_retail_markdown_price_gbp} * (${TABLE}.quantity - ${TABLE}.items_returned) ;;
  }

  dimension: net_item_revenue_in_gbp {
    type: number
    value_format_name: decimal_2
    sql: ${price_gbp} * (${TABLE}.quantity - ${TABLE}.items_returned) ;;
  }

  dimension: net_item_revenue_ex_voucher_discount_gbp {
    type: number
    value_format_name: decimal_2
    sql: case when ${TABLE}.order_total = 0 then 0 else ${net_item_revenue_in_gbp} * ((${TABLE}.order_total + ${TABLE}.adjustment_total)/${TABLE}.order_total) end ;;
  }

  dimension: net_item_revenue_ex_discount_ex_vat_gbp {
    type: number
    value_format_name: decimal_2
    sql: case when ${TABLE}.order_total = 0 then 0 else (${net_item_revenue_in_gbp} * ((${TABLE}.order_total + ${TABLE}.adjustment_total)/${TABLE}.order_total) / (1+${tax_rate})) end ;;
  }

  ####


  # Margin Dimensions
  dimension: landed_cost_gbp {
    type: number
    value_format_name: decimal_2
    sql: ${landed_cost_per_unit_gbp} * ${quantity} ;;
  }

  #################################### Returns Dimensions #########################################################################################################################

  dimension: items_returned {
    sql: ${TABLE}.items_returned ;;
  }

  dimension: return_reason {
    sql: ${TABLE}.return_reason ;;
  }

  dimension_group: return_time {
    type: time
    timeframes: [date, week, month]
    sql: ${TABLE}.return_tstamp ;;
  }

  dimension: days_to_process_return {
    type: number
    sql: ${return_time_date} - ${order_time_date} ;;
  }

  dimension: return_item_value_gbp {
    type: number
    value_format_name: decimal_2
    sql: ${price_gbp} * ${TABLE}.items_returned ;;
    hidden: yes
  }

  dimension: net_reveune_after_returns_gbp {
    type: number
    value_format_name: decimal_2
    sql: ${price_gbp} * (${TABLE}.quantity - ${TABLE}.items_returned) ;;
    hidden: yes
  }

  #################################################################################################################################################################################
  ############################################################ MEASURES ###########################################################################################################
  #################################################################################################################################################################################

  measure: count_orders {
    type: count_distinct
    sql: ${TABLE}.order_id ;;
  }

  measure: distinct_skus_sold {
    type: count_distinct
    sql: ${TABLE}.sku ;;
  }

  measure: total_items_sold {
    label: "Items Sold"
    type: sum
    sql: ${TABLE}.quantity ;;
    group_label: "Items Sold Measures"
  }

  ########################################### Returns Measures #################################################################################################################

  measure: total_items_returned {
    label: "Items Returned"
    type: sum
    sql: coalesce(${items_returned}, 0) ;;
    group_label: "Items Returned Measures"
  }

  measure: total_items_returned_size {
    label: "Items Returned - Size Issues"
    type: sum
    sql: coalesce(${items_returned}, 0) ;;

    filters: {
      field: return_reason
      value: "It's too small, It's too large, Too large, Too small"
    }
  }

  measure: total_items_returned_too_big {
    label: "Items Returned - Too Big"
    type: sum
    sql: coalesce(${items_returned}, 0) ;;

    filters: {
      field: return_reason
      value: "It's too large, Too large"
    }
  }

  measure: total_items_returned_doesnt_suit {
    label: "Items Returned - Doesn't Suit Me"
    type: sum
    sql: coalesce(${items_returned}, 0) ;;

    filters: {
      field: return_reason
      value: "It doesn't suit me, Not right for me - fabric, Not right for me - colour, Not right for me - other"
    }
  }

  measure: total_items_returned_too_small {
    label: "Items Returned - Too Small"
    type: sum
    sql: coalesce(${items_returned}, 0) ;;

    filters: {
      field: return_reason
      value: "It's too small, Too small"
    }
  }

  measure: total_items_returned_not_as_pictured_not_as_described {
    label: "Items Returned - Not as Pictured or Described"
    type: sum
    sql: coalesce(${items_returned}, 0) ;;

    filters: {
      field: return_reason
      value: "It's not as described, It's not as pictured, Not as pictured - fabric, Not as pictured - colour, Not as pictured - length"
    }
  }

  measure: total_items_returned_not_as_described {
    label: "Items Returned - Not as Described"
    type: sum
    sql: coalesce(${items_returned}, 0) ;;

    filters: {
      field: return_reason
      value: "It's not as described"
    }
  }

  measure: total_items_returned_not_as_pictured {
    label: "Items Returned - Not as Pictured"
    type: sum
    sql: coalesce(${items_returned}, 0) ;;

    filters: {
      field: return_reason
      value: "It's not as pictured, Not as pictured - fabric, Not as pictured - colour, Not as pictured - length"
    }
  }

  measure: total_items_returned_other {
    label: "Items Returned - Other Please Specify"
    type: sum
    sql: coalesce(${items_returned}, 0) ;;

    filters: {
      field: return_reason
      value: "Other, Other - please specify in writing"
    }
  }

  measure: total_items_returned_faulty {
    label: "Items Returned - Faulty"
    type: sum
    sql: coalesce(${items_returned}, 0) ;;

    filters: {
      field: return_reason
      value: "It's faulty/in a poor condition, Faulty/in a poor condition"
    }
  }

  measure: total_items_returned_ordered_more_than_1_size {
    label: "Items Returned - Ordered > 1 Size"
    type: sum
    sql: coalesce(${items_returned}, 0) ;;

    filters: {
      field: return_reason
      value: "I ordered more than one size, Ordered more than one"
    }
  }

  measure: total_items_returned_arrived_late {
    label: "Items Returned - It Arrived Too Late"
    type: sum
    sql: coalesce(${items_returned}, 0) ;;

    filters: {
      field: return_reason
      value: "It arrived too late"
    }
  }

  measure: total_items_returned_wrong_item_or_size {
    label: "Items Returned - Received Wrong Item/Size"
    type: sum
    sql: coalesce(${items_returned}, 0) ;;

    filters: {
      field: return_reason
      value: "I received the wrong item or size"
    }
  }

  measure: total_items_returned_too_long_or_short {
    label: "Items Returned - Too Long/Short"
    type: sum
    sql: coalesce(${items_returned}, 0) ;;

    filters: {
      field: return_reason
      value: "Too long, Too short"
    }
  }

  measure: total_items_returned_too_long {
    label: "Items Returned - Too Long"
    type: sum
    sql: coalesce(${items_returned}, 0) ;;

    filters: {
      field: return_reason
      value: "Too long"
    }
  }

  measure: total_items_returned_too_short {
    label: "Items Returned - Too Short"
    type: sum
    sql: coalesce(${items_returned}, 0) ;;

    filters: {
      field: return_reason
      value: "Too short"
    }
  }

  measure: items_sold_after_returns {
    type: sum
    sql: ${quantity} - ${items_returned} ;;
    group_label: "Items Sold Measures"
  }

  measure: return_rate {
    type: number
    value_format_name: percent_2
    sql: ${total_items_returned}/NULLIF(${total_items_sold},0)::REAL ;;
  }

  measure: sum_return_item_value_gbp {
    type: sum
    value_format_name: decimal_2
    sql: ${price} * ${items_returned} / ${exchange_rate} ;;
    hidden: yes
  }

  measure: sum_return_item_value_gbp_ex_vat {
    type: sum
    value_format_name: decimal_2
    sql: ${price} * ${items_returned} / (1+${tax_rate}) / ${exchange_rate} ;;
    hidden: yes
  }

  measure: return_rate_value {
    type: number
    value_format_name: percent_2
    sql: ${sum_return_item_value_gbp}/NULLIF(${sum_gross_item_revenue_in_gbp},0)::REAL ;;
  }

  ######################################################## GROSS Revenue Measures #######################################################################################################

  measure: sum_pre_retail_markdown_item_revenue_in_gbp {
    type: sum
    sql: ${gross_item_revenue_pre_retail_markdown_gbp} ;;
    value_format_name: decimal_2
  }

  measure: sum_gross_item_revenue_in_gbp {
    type: sum
    sql: ${price} * ${quantity} / ${exchange_rate} ;;
    value_format_name: decimal_2
  }

  measure: sum_gross_item_revenue_ex_voucher_discount_gbp {
    type: sum
    sql: ${gross_item_revenue_ex_voucher_discount_gbp} ;;
    value_format_name: decimal_2
  }

  measure: sum_net_item_revenue_gbp {
    type: sum
    sql: ${price} * (${quantity} - ${items_returned}) / ${exchange_rate} ;;
    value_format_name: decimal_2
  }

  measure: sum_gross_item_revenue_ex_discount_ex_vat_gbp {
    label: "Gross Revenue"
    type: sum
    sql: ${gross_item_revenue_ex_discount_ex_vat_gbp} ;;
    value_format_name: decimal_2
  }

  measure: sum_gross_item_revenue_in_gbp_ex_vat {
    type: sum
    sql: (${price} * ${quantity} / (1+${tax_rate})) / ${exchange_rate} ;;
    value_format_name: decimal_2
  }

  measure: sum_net_item_revenue_gbp_ex_vat {
    type: sum
    sql: (${price} * (${quantity} - ${items_returned}) / (1+${tax_rate})) / ${exchange_rate} ;;
    value_format_name: decimal_2
  }

  measure: sum_net_item_revenue_ex_discount_ex_vat_gbp {
    type: sum
    sql: ${net_item_revenue_ex_discount_ex_vat_gbp} ;;
    value_format_name: decimal_2
  }

  measure: count_days {
    type: count_distinct
    sql: ${order_time_date} ;;
    hidden: yes
  }

  measure: revenue_per_day {
    label: "Revenue per Day"
    type: number
    value_format_name: decimal_0
    sql: ${sum_gross_item_revenue_ex_discount_ex_vat_gbp}/nullif(${count_days},0)::REAL ;;
  }

  ########################################################## GROSS Margin Measures ########################################################################################################

  measure: sum_gross_landed_cost_gbp {
    type: sum
    sql: ${variant_info.total_landed_cost_gbp} * ${quantity} ;;
    value_format_name: decimal_2
  }

  measure: sum_gross_margin_gbp_ex_vat {
    type: number
    value_format_name: decimal_2
    sql: ${sum_gross_item_revenue_ex_discount_ex_vat_gbp} - ${sum_gross_landed_cost_gbp} ;;
  }

  measure: gross_margin_percent_ex_vat {
    type: number
    value_format_name: percent_2
    sql: ${sum_gross_margin_gbp_ex_vat}/NULLIF(${sum_gross_item_revenue_ex_discount_ex_vat_gbp},0)::REAL ;;
  }

  ########################################################## NET Margin Measures ########################################################################################################

  measure: sum_net_landed_cost_gbp {
    type: sum
    sql: ${variant_info.total_landed_cost_gbp} * (${quantity} - ${items_returned}) ;;
    value_format_name: decimal_2
  }

  measure: sum_net_margin_gbp_ex_vat {
    type: number
    value_format_name: decimal_2
    sql: ${sum_net_item_revenue_ex_discount_ex_vat_gbp} - ${sum_net_landed_cost_gbp} ;;
  }

  measure: net_margin_percent_ex_vat {
    type: number
    value_format_name: percent_2
    sql: ${sum_net_margin_gbp_ex_vat}/NULLIF(${sum_net_item_revenue_ex_discount_ex_vat_gbp},0)::REAL ;;
  }

  ###################################################### DISCOUNT STUFF ##################################################

  measure: avg_retail_markdown {
    type: number
    value_format_name: percent_2
    sql: (${sum_pre_retail_markdown_item_revenue_in_gbp} - ${sum_gross_item_revenue_in_gbp})/NULLIF(${sum_pre_retail_markdown_item_revenue_in_gbp},0)::REAL ;;
  }

  measure: avg_voucher_discount {
    type: number
    value_format_name: percent_2
    sql: (${sum_gross_item_revenue_in_gbp} - ${sum_gross_item_revenue_ex_voucher_discount_gbp})/NULLIF(${sum_pre_retail_markdown_item_revenue_in_gbp},0)::REAL ;;
  }

  measure: avg_total_discount {
    type: number
    value_format_name: percent_2
    sql: ${avg_retail_markdown} + ${avg_voucher_discount} ;;
  }

  measure: total_retail_markdown {
    type: number
    value_format_name: decimal_2
    sql: ${sum_pre_retail_markdown_item_revenue_in_gbp} - ${sum_gross_item_revenue_in_gbp} ;;
  }

  measure: total_voucher_discount {
    type: number
    value_format_name: decimal_2
    sql: ${sum_gross_item_revenue_in_gbp} - ${sum_gross_item_revenue_ex_voucher_discount_gbp} ;;
  }

  measure: total_discount {
    type: number
    value_format_name: decimal_2
    sql: ${total_retail_markdown} + ${total_voucher_discount} ;;
  }

  ####################################################################################
  ################################################# TW, LW, L4W, MTD, STD #######################################################################################################################
  ####################################################################################

  # Revenue

  measure: gross_rev_ex_discount_ex_vat_tw {
    label: "TW"
    type: sum
    sql: ${gross_item_revenue_ex_discount_ex_vat_gbp} ;;
    group_label: "Gross Revenue ex Discount & VAT Measures"
    value_format_name: decimal_2

    filters: {
      field: order_time_date
      value: "last week"
    }
  }

  measure: gross_rev_ex_discount_ex_vat_lw {
    label: "LW"
    type: sum
    sql: ${gross_item_revenue_ex_discount_ex_vat_gbp} ;;
    group_label: "Gross Revenue ex Discount & VAT Measures"
    value_format_name: decimal_2

    filters: {
      field: order_time_date
      value: "2 weeks ago"
    }
  }

  measure: gross_rev_ex_discount_ex_vat_tw_ly {
    label: "TW - LY"
    type: number
    value_format_name: decimal_2
    group_label: "Gross Revenue ex Discount & VAT Measures"
    sql: sum (
      case when ${order_time_week_of_year} = EXTRACT(WEEK FROM current_date - 8)
      and ${order_time_date} between current_date - 400 and current_date - 300
      then ${gross_item_revenue_ex_discount_ex_vat_gbp} else null end
      )
      ;;
  }


  measure: gross_rev_ex_discount_ex_vat_l4w {
    label: "L4W"
    type: sum
    sql: ${gross_item_revenue_ex_discount_ex_vat_gbp} ;;
    group_label: "Gross Revenue ex Discount & VAT Measures"
    value_format_name: decimal_2

    filters: {
      field: order_time_date
      value: "5 weeks ago for 4 weeks"
    }
  }

  measure: gross_rev_ex_discount_ex_vat_mtd {
    label: "MTD"
    type: sum
    sql: ${gross_item_revenue_ex_discount_ex_vat_gbp} ;;
    group_label: "Gross Revenue ex Discount & VAT Measures"
    value_format_name: decimal_2

    filters: {
      field: order_time_date
      value: "this month"
    }

    filters: {
      field: order_time_time
      value: "before this week"
    }
  }

  measure: gross_rev_ex_discount_ex_vat_std {
    label: "STD"
    type: sum
    sql: ${gross_item_revenue_ex_discount_ex_vat_gbp} ;;
    group_label: "Gross Revenue ex Discount & VAT Measures"
    value_format_name: decimal_2

    filters: {
      field: order_time_date
      value: "after 2015/02/01"
    }

    filters: {
      field: order_time_time
      value: "before this week"
    }
  }

  # Profit

  measure: pc1_profit_tw {
    label: "TW"
    type: sum
    value_format_name: decimal_2
    sql: ${gross_item_revenue_ex_discount_ex_vat_gbp} - (${variant_info.total_landed_cost_gbp} * ${quantity}) ;;
    group_label: "PC1 Profit Measures"

    filters: {
      field: order_time_date
      value: "last week"
    }
  }

  measure: pc1_profit_lw {
    label: "LW"
    type: sum
    value_format_name: decimal_2
    sql: ${gross_item_revenue_ex_discount_ex_vat_gbp} - (${variant_info.total_landed_cost_gbp} * ${quantity}) ;;
    group_label: "PC1 Profit Measures"

    filters: {
      field: order_time_date
      value: "2 weeks ago"
    }
  }

  measure: pc1_profit_l4w {
    label: "L4W"
    type: sum
    value_format_name: decimal_2
    sql: ${gross_item_revenue_ex_discount_ex_vat_gbp} - (${variant_info.total_landed_cost_gbp} * ${quantity}) ;;
    group_label: "PC1 Profit Measures"

    filters: {
      field: order_time_date
      value: "5 weeks ago for 4 weeks"
    }
  }

  measure: pc1_proit_tw_ly {
    label: "TW - LY"
    type: number
    value_format_name: decimal_2
    sql: sum (
      case when ${order_time_week_of_year} = EXTRACT(WEEK FROM current_date - 8)
      and ${order_time_date} between current_date - 400 and current_date - 300
      then (${gross_item_revenue_ex_discount_ex_vat_gbp} - (${variant_info.total_landed_cost_gbp} * ${quantity}))  else null end
      )
      ;;
    group_label: "PC1 Profit Measures"
  }

  measure: pc1_profit_mtd {
    label: "MTD"
    type: sum
    value_format_name: decimal_2
    sql: ${gross_item_revenue_ex_discount_ex_vat_gbp} - (${variant_info.total_landed_cost_gbp} * ${quantity}) ;;
    group_label: "PC1 Profit Measures"

    filters: {
      field: order_time_date
      value: "this month"
    }

    filters: {
      field: order_time_time
      value: "before this week"
    }
  }

  measure: pc1_profit_std {
    label: "STD"
    type: sum
    value_format_name: decimal_2
    sql: ${gross_item_revenue_ex_discount_ex_vat_gbp} - (${variant_info.total_landed_cost_gbp} * ${quantity}) ;;
    group_label: "PC1 Profit Measures"

    filters: {
      field: order_time_date
      value: "after 2015/02/01"
    }

    filters: {
      field: order_time_time
      value: "before this week"
    }
  }

  # Units Sold

  measure: items_sold_tw {
    label: "TW"
    type: sum
    sql: ${TABLE}.quantity ;;
    group_label: "Items Sold Measures"

    filters: {
      field: order_time_date
      value: "last week"
    }
  }

  measure: items_sold_lw {
    label: "LW"
    type: sum
    sql: ${TABLE}.quantity ;;
    group_label: "Items Sold Measures"

    filters: {
      field: order_time_date
      value: "2 weeks ago"
    }
  }

  measure: items_sold_tw_ly {
    label: "TW - LY"
    type: number
    value_format_name: integer
    group_label: "Items Sold Measures"
    sql: sum (
      case when ${order_time_week_of_year} = EXTRACT(WEEK FROM current_date - 8)
      and ${order_time_date} between current_date - 400 and current_date - 300
      then ${TABLE}.quantity  else null end
      )
      ;;
  }

  measure: items_sold_l4w {
    label: "L4W"
    type: sum
    sql: ${TABLE}.quantity ;;
    group_label: "Items Sold Measures"

    filters: {
      field: order_time_date
      value: "5 weeks ago for 4 weeks"
    }
  }

  measure: items_sold_mtd {
    label: "MTD"
    type: sum
    sql: ${TABLE}.quantity ;;
    group_label: "Items Sold Measures"

    filters: {
      field: order_time_date
      value: "this month"
    }

    filters: {
      field: order_time_time
      value: "before this week"
    }
  }

  measure: items_sold_std {
    label: "STD"
    type: sum
    sql: ${TABLE}.quantity ;;
    group_label: "Items Sold Measures"

    filters: {
      field: order_time_date
      value: "after 2015/02/01"
    }

    filters: {
      field: order_time_time
      value: "before this week"
    }
  }
}
