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

  - dimension_group: completed
    label: Order
    type: time
    timeframes: [time, date, hour_of_day, hour, time_of_day, day_of_week_index, day_of_week, week, week_of_year, day_of_month, month, month_num, year, quarter, quarter_of_year]
    sql: ${TABLE}.completed_at

  - dimension: item_count
    label: Items in Order
    type: int
    sql: ${TABLE}.item_count

  - dimension: item_count_tier
    label: Items in Order Tier
    sql: |
          case
          when ${TABLE}.item_count = 1 then '1'
          when ${TABLE}.item_count = 2 then '2'
          when ${TABLE}.item_count = 3 then '3'
          when ${TABLE}.item_count = 4 then '4'
          else '5+' end

  - dimension: sale_item_count
    type: int
    sql: ${TABLE}.on_sale_items

  - dimension: order_contains_sale_items
    type: yesno
    sql: ${sale_item_count} > 0
  
          
  - dimension: RM_order_flag
    type: int
    sql: |
          case when spree_orders.delivery_type = 'Next Day Delivery' and parcel_tracking.last_event_status_detail is not null then 1 
          when spree_orders.delivery_type = 'Standard Delivery' and parcel_tracking.last_event_status_detail is not null then 1 
          else 0 end
          
  - dimension: RM_late_order_flag
    type: int
    sql: |
          case when datediff(day, ${TABLE}.rm_delivery_due_date, parcel_tracking.attempted_delivery) > 0 and ${RM_order_flag} = 1 then 1 end 
  
  - dimension: RM_delivery_on_time_flag
    type: int
    sql: |
          case when datediff(day, ${TABLE}.rm_delivery_due_date, parcel_tracking.attempted_delivery) <= 0 and ${RM_order_flag} = 1 then 1 end 
          
  - dimension: RM_no_attempted_delivery_flag
    type: int
    sql: |
          case when parcel_tracking.attempted_delivery is null and ${RM_order_flag} = 1 then 1 end        
  
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

  - dimension: new_customer_flag
    type: yesno
    sql: ${order_sequence_tier} = 1

  - dimension: discount_flag
    type: yesno
    sql: ${TABLE}.adjustment_total <> 0

  - dimension: gift_card_only_orders
    type: yesno
    sql: ${TABLE}.total_gift_card_items = ${TABLE}.item_count

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
  
  - dimension: paid_for_shipping
    type: yesno
    sql: ${TABLE}.shipment_total > 0
  
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
    
  - dimension: rm_delivery_due_date
    type: time
    timeframes: [date, day_of_week_index]
    sql: ${TABLE}.rm_delivery_due_date
    

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
    label: Basket Size Tier ex. Shipping
    type: tier
    tiers: [0,10,20,30,40,50,60,70,80,90,100,110,120,130,140,150,160,170,180,190,200]
    sql: ((${TABLE}.item_total- (${TABLE}.adjustment_total * (-1)) )) / ${exchange_rate}

  - dimension: basket_size_ex_shipping
    label: Basket Size ex. Shipping
    type: number
    decimals: 2
    sql: ((${TABLE}.item_total- (${TABLE}.adjustment_total * (-1)) )) / ${exchange_rate}
    value_format: '#,##0.00'

  - dimension: basket_size_tier_50_gbp
    type: tier
    tiers: [50,100,150,200]
    sql: ((${TABLE}.item_total- (${TABLE}.adjustment_total * (-1)) )) / ${exchange_rate}

  - dimension: average_selling_price
    type: number
    sql: ((${item_total} -${discount} ) / ${exchange_rate})/${item_count}

  - dimension: average_selling_price_tier
    type: tier
    tiers: [0,10,20,30,40,50,60,70,80,90,100]
    sql: ${average_selling_price}
    style: integer
    value_format: '"£"#0'

  - dimension: average_selling_price_tier_20_gbp
    type: tier
    tiers: [20,40,60,80,100]
    sql: ${average_selling_price}
    style: integer
    value_format: '"£"#0'
    
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
    type: int
    sql:  cast(coalesce(${TABLE}.items_returned, '0') as integer)
  
  - dimension: order_contains_return
    type: yesno
    sql: ${items_returned} > 0
 
  - dimension: return_rate_order
    label: Return Rate
    type: number
    sql: ${items_returned}/NULLIF(${item_count},0)::REAL
    
  - dimension: return_rate_tier
    type: tier
    sql: ${return_rate_order}
    tiers: [0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0]
    style: relational
    value_format: '0%'
    
  - dimension: returned_an_item_flag
    sql: case when ${items_returned} > 0 then 'yes' else 'no' end

  - dimension: all_items_returned_flag
    sql: case when ${items_returned} = ${item_count} then 'yes' else 'no' end

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

  - dimension: restocking_fee
    type: number
    decimals: 2
    sql:  ${TABLE}.restocking_fee/${exchange_rate}
    value_format: '#,##0.00'

  - dimension: vat_payable_gbp
    type: number
    decimals: 2
    sql:  ((${item_total} - ${discount} - ${amount_refunded} + ${store_credit_refunded} - ${store_credit_used}) / ${exchange_rate}) * (${tax_rate}/(1+${tax_rate}))
    value_format: '#0.00'

  - dimension: gross_cogs_gbp
    type: number
    decimals: 2
    sql:  ${TABLE}.gross_cogs
    value_format: '#,##0.00'
    hidden: true

  - dimension: net_cogs_gbp
    type: number
    decimals: 2
    sql:  ${TABLE}.net_cogs
    value_format: '#,##0.00'
    hidden: true
 
  - dimension: retail_markdown_gbp
    type: number
    decimals: 2
    sql:  ${TABLE}.retail_markdown_gbp
    value_format: '#,##0.00'
    hidden: true
  
  - dimension: gross_revenue_pre_retail_markdown
    type: number
    decimals: 2
    sql: (${item_total}/${exchange_rate}) + ${retail_markdown_gbp}
    
  - dimension: total_discount_retail_md_voucher
    type: number
    decimals: 2
    sql: ${retail_markdown_gbp} + (${discount}/${exchange_rate})
    
  - dimension: total_discount_retail_md_voucher_store_credit
    type: number
    decimals: 2
    sql: ${retail_markdown_gbp} + ((${discount} + ${store_credit_used})/${exchange_rate})
  
  - dimension: order_contains_markdown
    type: yesno
    sql: ${total_discount_retail_md_voucher_store_credit} > 0

  - dimension: retail_markdown_tier
    type: tier
    sql: ${retail_markdown_gbp}/NULLIF(${gross_revenue_pre_retail_markdown},0)::REAL
    tiers: [0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8]
    style: relational
    value_format: '0%'
    
  - dimension: total_discount_tier
    type: tier
    sql: ${total_discount_retail_md_voucher_store_credit}/NULLIF(${gross_revenue_pre_retail_markdown},0)::REAL
    tiers: [0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8]
    style: relational
    value_format: '0%'

  - dimension: has_free_returns
    type: yesno
    sql: (${TABLE}.free_returns_flag = 1 and ${TABLE}.before_paid_returns_date = 0) or (${TABLE}.before_paid_returns_date = 1 and ${TABLE}.uk_order_flag = 1)

  - dimension: has_free_returns_backdated
    description: 'Flags whether the order would have free returns under the new policy implemented on 01/09/2016'
    type: yesno
    sql: ${TABLE}.free_returns_flag = 1
    
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
      
  - measure: RM_orders
    type: sum
    sql: ${RM_order_flag}
    
  - measure: No_RM_match_orders
    type: count
    sql: ${RM_order_flag}
    filters:
      RM_order_flag: 0
      
  - measure: total_on_time_delivery_attempt_rm_orders
    label: RM On Time Attempt Deliveries
    type: sum
    sql: ${RM_delivery_on_time_flag}
    
  - measure: total_late_delivery_attempt_rm_orders
    label: RM Late Attempt Deliveries
    type: sum
    sql: ${RM_late_order_flag}
    
  
  - measure: total_no_attempted_delivery_rm_orders
    label: RM No Attempt Deliveries
    type: sum
    sql: ${RM_no_attempted_delivery_flag}
  
  - measure: percentage_of_no_rm_match_orders
    label: No RM Match Orders Percentage
    type: number
    decimals: 2
    sql: ${No_RM_match_orders}/(NULLIF(${RM_orders},0)::REAL + NULLIF(${No_RM_match_orders},0)::REAL)
    value_format: '#0.00%'
    
  - measure: percentage_of_on_time_rm_deliveries
    label: RM On Time Attempted Deliveries Percentage
    type: number
    decimals: 2
    sql: ${total_on_time_delivery_attempt_rm_orders}/NULLIF(${RM_orders},0)::REAL
    value_format: '#0.00%'
    
  - measure: percentage_of_late_rm_deliveries
    label: RM Late Attempted Deliveries Percentage
    type: number
    decimals: 2
    sql: ${total_late_delivery_attempt_rm_orders}/NULLIF(${RM_orders},0)::REAL
    value_format: '#0.00%'
  
  - measure: percentage_of_no_attempted_deliveries
    label: RM No Attempted Deliveries Percentage
    type: number
    decimals: 2
    sql: ${total_no_attempted_delivery_rm_orders}/NULLIF(${RM_orders},0)::REAL
    value_format: '#0.00%'
  
  - measure: orders_perc_of_total
    label: Orders % Column
    type: percent_of_total
    sql: ${count_orders}
    direction: column

  - measure: orders_perc_of_total_row
    label: Orders % Row
    type: percent_of_total
    sql: ${count_orders}
    direction: row

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
      items_returned: '>0'
 
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
   
  - measure: sum_restocking_fee
    type: sum
    sql: ${restocking_fee}
    value_format: '#,##0.00'

  - measure: sum_vat_payable_gbp
    type: sum
    sql: ${vat_payable_gbp}
    value_format: '#,##0.00'

  - measure: sum_gross_cogs_gbp
    type: sum
    decimals: 2
    sql: ${gross_cogs_gbp}
    value_format: '#,##0.00'

  - measure: sum_net_cogs_gbp
    type: sum
    decimals: 2
    sql: ${net_cogs_gbp}
    value_format: '#,##0.00'
    
  - measure: sum_retail_markdown
    type: sum
    sql: ${retail_markdown_gbp}
  
  - measure: sum_total_discount_retail_md_voucher_store_credit
    type: sum
    sql: ${total_discount_retail_md_voucher_store_credit}
      
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

  - measure: sum_gross_revenue_ex_discount_and_shipping_in_gbp
    label: Gross Revenue ex. Voucher, Shipping
    type: sum
    sql: (${TABLE}.item_total - (${TABLE}.adjustment_total * (-1)) ) / ${exchange_rate}
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

  - measure: avg_gross_revenue_ex_discount_and_shipping_in_gbp
    label: Avg Basket Size ex. Voucher, Shipping
    type: number
    decimals: 2
    sql: ${sum_gross_revenue_ex_discount_and_shipping_in_gbp}/NULLIF(${count_orders},0)::REAL
    value_format: '#,##0.00'

  - measure: avg_shipping_in_gbp
    label: Shipping Revenue per Order
    type: number
    decimals: 2
    sql: ${sum_shipping_total_gbp}/NULLIF(${count_orders},0)::REAL
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

  - measure: return_rate
    type: number
    sql: ${sum_items_returned}/NULLIF(${total_items},0)::REAL
    value_format: '#0.00%'

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
 
  - measure: sum_net_store_credit_used_gbp
    label: Net Store Credit Used
    type: number
    sql: ${sum_store_credit_used_gbp} - ${sum_store_credit_refunded_gbp}
    decimals: 2
    value_format: '#,##0.00'    

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


