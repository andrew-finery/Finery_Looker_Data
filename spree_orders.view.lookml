- view: spree_orders
  derived_table:
    sql: select * from sales.orders where reason_to_strip_out is null

  fields:
    #################################################################################################################################################################################
  ####################################################### DIMENSIONS ##############################################################################################################
#################################################################################################################################################################################

############################ BASIC ORDER DIMENSIONS #######################################################

  - dimension: order_id
    primary_key: true
    type: int
    sql: ${TABLE}.order_id
    hidden: true

  - dimension_group: completed
    label: Order
    type: time
    timeframes: [time, date, hour_of_day, week, month, time_of_day, day_of_week_index, day_of_week, day_of_month]
    sql: ${TABLE}.completed_at

  - dimension: item_count
    label: Items in Order
    type: int
    sql: ${TABLE}.item_count

  - dimension: order_code
    label: Order Code
    sql: ${TABLE}.order_code

  - dimension: primary_payment_method
    label: Primary Payment Method
    sql: ${TABLE}.primary_payment_method

  - dimension: state
    sql: ${TABLE}.state

  - dimension: customer_id
    type: int
    sql: ${TABLE}.customer_id
    hidden: true
    
  - dimension: blended_email
    sql: ${TABLE}.blended_email
    hidden: true
    
  - dimension: order_sequence_number
    sql: cast(${TABLE}.order_sequence_number as integer)
    hidden: true
    
  - dimension: order_sequence_tier
    type: string
    sql: case when ${TABLE}.order_sequence_number in (1,2,3,4) then cast(${order_sequence_number} as varchar) else '5+' end

  - dimension: first_order_flag
    type: yesno
    sql: ${order_sequence_tier} = 1

  - dimension: discount_flag
    type: yesno
    sql: ${TABLE}.adjustment_total <> 0

  - dimension: latest_order_flag
    type: yesno
    sql: ${TABLE}.order_id = ${TABLE}.latest_order_id

  - dimension: multiple_size_flag
    type: yesno
    sql: ${TABLE}.number_of_skus != ${TABLE}.number_of_products

  - dimension: order_email
    label: Email Address
    sql: ${TABLE}.email
  
  - dimension: in_store_flag
    label: In Store Flag
    sql_case:
      In-Store: ${TABLE}.in_store_flag = 1
      else: Online

# Shipping Dimensions
  
  - dimension: ship_address_id
    sql: ${TABLE}.ship_address_id
    hidden: true
  
  - dimension: shipping_method
    label: Delivery Method
    sql: ${TABLE}.shipping_method

  - dimension: shipment_number
    label: Shipment Number
    sql: ${TABLE}.shipment_number

  - dimension: tracking_number
    label: Tracking Number
    type: string
    sql: ${TABLE}.tracking_number || 'a'

  - dimension: tracking_link
    label: Hermes Tracking Link
    type: string
    sql: ${TABLE}.tracking_number
    html: |
        <a href="http://www.hermes-europe.co.uk/customerparceltrackingservice/trackingDetailsHermes.jsp?barcode={{value}}">{{value}}</a>

  - dimension_group: shipped_at
    label: Shipped at
    type: time
    timeframes: [date, day_of_week_index]
    sql: ${TABLE}.shipped_at_date
  
  - dimension: delivery_company
    label: Delivery Company
    sql: ${TABLE}.consignee
  
  - dimension: delivery_type
    label: Delivery Type
    sql: ${TABLE}.delivery_type
  
  - dimension: tracking_info_available
    label: Tracking Info Available
    type: yesno
    sql: ${tracking_number} <> 'a'

  - dimension_group: latest_event_time
    label: Latest Event
    type: time
    timeframes: [time, date]
    sql: ${TABLE}.latest_event_time
       
  - dimension: latest_delivery_event
    label: Latest Event Description
    sql: ${TABLE}.current_status

