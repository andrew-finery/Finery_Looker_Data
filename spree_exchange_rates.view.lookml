- view: spree_exchange_rates
  derived_table:
    sql: |
          select calendar_date, currency, rate, spree_timestamp
          
          from
          
          (select calendar_before.calendar_date, exchange_rates_before.currency, exchange_rates_before.rate, cast(null as datetime) as spree_timestamp from
          (select calendar_date from finery.calendar where calendar_date < (select min(date(spree_timestamp)) from daily_snapshot.spree_exchange_rates)) calendar_before
          cross join
          (select 'USD' as currency, cast('1.60' as decimal(8,2)) as rate union select 'CAD' as currency, cast('1.80' as decimal(8,2)) as rate) exchange_rates_before)
          
          union
          
          select * from 
          
          (select date(spree_timestamp) as calendar_date, currency, max(rate) as rate, max(spree_timestamp) as spree_timestamp from daily_snapshot.spree_exchange_rates group by 1,2)
          
          union
          
          (select calendar_after.calendar_date, exchange_rates_after.currency, exchange_rates_after.rate as exchange_rate, cast(null as datetime) as spree_timestamp from
          (select calendar_date from finery.calendar where calendar_date > (select max(date(spree_timestamp)) from daily_snapshot.spree_exchange_rates)) calendar_after
          cross join
          (select currency, rate from (select currency, first_value(rate) over (partition by currency order by spree_timestamp desc rows between unbounded preceding and unbounded following) as rate from daily_snapshot.spree_exchange_rates) group by 1,2) exchange_rates_after)
          
          union
          
          (select calendar_date, 'GBP' as currency, cast('1.00' as decimal(8,2)) as rate, cast(null as datetime) as spree_timestamp from finery.calendar)

    sql_trigger_value: select max(spree_timestamp) from daily_snapshot.spree_zones
    distkey: calendar_date
    sortkeys: [calendar_date, currency]
          
  fields:

  - dimension: date
    type: date
    sql: ${TABLE}.calendar_date
    hidden: true

  - dimension: currency
    sql: ${TABLE}.currency
    hidden: true

  - dimension: exchange_rate
    sql: ${TABLE}.rate