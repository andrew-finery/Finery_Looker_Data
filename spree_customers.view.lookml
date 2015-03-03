- view: spree_customers
  derived_table:
    sql: |
        select email, first_order_time, first_order_id, last_order_time, last_order_id, count(distinct order_id) as number_of_orders from
        (select orders.order_id,
        lower(coalesce(users.email_address, orders.email)) as email,
        first_value(orders.completed_at) over(partition by lower(coalesce(users.email_address, orders.email)) order by completed_at asc rows between unbounded preceding and unbounded following) as first_order_time,
        first_value(orders.order_id) over(partition by lower(coalesce(users.email_address, orders.email)) order by completed_at asc rows between unbounded preceding and unbounded following) as first_order_id,
        last_value(orders.completed_at) over(partition by lower(coalesce(users.email_address, orders.email)) order by completed_at asc rows between unbounded preceding and unbounded following) as last_order_time,
        last_value(orders.order_id) over(partition by lower(coalesce(users.email_address, orders.email)) order by completed_at asc rows between unbounded preceding and unbounded following) as last_order_id
        from ${spree_orders.SQL_TABLE_NAME} orders
        left join ${spree_users.SQL_TABLE_NAME} users on orders.customer_id = users.user_id
        where orders.state <> 'canceled')
        group by 1,2,3,4,5

    sql_trigger_value: SELECT max(spree_timestamp) FROM ${spree_orders.SQL_TABLE_NAME}
    distkey: email
    sortkeys: [email]

  fields:

    #####################################################################################################################################################
  ###################################################################  DIMENSIONS  ####################################################################
#####################################################################################################################################################

  - dimension_group: first_order
    label: FIRST ORDER
    type: time
    timeframes: [date, week, month]
    sql: ${TABLE}.first_order_time

  - dimension: number_of_orders
    label: NUMBER OF ORDERS
    sql: ${TABLE}.number_of_orders