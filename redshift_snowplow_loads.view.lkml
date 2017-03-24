view: redshift_snowplow_loads {
  derived_table: {
    sql: select etl_tstamp,
       max(collector_tstamp) as latest_event_collected,
       count(*) as rows_loaded
from atomic.events
group by 1
order by 1 desc
 ;;
  }

  dimension_group: load_time {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.etl_tstamp ;;
  }

  dimension_group: last_event_collected_time {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.latest_event_collected ;;
  }

  dimension: rows_loaded {
    type: number
    sql: ${TABLE}.rows_loaded ;;
  }

  ###

  measure: sum_rows_loaded {
    type: sum
    sql: ${rows_loaded} ;;
  }
}
