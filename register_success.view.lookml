- view: register_success
  derived_table:
    sql: |
        SELECT root_id,
               root_tstamp,
               register_method,
               customer_id
        FROM atomic.com_finerylondon_registration_success_1 reg_suc
          LEFT JOIN atomic.events events ON reg_suc.root_id = events.event_id
        WHERE events.app_id = 'production'
  
    sql_trigger_value: SELECT MAX(root_tstamp) FROM atomic.com_finerylondon_registration_success_1
    distkey: root_id
    sortkeys: [root_id, root_tstamp]
        
  fields:

    #######################################################################################################
  ##########################################  DIMENSIONS  ###############################################
#######################################################################################################

  - dimension: event_id
    sql: ${TABLE}.root_id

  - dimension: register_method
    sql: ${TABLE}.register_method
    
  - dimension: customer_id
    sql: ${TABLE}.customer_id

#######################################################################################################
  ##########################################  MEASURES  #################################################
    #######################################################################################################

  - measure: count_registrations
    type: count_distinct
    sql: ${customer_id}
