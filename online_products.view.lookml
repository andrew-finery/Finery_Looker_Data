- view: online_products
  sql_table_name: web.product_info


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
       value_format: '##0.00'

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

