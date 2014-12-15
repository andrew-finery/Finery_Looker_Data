- view: online_products
# View of all products currently live on the website

  derived_table:
     sql: |
       select
        a.id as product_id,
        a.name as style,
        a.description as product_description,
        a.available_on as available_on,
        b.id as variant_id,
        b.sku as ean,
        c.amount as current_price,
        case when d.origin_id is null then d.id else d.origin_id end as image_origin_id,
        h.origin_id as master_origin_id,
        d.attachment_file_name,
        f.colour,
        g.size,
        a.name || ' ' || coalesce(f.colour, '') as option
        
        
        
        from
        (select * from daily_snapshot.spree_products where date(spree_timestamp) = current_date) a
        
        inner join
        (select * from daily_snapshot.spree_variants where date(spree_timestamp) = current_date and is_master <>1) b
        on a.id = b.product_id
        
        left join
        (select variant_id, amount from (select * from daily_snapshot.spree_prices where date(spree_timestamp) = current_date) where currency = 'GBP' and deleted_at is null group  by 1,2) c
        on c.variant_id = b.id
        
        left join
            (select bbb.id, bbb.viewable_id as variant_id, bbb.attachment_file_name, bbb.origin_id from
              (select viewable_id, min("position") as "position" from (select * from daily_snapshot.spree_assets where date(spree_timestamp) = current_date and viewable_type = 'Spree::Variant') group by 1) aaa
              inner join
              (select * from daily_snapshot.spree_assets where date(spree_timestamp) = current_date) bbb
              on aaa.viewable_id = bbb.viewable_id and aaa."position" = bbb."position") d
        on d.variant_id = b.id
        
        left join
            (select aaa.variant_id, bbb.name as colour from
              (select * from daily_snapshot.spree_option_values_variants where date(spree_timestamp) = current_date) aaa
              left join
              (select * from daily_snapshot.spree_option_values where date(spree_timestamp) = current_date) bbb
              on aaa.option_value_id = bbb.id
              left join
              (select * from daily_snapshot.spree_option_types where date(spree_timestamp) = current_date) ccc
              on bbb.option_type_id = ccc.id
              where ccc.id = 3) f --only return the colour
        
        on b.id = f.variant_id
        
        left join
            (select aaa.variant_id, max(bbb.name) as size from
              (select * from daily_snapshot.spree_option_values_variants where date(spree_timestamp) = current_date) aaa
              left join
              (select * from daily_snapshot.spree_option_values where date(spree_timestamp) = current_date) bbb
              on aaa.option_value_id = bbb.id
              left join
              (select * from daily_snapshot.spree_option_types where date(spree_timestamp) = current_date) ccc
              on bbb.option_type_id = ccc.id
              where ccc.id <> 3 -- get the size
              group by 1) g
        
        on b.id = g.variant_id
        
        left join
        (select attachment_file_name, case when max(origin_id)is null then max(id) else max(origin_id) end as origin_id from 
        (select * from daily_snapshot.spree_assets where date(spree_timestamp) = current_date)
        group by 1) h
        on d.attachment_file_name = h.attachment_file_name
        
        where date(a.available_on) <= current_date --available before today
        and a.deleted_at is null -- product hasn't been deleted
        and b.deleted_at is null -- variant hasn't been deleted

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
    
     - dimension: size
       sql: ${TABLE}.size

     - dimension: origin_id
       sql: ${TABLE}.master_origin_id
       
     - dimension: attachment_file_name
       sql: ${TABLE}.attachment_file_name

     - dimension_group: available_on
       type: time
       timeframes: [date, week, month]
       sql: ${TABLE}.available_on
    
     - dimension: image_location
       type: string
       sql: ${origin_id} || '/single/' || ${attachment_file_name}

# measures

     - measure: image
       type: string
       sql: max(${image_location})
       html: |
          <img src="https://assets.finerylondon.com/spree/products/{{value}}" height="130" width="86"/>

       
     - measure: number_of_skus
       type: count_distinct
       sql: ${ean}
    

