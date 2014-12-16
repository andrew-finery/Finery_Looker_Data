- view: returns

  derived_table:
     sql: |
        select
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
        (select * from daily_snapshot.spree_return_authorizations where date(spree_timestamp) = current_date) a
        left join
        (select * from daily_snapshot.spree_return_items where date(spree_timestamp) = current_date) b
        on a.id = b.return_authorization_id
        left join
        (select * from daily_snapshot.spree_inventory_units where date(spree_timestamp) = current_date) c
        on b.inventory_unit_id = c.id
        left join
        (select * from daily_snapshot.spree_return_authorization_reasons where date(spree_timestamp) = current_date) d
        on a.return_authorization_reason_id = d.id
        left join
        (select * from daily_snapshot.spree_reimbursements where date(spree_timestamp) = current_date) e
        on b.reimbursement_id = e.id
        left join
        (select * from daily_snapshot.spree_customer_returns where date(spree_timestamp) = current_date) f
        on b.customer_return_id = f.id
        left join
        (select * from daily_snapshot.spree_variants where date(spree_timestamp) = current_date) g
        on c.variant_id = g.id
        left join
        (select * from daily_snapshot.spree_orders where date(spree_timestamp) = current_date) h
        on c.order_id = h.id
          where b.id is not null -- making sure that the return authorizations row has a corresponsing row in the spree return items table
        and a.id <> 1 --removing test return
        
     sql_trigger_value: SELECT COUNT(*) FROM daily_snapshot.spree_return_authorizations
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
       timeframes: [time, hour, date, hod, dow, week, month]
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
