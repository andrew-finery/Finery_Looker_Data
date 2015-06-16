- view: online_products

  derived_table:
     sql: |
          select
          variants.id as variant_id,
          variants.sku as ean,
          variants.product_id as product_id,
          variants.deleted_at as deleted_at,
          products.available_on as available_on,
          first_value(products.name) over (partition by products.product_group_id order by products.name asc rows between unbounded preceding and unbounded following) as style,
          products.product_group_id as product_group_id,
          product_group.sku as parent_sku,
          prices.amount as current_price,
          max_prices.amount as max_price,
          colours.name as colour,
          colour_groups.name as colour_group,
          sizes.name as size,
          product_images.origin_id || '/single/' || product_images.attachment_file_name as option_image,
          product_group_images.origin_id || '/single/' || product_group_images.attachment_file_name as style_image,
          departments.department as department,
          departments.permalink as permalink,
          sub_departments.department as sub_department,
          products.name || ' ' || coalesce(colours.name, '') as option,
          case when date(products.available_on) > current_date or variants.deleted_at is not null then 'No' else 'Yes' end as online_flag,
          products.is_coming_soon,
          case when pre_sale_prices.amount = 0 then null else pre_sale_prices.amount end as pre_sale_price,
          on_sale_dates.on_sale_date
          
          from
          
          (select sku, id, product_id, deleted_at from
          (select sku,
          first_value(id) over(partition by sku order by deleted_at desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as id,
          first_value(product_id) over(partition by sku order by deleted_at desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as product_id,
          first_value(deleted_at) over(partition by sku order by deleted_at desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as deleted_at
          from daily_snapshot.spree_variants where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_variants) and is_master <>1)
          group by 1,2,3,4) variants
          
          
          left join 
          (select * from daily_snapshot.spree_products where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_products)) products
          on variants.product_id = products.id
          
          
          left join
          (select * from daily_snapshot.spree_product_groups where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_product_groups)) product_group
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
          where bbb.option_type_id = 9) colour_groups
          on colour_groups.variant_id = variants.id        
          
          left join
          (select * from
          (select * from daily_snapshot.spree_option_values_variants where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_option_values_variants))aaa
          left join
          (select * from daily_snapshot.spree_option_values where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_option_values)) bbb
          on aaa.option_value_id = bbb.id
          where bbb.option_type_id in(1,5,6,7)) sizes
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
          (select
          product_taxons.product_id,
          FIRST_VALUE(taxons.name) OVER (PARTITION BY PRODUCT_TAXONS.PRODUCT_ID ORDER BY TAXONS.NAME ASC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as department,
          FIRST_VALUE(taxons.permalink) OVER (PARTITION BY PRODUCT_TAXONS.PRODUCT_ID ORDER BY TAXONS.NAME ASC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as permalink
          from
          (select * from daily_snapshot.spree_products_taxons where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_products_taxons)) product_taxons
          left join
          (select * from daily_snapshot.spree_taxons where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_taxons)) taxons
          on product_taxons.taxon_id = taxons.id
          where taxons.parent_id = 1) group by 1,2,3) departments
          on departments.product_id = variants.product_id
  
          left join
          (select product_id, department, permalink from
          (select
          product_taxons.product_id,
          FIRST_VALUE(taxons.name) OVER (PARTITION BY PRODUCT_TAXONS.PRODUCT_ID ORDER BY TAXONS.NAME ASC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as department,
          FIRST_VALUE(taxons.permalink) OVER (PARTITION BY PRODUCT_TAXONS.PRODUCT_ID ORDER BY TAXONS.NAME ASC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as permalink
          from
          (select * from daily_snapshot.spree_products_taxons where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_products_taxons)) product_taxons
          left join
          (select * from daily_snapshot.spree_taxons where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_taxons)) taxons
          on product_taxons.taxon_id = taxons.id
          where taxons.parent_id is not null
          and taxons.parent_id not in (72, 1)) group by 1,2,3) sub_departments
          on sub_departments.product_id = variants.product_id
          
          left join
          (select * from daily_snapshot.spree_pre_sale_prices where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_pre_sale_prices) and deleted_at is null and currency = 'GBP') pre_sale_prices
          on pre_sale_prices.variant_id = variants.id
          
          left join
          (select variant_id, min(date(spree_timestamp)) - 1 as on_sale_date from daily_snapshot.spree_pre_sale_prices where deleted_at is null and amount > 0 group by 1) on_sale_dates
          on on_sale_dates.variant_id = variants.id

     sql_trigger_value: SELECT COUNT(*) FROM daily_snapshot.spree_products
     distkey: ean
     sortkeys: [ean]


  fields:

