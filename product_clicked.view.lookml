- view: product_clicked
  derived_table:
     sql: |
          SELECT click.root_id,
                 impressions_context.brand,
                 impressions_context.category,
                 impressions_context.id,
                 impressions_context.list,
                 impressions_context.name,
                 impressions_context. "position",
                 impressions_context.price,
                 impressions_context.sku,
                 impressions_context.style
          FROM atomic.com_finerylondon_product_clicked_1 click
            LEFT JOIN atomic.com_finerylondon_product_impression_context_1 impressions_context ON click.root_id = impressions_context.root_id

  fields:
  
  - dimension: event_id
    sql: ${TABLE}.root_id
    hidden: true
      
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
  