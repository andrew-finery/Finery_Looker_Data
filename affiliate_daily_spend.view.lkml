view: affiliate_daily_spend {
  derived_table: {
    sql: with step_1 as (
          select
          (SUM(CASE WHEN (webgains_orders.status = 'confirmed' OR webgains_orders.status = 'delayed') THEN (webgains_orders.commission * (1 + (case when webgains_orders.campaign_id = 139873 then 0.1 else 0.3 end)))  ELSE NULL END))/(SUM(webgains_orders.commission * (1 + (case when webgains_orders.campaign_id = 139873 then 0.1 else 0.3 end)))) as percentage_paid
          FROM affiliate_data.webgains_transactions webgains_orders
          where date(webgains_orders."date") between current_date - 180 and current_date - 45
          )

          , step_2 as (
          SELECT
            date(webgains_orders."date") as calendar_date,
            SUM(webgains_orders.commission * (1 + (case when webgains_orders.campaign_id = 139873 then 0.1 else 0.3 end))) AS current_amount_spent,
            SUM(CASE WHEN (webgains_orders.status = 'confirmed' OR webgains_orders.status = 'delayed') THEN (webgains_orders.commission * (1 + (case when webgains_orders.campaign_id = 139873 then 0.1 else 0.3 end)))  ELSE NULL END) AS amount_spent_confirmed
          FROM affiliate_data.webgains_transactions  AS webgains_orders
          GROUP BY 1
          ORDER BY 1 DESC
          )

          select
          calendar_date,
          case when calendar_date < current_date - 45 then 'confirmed' else 'estimate' end as status,
          case when calendar_date < current_date - 45 then amount_spent_confirmed else current_amount_spent * percentage_paid end as spend
          from
          step_2 cross join step_1 ;;
    }

  dimension_group: calendar {
    type: time
    timeframes: [
      date,
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
    sql: ${TABLE}.calendar_date ;;
  }

  dimension: status {
    sql: ${TABLE}.status ;;
  }

  dimension: affiliate_spend {
    type: number
    value_format_name: decimal_2
    sql: ${TABLE}.spend ;;
  }

  measure: sum_affiliate_spend {
    type: sum
    value_format_name: decimal_2
    sql: ${affiliate_spend} ;;
  }

}
