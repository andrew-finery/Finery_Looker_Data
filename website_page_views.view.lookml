- view: website_page_views
  sql_table_name: website_data.page_views

  fields:

########### DIMENSIONS

  - dimension: domain_userid
    sql: ${TABLE}.domain_userid

  - dimension: session_id
    sql: ${TABLE}.session_id

  - dimension: page_view_index
    type: number
    sql: ${TABLE}.page_view_index

  - dimension_group: page_entry_tstamp
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.page_entry_tstamp

  - dimension_group: page_exit_tstamp
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.page_exit_tstamp
    hidden: true

  - dimension: page_url
    sql: ${TABLE}.page_url
    hidden: true

  - dimension: original_page_urlpath
    sql: ${TABLE}.original_page_urlpath
    hidden: true

  - dimension: page_urlpath
    sql: ${TABLE}.page_urlpath

  - dimension: previous_page_urlpath
    sql: ${TABLE}.previous_page_urlpath

  - dimension: next_page_urlpath
    sql: ${TABLE}.next_page_urlpath

  - dimension: product_slug
    sql: ${TABLE}.product_slug
    hidden: true

  - dimension: slug
    sql: ${TABLE}.slug
    hidden: true

  - dimension: prod_id
    type: number
    sql: ${TABLE}.prod_id
  
  - dimension: page_type
    sql_case:
      Homepage: ${page_urlpath} in ('/', '//')
      Category Page: ${page_urlpath} like '%/t/%'
      Product Page: ${page_urlpath} like '%/products/%'
      Chapters Page: ${page_urlpath} = '/chapters'
      Editorial: ${page_urlpath} like '%/chapters/%'
      Cart: ${page_urlpath} = '/cart'
      Checkout: ${page_urlpath} = '/checkout'
      Order Complete: ${page_urlpath} like '/orders/%'
      else: Other

  - dimension: previous_page_type
    sql_case:
      Homepage: ${previous_page_urlpath} in ('/', '//')
      Category Page: ${previous_page_urlpath} like '%/t/%'
      Product Page: ${previous_page_urlpath} like '%/products/%'
      Chapters Page: ${previous_page_urlpath} = '/chapters'
      Editorial: ${previous_page_urlpath} like '%/chapters/%'
      Cart: ${previous_page_urlpath} = '/cart'
      Checkout: ${previous_page_urlpath} = '/checkout'
      Order Complete: ${previous_page_urlpath} like '/orders/%'
      else: Other

  - dimension: next_page_type
    sql_case:
      Homepage: ${next_page_urlpath} in ('/', '//')
      Category Page: ${next_page_urlpath} like '%/t/%'
      Product Page: ${next_page_urlpath} like '%/products/%'
      Chapters Page: ${next_page_urlpath} = '/chapters'
      Editorial: ${next_page_urlpath} like '%/chapters/%'
      Cart: ${next_page_urlpath} = '/cart'
      Checkout: ${next_page_urlpath} = '/checkout'
      Order Complete: ${next_page_urlpath} like '/orders/%'
      else: Other
  
  - dimension: landing_page_flag
    type: yesno
    sql: ${previous_page_urlpath} is null
    
  - dimension: exit_page_flag
    type: yesno
    sql: ${next_page_urlpath} is null
  
  - dimension: bounce_flag
    type: yesno
    sql: ${previous_page_urlpath} is null and ${next_page_urlpath} is null
    
########### MEASURES
  
  - measure: count_total_page_views
    type: count

  - measure: count_distinct_page_views
    type: count_distinct
    sql: ${session_id} || ${page_urlpath}

  - measure: count_sessions
    type: count_distinct
    sql: ${session_id}
    
  - measure: count_exits
    type: count
    filters:
      exit_page_flag: yes
  
  - measure: count_bounces
    type: count
    filters:
      bounce_flag: yes

  - measure: count_lands
    type: count
    filters:
      landing_page_flag: yes

  - measure: count_urls
    type: count_distinct
    sql: ${page_urlpath}

  - measure: exit_rate
    type: number
    decimals: 4
    sql: ${count_exits}/NULLIF(${count_total_page_views},0)::REAL
    value_format: '#0.00%'

  - measure: bounce_rate
    type: number
    decimals: 4
    sql: ${count_bounces}/NULLIF(${count_lands},0)::REAL
    value_format: '#0.00%'
    
  - measure: click_through_rate_any_page
    type: number
    decimals: 4
    sql: 1 - ${exit_rate}
    value_format: '#0.00%'

  - measure: count_next_page_product_views
    type: count
    filters:
      next_page_type: Product Page
    hidden: true
    
  - measure: click_through_rate_product_page
    type: number
    decimals: 4
    sql: ${count_next_page_product_views}/NULLIF(${count_total_page_views},0)::REAL
    value_format: '#0.00%'  
  
  
  
  