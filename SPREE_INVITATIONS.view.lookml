- view: spree_invitations
  derived_table:
    sql: |
       select
        aaa.email,
        aaa.credit_amount,
        aaa.currency,
        aaa.credit_amount * bbb.exchange_rate as credit_amount_gbp
        from
        (select * from daily_snapshot.spree_user_signup_awards where date(spree_timestamp) = current_date) aaa
        left join
        lookup.exchange_rates bbb
        on coalesce(date(aaa.created_at), '2014-11-23') = bbb."date"
        and aaa.currency = bbb.currency
        
    sql_trigger_value: SELECT MAX(spree_timestamp) FROM daily_snapshot.spree_invitations
    distkey: email
    sortkeys: [email]

  fields:
  - dimension: email_address
    sql: ${TABLE}.email

  - dimension: credit_amount
    type: number
    decimals: 2
    sql: ${TABLE}.credit_amount
    format: "%0.2f"
       
  - dimension: currency
    sql: ${TABLE}.currency
       
  - dimension: credit_amount_gbp
    type: number
    decimals: 2
    sql: ${TABLE}.credit_amount_gbp
    format: "£%0.2f"
       
# Measures
  
  - measure: count_all_awards
    type: count_distinct
    sql: ${email_address}

  - measure: count_awards_with_credit
    type: count_distinct
    sql: ${email_address}
    filters:
      credit_amount: '>0'
  
  - measure: sum_credit_amount
    type: sum
    sql: ${credit_amount}
    format: "%0.2f"
    
  - measure: sum_credit_amount_gbp
    type: sum
    sql: ${credit_amount_gbp}
    format: "£%0.2f"

