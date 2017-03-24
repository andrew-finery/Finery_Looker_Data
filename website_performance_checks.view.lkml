view: website_performance_checks {
  sql_table_name: web.site_performance_checks ;;

  dimension: avoid_landing_page_redirects {
    type: number
    sql: ${TABLE}.avoid_landing_page_redirects ;;
    hidden: yes
  }

  dimension_group: calendar {
    type: time
    timeframes: [date, week, month, year]
    convert_tz: no
    sql: ${TABLE}.calendar_date ;;
  }

  dimension: css_response_bytes {
    type: number
    sql: cast(${TABLE}.css_response_bytes as integer) ;;
    hidden: yes
  }

  dimension: enable_gzip_compression {
    type: number
    sql: ${TABLE}.enable_gzip_compression ;;
    hidden: yes
  }

  dimension: html_response_bytes {
    type: number
    sql: cast(${TABLE}.html_response_bytes as integer) ;;
    hidden: yes
  }

  dimension: image_response_bytes {
    type: number
    sql: cast(${TABLE}.image_response_bytes as integer) ;;
    hidden: yes
  }

  dimension: javascript_response_bytes {
    type: number
    sql: cast(${TABLE}.javascript_response_bytes as integer) ;;
    hidden: yes
  }

  dimension: leverage_browser_caching {
    type: number
    sql: ${TABLE}.leverage_browser_caching ;;
    hidden: yes
  }

  dimension: main_resource_server_response_time {
    type: number
    sql: ${TABLE}.main_resource_server_response_time ;;
    hidden: yes
  }

  dimension: minify_css {
    type: number
    sql: ${TABLE}.minify_css ;;
    hidden: yes
  }

  dimension: minify_html {
    type: number
    sql: ${TABLE}.minify_html ;;
    hidden: yes
  }

  dimension: minify_java_script {
    type: number
    sql: ${TABLE}.minify_java_script ;;
    hidden: yes
  }

  dimension: minimize_render_blocking_resources {
    type: number
    sql: ${TABLE}.minimize_render_blocking_resources ;;
    hidden: yes
  }

  dimension: number_css_resources {
    type: number
    sql: ${TABLE}.number_css_resources ;;
    hidden: yes
  }

  dimension: number_hosts {
    type: number
    sql: ${TABLE}.number_hosts ;;
    hidden: yes
  }

  dimension: number_js_resources {
    type: number
    sql: ${TABLE}.number_js_resources ;;
    hidden: yes
  }

  dimension: number_resources {
    type: number
    sql: ${TABLE}.number_resources ;;
    hidden: yes
  }

  dimension: number_static_resources {
    type: number
    sql: ${TABLE}.number_static_resources ;;
    hidden: yes
  }

  dimension: optimize_images {
    type: number
    sql: ${TABLE}.optimize_images ;;
    hidden: yes
  }

  dimension: other_response_bytes {
    type: number
    sql: cast(${TABLE}.other_response_bytes as integer) ;;
    hidden: yes
  }

  dimension: platform {
    type: string
    sql: ${TABLE}.platform ;;
  }

  dimension: prioritize_visible_content {
    type: number
    sql: ${TABLE}.prioritize_visible_content ;;
    hidden: yes
  }

  dimension: screenshot {
    type: string
    sql: ${TABLE}.screenshot ;;
    html: <img src="{{value}}" height="240" width="320"/>
      ;;
  }

  dimension: speed {
    type: number
    sql: ${TABLE}.speed ;;
    hidden: yes
  }

  dimension: text_response_bytes {
    type: string
    sql: ${TABLE}.text_response_bytes ;;
    hidden: yes
  }

  dimension: total_request_bytes {
    type: number
    sql: cast(${TABLE}.total_request_bytes as integer) ;;
    hidden: yes
  }

  dimension: url {
    type: string
    sql: ${TABLE}.url ;;
  }

  dimension: page_type {
    sql: case
      when ${url} like '%/products/%' then 'Product Page'
      when ${url} like '%/t/%' then 'Category Page'
      when ${url} = 'https://www.finerylondon.com/' then 'Home Page'
      else ${url} end
       ;;
  }

  dimension: usability {
    type: number
    sql: ${TABLE}.usability ;;
    hidden: yes
  }

  dimension: response_time {
    type: number
    sql: ${TABLE}.avg_response_time ;;
    hidden: yes
  }

  dimension: queries_per_second {
    type: number
    sql: ${TABLE}.queries_per_second ;;
    hidden: yes
  }

  dimension: failed_requests {
    type: number
    sql: ${TABLE}.failed_requests ;;
    hidden: yes
  }

  ## Measures

  measure: count_checks {
    type: count
  }

  measure: average_site_speed {
    type: average
    sql: ${speed} ;;
  }

  measure: average_number_of_resources {
    type: average
    sql: ${number_resources} ;;
  }

  measure: average_number_of_js_resources {
    type: average
    sql: ${number_js_resources} ;;
  }

  measure: average_total_request_bytes {
    type: average
    sql: ${total_request_bytes} ;;
  }

  measure: average_text_response_bytes {
    type: average
    sql: ${text_response_bytes} ;;
  }

  measure: average_css_response_bytes {
    type: average
    sql: ${css_response_bytes} ;;
  }

  measure: average_html_response_bytes {
    type: average
    sql: ${html_response_bytes} ;;
  }

  measure: average_image_response_bytes {
    type: average
    sql: ${image_response_bytes} ;;
  }

  measure: average_javascript_response_bytes {
    type: average
    sql: ${javascript_response_bytes} ;;
  }

  measure: average_other_response_bytes {
    type: average
    sql: ${other_response_bytes} ;;
  }

  measure: average_response_time {
    type: average
    sql: ${response_time} ;;
  }

  measure: average_queries_per_second {
    type: average
    sql: ${queries_per_second} ;;
  }

  measure: average_failed_requests {
    type: average
    sql: ${failed_requests} ;;
  }
}
