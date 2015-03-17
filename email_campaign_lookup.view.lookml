- view: email_campaign_lookup
  derived_table:
    sql: |
          SELECT "data.id" AS email_id,
                 MAX("data.subject") AS email_subject
          FROM atomic.com_mailchimp_campaign_sending_status_1
          GROUP BY 1

  fields:

  - dimension: email_subject
    label: EMAIL
    sql: ${TABLE}.email_subject

