- view: delivery_tracking_current_status
  derived_table:
   sql: |
       select
        all_codes.tracking_code,
        hub_received.hub_received_date,
        misrouted.misrouted_date,
        missort.missort_date,
        depot_received.depot_received_date,
        missing_pre_advice.missing_pre_advice_date,
        more_info_required.more_info_required_date,
        out_for_delivery.out_for_delivery_date,
        courier_received.courier_received_date,
        carried_forward.carried_forward_date,
        first_attempt.first_attempt_tstamp as first_attempt_time,
        delivery.delivery_tstamp,
        not_delivered.not_delivered_tstamp as delivery_confirmed_time,
        refused.refused_tstamp,
        returned_to_sender.returned_to_sender_tstamp,
        return_processed.return_processed_tstamp as return_confirmed_time,
        delay.delay_tstamp,
        latest_event.latest_event_tstamp as latest_event_time,
        latest_event.latest_event_description as current_status
        
        from
        (SELECT tracking_code from finery.delivery_tracking_information_staging group by 1) all_codes
        left join
        (SELECT tracking_code, min(calendar_date) as hub_received_date FROM finery.delivery_tracking_information_staging where event_description in ('Hub Trailer Via Sorter', 'Receipt at Hub', 'Hub Sorter Receipt Scan') group by 1) hub_received
        on all_codes.tracking_code = hub_received.tracking_code
        left join
        (SELECT tracking_code, min(calendar_date) as misrouted_date FROM finery.delivery_tracking_information_staging where event_description = 'Misrouted to Incorrect Depot' group by 1) misrouted
        on all_codes.tracking_code = misrouted.tracking_code
        left join
        (SELECT tracking_code, min(calendar_date) as missort_date FROM finery.delivery_tracking_information_staging where event_description = 'Missort to Incorrect Courier' group by 1) missort
        on all_codes.tracking_code = missort.tracking_code
        left join
        (SELECT tracking_code, min(calendar_date) as depot_received_date FROM finery.delivery_tracking_information_staging where event_description in ('Processed at Depot', 'Receipt at Depot', 'Receipt @ Depot') group by 1) depot_received
        on all_codes.tracking_code = depot_received.tracking_code
        left join
        (SELECT tracking_code, min(calendar_date) as missing_pre_advice_date FROM finery.delivery_tracking_information_staging where event_description = 'Missing Pre-Advice' group by 1) missing_pre_advice
        on all_codes.tracking_code = missing_pre_advice.tracking_code
        left join
        (SELECT tracking_code, min(calendar_date) as more_info_required_date FROM finery.delivery_tracking_information_staging where event_description like 'Additional Delivery Info Rec%' or event_description in ('Not Delivered - Postcode error', 'Not Delivered - Address Query', 'Parcel query-receipt at depot') group by 1) more_info_required
        on all_codes.tracking_code = more_info_required.tracking_code
        left join
        (SELECT tracking_code, min(calendar_date) as out_for_delivery_date FROM finery.delivery_tracking_information_staging where event_description in ('Out For Delivery', 'Out For Delivery To Courier') group by 1) out_for_delivery
        on all_codes.tracking_code = out_for_delivery.tracking_code
        left join
        (SELECT tracking_code, min(calendar_date) as courier_received_date FROM finery.delivery_tracking_information_staging where event_description = 'Courier Received' group by 1) courier_received
        on all_codes.tracking_code = courier_received.tracking_code
        left join
        (SELECT tracking_code, min(calendar_date) as carried_forward_date FROM finery.delivery_tracking_information_staging where event_description = 'Carried Forward' group by 1) carried_forward
        on all_codes.tracking_code = carried_forward.tracking_code
        left join
        (SELECT tracking_code, min(CAST(calendar_date || ' ' || event_time AS datetime)) as first_attempt_tstamp FROM finery.delivery_tracking_information_staging where event_description like '%Signature%' or event_description like '%Delivered to%' or event_description like '%Delivery Confirmed%' or event_description like '%Courier to Re-attempt%' group by 1) first_attempt
        on all_codes.tracking_code = first_attempt.tracking_code
        left join
        (SELECT tracking_code, min(CAST(calendar_date || ' ' || event_time AS datetime)) as delivery_tstamp FROM finery.delivery_tracking_information_staging where event_description like '%Signature%' or event_description like '%Delivered to%' or event_description like '%Delivery Confirmed%' group by 1) delivery
        on all_codes.tracking_code = delivery.tracking_code
        left join
        (SELECT tracking_code, min(CAST(calendar_date || ' ' || event_time AS datetime)) as not_delivered_tstamp FROM finery.delivery_tracking_information_staging where event_description like '%Not Del%' group by 1) not_delivered
        on all_codes.tracking_code = not_delivered.tracking_code
        left join
        (SELECT tracking_code, min(CAST(calendar_date || ' ' || event_time AS datetime)) as refused_tstamp FROM finery.delivery_tracking_information_staging where event_description like '%Refused%' group by 1) refused
        on all_codes.tracking_code = refused.tracking_code
        left join
        (SELECT tracking_code, min(CAST(calendar_date || ' ' || event_time AS datetime)) as returned_to_sender_tstamp FROM finery.delivery_tracking_information_staging where event_description like '%Returned To Sender%' group by 1) returned_to_sender
        on all_codes.tracking_code = returned_to_sender.tracking_code
        left join
        (SELECT tracking_code, min(CAST(calendar_date || ' ' || event_time AS datetime)) as return_processed_tstamp FROM finery.delivery_tracking_information_staging where event_description like '%Return - Processed By Depot%' group by 1) return_processed
        on all_codes.tracking_code = return_processed.tracking_code
        left join
        (SELECT tracking_code, min(CAST(calendar_date || ' ' || event_time AS datetime)) as delay_tstamp, max(event_description)  FROM finery.delivery_tracking_information_staging where event_description like '%Delay%' group by 1) delay
        on all_codes.tracking_code = delay.tracking_code
        left join
        (SELECT tracking_code, latest_event_tstamp, latest_event_description from
        (SELECT tracking_code,
        first_value(event_timestamp) over(partition by tracking_code order by event_timestamp desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as latest_event_tstamp,
        first_value(event_description) over(partition by tracking_code order by event_timestamp desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as latest_event_description
        from (SELECT tracking_code,CAST(calendar_date || ' ' || event_time AS datetime) as event_timestamp, event_description from finery.delivery_tracking_information_staging)) group by 1,2,3) latest_event
        on all_codes.tracking_code = latest_event.tracking_code

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