# delivery tracking event times

  - dimension_group: first_attempt_time
    label: First Delivery Attempt
    type: time
    timeframes: [time, date]
    sql: ${TABLE}.first_attempt_time
    hidden: true
    
  - dimension_group: delivery_confirmed_time
    type: time
    timeframes: [time, date]
    sql: ${TABLE}.delivery_confirmed_time
    hidden: true
    
  - dimension_group: return_confirmed_time
    type: time
    timeframes: [time, date]
    sql: ${TABLE}.return_confirmed_time
    hidden: true
    
  - dimension: hub_received_date
    type: date
    sql: ${TABLE}.hub_received_date
    hidden: true
    
  - dimension: misrouted_date
    type: date
    sql: ${TABLE}.misrouted_date
    hidden: true
    
  - dimension: missort_date
    type: date
    sql: ${TABLE}.missort_date    
    hidden: true
    
  - dimension: depot_received_date
    type: date
    sql: ${TABLE}.depot_received_date    
    hidden: true
    
  - dimension: missing_pre_advice_date
    type: date
    sql: ${TABLE}.missing_pre_advice_date    
    hidden: true
    
  - dimension: more_info_required_date
    type: date
    sql: ${TABLE}.more_info_required_date      
    hidden: true
    
  - dimension: out_for_delivery_date
    type: date
    sql: ${TABLE}.out_for_delivery_date      
    hidden: true
    
  - dimension: courier_received_date
    type: date
    sql: ${TABLE}.courier_received_date        
    hidden: true
    
  - dimension: carried_forward_date
    type: date
    sql: ${TABLE}.carried_forward_date 
    hidden: true
    
  - dimension: not_delivered_date
    type: date
    sql: date(${TABLE}.not_delivered_tstamp)
    hidden: true
    
  - dimension: refused_date
    type: date
    sql: date(${TABLE}.refused_tstamp)
    hidden: true
    
  - dimension: returned_to_sender_date
    type: date
    sql: date(${TABLE}.returned_to_sender_tstamp)
    hidden: true
    
  - dimension: delay_date
    type: date
    sql: date(${TABLE}.delay_tstamp)    
    hidden: true    

  - dimension: delivered_flag
    label: Delivered Flag
    type: yesno
    sql: |
        ${delivery_confirmed_time_time} is not null
        or ${TABLE}.tracking_number in
        ('7817394680536081',
        '3910172680538186',
        '1149738680537787',
        '6801279680535086',
        '6820375680535387',
        '6004675499',
        '6004676013',
        '1381987680535888',
        '1181887680535289')
        or ${TABLE}.order_code in
        ('R734499812',
        'R943850231',
        'R616072248',
        'R759284769',
        'R164515611',
        'R633214240',
        'R864835650',
        'R644319374',
        'R870765040',
        'R408945061')
  # NB. Manually entered tracking codes. These are parcels that Hermes website has lost track of but we have confirmed as delivered

  - dimension: late_delivery_reason
    sql: |
        case
        
        when ${delivery_company} = 'DHL' then 'DHL Delivery'
        
        when ${latest_event_time_date} is null and ${tracking_number} = 'a' then 'No Tracking Info - Warehouse'
        
        when (${expected_delivery_date} >= current_date or ${expected_delivery_date_hermes} >= current_date) and ${delivery_confirmed_time_time} is null then 'Parcel to be Delivered'
        
        when ${latest_event_time_date} is null then 'No Tracking Info - Hermes'
        
        when ${delivery_confirmed_time_time} is null and ${return_confirmed_time_time} is null and ${expected_delivery_date} < current_date - 14 then 'Parcel Lost by Hermes'
        
        when ${first_attempt_time_date} is null then 'Parcel Currently Late - Not Delivered'
        
        when ${first_attempt_time_date} > ${expected_delivery_date_hermes} and ${first_attempt_time_date} > ${expected_delivery_date} and ${first_attempt_time_date} is not null
        and ${misrouted_date} is not null then 'Misrouted to Incorrect Depot'
        
        when ${first_attempt_time_date} > ${expected_delivery_date_hermes} and ${first_attempt_time_date} > ${expected_delivery_date} and ${first_attempt_time_date} is not null
        and ${missort_date} is not null then 'Missort to Incorrect Courier'
        
        when ${first_attempt_time_date} > ${expected_delivery_date_hermes} and ${first_attempt_time_date} > ${expected_delivery_date} and ${first_attempt_time_date} is not null
        and ${more_info_required_date} is not null then 'More Info Required'
        
        when ${first_attempt_time_date} > ${expected_delivery_date_hermes} and ${first_attempt_time_date} > ${expected_delivery_date} and ${first_attempt_time_date} is not null
        and ${carried_forward_date} is not null then 'Carried Forward'
        
        when ${first_attempt_time_date} > ${expected_delivery_date_hermes} and ${first_attempt_time_date} > ${expected_delivery_date} and ${first_attempt_time_date} is not null
        and ${delay_date} is not null then 'Hermes Delay'
        
        when ${first_attempt_time_date} > ${expected_delivery_date_hermes} and ${first_attempt_time_date} > ${expected_delivery_date} and ${first_attempt_time_date} is not null
        and ${hub_received_date} > ${completed_date} + 1 then 'Late to Hub'
        
        when ${first_attempt_time_date} > ${expected_delivery_date_hermes} and ${first_attempt_time_date} > ${expected_delivery_date} and ${first_attempt_time_date} is not null
        and ${depot_received_date} > ${completed_date} + 2 then 'Late to Depot'
        
        when ${first_attempt_time_date} > ${expected_delivery_date_hermes} and ${first_attempt_time_date} > ${expected_delivery_date} and ${first_attempt_time_date} is not null
        and ${out_for_delivery_date} > ${expected_delivery_date_hermes} and ${out_for_delivery_date} > ${expected_delivery_date} then 'Delay at Depot'
        
        when ${first_attempt_time_date} > ${expected_delivery_date_hermes} and ${first_attempt_time_date} > ${expected_delivery_date} and ${first_attempt_time_date} is not null
        and ${courier_received_date} > ${expected_delivery_date_hermes} and ${courier_received_date} > ${expected_delivery_date} then 'Delay in Courier Receiving Package'
        
        when ${first_attempt_time_date} > ${expected_delivery_date_hermes} and ${first_attempt_time_date} > ${expected_delivery_date} and ${first_attempt_time_date} is not null
        and ${delay_date} is not null then 'Missing Pre-Advice'
        
        when ${first_attempt_time_date} > ${expected_delivery_date_hermes} and ${first_attempt_time_date} > ${expected_delivery_date} and ${first_attempt_time_date} is not null
        then 'Late - Other Reason'
        
        else 'Delivered On Time' end

  - dimension: returned_flag
    type: yesno
    sql: ${return_confirmed_time_time} is not null  
    
  - dimension: expected_delivery_date_hermes
    type: date
    sql: |
        case
        when ${shipped_at_date} is null then null -- if there is no 'shipped at date', hermes did not recieve teh parcel therefore we can't assign a date we expect the to deliver it by
        --- 48 HOUR DELIVERY CASES
        when ${delivery_type} = '48 Hour Delivery' and ${shipped_at_day_of_week_index} in (0,1,2,3) then ${shipped_at_date} + 2                                       -- 48h Orders Shipped Mon-Thu arrive 2 days later
        when ${delivery_type} = '48 Hour Delivery' and ${shipped_at_day_of_week_index} in (4,5,6) then ${shipped_at_date} + 3                                         -- 48h Order  Shipped Fri-Sun arrive 3 days later
        --- NEXT DAY DELIVERY CASES
        when ${delivery_type} = 'Next Day Delivery' and ${shipped_at_day_of_week_index} in (0,1,2,3,4) then ${shipped_at_date} + 1                                    -- 24h Orders Shipped Mon-Fri arrive 1 day later
        when ${delivery_type} = 'Next Day Delivery' and ${shipped_at_day_of_week_index} in (5,6) then ${shipped_at_date} + 2                                          -- 24h Order  Shipped Sat-Sun arrive 2 days later
        --- SUNDAY DELIVERY CASES
        when ${delivery_type} = 'Sunday Delivery' and ${shipped_at_day_of_week_index} = 0 then ${shipped_at_date} + 6                                                   -- Sunday Delivery Orders Shipped on Monday delivered this Sunday
        when ${delivery_type} = 'Sunday Delivery' and ${shipped_at_day_of_week_index} = 1 then ${shipped_at_date} + 5                                                   -- Sunday Delivery Orders Shipped on Tuesday delivered this Sunday
        when ${delivery_type} = 'Sunday Delivery' and ${shipped_at_day_of_week_index} = 2 then ${shipped_at_date} + 4                                                   -- Sunday Delivery Orders Shipped on Wednesday delivered this Sunday
        when ${delivery_type} = 'Sunday Delivery' and ${shipped_at_day_of_week_index} = 3 then ${shipped_at_date} + 3                                                   -- Sunday Delivery Orders Shipped on Thursday delivered this Sunday
        when ${delivery_type} = 'Sunday Delivery' and ${shipped_at_day_of_week_index} = 4 then ${shipped_at_date} + 2                                                   -- Sunday Delivery Orders Shipped on Friday before 4 delivered this Sunday
        when ${delivery_type} = 'Sunday Delivery' and ${shipped_at_day_of_week_index} = 5 then ${shipped_at_date} + 8                                                   -- Sunday Delivery Orders Shipped on Saturday delivered next Sunday
        when ${delivery_type} = 'Sunday Delivery' and ${shipped_at_day_of_week_index} = 6 then ${shipped_at_date} + 7                                                   -- Sunday Delivery Orders Shipped on Sunday delivered next Sunday
        --- OTHER DELIVERIES
        else ${completed_date} + 7                                                                                                                      -- Assume all other deliveries DHL and get there within a week of order
        end
  
  - dimension: expected_delivery_date
    label: Expected Delivery
    type: date
    sql: |
        case
        --- 48 HOUR DELIVERY CASES
        when ${delivery_type} = '48 Hour Delivery' and ${completed_day_of_week_index} = 6 then ${completed_date} + 3                                                  -- 48h Orders on Sunday delivered on Wednesday
        when ${delivery_type} = '48 Hour Delivery' and ${completed_day_of_week_index} between 0 and 2 and ${completed_time_of_day} < '16:00' then ${completed_date} + 2       -- 48h Orders Mon-Wed before 4 delivered 2 days later
        when ${delivery_type} = '48 Hour Delivery' and ${completed_day_of_week_index} between 0 and 2 and ${completed_time_of_day} >= '16:00' then ${completed_date} + 3      -- 48h Orders Mon-Wed after 4 delivered 3 days later
        when ${delivery_type} = '48 Hour Delivery' and ${completed_day_of_week_index} = 3 and ${completed_time_of_day} < '16:00' then ${completed_date} + 2                   -- 48h Order on Thursday before 4 delivered on Saturday
        when ${delivery_type} = '48 Hour Delivery' and ${completed_day_of_week_index} = 3 and ${completed_time_of_day} >= '16:00' then ${completed_date} + 4                  -- 48h Orders on Thursday after 4 delivered Monday
        when ${delivery_type} = '48 Hour Delivery' and ${completed_day_of_week_index} = 4 and ${completed_time_of_day} < '16:00' then ${completed_date} + 3                   -- 48h Orders on Friday before 4 delivered Monday
        when ${delivery_type} = '48 Hour Delivery' and ${completed_day_of_week_index} = 4 and ${completed_time_of_day} >= '16:00' then ${completed_date} + 4                  -- 48h Orders on Friday after 4 delivered Tuesday
        when ${delivery_type} = '48 Hour Delivery' and ${completed_day_of_week_index} = 5 and ${completed_time_of_day} < '17:00' then ${completed_date} + 3                   -- 48h Orders on Saturday before 5 delivered Tuesday
        when ${delivery_type} = '48 Hour Delivery' and ${completed_day_of_week_index} = 5 and ${completed_time_of_day} >= '17:00' then ${completed_date} + 4                  -- 48h Orders on Saturday after 5 delivered Wednesday
        --- NEXT DAY DELIVERY CASES
        when ${delivery_type} = 'Next Day Delivery' and ${completed_day_of_week_index} = 6 then ${completed_date} + 2                                                 -- 24h Orders on Sunday delivered on Tuesday
        when ${delivery_type} = 'Next Day Delivery' and ${completed_day_of_week_index} between 0 and 3 and ${completed_time_of_day} < '16:00' then ${completed_date} + 1      -- 24h Orders Mon-Thu before 4 delivered the next day
        when ${delivery_type} = 'Next Day Delivery' and ${completed_day_of_week_index} between 0 and 3 and ${completed_time_of_day} >= '16:00' then ${completed_date} + 2     -- 24h Orders Mon-Thu after 4 delivered 2 days later
        when ${delivery_type} = 'Next Day Delivery' and ${completed_day_of_week_index} = 4 and ${completed_time_of_day} < '16:00' then ${completed_date} + 1                  -- 24h Orders Fri before 4 delivered Saturday                   
        when ${delivery_type} = 'Next Day Delivery' and ${completed_day_of_week_index} = 4 and ${completed_time_of_day} >= '16:00' then ${completed_date} + 3                 -- 24h Orders Fri after 4 delivered Monday
        when ${delivery_type} = 'Next Day Delivery' and ${completed_day_of_week_index} = 5 and ${completed_time_of_day} < '17:00' then ${completed_date} + 2                  -- 24h Orders on Saturday before 5 delivered Monday
        when ${delivery_type} = 'Next Day Delivery' and ${completed_day_of_week_index} = 5 and ${completed_time_of_day} >= '17:00' then ${completed_date} + 3                 -- 24h Orders on Saturday after 5 delivered Tuesday
        --- SUNDAY DELIVERY CASES
        when ${delivery_type} = 'Sunday Delivery' and ${completed_day_of_week_index} = 0 then ${completed_date} + 6                                                   -- Sunday Delivery Orders on Monday delivered this Sunday
        when ${delivery_type} = 'Sunday Delivery' and ${completed_day_of_week_index} = 1 then ${completed_date} + 5                                                   -- Sunday Delivery Orders on Tuesday delivered this Sunday
        when ${delivery_type} = 'Sunday Delivery' and ${completed_day_of_week_index} = 2 then ${completed_date} + 4                                                   -- Sunday Delivery Orders on Wednesday delivered this Sunday
        when ${delivery_type} = 'Sunday Delivery' and ${completed_day_of_week_index} = 3 then ${completed_date} + 3                                                   -- Sunday Delivery Orders on Thursday delivered this Sunday
        when ${delivery_type} = 'Sunday Delivery' and ${completed_day_of_week_index} = 4 and ${completed_time_of_day} < '16:00' then ${completed_date} + 2                    -- Sunday Delivery Orders on Friday before 4 delivered this Sunday
        when ${delivery_type} = 'Sunday Delivery' and ${completed_day_of_week_index} = 4 and ${completed_time_of_day} >= '16:00' then ${completed_date} + 9                   -- Sunday Delivery Orders on Friday after 4 delivered next Sunday
        when ${delivery_type} = 'Sunday Delivery' and ${completed_day_of_week_index} = 5 then ${completed_date} + 8                                                   -- Sunday Delivery Orders on Saturday delivered next Sunday
        when ${delivery_type} = 'Sunday Delivery' and ${completed_day_of_week_index} = 6 then ${completed_date} + 7                                                   -- Sunday Delivery Orders on Sunday delivered next Sunday
        --- OTHER DELIVERIES
        else ${completed_date} + 7                                                                                                                      -- Assume all other deliveries DHL and get there within a week of order
        end

    

