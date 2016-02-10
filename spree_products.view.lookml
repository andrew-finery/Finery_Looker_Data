- view: spree_products
  sql_table_name: info.option_info

  fields:

  - dimension: product_group_id
    sql: ${TABLE}.product_group_id
    hidden: true
      
  - dimension: product_id
    sql: ${TABLE}.product_id
    
  - dimension: colour
    label: Colour
    sql: ${TABLE}.colour

  - dimension: colour_group
    label: Colour Group
    sql: ${TABLE}.colour_group
    
  - dimension: style_name
    label: Style
    sql: ${TABLE}.style_name
    
  - dimension: option_name
    label: Option
    sql: case when ${colour} is null then ${style_name} else ${style_name} || ' ' || ${colour} end
    
  - dimension: current_price
    label: Current Price
    sql: ${TABLE}.current_price
    
  - dimension: max_price
    label: Original Price
    sql: ${TABLE}.max_price

  - dimension: on_sale_flag
    label: Currently On Sale?
    sql: ${TABLE}.on_sale_flag

  - dimension: parent_sku
    sql: ${TABLE}.parent_sku
    hidden: true
      
  - dimension: department
    sql: ${TABLE}.department
    
  - dimension: sub_season
    label: Sub-Season
    sql: ${TABLE}.sub_season_code
    
  - dimension: product_area
    label: Product Area
    sql: ${TABLE}.product_area
    
  - dimension: selling_price_tiered
    label: Price Band
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
    label: Discount Band
    sql_case:
      0% - 7.5%: ${current_price}/${max_price} > 0.925 or ${max_price} = 0
      7.5% - 17.5%: ${current_price}/${max_price} > 0.825
      17.5% - 27.5%: ${current_price}/${max_price} > 0.725
      27.5% - 37.5%: ${current_price}/${max_price} > 0.625
      37.5% and over: (${current_price}/${max_price}) > 0 and (${current_price}/${max_price}) <= 0.625
      else: '0% - 7.5%'

  - dimension: dpa_image
    label: DPA Product Image
    type: string
    sql: ${TABLE}.option_image
    html: |
          <img src="https://assets.finerylondon.com/spree/products/{{value}}" height="130" width="130"/>
          
  - dimension: number_of_dpa_feed_images
    label: Number of DPA Images
    sql: ${TABLE}.number_images
    
  - dimension: product_shown_on_site
    type: yesno
    sql: |
          ${TABLE}.deleted_at is null
          and ${TABLE}.is_live = true
          and date(${TABLE}.available_on) <= current_date 
  
  
  
      
      