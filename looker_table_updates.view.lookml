- view: looker_table_updates

  derived_table:
    sql: |
          select
          view_name,
          table_name,
          convert_timezone('Europe/London', cast(cast(current_date as varchar) || ' ' || start_time || ':00' as datetime)) as start_time,
          creation_time_in_s
          from
          
          (select
          create_started.view_name,
          create_started.table_name,
          right(concat('00', floor((create_started.at - extract (epoch from current_date))/3600)),2) || ':' || right(concat('00', floor((create_started.at - extract (epoch from current_date) - floor((create_started.at - extract (epoch from current_date))/3600)*3600)/60)),2) as start_time,
          create_finished.at - create_started.at as creation_time_in_s
          from
          (select * from looker_scratch.persist_event_log_r3  where action = 'create begin') create_started
          left join
          (select * from looker_scratch.persist_event_log_r3  where action = 'create complete' and action_data = 'production trigger') create_finished
          on create_started.tid = create_finished.tid
          
          where create_started.at > extract (epoch from current_date) -- only look at todays updates
          
          order by 3 desc
          )

  fields:
 
   # DIMENSIONS #
  
  - dimension: view_name
    sql: ${TABLE}.view_name

  - dimension: table_name
    sql: ${TABLE}.table_name

  - dimension_group: start
    label: Table Built Start
    type: time
    timeframes: [time, date]
    sql: ${TABLE}.start_time
    convert_tz: false
  
  - dimension: creation_time_in_s
    label: Creation Time (seconds)
    sql: ${TABLE}.creation_time_in_s
