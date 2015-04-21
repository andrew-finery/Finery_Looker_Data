- view: email_subscriptions
  sql_table_name: atomic.com_mailchimp_subscribe_1

  fields:

    ##################################################################################################################################################################################
  ######################################################################  DIMENSIONS  ##############################################################################################
##################################################################################################################################################################################

   - dimension: event_id
     sql: ${TABLE}.root_id
     hidden: true
    
   - dimension_group: event_time
     type: time
     timeframes: [date]
     sql: convert_timezone('UTC', 'Europe/London', ${TABLE}.root_tstamp)
     hidden: true
    
   - dimension: event_type
     sql: ${TABLE}."type"
  
   - dimension: email_id
     sql: ${TABLE}."data.id"
     hidden: true
  
   - dimension: email_list_name
     sql_case:
       Newsletter: ${TABLE}."data.list_id" = '179a8621fb'
       Referrals: ${TABLE}."data.list_id" = 'de06e9bf29'
       else: Other
    
##################################################################################################################################################################################
  ######################################################################  MEASURES  ################################################################################################
    ##################################################################################################################################################################################

   - measure: count_newsletter_subscribers
     type: count_distinct
     sql: ${email_id}
     filters:
      email_list_name: Newsletter
  
   - measure: count_referrals
     type: count_distinct
     sql: ${email_id}
     filters:
      email_list_name: Referrals
  
  # WoW stuff
  
   - measure: count_newsletter_subscribers_yesterday
     type: count_distinct
     sql: ${email_id}
     filters:
      email_list_name: Newsletter
      event_time_date: 1 day ago for 1 day
     hidden: true

   - measure: count_newsletter_subscribers_last_week
     type: count_distinct
     sql: ${email_id}
     filters:
      email_list_name: Newsletter
      event_time_date: 8 days ago for 1 day
     hidden: true
  
   - measure: count_referrals_yesterday
     type: count_distinct
     sql: ${email_id}
     filters:
      email_list_name: Referrals
      event_time_date: 1 day ago for 1 day
     hidden: true
  
   - measure: count_referrals_last_week
     type: count_distinct
     sql: ${email_id}
     filters:
      email_list_name: Referrals
      event_time_date: 8 days ago for 1 day
     hidden: true
  
   - measure: newsletter_subscribers_wow
     label: NEWSLETTER SUBSCRIBERS WEEK ON WEEK
     type: number
     decimals: 2
     sql: 100.0 * (${count_newsletter_subscribers_yesterday} - ${count_newsletter_subscribers_last_week})/NULLIF(${count_newsletter_subscribers_last_week},0)::REAL
     format: "%0.2f%"
     html: |
          {% if value < 0 - Red' %}
          <font color="#D77070"> {{ rendered_value }} </font>
          {% elsif value > 0 - Green' %}
          <font color="#3CB371> {{ rendered_value }} </font>
          {% else %}
          <font color="#000000> {{ rendered_value }} </font>
          {% endif %}
     hidden: true
     

   - measure: referrals_wow
     label: REFERRALS WEEK ON WEEK
     type: number
     decimals: 2
     sql: 100.0 * (${count_referrals_yesterday} - ${count_referrals_last_week})/NULLIF(${count_referrals_last_week},0)::REAL
     format: "%0.2f%"
     html: |
          {% if value < 0 - Red' %}
          <font color="#D77070"> {{ rendered_value }} </font>
          {% elsif value > 0 - Green' %}
          <font color="#3CB371> {{ rendered_value }} </font>
          {% else %}
          <font color="#000000> {{ rendered_value }} </font>
          {% endif %}
     hidden: true      