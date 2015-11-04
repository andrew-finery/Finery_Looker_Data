- view: website_product_stats
  sql_table_name: web.product_stats
  fields:

  - dimension: id
    type: int
    sql: ${TABLE}.id

  - dimension: clicks
    type: number
    sql: ${TABLE}.clicks

  - dimension: domain_sessionidx
    type: number
    sql: ${TABLE}.domain_sessionidx

  - dimension: domain_userid
    sql: ${TABLE}.domain_userid

  - dimension: impressions
    type: number
    sql: ${TABLE}.impressions

  - dimension: product_views
    type: number
    sql: ${TABLE}.product_views

  - dimension: quantity_purchased
    type: number
    sql: ${TABLE}.quantity_purchased

  - dimension: quick_views
    type: number
    sql: ${TABLE}.quick_views

# Measures

  - measure: sum_product_views
    type: sum
    sql: ${product_views}
  
  - measure: sum_products_purchased
    type: sum
    sql: ${quantity_purchased}

  - measure: count_visits
    type: count_distinct
    sql: ${domain_userid} || ${domain_sessionidx}
  
  - measure: product_conversion_rate
    type: number
    decimals: 4
    sql: ${sum_products_purchased}/NULLIF(${sum_product_views},0)::REAL
    value_format: '0.00%'
  
  - measure: product_views_per_visit
    type: number
    decimals: 2
    sql: ${sum_product_views}/NULLIF(${count_visits},0)::REAL
    value_format: '0.00'
    

  