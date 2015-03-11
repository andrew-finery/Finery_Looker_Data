- view: sessions_source
  derived_table:
    sql: |
      SELECT *
      FROM (
        SELECT
          domain_userid,
          domain_sessionidx,
          mkt_source,
          mkt_medium,
          mkt_campaign,
          mkt_term,
          refr_source,
          refr_medium,
          refr_term,
          refr_urlhost,
          refr_urlpath,
          dvce_tstamp,
          RANK() OVER (PARTITION BY domain_userid, domain_sessionidx 
            ORDER BY dvce_tstamp, mkt_source, mkt_medium, mkt_campaign, mkt_term, refr_source, refr_medium, refr_term, refr_urlhost, refr_urlpath) AS "rank"
        FROM
          atomic.events
        WHERE
          (refr_medium is null or refr_medium != 'internal') -- Not an internal referer
          and refr_urlhost not like '%paypal%' -- ignore referrals from paypal
          AND (
            NOT(refr_medium IS NULL OR refr_medium = '') OR
            NOT ((mkt_campaign IS NULL AND mkt_content IS NULL AND mkt_medium IS NULL AND mkt_source IS NULL AND mkt_term IS NULL)
                    OR (mkt_campaign = '' AND mkt_content = '' AND mkt_medium = '' AND mkt_source = '' AND mkt_term = '')
            )
          ) -- Either the refr or mkt fields are set (not blank)
          AND app_id = 'production'
        GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12) AS t
      WHERE "rank" = 1 -- Only pull the first referer for each visit
    
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
      Affiliates: ${TABLE}.refr_medium = 'unknown'
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
      
    