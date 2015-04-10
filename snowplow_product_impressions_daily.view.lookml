- view: snowplow_product_impressions_daily
  derived_table:
     sql: |
          SELECT date(events.collector_tstamp) as impression_date,
                 impressions_context.brand,
                 impressions_context.category,
                 impressions_context.id,
                 impressions_context.list,
                 impressions_context. "position",
                 impressions_context.style,
                 count(*) as product_impressions
          FROM atomic.com_finerylondon_product_impression_1 impressions
            LEFT JOIN atomic.com_finerylondon_product_impression_context_1 impressions_context ON impressions.root_id = impressions_context.root_id
            LEFT JOIN atomic.events events on events.event_id = impressions.root_id
            where events.app_id = 'production'
            and date(events.collector_tstamp) < current_date
            group by 1,2,3,4,5,6,7

     sql_trigger_value: select max(date(root_tstamp)) from atomic.com_finerylondon_product_impression_1
     distkey: id
     sortkeys: [id, impression_date]

  fields:
# #     Define your dimensions and measures here, like this:
#     - dimension: profit
#       type: number
#       sql: ${TABLE}.profit
#
#     - measure: total_profit
#       type: sum
#       sql: ${profit}
