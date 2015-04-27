- view: spree_products
  derived_table:
     sql: |
       select
        product_groups.id as product_group_id,
        products.id as product_id,
        colours_prices.colour,
        colours_prices.colour_group,
        colours_prices.current_price,
        colours_prices.max_price,
        product_groups.name as style_name,
        product_groups.sku as parent_sku,
        brightpearl_info.department,
        brightpearl_info.sub_season_code,
        brightpearl_info.product_area,
        departments.department as online_department,
        sub_departments.department as online_sub_department
        
        from
        (select * from daily_snapshot.spree_product_groups where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_product_groups)) product_groups
        
        left join
        (select
        parent_sku,
        max(category) as department,
        max(sub_season_code) as sub_season_code,
        case when max(category) in ('Jewellery', 'Accessories') then 'Non-Clothing' else 'Clothing' end as product_area
        from finery.brightpearl_export group by 1) brightpearl_info
        on product_groups.sku = brightpearl_info.parent_sku
        
        left join
        (select * from daily_snapshot.spree_products where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_products)) products
        on products.product_group_id = product_groups.id
        
        left join
        (select variants.product_id, max(colours."name") as colour, max(colour_groups."name") as colour_group, max(current_price) as current_price, max(max_price) as max_price from
        (select * from daily_snapshot.spree_option_values_variants where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_option_values_variants)) option_values_variants
        left join
        (select * from daily_snapshot.spree_option_values where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_option_values) and option_type_id = 3) colours
        on option_values_variants.option_value_id = colours.id
        left join
        (select * from daily_snapshot.spree_option_values where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_option_values) and option_type_id = 9) colour_groups
        on option_values_variants.option_value_id = colour_groups.id
        left join
        (select * from daily_snapshot.spree_variants where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_variants) and deleted_at is null) variants
        on option_values_variants.variant_id = variants.id
        left join
        (select variant_id, max(amount) as current_price from daily_snapshot.spree_prices where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_prices) and currency = 'GBP' group by 1) current_prices
        on current_prices.variant_id = variants.id
        left join
        (select variant_id, max(amount) as max_price from daily_snapshot.spree_prices where currency = 'GBP' group by 1) max_prices
        on max_prices.variant_id = variants.id
        where variants.product_id is not null
        group by 1) colours_prices
        on colours_prices.product_id = products.id
        
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
        on departments.product_id = products.id

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
        and taxons.parent_id 
        not in (72, 1)) group by 1,2,3) sub_departments
        on sub_departments.product_id = products.id

        where products.id is not null
        and colours_prices.max_price is not null


     sql_trigger_value: SELECT COUNT(*) FROM daily_snapshot.spree_variants
     distkey: product_id
     sortkeys: [product_id]


  fields:

  - dimension: product_group_id
    sql: ${TABLE}.product_group_id
    hidden: true
      
  - dimension: product_id
    sql: ${TABLE}.product_id
    hidden: true
    
  - dimension: colour
    label: COLOUR
    sql: ${TABLE}.colour

  - dimension: colour_group
    label: COLOUR GROUP
    sql: ${TABLE}.colour_group
    
  - dimension: style_name
    label: STYLE NAME
    sql: ${TABLE}.style_name
    
  - dimension: option_name
    label: OPTION NAME
    sql: ${style_name} || ' ' || ${colour}
    
  - dimension: current_price
    label: CURRENT PRICE
    sql: ${TABLE}.current_price
    
  - dimension: max_price
    label: MAX PRICE
    sql: ${TABLE}.max_price
    
  - dimension: parent_sku
    sql: ${TABLE}.parent_sku
    hidden: true
      
  - dimension: department
    label: DEPARTMENT
    sql_case:
      Evening Dresses: ${TABLE}.department = 'Evening Dresses'
      Outerwear and Blazers: ${TABLE}.department = 'Outerwear & Blazers'
      Skirts: ${TABLE}.department = 'Skirts'
      Woven Tops: ${TABLE}.department = 'Woven Tops'
      Day Dresses: ${TABLE}.department = 'Day Dresses'
      Shoes: ${TABLE}.department = 'Shoes'
      Knitwear: ${TABLE}.department = 'Knitwear'
      Trousers and Shorts: ${TABLE}.department = 'Trousers & Shorts'
      Jersey Tops: ${TABLE}.department = 'Jersey Tops'
      Accessories: ${TABLE}.department = 'Accessories'
      Jewellery: ${TABLE}.department = 'Jewellery'
      else: 'Other'
    
  - dimension: sub_season
    label: SUB SEASON
    sql: ${TABLE}.sub_season_code
    
  - dimension: product_area
    label: PRODUCT AREA
    sql: ${TABLE}.product_area
    
  - dimension: selling_price_tiered
    label: CURRENT PRICE TIER
    sql_case:
      £0 - £20: ${current_price} < 20
      £20 - £40: ${current_price} < 40
      £40 - £60: ${current_price} < 60
      £60 - £80: ${current_price} < 80
      £80 - £100: ${current_price} < 100
      £100 - £150: ${current_price} < 150
      £150 - £200: ${current_price} < 200
      £200 - £300: ${current_price} < 300
      else: '£300 and over'
    
  - dimension: discount_level_tier
    label: CURRENT DISCOUNT LEVEL TIER
    sql_case:
      0% - 7.5%: ${current_price}/${max_price} > 0.925 or ${max_price} = 0
      7.5% - 17.5%: ${current_price}/${max_price} > 0.825
      17.5% - 27.5%: ${current_price}/${max_price} > 0.725
      27.5% - 37.5%: ${current_price}/${max_price} > 0.625
      37.5% and over: (${current_price}/${max_price}) > 0 and (${current_price}/${max_price}) <= 0.625
      else: '0% - 7.5%'