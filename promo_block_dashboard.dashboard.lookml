- dashboard: promo_block_dashboard
  title: Promo Block Dashboard
  layout: static
  tile_size: 100



  elements:
  - name: promo_block_performance_total
    title: HP Promo Block Performance (Last 7 Days)
    model: finery_data
    explore: website_promo_block_click_through_daily
    type: table
    fields: [spree_promo_block_info.promo_block_image, spree_promo_block_info.promo_block_position,
      spree_promo_block_info.cta_link, spree_promo_block_info.name, website_promo_block_click_through_daily.sum_promo_views,
      website_promo_block_click_through_daily.sum_promo_clicks, website_promo_block_click_through_daily.click_through_rate]
    filters:
      website_promo_block_click_through_daily.page_urlpath: "/"
      website_promo_block_click_through_daily.calendar_date: 7 days
      spree_promo_block_info.name: HP%
    sorts: [spree_promo_block_info.promo_block_position]
    limit: 500
    query_timezone: Europe/London
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_labels:
      website_promo_block_click_through_daily.click_through_rate: CTR
      website_promo_block_click_through_daily.sum_promo_clicks: Clicks
      website_promo_block_click_through_daily.sum_promo_views: Views
    width: 14
    height: 25
    top: 0
    left: 0


  - name: promo_block_performance_by_device
    title: HP Promo Block Performance - By Device (Last 7 Days)
    model: finery_data
    explore: website_promo_block_click_through_daily
    type: table
    fields: [spree_promo_block_info.promo_block_image,
      spree_promo_block_info.promo_block_position, spree_promo_block_info.cta_link,
      website_promo_block_click_through_daily.click_through_rate, website_promo_block_click_through_daily.sum_promo_clicks,
      website_promo_block_click_through_daily.sum_promo_views,
      website_promo_block_click_through_daily.device_type]
    pivots: [website_promo_block_click_through_daily.device_type]
    filters:
      website_promo_block_click_through_daily.page_urlpath: "/"
      website_promo_block_click_through_daily.calendar_date: 7 days
      spree_promo_block_info.name: HP%
    sorts: [website_promo_block_click_through_daily.page_urlpath, website_promo_block_click_through_daily.device_type]
    limit: 500
    query_timezone: Europe/London
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    conditional_formatting: [{type: low to high, value: !!null '', background_color: !!null '',
        font_color: !!null '', palette: {name: Custom, colors: ["#F36254", "#f9435d",
            "#4FBC89"]}, bold: false, italic: false, strikethrough: false, fields: [
          website_promo_block_click_through_daily.click_through_rate]}, {type: low to
          high, value: !!null '', background_color: !!null '', font_color: !!null '',
        palette: {name: Red to Yellow to Green, colors: ["#F36254", "#FCF758", "#4FBC89"]},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    width: 14
    height: 25
    top: 25
    left: 0
