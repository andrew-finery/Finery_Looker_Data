view: snowplow_link_clicks {
  sql_table_name: atomic.com_snowplowanalytics_snowplow_link_click_1 ;;

  dimension: element_classes {
    label: "Link Class"
    sql: ${TABLE}.element_classes ;;
  }

  dimension: element_id {
    sql: ${TABLE}.element_id ;;
    hidden: yes
  }

  dimension: link_type {
    case: {
      when: {
        sql: ${element_classes} like '%homepage-promotion-banner%' ;;
        label: "Homepage Hero Image"
      }

      when: {
        sql: ${element_classes} like '%navigation__link%' or ${element_classes} like '%country-selector%' or ${element_classes} like '%social__hashtag--footer%' ;;
        label: "Navigation Link"
      }

      when: {
        sql: ${element_classes} like '%product__size-guide%' ;;
        label: "Product Size Guide"
      }

      when: {
        sql: ${element_classes} like '%finery-logo%' ;;
        label: "Finery Logo"
      }

      when: {
        sql: ${element_classes} like '%promotion__link%' ;;
        label: "Promotion Link"
      }

      when: {
        sql: ${element_classes} like '%taxon-promotion%' ;;
        label: "Taxon Promotion Link"
      }

      else: "Other"
    }
  }

  dimension: link_type_2 {
    case: {
      when: {
        sql: ${element_classes} like '%icon-close%' ;;
        label: "Close Popup"
      }

      when: {
        sql: ${element_classes} like '%modal-window-close%' ;;
        label: "Close Sale Pop-Up"
      }

      when: {
        sql: ${element_classes} like '%soft-locked-modal__no-thanks%' ;;
        label: "No Thanks Button on Sale Pop-Up"
      }

      when: {
        sql: ${element_classes} like '%basket__checkout%' ;;
        label: "Mini Basket - Checkout"
      }

      when: {
        sql: ${element_classes} like '%social__hashtag--footer%' or ${element_classes} = '["social__link","js-social-footer-link"]' ;;
        label: "Social Link"
      }

      else: "Other"
    }

    hidden: yes
  }

  dimension: element_target {
    sql: ${TABLE}.element_target ;;
  }

  dimension: root_id {
    sql: ${TABLE}.root_id ;;
    hidden: yes
  }

  dimension_group: root_tstamp {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.root_tstamp ;;
    hidden: yes
  }

  dimension: target_url {
    sql: ${TABLE}.target_url ;;
    hidden: yes
  }

  dimension: target_url_query_string_removed {
    sql: case
      when charindex('?', target_url) = 0 then target_url
      else left(target_url, charindex('?', target_url) - 1)
      end
       ;;
    hidden: yes
  }

  dimension: target_url_adjusted_for_country {
    label: "Target URL"
    sql: case

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
       ;;
  }

  dimension: target_url_type {
    label: "Target URL Type"

    case: {
      when: {
        sql: ${target_url_adjusted_for_country} in ('/', '//') ;;
        label: "Homepage"
      }

      when: {
        sql: ${target_url} like '%/t/%' ;;
        label: "Product Listing Page"
      }

      when: {
        sql: ${target_url} like '%/products/%' ;;
        label: "Product Detail Page"
      }

      when: {
        sql: ${target_url_adjusted_for_country} = '/chapters' ;;
        label: "Chapters Home"
      }

      when: {
        sql: ${target_url} like '%/chapters/%' ;;
        label: "Editorial"
      }

      when: {
        sql: ${target_url_adjusted_for_country} = '/cart' ;;
        label: "Cart"
      }

      when: {
        sql: ${target_url_adjusted_for_country} = '/checkout' ;;
        label: "Checkout"
      }

      when: {
        sql: ${target_url} like '/orders/%' ;;
        label: "Order Complete"
      }

      else: "Other"
    }
  }

  measure: link_clicks_count {
    type: count_distinct
    sql: ${root_id} ;;
  }

  measure: sessions_with_product_click_count {
    type: count_distinct
    sql: ${atomic_events.session_id} ;;

    filters: {
      field: target_url_type
      value: "Product Detail Page"
    }
  }

  measure: distinct_product_clicks_count {
    type: count_distinct
    sql: ${target_url_adjusted_for_country} ;;

    filters: {
      field: target_url_type
      value: "Product Detail Page"
    }
  }

  measure: link_clicks {
    label: "Link Clicks %"
    type: percent_of_total
    sql: ${link_clicks_count} ;;
  }
}
