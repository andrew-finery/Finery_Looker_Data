- view: page_contexts
  derived_table:
     sql: |
          select
          root_id,
          customer_id,
          page_type,
          prod_brand,
          prod_category,
          prod_id,
          prod_name,
          prod_price,
          prod_variant
          from
          atomic.com_finerylondon_page_view_context_1

  fields:

  - dimension: event_id
    sql: ${TABLE}.root_id
    hidden: true
  
  - dimension: page_type
    sql: ${TABLE}.page_type
    hidden: true
      
  - dimension: product_id
    sql: ${TABLE}.prod_id
    hidden: true

  - dimension: category
    sql: ${TABLE}.prod_category
    hidden: true
  
  - dimension: prod_price
    sql: ${TABLE}.prod_price
    hidden: true
    















