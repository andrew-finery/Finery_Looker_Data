- view: goods_commitment
  derived_table:
     sql: |
          select
          brightpearl.ean,
          coalesce(lamoda_units,'0') + coalesce(iconic_units,'0') + coalesce(dafiti_units,'0') + coalesce(namshi_units,'0') + coalesce(zalora_units,'0') as wholesale_units_on_order,
          
          case
          when coalesce(brightpearl.on_order,'0') - coalesce(lamoda_units,'0') - coalesce(iconic_units,'0') - coalesce(dafiti_units,'0') - coalesce(namshi_units,'0') - coalesce(zalora_units,'0') < 0 then 0
          else coalesce(brightpearl.on_order,'0') - coalesce(lamoda_units,'0') - coalesce(iconic_units,'0') - coalesce(dafiti_units,'0') - coalesce(namshi_units,'0') - coalesce(zalora_units,'0')
          end  as ecom_units_on_order,
          
          coalesce(goods_in_wholesale.received_quantity,'0') as wholesale_received_qty,
          coalesce (goods_in_wholesale.expected_quantity,'0') as wholesale_expected_qty,
          coalesce(goods_in_ecom.received_quantity,'0') as ecom_received_qty,
          coalesce (goods_in_ecom.expected_quantity,'0') as ecom_expected_qty,
          
          case
          when coalesce(lamoda_units,'0') + coalesce(iconic_units,'0') + coalesce(dafiti_units,'0') + coalesce(namshi_units,'0') + coalesce(zalora_units,'0') - coalesce(goods_in_wholesale.received_quantity,'0') < 0 then 0
          else coalesce(lamoda_units,'0') + coalesce(iconic_units,'0') + coalesce(dafiti_units,'0') + coalesce(namshi_units,'0') + coalesce(zalora_units,'0') - coalesce(goods_in_wholesale.received_quantity,'0')
          end as wholesale_commitment,
          
          case
          when coalesce(brightpearl.on_order,'0') - coalesce(lamoda_units,'0') - coalesce(iconic_units,'0') - coalesce(dafiti_units,'0') - coalesce(namshi_units,'0') - coalesce(zalora_units,'0') - coalesce(goods_in_ecom.received_quantity,'0') < 0 then 0
          else coalesce(brightpearl.on_order,'0') - coalesce(lamoda_units,'0') - coalesce(iconic_units,'0') - coalesce(dafiti_units,'0') - coalesce(namshi_units,'0') - coalesce(zalora_units,'0') - coalesce(goods_in_ecom.received_quantity,'0')
          end as ecom_commitment
          
          from brightpearl.all_products brightpearl
          
          left join finery.wholesale_commitment_ss15 wholesale_commitment
          on brightpearl.ean = wholesale_commitment.ean
          
          left join (SELECT ean, SUM(receieved_qty) AS received_quantity, SUM(TRIM('UN' FROM expected_qty)) AS expected_quantity FROM finery.goods_in WHERE confirm_date IS NOT NULL and (rcpt_ref_num LIKE '%(W)%' or rcpt_ref_num LIKE '%(WH)%') GROUP BY 1) goods_in_wholesale
          on goods_in_wholesale.ean = brightpearl.ean
          
          left join (SELECT ean, SUM(receieved_qty) AS received_quantity, SUM(TRIM('UN' FROM expected_qty)) AS expected_quantity FROM finery.goods_in WHERE confirm_date IS NOT NULL and rcpt_ref_num NOT LIKE '%(W)%' and rcpt_ref_num NOT LIKE '%(WH)%' GROUP BY 1) goods_in_ecom
          on goods_in_ecom.ean = brightpearl.ean

     sql_trigger_value: SELECT count(*) from ${goods_in.SQL_TABLE_NAME}
     distkey: ean
     sortkeys: [ean]


  fields:

    ########################################################################################################################################################################
  ################################################################  DIMENSIONS  ##########################################################################################
########################################################################################################################################################################

  - dimension: ean
    sql: ${TABLE}.ean
  
########################################################################################################################################################################
  ################################################################  MEASURES  ############################################################################################
    ########################################################################################################################################################################

# Wholesale Measures

  - measure: sum_on_order_qty_wholesale
    type: sum
    sql: ${TABLE}.wholesale_units_on_order

  - measure: sum_received_qty_wholesale
    type: sum
    sql: ${TABLE}.wholesale_received_qty

  - measure: sum_expected_qty_wholesale
    type: sum
    sql: ${TABLE}.wholesale_expected_qty

  - measure: sum_commitment_wholesale
    type: sum
    sql: ${TABLE}.wholesale_commitment
    
  - measure: sum_on_order_value_wholesale
    type: sum
    sql: ${TABLE}.wholesale_units_on_order * ${product_lookup.total_landed_cost_gbp}

  - measure: sum_received_value_wholesale
    type: sum
    sql: ${TABLE}.wholesale_received_qty * ${product_lookup.total_landed_cost_gbp}

  - measure: sum_expected_value_wholesale
    type: sum
    sql: ${TABLE}.wholesale_expected_qty * ${product_lookup.total_landed_cost_gbp}

  - measure: sum_commitment_value_wholesale
    type: sum
    sql: ${TABLE}.wholesale_commitment * ${product_lookup.total_landed_cost_gbp}
    
# Ecom Measures

  - measure: sum_on_order_qty_ecom
    type: sum
    sql: ${TABLE}.ecom_units_on_order

  - measure: sum_received_qty_ecom
    type: sum
    sql: ${TABLE}.ecom_received_qty

  - measure: sum_expected_qty_ecom
    type: sum
    sql: ${TABLE}.ecom_expected_qty

  - measure: sum_commitment_ecom
    type: sum
    sql: ${TABLE}.ecom_commitment
    
  - measure: sum_on_order_value_ecom
    type: sum
    sql: ${TABLE}.ecom_units_on_order * ${product_lookup.total_landed_cost_gbp}

  - measure: sum_received_value_ecom
    type: sum
    sql: ${TABLE}.ecom_received_qty * ${product_lookup.total_landed_cost_gbp}

  - measure: sum_expected_value_ecom
    type: sum
    sql: ${TABLE}.ecom_expected_qty * ${product_lookup.total_landed_cost_gbp}

  - measure: sum_commitment_value_ecom
    type: sum
    sql: ${TABLE}.ecom_commitment * ${product_lookup.total_landed_cost_gbp}
