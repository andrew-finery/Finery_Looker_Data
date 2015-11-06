- view: spree_returns
  sql_table_name: sales.order_returns
  
  fields:

    ##############################################################################################################################################
  ###################################################### DIMENSIONS ############################################################################
##############################################################################################################################################

  - dimension: return_id
    sql: ${TABLE}.return_id
    hidden: true
     
  - dimension: order_id
    sql: ${TABLE}.order_id
       
  - dimension: shipment_id
    sql: ${TABLE}.shipment_id
    hidden: true

  - dimension: sku
    label: sku
    sql: ${TABLE}.sku

  - dimension: return_reason
    sql: ${TABLE}.name

  - dimension_group: returned_at
    type: time
    timeframes: [date, week, month]
    sql: ${TABLE}.created_at
  
  - dimension_group: order_completed
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
    label: Average Days to Return
    type: average
    sql: cast(${days_to_process_return} as decimal(8,2))
    value_format: '#.00'
     
  - measure: number_of_orders_with_returns
    type: count_distinct
    sql: ${order_id}
