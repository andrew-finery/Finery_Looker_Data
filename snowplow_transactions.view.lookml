- view: snowplow_transactions
  derived_table:
    sql: |
          with step_1 as (

          select root_id, id, item_total, total, state, adjustment_total, user_id, payment_total, currency, shipment_total, additional_tax_total, promo_total, included_tax_total, use_credit, min(root_tstamp) as root_tstamp
          from atomic.com_finerylondon_order_1
          group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14
          
          ), step_2 as (
          
          select event_id, domain_userid, domain_sessionidx, app_id, min(collector_tstamp) as collector_tstamp
          from atomic.events
          group by 1,2,3,4
          
          ), step_3 as (
          
          select
          id as order_id,
          first_value (root_id) over (partition by order_id order by root_tstamp asc rows between unbounded preceding and unbounded following) as order_event_id,
          first_value (root_tstamp) over (partition by order_id order by root_tstamp asc rows between unbounded preceding and unbounded following) as order_event_tstamp
          from step_1
          where state = 'complete'
          
          ), step_4 as (
          
          select order_id, order_event_id, order_event_tstamp from step_3 group by 1,2,3
          
          ), step_5 as (
          
          select
          a.order_id,
          a.order_event_id,
          last_value(c.domain_userid) over(partition by a.order_id order by b.root_tstamp asc rows between unbounded preceding and unbounded following) as domain_userid
          from
          step_4 a
          left join step_1 b on a.order_id = b.id
          left join step_2 c on b.root_id = c.event_id
          where a.order_event_tstamp >= b.root_tstamp
          and c.domain_userid is not null
          
          ), step_6 as (
          
          select order_id, order_event_id, domain_userid
          from step_5
          group by 1,2,3
          
          ), step_7 as (
          
          select b.root_id, a.domain_userid, b.id, b.item_total, b.total, b.state, b.adjustment_total, b.user_id, b.payment_total, b.currency, b.shipment_total, b.additional_tax_total, b.promo_total, b.included_tax_total, b.use_credit, b.root_tstamp,
          case when b.id in (select id from atomic.com_finerylondon_order_1 where state = 'canceled') then 'Yes' else 'No' end as canceled_flag
          from step_6 a
          left join step_1 b
          on a.order_event_id = b.root_id
          
          ), step_8 as (
          
          select a.root_id, a.domain_userid, a.id, a.item_total, a.total, a.state, a.adjustment_total, a.user_id, a.payment_total, a.currency, a.shipment_total, a.additional_tax_total, a.promo_total, a.included_tax_total, a.use_credit, a.root_tstamp,
          a.canceled_flag,
          first_value (b.domain_sessionidx) over (partition by a.id order by b.collector_tstamp desc rows between unbounded preceding and unbounded following) as domain_sessionidx
          from step_7 a
          left join step_2 b
          on a.domain_userid = b.domain_userid
          where a.root_tstamp >= b.collector_tstamp
          and domain_sessionidx is not null
          
          )
          
          select
          root_id,
          domain_userid,
          domain_sessionidx,
          id as order_id,
          item_total,
          total,
          state,
          adjustment_total,
          user_id,
          payment_total,
          currency,
          shipment_total,
          additional_tax_total,
          promo_total,
          included_tax_total,
          use_credit,
          canceled_flag,
          root_tstamp
          from step_8
          group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18

    
    sql_trigger_value: SELECT COUNT(*) FROM atomic.com_finerylondon_order_1
    distkey: domain_userid
    sortkeys: [domain_userid, domain_sessionidx, root_tstamp]
    
  fields:
    #################################################################################################################################################################################
  ####################################################### DIMENSIONS ##############################################################################################################
#################################################################################################################################################################################

  - dimension: domain_userid
    type: int
    sql: ${TABLE}.domain_userid
    hidden: true

  - dimension: domain_sessionidx
    sql: ${TABLE}.domain_sessionidx
    hidden: true    
    
  - dimension: order_id
    type: int
    sql: ${TABLE}.order_id
    hidden: true

  - dimension: canceled_flag
    sql: ${TABLE}.canceled_flag
    hidden: true

    #################################################################################################################################################################################
  ####################################################### DIMENSIONS ##############################################################################################################
#################################################################################################################################################################################

  - measure: count_orders
    type: count_distinct
    sql: ${order_id}
    filters:
      canceled_flag: No