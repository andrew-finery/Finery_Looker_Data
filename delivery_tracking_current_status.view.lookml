- view: delivery_tracking_current_status
  derived_table:
   sql: |
       select
        all_deliveries.tracking_code,
        all_deliveries.current_status,
        all_deliveries.event_timestamp as latest_event_time,
        first_attempts.first_attempt_timestamp as first_attempt_time,
        confirmed_deliveries.delivery_timestamp as delivery_confirmed_time,
        deliveries_returned.return_timestamp as return_confirmed_time
        
        from
        (select tracking_code, event_timestamp, max(event_description) as current_status
        from
        ${delivery_tracking_hermes.SQL_TABLE_NAME}
        where event_order_sequence = 1
        group by 1,2) all_deliveries
        
        left join
        (select
        tracking_code,
        min(event_timestamp) as delivery_timestamp
        from 
        ${delivery_tracking_hermes.SQL_TABLE_NAME}
        where event_description like '%Signature%'
        or event_description like '%Delivered%'
        or event_description like '%Delivery Confirmed by Courier%'
        group by 1) confirmed_deliveries
        on all_deliveries.tracking_code = confirmed_deliveries.tracking_code
        
        left join
        (select
        tracking_code,
        min(event_timestamp) as first_attempt_timestamp
        from 
        ${delivery_tracking_hermes.SQL_TABLE_NAME}
        where event_description like '%Signature%'
        or event_description like '%Delivered%'
        or event_description like '%Delivery Confirmed by Courier%'
        or event_description like '%Courier to Re-attempt%'
        group by 1) first_attempts
        on all_deliveries.tracking_code = first_attempts.tracking_code
        
        left join
        (select
        tracking_code,
        min(event_timestamp) as return_timestamp
        from 
        ${delivery_tracking_hermes.SQL_TABLE_NAME}
        where event_description like '%Return - Processed By Depot%'
        group by 1) deliveries_returned
        on all_deliveries.tracking_code = deliveries_returned.tracking_code



   sql_trigger_value: select max(event_timestamp) from ${delivery_tracking_hermes.SQL_TABLE_NAME}
   distkey: tracking_code
   sortkeys: [tracking_code]
   
  fields:

    ###################################################################################################################################################################
  ####################################################################  DIMENSIONS  #################################################################################
###################################################################################################################################################################

  - dimension: tracking_code
    sql: ${TABLE}.tracking_code

# Time and Description of latest event
    
  - dimension_group: latest_event_time
    type: time
    timeframes: [time, hour, date, week, month]
    sql: ${TABLE}.latest_event_time
       
  - dimension: latest_delivery_event
    sql: ${TABLE}.current_status

# Time of first attempt

  - dimension_group: first_attempt_time
    type: time
    timeframes: [time, hour, date, week, month]
    sql: ${TABLE}.first_attempt_time

  - dimension_group: delivery_confirmed_time
    type: time
    timeframes: [time, hour, date, week, month]
    sql: ${TABLE}.delivery_confirmed_time

  - dimension_group: return_confirmed_time
    type: time
    timeframes: [time, hour, date, week, month]
    sql: ${TABLE}.return_confirmed_time

