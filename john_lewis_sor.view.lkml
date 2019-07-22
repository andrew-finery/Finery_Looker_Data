view: john_lewis_sor {
sql_table_name: john_lewis.sor_data ;;

# Dimensions

dimension: ean {
  type: string
  sql: ${TABLE}.ean ;;
}

  dimension_group: calendar {
    type: time
    timeframes: [
      date,
      day_of_week_index,
      week,
      week_of_year,
      day_of_month,
      month,
      month_num,
      year,
    ]
    sql: ${TABLE}.calendar_date ;;
  }

  dimension: jl_store_name {
    type: string
    sql: ${TABLE}.loc_name ;;
  }

  dimension: sales_units {
    type: number
    value_format_name: decimal_0
    sql: ${TABLE}.sales_units ;;
    hidden: yes
  }

  dimension: returns_units {
    type: number
    value_format_name: decimal_0
    sql: ${TABLE}.returns_units ;;
    hidden: yes
  }

  dimension: gross_revenue {
    type: number
    value_format_name: decimal_2
    sql: ${TABLE}.gross_revenue  ;;
    hidden: yes
  }

  dimension: refunds {
    type: number
    value_format_name: decimal_2
    sql: ${TABLE}.refunds ;;
    hidden: yes
  }

  dimension: units_delivered {
    type: number
    value_format_name: decimal_2
    sql: ${TABLE}.units_delivered ;;
    hidden: yes
  }

  dimension: price {
    type: number
    value_format_name: decimal_2
    sql: coalesce(${option_info_daily.price}, ${option_info.current_price_gbp}) ;;
    hidden:  yes
  }


# Measures

  measure: sum_sales_units {
    type: sum
    sql: ${sales_units} ;;
  }

  measure: sum_sales_units_yesterday {
    type: sum
    sql: case when ${calendar_date} = current_date - 1 then  ${sales_units} else 0 end ;;
    label: "Items Sold Yesterday"
  }

  measure: sum_sales_units_wtd {
    type: sum
    sql: case when ${calendar_date} between date_trunc('week', current_date - 1) and current_date - 1 then  ${sales_units} else 0 end ;;
    label: "Items Sold WTD"
  }

  measure: sum_sales_units_wtd_lw {
    type: sum
    sql: case when ${calendar_date} between date_trunc('week', current_date - 8) and current_date - 8 then  ${sales_units} else 0 end ;;
    label: "Items Sold WTD LW"
  }

  measure: sum_sales_units_wtd_wow {
    type: number
    value_format_name: percent_0
    label: "Items Sold WTD WoW"
    sql: (${sum_sales_units_wtd} - ${sum_sales_units_wtd_lw})/NULLIF(${sum_sales_units_wtd_lw},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: sum_returns_units{
    type: sum
    sql: ${returns_units} ;;
  }

  measure: gross_cogs{
    type: sum
    sql: coalesce(${variant_info.total_landed_cost_gbp}, 0)*${sales_units} ;;
  }

  measure: gross_cogs_yesterday{
    type: sum
    sql: case when ${calendar_date} = current_date - 1 then (coalesce(${variant_info.total_landed_cost_gbp}, 0)*${sales_units}) else 0 end ;;
    label: "Gross Cogs Yesterday"
  }

  measure: net_cogs{
    type: sum
    sql: coalesce(${variant_info.total_landed_cost_gbp}, 0)*(${sales_units} - ${returns_units}) ;;
  }

  measure: return_cogs{
    type: sum
    sql: coalesce(${variant_info.total_landed_cost_gbp}, 0)*(${returns_units}) ;;
  }

  measure: sum_gross_revenue {
    type: sum
    sql: ${gross_revenue} ;;
  }

  measure: sum_refunds {
    type: sum
    sql: ${refunds} ;;
  }

  measure: sum_units_delivered {
    type: sum
    sql: ${units_delivered} ;;
  }

  measure: intake_units{
    type: sum
    sql: ${units_delivered} ;;
  }

  measure: intake_cost {
    type: sum
    value_format_name: pounds
    sql: coalesce(${variant_info.total_landed_cost_gbp}, 0)*${units_delivered} ;;
  }

  measure: intake_retail {
    type: sum
    value_format_name: pounds
    sql: ${price}*${units_delivered} ;;
  }

  measure: sum_net_sales_units {
    type: number
    sql: ${sum_sales_units} - ${sum_returns_units} ;;
  }

  measure: sum_net_revenue {
    type: number
    sql: ${sum_gross_revenue} - ${sum_refunds} ;;
  }

  measure: derived_stock_units {
    type: sum
    sql: ${TABLE}.derived_closing_stock;;
    hidden: yes
  }

  measure: derived_stock_units_closing_yesterday {
    type: sum
    sql: ${TABLE}.derived_closing_stock;;
    hidden: no
    filters: {
      field: calendar_date
      value: "yesterday"
    }
  }

  measure: stock_units {
      type: sum
      sql: ${TABLE}.derived_closing_stock;;
    }

  measure: stock_cost {
      type: sum
      value_format_name: pounds
      sql: coalesce(${variant_info.total_landed_cost_gbp}, 0)*${TABLE}.derived_closing_stock;;
    }

  measure: stock_retail {
      type: sum
      value_format_name: pounds
      sql: ${price}*${TABLE}.derived_closing_stock;;
    }

  measure: stock_units_yesterday {
      type: sum
      sql: ${TABLE}.derived_closing_stock;;
      filters: {
        field: calendar_date
        value: "yesterday"
      }
    }

    measure: stock_cost_yesterday {
      type: sum
      value_format_name: pounds
      sql: coalesce(${variant_info.total_landed_cost_gbp}, 0)*${TABLE}.derived_closing_stock;;
      filters: {
        field: calendar_date
        value: "yesterday"
      }
    }

    measure: stock_retail_yesterday {
      type: sum
      value_format_name: pounds
      sql: ${price}*${TABLE}.derived_closing_stock;;
      filters: {
        field: calendar_date
        value: "yesterday"
      }
    }

  measure: stock_cost_eow {
    type: sum
    value_format_name: pounds
    sql: coalesce(${variant_info.total_landed_cost_gbp}, 0)*${TABLE}.derived_closing_stock;;
    filters: {
      field: calendar_day_of_week_index
      value: "6"
    }
  }

  measure: stock_retail_eow {
    type: sum
    value_format_name: pounds
    sql: ${price}*${TABLE}.derived_closing_stock;;
    filters: {
      field: calendar_day_of_week_index
      value: "6"
    }
  }

  measure: stock_units_eow {
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.derived_closing_stock;;
    filters: {
      field: calendar_day_of_week_index
      value: "6"
    }
  }


  measure: net_revenue_yesterday {
    label: "Actual"
    type: sum
    sql: ${gross_revenue} - ${refunds} ;;
    value_format_name: pounds
    group_label: "Net Revenue Reporting Measures"

    filters: {
      field: calendar_date
      value: "yesterday"
    }
  }

  measure: net_revenue_yesterday_last_week {
    label: "LW"
    type: sum
    sql: ${gross_revenue} - ${refunds} ;;
    value_format_name: pounds

    group_label: "Net Revenue Reporting Measures"

    filters: {
      field: calendar_date
      value: "8 days ago for 1 day"
    }
  }

  measure: net_revenue_yesterday_week_on_week {
    label: "%"
    type: number
    value_format_name: percent_0
    group_label: "Net Revenue Reporting Measures"
    sql: (${net_revenue_yesterday} - ${net_revenue_yesterday_last_week})/NULLIF(${net_revenue_yesterday_last_week},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: net_revenue_yesterday_last_year {
    label: "LY"
    type: number
    value_format_name: pounds
    sql: sum(case when (${calendar_date} = (select calendar_date from finery.calendar where week_number = (select week_number from finery.calendar where calendar_date = current_date - 1) and dow = (select dow from finery.calendar where calendar_date = current_date - 1) and year = (select year - 1 from finery.calendar where calendar_date = current_date - 1))) then (${gross_revenue} - ${refunds}) else 0 end) ;;
    group_label: "Net Revenue Reporting Measures"
  }

  measure: net_revenue_yesterday_year_on_year {
    label: "YoY"
    type: number
    value_format_name: percent_0
    group_label: "Net Revenue Reporting Measures"
    sql: (${net_revenue_yesterday} - ${net_revenue_yesterday_last_year})/NULLIF(${net_revenue_yesterday_last_year},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: net_revenue_week_to_date {
    label: "WTD"
    type: number
    value_format_name: pounds
    sql: sum(case when ${calendar_date} between date_trunc('week', current_date - 1) and current_date - 1 then (${gross_revenue} - ${refunds}) else 0 end) ;;

    group_label: "Net Revenue Reporting Measures"
  }

  measure: net_revenue_week_to_date_lw {
    label: "WTD LW"
    type: number
    value_format_name: pounds
    sql: sum(case when ${calendar_date} between date_trunc('week', current_date - 8) and current_date - 8 then (${gross_revenue} - ${refunds}) else 0 end) ;;

    group_label: "Net Revenue Reporting Measures"
  }

  measure: net_revenue_week_to_date_week_on_week {
    label: "WTD WoW"
    type: number
    value_format_name: percent_0
    group_label: "Net Revenue Reporting Measures"
    sql: (${net_revenue_week_to_date} - ${net_revenue_week_to_date_lw})/NULLIF(${net_revenue_week_to_date_lw},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: net_revenue_week_to_date_ly {
    label: "WTD LY"
    type: number
    value_format_name: pounds
    sql: sum(case when ${calendar_date} between date_trunc('week', (select calendar_date from finery.calendar where week_number = (select week_number from finery.calendar where calendar_date = current_date - 1) and dow = (select dow from finery.calendar where calendar_date = current_date - 1) and year = (select year - 1 from finery.calendar where calendar_date = current_date - 1))) and (select calendar_date from finery.calendar where week_number = (select week_number from finery.calendar where calendar_date = current_date - 1) and dow = (select dow from finery.calendar where calendar_date = current_date - 1) and year = (select year - 1 from finery.calendar where calendar_date = current_date - 1)) then (${gross_revenue} - ${refunds}) else 0 end) ;;

    group_label: "Net Revenue Reporting Measures"
  }

  measure: net_revenue_week_to_date_year_on_year {
    label: "WTD YoY"
    type: number
    value_format_name: percent_0
    group_label: "Reporting Measures"
    sql: (${net_revenue_week_to_date} - ${net_revenue_week_to_date_ly})/NULLIF(${net_revenue_week_to_date_ly},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: net_revenue_month_to_date {
    label: "MTD"
    type: number
    value_format_name: pounds
    sql: sum(case when ${calendar_date} between date_trunc('month', current_date - 1) and current_date - 1 then (${gross_revenue} - ${refunds}) else 0 end) ;;

    group_label: "Net Revenue Reporting Measures"
  }

  measure: net_revenue_month_to_date_last_month {
    label: "MTD LM"
    type: number
    value_format_name: pounds
    sql: sum(case when ${calendar_date} between date_trunc('month', add_months(current_date - 1, -1)) and add_months(current_date - 1, -1) then (${gross_revenue} - ${refunds}) else 0 end) ;;

    group_label: "Net Revenue Reporting Measures"
  }

  measure: net_revenue_month_to_date_month_on_month {
    label: "MTD MoM"
    type: number
    value_format_name: percent_0
    group_label: "Net Revenue Reporting Measures"
    sql: (${net_revenue_month_to_date} - ${net_revenue_month_to_date_last_month})/NULLIF(${net_revenue_month_to_date_last_month},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: net_revenue_month_to_date_last_year {
    label: "MTD LY"
    type: number
    value_format_name: pounds
    sql: sum(case when ${calendar_date} between date_trunc('month', add_months(current_date - 1, -12)) and add_months(current_date - 1, -12) then (${gross_revenue} - ${refunds}) else 0 end) ;;

    group_label: "Net Revenue Reporting Measures"
  }

  measure: net_revenue_month_to_date_year_on_year {
    label: "MTD YoY"
    type: number
    value_format_name: percent_0
    group_label: "Net Revenue Reporting Measures"
    sql: (${net_revenue_month_to_date} - ${net_revenue_month_to_date_last_year})/NULLIF(${net_revenue_month_to_date_last_year},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: net_revenue_year_to_date {
    label: "YTD"
    type: number
    value_format_name: pounds
    sql: sum(case when ${calendar_date} between date_trunc('year', current_date - 1) and current_date - 1 then (${gross_revenue} - ${refunds}) else 0 end) ;;

    group_label: "Net Revenue Reporting Measures"
  }

  measure: net_revenue_year_to_date_last_year {
    label: "YTD LY"
    type: number
    value_format_name: pounds
    sql: sum(case when ${calendar_date} between date_trunc('year', add_months(current_date - 1, -12)) and add_months(current_date - 1, -12) then (${gross_revenue} - ${refunds}) else 0 end) ;;

    group_label: "Net Revenue Reporting Measures"
  }

  measure: net_revenue_year_to_date_year_on_year {
    label: "YTD YoY"
    type: number
    value_format_name: percent_0
    group_label: "Net Revenue Reporting Measures"
    sql: (${net_revenue_year_to_date} - ${net_revenue_year_to_date_last_year})/NULLIF(${net_revenue_year_to_date_last_year},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }


### Buying Report Measures

  measure: gross_revenue_yesterday {
    type: sum
    sql: case when ${calendar_date} = current_date - 1 then  ${gross_revenue} else 0 end ;;
    value_format_name: pounds
    label: "Gross Revenue Yesterday"
  }

    measure: gross_revenue_wtd {
      type: sum
      sql: case when ${calendar_date} between date_trunc('week', current_date - 1) and current_date - 1 then  ${gross_revenue} else 0 end ;;
      value_format_name: pounds
      label: "Gross Revenue WTD"
  }

  measure: gross_revenue_wtd_lw {
    type: sum
    sql: case when ${calendar_date} between date_trunc('week', current_date - 8) and current_date - 8 then  ${gross_revenue} else 0 end ;;
    value_format_name: pounds
    label: "Gross Revenue WTD LW"
  }

  measure: gross_revenue_wtd_wow {
    type: number
    value_format_name: percent_0
    label: "Gross Revenue WTD WoW"
    sql: (${gross_revenue_wtd} - ${gross_revenue_wtd_lw})/NULLIF(${gross_revenue_wtd_lw},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: gross_revenue_last_week {
    type: sum
    sql: ${gross_revenue} ;;
    value_format_name: pounds
    label: "Gross Revenue LW"
    group_label: "Buying Report Measures"

    filters: {
      field: calendar_date
      value: "1 week ago for 1 week"
    }
  }

  measure: gross_revenue_week_before_last {
    type: sum
    sql: ${gross_revenue} ;;
    value_format_name: pounds
    label: "Gross Revenue PW"
    group_label: "Buying Report Measures"

    filters: {
      field: calendar_date
      value: "2 weeks ago for 1 week"
    }
  }

  measure: gross_revenue_last_week_wow {
    type: number
    value_format_name: percent_0
    label: "Gross Revenue WoW"
    group_label: "Buying Report Measures"
    sql: (${gross_revenue_last_week} - ${gross_revenue_week_before_last})/NULLIF(${gross_revenue_week_before_last},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: net_revenue_last_week {
    type: sum
    label: "Net Revenue LW"
    sql: ${gross_revenue} - ${refunds} ;;
    value_format_name: pounds

    group_label: "Buying Report Measures"

    filters: {
      field: calendar_date
      value: "1 week ago for 1 week"
    }
  }

  measure: net_revenue_week_before_last {
    type: sum
    label: "Net Revenue PW"
    sql: ${gross_revenue} - ${refunds} ;;
    value_format_name: pounds

    group_label: "Buying Report Measures"

    filters: {
      field: calendar_date
      value: "2 weeks ago for 1 week"
    }
  }

  measure: net_revenue_last_week_wow {
    type: number
    label: "Net Revenue WoW"
    value_format_name: percent_0
    group_label: "Buying Report Measures"
    sql: (${net_revenue_last_week} - ${net_revenue_week_before_last})/NULLIF(${net_revenue_week_before_last},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: gross_revenue_yesterday_daily {
    label: "Actual"
    type: sum
    sql: ${gross_revenue} ;;
    value_format_name: pounds
    group_label: "Gross Revenue Reporting Measures"

    filters: {
      field: calendar_date
      value: "yesterday"
    }
  }

  measure: gross_revenue_yesterday_last_week {
    label: "LW"
    type: sum
    sql: ${gross_revenue} ;;
    value_format_name: pounds

    group_label: "Gross Revenue Reporting Measures"

    filters: {
      field: calendar_date
      value: "8 days ago for 1 day"
    }
  }

  measure: gross_revenue_yesterday_week_on_week {
    label: "%"
    type: number
    value_format_name: percent_0
    group_label: "Gross Revenue Reporting Measures"
    sql: (${gross_revenue_yesterday_daily} - ${gross_revenue_yesterday_last_week})/NULLIF(${gross_revenue_yesterday_last_week},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: gross_revenue_yesterday_last_year {
    label: "LY"
    type: number
    value_format_name: pounds
    sql: sum(case when (${calendar_date} = (select calendar_date from finery.calendar where week_number = (select week_number from finery.calendar where calendar_date = current_date - 1) and dow = (select dow from finery.calendar where calendar_date = current_date - 1) and year = (select year - 1 from finery.calendar where calendar_date = current_date - 1))) then (${gross_revenue}) else 0 end) ;;
    group_label: "Gross Revenue Reporting Measures"
  }

  measure: gross_revenue_yesterday_year_on_year {
    label: "YoY"
    type: number
    value_format_name: percent_0
    group_label: "Gross Revenue Reporting Measures"
    sql: (${gross_revenue_yesterday_daily} - ${gross_revenue_yesterday_last_year})/NULLIF(${gross_revenue_yesterday_last_year},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: gross_revenue_week_to_date {
    label: "WTD"
    type: number
    value_format_name: pounds
    sql: sum(case when ${calendar_date} between date_trunc('week', current_date - 1) and current_date - 1 then (${gross_revenue}) else 0 end) ;;

    group_label: "Gross Revenue Reporting Measures"
  }

  measure: gross_revenue_week_to_date_lw {
    label: "WTD LW"
    type: number
    value_format_name: pounds
    sql: sum(case when ${calendar_date} between date_trunc('week', current_date - 8) and current_date - 8 then (${gross_revenue}) else 0 end) ;;

    group_label: "Gross Revenue Reporting Measures"
  }

  measure: gross_revenue_week_to_date_week_on_week {
    label: "WTD WoW"
    type: number
    value_format_name: percent_0
    group_label: "Gross Revenue Reporting Measures"
    sql: (${gross_revenue_week_to_date} - ${gross_revenue_week_to_date_lw})/NULLIF(${gross_revenue_week_to_date_lw},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: gross_revenue_week_to_date_ly {
    label: "WTD LY"
    type: number
    value_format_name: pounds
    sql: sum(case when ${calendar_date} between date_trunc('week', (select calendar_date from finery.calendar where week_number = (select week_number from finery.calendar where calendar_date = current_date - 1) and dow = (select dow from finery.calendar where calendar_date = current_date - 1) and year = (select year - 1 from finery.calendar where calendar_date = current_date - 1))) and (select calendar_date from finery.calendar where week_number = (select week_number from finery.calendar where calendar_date = current_date - 1) and dow = (select dow from finery.calendar where calendar_date = current_date - 1) and year = (select year - 1 from finery.calendar where calendar_date = current_date - 1)) then (${gross_revenue}) else 0 end) ;;

    group_label: "Gross Revenue Reporting Measures"
  }

  measure: gross_revenue_week_to_date_year_on_year {
    label: "WTD YoY"
    type: number
    value_format_name: percent_0
    group_label: "Reporting Measures"
    sql: (${gross_revenue_week_to_date} - ${gross_revenue_week_to_date_ly})/NULLIF(${gross_revenue_week_to_date_ly},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: gross_revenue_month_to_date {
    label: "MTD"
    type: number
    value_format_name: pounds
    sql: sum(case when ${calendar_date} between date_trunc('month', current_date - 1) and current_date - 1 then (${gross_revenue}) else 0 end) ;;

    group_label: "Gross Revenue Reporting Measures"
  }

  measure: gross_revenue_month_to_date_last_month {
    label: "MTD LM"
    type: number
    value_format_name: pounds
    sql: sum(case when ${calendar_date} between date_trunc('month', add_months(current_date - 1, -1)) and add_months(current_date - 1, -1) then (${gross_revenue}) else 0 end) ;;

    group_label: "Gross Revenue Reporting Measures"
  }

  measure: gross_revenue_month_to_date_month_on_month {
    label: "MTD MoM"
    type: number
    value_format_name: percent_0
    group_label: "Gross Revenue Reporting Measures"
    sql: (${gross_revenue_month_to_date} - ${gross_revenue_month_to_date_last_month})/NULLIF(${gross_revenue_month_to_date_last_month},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: gross_revenue_month_to_date_last_year {
    label: "MTD LY"
    type: number
    value_format_name: pounds
    sql: sum(case when ${calendar_date} between date_trunc('month', add_months(current_date - 1, -12)) and add_months(current_date - 1, -12) then (${gross_revenue}) else 0 end) ;;

    group_label: "Gross Revenue Reporting Measures"
  }

  measure: gross_revenue_month_to_date_year_on_year {
    label: "MTD YoY"
    type: number
    value_format_name: percent_0
    group_label: "Gross Revenue Reporting Measures"
    sql: (${gross_revenue_month_to_date} - ${gross_revenue_month_to_date_last_year})/NULLIF(${gross_revenue_month_to_date_last_year},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: gross_revenue_year_to_date {
    label: "YTD"
    type: number
    value_format_name: pounds
    sql: sum(case when ${calendar_date} between date_trunc('year', current_date - 1) and current_date - 1 then (${gross_revenue}) else 0 end) ;;

    group_label: "Gross Revenue Reporting Measures"
  }

  measure: gross_revenue_year_to_date_last_year {
    label: "YTD LY"
    type: number
    value_format_name: pounds
    sql: sum(case when ${calendar_date} between date_trunc('year', add_months(current_date - 1, -12)) and add_months(current_date - 1, -12) then (${gross_revenue}) else 0 end) ;;

    group_label: "Gross Revenue Reporting Measures"
  }

  measure: gross_revenue_year_to_date_year_on_year {
    label: "YTD YoY"
    type: number
    value_format_name: percent_0
    group_label: "Gross Revenue Reporting Measures"
    sql: (${gross_revenue_year_to_date} - ${gross_revenue_year_to_date_last_year})/NULLIF(${gross_revenue_year_to_date_last_year},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: units_gross_last_week {
    type: sum
    sql: ${sales_units} ;;
    value_format_name: decimal_0
    label: "Gross Units LW"
    group_label: "Buying Report Measures"

    filters: {
      field: calendar_date
      value: "1 week ago for 1 week"
    }
  }

  measure: units_gross_week_before_last {
    type: sum
    sql: ${sales_units} ;;
    value_format_name: decimal_0
    label: "Gross Units PW"
    group_label: "Buying Report Measures"

    filters: {
      field: calendar_date
      value: "2 weeks ago for 1 week"
    }
  }

  measure: units_gross_revenue_last_week_wow {
    type: number
    value_format_name: percent_0
    group_label: "Buying Report Measures"
    label: "Gross Units WoW"
    sql: (${units_gross_last_week} - ${units_gross_week_before_last})/NULLIF(${units_gross_week_before_last},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: units_net_last_week {
    type: sum
    sql: ${sales_units} - ${returns_units} ;;
    value_format_name: decimal_0
    label: "Net Units LW"
    group_label: "Buying Report Measures"

    filters: {
      field: calendar_date
      value: "1 week ago for 1 week"
    }
  }

  measure: units_net_week_before_last {
    type: sum
    sql: ${sales_units} - ${returns_units} ;;
    value_format_name: decimal_0
    label: "Net Units PW"
    group_label: "Buying Report Measures"

    filters: {
      field: calendar_date
      value: "2 weeks ago for 1 week"
    }
  }

  measure: units_net_last_week_wow {
    type: number
    label: "Net Units WoW"
    value_format_name: percent_0
    group_label: "Buying Report Measures"
    sql: (${units_net_last_week} - ${units_net_week_before_last})/NULLIF(${units_net_week_before_last},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: intake_units_last_week{
    type: sum
    label: "Intake Units LW"
    group_label: "Buying Report Measures"
    sql: ${units_delivered} ;;
    filters: {
      field: calendar_date
      value: "1 week ago for 1 week"
    }
  }

  measure: intake_cost_last_week {
    type: sum
    value_format_name: pounds
    group_label: "Buying Report Measures"
    sql: coalesce(${variant_info.total_landed_cost_gbp}, 0)*${units_delivered} ;;
    filters: {
      field: calendar_date
      value: "1 week ago for 1 week"
    }
  }

  measure: intake_retail_last_week {
    type: sum
    value_format_name: pounds
    label: "Intake Value LW"
    group_label: "Buying Report Measures"
    sql: ${price}*${units_delivered} ;;
    filters: {
      field: calendar_date
      value: "1 week ago for 1 week"
    }
  }

  measure: stock_units_last_week_end_of_week {
    type: sum
    label: "Stock Units LW"
    group_label: "Buying Report Measures"
    sql: ${TABLE}.derived_closing_stock;;
    filters: {
      field: calendar_date
      value: "1 week ago for 1 week"
    }
    filters: {
      field: calendar_day_of_week_index
      value: "6"
    }
  }

  measure: stock_units_week_before_last_end_of_week {
    type: sum
    label: "Stock Units PW"
    group_label: "Buying Report Measures"
    sql: ${TABLE}.derived_closing_stock;;
    filters: {
      field: calendar_date
      value: "2 weeks ago for 1 week"
    }
    filters: {
      field: calendar_day_of_week_index
      value: "6"
    }
  }

  measure: stock_value_last_week_end_of_week {
    type: sum
    label: "Stock Value LW"
    value_format_name: pounds
    group_label: "Buying Report Measures"
    sql: ${price}*${TABLE}.derived_closing_stock;;
    filters: {
      field: calendar_date
      value: "1 weeks ago for 1 week"
    }
    filters: {
      field: calendar_day_of_week_index
      value: "6"
    }
  }

  measure: net_cover_lw {
    type: number
    value_format_name: decimal_0
    label: "Net Cover LW"
    group_label: "Buying Report Measures"
    sql: ${stock_units_last_week_end_of_week}/NULLIF(${units_net_last_week},0)::REAL ;;
  }

  measure: net_cover_pw {
    type: number
    value_format_name: decimal_0
    label: "Net Cover PW"
    group_label: "Buying Report Measures"
    sql: ${stock_units_week_before_last_end_of_week}/NULLIF(${units_net_week_before_last},0)::REAL ;;
  }


}
