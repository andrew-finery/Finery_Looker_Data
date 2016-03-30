- view: product_info_options
  sql_table_name: sales.option_info


  fields:

########################################################################################################################################
############################################### DIMENSIONS #############################################################################
########################################################################################################################################

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
       
     - dimension: option
       label: Option
       sql: ${TABLE}.style_name || ' - ' ||  ${TABLE}.colour

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
       type: number
       decimals: 2
       sql: ${TABLE}.retail_price_gbp
       value_format: '##0.00'

     - dimension: first_price
       label: Maximum Price
       type: number
       decimals: 2
       sql: ${TABLE}.highest_retail_price_gbp

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
          Outerwear & Blazers: ${TABLE}.department = 'Outerwear & Blazers'
          Shoes: ${TABLE}.department = 'Shoes'
          Skirts: ${TABLE}.department = 'Skirts'
          Trousers & Shorts: ${TABLE}.department = 'Trousers & Shorts'
          Woven Day Dresses: ${TABLE}.department = 'Woven Day Dresses'
          Woven Tops: ${TABLE}.department = 'Woven Tops'
          else: 'Other'
  
     - dimension: product_area
       label: Product Area
       sql_case:
          Clothing: ${TABLE}.department in ('Woven Day Dresses', 'Trousers & Shorts', 'Woven Tops', 'Outerwear & Blazers', 'Knitwear', 'Jersey Tops', 'Occasion Dresses', 'Skirts', 'Jumpsuits', 'Jersey Day Dresses')
          #Clothing: ${TABLE}.category in ('Day Dresses', 'Trousers & Shorts', 'Woven Tops', 'Outerwear & Blazers', 'Knitwear', 'Jersey Tops', 'Evening Dresses', 'Skirts')
          Non-Clothing: ${TABLE}.department in ('Accessories', 'Shoes', 'Jewellery')
          else: 'Other'
 
     - dimension: sub_season
       label: Sub-Season
       sql: ${TABLE}.sub_season_code
    
     - dimension: factory
       label: Factory
       sql: ${TABLE}.factory
    
     - dimension: supplier
       label: Supplier
       sql: |
            case
            when ${factory} in  ('Alvex', 'Alvex Ltd')  then  'Alvex LTD'
            when ${factory} in  ('Anglo Union') then  'Anglo Union'
            when ${factory} in  ('Apparels Connection') then  'Apparels Connection'
            when ${factory} in  ('APPRIVA TEKSTIL') then  'Appriva Tekstil'
            when ${factory} in  ('SC Rojin Textile SRL - Blue Clothing','SC Rojin Textile SRL - Blue Clothing ','Micheal.com','SC Rojin Textile SRL') then  'Blue Clothing'
            when ${factory} in  ('Fashion Enter') then  'Fashion Enter Ltd'
            when ${factory} in  ('For You Fashions','For You Fashion')  then  'For You Fashion'
            when ${factory} in  ('Gemini Clothing') then  'Gemini'
            when ${factory} in  ('India Fashion','India Fashions')  then  'India Fashion'
            when ${factory} in  ('Indigo')  then  'Indigo'
            when ${factory} in  ('Legend Creations')  then  'Legend Creations'
            when ${factory} in  ('Loaded')  then  'Loaded'
            when ${factory} in  ('ZST') then  'Luna and Smith Ltd'
            when ${factory} in  ('Lara Fashions') then  'Lara Fashions'
            when ${factory} in  ('Dongguan Neo-Oct Knitwear Co., Ltd')  then  'Neo Concept'
            when ${factory} in  ('Zen','Solda','Affinity','Ecomoda','Eccomoda','Violetta','Elegance','Ekemoda','PC Clothing') then  'PC Clothing'
            when ${factory} in  ('Mode Tekstil','Signature')  then  'Signature'
            when ${factory} in  ('Stiletto')  then  'Stiletto'
            when ${factory} in  ('Starpro Ltd') then  'Starpro'
            when ${factory} in  ('Stanca Aurelia')  then  'Stanca Aurelia'
            when ${factory} in  ('cn fty','Deqing Perrie Garments Co., Ltd','Twisted Sister Ltd','Twisted Sister')  then  'Twisted Sister Ltd'
            when ${factory} in  ('Nesan') then  'ZD - Bati Triko'
            when ${factory} in  ('Bati', 'KARAHAN TEKSTIL') then  'ZD - Karahan Tekstil '
            when ${factory} in  ('Camilton','Camilton ')  then  'Camilton'
            when ${factory} in  ('Feetcare','Feetcare ltd') then  'Feetcare'
            when ${factory} in  ('Heitor')  then  'Heitor'
            when ${factory} in  ('Humat Spain S.L') then  'Humat Spain S.L'
            when ${factory} in  ('Michael.com') then  'Michael.com'
            when ${factory} in  ('R.D.Traders PVT LTD') then  'R.D.Traders PVT LTD'
            when ${factory} in  ('Vision East') then  'Vision East '
            when ${factory} in  ('Rhythm London Ltd') then  'Rhythm London Ltd'
            when ${factory} in  ('Gold Point')  then  'Gold Point'
            when ${factory} in  ('DNC Jewelry', 'DNC Jewelry ') then  'DNC Jewelry '
            when ${factory} in  ('KC')  then  'Kc Paul Qingdao Co. Ltd '
            when ${factory} in  ('H.Gaventa','H.Gaventa ltd') then  'H.Gaventa'
            when ${factory} in  ('Zhangjiagang Asisancharm Garment Co Ltd') then  'Zhangjiagang Asisancharm Garment Co Ltd'
            when ${factory} in  ('Gold Point')  then  'Gold Point'
            when ${factory} in  ('Ardy')  then  'Ardy'
            when ${factory} in  ('Rise Designs')  then  'Rise Designs'
            when ${factory} in  ('New Fashion') then  'New Fashion'
            when ${factory} in  ('J G Belts') then  'J G Belts'
            else ${factory} end
  
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

     - dimension: packshot_image
       label: DPA Product Image
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
    
     - dimension: size_availability
       type: number
       sql: ${sizes_in_stock}/nullif(${sizes_online},0)::REAL
       value_format: '0%'
      
     - dimension: return_rate
       type: number
       sql: |
            case
            when ${items_sold_b4_28_days_ago} < 10 then null
            else ${items_returned_b4_28_days_ago}/nullif(${items_sold_b4_28_days_ago},0)::REAL
            end
       value_format: '0%'
       
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

