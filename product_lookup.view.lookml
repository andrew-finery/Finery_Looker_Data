- view: product_lookup
  derived_table:
    sql: |
        select 
        product_id,
        sku,
        barcode,
        ean,
        upc,
        isbn,
        name,
        size,
        colour_group,
        parent_sku,
        commodity_code,
        design,
        length,
        sleeve_length,
        neck_shape,
        shoe_height,
        fabric,
        style,
        bag_shape,
        ex_factory_date,
        factory,
        incoterms,
        freight_cost_gbp,
        duty_rate_perc,
        total_landed_cost_gbp,
        brand1,
        sub_season_code,
        design_colour,
        new_or_repeat,
        cloth_composition,
        size_pips,
        back_neck_label,
        swing_tag,
        disclaimer,
        supplier_code,
        country_of_origin,
        single_or_multiple_drop,
        mode_of_transport,
        order_placement_date,
        delivery_notes,
        duty_gbp,
        retail_markup_inc_vat,
        intake_margin_inc_vat,
        expected_delivery_date_first_batch,
        expected_delivery_date_second_batch,
        width,
        height,
        depth,
        product_type,
        in_stock,
        allocated,
        on_hand,
        on_order,
        tax_class,
        sell_code,
        buy_code,
        stock_code,
        wholesale,
        weight,
        height2,
        width2,
        length2,
        volume2,
        brand2,
        category,
        short_description
        from
        (select
        first_value(product_id) over (partition by ean order by sub_season_code desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as product_id,
        first_value(sku) over (partition by ean order by sub_season_code desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as sku,
        first_value(barcode) over (partition by ean order by sub_season_code desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as barcode,
        ean,
        first_value(upc) over (partition by ean order by sub_season_code desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as upc,
        first_value(isbn) over (partition by ean order by sub_season_code desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as isbn,
        first_value(name) over (partition by ean order by sub_season_code desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as name,
        first_value(size) over (partition by ean order by sub_season_code desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as size,
        first_value(colour_group) over (partition by ean order by sub_season_code desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as colour_group,
        first_value(parent_sku) over (partition by ean order by sub_season_code desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as parent_sku,
        first_value(commodity_code) over (partition by ean order by sub_season_code desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as commodity_code,
        first_value(design) over (partition by ean order by sub_season_code desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as design,
        first_value(length) over (partition by ean order by sub_season_code desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as length,
        first_value(sleeve_length) over (partition by ean order by sub_season_code desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as sleeve_length,
        first_value(neck_shape) over (partition by ean order by sub_season_code desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as neck_shape,
        first_value(shoe_height) over (partition by ean order by sub_season_code desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as shoe_height,
        first_value(fabric) over (partition by ean order by sub_season_code desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as fabric,
        first_value(style) over (partition by ean order by sub_season_code desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as style,
        first_value(bag_shape) over (partition by ean order by sub_season_code desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as bag_shape,
        first_value(ex_factory_date) over (partition by ean order by sub_season_code desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as ex_factory_date,
        first_value(factory) over (partition by ean order by sub_season_code desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as factory,
        first_value(incoterms) over (partition by ean order by sub_season_code desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as incoterms,
        first_value(freight_cost_gbp) over (partition by ean order by sub_season_code desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as freight_cost_gbp,
        first_value(duty_rate_perc) over (partition by ean order by sub_season_code desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as duty_rate_perc,
        first_value(total_landed_cost_gbp) over (partition by ean order by sub_season_code desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as total_landed_cost_gbp,
        first_value(brand1) over (partition by ean order by sub_season_code desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as brand1,
        first_value(sub_season_code) over (partition by ean order by sub_season_code desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as sub_season_code,
        first_value(design_colour) over (partition by ean order by sub_season_code desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as design_colour,
        first_value(new_or_repeat) over (partition by ean order by sub_season_code desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as new_or_repeat,
        first_value(cloth_composition) over (partition by ean order by sub_season_code desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as cloth_composition,
        first_value(size_pips) over (partition by ean order by sub_season_code desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as size_pips,
        first_value(back_neck_label) over (partition by ean order by sub_season_code desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as back_neck_label,
        first_value(swing_tag) over (partition by ean order by sub_season_code desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as swing_tag,
        first_value(disclaimer) over (partition by ean order by sub_season_code desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as disclaimer,
        first_value(supplier_code) over (partition by ean order by sub_season_code desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as supplier_code,
        first_value(country_of_origin) over (partition by ean order by sub_season_code desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as country_of_origin,
        first_value(single_or_multiple_drop) over (partition by ean order by sub_season_code desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as single_or_multiple_drop,
        first_value(mode_of_transport) over (partition by ean order by sub_season_code desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as mode_of_transport,
        first_value(order_placement_date) over (partition by ean order by sub_season_code desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as order_placement_date,
        first_value(delivery_notes) over (partition by ean order by sub_season_code desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as delivery_notes,
        first_value(duty_gbp) over (partition by ean order by sub_season_code desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as duty_gbp,
        first_value(retail_markup_inc_vat) over (partition by ean order by sub_season_code desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as retail_markup_inc_vat,
        first_value(intake_margin_inc_vat) over (partition by ean order by sub_season_code desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as intake_margin_inc_vat,
        first_value(expected_delivery_date_first_batch) over (partition by ean order by sub_season_code desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as expected_delivery_date_first_batch,
        first_value(expected_delivery_date_second_batch) over (partition by ean order by sub_season_code desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as expected_delivery_date_second_batch,
        first_value(width) over (partition by ean order by sub_season_code desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as width,
        first_value(height) over (partition by ean order by sub_season_code desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as height,
        first_value(depth) over (partition by ean order by sub_season_code desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as depth,
        first_value(product_type) over (partition by ean order by sub_season_code desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as product_type,
        first_value(in_stock) over (partition by ean order by sub_season_code desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as in_stock,
        first_value(allocated) over (partition by ean order by sub_season_code desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as allocated,
        first_value(on_hand) over (partition by ean order by sub_season_code desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as on_hand,
        first_value(on_order) over (partition by ean order by sub_season_code desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as on_order,
        first_value(tax_class) over (partition by ean order by sub_season_code desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as tax_class,
        first_value(sell_code) over (partition by ean order by sub_season_code desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as sell_code,
        first_value(buy_code) over (partition by ean order by sub_season_code desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as buy_code,
        first_value(stock_code) over (partition by ean order by sub_season_code desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as stock_code,
        first_value(wholesale) over (partition by ean order by sub_season_code desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as wholesale,
        first_value(weight) over (partition by ean order by sub_season_code desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as weight,
        first_value(height2) over (partition by ean order by sub_season_code desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as height2,
        first_value(width2) over (partition by ean order by sub_season_code desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as width2,
        first_value(length2) over (partition by ean order by sub_season_code desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as length2,
        first_value(volume2) over (partition by ean order by sub_season_code desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as volume2,
        first_value(brand2) over (partition by ean order by sub_season_code desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as brand2,
        first_value(category) over (partition by ean order by sub_season_code desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as category,
        first_value(short_description) over (partition by ean order by sub_season_code desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as short_description
        from brightpearl.all_products)
        group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66


    sql_trigger_value: SELECT count(*) from brightpearl.all_products
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
        <a href="https://finerylondon.looker.com/explore/finery_data/sales_snapshot?show=data,fields&vis=%7B%22type%22:%22looker_column%22%7D&fields=product_lookup.style,sales_snapshot.sum_sales_yesterday_qty,sales_snapshot.sum_sales_yesterday,sales_snapshot.day_on_day,sales_snapshot.sum_sales_last_7_days_qty,sales_snapshot.sum_sales_last_7_days,sales_snapshot.week_on_week,sales_snapshot.sum_sales_last_28_days_qty,sales_snapshot.sum_sales_last_28_days,sales_snapshot.month_on_month,sales_snapshot.sum_count_on_hand_qty,sales_snapshot.sum_count_on_hand_gbp,sales_snapshot.avg_weeks_cover&sorts=sales_snapshot.sum_sales_yesterday+desc&limit=500&total=on&vis=%7B%22type%22:%22looker_column%22%7D&show=data,fields&title=Sales+by+Style+-+{{value}}&filter_config=%7B%22product_lookup.category%22:%5B%7B%22type%22:%22is%22,%22values%22:%5B%7B%22constant%22:%22{{value}}%22%7D,%7B%7D%5D,%22id%22:1%7D%5D%7D&f%5Bproduct_lookup.category%5D={{value}}&run=1">{{value}}</a>
  
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
    sql: ${TABLE}.ean
    hidden: true
    
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
    label: SUPPLIER
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
        <a href="https://finerylondon.looker.com/explore/finery_data/sales_snapshot?show=data,fields&vis=%7B%22type%22:%22looker_column%22%7D&fields=product_lookup.option_name,sales_snapshot.sum_sales_yesterday_qty,sales_snapshot.sum_sales_yesterday,sales_snapshot.day_on_day,sales_snapshot.sum_sales_last_7_days_qty,sales_snapshot.sum_sales_last_7_days,sales_snapshot.week_on_week,sales_snapshot.sum_sales_last_28_days_qty,sales_snapshot.sum_sales_last_28_days,sales_snapshot.month_on_month,sales_snapshot.sum_count_on_hand_qty,sales_snapshot.sum_count_on_hand_gbp,sales_snapshot.avg_weeks_cover&sorts=sales_snapshot.sum_sales_yesterday+desc&total=on&filter_config=%7B%22product_lookup.style%22:%5B%7B%22type%22:%22%3D%22,%22values%22:%5B%7B%22constant%22:%22{{value}}%22%7D,%7B%7D%5D,%22id%22:0%7D%5D%7D&title=Sales+by+Option+-+{{value}}&f%5Bproduct_lookup.style%5D=%22{{value}}%22&run=1">{{value}}</a>
  
  - dimension: option_name
    label: BP_OPTION
    sql: ${TABLE}.name||' - '||${TABLE}.colour_group 
    html: |
        <a href="https://finerylondon.looker.com/explore/finery_data/sales_snapshot?show=data,fields&vis=%7B%22type%22:%22looker_column%22%7D&fields=product_lookup.size,sales_snapshot.sum_sales_yesterday_qty,sales_snapshot.sum_sales_yesterday,sales_snapshot.day_on_day,sales_snapshot.sum_sales_last_7_days_qty,sales_snapshot.sum_sales_last_7_days,sales_snapshot.week_on_week,sales_snapshot.sum_sales_last_28_days_qty,sales_snapshot.sum_sales_last_28_days,sales_snapshot.month_on_month,sales_snapshot.sum_count_on_hand_qty,sales_snapshot.sum_count_on_hand_gbp,sales_snapshot.avg_weeks_cover&sorts=product_lookup.size+asc&total=on&filter_config=%7B%22product_lookup.option_name%22:%5B%7B%22type%22:%22%3D%22,%22values%22:%5B%7B%22constant%22:%22{{value}}%22%7D,%7B%7D%5D,%22id%22:0%7D%5D%7D&title=Sales+by+Size+-+{{value}}&f%5Bproduct_lookup.option_name%5D=%22{{value}}%22&run=1">{{value}}</a>

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
    sql: coalesce(${online_products.max_price}, round((${total_landed_cost_gbp} * ${retail_markup_inc_vat}), 0))
 
  - dimension: current_price
    label: CURRENT PRICE
    sql: coalesce(${online_products.current_price_gbp}, round((${total_landed_cost_gbp} * ${retail_markup_inc_vat}), 0))
    
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