##################################### REVENUE DIMENSIONS ##########################################################

  - dimension: currency
    sql: ${TABLE}.currency
  
  - dimension: exchange_rate
    sql: ${TABLE}.exchange_rate
    hidden: true

  - dimension: tax_rate
    sql: ${TABLE}.tax_rate
    hidden: true
    
  - dimension: payment_total
    type: number
    decimals: 2
    sql: ${TABLE}.order_total
    value_format: '#,##0.00'
    hidden: true
    
  - dimension: item_total
    type: number
    decimals: 2
    sql: ${TABLE}.item_total
    value_format: '#,##0.00'
    
  - dimension: shipping_total
    type: number
    decimals: 2
    sql: ${TABLE}.shipment_total
    value_format: '#,##0.00'
    hidden: true
    
  - dimension: discount
    type: number
    decimals: 2
    sql: ${TABLE}.adjustment_total * (-1)
    value_format: '#,##0.00'
    hidden: true
    
  - dimension: store_credit_used
    type: number
    sql: ${TABLE}.store_credit_used
    value_format: '#,##0.00'
    hidden: true
    
  - dimension: gross_reveune_ex_discount_ex_vat_ex_shipping_gbp_tier
    label: Basket Size Tier
    type: tier
    tiers: [0,10,20,30,40,50,60,70,80,90,100,110,120,130,140,150,160,170,180,190,200]
    sql: ((${TABLE}.item_total- (${TABLE}.adjustment_total * (-1)) )*(1/(1+${tax_rate}))) / ${exchange_rate}

  - dimension: primary_promotion
    label: Promotion
    sql: ${TABLE}.promotion
  
