- view: finery_budgets
  sql_table_name: lookup.finery_budgets
  fields:

  - dimension: department
    sql: ${TABLE}.department

  - dimension: intake_budget_retail_value
    type: number
    sql: ${TABLE}.intake_budget_retail_value

  - dimension: intake_budget_units
    type: int
    sql: ${TABLE}.intake_budget_units

  - dimension: intake_margin_budget
    type: number
    sql: ${TABLE}.intake_margin_budget

  - dimension: margin_budget
    type: number
    sql: ${TABLE}.margin_budget

  - dimension: margin_budget_percent
    type: number
    sql: ${TABLE}.margin_budget_percent

  - dimension: returns_budget
    type: number
    sql: ${TABLE}.returns_budget

  - dimension: returns_budget_percent
    type: number
    sql: ${TABLE}.returns_budget_percent

  - dimension: sales_budget
    type: number
    sql: ${TABLE}.sales_budget

  - dimension: sales_discount_mix_budget
    type: number
    sql: ${TABLE}.sales_discount_mix_budget

  - dimension: sales_fp_mix_budget
    type: number
    sql: ${TABLE}.sales_fp_mix_budget

  - dimension: shipping_budget
    type: number
    sql: ${TABLE}.shipping_budget

  - dimension: stock_discount_mix_budget
    type: number
    sql: ${TABLE}.stock_discount_mix_budget

  - dimension: stock_fp_mix_budget
    type: number
    sql: ${TABLE}.stock_fp_mix_budget

  - dimension: stockholding_budget_cost
    type: number
    sql: ${TABLE}.stockholding_budget_cost

  - dimension: stockholding_budget_retail
    type: number
    sql: ${TABLE}.stockholding_budget_retail

  - dimension: weeks_cover_budget
    type: number
    sql: ${TABLE}.weeks_cover_budget

  - dimension: year_week_number
    type: int
    sql: ${TABLE}.year_week_number

  - measure: count
    type: count
    drill_fields: []

