- view: product_info_options
  derived_table:
    sql: |
          select * from sales.option_info a
          left join (select product_id as product_id_2, model_name, background_colour from finery.product_shoot_information) b
          on a.product_id = b.product_id_2


  fields:

########################################################################################################################################
############################################### DIMENSIONS #############################################################################
########################################################################################################################################

     
     - dimension: google_category
       type: string
       sql: |
            case
            when ${category} = 'Accessories' then 'Clothing & Accessories > Clothing Accessories' 
            when ${category} = 'Jersey Day Dresses' then 'Clothing & Accessories > Clothing > Dresses' 
            when ${category} = 'Jersey Tops' then 'Clothing & Accessories > Clothing > Shirts & Tops' 
            when ${category} = 'Jewellery' then 'Clothing & Accessories > Jewellery & Watches' 
            when ${category} = 'Jumpsuits' then 'Clothing & Accessories > Clothing > One-Pieces' 
            when ${category} = 'Knitwear' then 'Clothing & Accessories > Clothing > Shirts & Tops' 
            when ${category} = 'Leather' then 'Clothing & Accessories > Clothing'
            when ${category} = 'Occasion Dresses' then 'Clothing & Accessories > Clothing > Dresses' 
            when ${category} = 'Other' then 'Clothing & Accessories > Clothing' 
            when ${category} = 'Outerwear & Blazers' then 'Clothing & Accessories > Clothing > Outerwear'
            when ${category} = 'Shoes' then 'Clothing & Accessories > Shoes'
            when ${category} = 'Skirts' then 'Clothing & Accessories > Clothing > Skirts' 
            when ${category} = 'Swimwear' then 'Clothing & Accessories > Clothing > Swimwear'
            when ${category} = 'Trousers & Shorts' then 'Clothing & Accessories > Clothing' 
            when ${category} = 'Woven Day Dresses' then 'Clothing & Accessories > Clothing > Dresses' 
            when ${category} = 'Woven Tops' then 'Clothing & Accessories > Clothing > Shirts & Tops' 
            
            end
            
     
          
     - dimension: description
       label: Description
       sql: ${TABLE}.description
       
     - dimension: style
       label: Style
       sql: ${TABLE}.style_name

     - dimension: product_id
       sql: ${TABLE}.product_id
       
     - dimension: product_group_id
       sql: ${TABLE}.product_group_id
       hidden: true

     - dimension: parent_sku
       sql: ${TABLE}.bp_style_id

     - dimension: option_id
       sql: ${TABLE}.option_id

     - dimension: slug
       sql: ${TABLE}.slug

     - dimension: option
       sql: ${TABLE}.option_name

     - dimension: shorthand_name
       sql: ${TABLE}.shorthand_name

     - dimension: facebook_product_name
       sql: coalesce(nullif(${shorthand_name}, ''), ${style})

     - dimension: shorthand_name_first_word
       sql: ${TABLE}.shorthand_name_first_word

     - dimension: shorthand_name_second_word
       sql: ${TABLE}.shorthand_name_second_word

     - dimension: bp_option
       label: BP Option
       sql: ${TABLE}.bp_option

     - dimension: option_for_returns_report
       label: Option
       sql: ${option}
       html: |
               <a href="https://finerylondon.looker.com/explore/finery_data/spree_returns?dynamic_fields=%5B%5D&f%5Bspree_returns.returned_at_date%5D=yesterday&filter_config=%7B%22online_products.option_for_returns_report%22:%5B%7B%22type%22:%22%3D%22,%22values%22:%5B%7B%22constant%22:{{value}}7D,%7B%7D%5D,%22id%22:0%7D%5D,%22spree_returns.returned_at_date%22:%5B%7B%22type%22:%22advanced%22,%22values%22:%5B%7B%22constant%22:%22yesterday%22%7D,%7B%7D%5D,%22id%22:1%7D%5D%7D&%20Black,%7B%7D%5D,%22id%22:1%7D%5D,%22spree_returns.returned_at_date%22:%5B%7B%22type%22:%22advanced%22,%22values%22:%5B%7B%22date%22:%222015-04-23T08:59:11.258Z%22,%22unit%22:%22day%22,%22constant%22:%22yesterday%22%7D,%7B%7D%5D,%22id%22:0%7D%5D%7D&query=BtN4vDw&vis_config=%7B%22type%22:%22looker_column%22%7D&visible_ui_sections=data&show=data,fields&vis=%7B%22type%22:%22looker_column%22%7D&f%5Bonline_products.option_for_returns_report%5D={{value}}">{{value}}</a>
       hidden: true
       
     - dimension: colour_group
       label: Colour Group
       sql: ${TABLE}.colour_group
       
     - dimension: colour
       label: Colour
       sql: ${TABLE}.colour

     - dimension: current_price_gbp
       label: Current Price
       group_label: 'Prices'
       type: number
       sql: ${TABLE}.retail_price_gbp
       value_format: '##0'

     - dimension: current_price_usd
       group_label: 'Prices'
       type: number
       sql: ${TABLE}.retail_price_usd
       value_format: '##0'
      
     - dimension: current_price_cad
       group_label: 'Prices'
       type: number
       sql: ${TABLE}.retail_price_cad
       value_format: '##0'

     - dimension: current_price_aed
       group_label: 'Prices'
       type: number
       sql: ${TABLE}.retail_price_aed
       value_format: '##0'

     - dimension: current_price_aud
       group_label: 'Prices'
       type: number
       sql: ${TABLE}.retail_price_aud
       value_format: '##0'

     - dimension: current_price_hkd
       group_label: 'Prices'
       type: number
       sql: ${TABLE}.retail_price_hkd
       value_format: '##0'

     - dimension: current_price_eur
       group_label: 'Prices'
       type: number
       sql: ${TABLE}.retail_price_eur
       value_format: '##0'

     - dimension: pre_sale_price_usd
       group_label: 'Prices'
       type: number
       sql: ${TABLE}.pre_sale_price_usd
       value_format: '##0'
       
     - dimension: pre_sale_price_cad
       group_label: 'Prices'
       type: number
       sql: ${TABLE}.pre_sale_price_cad
       value_format: '##0'
       
     - dimension: pre_sale_price_aed
       group_label: 'Prices'
       type: number
       sql: ${TABLE}.pre_sale_price_aed
       value_format: '##0'
       
     - dimension: pre_sale_price_aud
       group_label: 'Prices'
       type: number
       sql: ${TABLE}.pre_sale_price_aud
       value_format: '##0'
       
     - dimension: pre_sale_price_sgd
       group_label: 'Prices'
       type: number
       sql: ${TABLE}.pre_sale_price_sgd
       value_format: '##0'
       
     - dimension: pre_sale_price_hkd
       group_label: 'Prices'
       type: number
       sql: ${TABLE}.pre_sale_price_hkd
       value_format: '##0'

     - dimension: pre_sale_price_eur
       group_label: 'Prices'
       type: number
       sql: ${TABLE}.pre_sale_price_eur
       value_format: '##0'

     - dimension: first_price
       label: Maximum Price
       group_label: 'Prices'
       type: number
       sql: ${TABLE}.highest_retail_price_gbp

     - dimension: pre_sale_price
       label: Pre-Sale Price
       group_label: 'Prices'
       type: number
       sql: ${TABLE}.pre_sale_price
      
     - dimension: max_price
       label: Original Price
       group_label: 'Prices'
       type: number
       sql: coalesce(${pre_sale_price}, ${first_price})
     
     - dimension: on_sale_flag
       label: Currently on Sale Flag
       sql: case when ${pre_sale_price} is not null and ${pre_sale_price} > ${current_price_gbp} then 'On Sale' else 'Full Price' end

     - dimension_group: on_sale
       label: On Sale
       type: time
       timeframes: [date]
       sql: ${TABLE}.first_on_sale_date
      
     - dimension_group: available_on
       type: time
       timeframes: [date, week, month]
       sql: ${TABLE}.available_on_spree
       
     - dimension: weeks_online
       label: Weeks Online
       sql: case when ${TABLE}.online_flag = 'No' then 0 else cast(CURRENT_DATE - date(${TABLE}.available_on_spree) as integer) / 7 end

     - dimension: days_online
       label: Days Online
       sql: case when ${TABLE}.online_flag = 'No' then 0 else cast(CURRENT_DATE - date(${TABLE}.available_on_spree) as integer) end

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
       sql: ${TABLE}.coming_soon_spree = 'true' or ${TABLE}.display_rule_spree in (1,2,3)
     
     - dimension: option_image
       label: Option Image
       type: string
       sql: ${TABLE}.option_image
       html: |
          <img src="https://assets.finerylondon.com/spree/products/{{value}}" height="130" width="86"/>

     - dimension: image_model_name
       sql: initcap(${TABLE}.model_name)

     - dimension: image_background_colour
       sql: initcap(${TABLE}.background_colour)

     - dimension: category
       label: Department
       sql_case:
          Accessories: ${TABLE}.department = 'Accessories'
          Jersey Day Dresses: ${TABLE}.department = 'Jersey Day Dresses'
          Jersey Tops: ${TABLE}.department = 'Jersey Tops'
          Jewellery: ${TABLE}.department = 'Jewellery'
          Jumpsuits: ${TABLE}.department = 'Jumpsuits'
          Knitwear: ${TABLE}.department = 'Knitwear'
          Occasion Dresses: ${TABLE}.department = 'Occasion Dresses'
          Outerwear & Blazers: ${TABLE}.department = 'Outerwear'
          Shoes: ${TABLE}.department = 'Shoes'
          Skirts: ${TABLE}.department = 'Skirts'
          Trousers & Shorts: ${TABLE}.department = 'Trousers & Shorts'
          Woven Day Dresses: ${TABLE}.department = 'Woven Day Dresses'
          Woven Tops: ${TABLE}.department = 'Woven Tops'
          Swimwear: ${TABLE}.department = 'Swimwear'
          Leather: ${TABLE}.department = 'Leather'
          else: 'Other'
     
     - dimension: big_department
       sql: ${TABLE}.big_department
      
        
     - dimension: product_area
       label: Product Area
       sql_case:
          Clothing: ${TABLE}.department in ('Woven Day Dresses', 'Trousers & Shorts', 'Woven Tops', 'Outerwear & Blazers', 'Knitwear', 'Jersey Tops', 'Occasion Dresses', 'Skirts', 'Jumpsuits', 'Jersey Day Dresses', 'Leather', 'Outerwear', 'Swimwear')
          Non-Clothing: ${TABLE}.department in ('Accessories', 'Shoes', 'Jewellery')
          else: 'Other'
 
     - dimension: sub_season
       label: Main Season
       sql: ${TABLE}.sub_season_code
     
     - dimension: main_season_group
       sql_case: 
         New: ${sub_season} = 'AW17'
         Current: ${sub_season} = 'SS17'
         Previous: ${sub_season} = 'AW16'
         else: 'Old'
     
     - dimension: category_type
       sql: ${TABLE}.category_type
     
     - dimension: sub_season_2
       label: Sub Season
       sql: ${TABLE}.sub_season
       
     - dimension: colour_group_zedonk
       sql: ${TABLE}.colour_group_2
       
     - dimension: washcare_instructions
       sql: ${TABLE}.washcare_instructions
       
     - dimension: factory
       label: Factory
       sql: ${TABLE}.factory
    
     - dimension: supplier
       label: Supplier
       sql: ${factory}
  
     - dimension: selling_price_tiered
       label: Current Price Tier
       sql_case:
        £0 - £20: ${current_price_gbp} < 20
        £20 - £40: ${current_price_gbp} < 40
        £40 - £60: ${current_price_gbp} < 60
        £60 - £80: ${current_price_gbp} < 80
        £80 - £100: ${current_price_gbp} < 100
        £100 - £150: ${current_price_gbp} < 150
        £150 - £200: ${current_price_gbp} < 200
        £200 - £300: ${current_price_gbp} < 300
        else: '£300 and over'

     - dimension: selling_price_tiered_10
       label: Current Price Tier (£10)
       sql_case:
        £0 - £10: ${current_price_gbp} < 10
        £10 - £20: ${current_price_gbp} < 20
        £20 - £30: ${current_price_gbp} < 30
        £30 - £40: ${current_price_gbp} < 40
        £40 - £50: ${current_price_gbp} < 50
        £50 - £60: ${current_price_gbp} < 60
        £60 - £70: ${current_price_gbp} < 70
        £70 - £80: ${current_price_gbp} < 80
        £80 - £90: ${current_price_gbp} < 90
        £90 - £100: ${current_price_gbp} < 100
        £100 - £110: ${current_price_gbp} < 110
        £110 - £120: ${current_price_gbp} < 120
        £120 - £130: ${current_price_gbp} < 130
        £130 - £140: ${current_price_gbp} < 140
        £140 - £150: ${current_price_gbp} < 150
        £150 - £300: ${current_price_gbp} < 300
        else: '£300 and over'
    
     - dimension: discount_level_tier
       label: Discount Level Tier
       sql_case:
        0% - 7.5%: ${current_price_gbp}/${max_price} > 0.925 or ${max_price} = 0
        7.5% - 17.5%: ${current_price_gbp}/${max_price} > 0.825
        17.5% - 27.5%: ${current_price_gbp}/${max_price} > 0.725
        27.5% - 37.5%: ${current_price_gbp}/${max_price} > 0.625
        37.5% and over: (${current_price_gbp}/${max_price}) > 0 and (${current_price_gbp}/${max_price}) <= 0.625
        else: '0% - 7.5%'

     - dimension: dpa_image
       label: DPA Product Image
       type: string
       sql: ${TABLE}.facebook_image_location
       html: |
            <img src="{{value}}" height="130" width="130"/>

     - dimension: number_of_dpa_feed_images
       label: Number of DPA Images
       sql: ${TABLE}.facebook_images
       
     - dimension: instagram_image
       label: Instagram Product Image
       type: string
       sql: ${TABLE}.instagram_image_location
       html: |
            <img src="{{value}}" height="130" width="130"/>

     - dimension: number_of_instagram_feed_images
       label: Number of Instagram Images
       sql: ${TABLE}.instagram_images

     - dimension: packshot_image
       label: DPA Packshot Product Image
       type: string
       sql: ${TABLE}.packshot_image_location
       html: |
            <img src="{{value}}" height="130" width="130"/>
            
     - dimension: number_of_packshot_images
       label: Number of Packshot Images
       sql: ${TABLE}.packshot_images

     - dimension: sizes_online
       sql: ${TABLE}.variants_in_spree
  
     - dimension: sizes_in_stock
       sql: ${TABLE}.variants_in_stock
      
     - dimension: units_in_stock
       sql: ${TABLE}.stock_on_hand
    
     - dimension: items_sold_b4_28_days_ago
       sql: ${TABLE}.items_sold_b4_28_days_ago
  
     - dimension: items_returned_b4_28_days_ago
       sql: ${TABLE}.items_returned_b4_28_days_ago

     - dimension: related_products
       sql: ${TABLE}.related_products_string
    
     - dimension: size_availability
       type: number
       decimals: 4
       sql: coalesce((${sizes_in_stock}/nullif(${sizes_online},0)::REAL), 0)
       value_format: '0%'
      
     - dimension: return_rate
       type: number
       sql: |
            case
            when ${items_sold_b4_28_days_ago} < 10 then null
            else ${items_returned_b4_28_days_ago}/nullif(${items_sold_b4_28_days_ago},0)::REAL
            end
       value_format: '0%'

