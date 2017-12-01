view: item_inventory_by_location {
  sql_table_name: peoplevox.item_inventory_by_location ;;

  dimension: attribute1 {
    type: string
    sql: ${TABLE}.attribute1 ;;
  }

  dimension: attribute10 {
    type: string
    sql: ${TABLE}.attribute10 ;;
  }

  dimension: attribute11 {
    type: string
    sql: ${TABLE}.attribute11 ;;
  }

  dimension: attribute12 {
    type: string
    sql: ${TABLE}.attribute12 ;;
  }

  dimension: attribute13 {
    type: string
    sql: ${TABLE}.attribute13 ;;
  }

  dimension: attribute14 {
    type: string
    sql: ${TABLE}.attribute14 ;;
  }

  dimension: attribute15 {
    type: string
    sql: ${TABLE}.attribute15 ;;
  }

  dimension: attribute2 {
    type: string
    sql: ${TABLE}.attribute2 ;;
  }

  dimension: attribute3 {
    type: string
    sql: ${TABLE}.attribute3 ;;
  }

  dimension: attribute4 {
    type: string
    sql: ${TABLE}.attribute4 ;;
  }

  dimension: attribute5 {
    type: string
    sql: ${TABLE}.attribute5 ;;
  }

  dimension: attribute6 {
    type: string
    sql: ${TABLE}.attribute6 ;;
  }

  dimension: attribute7 {
    type: string
    sql: ${TABLE}.attribute7 ;;
  }

  dimension: attribute8 {
    type: string
    sql: ${TABLE}.attribute8 ;;
  }

  dimension: attribute9 {
    type: string
    sql: ${TABLE}.attribute9 ;;
  }

  dimension: buy_price {
    type: number
    sql: ${TABLE}.buy_price ;;
  }

  dimension: container_barcode {
    type: string
    sql: ${TABLE}.container_barcode ;;
  }

  dimension: default_economic_order_quantity {
    type: string
    sql: ${TABLE}.default_economic_order_quantity ;;
  }

  dimension: default_lead_time {
    type: string
    sql: ${TABLE}.default_lead_time ;;
  }

  dimension: default_number_of_items_per_container {
    type: string
    sql: ${TABLE}.default_number_of_items_per_container ;;
  }

  dimension: default_number_of_items_per_outercase {
    type: string
    sql: ${TABLE}.default_number_of_items_per_outercase ;;
  }

  dimension: default_suppliers_part_number {
    type: string
    sql: ${TABLE}.default_suppliers_part_number ;;
  }

  dimension: depth {
    type: string
    sql: ${TABLE}.depth ;;
  }

  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
  }

  dimension: dimensions_unit_of_measure {
    type: string
    sql: ${TABLE}.dimensions_unit_of_measure ;;
  }

  dimension: has_serial_number {
    type: string
    sql: ${TABLE}.has_serial_number ;;
  }

  dimension: height {
    type: string
    sql: ${TABLE}.height ;;
  }

  dimension: item_barcode {
    type: string
    sql: ${TABLE}.item_barcode ;;
  }

  dimension: item_code {
    type: string
    sql: ${TABLE}.item_code ;;
  }

  dimension: item_type_group {
    type: string
    sql: ${TABLE}.item_type_group ;;
  }

  dimension: location_barcode {
    type: string
    sql: ${TABLE}.location_barcode ;;
  }

  dimension: location_type {
    type: string
    sql: ${TABLE}.location_type ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: policy_name {
    type: string
    sql: ${TABLE}.policy_name ;;
  }

  dimension: reorder_point {
    type: string
    sql: ${TABLE}.reorder_point ;;
  }

  dimension: retail_price {
    type: number
    sql: ${TABLE}.retail_price ;;
  }

  dimension: shelf_life {
    type: string
    sql: ${TABLE}.shelf_life ;;
  }

  dimension: site_reference {
    type: string
    sql: ${TABLE}.site_reference ;;
  }

  dimension: stock_count {
    type: number
    sql: ${TABLE}.stock_count ;;
  }

  dimension: tags {
    type: string
    sql: ${TABLE}.tags ;;
  }

  dimension_group: time_stamp {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.time_stamp ;;
  }

  dimension: traceability {
    type: string
    sql: ${TABLE}.traceability ;;
  }

  dimension: unit_of_measure {
    type: string
    sql: ${TABLE}.unit_of_measure ;;
  }

  dimension: use_manufacturers_serial_number {
    type: string
    sql: ${TABLE}.use_manufacturers_serial_number ;;
  }

  dimension: weight {
    type: string
    sql: ${TABLE}.weight ;;
  }

  dimension: weight_unit_of_measure {
    type: string
    sql: ${TABLE}.weight_unit_of_measure ;;
  }

  dimension: wholesale_price {
    type: number
    sql: ${TABLE}.wholesale_price ;;
  }

  dimension: width {
    type: string
    sql: ${TABLE}.width ;;
  }

  measure: count {
    type: count
    drill_fields: [policy_name, name]
  }
}
