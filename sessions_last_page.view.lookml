- view: sessions_last_page
  derived_table:
    sql: |
              select
                a.domain_userid,
                a.domain_sessionidx,
                case when c.final_pv = 'DP' then a.dvce_tstamp
                     when c.final_pv = 'PV' then b.dvce_tstamp
                     else a.dvce_tstamp end as dvce_tstamp,
                case when c.final_pv = 'DP' then a.page_urlhost
                     when c.final_pv = 'PV' then b.page_urlhost
                     else a.page_urlhost end as page_urlhost,
                case when c.final_pv = 'DP' then a.page_urlpath
                     when c.final_pv = 'PV' then b.page_urlpath
                     else a.page_urlhost end as page_urlpath
                
                from 
                
                (SELECT
                domain_userid,
                domain_sessionidx,
                page_urlhost, 
                page_urlpath,
                dvce_tstamp 
                FROM (
                SELECT
                domain_userid,
                domain_sessionidx,
                LAST_VALUE(page_urlhost) OVER (PARTITION BY domain_userid, domain_sessionidx ORDER BY dvce_tstamp, event_id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS page_urlhost,
                LAST_VALUE(page_urlpath) OVER (PARTITION BY domain_userid, domain_sessionidx ORDER BY dvce_tstamp, event_id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS page_urlpath,
                LAST_VALUE(dvce_tstamp) OVER (PARTITION BY domain_userid, domain_sessionidx ORDER BY dvce_tstamp, event_id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS dvce_tstamp
                FROM atomic.events
                ) AS a
                GROUP BY 1,2,3,4,5)a
                
                left join
                
                (SELECT
                domain_userid,
                domain_sessionidx,
                page_urlhost, 
                page_urlpath,
                dvce_tstamp 
                FROM (
                SELECT
                domain_userid,
                domain_sessionidx,
                LAST_VALUE(page_urlhost) OVER (PARTITION BY domain_userid, domain_sessionidx ORDER BY dvce_tstamp, event_id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS page_urlhost,
                LAST_VALUE(page_urlpath) OVER (PARTITION BY domain_userid, domain_sessionidx ORDER BY dvce_tstamp, event_id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS page_urlpath,
                LAST_VALUE(dvce_tstamp) OVER (PARTITION BY domain_userid, domain_sessionidx ORDER BY dvce_tstamp, event_id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS dvce_tstamp
                FROM atomic.events
                where event = 'page_view') AS a
                GROUP BY 1,2,3,4,5)b
                
                on a.domain_userid = b.domain_userid
                and a.domain_sessionidx = b.domain_sessionidx
                
                left join
                
                (select
                events.domain_userid as domain_userid,
                events.domain_sessionidx as domain_sessionidx,
                sum(case when event = 'page_view' then 1 else 0 end) as page_views,
                count(distinct page_url) as distinct_pages,
                case when (count(distinct page_url)) > (sum(case when event = 'page_view' then 1 else 0 end)) then 'DP' else 'PV' end as final_pv
                from atomic.events
                group by 1,2) c
                
                on a.domain_userid = c.domain_userid
                and a.domain_sessionidx = c.domain_sessionidx



    sql_trigger_value: SELECT COUNT(*) FROM ${sessions_landing_page.SQL_TABLE_NAME} # Generate this table after the sessions_landing page
    distkey: domain_userid
    sortkeys: [domain_userid, domain_sessionidx]

  fields:
    
  # DIMENSIONS #
  
  - dimension: user_id
    sql: ${TABLE}.domain_userid
    
  - dimension: session_index
    type: int
    sql: ${TABLE}.domain_sessionidx

  - dimension: exit_page_host
    sql: ${TABLE}.page_urlhost
    
  - dimension: exit_page_path
    sql: ${TABLE}.page_urlpath
    
  - measure: count
    type: count
    
  