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

  dimension: country_group {
    sql: case when ${country} = 'United Kingdom' then 'UK'
    when ${country} = 'Ireland' then 'Ireland'
    when  ${country} = 'United States' then 'United States' else 'Other' end  ;;
  }

  dimension: geography_continent {
    label: "Geo - Continent"
    sql: case when ${country} = 'United Kingdom' then 'Europe'
    when ${country} = 'Ireland' then 'Europe'
    when ${country} = 'United States' then 'North America'
    when ${country} = 'Australia' then 'Australia'
    when ${country} = 'Canada' then 'North America'
    when ${country} = 'Germany' then 'Europe'
    when ${country} = 'France' then 'Europe'
    when ${country} = 'Hong Kong' then 'Asia'
    when ${country} = 'Spain' then 'Europe'
    when ${country} = 'Italy' then 'Europe'
    when ${country} = 'Singapore' then 'Asia'
    when ${country} = 'Netherlands' then 'Europe'
    when ${country} = 'Belgium' then 'Europe'
    when ${country} = 'Denmark' then 'Europe'
    when ${country} = 'Sweden' then 'Europe'
    when ${country} = 'United Arab Emirates' then 'Asia'
    when ${country} = 'New Zealand' then 'Australia'
    when ${country} = 'Austria' then 'Europe'
    when ${country} = 'Switzerland' then 'Europe'
    when ${country} = 'Philippines' then 'Asia'
    when ${country} = 'Luxembourg' then 'Europe'
    when ${country} = 'Norway' then 'Europe' else 'Other' end ;;
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
