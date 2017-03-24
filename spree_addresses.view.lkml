view: spree_addresses {
  sql_table_name: info.addresses ;;

  dimension: address_id {
    sql: ${TABLE}.address_id ;;
    hidden: yes
  }

  dimension: country_id {
    sql: ${TABLE}.country_id ;;
    hidden: yes
  }

  dimension: uk_flag {
    type: yesno
    sql: ${country_id} = 44 ;;
  }

  dimension: map_postcode {
    label: "Postcode Area"
    type: zipcode
    sql: ${TABLE}.map_postcode ;;
  }

  dimension: city {
    sql: upper(${TABLE}.city) ;;
  }

  dimension: country {
    sql: ${TABLE}.country ;;
  }

  dimension: london_flag {
    sql: case when ${TABLE}.map_postcode in ('E', 'EC', 'N', 'NW', 'SE', 'SW', 'W', 'WC') then 'London' else 'Non-London' end ;;
  }

  dimension: post_town {
    sql: ${TABLE}.post_town ;;
  }

  dimension: local_area {
    sql: ${TABLE}.local_area ;;
  }

  dimension: region {
    sql: ${TABLE}.region ;;
  }

  dimension: full_post_code {
    sql: ${TABLE}.zipcode ;;
  }

  dimension: phone_number {
    sql: ${TABLE}.phone_number ;;
  }

  dimension: address_line_1 {
    sql: ${TABLE}.address_line_1 ;;
  }

  dimension: address_line_2 {
    sql: ${TABLE}.address_line_2 ;;
  }

  dimension: first_name {
    sql: ${TABLE}.first_name ;;
  }

  dimension: last_name {
    sql: ${TABLE}.last_name ;;
  }
}
