- view: mandrill_message_sent
  sql_table_name: atomic.com_mandrill_message_sent_1
  fields:

  - dimension: event_id
    sql: ${TABLE}.root_id
    hidden: true

  - dimension_group: email_sent
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.root_tstamp

  - dimension: email_id
    sql: ${TABLE}."msg._id"

  - dimension: email_sent_to
    sql: ${TABLE}."msg.email"

  - dimension: email_sent_from
    sql: ${TABLE}."msg.sender"

  - dimension: email_state
    sql: ${TABLE}."msg.state"

  - dimension: email_subject
    sql: ${TABLE}."msg.subject"
  
  - dimension: email_group
    sql_case:
      Registration: ${email_subject} in ('Welcome to Finery!','Thanks for joining us!')
      Order Confirmation: ${email_subject} like '%Hooray! Your Finery order confirmation - %'
      Order Shipped: ${email_subject} like '%ve shipped your order'
      Referral: ${email_subject} like 'Your exclusive invitation from %'
      Items Refunded: ${email_subject} like 'Your returned items were refunded - %' or ${email_subject} like '%Reimbursement Notification%'
      Return Being Processed: ${email_subject} like 'Your return is being processed - %' or ${email_subject} like 'Your Return is being processed - %'
      Abandoned Cart: ${email_subject} = 'Forget something?'
      Password Reset: ${email_subject} = 'Reset your Finery Password'
      Fine Soceity: ${email_subject} = 'Welcome to the club!'
      Special Gift: ${email_subject} = 'A special gift from us to you'
      Free Gift Qualification: ${email_subject} = 'You give, we give.'
      Finished Uploading Returns: ${email_subject} = 'Finished uploading returns.'
      A friend  just earned you £10: ${email_subject} like '%just earned you%'
      Cancelled Order: ${email_subject} like 'Your order has been cancelled - %'
      else: Other

  - measure: count_messages_sent
    type: count_distinct
    sql: ${email_id}
    
  - measure: open_rate
    type: number
    sql: ${mandrill_message_opened.count_unique_opens}/NULLIF(${count_messages_sent},0)::REAL
    value_format: '#0.00%'

  - measure: click_rate
    type: number
    sql: ${mandrill_message_clicked.count_unique_clicks}/NULLIF(${count_messages_sent},0)::REAL
    value_format: '#0.00%'

  - measure: click_through_open_rate
    type: number
    sql: ${mandrill_message_clicked.count_unique_clicks}/NULLIF(${mandrill_message_opened.count_unique_opens},0)::REAL
    value_format: '#0.00%'
