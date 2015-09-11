- view: website_page_views
  derived_table:
    sql: |
          WITH step_1 AS
          (
            SELECT * FROM atomic.events WHERE app_id = 'production'
          ),
          step_2 AS
          (
            SELECT *,
                   CASE
                     WHEN LEFT (page_urlpath,1) = '/' AND SUBSTRING(page_urlpath,4,1) = '/' THEN RIGHT (page_urlpath,len (page_urlpath) - 3)
                     WHEN LEFT (page_urlpath,1) = '/' AND LENGTH(page_urlpath) = 3 THEN '/'
                     ELSE page_urlpath
                   END AS page_urlpath_adj
            FROM step_1
          ),
          step_3 AS
          (
            SELECT domain_userid,
                   domain_userid || domain_sessionidx AS session_id,
                   collector_tstamp,
                   page_urlpath,
                   page_urlpath_adj,
                   page_url,
                   page_urlscheme,
                   page_urlhost,
                   page_urlport,
                   page_urlquery,
                   page_urlfragment,
                   ROW_NUMBER() OVER (PARTITION BY domain_userid || domain_sessionidx ORDER BY collector_tstamp ASC,dvce_tstamp ASC) AS event_index
            FROM step_2
          ),
          step_4 AS
          (
            SELECT *,
                   LAG(page_urlpath_adj,1) OVER (PARTITION BY session_id ORDER BY event_index ASC) AS previous_page_urlpath_adj
            FROM step_3
          ),
          step_5 AS
          (
            SELECT *,
                   ROW_NUMBER() OVER (PARTITION BY session_id ORDER BY event_index ASC) AS page_view_index
            FROM step_4
            WHERE page_urlpath_adj != previous_page_urlpath_adj
          ),
          step_6 AS
          (
            SELECT domain_userid,
                   session_id,
                   page_view_index,
                   collector_tstamp AS page_entry_tstamp,
                   LEAD(collector_tstamp,1) OVER (PARTITION BY session_id ORDER BY page_view_index ASC) AS page_exit_tstamp,
                   page_url,
                   page_urlpath AS original_page_urlpath,
                   page_urlpath_adj AS page_urlpath,
                   LAG(page_urlpath_adj,1) OVER (PARTITION BY session_id ORDER BY page_view_index ASC) AS previous_page_urlpath,
                   LEAD(page_urlpath_adj,1) OVER (PARTITION BY session_id ORDER BY page_view_index ASC) AS next_page_urlpath,
                   CASE
                     WHEN page_urlpath LIKE '%/products/%' THEN RIGHT (page_urlpath,(LENGTH(page_urlpath) -(POSITION('/products/' IN page_urlpath) + 9)))
                     ELSE NULL
                   END AS product_slug
            FROM step_5
          ),
          step_7 AS
          (
            SELECT slug,
                   prod_id
            FROM (SELECT slug,
                         FIRST_VALUE(id) OVER (PARTITION BY slug ORDER BY spree_timestamp DESC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS prod_id
                  FROM daily_snapshot.spree_products
                  WHERE deleted_at IS NULL)
            GROUP BY 1,
                     2
          )
          SELECT *
          FROM step_6 page_views
            LEFT JOIN step_7 prod_lookup ON page_views.product_slug = prod_lookup.slug



    sql_trigger_value: SELECT COUNT(*) FROM atomic.events
    distkey: domain_userid
    sortkeys: [domain_userid, page_entry_tstamp]

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
  
  
  
  