####################### FLAGS ######################################################################################

  - dimension: store_credit_used_boolean
    type: yesno
    sql: ${store_credit_used} > 0
    
  - dimension: discount_used_boolean
    type: yesno
    sql: ${discount} > 0

####################### Returns Dimensions ##########################################################################

  - dimension: items_returned
    sql:  ${TABLE}.items_returned
    hidden: true
    
  - dimension: return_item_total
    type: number
    decimals: 2
    sql:  ${TABLE}.return_item_total
    value_format: '#,##0.00'
    hidden: true
    
  - dimension: amount_refunded
    type: number
    decimals: 2
    sql:  ${TABLE}.amount_refunded
    value_format: '#,##0.00'
    hidden: true
    
  - dimension: store_credit_refunded
    type: number
    decimals: 2
    sql:  ${TABLE}.store_credit_refunded
    value_format: '#,##0.00'
    hidden: true
    
  - dimension: cash_refunded
    type: number
    decimals: 2
    sql:  ${TABLE}.cash_refunded
    value_format: '#,##0.00'
    hidden: true

    
#################################################################################################################################################################################
####################################################### MEASURES ################################################################################################################
#################################################################################################################################################################################

################################################## BASIC ORDER MEASURES ################################################################
  
  - measure: count_orders
    label: Orders
    type: count_distinct
    sql: ${TABLE}.order_id
    filters:
      state: -canceled
  
  - measure: orders_perc_of_total
    label: Orders %
    type: percent_of_total
    sql: ${count_orders}
    direction: column

  - measure: orders_running_total
    label: Orders Running Total
    type: running_total
    sql: ${count_orders}
    direction: column

  - measure: count_orders_inc_cancelled
    label: Orders (Including Cancelled)
    type: count_distinct
    sql: ${TABLE}.order_id
    
  - measure: cancellation_rate
    label: Cancellation Rate
    type: number
    decimals: 2
    sql: 1 - (${count_orders})/${count_orders_inc_cancelled}::REAL
    value_format: '#.00%'

  - measure: orders_with_returns
    label: Orders with Returns
    type: count_distinct
    sql: ${TABLE}.order_id
    filters:
      items_returned: -0, -NULL
 
  - measure: orders_with_discount
    label: Orders with Discount
    type: count_distinct
    sql: ${TABLE}.order_id
    filters:
      state: -canceled
      discount_flag: Yes

  - measure: new_customers_with_discount
    label: New Customers with Discount
    type: count_distinct
    sql: ${TABLE}.order_id
    filters:
      state: -canceled
      discount_flag: Yes
      order_sequence_number: 1
  
  - measure: count_customers
    label: Customers
    type: count_distinct
    sql: ${blended_email}
    filters:
      state: -canceled

  - measure: count_new_customers
    label: New Customers
    type: count_distinct
    sql: ${blended_email}
    filters:
      state: -canceled
      order_sequence_number: 1
  
  - measure: total_items
    label: Items
    type: sum
    sql: ${TABLE}.item_count
    filters:
      state: -canceled
  
  - measure: avg_items_in_basket
    label: Avg items in basket
    type: number
    decimals: 2
    sql: ${total_items}/${count_orders}::REAL
    value_format: '#,##0.00'
    
  - measure: asp
    label: Avg Selling Price
    type: number
    decimals: 2
    sql: ${sum_gross_revenue_ex_discount_in_gbp_ex_vat_ex_shipping}/${total_items}
    value_format: '##0.00'


  - measure: orders_per_customer
    label: Orders per customer
    type: number
    decimals: 2
    sql: cast(${count_orders} as decimal(8,2))/nullif(cast(${count_customers} as decimal(8,2)),0)::REAL
    value_format: '#,##0.00'

  - measure: new_customer_percentage
    label: New Customer %
    type: number
    decimals: 4
    sql: cast(${count_new_customers} as decimal(8,2))/nullif(cast(${count_orders} as decimal(8,2)),0)::REAL
    value_format: '#0.00%'

  - measure: orders_with_discount_percentage
    label: Orders with Discount (%)
    type: number
    decimals: 4
    sql: ${orders_with_discount}/NULLIF(${count_orders},0)::REAL
    value_format: '#0.00%'

  - measure: new_customers_using_discount_percentage
    label: New Cust w/ Discount
    type: number
    decimals: 4
    sql: ${new_customers_with_discount}/NULLIF(${count_new_customers},0)::REAL
    value_format: '#0.00%'
    
