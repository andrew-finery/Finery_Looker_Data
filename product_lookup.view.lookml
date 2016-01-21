- view: product_lookup
  derived_table:
   sql: |
        select * from finery.brightpearl_export_new bp
        left join (select ean as ean2, current_price, coalesce(pre_sale_price, max_price) as original_price from web.product_info) prices
        on bp.ean = prices.ean2

   sql_trigger_value: SELECT count(*) from web.product_info
   distkey: ean
   sortkeys: [ean]
     
     
  fields:

  - dimension: allocated
    sql: ${TABLE}.allocated
    hidden: true

  - dimension: category
    label: Department
    sql_case:
      Accessories: ${TABLE}.category = 'Accessories'
      Jersey Day Dresses: ${TABLE}.category = 'Jersey Day Dresses'
      Jersey Tops: ${TABLE}.category = 'Jersey Tops'
      Jewellery: ${TABLE}.category = 'Jewellery'
      Jumpsuits: ${TABLE}.category = 'Jumpsuits'
      Knitwear: ${TABLE}.category = 'Knitwear'
      Occasion Dresses: ${TABLE}.category = 'Occasion Dresses'
      Outerwear & Blazers: ${TABLE}.category = 'Outerwear & Blazers'
      Shoes: ${TABLE}.category = 'Shoes'
      Skirts: ${TABLE}.category = 'Skirts'
      Trousers & Shorts: ${TABLE}.category = 'Trousers & Shorts'
      Woven Day Dresses: ${TABLE}.category = 'Woven Day Dresses'
      Woven Tops: ${TABLE}.category = 'Woven Tops'
      else: 'Other'

  #- dimension: category
  #  label: Department
  #  sql_case:
  #    Accessories: ${TABLE}.category = 'Accessories'
  #    Day Dresses: ${TABLE}.category = 'Day Dresses'
  #    Jersey Tops: ${TABLE}.category = 'Jersey Tops'
  #    Jewellery: ${TABLE}.category = 'Jewellery'
  #    Knitwear: ${TABLE}.category = 'Knitwear'
  #    Evening Dresses: ${TABLE}.category = 'Evening Dresses'
  #    Outerwear and Blazers: ${TABLE}.category = 'Outerwear & Blazers'
  #    Shoes: ${TABLE}.category = 'Shoes'
  #    Skirts: ${TABLE}.category = 'Skirts'
  #    Trousers and Shorts: ${TABLE}.category = 'Trousers & Shorts'
  #    Woven Tops: ${TABLE}.category = 'Woven Tops'
  #    else: 'Other'
  #  html: |
  #      <a href="https://finerylondon.looker.com/explore/finery_data/daily_sales?show=data,fields&vis=%7B%22type%22:%22looker_column%22%7D&query=fqvpV63&filter_config=%7B%22product_lookup.category%22:%5B%7B%22type%22:%22is%22,%22values%22:%5B%7B%22constant%22:%22{{value}}%22%7D,%7B%7D%5D,%22id%22:5%7D%5D%7D&f%5Bproduct_lookup.category%5D={{value}}&run=1">{{value}}</a>

  
  - dimension: product_area
    label: Product Area
    sql_case:
      Clothing: ${TABLE}.category in ('Woven Day Dresses', 'Trousers & Shorts', 'Woven Tops', 'Outerwear & Blazers', 'Knitwear', 'Jersey Tops', 'Occasion Dresses', 'Skirts', 'Jumpsuits', 'Jersey Day Dresses')
      #Clothing: ${TABLE}.category in ('Day Dresses', 'Trousers & Shorts', 'Woven Tops', 'Outerwear & Blazers', 'Knitwear', 'Jersey Tops', 'Evening Dresses', 'Skirts')
      Non-Clothing: ${TABLE}.category in ('Accessories', 'Shoes', 'Jewellery')
      else: 'Other'

  - dimension: colour_group
    label: BP Colour
    sql: ${TABLE}.colour_group

  - dimension: design
    sql: ${TABLE}.design
    hidden: true

  - dimension: duty_gbp
    sql: ${TABLE}.duty_gbp
    hidden: true

  - dimension: duty_rate_perc
    sql: ${TABLE}.duty_rate_perc
    hidden: true
    
  - dimension: ean
    label: ean
    sql: ${TABLE}.ean
    
  - dimension_group: ex_factory
    type: time
    timeframes: [date, week, month]
    convert_tz: false
    sql: ${TABLE}.ex_factory_date
    hidden: true
    
  - dimension_group: expected_delivery_date_first_batch
    type: time
    label: Expected Delivery
    timeframes: [date, week, month]
    convert_tz: false
    sql: ${TABLE}.expected_delivery_date_first_batch

  - dimension_group: expected_delivery_date_second_batch
    type: time
    timeframes: [date, week, month]
    convert_tz: false
    sql: ${TABLE}.expected_delivery_date_second_batch
    hidden: true
    
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

  - dimension: freight_cost_gbp
    sql: ${TABLE}.freight_cost_gbp
    hidden: true    
    
  - dimension: incoterms
    sql: ${TABLE}.incoterms
    hidden: true
    
  - dimension: intake_margin_inc_vat
    sql: ${TABLE}.intake_margin_inc_vat
    hidden: true
    
  - dimension: length
    sql: ${TABLE}.length
    hidden: true
    
  - dimension: mode_of_transport
    sql: ${TABLE}.mode_of_transport
    hidden: true
    
  - dimension: style
    label: BP Style
    sql: ${TABLE}.name
    html: |
        <a href="https://finerylondon.looker.com/explore/finery_data/daily_sales?show=data,fields&vis=%7B%22type%22:%22looker_column%22%7D&query=mcBbKm7&filter_config=%7B%22product_lookup.style%22:%5B%7B%22type%22:%22%3D%22,%22values%22:%5B%7B%22constant%22:%22{{value}}%22%7D,%7B%7D%5D,%22id%22:6%7D%5D%7D&f%5Bproduct_lookup.style%5D=%22{{value}}%22&run=1">{{value}}</a>
  
  - dimension: option_name
    label: BP Option
    sql: ${TABLE}.name||' - '||${TABLE}.colour_group
    html: |
        <a href="https://finerylondon.looker.com/explore/finery_data/daily_sales?show=data,fields&vis=%7B%22type%22:%22looker_column%22%7D&query=M2XQ72k&filter_config=%7B%22product_lookup.option_name%22:%5B%7B%22type%22:%22%3D%22,%22values%22:%5B%7B%22constant%22:%22{{value}}%22%7D,%7B%7D%5D,%22id%22:7%7D%5D%7D&f%5Bproduct_lookup.option_name%5D=%22{{value}}%22&run=1">{{value}}</a>
  
  - dimension: model_name
    label: Model Name
    sql: ${TABLE}.model_name
  
  - dimension: new_or_repeat
    sql: ${TABLE}.new_or_repeat
    hidden: true
    
  - dimension: on_hand
    sql: ${TABLE}.on_hand
    hidden: true
    
  - dimension: on_order
    sql: ${TABLE}.on_order
    hidden: true
    
  - dimension_group: order_placement
    type: time
    timeframes: [date, week, month]
    convert_tz: false
    sql: ${TABLE}.order_placement_date
    hidden: true
    
  - dimension: parent_sku
    label: Parent SKU
    sql: ${TABLE}.parent_sku

  - dimension: product_type
    sql: ${TABLE}.product_type
    hidden: true
    
  - dimension: retail_markup_inc_vat
    type: number
    decimals: 2
    sql: case when ${TABLE}.retail_markup_inc_vat = ' ' then '0' else left(${TABLE}.retail_markup_inc_vat, charindex('.',${TABLE}.retail_markup_inc_vat) + 2) end
    hidden: true
    
  - dimension: size
    label: BP Size
    sql: ${TABLE}.size

  - dimension: sku
    sql: ${TABLE}.sku
    hidden: true
    
  - dimension: sub_season_code
    label: Sub-Season
    sql: ${TABLE}.sub_season_code

  - dimension: total_landed_cost_gbp
    type: number
    decimals: 2
    sql: ${TABLE}.total_landed_cost_gbp
    hidden: true

### Price Dimensions
  
  - dimension: retail_price
    sql: ${TABLE}.retail
  
  - dimension: max_selling_price
    label: Original Price
    sql: coalesce(${TABLE}.original_price, round((${retail_price}), 0))
 
  - dimension: current_price
    label: Current Price
    sql: coalesce(${TABLE}.current_price, round((${retail_price}), 0))
    
  - dimension: selling_price_tiered
    label: Current Price Tier
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
    label: Discount Level Tier
    sql_case:
      0% - 7.5%: ${current_price}/${max_selling_price} > 0.925 or ${max_selling_price} = 0
      7.5% - 17.5%: ${current_price}/${max_selling_price} > 0.825
      17.5% - 27.5%: ${current_price}/${max_selling_price} > 0.725
      27.5% - 37.5%: ${current_price}/${max_selling_price} > 0.625
      37.5% and over: (${current_price}/${max_selling_price}) > 0 and (${current_price}/${max_selling_price}) <= 0.625
      else: '0% - 7.5%'