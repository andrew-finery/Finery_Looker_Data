view: john_lewis_sor {
derived_table: {
  sql:  -- STEP 1: Set up the table: all EANs, all locations, all dates
        with step_1 as (
        select ean, loc_name, calendar_date from
        (select ean from web.variant_info group by 1)
        cross join
        (select loc_name from john_lewis.sales where report_type != 'Report Type' and case when report_date = 'Report Date' then null else to_date(report_date, 'DD/MM/YYYY') end  > '2017-07-19' group by 1)
        cross join
        (select calendar_date from finery.calendar where calendar_date between '2017-07-18' and current_date - 1)
        )

        -- STEP 2: JL sales and returns (units and revs by store by date)
        , step_2 as (
        select
        case when report_date = 'Report Date' then null else to_date(report_date, 'DD/MM/YYYY') end as calendar_date,
        loc_name,
        pr_ean as ean,
        sum(NULLIF(sales, '')) as sales_units,
        sum(NULLIF(returns, '')) as returns_units,
        sum(NULLIF(money_sal, '')) as gross_revenue,
        sum(NULLIF(money_ret, '')) as refunds
        from john_lewis.sales
        where report_type != 'Report Type'
        and case when report_date = 'Report Date' then null else to_date(report_date, 'DD/MM/YYYY') end  > '2017-07-19'
        group by 1,2,3
        )

        -- STEP 3: Summary of JL.com order 19/07/2017 (pre warehouse move so in a manually created table)
        , step_3 as (
        select '2017-07-19' as calendar_date, ean, sum(delivered_qty) as units_delivered, 'John Lewis.com' as loc_name from john_lewis.ecom_shipment_19_07_17 group by 1,2,4
        )

        select
        a.ean,
        a.loc_name,
        a.calendar_date,
        coalesce(b.sales_units, 0) as sales_units,
        coalesce(b.returns_units, 0) as returns_units,
        coalesce(b.gross_revenue, 0) as gross_revenue,
        coalesce(b.refunds, 0) as refunds,
        coalesce(c.units_delivered, 0) as units_delivered
        from step_1 a

        left join step_2 b
        on a.calendar_date = b.calendar_date
        and a.loc_name = b.loc_name
        and a.ean = b.ean

        left join step_3 c
        on a.calendar_date = c.calendar_date
        and a.loc_name = c.loc_name
        and a.ean = c.ean

        where (b.sales_units > 0 or b.returns_units > 0 or c.units_delivered > 0)

       ;;
}

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
    type: number
    sql: ${sum_units_delivered} + ${sum_returns_units} - ${sum_sales_units};;
  }
}