################################################# GROSS REVENUE MEASURES ##############################################################

  - measure: sum_gross_revenue
    type: sum
    sql: ${TABLE}.item_total + ${TABLE}.shipment_total
    decimals: 2
    value_format: '#,##0.00'
    filters:
      state: -canceled
    hidden: true
  
  - measure: sum_gross_revenue_in_gbp
    label: Gross Revenue (inc. VAT, Discount, Shipping)
    type: sum
    sql: (${TABLE}.item_total + ${TABLE}.shipment_total) / ${exchange_rate}
    decimals: 2
    value_format: '#,##0.00'
    filters:
      state: -canceled

  - measure: sum_gross_revenue_ex_vat
    type: sum
    sql: (${TABLE}.item_total*(1/(1+${tax_rate}))) + ${TABLE}.shipment_total
    decimals: 2
    value_format: '#,##0.00'
    filters:
      state: -canceled
    hidden: true
  
  - measure: sum_gross_revenue_in_gbp_ex_vat
    label: Gross Revenue (ex. VAT, inc. Discount, Shipping)
    type: sum
    sql: ((${TABLE}.item_total*(1/(1+${tax_rate}))) + ${TABLE}.shipment_total) / ${exchange_rate}
    decimals: 2
    value_format: '#,##0.00'
    filters:
      state: -canceled
  
  - measure: sum_gross_revenue_inc_canceled
    type: sum
    sql: ${TABLE}.item_total + ${TABLE}.shipment_total
    decimals: 2
    value_format: '#,##0.00'
    hidden: true
  
  - measure: sum_gross_revenue_in_gbp_inc_canceled
    label: Gross Revenue (inc. Cancelled Orders, VAT, Discount, Shipping)
    type: sum
    sql: (${TABLE}.item_total + ${TABLE}.shipment_total) / ${exchange_rate}
    decimals: 2
    value_format: '#,##0.00'

################################################# DISCOUNT/STORE CREDIT MEASURES ##############################################################

  - measure: sum_total_discount
    type: sum
    sql: ${TABLE}.adjustment_total * (-1)
    decimals: 2
    value_format: '#,##0.00'
    filters:
      state: -canceled
    hidden: true
    
  - measure: sum_total_discount_gbp
    label: Total Voucher Discount
    type: sum
    sql: ${TABLE}.adjustment_total * (-1) / ${exchange_rate}
    decimals: 2
    value_format: '#,##0.00'
    filters:
      state: -canceled
  
  - measure: sum_store_credit_used
    type: sum
    sql: ${TABLE}.store_credit_used
    decimals: 2
    value_format: '#,##0.00'
    filters:
      state: -canceled
    hidden: true
    
  - measure: sum_store_credit_used_gbp
    label: Total Store Credit
    type: sum
    sql: ${TABLE}.store_credit_used / ${exchange_rate}
    decimals: 2
    value_format: '#,##0.00'
    filters:
      state: -canceled

  - measure: sum_total_discount_ex_vat
    type: sum
    sql: ${TABLE}.adjustment_total * (-1) * (1/(1+${tax_rate}))
    decimals: 2
    value_format: '#,##0.00'
    filters:
      state: -canceled
    hidden: true
    
  - measure: sum_total_discount_gbp_ex_vat
    label: Total Discount ex. VAT
    type: sum
    sql: ${TABLE}.adjustment_total * (-1) * ${exchange_rate}  *(1/(1+${tax_rate}))
    decimals: 2
    value_format: '#,##0.00'
    filters:
      state: -canceled
  
  - measure: sum_store_credit_used_ex_vat
    type: sum
    sql: ${TABLE}.store_credit_used*(1/(1+${tax_rate}))
    decimals: 2
    value_format: '#,##0.00'
    filters:
      state: -canceled
    hidden: true
    
  - measure: sum_store_credit_used_gbp_ex_vat
    label: Total Store Credit ex. VAT
    type: sum
    sql: ${TABLE}.store_credit_used / ${exchange_rate} * (1/(1+${tax_rate}))
    decimals: 2
    value_format: '#,##0.00'
    filters:
      state: -canceled

