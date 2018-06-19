view: website_page_views {
  sql_table_name: web.page_views ;;
  ########### DIMENSIONS

  dimension: domain_userid {
    sql: ${TABLE}.domain_userid ;;
  }

  dimension: domain_sessionidx {
    sql: ${TABLE}.domain_sessionidx ;;
  }

  dimension: page_view_index {
    type: number
    sql: ${TABLE}.page_view_index ;;
  }

  dimension_group: page_entry_tstamp {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.page_entry_tstamp ;;
    hidden: yes
  }

  dimension_group: page_exit_tstamp {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.page_exit_tstamp ;;
    hidden: yes
  }

  dimension: page_url {
    sql: ${TABLE}.page_url ;;
    hidden: yes
  }

  dimension: original_page_urlpath {
    sql: ${TABLE}.original_page_urlpath ;;
    hidden: yes
  }

  dimension: page_urlpath {
    sql: ${TABLE}.page_urlpath ;;
  }

  dimension: previous_page_urlpath {
    sql: ${TABLE}.previous_page_urlpath ;;
  }

  dimension: next_page_urlpath {
    sql: ${TABLE}.next_page_urlpath ;;
  }

  dimension: product_slug {
    sql: ${TABLE}.product_slug ;;
    hidden: yes
  }

  dimension: slug {
    sql: ${TABLE}.slug ;;
    hidden: yes
  }

  dimension: prod_id {
    type: number
    sql: ${TABLE}.prod_id ;;
  }

  dimension: page_type {
    case: {
      when: {
        sql: ${page_urlpath} in ('/', '//') ;;
        label: "Homepage"
      }

      when: {
        sql: ${page_urlpath} like '%/t/%' ;;
        label: "Category Page"
      }

      when: {
        sql: ${page_urlpath} like '%/products/%' ;;
        label: "Product Page"
      }

      when: {
        sql: ${page_urlpath} = '/chapters' ;;
        label: "Chapters Page"
      }

      when: {
        sql: ${page_urlpath} like '%/chapters/%' ;;
        label: "Editorial"
      }

      when: {
        sql: ${page_urlpath} like '/cart%' ;;
        label: "Cart Page"
      }

      when: {
        sql: ${page_urlpath} like '%/checkout/registration%' ;;
        label: "Checkout - Registration Page"
      }

      when: {
        sql: ${page_urlpath} like '%/checkout/address%' ;;
        label: "Checkout - Address"
      }

      when: {
        sql: ${page_urlpath} like '%/checkout/delivery%' ;;
        label: "Checkout - Delivery"
      }

      when: {
        sql: ${page_urlpath} like '%/checkout/payment%' ;;
        label: "Checkout - Payment"
      }

      when: {
        sql: ${page_urlpath} like '%/orders/R%' ;;
        label: "Order Complete"
      }

      else: "Other"
    }
  }

  dimension: previous_page_type {
    case: {
      when: {
        sql: ${previous_page_urlpath} in ('/', '//') ;;
        label: "Homepage"
      }

      when: {
        sql: ${previous_page_urlpath} like '%/t/%' ;;
        label: "Category Page"
      }

      when: {
        sql: ${previous_page_urlpath} like '%/products/%' ;;
        label: "Product Page"
      }

      when: {
        sql: ${previous_page_urlpath} = '/chapters' ;;
        label: "Chapters Page"
      }

      when: {
        sql: ${previous_page_urlpath} like '%/chapters/%' ;;
        label: "Editorial"
      }

      when: {
        sql: ${previous_page_urlpath} = '/cart' ;;
        label: "Cart"
      }

      when: {
        sql: ${previous_page_urlpath} = '/checkout' ;;
        label: "Checkout"
      }

      when: {
        sql: ${previous_page_urlpath} like '/orders/%' ;;
        label: "Order Complete"
      }

      else: "Other"
    }
  }

  dimension: next_page_type {
    case: {
      when: {
        sql: ${next_page_urlpath} in ('/', '//') ;;
        label: "Homepage"
      }

      when: {
        sql: ${next_page_urlpath} like '%/t/%' ;;
        label: "Category Page"
      }

      when: {
        sql: ${next_page_urlpath} like '%/products/%' ;;
        label: "Product Page"
      }

      when: {
        sql: ${next_page_urlpath} = '/chapters' ;;
        label: "Chapters Page"
      }

      when: {
        sql: ${next_page_urlpath} like '%/chapters/%' ;;
        label: "Editorial"
      }

      when: {
        sql: ${next_page_urlpath} = '/cart' ;;
        label: "Cart"
      }

      when: {
        sql: ${next_page_urlpath} = '/checkout' ;;
        label: "Checkout"
      }

      when: {
        sql: ${next_page_urlpath} like '/orders/%' ;;
        label: "Order Complete"
      }

      else: "Other"
    }
  }

  dimension: landing_page_flag {
    type: yesno
    sql: ${previous_page_urlpath} is null ;;
  }

  dimension: exit_page_flag {
    type: yesno
    sql: ${next_page_urlpath} is null ;;
  }

  dimension: bounce_flag {
    type: yesno
    sql: ${previous_page_urlpath} is null and ${next_page_urlpath} is null ;;
  }

  ########### MEASURES

  measure: count_total_page_views {
    type: count
  }

  measure: count_distinct_page_views {
    type: count_distinct
    sql: ${domain_userid} || ${domain_sessionidx} || ${page_view_index} ;;
  }

  measure: count_sessions {
    type: count_distinct
    sql: ${domain_userid} || ${domain_sessionidx} ;;
  }

  measure: count_exits {
    type: count

    filters: {
      field: exit_page_flag
      value: "yes"
    }
  }

  measure: count_bounces {
    type: count

    filters: {
      field: bounce_flag
      value: "yes"
    }
  }

  measure: count_lands {
    type: count

    filters: {
      field: landing_page_flag
      value: "yes"
    }
  }

  measure: count_urls {
    type: count_distinct
    sql: ${page_urlpath} ;;
  }

  measure: exit_rate {
    type: number
    value_format_name: percent_2
    sql: ${count_exits}/NULLIF(${count_total_page_views},0)::REAL ;;
  }

  measure: bounce_rate {
    type: number
    value_format_name: percent_2
    sql: ${count_bounces}/NULLIF(${count_lands},0)::REAL ;;
  }

  measure: click_through_rate_any_page {
    type: number
    value_format_name: percent_2
    sql: 1 - ${exit_rate} ;;
  }

  measure: count_next_page_product_views {
    type: count

    filters: {
      field: next_page_type
      value: "Product Page"
    }

    hidden: yes
  }

  measure: click_through_rate_product_page {
    type: number
    value_format_name: percent_2
    sql: ${count_next_page_product_views}/NULLIF(${count_total_page_views},0)::REAL ;;
  }



###################### Reporting Measures

  measure: landing_page_views_yesterday {
    type: number
    sql: count(distinct case when ${visits.start_date} = current_date - 1 and ${landing_page_flag} then ${domain_userid} || ${domain_sessionidx} || ${page_view_index} else null end)::REAL;;
    label: "Landing Page Views Yesterday"
  }

  measure: count_total_page_views_yesterday {
    type: count_distinct
    sql:  case when ${visits.start_date} = current_date - 1 then ${domain_userid} || ${domain_sessionidx} || ${page_view_index} else null end ;;
    label: "Actual"
    group_label: "Total Page Views Reporting Measures"
  }

  measure: count_total_page_views_lw {
    type: count_distinct
    sql:  case when ${visits.start_date} = current_date - 8 then ${domain_userid} || ${domain_sessionidx} || ${page_view_index} else null end ;;
    label: "LW"
    group_label: "Total Page Views Reporting Measures"
  }

  measure: percentage_total_page_views_lw {
    label: "%"
    type: number
    value_format_name: percent_1
    group_label: "Total Page Views Reporting Measures"
    sql: (${count_total_page_views_yesterday} - ${count_total_page_views_lw})/NULLIF(${count_total_page_views_lw},0)::REAL ;;
    html: {% if value < 0 %}
        <font color="#D77070"> {{ rendered_value }} </font>
        {% elsif value > 0 %}
        <font color="#3CB371"> {{ rendered_value }} </font>
        {% else %}
        <font color="#000000"> {{ rendered_value }} </font>
        {% endif %}
        ;;
  }

  measure: count_total_page_views_l7d {
    type: count_distinct
    sql:  case when (${visits.start_date} between current_date - 7 and current_date - 1) then ${domain_userid} || ${domain_sessionidx} || ${page_view_index} else null end ;;
    label: "L7D"
    group_label: "Total Page Views Reporting Measures"
  }

  measure: count_total_page_views_l7d_average {
    type: number
    sql:  ${count_total_page_views_l7d}/7 ;;
    label: "L7D Average"
    group_label: "Total Page Views Reporting Measures"
  }

  measure: percentage_total_page_views_l7d {
    label: "vs L7D"
    type: number
    value_format_name: percent_1
    group_label: "Total Page Views Reporting Measures"
    sql: (${count_total_page_views_yesterday} - ${count_total_page_views_l7d_average})/NULLIF(${count_total_page_views_l7d_average},0)::REAL ;;
    html: {% if value < 0 %}
        <font color="#D77070"> {{ rendered_value }} </font>
        {% elsif value > 0 %}
        <font color="#3CB371"> {{ rendered_value }} </font>
        {% else %}
        <font color="#000000"> {{ rendered_value }} </font>
        {% endif %}
        ;;
  }

  measure: count_total_page_views_lcw {
    label: "LCW"
    type: number
    sql: count(distinct case when (((${visits.start_date}) >= ((DATEADD(week,-1, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())) ))) AND ( ${visits.start_date} ) < ((DATEADD(week,1, DATEADD(week,-1, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())))))))) then ${domain_userid} || ${domain_sessionidx} || ${page_view_index} else null end) ;;
    group_label: "Total Page Views Reporting Measures"
  }

  measure: count_total_page_views_pcw {
    label: "PCW"
    type: number
    sql: count(distinct case when (((${visits.start_date}) >= ((DATEADD(week,-2, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())) ))) AND ( ${visits.start_date} ) < ((DATEADD(week,1, DATEADD(week,-2, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())))))))) then ${domain_userid} || ${domain_sessionidx} || ${page_view_index} else null end) ;;
    group_label: "Total Page Views Reporting Measures"
  }

  measure: count_total_page_views_lcw_wow {
    label: "LCW %"
    type: number
    value_format_name: percent_0
    group_label: "Total Page Views Reporting Measures"
    sql: (${count_total_page_views_lcw} - ${count_total_page_views_pcw})/NULLIF(${count_total_page_views_pcw},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: count_total_page_views_lcw_ly {
    label: "LCW - LY"
    type: number
    sql: count(distinct case when ${visits.start_week_of_year} = EXTRACT(WEEK FROM current_date - 7) and ${visits.start_date} between current_date - 400 and current_date - 30 then ${domain_userid} || ${domain_sessionidx} || ${page_view_index} else null end);;
    group_label: "Total Page Views Reporting Measures"
  }

  measure: count_total_page_views_lcw_ly_yoy {
    label: "LCW - LY%"
    type: number
    group_label: "Total Page Views Reporting Measures"
    sql: (${count_total_page_views_lcw} - ${count_total_page_views_lcw_ly})/NULLIF(${count_total_page_views_lcw_ly},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: count_total_page_views_mtd {
    label: "MTD"
    type: number
    sql: count(distinct case when ${visits.start_date} between date_trunc('month', current_date - 1) and current_date - 1 then ${domain_userid} || ${domain_sessionidx} || ${page_view_index} else null end);;
    group_label: "Total Page Views Reporting Measures"
  }

  measure: count_total_page_views_mtd_lm {
    label: "MTD LM"
    type: number
    sql: count(distinct case when ${visits.start_date} between date_trunc('month', add_months(current_date - 1, -1)) and add_months(current_date - 1, -1) then ${domain_userid} || ${domain_sessionidx} || ${page_view_index} else null end) ;;
    group_label: "Total Page Views Reporting Measures"
  }

  measure: count_total_page_views_mtd_mom {
    label: "MTD MoM"
    type: number
    value_format_name: percent_0
    group_label: "Total Page Views Reporting Measures"
    sql: (${count_total_page_views_mtd} - ${count_total_page_views_mtd_lm})/NULLIF(${count_total_page_views_mtd_lm},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: count_total_page_views_ytd {
    label: "YTD"
    type: number
    sql: count(distinct case when ${visits.start_date} between date_trunc('year',current_date) and current_date-1 then ${domain_userid} || ${domain_sessionidx} || ${page_view_index} else null end) ;;
    group_label: "Total Page Views Reporting Measures"
  }

  measure: count_total_page_views_ytd_ly {
    label: "YTD LY"
    type: number
    sql: count(distinct case when ${visits.start_date} between date_trunc('year', add_months(current_date - 1, -12)) and add_months(current_date - 1, -12) then ${domain_userid} || ${domain_sessionidx} || ${page_view_index} else null end);;
    group_label: "Total Page Views Reporting Measures"
  }

  measure: count_total_page_views_ytd_yoy {
    label: "YTD YoY"
    type: number
    value_format_name: percent_0
    group_label: "Total Page Views Reporting Measures"
    sql: (${count_total_page_views_ytd} - ${count_total_page_views_ytd_ly})/NULLIF(${count_total_page_views_ytd_ly},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: page_exit_yesterday {
    type: number
    sql: count(distinct case when ${visits.start_date} = current_date - 1 and ${exit_page_flag} then ${domain_userid} || ${domain_sessionidx} || ${page_view_index} else null end)::REAL;;
    label: "Actual"
    group_label: "Count Exit Page Reporting Measures"
    hidden: yes
  }

  measure: page_exit_lw {
    type: number
    sql: count(distinct case when ${visits.start_date} = current_date - 8 and ${exit_page_flag} then ${domain_userid} || ${domain_sessionidx} || ${page_view_index} else null end)::REAL;;
    label: "LW"
    group_label: "Count Exit Page Reporting Measures"
    hidden: yes
  }

  measure: page_exit_l7d {
    type: number
    sql: count(distinct case when (${visits.start_date} between current_date - 7 and current_date - 1) and ${exit_page_flag} then ${domain_userid} || ${domain_sessionidx} || ${page_view_index} else null end)::REAL;;
    label: "L7D"
    group_label: "Count Exit Page Reporting Measures"
    hidden: yes
  }

  measure: page_exit_lcw {
    type: number
    sql: count(distinct case when (((${visits.start_date}) >= ((DATEADD(week,-1, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())) ))) AND ( ${visits.start_date} ) < ((DATEADD(week,1, DATEADD(week,-1, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())))))))) and ${exit_page_flag} then ${domain_userid} || ${domain_sessionidx} || ${page_view_index} else null end)::REAL;;
    label: "LCW"
    group_label: "Count Exit Page Reporting Measures"
    hidden: yes
  }

  measure: page_exit_pcw {
    type: number
    sql: count(distinct case when (((${visits.start_date}) >= ((DATEADD(week,-2, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())) ))) AND ( ${visits.start_date} ) < ((DATEADD(week,1, DATEADD(week,-2, DATE_TRUNC('week', DATE_TRUNC('day',GETDATE())))))))) and ${exit_page_flag} then ${domain_userid} || ${domain_sessionidx} || ${page_view_index} else null end)::REAL;;
    label: "PCW"
    group_label: "Count Exit Page Reporting Measures"
    hidden: yes
  }

  measure: exit_rate_yesterday {
    label: "Actual"
    type: number
    value_format_name: percent_1
    sql: ${page_exit_yesterday}/NULLIF(${count_total_page_views_yesterday},0)::REAL ;;
    group_label: "Exit Rate Reporting Measures"
  }

  measure: exit_rate_lw {
    label: "LW"
    type: number
    value_format_name: percent_1
    sql: ${page_exit_lw}/NULLIF(${count_total_page_views_lw},0)::REAL ;;
    group_label: "Exit Rate Reporting Measures"
  }

  measure: exit_rate_wow {
    label: "%"
    type: number
    value_format_name: percent_1
    group_label: "Exit Rate Reporting Measures"
    sql: (${exit_rate_yesterday} - ${exit_rate_lw})/NULLIF(${exit_rate_lw},0)::REAL ;;
    html: {% if value > 0 %}
        <font color="#D77070"> {{ rendered_value }} </font>
        {% elsif value < 0 %}
        <font color="#3CB371"> {{ rendered_value }} </font>
        {% else %}
        <font color="#000000"> {{ rendered_value }} </font>
        {% endif %}
        ;;
  }

  measure: exit_rate_l7d {
    label: "L7D"
    type: number
    value_format_name: percent_1
    sql: ${page_exit_l7d}/NULLIF(${count_total_page_views_l7d},0)::REAL ;;
    group_label: "Exit Rate Reporting Measures"
  }

  measure: exit_rate_l7d_percentage {
    label: "vs L7D"
    type: number
    value_format_name: percent_1
    group_label: "Exit Rate Reporting Measures"
    sql: (${exit_rate_yesterday} - ${exit_rate_l7d})/NULLIF(${exit_rate_l7d},0)::REAL ;;
    html: {% if value > 0 %}
        <font color="#D77070"> {{ rendered_value }} </font>
        {% elsif value < 0 %}
        <font color="#3CB371"> {{ rendered_value }} </font>
        {% else %}
        <font color="#000000"> {{ rendered_value }} </font>
        {% endif %}
        ;;
  }

  measure: exit_rate_lcw {
    label: "LCW"
    type: number
    value_format_name: percent_1
    sql: ${page_exit_lcw}/NULLIF(${count_total_page_views_lcw},0)::REAL ;;
    group_label: "Exit Rate Reporting Measures"
  }

  measure: exit_rate_pcw {
    label: "PCW"
    type: number
    value_format_name: percent_1
    sql: ${page_exit_pcw}/NULLIF(${count_total_page_views_pcw},0)::REAL ;;
    group_label: "Exit Rate Reporting Measures"
  }

  measure: exit_rate_lcw_percentage {
    label: "LCW %"
    type: number
    value_format_name: percent_1
    group_label: "Exit Rate Reporting Measures"
    sql: (${exit_rate_lcw} - ${exit_rate_pcw})/NULLIF(${exit_rate_pcw},0)::REAL ;;
    html: {% if value > 0 %}
        <font color="#D77070"> {{ rendered_value }} </font>
        {% elsif value < 0 %}
        <font color="#3CB371"> {{ rendered_value }} </font>
        {% else %}
        <font color="#000000"> {{ rendered_value }} </font>
        {% endif %}
        ;;
  }

}
