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

  - dimension: target_url_adjusted_for_country
    label: Target URL
    sql: |
        case

        when ${TABLE}.target_url like '%/uk' then replace(${TABLE}.target_url, '/uk', '/')
        when ${TABLE}.target_url like '%/uk#' then replace(${TABLE}.target_url, '/uk', '/')
        when ${TABLE}.target_url like '%/uk/%' then replace(${TABLE}.target_url, '/uk/', '/')
        
        when ${TABLE}.target_url like '%/us' then replace(${TABLE}.target_url, '/us', '/')
        when ${TABLE}.target_url like '%/us#' then replace(${TABLE}.target_url, '/us', '/')
        when ${TABLE}.target_url like '%/us/%' then replace(${TABLE}.target_url, '/us/', '/')
        
        when ${TABLE}.target_url like '%/ie' then replace(${TABLE}.target_url, '/ie', '/')
        when ${TABLE}.target_url like '%/ie#' then replace(${TABLE}.target_url, '/ie', '/')
        when ${TABLE}.target_url like '%/ie/%' then replace(${TABLE}.target_url, '/ie/', '/')
        
        when ${TABLE}.target_url like '%/au' then replace(${TABLE}.target_url, '/au', '/')
        when ${TABLE}.target_url like '%/au#' then replace(${TABLE}.target_url, '/au', '/')
        when ${TABLE}.target_url like '%/au/%' then replace(${TABLE}.target_url, '/au/', '/')
        
        when ${TABLE}.target_url like '%/ca' then replace(${TABLE}.target_url, '/ca', '/')
        when ${TABLE}.target_url like '%/ca#' then replace(${TABLE}.target_url, '/ca', '/')
        when ${TABLE}.target_url like '%/ca/%' then replace(${TABLE}.target_url, '/ca/', '/')
        
        when ${TABLE}.target_url like '%/sg' then replace(${TABLE}.target_url, '/sg', '/')
        when ${TABLE}.target_url like '%/sg#' then replace(${TABLE}.target_url, '/sg', '/')
        when ${TABLE}.target_url like '%/sg/%' then replace(${TABLE}.target_url, '/sg/', '/')
        
        when ${TABLE}.target_url like '%/hk' then replace(${TABLE}.target_url, '/hk', '/')
        when ${TABLE}.target_url like '%/hk#' then replace(${TABLE}.target_url, '/hk', '/')
        when ${TABLE}.target_url like '%/hk/%' then replace(${TABLE}.target_url, '/hk/', '/')
        
        when ${TABLE}.target_url like '%/ae' then replace(${TABLE}.target_url, '/ae', '/')
        when ${TABLE}.target_url like '%/ae#' then replace(${TABLE}.target_url, '/ae', '/')
        when ${TABLE}.target_url like '%/ae/%' then replace(${TABLE}.target_url, '/ae/', '/')
        
        else ${TABLE}.target_url
        
        end

  - measure: link_clicks_count
    type: number
    sql: approximate count(distinct ${root_id})

  - measure: link_clicks
    label: Link Clicks %
    type: percent_of_total
    sql: ${link_clicks_count}