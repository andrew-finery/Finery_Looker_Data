- view: snowplow_product_page_views_daily
  derived_table:
     sql: |
          select
          date (convert_timezone('UTC', 'Europe/London', events.collector_tstamp)) as calendar_date,
          pagecx.prod_id as product_id,
          approximate count(distinct events.domain_userid || domain_sessionidx || pagecx.prod_id) as product_page_views
          from atomic.events events
          left join atomic.com_finerylondon_page_view_context_1 pagecx
          on events.event_id = pagecx. root_id
          where events.app_id = 'production'
          and events.event = 'page_view'
          and pagecx.page_type = 'products/show'
          and pagecx.prod_id is not null
          group by 1,2

     sql_trigger_value: select max(calendar_date) from ${snowplow_product_click_through_daily.SQL_TABLE_NAME}
     distkey: product_id
     sortkeys: [product_id, calendar_date]

  fields:
# #     Define your dimensions and measures here, like this:
#     - dimension: profit
#       type: number
#       sql: ${TABLE}.profit
#
#     - measure: total_profit
#       type: sum
#       sql: ${profit}
