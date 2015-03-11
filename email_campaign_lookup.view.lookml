- view: email_campaign_lookup
  derived_table:
    sql: |
          SELECT "data.id" AS email_id,
                 MAX("data.subject") AS email_subject
          FROM atomic.com_mailchimp_campaign_sending_status_1
          GROUP BY 1

    sql_trigger_value: SELECT MAX(root_tstamp) FROM atomic.com_mailchimp_campaign_sending_status_1
    distkey: email_id
    sortkeys: [email_id]


  fields:

  - dimension: email_subject
    label: EMAIL
    sql: ${TABLE}.email_subject
