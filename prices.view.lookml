- view: prices
  derived_table:
    sql: |
      select
          prices.currency, variants.sku, prices.variant_id, date(prices.spree_timestamp) as calendar_date, max(prices.amount) as price from
          daily_snapshot.spree_prices prices
          inner join (select * from daily_snapshot.spree_variants where date(spree_timestamp) = current_date) variants
          on prices.variant_id = variants.id
          where prices.currency = 'GBP' and prices.deleted_at is null 
          group  by 1,2,3,4

    sql_trigger_value: SELECT max(spree_timestamp) FROM daily_snapshot.spree_prices
    distkey: sku
    sortkeys: [sku, calendar_date]

  fields:

  - dimension: currency
    sql: ${TABLE}.currency

  - dimension: sku
    sql: ${TABLE}.sku

  - dimension: price
    type: number
    decimals: 2
    sql: ${TABLE}.price
