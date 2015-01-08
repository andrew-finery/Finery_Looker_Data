- view: online_products
# View of all products currently live on the website

  derived_table:
     sql: |
       select
        ean,
        max(style) as style,
        max(product_description) as product_description,
        max(available_on) as available_on,
        max(current_price) as current_price,
        max(option_image) as option_image,
        max(colour) as colour,
        max(size) as size,
        max(option) as option,
        min(online_flag) as online_flag,
        min(department) as department
        
        from
        
        (select
                a.id as product_id,
                a.name as style,
                a.description as product_description,
                a.available_on as available_on,
                b.id as variant_id,
                b.sku as ean,
                c.amount as current_price,
                h.option_image,
                f.colour,
                g.size,
                a.name || ' ' || coalesce(f.colour, '') as option,
                case when c.amount is null then 'Yes' else (case when date(a.available_on) <= current_date then 'Yes' else 'No' end) end as online_flag,
                j.name as department
                
                
                
                from
                (select * from daily_snapshot.spree_products where date(spree_timestamp) = (select max(date(spree_timestamp)) from daily_snapshot.spree_products)) a
                
                inner join
                (select * from daily_snapshot.spree_variants where date(spree_timestamp) = (select max(date(spree_timestamp)) from daily_snapshot.spree_variants) and is_master <>1) b
                on a.id = b.product_id
                
                left join
                (select variant_id, amount from (select * from daily_snapshot.spree_prices where date(spree_timestamp) = (select max(date(spree_timestamp)) from daily_snapshot.spree_prices)) where currency = 'GBP' and deleted_at is null group  by 1,2) c
                on c.variant_id = b.id
                
                left join
                    (select aaa.variant_id, bbb.name as colour from
                      (select * from daily_snapshot.spree_option_values_variants where date(spree_timestamp) = (select max(date(spree_timestamp)) from daily_snapshot.spree_option_values_variants))aaa
                      left join
                      (select * from daily_snapshot.spree_option_values where date(spree_timestamp) = (select max(date(spree_timestamp)) from daily_snapshot.spree_option_values)) bbb
                      on aaa.option_value_id = bbb.id
                      left join
                      (select * from daily_snapshot.spree_option_types where date(spree_timestamp) = (select max(date(spree_timestamp)) from daily_snapshot.spree_option_types)) ccc
                      on bbb.option_type_id = ccc.id
                      where ccc.id = 3) f --only return the colour
                
                on b.id = f.variant_id
                
                left join
                    (select aaa.variant_id, max(bbb.name) as size from
                      (select * from daily_snapshot.spree_option_values_variants where date(spree_timestamp) = (select max(date(spree_timestamp)) from daily_snapshot.spree_option_values_variants))aaa
                      left join
                      (select * from daily_snapshot.spree_option_values where date(spree_timestamp) = (select max(date(spree_timestamp)) from daily_snapshot.spree_option_values)) bbb
                      on aaa.option_value_id = bbb.id
                      left join
                      (select * from daily_snapshot.spree_option_types where date(spree_timestamp) = (select max(date(spree_timestamp)) from daily_snapshot.spree_option_types)) ccc
                      on bbb.option_type_id = ccc.id
                      where ccc.id <> 3 -- get the size
                      group by 1) g
                
                on b.id = g.variant_id
                
                left join
                         (select
                          bbb.id as variant_id,
                          aaa.id as style_id,
                          aaa.id || '-' || ccc.colour as option_id,
                          eee.style_image,
                          case when max(coalesce(ddd.origin_id, ddd.id) || '/single/' || ddd.attachment_file_name) is null then max(eee.style_image) else max(coalesce(ddd.origin_id, ddd.id) || '/single/' || ddd.attachment_file_name) end as option_image
                          from
                          (select * from daily_snapshot.spree_products where date(spree_timestamp) = (select max(date(spree_timestamp)) from daily_snapshot.spree_products)) aaa
                          inner join
                          (select * from daily_snapshot.spree_variants where date(spree_timestamp) = (select max(date(spree_timestamp)) from daily_snapshot.spree_variants)) bbb
                          on aaa.id = bbb.product_id
                          left join
                                         (select aaa.variant_id, bbb.name as colour from
                                        (select * from daily_snapshot.spree_option_values_variants where date(spree_timestamp) = (select max(date(spree_timestamp)) from daily_snapshot.spree_option_values_variants)) aaa
                                        left join
                                        (select * from daily_snapshot.spree_option_values where date(spree_timestamp) = (select max(date(spree_timestamp)) from daily_snapshot.spree_option_values)) bbb
                                        on aaa.option_value_id = bbb.id
                                        left join
                                        (select * from daily_snapshot.spree_option_types where date(spree_timestamp) = (select max(date(spree_timestamp)) from daily_snapshot.spree_option_types)) ccc
                                        on bbb.option_type_id = ccc.id
                                        where ccc.id = 3) ccc
                          on ccc.variant_id = bbb.id
                          left join
                                        (select * from daily_snapshot.spree_assets where date(spree_timestamp) = (select max(date(spree_timestamp)) from daily_snapshot.spree_assets) and viewable_type = 'Spree::Variant' and packshot <> 1) ddd
                          on ddd.viewable_id = bbb.id
                          left join
                                        (select
                                          aaa.id as style_id,
                                          max(coalesce(ddd.origin_id, ddd.id) || '/single/' || ddd.attachment_file_name) as style_image ----
                                          from
                                          (select * from daily_snapshot.spree_products where date(spree_timestamp) = (select max(date(spree_timestamp)) from daily_snapshot.spree_products)) aaa
                                          inner join
                                          (select * from daily_snapshot.spree_variants where date(spree_timestamp) = (select max(date(spree_timestamp)) from daily_snapshot.spree_variants)) bbb
                                          on aaa.id = bbb.product_id
                                          left join
                                                         (select aaa.variant_id, bbb.name as colour from
                                                        (select * from daily_snapshot.spree_option_values_variants where date(spree_timestamp) = (select max(date(spree_timestamp)) from daily_snapshot.spree_option_values_variants)) aaa
                                                        left join
                                                        (select * from daily_snapshot.spree_option_values where date(spree_timestamp) = (select max(date(spree_timestamp)) from daily_snapshot.spree_option_values)) bbb
                                                        on aaa.option_value_id = bbb.id
                                                        left join
                                                        (select * from daily_snapshot.spree_option_types where date(spree_timestamp) = (select max(date(spree_timestamp)) from daily_snapshot.spree_option_types)) ccc
                                                        on bbb.option_type_id = ccc.id
                                                        where ccc.id = 3) ccc
                                          on ccc.variant_id = bbb.id
                                          left join
                                                        (select * from daily_snapshot.spree_assets where date(spree_timestamp) = (select max(date(spree_timestamp)) from daily_snapshot.spree_assets) and viewable_type = 'Spree::Variant' and packshot <> 1) ddd
                                          on ddd.viewable_id = bbb.id
                                          group by 1) eee
                          on aaa.id = eee.style_id
        
                          group by 1,2,3,4) h
                          
                          on h.variant_id = b.id
                          




                        
                left join (select * from daily_snapshot.spree_products_taxons where date(spree_timestamp) = (select max(date(spree_timestamp)) from daily_snapshot.spree_products_taxons)) i
                on a.id = i.product_id
                
                left join (select * from daily_snapshot.spree_taxons where date(spree_timestamp) = (select max(date(spree_timestamp)) from daily_snapshot.spree_taxons)) j
                on i.taxon_id = j.id
                
                where a.available_on is not null -- product has a start date
                and j.taxonomy_id = 1) -- only include the taxonomy department
        
        group by 1

     sql_trigger_value: SELECT COUNT(*) FROM daily_snapshot.spree_products
     distkey: ean
     sortkeys: [ean]


  fields:

     - dimension: ean
       sql: ${TABLE}.ean

     - dimension: style
       sql: ${TABLE}.style
      
     - dimension: option
       sql: ${TABLE}.option
       
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
    
     - dimension_group: available_on
       type: time
       timeframes: [date, week, month]
       sql: ${TABLE}.available_on
    
     - dimension: image_location
       sql: ${TABLE}.option_image
       
     - dimension: online_flag
       type: yesno
       sql: ${TABLE}.online_flag = 'Yes'

# measures

     - measure: image
       type: string
       sql: max(${image_location})
       html: |
          <img src="https://assets.finerylondon.com/spree/products/{{value}}" height="130" width="86"/>

     - measure: skus_online
       type: count_distinct
       sql: ${ean}
       filters:
        online_flag: Yes 
        
     - measure: options_online
       type: count_distinct
       sql: ${option}
       filters:
        online_flag: Yes 
       
     - measure: styles_online
       type: count_distinct
       sql: ${style}
       filters:
        online_flag: Yes 
    

