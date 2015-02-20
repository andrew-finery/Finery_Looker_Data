- dashboard: customer_dashboard
  title: Customer Dashboard
  layout: tile
  tile_size: 100

#  filters:

  elements:

  - name: add_a_unique_name_593
    title: UK Customer Heat Map
    type: looker_geo_choropleth
    model: finery_data
    explore: spree_orders
    dimensions: [addresses.map_postcode]
    measures: [spree_orders.count_customers]
    filters:
      addresses.country: '"United Kingdom"'
    sorts: [spree_orders.count_customers desc]
    limit: 500
    total: false
    quantize_colors: false
    map: topojson
    map_url: https://rawgit.com/wilg/3832004ce358c36b06f2/raw/772d28bfd755bcacdff0b6d9fb2b248aa2a563d1/Areas.json
    map_projection: ''
    point_color: blue
    show_null_points: true
    colors: ['#280000', '#300000', '#380000', '#400000', '#480000', '#500000', '#580000',
      '#600000', '#680000', '#700000', '#780000', '#800000', '#880000', '#900000', '#980000',
      '#a00000', '#a80000', '#b00000', '#b80000', '#c00000', '#c80000', '#d00000', '#d80000',
      '#e00000', '#e80000', '#f00000', '#f80000', '#ff0000']
    empty_color: black
    inner_border_width: 0
    loading: false
    height: 10
    width: 8

