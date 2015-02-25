- view: spree_addresses
  derived_table:
    sql: |
          select
          addresses.id as address_id,
          addresses.firstname as first_name,
          addresses.lastname as last_name,
          addresses.address1 as address_line_1,
          addresses.address2 as address_line_2,
          addresses.city as city,
          addresses.zipcode as zipcode,
          case
          when country_id <> 44 then addresses.zipcode
          when left(addresses.zipcode,'2') like '%0%' then upper(left(addresses.zipcode,'1'))
          when left(addresses.zipcode,'2') like '%1%' then upper(left(addresses.zipcode,'1'))
          when left(addresses.zipcode,'2') like '%2%' then upper(left(addresses.zipcode,'1'))
          when left(addresses.zipcode,'2') like '%3%' then upper(left(addresses.zipcode,'1'))
          when left(addresses.zipcode,'2') like '%4%' then upper(left(addresses.zipcode,'1'))
          when left(addresses.zipcode,'2') like '%5%' then upper(left(addresses.zipcode,'1'))
          when left(addresses.zipcode,'2') like '%6%' then upper(left(addresses.zipcode,'1'))
          when left(addresses.zipcode,'2') like '%7%' then upper(left(addresses.zipcode,'1'))
          when left(addresses.zipcode,'2') like '%8%' then upper(left(addresses.zipcode,'1'))
          when left(addresses.zipcode,'2') like '%9%' then upper(left(addresses.zipcode,'1'))
          else upper(left(addresses.zipcode,'2')) end as map_postcode,
          addresses.country_id as country_id,
          countries.name as country
          
          from
          (select * from daily_snapshot.spree_addresses where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_addresses)) addresses
          left join
          (select * from daily_snapshot.spree_countries where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_countries)) countries
          on addresses.country_id = countries.id

    sql_trigger_value: SELECT max(spree_timestamp) FROM daily_snapshot.spree_addresses
    distkey: address_id
    sortkeys: [address_id]

  fields:

  - dimension: address_id
    sql: ${TABLE}.address_id
    hidden: true

  - dimension: country_id
    sql: ${TABLE}.country_id
    hidden: true
    
  - dimension: map_postcode
    label: POSTCODE
    type: zipcode
    sql: ${TABLE}.map_postcode
  
  - dimension: city
    label: CITY
    sql: upper(${TABLE}.city)
  
  - dimension: country
    label: COUNTRY
    sql: ${TABLE}.country

  - dimension: london_flag
    label: LONDON FLAG
    sql: case when ${TABLE}.map_postcode in ('E', 'EC', 'N', 'NW', 'SE', 'SW', 'W', 'WC') then 'London' else 'Non-London' end
    
  

    

