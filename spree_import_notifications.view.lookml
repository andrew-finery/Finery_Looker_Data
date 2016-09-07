- view: spree_import_notifications

  derived_table:
     sql: |
          with step_1 as (
          select table_name, min(date(spree_timestamp)) as first_import_date from bi_data.spree_integration_table_checks_details
          group by 1
          )
          
          , step_2 as (
          select a.table_name, a.first_import_date, b.calendar_date
          from
          (select table_name, first_import_date from step_1) a
          cross join
          (select calendar_date from finery.calendar) b
          )
          
          , step_3 as (
          select * from step_2
          where calendar_date <= current_date
          and calendar_date >= first_import_date
          )
          
          , step_4 as (
          select table_name, date(spree_timestamp) as import_date
          from bi_data.spree_integration_table_checks_details
          group by 1,2
          )
          
          
          select
          a.table_name,
          a.calendar_date
          from step_3 a
          left join step_4 b
          on a.table_name = b.table_name
          and a.calendar_date = b.import_date
          where b.import_date is null



  fields:

# Dimensions
     - dimension: table_name
       sql: ${TABLE}.table_name

     - dimension_group: import_date
       type: time
       timeframes: [date, week, month, year]
       sql: ${TABLE}.calendar_date

# Measures
     - measure: tables_with_missing_data
       type: count_distinct
       sql: ${table_name}

     - measure: dates_with_missing_data
       type: count_distinct
       sql: ${import_date_date}
       
     - measure: total_missing_imports
       type: count_distinct
       sql: ${table_name} || ${import_date_date}