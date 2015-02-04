- view: product_lookup
  sql_table_name: brightpearl.all_products
  fields:

  - dimension: allocated
    sql: ${TABLE}.allocated

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
        <a href="https://finerylondon.looker.com/explore/finery_data/sales_snapshot?show=data,fields&vis=%7B%22type%22:%22looker_column%22%7D&fields=product_lookup.style,sales_snapshot.sum_sales_yesterday_qty,sales_snapshot.sum_sales_yesterday,sales_snapshot.day_on_day,sales_snapshot.sum_sales_last_7_days_qty,sales_snapshot.sum_sales_last_7_days,sales_snapshot.week_on_week,sales_snapshot.sum_sales_last_28_days_qty,sales_snapshot.sum_sales_last_28_days,sales_snapshot.month_on_month,sales_snapshot.sum_count_on_hand_qty,sales_snapshot.sum_count_on_hand_gbp,sales_snapshot.avg_weeks_cover&sorts=sales_snapshot.sum_sales_yesterday+desc&limit=500&total=on&vis=%7B%22type%22:%22looker_column%22%7D&show=data,fields&title=Sales+by+Style+-+{{value}}&filter_config=%7B%22product_lookup.category%22:%5B%7B%22type%22:%22is%22,%22values%22:%5B%7B%22constant%22:%22{{value}}%22%7D,%7B%7D%5D,%22id%22:1%7D%5D%7D&f%5Bproduct_lookup.category%5D={{value}}&run=1">{{value}}</a>
  
  - dimension: product_area
    sql_case:
      Clothing: ${TABLE}.category in ('Evening Dresses', 'Outerwear & Blazers', 'Skirts', 'Woven Tops', 'Day Dresses', 'Knitwear', 'Trousers & Shorts', 'Jersey Tops')
      Non-Clothing: ${TABLE}.category in ('Accessories', 'Shoes', 'Jewellery')
      else: 'Other'

  - dimension: colour_group
    sql: ${TABLE}.colour_group

  - dimension: design
    sql: ${TABLE}.design

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

  - dimension: factory
    sql: ${TABLE}.factory

  - dimension: freight_cost_gbp
    sql: ${TABLE}.freight_cost_gbp

  - dimension: incoterms
    sql: ${TABLE}.incoterms

  - dimension: intake_margin_inc_vat
    sql: ${TABLE}.intake_margin_inc_vat

  - dimension: length
    sql: ${TABLE}.length

  - dimension: mode_of_transport
    sql: ${TABLE}.mode_of_transport

  - dimension: style
    sql: ${TABLE}.name
    html: |
        <a href="https://finerylondon.looker.com/explore/finery_data/sales_snapshot?show=data,fields&vis=%7B%22type%22:%22looker_column%22%7D&fields=product_lookup.option_name,sales_snapshot.sum_sales_yesterday_qty,sales_snapshot.sum_sales_yesterday,sales_snapshot.day_on_day,sales_snapshot.sum_sales_last_7_days_qty,sales_snapshot.sum_sales_last_7_days,sales_snapshot.week_on_week,sales_snapshot.sum_sales_last_28_days_qty,sales_snapshot.sum_sales_last_28_days,sales_snapshot.month_on_month,sales_snapshot.sum_count_on_hand_qty,sales_snapshot.sum_count_on_hand_gbp,sales_snapshot.avg_weeks_cover&sorts=sales_snapshot.sum_sales_yesterday+desc&total=on&filter_config=%7B%22product_lookup.style%22:%5B%7B%22type%22:%22%3D%22,%22values%22:%5B%7B%22constant%22:%22{{value}}%22%7D,%7B%7D%5D,%22id%22:0%7D%5D%7D&title=Sales+by+Option+-+{{value}}&f%5Bproduct_lookup.style%5D=%22{{value}}%22&run=1">{{value}}</a>
  
  - dimension: option_name
    sql: ${TABLE}.name||' - '||${TABLE}.colour_group 
    html: |
        <a href="https://finerylondon.looker.com/explore/finery_data/sales_snapshot?show=data,fields&vis=%7B%22type%22:%22looker_column%22%7D&fields=product_lookup.size,sales_snapshot.sum_sales_yesterday_qty,sales_snapshot.sum_sales_yesterday,sales_snapshot.day_on_day,sales_snapshot.sum_sales_last_7_days_qty,sales_snapshot.sum_sales_last_7_days,sales_snapshot.week_on_week,sales_snapshot.sum_sales_last_28_days_qty,sales_snapshot.sum_sales_last_28_days,sales_snapshot.month_on_month,sales_snapshot.sum_count_on_hand_qty,sales_snapshot.sum_count_on_hand_gbp,sales_snapshot.avg_weeks_cover&sorts=product_lookup.size+asc&total=on&filter_config=%7B%22product_lookup.option_name%22:%5B%7B%22type%22:%22%3D%22,%22values%22:%5B%7B%22constant%22:%22{{value}}%22%7D,%7B%7D%5D,%22id%22:0%7D%5D%7D&title=Sales+by+Size+-+{{value}}&f%5Bproduct_lookup.option_name%5D=%22{{value}}%22&run=1">{{value}}</a>

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

  - dimension: product_type
    sql: ${TABLE}.product_type

  - dimension: retail_markup_inc_vat
    type: number
    decimals: 2
    sql: case when ${TABLE}.retail_markup_inc_vat = ' ' then '0' else left(${TABLE}.retail_markup_inc_vat, charindex('.',${TABLE}.retail_markup_inc_vat) + 2) end

  - dimension: size
    sql: ${TABLE}.size

  - dimension: sku
    sql: ${TABLE}.sku

  - dimension: sub_season_code
    sql: ${TABLE}.sub_season_code

  - dimension: total_landed_cost_gbp
    type: number
    decimals: 2
    sql: ${TABLE}.total_landed_cost_gbp

### Price Dimensions

  - dimension: max_selling_price
    sql: coalesce(${online_products.max_price}, round((${total_landed_cost_gbp} * ${retail_markup_inc_vat}), 0))
 
  - dimension: current_price
    sql: coalesce(${online_products.current_price_gbp}, round((${total_landed_cost_gbp} * ${retail_markup_inc_vat}), 0))
    
  - dimension: selling_price_tiered
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
    sql_case:
      0% - 7.5%: ${current_price}/${max_selling_price} > 0.925 or ${max_selling_price} = 0
      7.5% - 17.5%: ${current_price}/${max_selling_price} > 0.825
      17.5% - 27.5%: ${current_price}/${max_selling_price} > 0.725
      27.5% - 37.5%: ${current_price}/${max_selling_price} > 0.625
      37.5% and over: (${current_price}/${max_selling_price}) > 0 and (${current_price}/${max_selling_price}) <= 0.625
      else: '0% - 7.5%'