################################################ GROSS REVENUE EX DISCOUNT/STORE CREDIT MEASURES ##############################################################


  - measure: sum_gross_revenue_ex_discount
    type: sum
    sql: ${TABLE}.item_total + ${TABLE}.shipment_total - (${TABLE}.adjustment_total * (-1))
    decimals: 2
    value_format: '#,##0.00'
    filters:
      state: -canceled
    hidden: true
    
  - measure: sum_gross_revenue_ex_discount_in_gbp
    label: Gross Revenue ex. Voucher
    type: sum
    sql: (${TABLE}.item_total + ${TABLE}.shipment_total - (${TABLE}.adjustment_total * (-1)) ) / ${exchange_rate}
    decimals: 2
    value_format: '#,##0.00'
    filters:
      state: -canceled

  - measure: sum_gross_revenue_ex_discount_ex_vat
    type: sum
    sql: ((${TABLE}.item_total- (${TABLE}.adjustment_total * (-1)) )*(1/(1+${tax_rate})))  + ${TABLE}.shipment_total 
    decimals: 2
    value_format: '#,##0.00'
    filters:
      state: -canceled
    hidden: true
    
  - measure: sum_gross_revenue_ex_discount_in_gbp_ex_vat
    label: Gross Revenue ex. Voucher, VAT
    type: sum
    sql: (((${TABLE}.item_total- (${TABLE}.adjustment_total * (-1)) )*(1/(1+${tax_rate})))  + ${TABLE}.shipment_total)  / ${exchange_rate}
    decimals: 2
    value_format: '#,##0.00'
    filters:
      state: -canceled

  - measure: sum_gross_revenue_ex_discount_in_gbp_ex_vat_in_k
    label: Gross Revenue ex. Voucher, VAT (K)
    type: sum
    sql: (((${TABLE}.item_total- (${TABLE}.adjustment_total * (-1)) )*(1/(1+${tax_rate})))  + ${TABLE}.shipment_total) / ${exchange_rate} / 1000
    decimals: 1
    value_format: '"£"##0.0"k"'
    filters:
      state: -canceled

  - measure: sum_gross_revenue_ex_discount_and_store_credit
    type: sum
    sql: ${TABLE}.item_total + ${TABLE}.shipment_total - (${TABLE}.adjustment_total * (-1)) - ${TABLE}.store_credit_used
    decimals: 2
    value_format: '#,##0.00'
    filters:
      state: -canceled
    hidden: true
    
  - measure: sum_gross_revenue_ex_discount_and_store_credit_in_gbp
    label: Gross Revenue ex. Voucher, Store Credit
    type: sum
    sql: (${TABLE}.item_total + ${TABLE}.shipment_total - (${TABLE}.adjustment_total * (-1)) - ${TABLE}.store_credit_used)  / ${exchange_rate}
    decimals: 2
    value_format: '#,##0.00'
    filters:
      state: -canceled

  - measure: sum_gross_revenue_ex_discount_and_store_credit_ex_vat
    type: sum
    sql: ((${TABLE}.item_total - (${TABLE}.adjustment_total * (-1)) - ${TABLE}.store_credit_used)*(1/(1+${tax_rate}))) + ${TABLE}.shipment_total
    decimals: 2
    value_format: '#,##0.00'
    filters:
      state: -canceled
    hidden: true
    
  - measure: sum_gross_revenue_ex_discount_and_store_credit_in_gbp_ex_vat
    label: Gross Revenue ex. Voucher, Store Credit, VAT
    type: sum
    sql: (((${TABLE}.item_total - (${TABLE}.adjustment_total * (-1)) - ${TABLE}.store_credit_used)*(1/(1+${tax_rate}))) + ${TABLE}.shipment_total)  / ${exchange_rate}
    decimals: 2
    value_format: '#,##0.00'
    filters:
      state: -canceled

################################################# GROSS REVENUE MEASURES EXCLUDING SHIPPING ############################################################

  - measure: sum_gross_revenue_ex_discount_in_gbp_ex_vat_ex_shipping
    label: Gross Revenue (ex. VAT, Discount, Shipping)
    type: sum
    sql: ((${TABLE}.item_total- (${TABLE}.adjustment_total * (-1)) )*(1/(1+${tax_rate})))  / ${exchange_rate}
    decimals: 2
    value_format: '#,##0.00'
    filters:
      state: -canceled
  
  - measure: revenue_percent_of_total
    type: percent_of_total
    sql: ${sum_gross_revenue_ex_discount_in_gbp_ex_vat_ex_shipping}
    direction: column
  
  - measure: revenue_running_total
    type: running_total
    sql: ${sum_gross_revenue_ex_discount_in_gbp_ex_vat_ex_shipping}
    direction: column
    
  - measure: sum_gross_revenue_ex_discount_in_gbp_ex_vat_ex_shipping_in_k
    type: sum
    label: Gross Revenue (£k)
    sql: ((${TABLE}.item_total- (${TABLE}.adjustment_total * (-1)) )*(1/(1+${tax_rate})))  / ${exchange_rate} / 1000
    value_format: '"£"##0.0"k"'
    filters:
      state: -canceled
    hidden: true
  
  - measure: average_discount
    label: Avg Discount
    type: number
    decimals: 4
    sql: ${sum_total_discount_gbp}/${sum_total_of_items_gbp}::REAL
    value_format: '#0.0%'
 
  - measure: avg_gross_revenue_ex_discount_in_gbp_ex_vat_ex_shipping
    label: Avg Basket Size
    type: number
    decimals: 2
    sql: ${sum_gross_revenue_ex_discount_in_gbp_ex_vat_ex_shipping}/NULLIF(${count_orders},0)::REAL
    value_format: '#,##0.00'
  
################################################ COUNT DAYS AND MEASURES PER DAY #######################################################################

  - measure: count_days
    type: count_distinct
    sql: ${completed_date}
    hidden: true
    
  - measure: orders_per_day
    label: Orders per Day
    type: number
    decimals: 0
    sql: ${count_orders}/${count_days}::REAL

  - measure: revenue_per_day
    label: Revenue per Day
    type: number
    decimals: 0
    sql: ${sum_gross_revenue_ex_discount_in_gbp_ex_vat_ex_shipping}/${count_days}::REAL
    value_format: '#,##0'

