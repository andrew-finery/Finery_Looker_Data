- view: spree_users
  derived_table:
    sql: |
       SELECT a.spree_timestamp,
              a.id AS user_id,
              a.email AS email_address,
              a.created_at,
              a.first_name,
              a.last_name,
              a.newsletter_opt_in,
              users_yesterday.newsletter_opt_in AS newsletter_opt_in_yest,
              a.sign_in_count,
              a.last_sign_in_at,
              a.birth_date,
              COALESCE(a.permitted_referrals,'0') AS permitted_referrals,
              c.credit_amount AS signup_credit,
              c.currency AS signup_credit_currency,
              c.credit_amount_gbp AS signup_credit_gbp,
              COALESCE(b.total_credit_granted_gbp,'0') AS total_credit_granted_gbp,
              COALESCE(b.total_credit_used_gbp,'0') AS total_credit_used_gbp,
              COALESCE(b.current_credit_gbp,'0') AS current_credit_gbp,
              COALESCE(d.referrals_sent,'0') AS referrals_sent,
              e.code AS invite_code_used,
              e.invitation_id AS invitation_id,
              e.sent_by_id AS invitation_sent_by_user_id,
              roles.name AS role
       FROM (SELECT *
             FROM daily_snapshot.spree_users
             WHERE spree_timestamp = (SELECT MAX(spree_timestamp) FROM daily_snapshot.spree_users)) a
         LEFT JOIN (SELECT aaa.user_id,
                           SUM(aaa.amount*bbb.exchange_rate) AS total_credit_granted_gbp,
                           SUM(aaa.amount_used*bbb.exchange_rate) AS total_credit_used_gbp,
                           SUM(aaa.amount*bbb.exchange_rate) - SUM(aaa.amount_used*bbb.exchange_rate) AS current_credit_gbp
                    FROM (SELECT *
                          FROM daily_snapshot.spree_store_credits
                          WHERE spree_timestamp = (SELECT MAX(spree_timestamp)
                                                   FROM daily_snapshot.spree_store_credits)) aaa
                      LEFT JOIN lookup.exchange_rates bbb
                             ON DATE (aaa.created_at) = bbb. "date"
                            AND aaa.currency = bbb.currency
                    GROUP BY 1) b ON a.id = b.user_id
         LEFT JOIN (SELECT aaa.email,
                           aaa.credit_amount,
                           aaa.currency,
                           aaa.credit_amount*bbb.exchange_rate AS credit_amount_gbp
                    FROM (SELECT *
                          FROM daily_snapshot.spree_user_signup_awards
                          WHERE spree_timestamp = (SELECT MAX(spree_timestamp)
                                                   FROM daily_snapshot.spree_user_signup_awards)
                          AND   created_at IS NOT NULL) aaa
                      LEFT JOIN lookup.exchange_rates bbb
                             ON DATE (aaa.created_at) = bbb. "date"
                            AND aaa.currency = bbb.currency) c ON lower (a.email) = lower (c.email)
         LEFT JOIN (SELECT sent_by_id AS user_id,
                           COUNT(*) AS referrals_sent
                    FROM daily_snapshot.spree_invitations
                    WHERE spree_timestamp = (SELECT MAX(spree_timestamp)
                                             FROM daily_snapshot.spree_invitations)
                    AND   sent_by_id IS NOT NULL
                    GROUP BY 1) d ON a.id = d.user_id
         LEFT JOIN (SELECT invitations_users.user_id,
                           invitations.id AS invitation_id,
                           invitations.code,
                           invitations.sent_by_id
                    FROM (SELECT user_id,
                                 invitation_id
                          FROM daily_snapshot.spree_invitations_users
                           WHERE spree_timestamp = (SELECT MAX(spree_timestamp)
                                                   FROM daily_snapshot.spree_invitations_users)) invitations_users
                      LEFT JOIN (SELECT *
                                 FROM daily_snapshot.spree_invitations
                                 WHERE spree_timestamp = (SELECT MAX(spree_timestamp)
                                                          FROM daily_snapshot.spree_invitations)) invitations ON invitations_users.invitation_id = invitations.id) e ON e.user_id = a.id
         LEFT JOIN (SELECT *
                    FROM daily_snapshot.spree_roles_users
                    WHERE spree_timestamp = (SELECT MAX(spree_timestamp)
                                             FROM daily_snapshot.spree_roles_users)) roles_users ON a.id = roles_users.user_id
         LEFT JOIN (SELECT *
                    FROM daily_snapshot.spree_roles
                    WHERE spree_timestamp = (SELECT MAX(spree_timestamp) FROM daily_snapshot.spree_roles)) roles ON roles_users.role_id = roles.id
         LEFT JOIN (SELECT id,
                           MAX(newsletter_opt_in) AS newsletter_opt_in
                    FROM daily_snapshot.spree_users
                    WHERE DATE (spree_timestamp) = CURRENT_DATE- 1
                    GROUP BY 1) users_yesterday ON users_yesterday.id = a.id

    sql_trigger_value: SELECT MAX(spree_timestamp) FROM daily_snapshot.spree_users
    distkey: user_id
    sortkeys: [user_id]


  fields:

