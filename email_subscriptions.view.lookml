- view: email_subscriptions
  derived_table:
     sql: |
          SELECT root_tstamp,
                 root_id,
                 "type" AS event_type,
                 "data.email" AS email_address,
                 "data.id" AS email_id,
                 "data.web_id" AS web_id,
                 "data.ip_opt" AS ip_address,
                 "data.list_id" AS list_id,
                 "data.merges.fname" AS first_name,
                 "data.merges.lname" AS last_name
          FROM atomic.com_mailchimp_subscribe_1


     sql_trigger_value: SELECT count(*) from atomic.com_mailchimp_subscribe_1
     distkey: root_id
     sortkeys: [root_tstamp]

  fields:

    ##################################################################################################################################################################################
  ######################################################################  DIMENSIONS  ##############################################################################################
##################################################################################################################################################################################

   - dimension: event_id
     sql: ${TABLE}.root_id
    
   - dimension: event_type
     sql: ${TABLE}.event_type
  
   - dimension: email_id
     sql: ${TABLE}.email_id
  
   - dimension: email_list_name
     sql_case:
       Newsletter: ${TABLE}.list_id = '179a8621fb'
       Referrals: ${TABLE}.list_id = 'de06e9bf29'
       else: Other
    
##################################################################################################################################################################################
  ######################################################################  MEASURES  ################################################################################################
    ##################################################################################################################################################################################

   - measure: count_newsletter_subscribers
     type: count_distinct
     sql: ${TABLE}.email_id
     filters:
      email_list_name: Newsletter
  
   - measure: count_referrals
     type: count_distinct
     sql: ${TABLE}.email_id
     filters:
      email_list_name: Referrals