########################################################################################################################################
############################################### DIMENSIONS #############################################################################
########################################################################################################################################

     - dimension: ean
       sql: ${TABLE}.ean
       hidden: true

     - dimension: style
       label: Style
       sql: ${TABLE}.style
       
     - dimension: product_group_id
       sql: ${TABLE}.product_group_id
       hidden: true
       
     - dimension: option
       label: Option
       sql: ${TABLE}.option

     - dimension: option_for_returns_report
       label: Option
       sql: ${TABLE}.option
       html: |
               <a href="https://finerylondon.looker.com/explore/finery_data/spree_returns?dynamic_fields=%5B%5D&f%5Bspree_returns.returned_at_date%5D=yesterday&filter_config=%7B%22online_products.option_for_returns_report%22:%5B%7B%22type%22:%22%3D%22,%22values%22:%5B%7B%22constant%22:{{value}}7D,%7B%7D%5D,%22id%22:0%7D%5D,%22spree_returns.returned_at_date%22:%5B%7B%22type%22:%22advanced%22,%22values%22:%5B%7B%22constant%22:%22yesterday%22%7D,%7B%7D%5D,%22id%22:1%7D%5D%7D&%20Black,%7B%7D%5D,%22id%22:1%7D%5D,%22spree_returns.returned_at_date%22:%5B%7B%22type%22:%22advanced%22,%22values%22:%5B%7B%22date%22:%222015-04-23T08:59:11.258Z%22,%22unit%22:%22day%22,%22constant%22:%22yesterday%22%7D,%7B%7D%5D,%22id%22:0%7D%5D%7D&query=BtN4vDw&vis_config=%7B%22type%22:%22looker_column%22%7D&visible_ui_sections=data&show=data,fields&vis=%7B%22type%22:%22looker_column%22%7D&f%5Bonline_products.option_for_returns_report%5D={{value}}">{{value}}</a>

     - dimension: product_id
       sql: ${TABLE}.product_id

     - dimension: colour_group
       label: Colour Group
       sql: ${TABLE}.colour_group
       
     - dimension: colour
       label: Colour
       sql: ${TABLE}.colour
       
     - dimension: online_department
       label: Online Department
       sql: ${TABLE}.department
       
     - dimension: online_sub_department
       label: Sub-Department
       sql: ${TABLE}.sub_department       
       
     - dimension: size
       label: Size
       sql: ${TABLE}.size
    
     - dimension: current_price_gbp
       label: Current Price
       type: number
       decimals: 2
       sql: ${TABLE}.current_price
       format: "£%0.2f"

     - dimension: first_price
       label: Maximum Price
       type: number
       decimals: 2
       sql: ${TABLE}.max_price

     - dimension: pre_sale_price
       label: Pre-Sale Price
       type: number
       decimals: 2
       sql: ${TABLE}.pre_sale_price
      
     - dimension: max_price
       label: Original Price
       type: number
       decimals: 2
       sql: coalesce(${pre_sale_price}, ${first_price})
     
     - dimension: on_sale_flag
       label: Currently on Sale Flag
       sql: case when ${pre_sale_price} is not null then 'On Sale' else 'Full Price' end

     - dimension_group: on_sale
       label: On Sale
       type: time
       timeframes: [date]
       sql: ${TABLE}.on_sale_date
      
     - dimension_group: available_on
       type: time
       timeframes: [date, week, month]
       sql: ${TABLE}.available_on
       
     - dimension: weeks_online
       label: Weeks Online
       sql: case when ${TABLE}.online_flag = 'No' then 0 else cast(CURRENT_DATE - date(${TABLE}.available_on) as integer) / 7 end

     - dimension: days_online
       label: Days Online
       sql: case when ${TABLE}.online_flag = 'No' then 0 else cast(CURRENT_DATE - date(${TABLE}.available_on) as integer) end
    
     - dimension: image_location
       sql: ${TABLE}.option_image
       hidden: true
       
     - dimension: online_flag
       label: Online Flag
       type: yesno
       sql: ${TABLE}.online_flag = 'Yes'

     - dimension: coming_soon_flag
       label: Coming Soon Flag
       type: yesno
       sql: ${TABLE}.is_coming_soon = 'true'
     
     - dimension: option_image
       label: Option Image
       type: string
       sql: ${TABLE}.option_image
       html: |
          <img src="https://assets.finerylondon.com/spree/products/{{value}}" height="130" width="86"/>
     
     - dimension: style_image
       label: Style Image
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
       hidden: true
       
     - measure: image_path
       type: string
       sql: max(${image_location})
       hidden: true
       
     - measure: skus_online
       label: Skus Online
       type: count_distinct
       sql: ${TABLE}.ean
       filters:
        online_flag: Yes 
      
     - measure: options_online
       label:  Options Online
       type: count_distinct
       sql: ${TABLE}.product_id
       filters:
        online_flag: Yes 
       
     - measure: styles_online
       label: Styles Online
       type: count_distinct
       sql: ${TABLE}.product_group_id
       filters:
        online_flag: Yes 

