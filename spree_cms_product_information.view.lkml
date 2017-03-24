view: spree_cms_product_information {
  sql_table_name: info.cms_product_information ;;
  #######################################################################################################################################################################
  ################################################################ DIMENSIONS ###########################################################################################
  ######################################################################################################################################################################

  dimension: product_id {
    label: "Product ID"
    sql: ${TABLE}.product_id ;;
  }

  dimension: product_name {
    label: "Product Name"
    sql: ${TABLE}.name ;;
  }

  dimension: product_price {
    label: "Product Price"
    type: number
    value_format_name: decimal_2
    sql: ${TABLE}.price_gbp ;;
  }

  dimension: about_me {
    label: "About Me"
    sql: ${TABLE}.about_me ;;
  }

  dimension: the_details {
    label: "The Details"
    sql: ${TABLE}.the_details ;;
  }

  dimension: slug {
    label: "Slug"
    sql: ${TABLE}.slug ;;
  }

  dimension: seo_page_title {
    label: "Seo Page Title"
    sql: ${TABLE}.seo_page_title ;;
  }

  dimension: meta_title {
    label: "Meta Title"
    sql: ${TABLE}.meta_title ;;
  }

  dimension: meta_keywords {
    label: "Meta Keywords"
    sql: ${TABLE}.meta_keywords ;;
  }

  dimension: meta_description {
    label: "Meta Description"
    sql: ${TABLE}.meta_description ;;
  }

  dimension: product_notes {
    label: "Product Notes"
    sql: ${TABLE}.product_notes ;;
  }

  dimension: is_coming_soon {
    label: "Is Coming Soon"
    type: yesno
    sql: ${TABLE}.is_coming_soon = true ;;
  }

  dimension_group: available_on {
    label: "Available On"
    type: time
    timeframes: [date, week, month]
    sql: ${TABLE}.available_on ;;
  }

  dimension: promotionable {
    label: "Promotable"
    type: yesno
    sql: ${TABLE}.promotionable = 1 ;;
  }

  dimension: size_guide {
    label: "Size Guide"
    sql: ${TABLE}.size_guide ;;
  }

  dimension: product_group_id {
    label: "Product Group ID"
    sql: ${TABLE}.product_group_id ;;
  }

  dimension: product_group_name {
    label: "Product Group Name"
    sql: ${TABLE}.product_group_name ;;
  }

  dimension: product_group_parent_sku {
    label: "Product Group Parent SKU"
    sql: ${TABLE}.product_group_parent_sku ;;
  }

  dimension: google_product_category {
    label: "Google Product Category"
    sql: ${TABLE}.google_product_category ;;
  }

  dimension: season {
    label: "Season"
    sql: ${TABLE}.season ;;
  }

  dimension: quote {
    label: "Quote"
    sql: ${TABLE}.quote ;;
  }

  dimension: quote_author {
    label: "Quote Author"
    sql: ${TABLE}.quote_author ;;
  }

  dimension: pdp_promo_block {
    label: "Pdp Promo Block"
    sql: ${TABLE}.pdp_promo_block ;;
  }

  dimension: taxon {
    label: "Taxon"
    sql: ${TABLE}.taxon ;;
  }

  dimension: taxon_position {
    label: "Taxon Position"
    sql: ${TABLE}.taxon_position ;;
  }

  dimension: secondary_taxon {
    label: "Secondary Taxon"
    sql: ${TABLE}.secondary_taxon ;;
  }

  dimension: variant_id {
    label: "Variant ID"
    sql: ${TABLE}.variant_id ;;
  }

  dimension: ean {
    label: "ean"
    sql: ${TABLE}.ean ;;
  }

  dimension: option_type {
    label: "Option Type"
    sql: ${TABLE}.option_type ;;
  }

  dimension: option_value {
    label: "Option Value"
    sql: ${TABLE}.option_value ;;
  }

  dimension: related_product_id {
    label: "Related Product ID"
    sql: ${TABLE}.related_product_id ;;
  }

  dimension: related_product_name {
    label: "Related Product Name"
    sql: ${TABLE}.related_product_name ;;
  }

  dimension: relation_type {
    label: "Relation Type"
    sql: ${TABLE}.relation_type ;;
  }

  dimension: attachment_file_name {
    label: "Image File Name"
    sql: ${TABLE}.attachment_file_name ;;
  }

  dimension: is_hover_image {
    label: "Image Is Hover"
    type: yesno
    sql: ${TABLE}.is_hover_image = 1 ;;
  }

  dimension: packshot {
    label: "Image Is Packshot"
    type: yesno
    sql: ${TABLE}.packshot = 1 ;;
  }

  dimension: is_hidden {
    label: "Image Is Hidden"
    type: yesno
    sql: ${TABLE}.is_hidden = true ;;
  }

  dimension: is_affiliate {
    label: "Image Is Affiliate"
    type: yesno
    sql: ${TABLE}.is_affiliate = true ;;
  }

  dimension: attachment_width {
    label: "Image Width"
    sql: ${TABLE}.attachment_width ;;
  }

  dimension: attachment_height {
    label: "Image Height"
    sql: ${TABLE}.attachment_height ;;
  }

  dimension: attachment_file_size {
    label: "Image File Size"
    sql: ${TABLE}.attachment_file_size ;;
  }

  dimension: image_preview {
    label: "Image Preview"
    type: string
    sql: ${TABLE}.origin_id || '/single/' || ${attachment_file_name} ;;
    html: <img src="https://assets.finerylondon.com/spree/products/{{value}}" height="130" width="86"/>
      ;;
  }

  #######################################################################################################################################################################
  ################################################################  MEASURES  ###########################################################################################
  #######################################################################################################################################################################


  measure: count_products {
    type: count_distinct
    sql: ${product_id} ;;
  }

  measure: count_product_groups {
    type: count_distinct
    sql: ${product_group_id} ;;
  }

  measure: count_variants {
    type: count_distinct
    sql: ${variant_id} ;;
  }

  measure: count_images {
    type: count_distinct
    sql: ${attachment_file_name} ;;
  }

  measure: count_pdp_blocks {
    label: "Count PDP Blocks"
    type: count_distinct
    sql: ${pdp_promo_block} ;;
  }

  measure: count_related_products {
    type: count_distinct
    sql: ${related_product_id} ;;
  }

  measure: count_wear_me_with_products {
    type: count_distinct
    sql: ${related_product_id} ;;

    filters: {
      field: relation_type
      value: "Complete The Look"
    }
  }

  measure: count_more_finery_to_fall_for_products {
    type: count_distinct
    sql: ${related_product_id} ;;

    filters: {
      field: relation_type
      value: "Related Products"
    }
  }
}
