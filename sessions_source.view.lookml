- view: sessions_source
  derived_table:
    sql: |
          SELECT
          domain_userid, domain_sessionidx,
          mkt_source_ga, mkt_medium_ga, mkt_campaign_ga, mkt_term_ga, mkt_content_ga,
          refr_source_ga, refr_medium_ga, refr_term_ga, refr_urlhost_ga, refr_urlpath_ga,
          max(mkt_source) as mkt_source, max(mkt_medium) as mkt_medium, max(mkt_campaign) as mkt_campaign, max(mkt_term) as mkt_term, max(mkt_content) as mkt_content,
          max(refr_source) as refr_source, max(refr_medium) as refr_medium, max(refr_term) as refr_term, max(refr_urlhost) as refr_urlhost, max(refr_urlpath) as refr_urlpath
          
          FROM
          
          (SELECT
          all_sessions.domain_userid,
          all_sessions.domain_sessionidx,
          
          first_value(sessions_source.mkt_source) over(partition by all_sessions.domain_userid, all_sessions.domain_sessionidx order by sessions_source.domain_sessionidx desc rows between unbounded preceding and unbounded following) as mkt_source_ga,
          first_value(sessions_source.mkt_medium) over(partition by all_sessions.domain_userid, all_sessions.domain_sessionidx order by sessions_source.domain_sessionidx desc rows between unbounded preceding and unbounded following) as mkt_medium_ga,
          first_value(sessions_source.mkt_campaign) over(partition by all_sessions.domain_userid, all_sessions.domain_sessionidx order by sessions_source.domain_sessionidx desc rows between unbounded preceding and unbounded following) as mkt_campaign_ga,
          first_value(sessions_source.mkt_term) over(partition by all_sessions.domain_userid, all_sessions.domain_sessionidx order by sessions_source.domain_sessionidx desc rows between unbounded preceding and unbounded following) as mkt_term_ga,
          first_value(sessions_source.mkt_content) over(partition by all_sessions.domain_userid, all_sessions.domain_sessionidx order by sessions_source.domain_sessionidx desc rows between unbounded preceding and unbounded following) as mkt_content_ga,
          
          first_value(sessions_source.refr_source) over(partition by all_sessions.domain_userid, all_sessions.domain_sessionidx order by sessions_source.domain_sessionidx desc rows between unbounded preceding and unbounded following) as refr_source_ga,
          first_value(sessions_source.refr_medium) over(partition by all_sessions.domain_userid, all_sessions.domain_sessionidx order by sessions_source.domain_sessionidx desc rows between unbounded preceding and unbounded following) as refr_medium_ga,
          first_value(sessions_source.refr_term) over(partition by all_sessions.domain_userid, all_sessions.domain_sessionidx order by sessions_source.domain_sessionidx desc rows between unbounded preceding and unbounded following) as refr_term_ga,
          first_value(sessions_source.refr_urlhost) over(partition by all_sessions.domain_userid, all_sessions.domain_sessionidx order by sessions_source.domain_sessionidx desc rows between unbounded preceding and unbounded following) as refr_urlhost_ga,
          first_value(sessions_source.refr_urlpath) over(partition by all_sessions.domain_userid, all_sessions.domain_sessionidx order by sessions_source.domain_sessionidx desc rows between unbounded preceding and unbounded following) as refr_urlpath_ga,
          
          case when sessions_source.domain_sessionidx = all_sessions.domain_sessionidx then sessions_source.mkt_source else null end as mkt_source,
          case when sessions_source.domain_sessionidx = all_sessions.domain_sessionidx then sessions_source.mkt_medium else null end as mkt_medium,
          case when sessions_source.domain_sessionidx = all_sessions.domain_sessionidx then sessions_source.mkt_campaign else null end as mkt_campaign,
          case when sessions_source.domain_sessionidx = all_sessions.domain_sessionidx then sessions_source.mkt_term else null end as mkt_term,
          case when sessions_source.domain_sessionidx = all_sessions.domain_sessionidx then sessions_source.mkt_content else null end as mkt_content,
          
          case when sessions_source.domain_sessionidx = all_sessions.domain_sessionidx then sessions_source.refr_source else null end as refr_source,
          case when sessions_source.domain_sessionidx = all_sessions.domain_sessionidx then sessions_source.refr_medium else null end as refr_medium,
          case when sessions_source.domain_sessionidx = all_sessions.domain_sessionidx then sessions_source.refr_term else null end as refr_term,
          case when sessions_source.domain_sessionidx = all_sessions.domain_sessionidx then sessions_source.refr_urlhost else null end as refr_urlhost,
          case when sessions_source.domain_sessionidx = all_sessions.domain_sessionidx then sessions_source.refr_urlpath else null end as refr_urlpath
          
          FROM
          
          (SELECT domain_userid, domain_sessionidx, MIN(collector_tstamp) AS session_start_time
          FROM atomic.events
          WHERE domain_sessionidx IS NOT NULL
          AND   app_id = 'production'
          GROUP BY 1,2) all_sessions
          
          LEFT JOIN
          
          (SELECT *
          FROM (
          SELECT
          domain_userid, domain_sessionidx, mkt_source, mkt_medium, mkt_campaign, mkt_term, mkt_content, refr_source, refr_medium, refr_term, refr_urlhost, refr_urlpath, dvce_tstamp,
          RANK() OVER (PARTITION BY domain_userid, domain_sessionidx ORDER BY dvce_tstamp, mkt_source, mkt_medium, mkt_campaign, mkt_term, refr_source, refr_medium, refr_term, refr_urlhost, refr_urlpath) AS "rank",
          min(collector_tstamp) as session_start_time
          FROM atomic.events
          WHERE (refr_medium is null or refr_medium != 'internal') -- Not an internal referer
          AND (refr_urlhost is null or refr_urlhost not like '%paypal%') -- ignore referrals from paypal
          AND (NOT(refr_medium IS NULL OR refr_medium = '') OR NOT ((mkt_campaign IS NULL AND mkt_content IS NULL AND mkt_medium IS NULL AND mkt_source IS NULL AND mkt_term IS NULL) OR (mkt_campaign = '' AND mkt_content = '' AND mkt_medium = '' AND mkt_source = '' AND mkt_term = ''))) -- Either the refr or mkt fields are set (not blank)
          AND app_id = 'production'
          GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13) AS t
          WHERE "rank" = 1 -- Only pull the first referer for each visit
          )sessions_source
          
          on all_sessions.domain_userid = sessions_source.domain_userid
          
          where all_sessions.domain_sessionidx >= sessions_source.domain_sessionidx -- only get the sessions that happen before the session you are looking at
          and all_sessions.session_start_time < DATEADD(month,6, sessions_source.session_start_time) -- only get sessions that are within the 'campaign period' - in this case 6 months
          AND (NOT(sessions_source.refr_medium IS NULL OR sessions_source.refr_medium = '') OR NOT ((sessions_source.mkt_campaign IS NULL AND sessions_source.mkt_content IS NULL AND sessions_source.mkt_medium IS NULL AND sessions_source.mkt_source IS NULL AND sessions_source.mkt_term IS NULL) OR (sessions_source.mkt_campaign = '' AND sessions_source.mkt_content = '' AND sessions_source.mkt_medium = '' AND sessions_source.mkt_source = '' AND sessions_source.mkt_term = ''))) -- only look at sessions that have a source attached to them
          )
          GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12
    
    sql_trigger_value: SELECT COUNT(*) FROM ${sessions_last_page.SQL_TABLE_NAME}
    distkey: domain_userid
    sortkeys: [domain_userid, domain_sessionidx]

  fields:
  
  # DIMENSIONS #
  
  # Basic dimensions #
  - dimension: user_id
    sql: ${TABLE}.domain_userid
    
  - dimension: session_index
    type: int
    sql: ${TABLE}.domain_sessionidx
    
  
  # Referer fields (all acquisition channels) #

  - dimension: session_source
    sql_case:
      Facebook - Paid Marketing: ${TABLE}.mkt_source = 'facebook' and ${TABLE}.mkt_medium = 'paid'
      Email - from Finery: ${TABLE}.mkt_source in ('crm', 'newsletter') and ${TABLE}.mkt_medium = 'email'
      Other Marketing: ${TABLE}.mkt_source is not null or ${TABLE}.mkt_medium is not null
      Social: ${TABLE}.refr_medium = 'social'
      Search: ${TABLE}.refr_medium = 'search'
      Referral: ${TABLE}.refr_medium = 'unknown'
      Email - Other: ${TABLE}.refr_medium = 'email'
      else: Direct
    
  - dimension: referer_medium
    sql_case:
      email: ${TABLE}.refr_medium = 'email'
      search: ${TABLE}.refr_medium = 'search'
      social: ${TABLE}.refr_medium = 'social'
      other_website: ${TABLE}.refr_medium = 'unknown'
      else: direct
    
  - dimension: referer_source
    sql: ${TABLE}.refr_source
    
  - dimension: referer_term
    sql: ${TABLE}.refr_term
    
  - dimension: referer_url_host
    sql: ${TABLE}.refr_urlhost
  
  - dimension: referer_url_path
    sql: ${TABLE}.refr_urlpath
  
  - dimension: paid_marketing_flag
    sql: |
        case
        when ${referer_url_host} = 'www.googleadservices.com' then 'Paid'
        when ${TABLE}.mkt_source = 'facebook' and ${TABLE}.mkt_medium = 'paid' then 'Paid'
        else 'Unpaid' end
    
  # MKT fields (paid acquisition channels)
    
  - dimension: campaign_medium
    sql: ${TABLE}.mkt_medium
  
  - dimension: campaign_source
    sql: ${TABLE}.mkt_source
  
  - dimension: campaign_term
    sql: ${TABLE}.mkt_term
  
  - dimension: campaign_name
    sql: ${TABLE}.mkt_campaign
      
    