- view: delivery_tracking_hermes
  derived_table:
   sql: |
       SELECT tracking_code,
             event_timestamp,
             event_description,
             RANK() OVER (PARTITION BY tracking_code ORDER BY event_timestamp DESC) AS event_order_sequence
        FROM (SELECT tracking_code,
                   CAST(calendar_date || ' ' || event_time AS datetime) AS event_timestamp,
                   event_description
            FROM finery.delivery_tracking_information_staging
            GROUP BY 1,
                     2,
                     3)
        -- NB. must group as the same records get loaded multiple times into the staging table


   sql_trigger_value: select count(*) from finery.delivery_tracking_information_staging
   distkey: tracking_code
   sortkeys: [tracking_code, event_timestamp]
   
  fields:

    ###################################################################################################################################################################
  ####################################################################  DIMENSIONS  #################################################################################
###################################################################################################################################################################

  - dimension: tracking_code
    sql: ${TABLE}.tracking_code
    
  - dimension_group: event__time
    type: time
    timeframes: [time, hour, date, week, month]
    sql: ${TABLE}.event_time
       
  - dimension: delivery_event
    sql: ${TABLE}.event_description

