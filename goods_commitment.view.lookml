- view: goods_commitment
  derived_table:
     sql: |
       SELECT COALESCE(brightpearl.ean,'0') AS ean,
              COALESCE(brightpearl.on_order,'0') AS on_order_qty,
              COALESCE(goods_in.received_quantity,'0') AS received_qty,
              COALESCE(goods_in.expected_quantity,'0') AS expected_qty,
              CASE
                WHEN COALESCE(goods_in.received_quantity,'0') >COALESCE(brightpearl.on_order,'0') THEN 0
                ELSE COALESCE(brightpearl.on_order,'0') -COALESCE(goods_in.received_quantity,'0')
              END AS outstanding_commitment
       FROM brightpearl.all_products brightpearl
         LEFT JOIN (SELECT ean,
                           SUM(receieved_qty) AS received_quantity,
                           SUM(TRIM('UN' FROM expected_qty)) AS expected_quantity
                    FROM cml.goods_in
                    WHERE confirm_date IS NOT NULL
                    GROUP BY 1) goods_in ON brightpearl.ean = goods_in.ean

     sql_trigger_value: SELECT max(confirm_date from cml.goods_in
     distkey: ean
     sortkeys: [ean]


  fields:

    ########################################################################################################################################################################
  ################################################################  DIMENSIONS  ##########################################################################################
########################################################################################################################################################################

  - dimension: ean
    sql: ${TABLE}.ean
  
  - dimension: total_landed_cost_gbp
    sql: ${product_lookup.total_landed_cost_gbp}

########################################################################################################################################################################
  ################################################################  MEASURES  ############################################################################################
    ########################################################################################################################################################################

  - measure: sum_on_order_qty
    type: sum
    sql: ${TABLE}.on_order_qty

  - measure: sum_received_qty
    type: sum
    sql: ${TABLE}.received_qty

  - measure: sum_expected_qty
    type: sum
    sql: ${TABLE}.expected_qty

  - measure: sum_commitment
    type: sum
    sql: ${TABLE}.outstanding_commitment
    
  - measure: sum_on_order_value
    type: sum
    sql: ${TABLE}.on_order_qty * ${product_lookup.total_landed_cost_gbp}

  - measure: sum_received_value
    type: sum
    sql: ${TABLE}.received_qty * ${product_lookup.total_landed_cost_gbp}

  - measure: sum_expected_value
    type: sum
    sql: ${TABLE}.expected_qty * ${product_lookup.total_landed_cost_gbp}

  - measure: sum_commitment_value
    type: sum
    sql: ${TABLE}.outstanding_commitment * ${product_lookup.total_landed_cost_gbp} 