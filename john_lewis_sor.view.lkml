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

# Measures

  measure: sum_sales_units {
    type: sum
    sql: ${sales_units} ;;
  }

  measure: sum_returns_units{
    type: sum
    sql: ${returns_units} ;;
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
  }

  measure: derived_stock_units_closing_yesterday {
    type: sum
    sql: ${TABLE}.derived_closing_stock;;

    filters: {
      field: calendar_date
      value: "yesterday"
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

}
