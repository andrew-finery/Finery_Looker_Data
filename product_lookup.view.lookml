- view: product_lookup
  derived_table:
   sql: |
        select * from finery.brightpearl_export bp
        left join (select parent_sku as online_parent_sku, max(style_name) as online_style_name, max(max_price) as max_price, max(current_price) as current_price from ${spree_products.SQL_TABLE_NAME} group by 1) prices
        on bp.parent_sku = prices.online_parent_sku

   sql_trigger_value: SELECT count(*) from ${spree_products.SQL_TABLE_NAME}
   distkey: ean
   sortkeys: [ean]
     
     
  fields:

  - dimension: allocated
    sql: ${TABLE}.allocated
    hidden: true

  - dimension: category
    label: DEPARTMENT
    sql_case:
      Evening Dresses: ${TABLE}.category = 'Evening Dresses'
      Outerwear and Blazers: ${TABLE}.category = 'Outerwear & Blazers'
      Skirts: ${TABLE}.category = 'Skirts'
      Woven Tops: ${TABLE}.category = 'Woven Tops'
      Day Dresses: ${TABLE}.category = 'Day Dresses'
      Shoes: ${TABLE}.category = 'Shoes'
      Knitwear: ${TABLE}.category = 'Knitwear'
      Trousers and Shorts: ${TABLE}.category = 'Trousers & Shorts'
      Jersey Tops: ${TABLE}.category = 'Jersey Tops'
      Accessories: ${TABLE}.category = 'Accessories'
      Jewellery: ${TABLE}.category = 'Jewellery'
      else: 'Other'
    html: |
        <a href="https://finerylondon.looker.com/explore/finery_data/daily_sales?show=data,fields&vis=%7B%22type%22:%22looker_column%22%7D&query=fqvpV63&filter_config=%7B%22product_lookup.category%22:%5B%7B%22type%22:%22is%22,%22values%22:%5B%7B%22constant%22:%22{{value}}%22%7D,%7B%7D%5D,%22id%22:5%7D%5D%7D&f%5Bproduct_lookup.category%5D={{value}}&run=1">{{value}}</a>
  
  - dimension: product_area
    label: PRODUCT AREA
    sql_case:
      Clothing: ${TABLE}.category in ('Evening Dresses', 'Outerwear & Blazers', 'Skirts', 'Woven Tops', 'Day Dresses', 'Knitwear', 'Trousers & Shorts', 'Jersey Tops')
      Non-Clothing: ${TABLE}.category in ('Accessories', 'Shoes', 'Jewellery')
      else: 'Other'

  - dimension: colour_group
    label: BP_COLOUR
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
    label: EAN
    sql: ${TABLE}.ean
    
  - dimension_group: ex_factory
    type: time
    timeframes: [date, week, month]
    convert_tz: false
    sql: ${TABLE}.ex_factory_date
    hidden: true
    
  - dimension_group: expected_delivery_date_first_batch
    type: time
    label: EXPECTED DELIVERY
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
    label: FACTORY
    sql: ${TABLE}.factory

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
    label: BP_STYLE
    sql: ${TABLE}.name
    html: |
        <a href="https://finerylondon.looker.com/explore/finery_data/daily_sales?show=data,fields&vis=%7B%22type%22:%22looker_column%22%7D&query=mcBbKm7&filter_config=%7B%22product_lookup.style%22:%5B%7B%22type%22:%22%3D%22,%22values%22:%5B%7B%22constant%22:%22{{value}}%22%7D,%7B%7D%5D,%22id%22:6%7D%5D%7D&f%5Bproduct_lookup.style%5D=%22{{value}}%22&run=1">{{value}}</a>
  
  - dimension: option_name
    label: BP_OPTION
    sql: ${TABLE}.name||' - '||${TABLE}.colour_group
    html: |
        <a href="https://finerylondon.looker.com/explore/finery_data/daily_sales?show=data,fields&vis=%7B%22type%22:%22looker_column%22%7D&query=M2XQ72k&filter_config=%7B%22product_lookup.option_name%22:%5B%7B%22type%22:%22%3D%22,%22values%22:%5B%7B%22constant%22:%22{{value}}%22%7D,%7B%7D%5D,%22id%22:7%7D%5D%7D&f%5Bproduct_lookup.option_name%5D=%22{{value}}%22&run=1">{{value}}</a>
  
  - dimension: model_name
    label: MODEL NAME
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
    label: PARENT SKU
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
    label: BP_SIZE
    sql: ${TABLE}.size

  - dimension: sku
    sql: ${TABLE}.sku
    hidden: true
    
  - dimension: sub_season_code
    label: SUB-SEASON
    sql: ${TABLE}.sub_season_code

  - dimension: total_landed_cost_gbp
    type: number
    decimals: 2
    sql: ${TABLE}.total_landed_cost_gbp
    hidden: true

### Price Dimensions

  - dimension: max_selling_price
    label: ORIGINAL PRICE
    sql: coalesce(${TABLE}.max_price, round((${total_landed_cost_gbp} * ${retail_markup_inc_vat}), 0))
 
  - dimension: current_price
    label: CURRENT PRICE
    sql: coalesce(${TABLE}.current_price, round((${total_landed_cost_gbp} * ${retail_markup_inc_vat}), 0))
    
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
      0% - 7.5%: ${current_price}/${max_selling_price} > 0.925 or ${max_selling_price} = 0
      7.5% - 17.5%: ${current_price}/${max_selling_price} > 0.825
      17.5% - 27.5%: ${current_price}/${max_selling_price} > 0.725
      27.5% - 37.5%: ${current_price}/${max_selling_price} > 0.625
      37.5% and over: (${current_price}/${max_selling_price}) > 0 and (${current_price}/${max_selling_price}) <= 0.625
      else: '0% - 7.5%'