view: redshift_table_checks {
  derived_table: {
    sql: with step_1 as (
      select
      table_name,
      "rows" as no_rows,
      distinct_key_1 as count_distinct_key_1,
      distinct_key_2 as count_distinct_key_2
      from
      bi_data.table_checks
      )

      select
      a.table_name,
      a.no_rows,
      b.distinct_key_1,
      a.count_distinct_key_1,
      b.distinct_key_2,
      a.count_distinct_key_2
      from step_1 a
      left join bi_data.table_distinct_keys b
      on a.table_name = b.table_name
       ;;
  }

  dimension: distinct_key_1 {
    type: string
    sql: ${TABLE}.distinct_key_1 ;;
  }

  dimension: count_distinct_key_1 {
    type: number
    sql: ${TABLE}.count_distinct_key_1 ;;
  }

  dimension: distinct_key_2 {
    type: string
    sql: ${TABLE}.distinct_key_2 ;;
  }

  dimension: count_distinct_key_2 {
    type: number
    sql: ${TABLE}.count_distinct_key_2 ;;
  }

  dimension: number_of_rows {
    type: number
    sql: ${TABLE}.no_rows ;;
  }

  dimension: table_name {
    type: string
    sql: ${TABLE}.table_name ;;
  }

  dimension: percent_difference_distinct_key_1 {
    type: number
    sql: (${number_of_rows} - ${count_distinct_key_1}) / NULLIF(${number_of_rows}, 0)::REAL ;;
  }

  dimension: percent_difference_distinct_key_2 {
    type: number
    sql: (${number_of_rows} - ${count_distinct_key_2}) / NULLIF(${number_of_rows}, 0)::REAL ;;
  }
}
