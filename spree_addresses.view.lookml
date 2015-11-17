- view: spree_addresses
  sql_table_name: info.addresses

  fields:

  - dimension: address_id
    sql: ${TABLE}.address_id
    hidden: true

  - dimension: country_id
    sql: ${TABLE}.country_id
    hidden: true
    
  - dimension: map_postcode
    label: Postcode Area
    type: zipcode
    sql: ${TABLE}.map_postcode
  
  - dimension: city
    label: City
    sql: upper(${TABLE}.city)
  
  - dimension: country
    sql: ${TABLE}.country

  - dimension: london_flag
    sql: case when ${TABLE}.map_postcode in ('E', 'EC', 'N', 'NW', 'SE', 'SW', 'W', 'WC') then 'London' else 'Non-London' end
    hidden: true
  

    

