- view: product_impressions
  derived_table:
     sql: |
          SELECT impressions.root_id,
                 impressions.currency_code,
                 impressions_context.brand,
                 impressions_context.category,
                 impressions_context.id,
                 impressions_context.list,
                 impressions_context.name,
                 impressions_context. "position",
                 impressions_context.price,
                 impressions_context.sku,
                 impressions_context.style
          FROM atomic.com_finerylondon_product_impression_1 impressions
            LEFT JOIN atomic.com_finerylondon_product_impression_context_1 impressions_context ON impressions.root_id = impressions_context.root_id

  fields:
  
  - dimension: product_impression_id
    sql: ${TABLE}.root_id || ${TABLE}.id
      
  - dimension: product_id
    sql: ${TABLE}.id
    hidden: true
  
  - dimension: position
    sql: ${TABLE}.position
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
  
