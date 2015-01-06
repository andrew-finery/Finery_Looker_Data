- view: sales_budgets
  sql_table_name: lookup.sales_budgets
  fields:

  - dimension: sales_budget
    type: number
    decimals: 2
    sql: ${TABLE}.budget
    format: "£%0.2f"

  - dimension: department
    sql: ${TABLE}.department

  - dimension: year_week_number
    type: int
    sql: ${TABLE}.year_week_number

  - measure: sum_sales_budget
    type: sum
    sql: ${sales_budget}
    format: "£%0.2f"