- view: identity_stitching
  derived_table:
     sql: |
       select aaa.domain_userid, bbb.user_id from

        (select domain_userid from
        (select domain_userid, count(distinct user_id) as count_users from atomic.events where app_id = 'production' and domain_sessionidx is not null group by 1) a
        where count_users = 1) aaa
        
        inner join 
        
        (select domain_userid, user_id from atomic.events where app_id = 'production' and domain_sessionidx is not null and user_id is not null group by 1,2) bbb
        
        on aaa.domain_userid = bbb.domain_userid

     sql_trigger_value: SELECT COUNT(*) FROM ${page_views.SQL_TABLE_NAME}
     distkey: domain_userid
     sortkeys: [domain_userid]


