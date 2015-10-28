- view: spree_cms_product_information
  derived_table:
    sql: |
          select
          products.id as product_id,
          products.name,
          prices.amount as price_gbp,
          products.description as about_me,
          products.details as the_details,
          products.slug,
          products.seo_page_title,
          products.meta_title,
          products.meta_keywords,
          products.meta_description,
          products.product_notes,
          products.is_coming_soon,
          products.available_on,
          products.promotionable,
          size_guides.name as size_guide,
          products.product_group_id,
          product_groups.name as product_group_name,
          product_groups.sku as product_group_parent_sku,
          products.google_product_category,
          products.season,
          product_quotes.content as quote,
          cms_authors.full_name as quote_author,
          pdp_blocks.name as pdp_promo_block,
          spree_taxons.name as taxon,
          spree_taxons."position" as taxon_position,
          spree_secondary_taxons.name as secondary_taxon,
          variants.id as variant_id,
          variants.sku as ean,
          option_types.name as option_type,
          option_values.name as option_value,
          relations.related_to_id as related_product_id,
          related_products.name as related_product_name,
          relation_types.name as relation_type,
          spree_assets.attachment_file_name,
          spree_assets.is_hover_image,
          spree_assets.packshot,
          spree_assets.is_hidden,
          spree_assets.is_affiliate,
          spree_assets.attachment_width,
          spree_assets.attachment_height,
          spree_assets.attachment_file_size,
          coalesce(spree_assets.origin_id, spree_assets.id) as origin_id
          
          from
          
          (select * from daily_snapshot.spree_products where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_products) and deleted_at is null) products
          left join
          (select * from daily_snapshot.spree_product_groups where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_product_groups) and deleted_at is null) product_groups
          on product_groups.id = products.product_group_id
          left join
          (select * from daily_snapshot.cms_promotion_blocks_spree_products where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.cms_promotion_blocks_spree_products)) pdp_blocks_products
          on products.id = pdp_blocks_products.spree_product_id
          left join (select * from daily_snapshot.cms_promotion_blocks   where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.cms_promotion_blocks)) pdp_blocks
          on pdp_blocks.id = pdp_blocks_products.cms_promotion_block_id
          left join (select * from daily_snapshot.spree_size_guides  where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_size_guides)) size_guides
          on size_guides.id = products.size_guide_id
          left join (select * from daily_snapshot.spree_product_quotes where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_product_quotes)) product_quotes
          on product_quotes.product_id = products.id
          left join (select * from daily_snapshot.cms_authors where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.cms_authors)) cms_authors
          on cms_authors.id = product_quotes.author_id
          left join (select taxons.id, taxons.name, taxons.permalink, taxons.taxonomy_id, products_taxons.product_id, products_taxons."position", taxons.parent_id from (select * from daily_snapshot.spree_taxons where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_taxons) and (parent_id = 1 or parent_id is null)) taxons
                      left join (select * from daily_snapshot.spree_products_taxons where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_products_taxons)) products_taxons on taxons.id = products_taxons.taxon_id) spree_taxons
          on spree_taxons.product_id = products.id
          left join (select taxons.id, taxons.name, taxons.permalink, taxons.taxonomy_id, products_taxons.product_id, products_taxons."position", taxons.parent_id from (select * from daily_snapshot.spree_taxons where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_taxons) and not (parent_id = 1 or parent_id is null)) taxons
                      left join (select * from daily_snapshot.spree_products_taxons where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_products_taxons)) products_taxons on taxons.id = products_taxons.taxon_id) spree_secondary_taxons
          on spree_secondary_taxons.product_id = products.id and spree_taxons.id = spree_secondary_taxons.parent_id
          left join (select * from daily_snapshot.spree_product_option_types where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_product_option_types)) product_option_types
          on product_option_types.product_id = products.id
          left join (select * from daily_snapshot.spree_variants where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_variants) and deleted_at is null) variants
          on variants.product_id = products.id
          left join (select * from daily_snapshot.spree_option_values_variants where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_option_values_variants)) option_values_variants
          on variants.id = option_values_variants.variant_id
          left join (select * from daily_snapshot.spree_option_values where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_option_values)) option_values
          on option_values_variants.option_value_id = option_values.id
          left join (select * from daily_snapshot.spree_option_types where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_option_types)) option_types
          on option_values.option_type_id = option_types.id
          left join (select * from daily_snapshot.spree_prices where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_prices) and deleted_at is null and currency = 'GBP') prices
          on prices.variant_id = variants.id
          left join (select * from daily_snapshot.spree_relations where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_relations)) relations
          on products.id = relations.relatable_id
          left join (select * from daily_snapshot.spree_relation_types where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_relation_types)) relation_types
          on relations.relation_type_id = relation_types.id
          left join (select * from daily_snapshot.spree_products where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_products) and deleted_at is null) related_products
          on related_products.id = relations.related_to_id
          left join (select assets.id, assets.viewable_id, assets.viewable_type, assets.attachment_width, assets.attachment_height, assets.attachment_file_size, assets."position", assets.attachment_file_name, assets.type, assets.is_hover_image, assets.packshot, assets.origin_id, assets.is_hidden, assets.is_affiliate, variants.product_id from
                    (select * from daily_snapshot.spree_assets  where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_assets)) assets
                    left join (select * from daily_snapshot.spree_variants where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_variants) and deleted_at is null) variants
                    on assets.viewable_id = variants.id) spree_assets
          on spree_assets.product_id = products.id

    sql_trigger_value: select max(spree_timestamp) from daily_snapshot.spree_products
    distkey: product_id
    sortkeys: [ean]
  fields:
    #######################################################################################################################################################################
