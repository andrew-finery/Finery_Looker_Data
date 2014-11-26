- view: line_detail_re15
  sql_table_name: scratchpad.line_detail_re15
  fields:

  - dimension: attribute_lv_3
    sql: ${TABLE}.attribute_lv_3

  - dimension: attribute_lv_4
    sql: ${TABLE}.attribute_lv_4

  - dimension: back_neck_label
    sql: ${TABLE}.back_neck_label

  - dimension: category
    sql: ${TABLE}.category

  - dimension: child_sku
    sql: ${TABLE}.child_sku

  - dimension: cloth_composition
    sql: ${TABLE}.cloth_composition

  - dimension: colour_code
    type: int
    sql: ${TABLE}.colour_code

  - dimension: colour_group
    sql: ${TABLE}.colour_group

  - dimension: commodity_code
    type: number
    sql: ${TABLE}.commodity_code

  - dimension: cost_price_and_f_n_i
    type: number
    sql: ${TABLE}.cost_price_and_f_n_i

  - dimension: cost_price_fob
    type: number
    sql: ${TABLE}.cost_price_fob

  - dimension: cost_price_fob_gbp
    type: number
    sql: ${TABLE}.cost_price_fob_gbp

  - dimension: country_of_origin
    sql: ${TABLE}.country_of_origin

  - dimension: department
    sql: ${TABLE}.department
    html: |
        <a href="https://finerylondon.looker.com/explore/finery_data/order_items?fields=line_detail_re15.department_category,order_items.distinct_skus_sold,order_items.items_sold,order_items.sum_gross_revenue&sorts=order_items.items_sold+desc&limit=500&vis=%7B%22type%22:%22looker_column%22%7D&filter_config=%7B%22line_detail_re15.department%22:%5B%7B%22type%22:%22%3D%22,%22values%22:%5B%7B%22constant%22:%22{{value}}%22%7D,%7B%7D%5D,%22id%22:0%7D%5D%7D&show=data,fields&title=Sales+by+Category+-+{{value}}&look_id=9&f%5Bline_detail_re15.department%5D=%22{{value}}%22&run=1">{{value}}</a>
  
  - dimension: department_category
    sql: ${TABLE}.department||' - '||${TABLE}.category   
    html: |
        <a href="https://finerylondon.looker.com/explore/finery_data/order_items?fields=line_detail_re15.parent_sku,line_detail_re15.description,order_items.price,order_items.items_sold,order_items.sum_gross_revenue&limit=500&vis=%7B%22type%22:%22looker_column%22%7D&filter_config=%7B%22line_detail_re15.department_category%22:%5B%7B%22type%22:%22%3D%22,%22values%22:%5B%7B%22constant%22:%22{{value}}%22%7D,%7B%7D%5D,%22id%22:0%7D%5D%7D&show=data,fields&title=Sales+by+Parent+SKU+-+{{value}}&look_id=9&sorts=order_items.items_sold+desc&f%5Bline_detail_re15.department_category%5D=%22{{value}}%22&run=1">{{value}}</a>
  
  - dimension: description
    sql: ${TABLE}.description

  - dimension: design_buying_style_nr
    sql: ${TABLE}.design_buying_style_nr

  - dimension: design_colour
    sql: ${TABLE}.design_colour

  - dimension: disclaimer
    sql: ${TABLE}.disclaimer

  - dimension: duty_gbp
    type: number
    sql: ${TABLE}.duty_gbp

  - dimension: duty_perc
    type: number
    sql: ${TABLE}.duty_perc

  - dimension: ean
    sql: ${TABLE}.ean

  - dimension_group: ex_factory
    type: time
    timeframes: [date, week, month]
    convert_tz: false
    sql: ${TABLE}.ex_factory_date

  - dimension: ex_rate
    type: number
    sql: ${TABLE}.ex_rate

  - dimension_group: expected_delivery
    type: time
    timeframes: [date, week, month]
    convert_tz: false
    sql: ${TABLE}.expected_delivery_date

  - dimension: factory
    sql: ${TABLE}.factory

  - dimension: freight_and_insurance_gbp
    type: number
    sql: ${TABLE}.freight_and_insurance_gbp

  - dimension: freight_and_insurance_perc
    type: number
    sql: ${TABLE}.freight_and_insurance_perc

  - dimension: incoterms
    sql: ${TABLE}.incoterms

  - dimension: index_number
    type: int
    sql: ${TABLE}.index_number

  - dimension: intake_margin_ex_vat
    type: number
    sql: ${TABLE}.intake_margin_ex_vat

  - dimension: intake_margin_inc_vat
    type: number
    sql: ${TABLE}.intake_margin_inc_vat

  - dimension: local_currency
    sql: ${TABLE}.local_currency

  - dimension: long_description
    sql: ${TABLE}.long_description

  - dimension: main_season
    sql: ${TABLE}.main_season

  - dimension: mda
    type: int
    sql: ${TABLE}.mda

  - dimension: mode_of_transport
    sql: ${TABLE}.mode_of_transport

  - dimension: new_or_repeat
    sql: ${TABLE}.new_or_repeat

  - dimension: no_units
    type: int
    sql: ${TABLE}.no_units

  - dimension_group: order_placement
    type: time
    timeframes: [date, week, month]
    convert_tz: false
    sql: ${TABLE}.order_placement_date

  - dimension: parent_sku
    sql: ${TABLE}.parent_sku
    html: |
        <a href="https://finerylondon.looker.com/explore/finery_data/order_items?fields=line_detail_re15.parent_sku,line_detail_re15.description,line_detail_re15.colour_group,order_items.price,line_detail_re15.size,order_items.items_sold,order_items.sum_gross_revenue&sorts=line_detail_re15.colour_group+desc&limit=500&vis=%7B%22type%22:%22looker_column%22%7D&filter_config=%7B%22line_detail_re15.parent_sku%22:%5B%7B%22type%22:%22%3D%22,%22values%22:%5B%7B%22constant%22:%22{{value}}%22%7D,%7B%7D%5D,%22id%22:0%7D%5D%7D&show=data,fields&title=Sales+by+Parent+SKU+-+{{value}}&look_id=9&f%5Bline_detail_re15.parent_sku%5D=%22{{value}}%22">{{value}}</a>
  
    
  - dimension: retail_markup_ex_vat
    type: number
    sql: ${TABLE}.retail_markup_ex_vat

  - dimension: retail_markup_inc_vat
    type: number
    sql: ${TABLE}.retail_markup_inc_vat

  - dimension: single_drop
    sql: ${TABLE}.single_drop

  - dimension: size
    sql: ${TABLE}.size

  - dimension: size_pips
    sql: ${TABLE}.size_pips

  - dimension: sub_season_code
    sql: ${TABLE}.sub_season_code

  - dimension: supplier
    sql: ${TABLE}.supplier

  - dimension: supplier_code
    type: int
    sql: ${TABLE}.supplier_code

  - dimension: swing_tag
    sql: ${TABLE}.swing_tag

  - dimension: total_landed_cost
    type: number
    sql: ${TABLE}.total_landed_cost

  - dimension: uk_selling_price
    type: number
    sql: ${TABLE}.uk_selling_price

  - dimension: weight
    type: number
    sql: ${TABLE}.weight

  - measure: count
    type: count
    drill_fields: []

