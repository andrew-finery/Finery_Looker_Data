- view: snowplow_link_clicks
  sql_table_name: atomic.com_snowplowanalytics_snowplow_link_click_1
  fields:

  - dimension: element_classes
    label: Link Class
    sql: ${TABLE}.element_classes
    
  - dimension: element_id
    sql: ${TABLE}.element_id
    hidden: true
  
  - dimension: link_type
    sql_case:
      Homepage Hero Image: ${element_classes} like '%homepage-promotion-banner%'
      Navigation Link: ${element_classes} like '%navigation__link%' or ${element_classes} like '%country-selector%' or ${element_classes} like '%social__hashtag--footer%'
      Product Size Guide: ${element_classes} like '%product__size-guide%'
      Finery Logo: ${element_classes} like '%finery-logo%'
      Promotion Link: ${element_classes} like '%promotion__link%'
      Taxon Promotion Link: ${element_classes} like '%taxon-promotion%'
      else: Other

  - dimension: link_type_2
    sql_case:
      Close Popup: ${element_classes} like '%icon-close%'
      Close Sale Pop-Up: ${element_classes} like '%modal-window-close%'
      No Thanks Button on Sale Pop-Up: ${element_classes} like '%soft-locked-modal__no-thanks%'
      Mini Basket - Checkout: ${element_classes} like '%basket__checkout%'
      Social Link: ${element_classes} like '%social__hashtag--footer%' or ${element_classes} = '["social__link","js-social-footer-link"]'
      else: Other
    hidden: true
      
  - dimension: element_target
    sql: ${TABLE}.element_target

  - dimension: root_id
    sql: ${TABLE}.root_id
    hidden: true

  - dimension_group: root_tstamp
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.root_tstamp
    hidden: true
    
  - dimension: target_url
    sql: ${TABLE}.target_url
    hidden: true
  
  - dimension: target_url_query_string_removed
    sql: |
          case
          when charindex('?', target_url) = 0 then target_url
          else left(target_url, charindex('?', target_url) - 1)
          end
    hidden: true
  
  - dimension: target_url_adjusted_for_country
    label: Target URL
    sql: |
        case

        when ${target_url_query_string_removed} like '%/uk' then replace(${target_url_query_string_removed}, '/uk', '/')
        when ${target_url_query_string_removed} like '%/uk#' then replace(${target_url_query_string_removed}, '/uk', '/')
        when ${target_url_query_string_removed} like '%/uk/%' then replace(${target_url_query_string_removed}, '/uk/', '/')
        
        when ${target_url_query_string_removed} like '%/us' then replace(${target_url_query_string_removed}, '/us', '/')
        when ${target_url_query_string_removed} like '%/us#' then replace(${target_url_query_string_removed}, '/us', '/')
        when ${target_url_query_string_removed} like '%/us/%' then replace(${target_url_query_string_removed}, '/us/', '/')
        
        when ${target_url_query_string_removed} like '%/ie' then replace(${target_url_query_string_removed}, '/ie', '/')
        when ${target_url_query_string_removed} like '%/ie#' then replace(${target_url_query_string_removed}, '/ie', '/')
        when ${target_url_query_string_removed} like '%/ie/%' then replace(${target_url_query_string_removed}, '/ie/', '/')
        
        when ${target_url_query_string_removed} like '%/au' then replace(${target_url_query_string_removed}, '/au', '/')
        when ${target_url_query_string_removed} like '%/au#' then replace(${target_url_query_string_removed}, '/au', '/')
        when ${target_url_query_string_removed} like '%/au/%' then replace(${target_url_query_string_removed}, '/au/', '/')
        
        when ${target_url_query_string_removed} like '%/ca' then replace(${target_url_query_string_removed}, '/ca', '/')
        when ${target_url_query_string_removed} like '%/ca#' then replace(${target_url_query_string_removed}, '/ca', '/')
        when ${target_url_query_string_removed} like '%/ca/%' then replace(${target_url_query_string_removed}, '/ca/', '/')
        
        when ${target_url_query_string_removed} like '%/sg' then replace(${target_url_query_string_removed}, '/sg', '/')
        when ${target_url_query_string_removed} like '%/sg#' then replace(${target_url_query_string_removed}, '/sg', '/')
        when ${target_url_query_string_removed} like '%/sg/%' then replace(${target_url_query_string_removed}, '/sg/', '/')
        
        when ${target_url_query_string_removed} like '%/hk' then replace(${target_url_query_string_removed}, '/hk', '/')
        when ${target_url_query_string_removed} like '%/hk#' then replace(${target_url_query_string_removed}, '/hk', '/')
        when ${target_url_query_string_removed} like '%/hk/%' then replace(${target_url_query_string_removed}, '/hk/', '/')
        
        when ${target_url_query_string_removed} like '%/ae' then replace(${target_url_query_string_removed}, '/ae', '/')
        when ${target_url_query_string_removed} like '%/ae#' then replace(${target_url_query_string_removed}, '/ae', '/')
        when ${target_url_query_string_removed} like '%/ae/%' then replace(${target_url_query_string_removed}, '/ae/', '/')
        
        else ${target_url_query_string_removed}
        
        end
  
  - dimension: target_url_type
    label: Target URL Type
    sql_case:
      Homepage: ${target_url_adjusted_for_country} in ('/', '//')
      Product Listing Page: ${target_url} like '%/t/%'
      Product Detail Page: ${target_url} like '%/products/%'
      Chapters Home: ${target_url_adjusted_for_country} = '/chapters'
      Editorial: ${target_url} like '%/chapters/%'
      Cart: ${target_url_adjusted_for_country} = '/cart'
      Checkout: ${target_url_adjusted_for_country} = '/checkout'
      Order Complete: ${target_url} like '/orders/%'
      else: Other
  
  - measure: link_clicks_count
    type: count_distinct
    sql: ${root_id}
  
  - measure: sessions_with_product_click_count
    type: count_distinct
    sql: ${atomic_events.session_id}
    filters:
      target_url_type: Product Detail Page
  
  - measure: distinct_product_clicks_count
    type: count_distinct
    sql: ${target_url_adjusted_for_country}
    filters:
      target_url_type: Product Detail Page


  - measure: link_clicks
    label: Link Clicks %
    type: percent_of_total
    sql: ${link_clicks_count}
    