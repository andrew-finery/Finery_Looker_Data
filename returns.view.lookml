- view: returns

  derived_table:
     sql: |
        select
        a.spree_timestamp,
        a.created_at,
        a.updated_at,
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
        
     sql_trigger_value: SELECT max(spree_timestamp) FROM daily_snapshot.spree_return_items
     distkey: return_id
     sortkeys: [return_id, created_at]

  fields:

     - dimension: return_id
       sql: ${TABLE}.return_id
     
     - dimension: order_id
       sql: ${TABLE}.order_id
       
     - dimension: shipment_id
       sql: ${TABLE}.shipment_id

     - dimension: sku
       sql: ${TABLE}.sku

     - dimension: return_reason
       sql: ${TABLE}.name

     - dimension_group: returned_at
       type: time
       timeframes: [time, hour, date, hour_of_day, day_of_week, week, month]
       sql: ${TABLE}.created_at

     - dimension: reception_status
       sql: ${TABLE}.reception_status

     - dimension: acceptance_status
       sql: ${TABLE}.acceptance_status

     - dimension: item_total
       sql: ${TABLE}.pre_tax_amount

     - dimension: reimbursement_total
       sql: ${TABLE}.total_reimbursed

     - dimension: reimbursement_status
       sql: ${TABLE}.reimbursement_status

     - dimension: customer_return_code
       sql: ${TABLE}.customer_return_code
       
     - dimension: return_authorization_code
       sql: ${TABLE}.return_authorization_code
       
     - dimension: reimbursemenet_code
       sql: ${TABLE}.reimbursemenet_code
       
    # Measures
       
     - measure: number_of_returns
       type: count_distinct
       sql: ${return_id}
       
     - measure: number_of_orders_with_returns
       type: count_distinct
       sql: ${order_id}
