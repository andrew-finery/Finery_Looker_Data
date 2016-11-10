- dashboard: website_promo_blocks_dashboard
  title: Website Promo Blocks Dashboard
  layout: static
  tile_size: 100

  filters:
  - name: date
    title: "Date"
    type: date_filter
    default_value: last week

  elements:

  - name: category_page_views
    title: Category Page Views
    type: looker_pie
    model: finery_data
    explore: website_page_views
    dimensions: [website_page_views.page_urlpath]
    measures: [website_page_views.count_distinct_page_views]
    filters:
      website_page_views.page_type: Category Page
    listen:
     date: visits.start_date
    sorts: [website_page_views.count_distinct_page_views desc]
    limit: '15'
    column_limit: '50'
    query_timezone: Europe/London
    value_labels: legend
    label_type: labPer
    show_view_names: false
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: '#808080'
    series_types: {}
    colors: 'palette: Mixed Pastels'
    inner_radius:
    top: 0
    left: -3
    height: 6
    width: 9

  - name: category_promo_block_impressions
    title: Category Promo Block Impressions
    type: looker_pie
    model: finery_data
    explore: website_promo_block_click_through_daily
    dimensions: [website_promo_block_click_through_daily.page_urlpath]
    measures: [website_promo_block_click_through_daily.sum_promo_views]
    filters:
      spree_promo_block_info.placements: taxon^_listing
      website_promo_block_click_through_daily.page_urlpath: '%/t/%'
      website_promo_block_click_through_daily.sum_promo_views: '>100'
    listen:
     date: website_promo_block_click_through_daily.calendar_date
    sorts: [website_promo_block_click_through_daily.sum_promo_views desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
    value_labels: legend
    label_type: labPer
    show_view_names: true
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: '#808080'
    series_types: {}
    colors: 'palette: Mixed Neutrals'
    top: 0
    left: 6
    height: 6
    width: 9

  - name: full_collection_category_promo_blocks
    title: Full Collection Promo Blocks
    type: table
    model: finery_data
    explore: website_promo_block_click_through_daily
    dimensions: [spree_promo_block_info.promo_block_image, website_promo_block_click_through_daily.page_urlpath,
      spree_promo_block_info.name, spree_promo_block_info.cta_link, spree_promo_block_info.promo_block_position]
    measures: [website_promo_block_click_through_daily.sum_promo_views, website_promo_block_click_through_daily.sum_promo_clicks,
      website_promo_block_click_through_daily.click_through_rate]
    filters:
      spree_promo_block_info.placements: taxon^_listing
      website_promo_block_click_through_daily.page_urlpath: /t/the-full-collection/
      website_promo_block_click_through_daily.sum_promo_views: '>100'
      website_promo_block_click_through_daily.sum_promo_views: '>100'
    listen:
     date: website_promo_block_click_through_daily.calendar_date
    sorts: [website_promo_block_click_through_daily.sum_promo_views desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
    show_row_numbers: false
    series_labels:
      spree_promo_block_info.promo_block_image: Image
      website_promo_block_click_through_daily.page_urlpath: URL
      spree_promo_block_info.name: Promo Block Name
      spree_promo_block_info.cta_link: Link URL
      spree_promo_block_info.promo_block_position: Position
      website_promo_block_click_through_daily.sum_promo_views: Views
      website_promo_block_click_through_daily.sum_promo_clicks: Clicks
      website_promo_block_click_through_daily.click_through_rate: CTR
    top: 7
    left: -3
    height: 5
    width: 9

  - name: dresses_category_promo_blocks
    title: Dresses Category Promo Blocks
    type: table
    model: finery_data
    explore: website_promo_block_click_through_daily
    dimensions: [spree_promo_block_info.promo_block_image, website_promo_block_click_through_daily.page_urlpath,
      spree_promo_block_info.name, spree_promo_block_info.cta_link, spree_promo_block_info.promo_block_position]
    measures: [website_promo_block_click_through_daily.sum_promo_views, website_promo_block_click_through_daily.sum_promo_clicks,
      website_promo_block_click_through_daily.click_through_rate]
    filters:
      spree_promo_block_info.placements: taxon^_listing
      website_promo_block_click_through_daily.page_urlpath: /t/dresses/
      website_promo_block_click_through_daily.sum_promo_views: '>100'
      website_promo_block_click_through_daily.sum_promo_views: '>100'
    listen:
     date: website_promo_block_click_through_daily.calendar_date
    sorts: [website_promo_block_click_through_daily.sum_promo_views desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
    show_row_numbers: false
    series_labels:
      spree_promo_block_info.promo_block_image: Image
      website_promo_block_click_through_daily.page_urlpath: URL
      spree_promo_block_info.name: Promo Block Name
      spree_promo_block_info.cta_link: Link URL
      spree_promo_block_info.promo_block_position: Position
      website_promo_block_click_through_daily.sum_promo_views: Views
      website_promo_block_click_through_daily.sum_promo_clicks: Clicks
      website_promo_block_click_through_daily.click_through_rate: CTR
    top: 7
    left: 6
    height: 5
    width: 9

  - name: tops_category_promo_blocks
    title: Tops Promo Blocks
    type: table
    model: finery_data
    explore: website_promo_block_click_through_daily
    dimensions: [spree_promo_block_info.promo_block_image, website_promo_block_click_through_daily.page_urlpath,
      spree_promo_block_info.name, spree_promo_block_info.cta_link, spree_promo_block_info.promo_block_position]
    measures: [website_promo_block_click_through_daily.sum_promo_views, website_promo_block_click_through_daily.sum_promo_clicks,
      website_promo_block_click_through_daily.click_through_rate]
    filters:
      spree_promo_block_info.placements: taxon^_listing
      website_promo_block_click_through_daily.page_urlpath: /t/tops/
      website_promo_block_click_through_daily.sum_promo_views: '>100'
      website_promo_block_click_through_daily.sum_promo_views: '>100'
    listen:
     date: website_promo_block_click_through_daily.calendar_date
    sorts: [website_promo_block_click_through_daily.sum_promo_views desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
    show_row_numbers: false
    series_labels:
      spree_promo_block_info.promo_block_image: Image
      website_promo_block_click_through_daily.page_urlpath: URL
      spree_promo_block_info.name: Promo Block Name
      spree_promo_block_info.cta_link: Link URL
      spree_promo_block_info.promo_block_position: Position
      website_promo_block_click_through_daily.sum_promo_views: Views
      website_promo_block_click_through_daily.sum_promo_clicks: Clicks
      website_promo_block_click_through_daily.click_through_rate: CTR
    top: 12
    left: -3
    height: 5
    width: 9

  - name: shoes_category_promo_blocks
    title: Shoes Category Promo Blocks
    type: table
    model: finery_data
    explore: website_promo_block_click_through_daily
    dimensions: [spree_promo_block_info.promo_block_image, website_promo_block_click_through_daily.page_urlpath,
      spree_promo_block_info.name, spree_promo_block_info.cta_link, spree_promo_block_info.promo_block_position]
    measures: [website_promo_block_click_through_daily.sum_promo_views, website_promo_block_click_through_daily.sum_promo_clicks,
      website_promo_block_click_through_daily.click_through_rate]
    filters:
      spree_promo_block_info.placements: taxon^_listing
      website_promo_block_click_through_daily.page_urlpath: /t/shoes/
      website_promo_block_click_through_daily.sum_promo_views: '>100'
      website_promo_block_click_through_daily.sum_promo_views: '>100'
    listen:
     date: website_promo_block_click_through_daily.calendar_date
    sorts: [website_promo_block_click_through_daily.sum_promo_views desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
    show_row_numbers: false
    series_labels:
      spree_promo_block_info.promo_block_image: Image
      website_promo_block_click_through_daily.page_urlpath: URL
      spree_promo_block_info.name: Promo Block Name
      spree_promo_block_info.cta_link: Link URL
      spree_promo_block_info.promo_block_position: Position
      website_promo_block_click_through_daily.sum_promo_views: Views
      website_promo_block_click_through_daily.sum_promo_clicks: Clicks
      website_promo_block_click_through_daily.click_through_rate: CTR
    top: 12
    left: 6
    height: 5
    width: 9

  - name: skirts_and_trousers_category_promo_blocks
    title: Skirts & Trousers Promo Blocks
    type: table
    model: finery_data
    explore: website_promo_block_click_through_daily
    dimensions: [spree_promo_block_info.promo_block_image, website_promo_block_click_through_daily.page_urlpath,
      spree_promo_block_info.name, spree_promo_block_info.cta_link, spree_promo_block_info.promo_block_position]
    measures: [website_promo_block_click_through_daily.sum_promo_views, website_promo_block_click_through_daily.sum_promo_clicks,
      website_promo_block_click_through_daily.click_through_rate]
    filters:
      spree_promo_block_info.placements: taxon^_listing
      website_promo_block_click_through_daily.page_urlpath: /t/skirts-and-trousers/
      website_promo_block_click_through_daily.sum_promo_views: '>100'
    listen:
     date: website_promo_block_click_through_daily.calendar_date
    sorts: [website_promo_block_click_through_daily.sum_promo_views desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
    show_row_numbers: false
    series_labels:
      spree_promo_block_info.promo_block_image: Image
      website_promo_block_click_through_daily.page_urlpath: URL
      spree_promo_block_info.name: Promo Block Name
      spree_promo_block_info.cta_link: Link URL
      spree_promo_block_info.promo_block_position: Position
      website_promo_block_click_through_daily.sum_promo_views: Views
      website_promo_block_click_through_daily.sum_promo_clicks: Clicks
      website_promo_block_click_through_daily.click_through_rate: CTR
    top: 17
    left: -3
    height: 5
    width: 9

  - name: accessories_category_promo_blocks
    title: Accessories Category Promo Blocks
    type: table
    model: finery_data
    explore: website_promo_block_click_through_daily
    dimensions: [spree_promo_block_info.promo_block_image, website_promo_block_click_through_daily.page_urlpath,
      spree_promo_block_info.name, spree_promo_block_info.cta_link, spree_promo_block_info.promo_block_position]
    measures: [website_promo_block_click_through_daily.sum_promo_views, website_promo_block_click_through_daily.sum_promo_clicks,
      website_promo_block_click_through_daily.click_through_rate]
    filters:
      spree_promo_block_info.placements: taxon^_listing
      website_promo_block_click_through_daily.page_urlpath: /t/accessories/
      website_promo_block_click_through_daily.sum_promo_views: '>100'
    listen:
     date: website_promo_block_click_through_daily.calendar_date
    sorts: [website_promo_block_click_through_daily.sum_promo_views desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
    show_row_numbers: false
    series_labels:
      spree_promo_block_info.promo_block_image: Image
      website_promo_block_click_through_daily.page_urlpath: URL
      spree_promo_block_info.name: Promo Block Name
      spree_promo_block_info.cta_link: Link URL
      spree_promo_block_info.promo_block_position: Position
      website_promo_block_click_through_daily.sum_promo_views: Views
      website_promo_block_click_through_daily.sum_promo_clicks: Clicks
      website_promo_block_click_through_daily.click_through_rate: CTR
    top: 17
    left: 6
    height: 5
    width: 9

  - name: outerwear_category_promo_blocks
    title: Outerwear Promo Blocks
    type: table
    model: finery_data
    explore: website_promo_block_click_through_daily
    dimensions: [spree_promo_block_info.promo_block_image, website_promo_block_click_through_daily.page_urlpath,
      spree_promo_block_info.name, spree_promo_block_info.cta_link, spree_promo_block_info.promo_block_position]
    measures: [website_promo_block_click_through_daily.sum_promo_views, website_promo_block_click_through_daily.sum_promo_clicks,
      website_promo_block_click_through_daily.click_through_rate]
    filters:
      spree_promo_block_info.placements: taxon^_listing
      website_promo_block_click_through_daily.page_urlpath: /t/jackets-and-coats/
      website_promo_block_click_through_daily.sum_promo_views: '>100'
    listen:
     date: website_promo_block_click_through_daily.calendar_date
    sorts: [website_promo_block_click_through_daily.sum_promo_views desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
    show_row_numbers: false
    series_labels:
      spree_promo_block_info.promo_block_image: Image
      website_promo_block_click_through_daily.page_urlpath: URL
      spree_promo_block_info.name: Promo Block Name
      spree_promo_block_info.cta_link: Link URL
      spree_promo_block_info.promo_block_position: Position
      website_promo_block_click_through_daily.sum_promo_views: Views
      website_promo_block_click_through_daily.sum_promo_clicks: Clicks
      website_promo_block_click_through_daily.click_through_rate: CTR
    top: 22
    left: -3
    height: 5
    width: 9

  - name: final_call_category_promo_blocks
    title: Final Call Category Promo Blocks
    type: table
    model: finery_data
    explore: website_promo_block_click_through_daily
    dimensions: [spree_promo_block_info.promo_block_image, website_promo_block_click_through_daily.page_urlpath,
      spree_promo_block_info.name, spree_promo_block_info.cta_link, spree_promo_block_info.promo_block_position]
    measures: [website_promo_block_click_through_daily.sum_promo_views, website_promo_block_click_through_daily.sum_promo_clicks,
      website_promo_block_click_through_daily.click_through_rate]
    filters:
      spree_promo_block_info.placements: taxon^_listing
      website_promo_block_click_through_daily.page_urlpath: /t/final-call/
      website_promo_block_click_through_daily.sum_promo_views: '>100'
    listen:
     date: website_promo_block_click_through_daily.calendar_date
    sorts: [website_promo_block_click_through_daily.sum_promo_views desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
    show_row_numbers: false
    series_labels:
      spree_promo_block_info.promo_block_image: Image
      website_promo_block_click_through_daily.page_urlpath: URL
      spree_promo_block_info.name: Promo Block Name
      spree_promo_block_info.cta_link: Link URL
      spree_promo_block_info.promo_block_position: Position
      website_promo_block_click_through_daily.sum_promo_views: Views
      website_promo_block_click_through_daily.sum_promo_clicks: Clicks
      website_promo_block_click_through_daily.click_through_rate: CTR
    top: 22
    left: 6
    height: 5
    width: 9

  - name: final_call_dresses_category_promo_blocks
    title: Final Call Dresses Category Promo Blocks
    type: table
    model: finery_data
    explore: website_promo_block_click_through_daily
    dimensions: [spree_promo_block_info.promo_block_image, website_promo_block_click_through_daily.page_urlpath,
      spree_promo_block_info.name, spree_promo_block_info.cta_link, spree_promo_block_info.promo_block_position]
    measures: [website_promo_block_click_through_daily.sum_promo_views, website_promo_block_click_through_daily.sum_promo_clicks,
      website_promo_block_click_through_daily.click_through_rate]
    filters:
      spree_promo_block_info.placements: taxon^_listing
      website_promo_block_click_through_daily.page_urlpath: /t/final-call/dresses/
      website_promo_block_click_through_daily.sum_promo_views: '>100'
    listen:
     date: website_promo_block_click_through_daily.calendar_date
    sorts: [website_promo_block_click_through_daily.sum_promo_views desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
    show_row_numbers: false
    series_labels:
      spree_promo_block_info.promo_block_image: Image
      website_promo_block_click_through_daily.page_urlpath: URL
      spree_promo_block_info.name: Promo Block Name
      spree_promo_block_info.cta_link: Link URL
      spree_promo_block_info.promo_block_position: Position
      website_promo_block_click_through_daily.sum_promo_views: Views
      website_promo_block_click_through_daily.sum_promo_clicks: Clicks
      website_promo_block_click_through_daily.click_through_rate: CTR
    top: 27
    left: -3
    height: 5
    width: 9

  - name: final_call_tops_category_promo_blocks
    title: Final Call Tops Category Promo Blocks
    type: table
    model: finery_data
    explore: website_promo_block_click_through_daily
    dimensions: [spree_promo_block_info.promo_block_image, website_promo_block_click_through_daily.page_urlpath,
      spree_promo_block_info.name, spree_promo_block_info.cta_link, spree_promo_block_info.promo_block_position]
    measures: [website_promo_block_click_through_daily.sum_promo_views, website_promo_block_click_through_daily.sum_promo_clicks,
      website_promo_block_click_through_daily.click_through_rate]
    filters:
      spree_promo_block_info.placements: taxon^_listing
      website_promo_block_click_through_daily.page_urlpath: /t/final-call/tops/
      website_promo_block_click_through_daily.sum_promo_views: '>100'
    listen:
     date: website_promo_block_click_through_daily.calendar_date
    sorts: [website_promo_block_click_through_daily.sum_promo_views desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
    show_row_numbers: false
    series_labels:
      spree_promo_block_info.promo_block_image: Image
      website_promo_block_click_through_daily.page_urlpath: URL
      spree_promo_block_info.name: Promo Block Name
      spree_promo_block_info.cta_link: Link URL
      spree_promo_block_info.promo_block_position: Position
      website_promo_block_click_through_daily.sum_promo_views: Views
      website_promo_block_click_through_daily.sum_promo_clicks: Clicks
      website_promo_block_click_through_daily.click_through_rate: CTR
    top: 27
    left: 6
    height: 5
    width: 9

  - name: final_call_shoes_category_promo_blocks
    title: Final Call Shoes Category Promo Blocks
    type: table
    model: finery_data
    explore: website_promo_block_click_through_daily
    dimensions: [spree_promo_block_info.promo_block_image, website_promo_block_click_through_daily.page_urlpath,
      spree_promo_block_info.name, spree_promo_block_info.cta_link, spree_promo_block_info.promo_block_position]
    measures: [website_promo_block_click_through_daily.sum_promo_views, website_promo_block_click_through_daily.sum_promo_clicks,
      website_promo_block_click_through_daily.click_through_rate]
    filters:
      spree_promo_block_info.placements: taxon^_listing
      website_promo_block_click_through_daily.page_urlpath: /t/final-call/shoes/
      website_promo_block_click_through_daily.sum_promo_views: '>100'
    listen:
     date: website_promo_block_click_through_daily.calendar_date
    sorts: [website_promo_block_click_through_daily.sum_promo_views desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
    show_row_numbers: false
    series_labels:
      spree_promo_block_info.promo_block_image: Image
      website_promo_block_click_through_daily.page_urlpath: URL
      spree_promo_block_info.name: Promo Block Name
      spree_promo_block_info.cta_link: Link URL
      spree_promo_block_info.promo_block_position: Position
      website_promo_block_click_through_daily.sum_promo_views: Views
      website_promo_block_click_through_daily.sum_promo_clicks: Clicks
      website_promo_block_click_through_daily.click_through_rate: CTR
    top: 32
    left: -3
    height: 5
    width: 9

  - name: final_call_skirts_and_trousers_category_promo_blocks
    title: Final Call Skirts & Trousers Category Promo Blocks
    type: table
    model: finery_data
    explore: website_promo_block_click_through_daily
    dimensions: [spree_promo_block_info.promo_block_image, website_promo_block_click_through_daily.page_urlpath,
      spree_promo_block_info.name, spree_promo_block_info.cta_link, spree_promo_block_info.promo_block_position]
    measures: [website_promo_block_click_through_daily.sum_promo_views, website_promo_block_click_through_daily.sum_promo_clicks,
      website_promo_block_click_through_daily.click_through_rate]
    filters:
      spree_promo_block_info.placements: taxon^_listing
      website_promo_block_click_through_daily.page_urlpath: /t/final-call/skirts-and-trousers/
      website_promo_block_click_through_daily.sum_promo_views: '>100'
    listen:
     date: website_promo_block_click_through_daily.calendar_date
    sorts: [website_promo_block_click_through_daily.sum_promo_views desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
    show_row_numbers: false
    series_labels:
      spree_promo_block_info.promo_block_image: Image
      website_promo_block_click_through_daily.page_urlpath: URL
      spree_promo_block_info.name: Promo Block Name
      spree_promo_block_info.cta_link: Link URL
      spree_promo_block_info.promo_block_position: Position
      website_promo_block_click_through_daily.sum_promo_views: Views
      website_promo_block_click_through_daily.sum_promo_clicks: Clicks
      website_promo_block_click_through_daily.click_through_rate: CTR
    top: 32
    left: 6
    height: 5
    width: 9

  - name: final_call_accessories_category_promo_blocks
    title: Final Call Accessories Category Promo Blocks
    type: table
    model: finery_data
    explore: website_promo_block_click_through_daily
    dimensions: [spree_promo_block_info.promo_block_image, website_promo_block_click_through_daily.page_urlpath,
      spree_promo_block_info.name, spree_promo_block_info.cta_link, spree_promo_block_info.promo_block_position]
    measures: [website_promo_block_click_through_daily.sum_promo_views, website_promo_block_click_through_daily.sum_promo_clicks,
      website_promo_block_click_through_daily.click_through_rate]
    filters:
      spree_promo_block_info.placements: taxon^_listing
      website_promo_block_click_through_daily.page_urlpath: /t/final-call/accessories/
      website_promo_block_click_through_daily.sum_promo_views: '>100'
    listen:
     date: website_promo_block_click_through_daily.calendar_date
    sorts: [website_promo_block_click_through_daily.sum_promo_views desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
    show_row_numbers: false
    series_labels:
      spree_promo_block_info.promo_block_image: Image
      website_promo_block_click_through_daily.page_urlpath: URL
      spree_promo_block_info.name: Promo Block Name
      spree_promo_block_info.cta_link: Link URL
      spree_promo_block_info.promo_block_position: Position
      website_promo_block_click_through_daily.sum_promo_views: Views
      website_promo_block_click_through_daily.sum_promo_clicks: Clicks
      website_promo_block_click_through_daily.click_through_rate: CTR
    top: 37
    left: -3
    height: 5
    width: 9

  - name: final_call_outerwear_category_promo_blocks
    title: Final Call Outerwear Category Promo Blocks
    type: table
    model: finery_data
    explore: website_promo_block_click_through_daily
    dimensions: [spree_promo_block_info.promo_block_image, website_promo_block_click_through_daily.page_urlpath,
      spree_promo_block_info.name, spree_promo_block_info.cta_link, spree_promo_block_info.promo_block_position]
    measures: [website_promo_block_click_through_daily.sum_promo_views, website_promo_block_click_through_daily.sum_promo_clicks,
      website_promo_block_click_through_daily.click_through_rate]
    filters:
      spree_promo_block_info.placements: taxon^_listing
      website_promo_block_click_through_daily.page_urlpath: /t/final-call/jackets-and-coats/
      website_promo_block_click_through_daily.sum_promo_views: '>100'
    listen:
     date: website_promo_block_click_through_daily.calendar_date
    sorts: [website_promo_block_click_through_daily.sum_promo_views desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
    show_row_numbers: false
    series_labels:
      spree_promo_block_info.promo_block_image: Image
      website_promo_block_click_through_daily.page_urlpath: URL
      spree_promo_block_info.name: Promo Block Name
      spree_promo_block_info.cta_link: Link URL
      spree_promo_block_info.promo_block_position: Position
      website_promo_block_click_through_daily.sum_promo_views: Views
      website_promo_block_click_through_daily.sum_promo_clicks: Clicks
      website_promo_block_click_through_daily.click_through_rate: CTR
    top: 37
    left: 6
    height: 5
    width: 9

  - name: product_page_promo_blocks
    title: Product Page Promo Blocks
    type: table
    model: finery_data
    explore: website_promo_block_click_through_daily
    dimensions: [spree_promo_block_info.promo_block_image, spree_promo_block_info.name,
      spree_promo_block_info.cta_link]
    measures: [website_promo_block_click_through_daily.sum_promo_views, website_promo_block_click_through_daily.sum_promo_clicks,
      website_promo_block_click_through_daily.click_through_rate]
    filters:
      spree_promo_block_info.placements: product^_posts
      website_promo_block_click_through_daily.sum_promo_views: '>100'
    listen:
     date: website_promo_block_click_through_daily.calendar_date
    sorts: [website_promo_block_click_through_daily.sum_promo_views desc]
    limit: '500'
    column_limit: '50'
    query_timezone: Europe/London
    show_row_numbers: false
    series_labels:
      spree_promo_block_info.promo_block_image: Image
      website_promo_block_click_through_daily.page_urlpath: URL
      spree_promo_block_info.name: Promo Block Name
      spree_promo_block_info.cta_link: Link URL
      spree_promo_block_info.promo_block_position: Position
      website_promo_block_click_through_daily.sum_promo_views: Views
      website_promo_block_click_through_daily.sum_promo_clicks: Clicks
      website_promo_block_click_through_daily.click_through_rate: CTR
    top: 43
    left: 1
    height: 5
    width: 10
