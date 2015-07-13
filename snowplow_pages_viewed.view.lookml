- view: snowplow_pages_viewed
  derived_table:
    sql: |
        select
        
          domain_userid,
          domain_sessionidx,
          page_url,
          page_urlhost,
          page_urlpath,
          page_urlquery,
          
          replace(
          case
          when page_urlpath like '%/uk' then replace(page_urlpath, '/uk', '/')
          when page_urlpath like '%/uk/%' then replace(page_urlpath, '/uk/', '/')
          
          when page_urlpath like '%/us' then replace(page_urlpath, '/us', '/')
          when page_urlpath like '%/us/%' then replace(page_urlpath, '/us/', '/')
          
          when page_urlpath like '%/ie' then replace(page_urlpath, '/ie', '/')
          when page_urlpath like '%/ie/%' then replace(page_urlpath, '/ie/', '/')
          
          when page_urlpath like '%/au' then replace(page_urlpath, '/au', '/')
          when page_urlpath like '%/au/%' then replace(page_urlpath, '/au/', '/')
          
          when page_urlpath like '%/ca' then replace(page_urlpath, '/ca', '/')
          when page_urlpath like '%/ca/%' then replace(page_urlpath, '/ca/', '/')
          
          when page_urlpath like '%/sg' then replace(page_urlpath, '/sg', '/')
          when page_urlpath like '%/sg/%' then replace(page_urlpath, '/sg/', '/')
          
          when page_urlpath like '%/hk' then replace(page_urlpath, '/hk', '/')
          when page_urlpath like '%/hk/%' then replace(page_urlpath, '/hk/', '/')
          
          when page_urlpath like '%/ae' then replace(page_urlpath, '/ae', '/')
          when page_urlpath like '%/ae/%' then replace(page_urlpath, '/ae/', '/')
          
          else page_urlpath end
          ,'//', '/')
          as page_urlpath_country_removed,
          
          case
          when page_urlpath in ('/', '//', '/uk', '/uk/', '/us', '/us/', '/ie', '/ie/', '/ca', '/ca/', '/hk', '/hk/', '/ae', '/ae/','/sg', '/sg/','/au', '/au/') or page_urlpath is null then 'Homepage'
          when page_urlpath like '%/products/%' then 'Product Page'
          when page_urlpath like '%/orders/%' then 'Order Confirmation Page'
          when page_urlpath like '%/cart%' then 'Cart Page'
          when page_urlpath like '%/chapters' or page_urlpath like '%/chapters/' then 'Chapters Page'
          when page_urlpath like '%/chapters/%' then 'Editorial Page'
          when page_urlpath like '%/checkout/registration' then 'Checkout - Registration Page'
          when page_urlpath like '%/checkout' or page_urlpath like '%checkout/address' or page_urlpath like '%checkout/update/address' then 'Checkout - Address Page'
          when page_urlpath like '%/checkout/delivery' or page_urlpath like '%/checkout/update/delivery' then 'Checkout - Delivery Page'
          when page_urlpath like '%/checkout/payment' or page_urlpath like '%/checkout/update/payment' then 'Checkout - Payment Page'
          when page_urlpath like '%/404' then '404 Page'
          when page_urlpath like '%/wishlist' then 'Wishlist Page'
          when page_urlpath like '%/t/%' then 'Category Page'
          else 'Other' end as page_type,
          
          case
          when page_urlpath like '%/t/dresses%' then 'Dresses'
          when page_urlpath like '%/t/the-full-collection%' then 'The Edit'
          when page_urlpath like '%/t/tops%' then 'Tops'
          when page_urlpath like '%/t/shoes%' then 'Shoes'
          when page_urlpath like '%/t/skirts-and-trousers%' then 'Skirts and Trousers'
          when page_urlpath like '%/t/jackets-and-coats%' then 'Jackets & Coats'
          when page_urlpath like '%/t/accessories%' then 'Accessories'
          when page_urlpath like '%/t/knitwear%' then 'Knitwear'
          when page_urlpath like '%/t/florals-reimagined%' then 'Florals Reimagined'
          when page_urlpath like '%/t/final-call' then 'Sale Home'
          when page_urlpath like '%/t/final-call/' then 'Sale Home'
          when page_urlpath like '%/t/finery-picks%' then 'Finery Picks'
          when page_urlpath like '%/t/final-call/dresses%' then 'Sale Dresses'
          when page_urlpath like '%/t/final-call/shoes%' then 'Sale Shoes'
          when page_urlpath like '%/t/final-call/knitwear%' then 'Sale Tops'
          when page_urlpath like '%/t/final-call/skirts-and-trousers%' then 'Sale Skirts & Trousers'
          when page_urlpath like '%/t/final-call/jackets-and-coats%' then 'Sale Jackets & Coats'
          when page_urlpath like '%/t/jewellery%' then 'Jewellery'
          when page_urlpath like '%/t/final-call/accessories%' then 'Sale Accessories'
          when page_urlpath like '%/t/final-call/finery-picks%' then 'Sale Picks'
          when page_urlpath like '%/t/final-call/all%' then 'All Sale'
          when page_urlpath like '%/t/clothing/dresses%' then 'Dresses'
          when page_urlpath like '%/t/clothing/the-full-collection%' then 'The Edit'
          when page_urlpath like '%/t/clothing/tops%' then 'Tops'
          when page_urlpath like '%/t/clothing/shoes%' then 'Shoes'
          when page_urlpath like '%/t/clothing/skirts-and-trousers%' then 'Skirts and Trousers'
          when page_urlpath like '%/t/clothing/jackets-and-coats%' then 'Jackets & Coats'
          when page_urlpath like '%/t/clothing/accessories%' then 'Accessories'
          else 'Other' end as category_page_type,                  

          convert_timezone('UTC', 'Europe/London', min(collector_tstamp)) as time_stamp,
          rank() over (partition by domain_userid || domain_sessionidx order by time_stamp asc) as page_number
          from atomic.events
          where app_id = 'production'
          group by 1,2,3,4,5,6,7,8,9
      
    sql_trigger_value: SELECT COUNT(*) FROM ${visitors.SQL_TABLE_NAME}
    distkey: domain_userid
    sortkeys: [domain_userid, domain_sessionidx, time_stamp]

  fields:
  
# Dimensions

  - dimension: domain_user_id
    sql: ${TABLE}.domain_userid
    hidden: true
      
  - dimension: domain_session_index
    sql: ${TABLE}.domain_sessionidx
    hidden: true
    
  - dimension: session_id
    sql: ${domain_user_id} || '-' || ${domain_session_index}
    hidden: true

  - dimension_group: page_first_viewed
    type: time
    timeframes: [time, hour, date, hour_of_day, day_of_week, week, month]
    sql: ${TABLE}.time_stamp
  
  - dimension: page_type
    sql: ${TABLE}.page_type

  - dimension: category_page_type
    sql: ${TABLE}.category_page_type
  
  - dimension: page_url_path
    sql: ${TABLE}.page_urlpath_country_removed
    
  - dimension: page_number
    sql: ${TABLE}.page_number

# Measures
    
  - measure: count_page_views
    type: count_distinct
    sql: ${session_id} || ${page_url_path}
    
    