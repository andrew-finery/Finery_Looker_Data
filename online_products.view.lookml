- view: online_products

  derived_table:
     sql: |
       select
        variants.id as variant_id,
        variants.sku as ean,
        variants.product_id as product_id,
        products.available_on as available_on,
        products.name as style,
        products.product_group_id as product_group_id,
        product_group.sku as parent_sku,
        prices.amount as current_price,
        max_prices.amount as max_price,
        colours.name as colour,
        sizes.name as size,
        product_images.origin_id || '/single/' || product_images.attachment_file_name as option_image,
        product_group_images.origin_id || '/single/' || product_group_images.attachment_file_name as style_image,
        departments.department as department,
        departments.permalink as permalink,
        products.name || ' ' || coalesce(colours.name, '') as option,
        case when date(products.available_on) <= current_date then 'Yes' else 'No' end as online_flag
        
        from
        (select * from daily_snapshot.spree_variants where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_variants) and deleted_at is null and is_master <> 1) variants
        
        
        left join 
        (select * from daily_snapshot.spree_products where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_products) and deleted_at is null) products
        on variants.product_id = products.id
        
        
        left join
        (select * from daily_snapshot.spree_product_groups where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_product_groups) and deleted_at is null) product_group
        on products.product_group_id = product_group.id
        
        
        left join
        (select * from daily_snapshot.spree_prices where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_prices) and currency = 'GBP' and deleted_at is null) prices
        on prices.variant_id = variants.id
        
        left join
        (select variant_id, max(amount) as amount from daily_snapshot.spree_prices where currency = 'GBP'  and deleted_at is null group by 1) max_prices
        on max_prices.variant_id = variants.id
        
        
        left join
        (select * from
        (select * from daily_snapshot.spree_option_values_variants where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_option_values_variants))aaa
        left join
        (select * from daily_snapshot.spree_option_values where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_option_values)) bbb
        on aaa.option_value_id = bbb.id
        where bbb.option_type_id = 3) colours
        on colours.variant_id = variants.id
        
        
        left join
        (select * from
        (select * from daily_snapshot.spree_option_values_variants where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_option_values_variants))aaa
        left join
        (select * from daily_snapshot.spree_option_values where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_option_values)) bbb
        on aaa.option_value_id = bbb.id
        where bbb.option_type_id in(2,7)) sizes
        on sizes.variant_id = variants.id
        
        
        left join
        (select * from
        (select
        var.product_id,
        first_value(assets.attachment_file_name) over (partition by var.product_id order by assets.attachment_file_name desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as attachment_file_name,
        first_value(assets.origin_id) over (partition by var.product_id order by assets.attachment_file_name desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as origin_id 
        from                    
        (select
        viewable_id, 
        first_value(attachment_file_name) over (partition by viewable_id order by "position" asc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as attachment_file_name,
        first_value(coalesce(origin_id, id)) over (partition by viewable_id order by "position" asc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as origin_id
        from daily_snapshot.spree_assets where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_assets) and viewable_type = 'Spree::Variant' and packshot <> 1) assets
        left join
        (select * from daily_snapshot.spree_variants where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_variants) and deleted_at is null) var
        on assets.viewable_id = var.id)
        group by 1,2,3) product_images
        on product_images.product_id = variants.product_id
        
        
        left join
        (select * from
        (select
        prod.product_group_id,
        first_value(assets.attachment_file_name) over (partition by prod.product_group_id order by assets.attachment_file_name desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as attachment_file_name,
        first_value(assets.origin_id) over (partition by prod.product_group_id order by assets.attachment_file_name desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as origin_id 
        from                    
        (select
        viewable_id, 
        first_value(attachment_file_name) over (partition by viewable_id order by "position" asc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as attachment_file_name,
        first_value(coalesce(origin_id, id)) over (partition by viewable_id order by "position" asc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as origin_id
        from daily_snapshot.spree_assets where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_assets) and viewable_type = 'Spree::Variant' and packshot <> 1) assets
        left join
        (select * from daily_snapshot.spree_variants where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_variants) and deleted_at is null) var
        on assets.viewable_id = var.id
        left join
        (select * from daily_snapshot.spree_products where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_products) and deleted_at is null) prod
        on prod.id = var.product_id)
        group by 1,2,3) product_group_images
        on product_group_images.product_group_id = products.product_group_id
        
        
        left join
        (select product_id, department, permalink from 
        (select product_taxons.product_id, FIRST_VALUE(taxons.name) OVER (PARTITION BY PRODUCT_TAXONS.PRODUCT_ID ORDER BY TAXONS.NAME ASC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as department, FIRST_VALUE(taxons.permalink) OVER (PARTITION BY PRODUCT_TAXONS.PRODUCT_ID ORDER BY TAXONS.NAME ASC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as permalink  from
        (select * from daily_snapshot.spree_products_taxons where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_products_taxons)) product_taxons
        left join
        (select * from daily_snapshot.spree_taxons where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_taxons) and parent_id = 1) taxons
        on product_taxons.taxon_id = taxons.id
        where taxonomy_id = 1 -- only get department taxons
        )group by 1,2,3) departments
        on departments.product_id = variants.product_id


     sql_trigger_value: SELECT COUNT(*) FROM daily_snapshot.spree_products
     distkey: ean
     sortkeys: [ean]


  fields:

########################################################################################################################################
############################################### DIMENSIONS #############################################################################
########################################################################################################################################

     - dimension: ean
       sql: ${TABLE}.ean

     - dimension: style
       sql: ${TABLE}.style
       
     - dimension: product_group_id
       sql: ${TABLE}.product_group_id
      
     - dimension: option
       sql: ${TABLE}.option

     - dimension: product_id
       sql: ${TABLE}.product_id
       
     - dimension: colour
       sql: ${TABLE}.colour
    
     - dimension: online_department
       sql: ${TABLE}.department
    
     - dimension: size
       sql: ${TABLE}.size
    
     - dimension: current_price_gbp
       type: number
       decimals: 2
       sql: ${TABLE}.current_price
       format: "£%0.2f"

     - dimension: max_price
       type: number
       decimals: 2
       sql: ${TABLE}.max_price
    
     - dimension_group: available_on
       type: time
       timeframes: [date, week, month]
       sql: ${TABLE}.available_on

     - dimension: weeks_online
       sql: case when ${TABLE}.online_flag = 'No' then 0 else cast(CURRENT_DATE - date(${TABLE}.available_on) as integer) / 7 end
    
     - dimension: image_location
       sql: ${TABLE}.option_image
       
     - dimension: online_flag
       type: yesno
       sql: ${TABLE}.online_flag = 'Yes'
     
     - dimension: option_image
       type: string
       sql: ${TABLE}.option_image
       html: |
          <img src="https://assets.finerylondon.com/spree/products/{{value}}" height="130" width="86"/>
     
     - dimension: style_image
       type: string
       sql: ${TABLE}.style_image
       html: |
          <img src="https://assets.finerylondon.com/spree/products/{{value}}" height="130" width="86"/>

########################################################################################################################################
############################################### DIMENSIONS #############################################################################
########################################################################################################################################

     - measure: image
       type: string
       sql: max(${image_location})
       html: |
          <img src="https://assets.finerylondon.com/spree/products/{{value}}" height="130" width="86"/>
          
     - measure: image_path
       type: string
       sql: max(${image_location})

     - measure: skus_online
       type: count_distinct
       sql: ${TABLE}.ean
       filters:
        online_flag: Yes 
        
     - measure: options_online
       type: count_distinct
       sql: ${TABLE}.product_id
       filters:
        online_flag: Yes 
       
     - measure: styles_online
       type: count_distinct
       sql: ${TABLE}.product_group_id
       filters:
        online_flag: Yes 

