- view: spree_tax_rates
  derived_table:
    sql: |
        select taxes.calendar_date, taxes.zone_id, taxes.amount, zone_members.zoneable_id as country_id from
        
        (select calendar_date, zone_id, amount from
        (select date(spree_timestamp) as calendar_date, zone_id, max(amount) as amount from daily_snapshot.spree_tax_rates group by 1,2)
        union
        select calendar_before.calendar_date, exchange_rates_before.zone_id, exchange_rates_before.amount from
        (select calendar_date from lookup.calendar where calendar_date < (select min(date(spree_timestamp)) from daily_snapshot.spree_exchange_rates)) calendar_before
        cross join
        (select zone_id, max(amount) as amount from daily_snapshot.spree_tax_rates where spree_timestamp = (select min(spree_timestamp) from daily_snapshot.spree_tax_rates) group by 1) exchange_rates_before
        union
        select calendar_before.calendar_date, exchange_rates_after.zone_id, exchange_rates_after.amount from
        (select calendar_date from lookup.calendar where calendar_date > (select max(date(spree_timestamp)) from daily_snapshot.spree_exchange_rates)) calendar_before
        cross join
        (select zone_id, max(amount) as amount from daily_snapshot.spree_tax_rates where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_tax_rates) group by 1) exchange_rates_after) taxes
        
        left join
        (select * from daily_snapshot.spree_zone_members where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_zone_members)) zone_members
        on zone_members.zone_id = taxes.zone_id

    sql_trigger_value: SELECT max(spree_timestamp) FROM daily_snapshot.spree_tax_rates
    distkey: calendar_date
    sortkeys: [calendar_date, country_id]

  fields:

   - dimension: calendar_date
     type: date
     sql: ${TABLE}.calendar_date
     hidden: true

   - dimension: country_id
     sql: ${TABLE}.country_id
     hidden: true

   - dimension: tax_rate
     type: number
     decimals: 2
     sql: ${TABLE}.amount
     hidden: true

   - dimension: tax_rate_visible
     label: TAX RATE
     type: int
     sql: 100 * ${TABLE}.amount
     format: "%0.2f%"