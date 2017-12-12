 view: rakuten_orders {
   # Or, you could make this view a derived table, like this:
   derived_table: {
     sql: select
          order_id,
          min(transaction_date) as transaction_date,
          min(publisher_id) as publisher_id,
          min(publisher_name) as publisher_name,
          sum(nr_of_items) as nr_of_items,
          sum(nr_of_cancelled_items) as nr_of_cancelled_items,
          sum(cast(sales as decimal(8,2))) as sales,
          sum(cast(total_commission as decimal(8,2))) as commission
          from affiliate_data.rakuten_transactions
          group by 1
       ;;
   }

  dimension_group: order_placed {
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
    sql: cast(${TABLE}.transaction_date as date) ;;
  }

  dimension: order_id {
    type: string
    sql: ${TABLE}.order_id;;
  }

  dimension: publisher_id {
    type: string
    sql: ${TABLE}.publisher_id;;
  }

  dimension: publisher_name {
    type: string
    sql: ${TABLE}.publisher_name ;;
  }

  dimension: number_of_items{
    type: number
    sql: ${TABLE}.nr_of_items ;;
  }

  dimension: revenue {
    type: number
    value_format_name: decimal_2
    sql: ${TABLE}.sales ;;
  }

  dimension: commission {
    type: number
    value_format_name: decimal_2
    sql: ${TABLE}.commission ;;
  }

  ################################################################
  ######################## MEASURES ##############################


  measure: sum_revenue {
    type: sum
    value_format_name: decimal_2
    sql: ${revenue} ;;
  }

  measure: sum_commission {
    type: sum
    value_format_name: decimal_2
    sql: ${commission} ;;
  }

  measure: sum_items {
    type: sum
    value_format_name: decimal_2
    sql: ${number_of_items} ;;
  }

  measure: count_orders {
    type: count_distinct
    sql: ${number_of_items} ;;
  }

 }
