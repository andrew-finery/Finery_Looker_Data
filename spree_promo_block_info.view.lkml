view: spree_promo_block_info {
  sql_table_name: info.promo_block_info ;;

  dimension: action {
    type: string
    sql: ${TABLE}.action ;;
  }

  dimension: caption {
    type: string
    sql: ${TABLE}.caption ;;
  }

  dimension: cta_link {
    label: "Links To"
    type: string
    sql: ${TABLE}.cta_link ;;
  }

  dimension: cta_target {
    type: string
    sql: ${TABLE}.cta_target ;;
  }

  dimension: cta_text {
    type: string
    sql: ${TABLE}.cta_text ;;
  }

  dimension: image_content_type {
    type: string
    sql: ${TABLE}.image_content_type ;;
  }

  dimension: image_file_name {
    type: string
    sql: ${TABLE}.image_file_name ;;
  }

  dimension: promo_block_image {
    type: string
    sql: ${TABLE}.image_location ;;
    html: <img src="{{value}}" height="130" width="86"/>
      ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: taxons {
    type: string
    sql: ${TABLE}.taxons_used_in ;;
  }

  dimension: pin_to_end_of_results {
    type: number
    sql: ${TABLE}.pin_to_end_of_results ;;
  }

  dimension: placements {
    type: string
    sql: ${TABLE}.placements ;;
  }

  dimension: promo_block_id {
    label: "ID"
    type: string
    sql: ${TABLE}.promo_block_id ;;
  }

  dimension: promo_block_position {
    label: "Position"
    type: number
    sql: ${TABLE}.promo_block_position ;;
  }

  dimension: secondary_text {
    type: string
    sql: ${TABLE}.secondary_text ;;
  }

  dimension: viewport_image_large_desktop {
    type: string
    sql: ${TABLE}.viewport_image_large_desktop ;;
  }

  dimension: viewport_image_mobile {
    type: string
    sql: ${TABLE}.viewport_image_mobile ;;
  }

  dimension: link_to_edit {
    type: string
    sql: 'https://www.finerylondon.com/cms/cms_promotion_blocks/' || ${promo_block_id} || '/edit' ;;
    html: <a href="{{value}}">LINK</a>
    ;;
  }
}