##############################################################################################################################################################################
#################################################################### DIMENSIONS ##############################################################################################
##############################################################################################################################################################################

  - dimension: email_address
    sql: ${TABLE}.email_address
  
  - dimension: customer_id
    type: int
    sql: ${TABLE}.user_id
    
  - dimension_group: account_created_at
    type: time
    timeframes: [time, date, hod, hour, week, month]
    sql: ${TABLE}.created_at
    
  - dimension: first_name
    sql: ${TABLE}.first_name
    
  - dimension: last_name
    sql: ${TABLE}.last_name

  - dimension: role
    sql: ${TABLE}.role
  
  - dimension: newsletter_opt_in
    type: yesno
    sql: ${TABLE}.newsletter_opt_in = 1

  - dimension: newsletter_opt_in_yesterday
    type: yesno
    sql: ${TABLE}.newsletter_opt_in_yest = 1
    
  - dimension: sign_in_count
    sql: ${TABLE}.sign_in_count
  
  - dimension_group: birth_date
    type: time
    timeframes: [date, month, year]
    sql: ${TABLE}.birth_date
  
  - dimension_group: last_sign_in_at
    type: time
    timeframes: [time, date, hod, hour, week, month]
    sql: ${TABLE}.last_sign_in_at

  - dimension: used_all_referrals
    type: yesno
    sql: ${TABLE}.permitted_referrals - ${TABLE}.referrals_sent = 0

  - dimension: signup_credit_currency
    sql: ${TABLE}.signup_credit_currency

##############################################################################################################################################################################
#################################################################### MEASURES ################################################################################################
##############################################################################################################################################################################
  
  - measure: count_users
    type: count_distinct
    sql: ${customer_id}
  
  - measure: count_newsletter_subscribers
    type: count_distinct
    sql: ${customer_id}
    filters:
      newsletter_opt_in: yes
  
  - measure: sum_referrals_sent
    type: sum
    sql: ${TABLE}.referrals_sent
  
  - measure: sum_referrals_permitted
    type: sum
    sql: ${TABLE}.permitted_referrals
    
  - measure: sum_referrals_left
    type: sum
    sql: ${TABLE}.permitted_referrals - ${TABLE}.referrals_sent
  
  - measure: percentage_referrals_sent
    type: number
    decimals: 2
    sql: 100.0 * ${sum_referrals_sent}/NULLIF(${sum_referrals_permitted},0)::REAL
    format: "%0.2f%"
  
  - measure: sum_signup_credit_granted
    type: sum
    sql: ${TABLE}.signup_credit
    format: "%0.2f"
  
  - measure: sum_signup_credit_granted_gbp
    type: sum
    sql: ${TABLE}.signup_credit_gbp
    format: "£%0.2f"
  
  - measure: sum_total_credit_granted_gbp
    type: sum
    sql: ${TABLE}.total_credit_granted_gbp
    format: "£%0.2f"
    
  - measure: sum_total_credit_used_gbp
    type: sum
    sql: ${TABLE}.total_credit_used_gbp
    format: "£%0.2f"
    
  - measure: sum_current_live_credit_gbp
    type: sum
    sql: ${TABLE}.current_credit_gbp
    format: "£%0.2f"