############## UNIT ORDER ECONOMICS

  - measure: gross_revenue_per_order
    type: number
    decimals: 2
    sql: ${sum_gross_revenue_ex_discount_in_gbp}/NULLIF(${count_orders},0)::REAL
    value_format: '#0.00'
    group_label: 'Unit Order Economics'

  - measure: shipping_revenue_per_order
    type: number
    decimals: 2
    sql: ${sum_shipping_total_gbp}/NULLIF(${count_orders},0)::REAL
    value_format: '#0.00'    
    group_label: 'Unit Order Economics'
    
  - measure: amount_refunded_per_order
    type: number
    decimals: 2
    sql: ${sum_amount_refunded_gbp}/NULLIF(${count_orders},0)::REAL
    value_format: '#0.00'
    group_label: 'Unit Order Economics'
    
  - measure: net_store_credit_used_per_order
    type: number
    decimals: 2
    sql: ${sum_net_store_credit_used_gbp}/NULLIF(${count_orders},0)::REAL
    value_format: '#0.00' 
    group_label: 'Unit Order Economics'
    
  - measure: vat_per_order
    type: number
    decimals: 2
    sql: ${sum_vat_payable_gbp}/NULLIF(${count_orders},0)::REAL
    value_format: '#0.00' 
    group_label: 'Unit Order Economics'
    
  - measure: net_cogs_per_order
    type: number
    decimals: 2
    sql: ${sum_net_cogs_gbp}/NULLIF(${count_orders},0)::REAL
    value_format: '#0.00' 
    group_label: 'Unit Order Economics'
    
  - measure: net_profit_pre_ops_and_marketing
    type: number
    decimals: 2
    sql: ${gross_revenue_per_order} - ${shipping_revenue_per_order} - ${amount_refunded_per_order} - ${net_store_credit_used_per_order} - ${vat_per_order} - ${net_cogs_per_order}
    value_format: '#0.00'
    group_label: 'Unit Order Economics'