############################ OTHER GROSS REVENUE SUMS ###################################################################################################

  - measure: sum_total_of_items
    type: sum
    sql: ${TABLE}.item_total
    decimals: 2
    value_format: '#,##0.00'
    filters:
      state: -canceled
    hidden: true
    
  - measure: sum_total_of_items_gbp
    label:  Gross Item Revenue
    type: sum
    sql: ${TABLE}.item_total / ${exchange_rate}
    decimals: 2
    value_format: '#,##0.00'
    filters:
      state: -canceled

  - measure: sum_shipping_total
    type: sum
    sql: ${TABLE}.shipment_total
    decimals: 2
    value_format: '#,##0.00'
    filters:
      state: -canceled
    hidden: true
    
  - measure: sum_shipping_total_gbp
    label: Shipping Revenue
    type: sum
    sql: ${TABLE}.shipment_total / ${exchange_rate}
    decimals: 2
    value_format: '#,##0.00'
    filters:
      state: -canceled

  ############################################################## REVENUE AVERAGES ##############################################################################

  - measure: avg_gross_revenue_gbp
    label: Avg Basket Size
    type: number
    decimals: 2
    sql: ${sum_gross_revenue_in_gbp}/NULLIF(${count_orders},0)::REAL
    value_format: '#,##0.00'
      
  - measure: avg_gross_revenue_ex_discount_in_gbp
    label: Avg Basket Size ex. Voucher
    type: number
    decimals: 2
    sql: ${sum_gross_revenue_ex_discount_in_gbp}/NULLIF(${count_orders},0)::REAL
    value_format: '#,##0.00'
    
  - measure: avg_gross_revenue_ex_discount_and_store_credit_in_gbp
    label: Avg Basket Size ex. Voucher, Store Credit
    type: number
    decimals: 2
    sql: ${sum_gross_revenue_ex_discount_and_store_credit_in_gbp}/NULLIF(${count_orders},0)::REAL
    value_format: '#,##0.00'
    
  - measure: avg_gross_revenue_gbp_ex_vat
    label: Avg Basket Size ex. VAT
    type: number
    decimals: 2
    sql: ${sum_gross_revenue_in_gbp_ex_vat}/NULLIF(${count_orders},0)::REAL
    value_format: '#,##0.00'
      
  - measure: avg_gross_revenue_ex_discount_in_gbp_ex_vat
    label: Avg Basket Size ex. Voucher, VAT
    type: number
    decimals: 2
    sql: ${sum_gross_revenue_ex_discount_in_gbp_ex_vat}/NULLIF(${count_orders},0)::REAL
    value_format: '#,##0.00'
    
  - measure: avg_gross_revenue_ex_discount_and_store_credit_in_gbp_ex_vat
    label: Avg Basket Size ex. Voucher, Store Credit, VAT
    type: number
    decimals: 2
    sql: ${sum_gross_revenue_ex_discount_and_store_credit_in_gbp_ex_vat}/NULLIF(${count_orders},0)::REAL
    value_format: '#,##0.00'

  - measure: avg_discount_in_gbp
    label: Avg Discount Value
    type: number
    decimals: 2
    sql: ${sum_total_discount_gbp}/NULLIF(${count_orders},0)::REAL
    value_format: '#,##0.00'

  - measure: avg_discount_in_gbp_ex_vat
    label: Avg Discount Value ex. VAT
    type: number
    decimals: 2
    sql: ${sum_total_discount_gbp_ex_vat}/NULLIF(${count_orders},0)::REAL
    value_format: '#,##0.00'

  - measure: avg_store_credit_used_gbp
    label: Avg Store Credit Used
    type: number
    decimals: 2
    sql: ${sum_store_credit_used_gbp}/NULLIF(${count_orders},0)::REAL
    value_format: '#,##0.00'
    
  - measure: avg_store_credit_used_gbp_ex_vat
    label: Avg Store Credit Used ex. VAT
    type: number
    decimals: 2
    sql: ${sum_store_credit_used_gbp_ex_vat}/NULLIF(${count_orders},0)::REAL
    value_format: '#,##0.00'

############################################################## RETURNS MEASUERS #############################################################################################

  - measure: sum_items_returned
    label: Items Returned
    type: sum
    sql: ${items_returned}
    filters:
      state: -canceled

  - measure: sum_return_item_total
    type: sum
    sql: ${return_item_total}
    decimals: 2
    value_format: '#,##0.00'
    filters:
      state: -canceled
    hidden: true
    
  - measure: sum_return_item_total_gbp
    label: Return Item Value
    type: sum
    sql: ${return_item_total} / ${exchange_rate}
    decimals: 2
    value_format: '#,##0.00'
    filters:
      state: -canceled

  - measure: sum_amount_refunded
    type: sum
    sql: ${amount_refunded}
    value_format: '#,##0.00'
    decimals: 2
    filters:
      state: -canceled
    hidden: true
    
  - measure: sum_amount_refunded_gbp
    label: Total Amount Refunded
    type: sum
    sql: ${amount_refunded} / ${exchange_rate}
    decimals: 2
    value_format: '#,##0.00'
    filters:
      state: -canceled
  
  - measure: sum_cash_refunded
    type: sum
    sql: ${cash_refunded}
    value_format: '#,##0.00'
    decimals: 2
    filters:
      state: -canceled
    hidden: true
    
  - measure: sum_cash_refunded_gbp
    label: Total Cash Refunded
    type: sum
    sql: ${cash_refunded} / ${exchange_rate}
    decimals: 2
    value_format: '#,##0.00'
    filters:
      state: -canceled
      
  - measure: sum_store_credit_refunded
    type: sum
    sql: ${store_credit_refunded}
    value_format: '#,##0.00'
    decimals: 2
    filters:
      state: -canceled
    hidden: true
    
  - measure: sum_store_credit_refunded_gbp
    label: Total Store Credit Refunded
    type: sum
    sql: ${store_credit_refunded} / ${exchange_rate}
    decimals: 2
    value_format: '#,##0.00'
    filters:
      state: -canceled


