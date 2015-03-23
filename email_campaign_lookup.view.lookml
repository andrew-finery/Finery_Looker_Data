- view: email_campaign_lookup
  derived_table:
    sql: |
          select email_id, list_id, email_subject from          
          (SELECT "data.id" AS email_id, "data.list_id" as list_id,
                 last_value("data.subject") over (partition by "data.id" order by root_tstamp asc rows between unbounded preceding and unbounded following) AS email_subject
          FROM atomic.com_mailchimp_campaign_sending_status_1)
          GROUP BY 1,2,3

  fields:

  - dimension: email_subject
    label: EMAIL
    sql: ${TABLE}.email_subject
    hidden: true
  
  - dimension: email_description
    sql_case:
      Newsletter Subscription Email: ${TABLE}.email_id = '99f17ae0cc'
      Newsletter WC Reminder 1: ${TABLE}.email_id = 'a60618fcc7'
      Newsletter WC Reminder 1: ${TABLE}.email_id = 'd399f1d826'
      Newsletter WC Reminder 1: ${TABLE}.email_id = 'f92381d88b'
      Create Account WC Reminder 1: ${TABLE}.email_id = '2ee520a42d'
      Create Account WC Reminder 2: ${TABLE}.email_id = 'b4a7752346'
      Create Account WC Reminder 3: ${TABLE}.email_id = 'd2d46d70e0'
      Referral Email: ${TABLE}.email_id = 'f297608864'
      Referral Reminder 1: ${TABLE}.email_id = '47bf57307c'
      Referral Reminder 2: ${TABLE}.email_id = 'a82d3c5906'
      Referral Reminder 3: ${TABLE}.email_id = '6cdfa5a6df'
      Weekly Newsletter: ${TABLE}.list_id = '179a8621fb'
      else: Other
    hidden: true
  
  - dimension: email_list
    sql_case:
      Newsletter Subscribers: ${TABLE}.list_id = '179a8621fb'
      Newsletter Welcome Chain: ${TABLE}.list_id = '292b2aee8e'
      Create Account Welcome Chain: ${TABLE}.list_id = '4666d51b64'
      Referral Welcome Chain: ${TABLE}.list_id = 'de06e9bf29'
      else: Other
    hidden: true

#d399f1d826 292b2aee8e  Don’t forget your discount is waiting 27
#a60618fcc7 292b2aee8e  Nice to meet you  26
#f92381d88b 292b2aee8e  Use it, don’t lose it 26