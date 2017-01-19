- view: adwords_campaigns
  derived_table:
     sql: |
           select distinct accountdescriptivename, campaign_id, campaign from adwords_data.criteria_performance
           
           
  # # You can specify the table name if it's different from the view name:
  # sql_table_name: my_schema_name.adwords_campaigns
  #
  # # Define your dimensions and measures here, like this:
  fields:
  
  - dimension: accountdescriptivename
    description: "account"
    type: string
    sql: ${TABLE}.accountdescriptivename
    
  - dimension: campaign
    description: "campaign name"
    type: string
    sql: ${TABLE}.campaign
    
  - dimension: campaign_id
    description: "campaign id"
    type: string
    sql: ${TABLE}.campaign_id
    
  - dimension: adwords_audience_segment
    sql: |
            case when ${TABLE}.accountdescriptivename like '%acquisition%' then 'Acquisition'
            when ${TABLE}.accountdescriptivename like '%retarget%' then 'Custom Audience'
            when ${TABLE}.accountdescriptivename like '%buyers%' then 'Buyers' end
            
  - dimension: adwords_Brand_vs_nonBrand
    sql: |
            case when ${TABLE}.campaign like '%brand%' then 'Brand'
            else 'Non Brand' end
            
  
  #
  #   - dimension_group: created
  #     description: "Transaction created date"
  #     type: time
  #     timeframes: [date, week, month, year]
  #     sql: ${TABLE}.created_at
  #
  #   - measure: count
  #     description: "Count of orders"
  #     type: count

# - view: adwords_campaigns
#   # Or, you could make this view a derived table, like this:
#   derived_table:
#     sql: |
#       SELECT
#         user_id as user_id
#         , COUNT(*) as lifetime_orders
#         , MAX(orders.created_at) as most_recent_purchase_at
#       FROM orders
#       GROUP BY user_id
#
#   # Define your dimensions and measures here, like this:
#   fields:
#     - dimension: user_id
#       description: "Unique ID for each user that has ordered"
#       type: number
#       sql: ${TABLE}.user_id
#
#     - dimension: lifetime_orders
#       description: "The total number of orders for each user"
#       type: number
#       sql: ${TABLE}.lifetime_orders
#
#     - dimension_group: most_recent_purchase
#       description: "The date when each user last ordered"
#       type: time
#       timeframes: [date, week, month, year]
#       sql: ${TABLE}.most_recent_purchase_at
#
#     - measure: total_lifetime_orders
#       description: "Use this for counting lifetime orders across many users"
#       type: sum
#       sql: ${lifetime_orders}
