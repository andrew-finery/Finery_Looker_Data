- view: returns

  derived_table:
     sql: |
        select
        a.spree_timestamp,
        a.created_at,
        a.updated_at,
        h.completed_at as order_completed_tstamp,
        a.id as return_id,
        c.order_id,
        h.user_id,
        c.variant_id,
        g.sku,
        g.product_id,
        c.shipment_id,
        d.name,
        b.reception_status,
        b.acceptance_status,
        b.pre_tax_amount,
        b.included_tax_total,
        b.additional_tax_total,
        a."number" as return_authorization_code,
        e."number" as reimbursemenet_code,
        f."number" as customer_return_code,
        e.reimbursement_status,
        e.total as total_reimbursed
        
        from
        (select * from daily_snapshot.spree_return_authorizations where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_return_authorizations)) a
        left join
        (select * from daily_snapshot.spree_return_items where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_return_items)) b
        on a.id = b.return_authorization_id
        left join
        (select * from daily_snapshot.spree_inventory_units where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_inventory_units)) c
        on b.inventory_unit_id = c.id
        left join
        (select * from daily_snapshot.spree_return_authorization_reasons where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_return_authorization_reasons)) d
        on a.return_authorization_reason_id = d.id
        left join
        (select * from daily_snapshot.spree_reimbursements where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_reimbursements)) e
        on b.reimbursement_id = e.id
        left join
        (select * from daily_snapshot.spree_customer_returns where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_customer_returns)) f
        on b.customer_return_id = f.id
        left join
        (select * from daily_snapshot.spree_variants where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_variants)) g
        on c.variant_id = g.id
        left join
        (select * from daily_snapshot.spree_orders where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_orders)) h
        on c.order_id = h.id
          where b.id is not null -- making sure that the return authorizations row has a corresponsing row in the spree return items table
          and b.reception_status = 'received' and b.acceptance_status = 'accepted'
        
     sql_trigger_value: SELECT max(spree_timestamp) FROM ${spree_users.SQL_TABLE_NAME}
     distkey: return_id
     sortkeys: [return_id, created_at]

  fields:

    ##############################################################################################################################################
  ###################################################### DIMENSIONS ############################################################################
##############################################################################################################################################

  - dimension: return_id
    label: RETURN ID
    sql: ${TABLE}.return_id
    hidden: true
     
  - dimension: order_id
    label: ORDER ID
    sql: ${TABLE}.order_id
    hidden: true
       
  - dimension: shipment_id
    label: SHIPMENT ID
    sql: ${TABLE}.shipment_id
    hidden: true

  - dimension: sku
    label: SKU
    sql: ${TABLE}.sku
    hidden: true

  - dimension: return_reason
    label: RETURN REASON
    sql: ${TABLE}.name

  - dimension_group: returned_at
    label: RETURNED
    type: time
    timeframes: [date, week, month]
    sql: ${TABLE}.created_at
  
  - dimension_group: order_completed
    label: ORDER PLACED
    type: time
    timeframes: [date, week, month]
    sql: ${TABLE}.order_completed_tstamp
  
  - dimension: reception_status
    sql: ${TABLE}.reception_status
    hidden: true

  - dimension: acceptance_status
    sql: ${TABLE}.acceptance_status
    hidden: true

  - dimension: item_total
    sql: ${TABLE}.pre_tax_amount
    hidden: true

  - dimension: reimbursement_total
    sql: ${TABLE}.total_reimbursed
    hidden: true

  - dimension: reimbursement_status
    sql: ${TABLE}.reimbursement_status
    hidden: true

  - dimension: customer_return_code
    sql: ${TABLE}.customer_return_code
    hidden: true
       
  - dimension: return_authorization_code
    sql: ${TABLE}.return_authorization_code
    hidden: true
       
  - dimension: reimbursemenet_code
    sql: ${TABLE}.reimbursemenet_code
    hidden: true
     
  - dimension: days_to_process_return
    type: int
    sql: ${returned_at_date} - ${order_completed_date}

    ##############################################################################################################################################
  ###################################################### MEASURES ##############################################################################
##############################################################################################################################################

  - measure: items_returned
    type: number
    sql: count(*)
  
  - measure: average_days_to_process_return
    label: AVERAGE DAYS TO RETURN
    type: average
    sql: cast(${days_to_process_return} as decimal(8,2))
    value_format: '#.00'
     
  - measure: number_of_orders_with_returns
    type: count_distinct
    sql: ${order_id}
