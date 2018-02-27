view: daily_sales {
  sql_table_name: sales.daily_variant_info ;;
  #################################################################################################################################################################################################
  ########################################################## DIMENSIONS ###########################################################################################################################
  #################################################################################################################################################################################################

  dimension_group: calendar_date {
    label: "Calendar"
    type: time
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
    convert_tz: no
    sql: ${TABLE}.calendar_date ;;
  }

  dimension: year_week_number {
    label: "Year Week Number"
    sql: ${TABLE}.year_week_number ;;
    hidden: yes
  }

  dimension: sku {
    label: "Ean"
    sql: ${TABLE}.ean ;;
  }

  dimension: count_on_hand {
    #    type: number
    sql: coalesce(${TABLE}.closing_stock, 0) ;;
    hidden: yes
  }

  dimension: items_sold {
    sql: ${TABLE}.items_sold ;;
    hidden: yes
  }

  ##
  #  - dimension: after_first_option_sales_date_flag
  #    label: After First Option Sales Date (Yes/No)
  #    type: yesno
  #    sql: ${TABLE}.calendar_date >= ${TABLE}.first_option_sales_date


  dimension: price {
    type: number
    value_format_name: decimal_2
    sql: coalesce(${product_info_option_daily.price}, ${option_info.current_price_gbp}) ;;
  }

  dimension: original_price {
    type: number
    value_format_name: decimal_2
    sql: case
      when ${product_info_option_daily.pre_sale_price} is null then ${price}
      when ${price} >= ${product_info_option_daily.pre_sale_price} then ${price}
      else coalesce(${product_info_option_daily.pre_sale_price}, ${option_info.current_price_gbp}) end
       ;;
  }

  dimension: retail_markdown {
    type: number
    value_format_name: percent_2
    sql: case when ${original_price} = 0 then 0 else (${original_price} - ${price}) / ${original_price} end ;;
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

  #################################################################################################################################################################################################
  ########################################################## MEASURES #############################################################################################################################
  #################################################################################################################################################################################################

  # Item Measures

  measure: sum_items_sold {
    label: "Gross Units Sold"
    type: sum
    sql: ${TABLE}.items_sold ;;
    group_label: "Units Sold Measures"
  }

  measure: sum_items_sold_as_percent {
    label: "Units Sold Mix"
    type: percent_of_total
    sql: ${sum_items_sold} ;;
    group_label: "Units Sold Measures"
  }

  measure: sum_items_returned {
    label: "Units Returned"
    type: sum
    sql: ${TABLE}.items_returned ;;
  }

  measure: sum_returns_value_cost {
    label: "Returns Value @ Cost"
    type: sum
    sql: coalesce(${product_info_variants.total_landed_cost_gbp}, 0)*${TABLE}.items_returned ;;
  }

  measure: sum_items_sold_after_returns {
    label: "Net Units Sold"
    type: sum
    sql: ${TABLE}.items_sold_after_returns ;;
    group_label: "Units Sold Measures"
  }

  measure: return_rate {
    label: "Return Rate"
    type: number
    value_format_name: percent_2
    sql: ${sum_items_returned}/NULLIF(${sum_items_sold},0)::REAL ;;
  }

  measure: first_sale_date {
    label: "First Sales Date"
    type: date
    sql: MIN(case when ${items_sold} > 0 then ${calendar_date_date} else null end) ;;
    convert_tz: no
  }

  measure: last_sale_date {
    label: "Last Sales Date"
    type: date
    sql: MAX(case when ${items_sold} > 0 then ${calendar_date_date} else null end) ;;
    convert_tz: no
  }

  # Value Measures

  measure: gross_item_revenue_gbp {
    label: "Gross Revenue (pre Discount)"
    type: sum
    value_format_name: decimal_2
    sql: ${TABLE}.gross_revenue_gbp ;;
  }

  measure: gross_item_revenue_gbp_ex_vat {
    label: "Gross Revenue (pre Discount) ex. VAT"
    type: sum
    value_format_name: decimal_2
    sql: ${TABLE}.gross_revenue_gbp_ex_vat ;;
  }

  measure: gross_item_revenue_gbp_ex_vat_ex_discount {
    label: "Gross Revenue ex. VAT & Discount"
    type: sum
    value_format_name: decimal_2
    sql: ${TABLE}.gross_revenue_gbp_ex_vat_ex_discount ;;
    group_label: "Gross Revenue ex. VAT & Discount Measures"
  }

  measure: gross_item_revenue_gbp_ex_discount {
    label: "Gross Revenue ex. Discount"
    type: sum
    value_format_name: decimal_2
    sql: ${TABLE}.gross_revenue_gbp_ex_discount ;;
    group_label: "Gross Revenue ex. Discount Measures"
  }

  measure: sales_mix {
    label: "Revenue Mix"
    type: percent_of_total
    sql: ${gross_item_revenue_gbp_ex_vat_ex_discount} ;;
    group_label: "Gross Revenue ex. VAT & Discount Measures"
  }

  measure: net_item_revenue_gbp {
    label: "Net Revenue (pre Discount)"
    type: sum
    value_format_name: decimal_2
    sql: ${TABLE}.net_revenue_gbp ;;
  }

  measure: net_item_revenue_gbp_ex_vat_ex_discount {
    label: "Net Revenue ex. VAT & Discount"
    type: sum
    value_format_name: decimal_2
    sql: ${TABLE}.net_revenue_gbp_ex_vat_ex_discount ;;
  }

  measure: net_item_revenue_gbp_ex_discount {
    label: "Net Revenue ex. Discount"
    type: sum
    value_format_name: decimal_2
    sql: ${TABLE}.net_revenue_gbp_ex_discount ;;
  }

  measure: return_item_value_gbp {
    label: "Return Item Value"
    type: number
    value_format_name: decimal_2
    sql: ${gross_item_revenue_gbp} - ${net_item_revenue_gbp} ;;
  }

  measure: return_item_value_gbp_ex_vat_ex_discount {
    label: "Return Item Value ex. VAT & Discount"
    type: number
    value_format_name: decimal_2
    sql: ${gross_item_revenue_gbp_ex_vat_ex_discount} - ${net_item_revenue_gbp_ex_vat_ex_discount} ;;
  }

  # ASP

  measure: asp {
    label: "Average Selling Price"
    type: number
    value_format_name: decimal_2
    sql: ${gross_item_revenue_gbp}/NULLIF(${sum_items_sold},0)::REAL ;;
    group_label: "Average Selling Price Measures"
  }

  measure: asp_ex_vat {
    label: "Average Selling Price ex. VAT"
    type: number
    value_format_name: decimal_2
    sql: ${gross_item_revenue_gbp_ex_vat}/NULLIF(${sum_items_sold},0)::REAL ;;
    group_label: "Average Selling Price Measures"
  }

  measure: asp_ex_vat_ex_discount {
    label: "Average Selling Price ex. VAT & Discount"
    type: number
    value_format_name: decimal_2
    sql: ${gross_item_revenue_gbp_ex_vat_ex_discount}/NULLIF(${sum_items_sold},0)::REAL ;;
    group_label: "Average Selling Price Measures"
  }

  # Margin Measures

  measure: sum_cost_gbp {
    label: "Gross Cost of Goods Sold"
    type: sum
    value_format_name: decimal_2
    sql: coalesce(${product_info_variants.total_landed_cost_gbp}, 0) * ${TABLE}.items_sold ;;
  }

  measure: sum_net_cost_gbp {
    label: "Net Cost of Goods Sold"
    type: sum
    value_format_name: decimal_2
    sql: coalesce(${product_info_variants.total_landed_cost_gbp}, 0) * ${TABLE}.items_sold_after_returns ;;
  }

  measure: gross_margin_percent {
    label: "Gross Margin %"
    type: number
    value_format_name: percent_2
    sql: (${gross_item_revenue_gbp_ex_vat_ex_discount} - ${sum_cost_gbp})/NULLIF(${gross_item_revenue_gbp_ex_vat_ex_discount},0)::REAL ;;
  }

  # Stock Measures

  measure: closing_stock {
    label: "Closing Stock Units"
    type: sum
    sql: ${TABLE}.closing_stock ;;
    group_label: "Closing Stock Unit Measures"
  }

  measure: closing_stock_yesterday {
    label: "Closing Stock Units - Yesterday"
    type: sum
    sql: ${TABLE}.closing_stock ;;
    group_label: "Closing Stock Unit Measures"

    filters: {
      field: calendar_date_date
      value: "1 day ago for 1 day"
    }
  }

  measure: closing_stock_last_week {
    label: "Closing Stock Unit Last Week"
    type: sum
    sql: ${TABLE}.closing_stock ;;
    group_label: "Closing Stock Unit Measures"

    filters: {
      field: calendar_date_date
      value: "last week"
    }

    filters: {
      field: calendar_date_day_of_week_index
      value: "6"
    }
  }

  measure: closing_stock_week_before_last {
    label: "Closing Stock Unit 2 Weeks Ago"
    type: sum
    sql: ${TABLE}.closing_stock ;;
    group_label: "Closing Stock Unit Measures"

    filters: {
      field: calendar_date_date
      value: "2 weeks ago"
    }

    filters: {
      field: calendar_date_day_of_week_index
      value: "6"
    }
  }

  measure: closing_stock_end_of_week {
    label: "Closing Stock Unit End of Week"
    type: sum
    sql: ${TABLE}.closing_stock ;;
    group_label: "Closing Stock Unit Measures"

    filters: {
      field: calendar_date_day_of_week_index
      value: "6"
    }
  }

  measure: closing_stock_end_of_week_last_year {
    label: "Closing Stock Unit Last Week - LY"
    type: number
    sql: sum (
      case when ${calendar_date_day_of_week_index} = 6
      and ${calendar_date_week_of_year} = EXTRACT(WEEK FROM dateadd(week, -1, current_date))
      and ${calendar_date_date} between current_date - 400 and current_date - 300
      then ${TABLE}.closing_stock else 0 end
      )
       ;;
    group_label: "Closing Stock Unit Measures"
    value_format: "#,##0"
  }

  measure: closing_stock_yesterday_yoy {
    label: "Closing Stock Unit Last Week - YoY"
    type: number
    value_format_name: percent_2
    sql: (${closing_stock_last_week} - ${closing_stock_end_of_week_last_year})/NULLIF(${closing_stock_end_of_week_last_year},0)::REAL ;;
    group_label: "Closing Stock Unit Measures"
  }

  # stock value @ cost

  measure: closing_stock_value_cost {
    label: "Closing Stock Value @ Cost"
    type: sum
    value_format_name: decimal_2
    sql: ${TABLE}.closing_stock*coalesce(${product_info_variants.total_landed_cost_gbp}, 0) ;;
    group_label: "Closing Stock Value @ Cost Measures"
  }

  measure: closing_stock_value_cost_yesterday {
    label: "Closing Stock Value @ Cost - Yesterday"
    type: sum
    value_format_name: decimal_2
    sql: ${TABLE}.closing_stock*coalesce(${product_info_variants.total_landed_cost_gbp}, 0) ;;
    group_label: "Closing Stock Value @ Cost Measures"

    filters: {
      field: calendar_date_date
      value: "1 day ago for 1 day"
    }
  }

  measure: closing_stock_value_cost_last_week {
    label: "Closing Stock Value @ Cost - Last Week"
    type: sum
    value_format_name: decimal_2
    sql: ${TABLE}.closing_stock*coalesce(${product_info_variants.total_landed_cost_gbp}, 0) ;;
    group_label: "Closing Stock Value @ Cost Measures"

    filters: {
      field: calendar_date_date
      value: "last week"
    }

    filters: {
      field: calendar_date_day_of_week_index
      value: "6"
    }
  }

  measure: closing_stock_value_cost_week_before_last {
    label: "Closing Stock Value @ Cost - 2 Weeks Ago"
    type: sum
    value_format_name: decimal_2
    sql: ${TABLE}.closing_stock*coalesce(${product_info_variants.total_landed_cost_gbp}, 0) ;;
    group_label: "Closing Stock Value @ Cost Measures"

    filters: {
      field: calendar_date_date
      value: "2 weeks ago"
    }

    filters: {
      field: calendar_date_day_of_week_index
      value: "6"
    }
  }

  measure: closing_stock_value_cost_end_of_week {
    label: "Closing Stock Value @ Cost - End of Week"
    type: sum
    value_format_name: decimal_2
    sql: ${TABLE}.closing_stock*coalesce(${product_info_variants.total_landed_cost_gbp}, 0) ;;
    group_label: "Closing Stock Value @ Cost Measures"

    filters: {
      field: calendar_date_day_of_week_index
      value: "6"
    }
  }

  measure: closing_stock_value_cost_end_of_week_last_year {
    label: "Closing Stock Value @ Cost - End of Week - LY"
    type: number
    sql: sum (
      case when ${calendar_date_day_of_week_index} = 6
      and ${calendar_date_week_of_year} = EXTRACT(WEEK FROM dateadd(week, -1, current_date))
      and ${calendar_date_date} between current_date - 400 and current_date - 300
      then ${TABLE}.closing_stock*coalesce(${product_info_variants.total_landed_cost_gbp}, 0) else 0 end
      )
       ;;
    group_label: "Closing Stock Value @ Cost Measures"
    value_format: "#,##0"
  }

  # closing stock @ retail

  measure: closing_stock_value_retail {
    label: "Closing Stock Value @ Retail"
    type: sum
    value_format_name: decimal_2
    sql: CASE WHEN ${count_on_hand} = 0 THEN 0 ELSE (${count_on_hand} * ${price}) END ;;
    group_label: "Closing Stock Value @ Retail Measures"
  }

  measure: closing_stock_value_retail_yesterday {
    label: "Closing Stock Value @ Retail - Yesterday"
    type: sum
    value_format_name: decimal_2
    sql: ${TABLE}.closing_stock * ${price} ;;
    group_label: "Closing Stock Value @ Retail Measures"

    filters: {
      field: calendar_date_date
      value: "1 day ago for 1 day"
    }
  }

  measure: stock_mix_retail_yesterday {
    label: "Stock Retail Value Mix - Yesterday"
    type: percent_of_total
    sql: ${closing_stock_value_retail_yesterday} ;;
    group_label: "Clsoing Stock Value @ Retail Measures"
    value_format: "#,##0.00"
  }

  measure: closing_stock_value_retail_last_week {
    label: "Closing Stock Value @ Retail - Last Week"
    type: sum
    value_format_name: decimal_2
    sql: ${TABLE}.closing_stock * ${price} ;;
    group_label: "Closing Stock Value @ Retail Measures"

    filters: {
      field: calendar_date_date
      value: "last week"
    }

    filters: {
      field: calendar_date_day_of_week_index
      value: "6"
    }
  }

  measure: closing_stock_value_retail_week_before_last {
    label: "Closing Stock Value @ Retail - 2 Weeks Ago"
    type: sum
    value_format_name: decimal_2
    sql: ${TABLE}.closing_stock * ${price} ;;
    group_label: "Closing Stock Value @ Retail Measures"

    filters: {
      field: calendar_date_date
      value: "2 weeks ago"
    }

    filters: {
      field: calendar_date_day_of_week_index
      value: "6"
    }
  }

  measure: closing_stock_value_retail_end_of_week {
    label: "Closing Stock Value @ Retail - End of Week"
    type: sum
    value_format_name: decimal_2
    sql: ${TABLE}.closing_stock * ${price} ;;
    group_label: "Closing Stock Value @ Retail Measures"

    filters: {
      field: calendar_date_day_of_week_index
      value: "6"
    }
  }

  measure: closing_stock_value_retail_end_of_week_last_year {
    label: "Closing Stock Value @ Retail - End of Week - LY"
    type: number
    sql: sum (
      case when ${calendar_date_day_of_week_index} = 6
      and ${calendar_date_week_of_year} = EXTRACT(WEEK FROM dateadd(week, -1, current_date))
      and ${calendar_date_date} between current_date - 400 and current_date - 300
      then ${TABLE}.closing_stock * ${price} else 0 end
      )
       ;;
    group_label: "Closing Stock Value @ Retail Measures"
    value_format: "#,##0"
  }

  # closing stock @ retail (FULL PRICE)

  measure: closing_stock_value_retail_full_price {
    label: "Closing Stock Value @ Retail (Full Price)"
    type: sum
    value_format_name: decimal_2
    sql: ${TABLE}.closing_stock*${original_price} ;;
    group_label: "Closing Stock Value Full Price @ Retail Measures"
  }

  measure: closing_stock_value_retail_yesterday_full_price {
    label: "Closing Stock Value Full - Yesterday (Full Price)"
    type: sum
    value_format_name: decimal_2
    sql: ${TABLE}.closing_stock*${original_price} ;;
    group_label: "Closing Stock Value Full Price @ Retail Measures"

    filters: {
      field: calendar_date_date
      value: "1 day ago for 1 day"
    }
  }

  measure: closing_stock_value_retail_last_week_full_price {
    label: "Closing Stock Value Full - Last Week (Full Price)"
    type: sum
    value_format_name: decimal_2
    sql: ${TABLE}.closing_stock*${original_price} ;;
    group_label: "Closing Stock Value Full Price @ Retail Measures"

    filters: {
      field: calendar_date_date
      value: "last week"
    }

    filters: {
      field: calendar_date_day_of_week_index
      value: "6"
    }
  }

  measure: closing_stock_value_retail_week_before_last_full_price {
    label: "Closing Stock Value Full - 2 Weeks Ago (Full Price)"
    type: sum
    value_format_name: decimal_2
    sql: ${TABLE}.closing_stock*${original_price} ;;
    group_label: "Closing Stock Value Full Price @ Retail Measures"

    filters: {
      field: calendar_date_date
      value: "2 weeks ago"
    }

    filters: {
      field: calendar_date_day_of_week_index
      value: "6"
    }
  }

  measure: closing_stock_value_retail_end_of_week_full_price {
    label: "Closing Stock Value Full - End of Week (Full Price)"
    type: sum
    value_format_name: decimal_2
    sql: ${TABLE}.closing_stock*${original_price} ;;
    group_label: "Closing Stock Value Full Price @ Retail Measures"

    filters: {
      field: calendar_date_day_of_week_index
      value: "6"
    }
  }

  measure: closing_stock_value_retail_end_of_week_full_price_last_year {
    label: "Closing Stock Value Full - End of Week (Full Price) - LY"
    type: number
    sql: sum (
      case when ${calendar_date_day_of_week_index} = 6
      and ${calendar_date_week_of_year} = EXTRACT(WEEK FROM dateadd(week, -1, current_date))
      and ${calendar_date_date} between current_date - 400 and current_date - 300
      then ${TABLE}.closing_stock*${original_price} else 0 end
      )
       ;;
    group_label: "Closing Stock Value Full Price @ Retail Measures"
    value_format: "#,##0"
  }

  ### Number of sku's in stock measures

  measure: skus_in_stock_last_week {
    label: "Sizes In Stock - Last Week"
    type: count_distinct
    sql: ${sku} ;;
    group_label: "Sizes In Stock Measures"

    filters: {
      field: count_on_hand
      value: "-NULL, -0"
    }

    filters: {
      field: calendar_date_date
      value: "last week"
    }

    filters: {
      field: calendar_date_day_of_week_index
      value: "6"
    }
  }

  measure: skus_in_stock_week_before {
    label: "Sizes In Stock - 2 Weeks Ago"
    type: count_distinct
    sql: ${sku} ;;
    group_label: "Sizes In Stock Measures"

    filters: {
      field: count_on_hand
      value: "-NULL, -0"
    }

    filters: {
      field: calendar_date_date
      value: "last week"
    }

    filters: {
      field: calendar_date_day_of_week_index
      value: "6"
    }
  }

  measure: skus_in_stock_yesterday {
    label: "Sizes In Stock - Yesterday"
    type: count_distinct
    sql: ${sku} ;;
    group_label: "Sizes In Stock Measures"

    filters: {
      field: count_on_hand
      value: "-NULL, -0"
    }

    filters: {
      field: calendar_date_date
      value: "yesterday"
    }
  }

  measure: skus_in_stock_last_year {
    label: "Sizes In Stock - Last Year"
    type: number
    sql: count (distinct
      case when ${calendar_date_day_of_week_index} = MOD(EXTRACT(DOW FROM current_date - 1)::integer - 1 + 7, 7)
      and ${calendar_date_week_of_year} = EXTRACT(WEEK FROM current_date - 1)
      and ${calendar_date_date} between current_date - 400 and current_date - 300
      then ${sku} else null end
      )
       ;;
    group_label: "Sizes In Stock Measures"
    value_format: "#,##0"
  }

  measure: variants_online {
    type: count_distinct
    sql: ${sku} ;;
    group_label: "Sizes In Stock Measures"


    filters: {
      field: option_info.online_flag
      value: "Yes"
    }
  }

  ####################### Weekly/Monthly Measures

  measure: sum_items_sold_yesterday {
    label: "Units Sold - Yesterday"
    type: sum
    sql: ${TABLE}.items_sold ;;
    group_label: "Units Sold Measures"

    filters: {
      field: calendar_date_date
      value: "1 day ago for 1 day"
    }
  }

  measure: sum_items_sold_same_day_last_week {
    label: "Units Sold - Same Day Last Week"
    type: sum
    sql: ${TABLE}.items_sold ;;
    group_label: "Units Sold Measures"

    filters: {
      field: calendar_date_date
      value: "8 day ago for 1 day"
    }
  }

  measure: sum_items_sold_last_week {
    label: "Units Sold - Last Week"
    type: sum
    sql: ${TABLE}.items_sold ;;
    group_label: "Units Sold Measures"

    filters: {
      field: calendar_date_date
      value: "last week"
    }
  }

  measure: sum_items_sold_week_before {
    label: "Units Sold - Week Before Last"
    type: sum
    sql: ${TABLE}.items_sold ;;
    group_label: "Units Sold Measures"

    filters: {
      field: calendar_date_date
      value: "2 weeks ago for 1 week"
    }
  }

  measure: sum_items_sold_last_7_days {
    label: "Units Sold - Last 7 Days"
    type: sum
    sql: ${TABLE}.items_sold ;;
    group_label: "Units Sold Measures"

    filters: {
      field: calendar_date_date
      value: "7 days ago for 7 days"
    }
  }

  measure: sum_items_sold_week_to_date {
    label: "Units Sold - Week to Date"
    type: sum
    sql: ${TABLE}.items_sold ;;
    group_label: "Units Sold Measures"

    filters: {
      field: calendar_date_date
      value: "this week"
    }
  }

  measure: units_sold_wow {
    label: "Units Sold - Last Week - WoW"
    type: number
    value_format_name: percent_2
    group_label: "Units Sold Measures"
    sql: (${sum_items_sold_last_week} - ${sum_items_sold_week_before})/NULLIF(${sum_items_sold_week_before},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: units_sold_yest_vs_lw {
    label: "Units Sold - Yesterday vs Last Week"
    type: number
    value_format_name: percent_2
    group_label: "Units Sold Measures"
    sql: (${sum_items_sold_yesterday} - ${sum_items_sold_same_day_last_week})/NULLIF(${sum_items_sold_same_day_last_week},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: units_sold_yoy {
    label: "Units Sold - YoY"
    type: number
    value_format_name: percent_2
    group_label: "Units Sold Measures"
    sql: (${sum_items_sold_last_week} - ${sum_items_sold_last_week_last_year})/NULLIF(${sum_items_sold_last_week_last_year},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: sum_items_sold_last_week_last_year {
    label: "Units Sold - Last Week LY"
    type: number
    sql: sum (
      case when ${calendar_date_week_of_year} = EXTRACT(WEEK FROM current_date - 7)
      and ${calendar_date_date} between current_date - 400 and current_date - 300
      then ${TABLE}.items_sold else null end
      )
       ;;
    group_label: "Units Sold Measures"
    value_format: "#,##0"
  }

  measure: gross_item_revenue_gbp_ex_vat_ex_discount_yesterday {
    label: "Gross Revenue ex. VAT & Discount - Yesterday"
    type: sum
    value_format_name: decimal_2
    sql: ${TABLE}.gross_revenue_gbp_ex_vat_ex_discount ;;
    group_label: "Gross Revenue ex. VAT & Discount Measures"

    filters: {
      field: calendar_date_date
      value: "1 day ago for 1 day"
    }
  }

  measure: gross_item_revenue_gbp_ex_vat_ex_discount_last_week {
    label: "Gross Revenue ex. VAT & Discount - Last Week"
    type: sum
    value_format_name: decimal_2
    sql: ${TABLE}.gross_revenue_gbp_ex_vat_ex_discount ;;
    group_label: "Gross Revenue ex. VAT & Discount Measures"

    filters: {
      field: calendar_date_date
      value: "last week"
    }
  }

  measure: gross_item_revenue_gbp_ex_vat_ex_discount_wow {
    label: "Gross Revenue ex. VAT & Discount - Last Week - WoW"
    type: number
    value_format_name: percent_2
    group_label: "Gross Revenue ex. VAT & Discount Measures"
    sql: (${gross_item_revenue_gbp_ex_vat_ex_discount_last_week} - ${gross_item_revenue_gbp_ex_vat_ex_discount_week_before})/NULLIF(${gross_item_revenue_gbp_ex_vat_ex_discount_week_before},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: gross_item_revenue_gbp_ex_vat_ex_discount_week_before {
    label: "Gross Revenue ex. VAT & Discount - Week Before Last"
    type: sum
    value_format_name: decimal_2
    sql: ${TABLE}.gross_revenue_gbp_ex_vat_ex_discount ;;
    group_label: "Gross Revenue ex. VAT & Discount Measures"

    filters: {
      field: calendar_date_date
      value: "2 weeks ago for 1 week"
    }
  }

  measure: gross_item_revenue_gbp_ex_vat_ex_discount_last_7_days {
    label: "Gross Revenue ex. VAT & Discount - Last 7 Days"
    type: sum
    value_format_name: decimal_2
    sql: ${TABLE}.gross_revenue_gbp_ex_vat_ex_discount ;;
    group_label: "Gross Revenue ex. VAT & Discount Measures"

    filters: {
      field: calendar_date_date
      value: "7 days ago for 7 days"
    }
  }

  measure: gross_item_revenue_gbp_ex_vat_ex_discount_week_to_date {
    label: "Gross Revenue ex. VAT & Discount - Week to Date"
    type: sum
    value_format_name: decimal_2
    sql: ${TABLE}.gross_revenue_gbp_ex_vat_ex_discount ;;
    group_label: "Gross Revenue ex. VAT & Discount Measures"

    filters: {
      field: calendar_date_date
      value: "this week"
    }
  }

  measure: gross_item_revenue_gbp_ex_vat_ex_discount_last_week_last_year {
    label: "Gross Revenue ex. VAT & Discount - Last Week LY"
    type: number
    value_format_name: decimal_2
    sql: sum (
      case when ${calendar_date_week_of_year} = EXTRACT(WEEK FROM current_date - 7)
      and ${calendar_date_date} between current_date - 400 and current_date - 300
      then ${TABLE}.gross_revenue_gbp_ex_vat_ex_discount else null end
      )
       ;;
    group_label: "Gross Revenue ex. VAT & Discount Measures"
  }

  measure: gross_revenue_yoy {
    label: "Gross Revenue ex. VAT & Discount - Last Week - YoY"
    type: number
    value_format_name: percent_2
    group_label: "Gross Revenue ex. VAT & Discount Measures"
    sql: (${gross_item_revenue_gbp_ex_vat_ex_discount_last_week} - ${gross_item_revenue_gbp_ex_vat_ex_discount_last_week_last_year})/NULLIF(${gross_item_revenue_gbp_ex_vat_ex_discount_last_week_last_year},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: gross_item_revenue_gbp_ex_discount_yesterday {
    label: "Gross Revenue ex. Discount - Yesterday"
    type: sum
    value_format_name: decimal_2
    sql: ${TABLE}.gross_revenue_gbp_ex_discount ;;
    group_label: "Gross Revenue ex. Discount Measures"

    filters: {
      field: calendar_date_date
      value: "1 day ago for 1 day"
    }
  }

  measure: gross_item_revenue_gbp_ex_discount_last_week {
    label: "Gross Revenue ex. Discount - Last Week"
    type: sum
    value_format_name: decimal_2
    sql: ${TABLE}.gross_revenue_gbp_ex_discount ;;
    group_label: "Gross Revenue ex. Discount Measures"

    filters: {
      field: calendar_date_date
      value: "last week"
    }
  }

  measure: gross_item_revenue_gbp_ex_discount_week_before {
    label: "Gross Revenue ex. Discount - Week Before Last"
    type: sum
    value_format_name: decimal_2
    sql: ${TABLE}.gross_revenue_gbp_ex_discount ;;
    group_label: "Gross Revenue ex. Discount Measures"

    filters: {
      field: calendar_date_date
      value: "2 weeks ago for 1 week"
    }
  }

  measure: gross_item_revenue_gbp_ex_discount_last_7_days {
    label: "Gross Revenue ex. Discount - Last 7 Days"
    type: sum
    value_format_name: decimal_2
    sql: ${TABLE}.gross_revenue_gbp_ex_discount ;;
    group_label: "Gross Revenue ex. Discount Measures"

    filters: {
      field: calendar_date_date
      value: "7 days ago for 7 days"
    }
  }

  measure: gross_item_revenue_gbp_ex_discount_week_to_date {
    label: "Gross Revenue ex. Discount - Week to Date"
    type: sum
    value_format_name: decimal_2
    sql: ${TABLE}.gross_revenue_gbp_ex_discount ;;
    group_label: "Gross Revenue ex. Discount Measures"

    filters: {
      field: calendar_date_date
      value: "this week"
    }
  }

  measure: gross_item_revenue_gbp_ex_discount_last_week_last_year {
    label: "Gross Revenue ex. Discount - Last Week LY"
    type: number
    value_format_name: decimal_2
    sql: sum (
      case when ${calendar_date_week_of_year} = EXTRACT(WEEK FROM current_date - 7)
      and ${calendar_date_date} between current_date - 400 and current_date - 300
      then ${TABLE}.gross_revenue_gbp_ex_discount else null end
      )
       ;;
    group_label: "Gross Revenue ex. Discount Measures"
  }

  measure: sales_mix_last_7_days {
    label: "Sales Mix - Last 7 Days"
    type: percent_of_total
    sql: ${gross_item_revenue_gbp_ex_vat_ex_discount_last_7_days} ;;
    group_label: "Gross Revenue ex. VAT & Discount Measures"
  }

  measure: weeks_cover_yesterday {
    label: "Weeks Cover - Yesterday"
    type: number
    value_format_name: decimal_2
    sql: ${closing_stock_yesterday}/NULLIF(${sum_items_sold_last_7_days},0)::REAL ;;
    group_label: "Weeks Cover Measures"
  }

  measure: weeks_cover_last_week {
    label: "Weeks Cover - Last Week"
    type: number
    value_format_name: decimal_2
    sql: ${closing_stock_last_week}/NULLIF(${sum_items_sold_last_week},0)::REAL ;;
    group_label: "Weeks Cover Measures"
  }

  measure: weeks_cover_week_before_last {
    label: "Weeks Cover - Week Before Last"
    type: number
    value_format_name: decimal_2
    sql: ${closing_stock_week_before_last}/NULLIF(${sum_items_sold_week_before},0)::REAL ;;
    group_label: "Weeks Cover Measures"
  }

  ########################################################################################################################
  ########################################## REPORTING MEASURES ##########################################################
  ########################################################################################################################


  measure: units_sold_l4w {
    type: sum
    sql: ${TABLE}.items_sold ;;


    filters: {
      field: calendar_date_date
      value: "5 weeks ago for 4 weeks"
    }

    hidden: yes
  }

  measure: units_sold_mtd {
    type: sum
    sql: ${TABLE}.items_sold ;;

    filters: {
      field: calendar_date_date
      value: "this month"
    }

    hidden: yes
  }

  measure: units_sold_std {
    type: sum
    sql: ${TABLE}.items_sold ;;

    filters: {
      field: calendar_date_date
      value: "after 2015/02/01"
    }

    hidden: yes
  }

  measure: gross_rev_l4w {
    type: sum
    value_format_name: decimal_2
    sql: ${TABLE}.gross_revenue_gbp_ex_vat_ex_discount ;;

    filters: {
      field: calendar_date_date
      value: "5 weeks ago for 4 weeks"
    }

    hidden: yes
  }

  measure: gross_rev_mtd {
    type: sum
    value_format_name: decimal_2
    sql: ${TABLE}.gross_revenue_gbp_ex_vat_ex_discount ;;

    filters: {
      field: calendar_date_date
      value: "this month"
    }

    hidden: yes
  }

  measure: gross_rev_std {
    type: sum
    value_format_name: decimal_2
    sql: ${TABLE}.gross_revenue_gbp_ex_vat_ex_discount ;;

    filters: {
      field: calendar_date_date
      value: "after 2015/02/01"
    }

    hidden: yes
  }

  measure: cost_tw {
    type: sum
    value_format_name: decimal_2
    sql: coalesce(${product_info_variants.total_landed_cost_gbp}, 0) * ${TABLE}.items_sold ;;

    filters: {
      field: calendar_date_date
      value: "last week"
    }

    #hidden: yes
  }


  measure: cost_tw_ly {
    type: number
    value_format_name: decimal_2
    sql: sum (
      case when ${calendar_date_week_of_year} = EXTRACT(WEEK FROM current_date - 7)
      and ${calendar_date_date} between current_date - 400 and current_date - 300
      then (coalesce(${product_info_variants.total_landed_cost_gbp}, 0) * ${TABLE}.items_sold) else null end
      )
      ;;

  }


  measure: cost_lw {
    type: sum
    value_format_name: decimal_2
    sql: coalesce(${product_info_variants.total_landed_cost_gbp}, 0) * ${TABLE}.items_sold ;;

    filters: {
      field: calendar_date_date
      value: "2 weeks ago for 1 week"
    }

    hidden: yes
  }

  measure: cost_l4w {
    type: sum
    value_format_name: decimal_2
    sql: coalesce(${product_info_variants.total_landed_cost_gbp}, 0) * ${TABLE}.items_sold ;;

    filters: {
      field: calendar_date_date
      value: "5 weeks ago for 4 weeks"
    }

    hidden: yes
  }

  measure: cost_mtd {
    type: sum
    value_format_name: decimal_2
    sql: coalesce(${product_info_variants.total_landed_cost_gbp}, 0) * ${TABLE}.items_sold ;;

    filters: {
      field: calendar_date_date
      value: "this month"
    }

    hidden: yes
  }

  measure: cost_std {
    type: sum
    value_format_name: decimal_2
    sql: coalesce(${product_info_variants.total_landed_cost_gbp}, 0) * ${TABLE}.items_sold ;;

    filters: {
      field: calendar_date_date
      value: "after 2015/02/01"
    }

    hidden: yes
  }

  measure: pc1_tw {
    type: number
    value_format_name: decimal_2
    sql: ${gross_item_revenue_gbp_ex_vat_ex_discount_last_week} - ${cost_tw} ;;
    hidden: yes
  }

  measure: pc1_lw {
    type: number
    value_format_name: decimal_2
    sql: ${gross_item_revenue_gbp_ex_vat_ex_discount_week_before} - ${cost_lw} ;;
    hidden: yes
  }

  measure: pc1_l4w {
    type: number
    value_format_name: decimal_2
    sql: ${gross_rev_l4w} - ${cost_l4w} ;;
    hidden: yes
  }

  measure: pc1_mtd {
    type: number
    value_format_name: decimal_2
    sql: ${gross_rev_mtd} - ${cost_mtd} ;;
    hidden: yes
  }

  measure: pc1_std {
    type: number
    value_format_name: decimal_2
    sql: ${gross_rev_std} - ${cost_std} ;;
    hidden: yes
  }

  measure: units_sold_for_returns {
    type: sum
    sql: ${TABLE}.items_sold ;;

    filters: {
      field: calendar_date_date
      value: "before 2 weeks ago"
    }

    hidden: yes
  }

  measure: units_returned_for_returns {
    type: sum
    sql: ${TABLE}.items_returned ;;

    filters: {
      field: calendar_date_date
      value: "before 2 weeks ago"
    }

    hidden: yes
  }


}
