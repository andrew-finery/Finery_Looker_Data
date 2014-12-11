- view: online_products
# View of all products currently live on the website

  derived_table:
     sql: |
       SELECT
         users.id as user_id
         , COUNT(*) as lifetime_orders
         , MAX(orders.date) as most_recent_purchase_date
       FROM orders
       GROUP BY user.id

  fields:
# #     Define your dimensions and measures here, like this:
#     - dimension: profit
#       type: number
#       sql: ${TABLE}.profit
#
#     - measure: total_profit
#       type: sum
#       sql: ${profit}