################################################################ DIMENSIONS ###########################################################################################
######################################################################################################################################################################

  - dimension: product_id
    label: Product ID
    sql: ${TABLE}.product_id

  - dimension: product_name
    label: Product Name
    sql: ${TABLE}.name
  
  - dimension: product_price
    label: Product Price
    type: number
    decimals: 2
    sql: ${TABLE}.price_gbp 
    value_format: '##0.00'

  - dimension: about_me
    label: About Me
    sql: ${TABLE}.about_me

  - dimension: the_details
    label: The Details
    sql: ${TABLE}.the_details

  - dimension: slug
    label: Slug
    sql: ${TABLE}.slug

  - dimension: seo_page_title
    label: Seo Page Title
    sql: ${TABLE}.seo_page_title

  - dimension: meta_title
    label: Meta Title
    sql: ${TABLE}.meta_title
  
  - dimension: meta_keywords
    label: Meta Keywords
    sql: ${TABLE}.meta_keywords

  - dimension: meta_description
    label: Meta Description
    sql: ${TABLE}.meta_description
    
  - dimension: product_notes
    label: Product Notes
    sql: ${TABLE}.product_notes

  - dimension: is_coming_soon
    label: Is Coming Soon
    type: yesno
    sql: ${TABLE}.is_coming_soon = true

  - dimension_group: available_on
    label: Available On
    type: time
    timeframes: [date, week, month]
    sql: ${TABLE}.available_on

  - dimension: promotionable
    label: Promotable
    type: yesno
    sql: ${TABLE}.promotionable = 1

  - dimension: size_guide
    label: Size Guide
    sql: ${TABLE}.size_guide

  - dimension: product_group_id
    label: Product Group ID
    sql: ${TABLE}.product_group_id

  - dimension: product_group_name
    label: Product Group Name
    sql: ${TABLE}.product_group_name

  - dimension: product_group_parent_sku
    label: Product Group Parent SKU
    sql: ${TABLE}.product_group_parent_sku

  - dimension: google_product_category
    label: Google Product Category
    sql: ${TABLE}.google_product_category
  
  - dimension: season
    label: Season
    sql: ${TABLE}.season

  - dimension: quote
    label:  Quote
    sql: ${TABLE}.quote

  - dimension: quote_author
    label:  Quote Author
    sql: ${TABLE}.quote_author

  - dimension: pdp_promo_block
    label:  Pdp Promo Block
    sql: ${TABLE}.pdp_promo_block

  - dimension: taxon
    label:  Taxon
    sql: ${TABLE}.taxon

  - dimension: taxon_position
    label:  Taxon Position
    sql: ${TABLE}.taxon_position

  - dimension: secondary_taxon
    label:  Secondary Taxon
    sql: ${TABLE}.secondary_taxon

  - dimension: variant_id
    label: Variant ID
    sql: ${TABLE}.variant_id

  - dimension: ean
    label: ean
    sql: ${TABLE}.ean

  - dimension: option_type
    label: Option Type
    sql: ${TABLE}.option_type

  - dimension: option_value
    label: Option Value
    sql: ${TABLE}.option_value

  - dimension: related_product_id
    label: Related Product ID
    sql: ${TABLE}.related_product_id

  - dimension: related_product_name
    label: Related Product Name
    sql: ${TABLE}.related_product_name

  - dimension: relation_type
    label: Relation Type
    sql: ${TABLE}.relation_type

  - dimension: attachment_file_name
    label: Image File Name
    sql: ${TABLE}.attachment_file_name

  - dimension: is_hover_image
    label: Image Is Hover
    type: yesno
    sql: ${TABLE}.is_hover_image = 1
    
  - dimension: packshot
    label: Image Is Packshot
    type: yesno
    sql: ${TABLE}.packshot = 1
    
  - dimension: is_hidden
    label: Image Is Hidden
    type: yesno
    sql: ${TABLE}.is_hidden = true
    
  - dimension: is_affiliate
    label: Image Is Affiliate
    type: yesno
    sql: ${TABLE}.is_affiliate = true
    
  - dimension: attachment_width
    label: Image Width
    sql: ${TABLE}.attachment_width
    
  - dimension: attachment_height
    label: Image Height
    sql: ${TABLE}.attachment_height

  - dimension: attachment_file_size
    label: Image File Size
    sql: ${TABLE}.attachment_file_size

  - dimension: image_preview
    label: Image Preview
    type: string
    sql:  ${TABLE}.origin_id || '/single/' || ${attachment_file_name}
    html: |
          <img src="https://assets.finerylondon.com/spree/products/{{value}}" height="130" width="86"/>

    #######################################################################################################################################################################
  ################################################################  MEASURES  ###########################################################################################
#######################################################################################################################################################################


  - measure: count_products
    type: count_distinct
    sql: ${product_id}

  - measure: count_product_groups
    type: count_distinct
    sql: ${product_group_id}
    
  - measure: count_variants
    type: count_distinct
    sql: ${variant_id}

  - measure: count_images
    type: count_distinct
    sql: ${attachment_file_name}
    
  - measure: count_pdp_blocks
    label: Count PDP Blocks
    type: count_distinct
    sql: ${pdp_promo_block}

  - measure: count_related_products
    type: count_distinct
    sql: ${related_product_id}

  - measure: count_wear_me_with_products
    type: count_distinct
    sql: ${related_product_id}
    filters:
      relation_type: Complete The Look

  - measure: count_more_finery_to_fall_for_products
    type: count_distinct
    sql: ${related_product_id}
    filters:
      relation_type: Related Products