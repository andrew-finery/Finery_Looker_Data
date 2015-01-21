- view: page_view_events
  derived_table:
     sql: |
          select
            all_page_views.domain_userid,
            all_page_views.domain_sessionidx,
            all_page_views.event_id,
            all_page_views.collector_tstamp,
            all_page_views.page_type,
            all_page_views.page_type_primary,
            all_page_views.page_type_secondary,
            all_page_views.prod_id,
            all_page_views.page_url,
            all_page_views.page_urlscheme,
            all_page_views.page_urlhost,
            all_page_views.page_urlport,
            all_page_views.page_urlpath,
            all_page_views.page_urlquery,
            all_page_views.page_urlfragment,
            taxons.taxon_name
            from
            (select
            events.domain_userid,
            events.domain_sessionidx,
            events.event_id,
            events.collector_tstamp,
            pageview.page_type,
            left(pageview.page_type, charindex('/', pageview.page_type) - 1) as page_type_primary,
            right(pageview.page_type, len(page_type) - charindex ('/', pageview.page_type)) as page_type_secondary,
            prod_id,
            events.page_url,
            events.page_urlscheme,
            events.page_urlhost,
            events.page_urlport,
            events.page_urlpath,
            events.page_urlquery,
            events.page_urlfragment,
            case when pageview.page_type like '%taxons%' then right(events.page_urlpath, len(events.page_urlpath) - charindex ('t/', events.page_urlpath) - 1) else null end as taxon_permalink
            from atomic.com_finerylondon_page_view_context_1 pageview
            left join atomic.events events
            on events.event_id = pageview.root_id
            where events.event = 'page_view'
            and events.app_id = 'production') all_page_views
            
            left join
            (select permalink, taxon_name from
            (select permalink, first_value(name) over (partition by permalink order by spree_timestamp desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as taxon_name from daily_snapshot.spree_taxons)
            group by 1,2) taxons
            on taxons.permalink = all_page_views.taxon_permalink
            
     sql_trigger_value: SELECT max(collector_tstamp) from atomic.events
     distkey: domain_userid
     sortkeys: [domain_userid, domain_sessionidx, collector_tstamp]
            
  fields:

    ##################################################################################################################################################################################
  ##################################################################   DIMENSIONS   ################################################################################################
##################################################################################################################################################################################

     - dimension: domain_userid
       sql: ${TABLE}.domain_userid

     - dimension: domain_sessionidx
       sql: ${TABLE}.domain_sessionidx
    
     - dimension: session_id
       sql: ${TABLE}.domain_userid || '-' || ${TABLE}.domain_sessionidx

     - dimension: event_id
       sql: ${TABLE}.event_id
      
     - dimension: page_type_primary
       sql: ${TABLE}.page_type_primary

     - dimension: page_type_secondary
       sql: ${TABLE}.page_type_secondary
       
     - dimension: page_viewed
       sql_case:
        Launch Page:      ${TABLE}.page_type_primary = 'launch_invitation'
        Home Page:        ${TABLE}.page_type_primary = 'home'
        Magazine:         ${TABLE}.page_type_primary = 'magazine'
        View Cart:        ${TABLE}.page_type = 'orders/edit'
        View Cart:        ${TABLE}.page_type = 'orders/update'
        Order Complete:   ${TABLE}.page_type = 'orders/edit'
        Product View:     ${TABLE}.page_type = 'products/show'
        Category View:    ${TABLE}.page_type = 'taxons/show'
        My Account:       ${TABLE}.page_type_primary = 'users'
        About:            ${TABLE}.page_type_primary = 'about'
        Checkout:         ${TABLE}.page_type_primary = 'checkout'
        Contact Us:       ${TABLE}.page_type_primary = 'contact'
        FAQ:              ${TABLE}.page_type_primary = 'faq'
        Other Pages:      ${TABLE}.page_type_primary = 'pages'
        else: Unknown
        
     - dimension: product_id
       sql: ${TABLE}.prod_id
    
     - dimension: category_page_viewed
       sql: ${TABLE}.taxon_name


    ##################################################################################################################################################################################
  ##################################################################   MEASURES     ################################################################################################
##################################################################################################################################################################################

     - measure: count_page_views
       type: count_distinct
       sql: ${TABLE}.event_id
    
     - measure: distinct_page_views
       type: count_distinct
       sql: ${TABLE}.domain_userid || '-' || ${TABLE}.domain_sessionidx || '-' || ${TABLE}.page_url
    
     - measure: distinct_product_views
       type: count_distinct
       sql: ${TABLE}.domain_userid || '-' || ${TABLE}.domain_sessionidx || '-' || ${TABLE}.prod_id
    
     - measure: distinct_category_views
       type: count_distinct
       sql: ${TABLE}.domain_userid || '-' || ${TABLE}.domain_sessionidx || '-' || ${TABLE}.taxon_name
















