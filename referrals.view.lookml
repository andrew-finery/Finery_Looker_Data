- view: referrals
  derived_table:
     sql: |
        SELECT sent_by_id,
               code,
               id,
               created_at
        FROM daily_snapshot.spree_invitations
        WHERE spree_timestamp = (SELECT MAX(spree_timestamp)
                                 FROM daily_snapshot.spree_invitations)
        AND   created_at > DATE '2015-01-01'
        AND   sent_by_id IS NOT NULL

     sql_trigger_value: SELECT MAX(spree_timestamp) FROM daily_snapshot.spree_invitations
     distkey: sent_by_id
     sortkeys: [sent_by_id]

  fields:

############################################################################################################################################
#####################################################   DIMENSIONS  ########################################################################
############################################################################################################################################

  - dimension: sent_by_id
    sql: ${TABLE}.sent_by_id
  
  - dimension: referral_id
    sql: ${TABLE}.referral_id

############################################################################################################################################
#####################################################   MEASURES  ##########################################################################
############################################################################################################################################
  
  - measure: referrals_sent
    type: count_distinct
    sql: ${TABLE}.id

## Temporary Measure for Competition

  - measure: net_revenue
    type: sum
    sql: (${spree_orders.item_total} + ${spree_orders.shipping_total} - ${spree_orders.return_item_total}) * ${spree_orders.exchange_rate}
    format: "£%0.2f"
    filters:
      spree_orders.state: -canceled
  
  - measure: count_signups
    type: count_distinct
    sql: ${spree_users_2.customer_id}
  
  - measure: sign_up_rate
    type: number
    decimals: 2
    sql: 100.0 * ${count_signups}/NULLIF(${referrals_sent},0)::REAL
    format: "%0.2f%"
  
  - measure: count_orders
    type: count_distinct
    sql: ${spree_orders.order_id}
    filters:
      spree_orders.state: -canceled
  
  - measure: count_customers
    type: count_distinct
    sql: ${spree_orders.customer_id}
    filters:
      spree_orders.state: -canceled
      
  - measure: purchase_rate
    type: number
    decimals: 2
    sql: 100.0 * ${count_customers}/NULLIF(${referrals_sent},0)::REAL
    format: "%0.2f%"

  - measure: average_net_revenue
    type: number
    decimals: 2
    sql: ${net_revenue}/NULLIF(${count_orders},0)::REAL
    format: "£%0.2f"
  
  
    