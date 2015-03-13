- view: product_quick_views
  derived_table:
     sql: |
          SELECT quick_view.root_id,
                 quick_view.currency_code,
                 product_context.brand,
                 product_context.category,
                 product_context.id,
                 product_context.list,
                 product_context.name,
                 product_context. "position",
                 product_context.price,
                 product_context.sku,
                 product_context.style
          FROM atomic.com_finerylondon_product_quick_view_1 quick_view
            LEFT JOIN atomic.com_finerylondon_product_impression_context_1 product_context ON quick_view.root_id = product_context.root_id

  fields:
  
  - dimension: event_id
    sql: ${TABLE}.root_id
    hidden: true
    
  - dimension: product_id
    sql: ${TABLE}.id
    hidden: true
  
  - dimension: position
    sql: ${TABLE}."position"
    hidden: true

  - dimension: category
    sql: ${TABLE}.category
    hidden: true
    
  - dimension: style
    sql: ${TABLE}.style
    hidden: true
       
  - dimension: list
    sql: ${TABLE}.list
    hidden: true