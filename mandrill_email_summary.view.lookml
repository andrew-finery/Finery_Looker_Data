- view: mandrill_email_summary
  sql_table_name: mandrill_data.email_summary
  fields:

  - dimension_group: email_sent
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.message_sent_timestamp

  - dimension: email_id
    sql: ${TABLE}.message_id

  - dimension: email_sent_to
    sql: ${TABLE}.email_recipient

  - dimension: email_sent_from
    sql: ${TABLE}.email_sender

  - dimension: email_subject
    sql: ${TABLE}.email_subject

  - dimension: opens
    sql: ${TABLE}.opens
    type: number
    
  - dimension: clicks
    sql: ${TABLE}.clicks
    type: number
    
  - dimension: bounces
    sql: ${TABLE}.bounces
    type: number
    
  - dimension: soft_bounces
    sql: ${TABLE}.soft_bounces
    type: number
    
  - dimension: delays
    sql: ${TABLE}.delays
    type: number
    
  - dimension: rejections
    sql: ${TABLE}.rejections
    type: number
    
  - dimension: unsubscribes
    sql: ${TABLE}.unsubscribes
    type: number
    
  - dimension: marked_as_spam
    sql: ${TABLE}.marked_as_spam
    type: number

  - dimension: email_group
    sql_case:
      Registration: ${email_subject} in ('Welcome to Finery!','Thanks for joining us!')
      Order Confirmation: ${email_subject} like '%Hooray! Your Finery order confirmation - %'
      Order Shipped: ${email_subject} like '%ve shipped your order'
      Referral: ${email_subject} like 'Your exclusive invitation from %'
      Items Refunded: ${email_subject} like 'Your returned items were refunded - %' or ${email_subject} like '%Reimbursement Notification%'
      Return Being Processed: ${email_subject} like 'Your return is being processed - %' or ${email_subject} like 'Your Return is being processed - %'
      Abandoned Cart: ${email_subject} like '%Forget something?%' or ${email_subject} like '%We have saved your items%'  or ${email_subject} like '%We saved your items%' or ${email_subject} like '%Did you drop something?%' or ${email_subject} like '%We Saved Your Items%' or ${email_subject} like '%Did you drop something?%'
      Password Reset: ${email_subject} = 'Reset your Finery Password'
      Fine Soceity: ${email_subject} = 'Welcome to the club!'
      Special Gift: ${email_subject} = 'A special gift from us to you'
      Free Gift Qualification: ${email_subject} = 'You give, we give.'
      Finished Uploading Returns: ${email_subject} = 'Finished uploading returns.'
      A friend  just earned you £10: ${email_subject} like '%just earned you%'
      Cancelled Order: ${email_subject} like 'Your order has been cancelled - %'
      else: Other

### measures

  - measure: count_messages_sent
    type: count_distinct
    sql: ${email_id}

  - measure: count_messages_opened
    type: count_distinct
    sql: ${email_id}
    filters:
      opens: '>0'

  - measure: count_messages_clicked
    type: count_distinct
    sql: ${email_id}
    filters:
      clicks: '>0'
      
  - measure: open_rate
    type: number
    sql: ${count_messages_opened}/NULLIF(${count_messages_sent},0)::REAL
    value_format: '#0.00%'

  - measure: click_rate
    type: number
    sql: ${count_messages_clicked}/NULLIF(${count_messages_sent},0)::REAL
    value_format: '#0.00%'

  - measure: click_through_open_rate
    type: number
    sql: ${count_messages_clicked}/NULLIF(${count_messages_opened},0)::REAL
    value_format: '#0.00%'