############################################################## NET REVENUE MEASURES (POST RETURNS) #############################################################################################
  
  - measure: sum_net_revenue
    type: sum
    sql: ${item_total} + ${shipping_total} - ${return_item_total}
    decimals: 2
    value_format: '#,##0.00'
    filters:
      state: -canceled  
    hidden: true
    
  - measure: sum_net_revenue_gbp
    label: Net Revenue
    type: sum
    sql: (${item_total} + ${shipping_total} - ${return_item_total}) / ${exchange_rate}
    decimals: 2
    value_format: '#,##0.00'
    filters:
      state: -canceled
      
  - measure: sum_net_revenue_ex_vat
    type: sum
    sql: ((${item_total} - ${return_item_total})*(1/(1+${tax_rate}))) + ${shipping_total}
    decimals: 2
    value_format: '#,##0.00'
    filters:
      state: -canceled  
    hidden: true
    
  - measure: sum_net_revenue_gbp_ex_vat
    label: Net Revenue ex. VAT
    type: sum
    sql: (((${item_total} - ${return_item_total})*(1/(1+${tax_rate}))) + ${shipping_total}) / ${exchange_rate}
    decimals: 2
    value_format: '#,##0.00'
    filters:
      state: -canceled

  - measure: sum_net_revenue_ex_discount
    type: sum
    sql: ${item_total} - ${discount} - ${amount_refunded} + ${shipping_total}
    decimals: 2
    value_format: '#,##0.00'
    filters:
      state: -canceled
    hidden: true
    
  - measure: sum_net_revenue_ex_discount_gbp
    label: Net Revenue ex. Discount
    type: sum
    sql: (${item_total} - ${discount} - ${amount_refunded} + ${shipping_total}) / ${exchange_rate}
    decimals: 2
    value_format: '#,##0.00'
    filters:
      state: -canceled

  - measure: sum_net_revenue_ex_discount_ex_vat
    type: sum
    sql: ((${item_total} - ${discount} - ${amount_refunded})*(1/(1+${tax_rate}))) + ${shipping_total}
    decimals: 2
    value_format: '#,##0.00'
    filters:
      state: -canceled
    hidden: true
    
  - measure: sum_net_revenue_ex_discount_gbp_ex_vat
    label: Net. Revenue ex. Discount, VAT
    type: sum
    sql: (((${item_total} - ${discount} - ${amount_refunded})*(1/(1+${tax_rate}))) + ${shipping_total}) / ${exchange_rate}
    decimals: 2
    value_format: '#,##0.00'
    filters:
      state: -canceled

  - measure: sum_net_revenue_ex_discount_ex_store_credit
    type: sum
    sql: ${item_total} - ${discount} - ${amount_refunded}  - ${store_credit_used} + ${store_credit_refunded} + ${shipping_total}
    decimals: 2
    value_format: '#,##0.00'
    filters:
      state: -canceled
    hidden: true
    
  - measure: sum_net_revenue_ex_discount_ex_store_credit_gbp
    label: Net Revenue ex. Voucher, Store Credit
    type: sum
    sql: (${item_total} - ${discount} - ${amount_refunded}  - ${store_credit_used} + ${store_credit_refunded} + ${shipping_total}) / ${exchange_rate}
    decimals: 2
    value_format: '#,##0.00'
    filters:
      state: -canceled

  - measure: sum_net_revenue_ex_discount_ex_store_credit_ex_vat
    type: sum
    sql: ((${item_total} - ${discount} - ${amount_refunded}  - ${store_credit_used} + ${store_credit_refunded})*(1/(1+${tax_rate}))) + ${shipping_total}
    decimals: 2
    value_format: '#,##0.00'
    filters:
      state: -canceled
    hidden: true
    
  - measure: sum_net_revenue_ex_discount_ex_store_credit_gbp_ex_vat
    label: Net Revenue ex. Voucher, Store Credit, VAT
    type: sum
    sql: (((${item_total} - ${discount} - ${amount_refunded}  - ${store_credit_used} + ${store_credit_refunded})*(1/(1+${tax_rate}))) + ${shipping_total}) / ${exchange_rate}
    decimals: 2
    value_format: '#,##0.00'
    filters:
      state: -canceled


################################### DELIVERY MEASURES ################################################################################

  - measure: count_hermes_completed_orders
    label: Orders Shipped with Hermes
    type: count_distinct
    sql: ${TABLE}.order_id
    filters:
      state: -canceled
      delivery_company: HERM
      late_delivery_reason: -Parcel to be Delivered, -Parcel Currently Late - Not Delivered
      
  - measure: count_hermes_late_orders
    label: Hermes Late Deliveries
    type: count_distinct
    sql: ${TABLE}.order_id
    filters:
      state: -canceled
      delivery_company: HERM
      late_delivery_reason: Parcel Lost by Hermes, Late to Hub, Delay at Depot, Misrouted to Incorrect Depot, Carried Forward, Late - Other Reason, Late to Depot, Delay in Courier Receiving Package, Hermes Delay, Missort to Incorrect Courier

  - measure: count_hermes_no_tracking_info
    label: Hermes Deliveries - No Tracking
    type: count_distinct
    sql: ${TABLE}.order_id
    filters:
      state: -canceled
      delivery_company: HERM
      late_delivery_reason: No Tracking Info - Hermes

  - measure: more_info_required_orders
    label: Hermes Deliveries - More Info Required
    type: count_distinct
    sql: ${TABLE}.order_id
    filters:
      state: -canceled
      delivery_company: HERM
      late_delivery_reason: More Info Required

  - measure: hermes_on_time_percentage
    label: Hermes On Time %
    type: number
    decimals: 4
    sql: 1 - ${count_hermes_late_orders}/nullif(${count_hermes_completed_orders},0)::REAL
    value_format: '#0.00%'

  - measure: hermes_no_tracking_info_percentage
    label: Hermes No Tracking Info %
    type: number
    decimals: 4
    sql: 1 - ${count_hermes_no_tracking_info}/nullif(${count_hermes_completed_orders},0)::REAL
    value_format: '#0.00%'

  - measure: more_info_required_percentage
    label: Hermes More Info Required %
    type: number
    decimals: 4
    sql: 1 - ${more_info_required_orders}/nullif(${count_hermes_completed_orders},0)::REAL
    value_format: '#0.00%'
  
  
 