## DISPLAY FEED DIMENSIONS
       
     - dimension: unique_id
       sql: ${product_id}
       group_label: Display Feed
     
     - dimension: reporting_label
       sql: ${shorthand_name} || '_' || ${product_id}
       group_label: Display Feed
     
     - dimension: is_active_ecom
       sql: | 
            case
            when (${online_flag}
                  and ${size_availability} >= 0.5
                  and ${units_in_stock} > 0
                  and not ${coming_soon_flag}
                  and ${dpa_image} is not null) then 'TRUE'
            else 'FALSE' end
       group_label: Display Feed

     - dimension: is_active_packshot
       sql: | 
            case
            when (${online_flag}
                  and ${size_availability} >= 0.5
                  and ${units_in_stock} > 0
                  and not ${coming_soon_flag}
                  and ${packshot_image} is not null) then 'TRUE'
            else 'FALSE' end
       group_label: Display Feed
       
     - dimension: fallback_ecom
       sql: ${is_active_ecom}
       group_label: Display Feed

     - dimension: fallback_packshot
       sql: ${is_active_packshot}
       group_label: Display Feed
       
    # clarify what fallback means
     
     - dimension: display_feed_product_link
       sql: | 
            case when ${on_sale_flag} = 'On Sale' then 'https://www.finerylondon.com/t/final-call/?pin_products=' || ${product_id}
            else 'https://www.finerylondon.com/t/new-collection/?pin_products=' || ${product_id}
            end
       group_label: Display Feed
     
     - dimension: is_default_ecom
       sql: | 
              case when ${product_id} = (select MIN (product_id) from sales.option_info
                                          where online_flag = 'Yes'
                                          and (coalesce((variants_in_stock/nullif(variants_in_spree,0)::REAL), 0)) >= 0.5
                                          and stock_on_hand > 0
                                          and option_info.coming_soon_spree != 'true'
                                          and option_info.display_rule_spree not in (1,2,3)
                                          and facebook_image_location is not null
                                          )
                   then 'TRUE' else 'FALSE' end
                                          
       group_label: Display Feed

     - dimension: is_default_packshot
       sql: | 
              case when ${product_id} = (select MIN (product_id) from sales.option_info
                                          where online_flag = 'Yes'
                                          and (coalesce((variants_in_stock/nullif(variants_in_spree,0)::REAL), 0)) >= 0.5
                                          and stock_on_hand > 0
                                          and option_info.coming_soon_spree != 'true'
                                          and option_info.display_rule_spree not in (1,2,3)
                                          and packshot_image_location is not null
                                          )
                   then 'TRUE' else 'FALSE' end
                                          
       group_label: Display Feed      
     
########################################################################################################################################
############################################### MEASURES #############################################################################
########################################################################################################################################
     - measure: nbr_weeks_online
       type: int
       sql: ${weeks_online}
    
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

