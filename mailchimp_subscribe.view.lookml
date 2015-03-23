- view: mailchimp_subscribe
  derived_table:
   sql: |
        select "data.list_id" as list_id, lower("data.email") as email_address, min(root_tstamp) as time_stamp
        from atomic.com_mailchimp_subscribe_1
        group by 1,2