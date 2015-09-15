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

  - dimension: email
    sql: ${TABLE}.email
  
  - dimension_group: first_order
    label: First Order
    type: time
    timeframes: [date, week, month]
    sql: ${TABLE}.first_order_time

  - dimension: number_of_orders
    label: Number of Orders
    type: number
    sql: ${TABLE}.number_of_orders

  - dimension: has_repurchased
    type: yesno
    sql: ${number_of_orders} != 1
    
## Measures
    
  - measure: total_customers
    type: count_distinct
    sql: ${email}
    
  - measure: repurchasing_customers
    type: count_distinct
    sql: ${email}
    filters:
      has_repurchased: Yes

  - measure: non_repurchasing_customers
    type: count_distinct
    sql: ${email}
    filters:
      has_repurchased: No
      
  - measure: repurchase_rate
    type: number
    sql: ${repurchasing_customers}/NULLIF(${total_customers},0)::REAL
    value_format: '#0.00%'