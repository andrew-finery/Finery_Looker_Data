- view: product_lookup
  sql_table_name: brightpearl.all_products
  fields:

  - dimension: allocated
    sql: ${TABLE}.allocated

  - dimension: back_neck_label
    sql: ${TABLE}.back_neck_label

  - dimension: bag_shape
    sql: ${TABLE}.bag_shape

  - dimension: brand1
    sql: ${TABLE}.brand1

  - dimension: buy_code
    sql: ${TABLE}.buy_code

  - dimension: category
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
        <a href="https://finerylondon.looker.com/explore/finery_data/sales_snapshot?show=data,fields&vis=%7B%22type%22:%22looker_column%22%7D&fields=product_lookup.style,sales_snapshot.sum_sales_yesterday_qty,sales_snapshot.sum_sales_yesterday,sales_snapshot.day_on_day,sales_snapshot.sum_sales_last_7_days_qty,sales_snapshot.sum_sales_last_7_days,sales_snapshot.sum_sales_last_28_days_qty,sales_snapshot.sum_sales_last_28_days,sales_snapshot.sum_count_on_hand_qty,sales_snapshot.sum_count_on_hand_gbp,sales_snapshot.avg_days_cover&sorts=sales_snapshot.sum_sales_yesterday+desc&limit=500&total=on&vis=%7B%22type%22:%22looker_column%22%7D&show=data,fields&title=Sales+by+Style+-+{{value}}&filter_config=%7B%22product_lookup.category%22:%5B%7B%22type%22:%22is%22,%22values%22:%5B%7B%22constant%22:%22{{value}}%22%7D,%7B%7D%5D,%22id%22:1%7D%5D%7D&f%5Bproduct_lookup.category%5D={{value}}&run=1">{{value}}</a>
  
  - dimension: product_area
    sql_case:
      Clothing: ${TABLE}.product_type = 'Apparel'
      Non-Clothing: ${TABLE}.product_type in ('Accessories', 'Shoes')
      else: 'Other'

  - dimension: cloth_composition
    sql: ${TABLE}.cloth_composition

  - dimension: colour_group
    sql: ${TABLE}.colour_group

  - dimension: commodity_code
    sql: ${TABLE}.commodity_code

  - dimension: country_of_origin
    sql: ${TABLE}.country_of_origin

  - dimension: delivery_notes
    sql: ${TABLE}.delivery_notes

  - dimension: depth
    sql: ${TABLE}.depth

  - dimension: design
    sql: ${TABLE}.design

  - dimension: design_colour
    sql: ${TABLE}.design_colour

  - dimension: disclaimer
    sql: ${TABLE}.disclaimer

  - dimension: duty_gbp
    sql: ${TABLE}.duty_gbp

  - dimension: duty_rate_perc
    sql: ${TABLE}.duty_rate_perc

  - dimension: ean
    sql: ${TABLE}.ean

  - dimension_group: ex_factory
    type: time
    timeframes: [date, week, month]
    convert_tz: false
    sql: ${TABLE}.ex_factory_date

  - dimension_group: expected_delivery_date_first_batch
    type: time
    timeframes: [date, week, month]
    convert_tz: false
    sql: ${TABLE}.expected_delivery_date_first_batch

  - dimension_group: expected_delivery_date_second_batch
    type: time
    timeframes: [date, week, month]
    convert_tz: false
    sql: ${TABLE}.expected_delivery_date_second_batch

  - dimension: fabric
    sql: ${TABLE}.fabric

  - dimension: factory
    sql: ${TABLE}.factory

  - dimension: freight_cost_gbp
    sql: ${TABLE}.freight_cost_gbp

  - dimension: height
    sql: ${TABLE}.height

  - dimension: in_stock
    sql: ${TABLE}.in_stock

  - dimension: incoterms
    sql: ${TABLE}.incoterms

  - dimension: intake_margin_inc_vat
    sql: ${TABLE}.intake_margin_inc_vat

  - dimension: isbn
    sql: ${TABLE}.isbn

  - dimension: length
    sql: ${TABLE}.length

  - dimension: mode_of_transport
    sql: ${TABLE}.mode_of_transport

  - dimension: style
    sql: ${TABLE}.name
    html: |
        <a href="https://finerylondon.looker.com/explore/finery_data/sales_snapshot?show=data,fields&vis=%7B%22type%22:%22looker_column%22%7D&fields=product_lookup.option_name,sales_snapshot.sum_sales_yesterday_qty,sales_snapshot.sum_sales_yesterday,sales_snapshot.day_on_day,sales_snapshot.sum_sales_last_7_days_qty,sales_snapshot.sum_sales_last_7_days,sales_snapshot.sum_sales_last_28_days_qty,sales_snapshot.sum_sales_last_28_days,sales_snapshot.sum_count_on_hand_qty,sales_snapshot.sum_count_on_hand_gbp,sales_snapshot.avg_days_cover&sorts=sales_snapshot.sum_sales_yesterday+desc&total=on&filter_config=%7B%22product_lookup.style%22:%5B%7B%22type%22:%22%3D%22,%22values%22:%5B%7B%22constant%22:%22{{value}}%22%7D,%7B%7D%5D,%22id%22:0%7D%5D%7D&title=Sales+by+Option+-+{{value}}&f%5Bproduct_lookup.style%5D=%22{{value}}%22&run=1">{{value}}</a>
  
  - dimension: option_name
    sql: ${TABLE}.name||' - '||${TABLE}.colour_group 
    html: |
        <a href="https://finerylondon.looker.com/explore/finery_data/sales_snapshot?show=data,fields&vis=%7B%22type%22:%22looker_column%22%7D&fields=product_lookup.size,sales_snapshot.sum_sales_yesterday_qty,sales_snapshot.sum_sales_yesterday,sales_snapshot.day_on_day,sales_snapshot.sum_sales_last_7_days_qty,sales_snapshot.sum_sales_last_7_days,sales_snapshot.sum_sales_last_28_days_qty,sales_snapshot.sum_sales_last_28_days,sales_snapshot.sum_count_on_hand_qty,sales_snapshot.sum_count_on_hand_gbp,sales_snapshot.avg_days_cover&sorts=product_lookup.size+asc&total=on&filter_config=%7B%22product_lookup.option_name%22:%5B%7B%22type%22:%22%3D%22,%22values%22:%5B%7B%22constant%22:%22{{value}}%22%7D,%7B%7D%5D,%22id%22:0%7D%5D%7D&title=Sales+by+Size+-+{{value}}&f%5Bproduct_lookup.option_name%5D=%22{{value}}%22&run=1">{{value}}</a>
  
  - dimension: neck_shape
    sql: ${TABLE}.neck_shape

  - dimension: new_or_repeat
    sql: ${TABLE}.new_or_repeat

  - dimension: on_hand
    sql: ${TABLE}.on_hand

  - dimension: on_order
    sql: ${TABLE}.on_order

  - dimension_group: order_placement
    type: time
    timeframes: [date, week, month]
    convert_tz: false
    sql: ${TABLE}.order_placement_date

  - dimension: parent_sku
    sql: ${TABLE}.parent_sku

  - dimension: product_id
    type: int
    sql: ${TABLE}.product_id

  - dimension: product_type
    sql: ${TABLE}.product_type

  - dimension: retail_markup_inc_vat
    sql: ${TABLE}.retail_markup_inc_vat

  - dimension: sell_code
    sql: ${TABLE}.sell_code

  - dimension: shoe_height
    sql: ${TABLE}.shoe_height

  - dimension: short_description
    sql: ${TABLE}.short_description

  - dimension: single_or_multiple_drop
    sql: ${TABLE}.single_or_multiple_drop

  - dimension: size
    sql: ${TABLE}.size

  - dimension: size_pips
    sql: ${TABLE}.size_pips

  - dimension: sku
    sql: ${TABLE}.sku

  - dimension: sleeve_length
    sql: ${TABLE}.sleeve_length

  - dimension: stock_code
    sql: ${TABLE}.stock_code

  - dimension: product_style
    sql: ${TABLE}.style

  - dimension: sub_season_code
    sql: ${TABLE}.sub_season_code

  - dimension: supplier_code
    sql: ${TABLE}.supplier_code

  - dimension: swing_tag
    sql: ${TABLE}.swing_tag

  - dimension: tax_class
    sql: ${TABLE}.tax_class

  - dimension: total_landed_cost_gbp
    type: number
    sql: ${TABLE}.total_landed_cost_gbp

  - dimension: upc
    sql: ${TABLE}.upc

  - dimension: weight
    sql: ${TABLE}.weight

  - dimension: wholesale
    sql: ${TABLE}.wholesale

  - dimension: width
    sql: ${TABLE}.width
