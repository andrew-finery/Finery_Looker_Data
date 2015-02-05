- view: spree_orders
  derived_table:
    sql: |
     SELECT  a.spree_timestamp,
             a.id AS order_id,
             a. "number" AS order_code,
             a.user_id AS customer_id,
             a.email as email,
             a.bill_address_id,
             a.ship_address_id,
             a.item_total,
             a.total AS order_total,
             case when voids.order_id is not null then 'canceled' else a.state end as state,
             adjustment_total,
             shipment_total,
             shipments.name as shipping_method,
             shipments.tracking as tracking_number,
             shipments.consignee,
             shipments.name as delivery_type,
             a.included_tax_total,
             a.additional_tax_total,
             a.completed_at,
             a.currency,
             a.item_count,
             COALESCE(b.store_credit,'0') AS store_credit_used,
             c.exchange_rate,
             COALESCE(d.return_item_total,'0') AS return_item_total,
             COALESCE(d.items_returned,'0') AS items_returned,
             COALESCE(e.amount_refunded,'0') AS amount_refunded,
             COALESCE(e.store_credit_refunded,'0') AS store_credit_refunded,
             COALESCE(e.cash_refunded,'0') AS cash_refunded
      FROM (SELECT *
            FROM daily_snapshot.spree_orders
            WHERE spree_timestamp = (SELECT MAX(spree_timestamp) FROM daily_snapshot.spree_orders)) a
            
        LEFT JOIN (SELECT order_id,
                          SUM(amount) AS store_credit
                   FROM (SELECT *
                         FROM daily_snapshot.spree_payments
                         WHERE spree_timestamp = (SELECT MAX(spree_timestamp)
                                                  FROM daily_snapshot.spree_payments))
                   WHERE source_type = 'Spree::StoreCredit'
                   GROUP BY 1) b ON a.id = b.order_id
                   
        LEFT JOIN lookup.exchange_rates c
               ON DATE_TRUNC ('day',a.completed_at) = c. "date"
              AND a.currency = c.currency
              
        LEFT JOIN (SELECT order_id
                    FROM (SELECT order_id,
                                 FIRST_VALUE(source_type) OVER (PARTITION BY order_id ORDER BY created_at DESC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS source_type,
                                 FIRST_VALUE(payment_method_id) OVER (PARTITION BY order_id ORDER BY created_at DESC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS payment_method_id,
                                 FIRST_VALUE(state) OVER (PARTITION BY order_id ORDER BY created_at DESC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS state
                          FROM (SELECT *
                                FROM daily_snapshot.spree_payments
                                WHERE spree_timestamp = (SELECT MAX(spree_timestamp)
                                                         FROM daily_snapshot.spree_payments)))
                    WHERE payment_method_id = 4
                    AND   state = 'void'
                    GROUP BY 1) voids ON voids.order_id = a.id
        
        LEFT JOIN (SELECT aaa.order_id,
                          SUM(bbb.price) AS return_item_total,
                          COUNT(*) AS items_returned
                   FROM ${returns.SQL_TABLE_NAME} aaa
                     LEFT JOIN (SELECT *
                                FROM daily_snapshot.spree_line_items
                                WHERE spree_timestamp = (SELECT MAX(spree_timestamp)
                                                         FROM daily_snapshot.spree_line_items)) bbb
                            ON aaa.order_id = bbb.order_id
                           AND aaa.variant_id = bbb.variant_id
                   GROUP BY 1) d ON a.id = d.order_id
        LEFT JOIN (SELECT bbb.order_id,
                          SUM(bbb.amount_refunded) AS amount_refunded,
                          SUM(bbb.amount_refunded) - SUM(CASE WHEN bbb.payment_method_id = 3 THEN bbb.amount_refunded ELSE 0 END) AS cash_refunded,
                          SUM(CASE WHEN bbb.payment_method_id = 3 THEN bbb.amount_refunded ELSE 0 END) AS store_credit_refunded
                   FROM ${spree_refunds.SQL_TABLE_NAME} bbb
                   GROUP BY 1) e ON a.id = e.order_id
                   
        
        LEFT JOIN (SELECT spree_shipments.order_id,
                           spree_shipments.tracking,
                           spree_shipments. "number",
                           spree_shipments.consignee,
                           spree_shipping_methods.name,
                           spree_shipping_methods.admin_name,
                           spree_shipping_methods.carrier_description
                    FROM (SELECT order_id,
                                 MAX(id) AS shipment_id
                          FROM daily_snapshot.spree_shipments
                          WHERE spree_timestamp = (SELECT MAX(spree_timestamp)
                                                   FROM daily_snapshot.spree_shipments)
                          GROUP BY 1) orders_to_shipments
                      INNER JOIN (SELECT *
                                  FROM daily_snapshot.spree_shipments
                                  WHERE spree_timestamp = (SELECT MAX(spree_timestamp)
                                                           FROM daily_snapshot.spree_shipments)) spree_shipments ON orders_to_shipments.shipment_id = spree_shipments.id
                      LEFT JOIN (SELECT *
                                 FROM daily_snapshot.spree_shipping_rates
                                 WHERE spree_timestamp = (SELECT MAX(spree_timestamp)
                                                          FROM daily_snapshot.spree_shipping_rates)
                                 AND   selected = 1) spree_shipping_rates ON spree_shipments.id = spree_shipping_rates.shipment_id
                      LEFT JOIN (SELECT *
                                 FROM daily_snapshot.spree_shipping_methods
                                 WHERE spree_timestamp = (SELECT MAX(spree_timestamp)
                                                          FROM daily_snapshot.spree_shipping_methods)) spree_shipping_methods ON spree_shipping_methods.id = spree_shipping_rates.shipping_method_id) shipments
                      on a.id = shipments.order_id
                            
      WHERE a.state IN ('complete','returned','canceled')
      AND   a.created_at > DATE '2014-11-22'

    
    sql_trigger_value: SELECT max(spree_timestamp) FROM ${spree_refunds.SQL_TABLE_NAME}
    distkey: order_id
    sortkeys: [order_id, completed_at]

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
    type: time
    timeframes: [time, date, week, month, tod, dow]
    sql: ${TABLE}.completed_at

  - dimension: item_count
    type: int
    sql: ${TABLE}.item_count

  - dimension: order_code
    sql: ${TABLE}.order_code

  - dimension: state
    sql: ${TABLE}.state

  - dimension: customer_id
    type: int
    sql: ${TABLE}.customer_id
  
  - dimension: order_email
    sql: ${TABLE}.email

# Shipping Dimensions

  - dimension: shipping_method
    sql: ${TABLE}.shipping_method

  - dimension: tracking_number
    type: string
    sql: ${TABLE}.tracking_number || 'a'
  
  - dimension: delivery_company
    sql: ${TABLE}.consignee
  
  - dimension: delivery_type
    sql: ${TABLE}.delivery_type
  
  - dimension: tracking_info_available
    type: yesno
    sql: ${tracking_number} <> 'a'

  - dimension: delivered_flag
    type: yesno
    sql: |
        ${delivery_tracking_current_status.delivery_confirmed_time_time} is not null
        or ${TABLE}.tracking_number in
        ('7817394680536081',
        '3901472680538288',
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
  
  - dimension: returned_flag
    type: yesno
    sql: ${delivery_tracking_current_status.return_confirmed_time_time} is not null  
    
  - dimension_group: expected_delivery
    type: time
    timeframes: [date]
    sql: |
        case
        --- 48 HOUR DELIVERY CASES
        when ${delivery_type} = '48 Hour Delivery' and ${completed_dow} = 0 then ${completed_date} + 3                                                  -- 48h Orders on Sunday delivered on Wednesday
        when ${delivery_type} = '48 Hour Delivery' and ${completed_dow} between 1 and 3 and ${completed_tod} < '16:00' then ${completed_date} + 2       -- 48h Orders Mon-Wed before 4 delivered 2 days later
        when ${delivery_type} = '48 Hour Delivery' and ${completed_dow} between 1 and 3 and ${completed_tod} >= '16:00' then ${completed_date} + 3      -- 48h Orders Mon-Wed after 4 delivered 3 days later
        when ${delivery_type} = '48 Hour Delivery' and ${completed_dow} = 4 and ${completed_tod} < '16:00' then ${completed_date} + 2                   -- 48h Order on Thursday before 4 delivered on Saturday
        when ${delivery_type} = '48 Hour Delivery' and ${completed_dow} = 4 and ${completed_tod} >= '16:00' then ${completed_date} + 4                  -- 48h Orders on Thursday after 4 delivered Monday
        when ${delivery_type} = '48 Hour Delivery' and ${completed_dow} = 5 and ${completed_tod} < '16:00' then ${completed_date} + 3                   -- 48h Orders on Friday before 4 delivered Monday
        when ${delivery_type} = '48 Hour Delivery' and ${completed_dow} = 5 and ${completed_tod} >= '16:00' then ${completed_date} + 4                  -- 48h Orders on Friday after 4 delivered Tuesday
        when ${delivery_type} = '48 Hour Delivery' and ${completed_dow} = 6 and ${completed_tod} < '17:00' then ${completed_date} + 3                   -- 48h Orders on Saturday before 5 delivered Tuesday
        when ${delivery_type} = '48 Hour Delivery' and ${completed_dow} = 6 and ${completed_tod} >= '17:00' then ${completed_date} + 4                  -- 48h Orders on Saturday after 5 delivered Wednesday
        --- NEXT DAY DELIVERY CASES
        when ${delivery_type} = 'Next Day Delivery' and ${completed_dow} = 0 then ${completed_date} + 2                                                 -- 24h Orders on Sunday delivered on Tuesday
        when ${delivery_type} = 'Next Day Delivery' and ${completed_dow} between 1 and 4 and ${completed_tod} < '16:00' then ${completed_date} + 1      -- 24h Orders Mon-Thu before 4 delivered the next day
        when ${delivery_type} = 'Next Day Delivery' and ${completed_dow} between 1 and 4 and ${completed_tod} >= '16:00' then ${completed_date} + 2     -- 24h Orders Mon-Thu after 4 delivered 2 days later
        when ${delivery_type} = 'Next Day Delivery' and ${completed_dow} = 5 and ${completed_tod} < '16:00' then ${completed_date} + 1                  -- 24h Orders Fri before 4 delivered Saturday                   
        when ${delivery_type} = 'Next Day Delivery' and ${completed_dow} = 5 and ${completed_tod} >= '16:00' then ${completed_date} + 3                 -- 24h Orders Fri after 4 delivered Monday
        when ${delivery_type} = 'Next Day Delivery' and ${completed_dow} = 6 and ${completed_tod} < '17:00' then ${completed_date} + 2                  -- 24h Orders on Saturday before 5 delivered Monday
        when ${delivery_type} = 'Next Day Delivery' and ${completed_dow} = 6 and ${completed_tod} >= '17:00' then ${completed_date} + 3                 -- 24h Orders on Saturday after 5 delivered Tuesday
        --- SUNDAY DELIVERY CASES
        when ${delivery_type} = 'Sunday Delivery' and ${completed_dow} = 1 then ${completed_date} + 6                                                   -- Sunday Delivery Orders on Monday delivered this Sunday
        when ${delivery_type} = 'Sunday Delivery' and ${completed_dow} = 2 then ${completed_date} + 5                                                   -- Sunday Delivery Orders on Tuesday delivered this Sunday
        when ${delivery_type} = 'Sunday Delivery' and ${completed_dow} = 3 then ${completed_date} + 4                                                   -- Sunday Delivery Orders on Wednesday delivered this Sunday
        when ${delivery_type} = 'Sunday Delivery' and ${completed_dow} = 4 then ${completed_date} + 3                                                   -- Sunday Delivery Orders on Thursday delivered this Sunday
        when ${delivery_type} = 'Sunday Delivery' and ${completed_dow} = 5 and ${completed_tod} < '16:00' then ${completed_date} + 2                    -- Sunday Delivery Orders on Friday before 4 delivered this Sunday
        when ${delivery_type} = 'Sunday Delivery' and ${completed_dow} = 5 and ${completed_tod} >= '16:00' then ${completed_date} + 9                   -- Sunday Delivery Orders on Friday after 4 delivered next Sunday
        when ${delivery_type} = 'Sunday Delivery' and ${completed_dow} = 6 then ${completed_date} + 8                                                   -- Sunday Delivery Orders on Saturday delivered next Sunday
        when ${delivery_type} = 'Sunday Delivery' and ${completed_dow} = 0 then ${completed_date} + 7                                                   -- Sunday Delivery Orders on Sunday delivered next Sunday
        --- OTHER DELIVERIES
        else ${completed_date} + 7                                                                                                                      -- Assume all other deliveries DHL and get there within a week of order
        end

##################################### REVENUE DIMENSIONS ##########################################################
  
  - dimension: currency
    sql: ${TABLE}.currency
  
  - dimension: exchange_rate
    sql: ${TABLE}.exchange_rate

  - dimension: payment_total
    type: number
    decimals: 2
    sql: ${TABLE}.order_total
    format: "%0.2f"

  - dimension: item_total
    type: number
    decimals: 2
    sql: ${TABLE}.item_total
    format: "%0.2f"
    
  - dimension: shipping_total
    type: number
    decimals: 2
    sql: ${TABLE}.shipment_total
    format: "%0.2f"

  - dimension: discount
    type: number
    decimals: 2
    sql: ${TABLE}.adjustment_total * (-1)
    format: "£%0.2f"
  
  - dimension: store_credit_used
    type: number
    sql: ${TABLE}.store_credit_used
    format: "%0.2f"
  
  
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

  - dimension: return_item_total
    type: number
    decimals: 2
    sql:  ${TABLE}.return_item_total
    format: "%0.2f"

  - dimension: amount_refunded
    type: number
    decimals: 2
    sql:  ${TABLE}.amount_refunded
    format: "%0.2f"

  - dimension: store_credit_refunded
    type: number
    decimals: 2
    sql:  ${TABLE}.store_credit_refunded
    format: "%0.2f"

  - dimension: cash_refunded
    type: number
    decimals: 2
    sql:  ${TABLE}.cash_refunded
    format: "%0.2f"


    
#################################################################################################################################################################################
####################################################### MEASURES ################################################################################################################
#################################################################################################################################################################################

################################################## BASIC ORDER MEASURES ################################################################
  
  - measure: count_orders
    type: count_distinct
    sql: ${TABLE}.order_id
    filters:
      state: -canceled

  - measure: count_orders_inc_cancelled
    type: count_distinct
    sql: ${TABLE}.order_id
    
  - measure: cancellation_rate
    type: number
    decimals: 2
    sql: 100.0 * (1 - (${count_orders})/${count_orders_inc_cancelled}::REAL)
    format: "%0.2f%"

  - measure: orders_with_returns
    type: count_distinct
    sql: ${TABLE}.order_id
    filters:
      items_returned: -0, -NULL
  
  - measure: count_customers
    type: count_distinct
    sql: ${TABLE}.customer_id
    filters:
      state: -canceled
  
  - measure: total_items
    type: sum
    sql: ${TABLE}.item_count
    filters:
      state: -canceled
  
  - measure: avg_items_in_basket
    type: number
    decimals: 2
    sql: ${total_items}/${count_orders}::REAL
    format: "%0.2f"

################################################# GROSS REVENUE MEASURES ##############################################################

  - measure: sum_gross_revenue
    type: sum
    sql: ${TABLE}.item_total + ${TABLE}.shipment_total
    format: "%0.2f"
    filters:
      state: -canceled
  
  - measure: sum_gross_revenue_in_gbp
    type: sum
    sql: (${TABLE}.item_total + ${TABLE}.shipment_total)*${TABLE}.exchange_rate
    format: "£%0.2f"
    filters:
      state: -canceled

  - measure: sum_gross_revenue_ex_vat
    type: sum
    sql: (${TABLE}.item_total*5/6) + ${TABLE}.shipment_total
    format: "%0.2f"
    filters:
      state: -canceled
  
  - measure: sum_gross_revenue_in_gbp_ex_vat
    type: sum
    sql: ((${TABLE}.item_total*5/6) + ${TABLE}.shipment_total)*${TABLE}.exchange_rate
    format: "£%0.2f"
    filters:
      state: -canceled
  
  - measure: sum_gross_revenue_inc_canceled
    type: sum
    sql: ${TABLE}.item_total + ${TABLE}.shipment_total
    format: "%0.2f"
  
  - measure: sum_gross_revenue_in_gbp_inc_canceled
    type: sum
    sql: (${TABLE}.item_total + ${TABLE}.shipment_total)*${TABLE}.exchange_rate
    format: "£%0.2f"

################################################# DISCOUNT/STORE CREDIT MEASURES ##############################################################

  - measure: sum_total_discount
    type: sum
    sql: ${TABLE}.adjustment_total * (-1)
    format: "%0.2f"
    filters:
      state: -canceled

  - measure: sum_total_discount_gbp
    type: sum
    sql: ${TABLE}.adjustment_total * (-1) * ${TABLE}.exchange_rate
    format: "£%0.2f"
    filters:
      state: -canceled
  
  - measure: sum_store_credit_used
    type: sum
    sql: ${TABLE}.store_credit_used
    format: "%0.2f"
    filters:
      state: -canceled
  
  - measure: sum_store_credit_used_gbp
    type: sum
    sql: ${TABLE}.store_credit_used * ${TABLE}.exchange_rate
    format: "£%0.2f"
    filters:
      state: -canceled

  - measure: sum_total_discount_ex_vat
    type: sum
    sql: ${TABLE}.adjustment_total * (-1) * 5/6
    format: "%0.2f"
    filters:
      state: -canceled

  - measure: sum_total_discount_gbp_ex_vat
    type: sum
    sql: ${TABLE}.adjustment_total * (-1) * ${TABLE}.exchange_rate  *5/6
    format: "£%0.2f"
    filters:
      state: -canceled
  
  - measure: sum_store_credit_used_ex_vat
    type: sum
    sql: ${TABLE}.store_credit_used*5/6
    format: "%0.2f"
    filters:
      state: -canceled
  
  - measure: sum_store_credit_used_gbp_ex_vat
    type: sum
    sql: ${TABLE}.store_credit_used * ${TABLE}.exchange_rate*5/6
    format: "£%0.2f"
    filters:
      state: -canceled

################################################ GROSS REVENUE EX DISCOUNT/STORE CREDIT MEASURES ##############################################################


  - measure: sum_gross_revenue_ex_discount
    type: sum
    sql: ${TABLE}.item_total + ${TABLE}.shipment_total - (${TABLE}.adjustment_total * (-1))
    format: "%0.2f"
    filters:
      state: -canceled
  
  - measure: sum_gross_revenue_ex_discount_in_gbp
    type: sum
    sql: (${TABLE}.item_total + ${TABLE}.shipment_total - (${TABLE}.adjustment_total * (-1)) ) * ${TABLE}.exchange_rate
    format: "£%0.2f"
    filters:
      state: -canceled

  - measure: sum_gross_revenue_ex_discount_ex_vat
    type: sum
    sql: ((${TABLE}.item_total- (${TABLE}.adjustment_total * (-1)) )*5/6)  + ${TABLE}.shipment_total 
    format: "%0.2f"
    filters:
      state: -canceled
  
  - measure: sum_gross_revenue_ex_discount_in_gbp_ex_vat
    type: sum
    sql: (((${TABLE}.item_total- (${TABLE}.adjustment_total * (-1)) )*5/6)  + ${TABLE}.shipment_total)  * ${TABLE}.exchange_rate
    format: "£%0.2f"
    filters:
      state: -canceled

  - measure: sum_gross_revenue_ex_discount_and_store_credit
    type: sum
    sql: ${TABLE}.item_total + ${TABLE}.shipment_total - (${TABLE}.adjustment_total * (-1)) - ${TABLE}.store_credit_used
    format: "%0.2f"
    filters:
      state: -canceled
  
  - measure: sum_gross_revenue_ex_discount_and_store_credit_in_gbp
    type: sum
    sql: (${TABLE}.item_total + ${TABLE}.shipment_total - (${TABLE}.adjustment_total * (-1)) - ${TABLE}.store_credit_used)  * ${TABLE}.exchange_rate
    format: "£%0.2f"
    filters:
      state: -canceled

  - measure: sum_gross_revenue_ex_discount_and_store_credit_ex_vat
    type: sum
    sql: ((${TABLE}.item_total - (${TABLE}.adjustment_total * (-1)) - ${TABLE}.store_credit_used)*5/6) + ${TABLE}.shipment_total
    format: "%0.2f"
    filters:
      state: -canceled
  
  - measure: sum_gross_revenue_ex_discount_and_store_credit_in_gbp_ex_vat
    type: sum
    sql: (((${TABLE}.item_total - (${TABLE}.adjustment_total * (-1)) - ${TABLE}.store_credit_used)*5/6) + ${TABLE}.shipment_total)  * ${TABLE}.exchange_rate
    format: "£%0.2f"
    filters:
      state: -canceled


############################ OTHER GROSS REVENUE SUMS ###################################################################################################

  - measure: sum_total_of_items
    type: sum
    sql: ${TABLE}.item_total
    format: "%0.2f"
    filters:
      state: -canceled

  - measure: sum_total_of_items_gbp
    type: sum
    sql: ${TABLE}.item_total * ${TABLE}.exchange_rate
    format: "£%0.2f"
    filters:
      state: -canceled

  - measure: sum_shipping_total
    type: sum
    sql: ${TABLE}.shipment_total
    format: "%0.2f"
    filters:
      state: -canceled

  - measure: sum_shipping_total_gbp
    type: sum
    sql: ${TABLE}.shipment_total * ${TABLE}.exchange_rate
    format: "£%0.2f"
    filters:
      state: -canceled

  ############################################################## REVENUE AVERAGES ##############################################################################

  - measure: avg_gross_revenue_gbp
    type: number
    decimals: 2
    sql: ${sum_gross_revenue_in_gbp}/NULLIF(${count_orders},0)::REAL
    format: "£%0.2f"
      
  - measure: avg_gross_revenue_ex_discount_in_gbp
    type: number
    decimals: 2
    sql: ${sum_gross_revenue_ex_discount_in_gbp}/NULLIF(${count_orders},0)::REAL
    format: "£%0.2f"
    
  - measure: avg_gross_revenue_ex_discount_and_store_credit_in_gbp
    type: number
    decimals: 2
    sql: ${sum_gross_revenue_ex_discount_and_store_credit_in_gbp}/NULLIF(${count_orders},0)::REAL
    format: "£%0.2f"
    
  - measure: avg_gross_revenue_gbp_ex_vat
    type: number
    decimals: 2
    sql: ${sum_gross_revenue_in_gbp_ex_vat}/NULLIF(${count_orders},0)::REAL
    format: "£%0.2f"
      
  - measure: avg_gross_revenue_ex_discount_in_gbp_ex_vat
    type: number
    decimals: 2
    sql: ${sum_gross_revenue_ex_discount_in_gbp_ex_vat}/NULLIF(${count_orders},0)::REAL
    format: "£%0.2f"
    
  - measure: avg_gross_revenue_ex_discount_and_store_credit_in_gbp_ex_vat
    type: number
    decimals: 2
    sql: ${sum_gross_revenue_ex_discount_and_store_credit_in_gbp_ex_vat}/NULLIF(${count_orders},0)::REAL
    format: "£%0.2f"

  - measure: avg_discount_in_gbp
    type: number
    decimals: 2
    sql: ${sum_total_discount_gbp}/NULLIF(${count_orders},0)::REAL
    format: "£%0.2f"

  - measure: avg_discount_in_gbp_ex_vat
    type: number
    decimals: 2
    sql: ${sum_total_discount_gbp_ex_vat}/NULLIF(${count_orders},0)::REAL
    format: "£%0.2f"

  - measure: avg_store_credit_used_gbp
    type: number
    decimals: 2
    sql: ${sum_store_credit_used_gbp}/NULLIF(${count_orders},0)::REAL
    format: "£%0.2f"
    
  - measure: avg_store_credit_used_gbp_ex_vat
    type: number
    decimals: 2
    sql: ${sum_store_credit_used_gbp_ex_vat}/NULLIF(${count_orders},0)::REAL
    format: "£%0.2f"

############################################################## RETURNS MEASUERS #############################################################################################

  - measure: sum_items_returned
    type: sum
    sql: ${items_returned}
    filters:
      state: -canceled

  - measure: sum_return_item_total
    type: sum
    sql: ${return_item_total}
    format: "%0.2f"
    filters:
      state: -canceled

  - measure: sum_return_item_total_gbp
    type: sum
    sql: ${return_item_total} * ${exchange_rate}
    format: "£%0.2f"
    filters:
      state: -canceled

  - measure: sum_amount_refunded
    type: sum
    sql: ${amount_refunded}
    format: "%0.2f"
    filters:
      state: -canceled
    
  - measure: sum_amount_refunded_gbp
    type: sum
    sql: ${amount_refunded} * ${exchange_rate}
    format: "£%0.2f"
    filters:
      state: -canceled
  
  - measure: sum_cash_refunded
    type: sum
    sql: ${cash_refunded}
    format: "%0.2f"
    filters:
      state: -canceled
    
  - measure: sum_cash_refunded_gbp
    type: sum
    sql: ${cash_refunded} * ${exchange_rate}
    format: "£%0.2f"
    filters:
      state: -canceled
      
  - measure: sum_store_credit_refunded
    type: sum
    sql: ${store_credit_refunded}
    format: "%0.2f"
    filters:
      state: -canceled
    
  - measure: sum_store_credit_refunded_gbp
    type: sum
    sql: ${store_credit_refunded} * ${exchange_rate}
    format: "£%0.2f"
    filters:
      state: -canceled


############################################################## NET REVENUE MEASURES (POST RETURNS) #############################################################################################
  
  - measure: sum_net_revenue
    type: sum
    sql: ${item_total} + ${shipping_total} - ${return_item_total}
    format: "%0.2f"
    filters:
      state: -canceled  
  
  - measure: sum_net_revenue_gbp
    type: sum
    sql: (${item_total} + ${shipping_total} - ${return_item_total}) * ${exchange_rate}
    format: "£%0.2f"
    filters:
      state: -canceled
      
  - measure: sum_net_revenue_ex_vat
    type: sum
    sql: ((${item_total} - ${return_item_total})*5/6) + ${shipping_total}
    format: "%0.2f"
    filters:
      state: -canceled  
  
  - measure: sum_net_revenue_gbp_ex_vat
    type: sum
    sql: (((${item_total} - ${return_item_total})*5/6) + ${shipping_total}) * ${exchange_rate}
    format: "£%0.2f"
    filters:
      state: -canceled

  - measure: sum_net_revenue_ex_discount
    type: sum
    sql: ${item_total} - ${discount} - ${amount_refunded} + ${shipping_total}
    format: "%0.2f"
    filters:
      state: -canceled
      
  - measure: sum_net_revenue_ex_discount_gbp
    type: sum
    sql: (${item_total} - ${discount} - ${amount_refunded} + ${shipping_total}) * ${exchange_rate}
    format: "£%0.2f"
    filters:
      state: -canceled

  - measure: sum_net_revenue_ex_discount_ex_vat
    type: sum
    sql: ((${item_total} - ${discount} - ${amount_refunded})*5/6) + ${shipping_total}
    format: "%0.2f"
    filters:
      state: -canceled
      
  - measure: sum_net_revenue_ex_discount_gbp_ex_vat
    type: sum
    sql: (((${item_total} - ${discount} - ${amount_refunded})*5/6) + ${shipping_total}) * ${exchange_rate}
    format: "£%0.2f"
    filters:
      state: -canceled

  - measure: sum_net_revenue_ex_discount_ex_store_credit
    type: sum
    sql: ${item_total} - ${discount} - ${amount_refunded}  - ${store_credit_used} + ${store_credit_refunded} + ${shipping_total}
    format: "%0.2f"
    filters:
      state: -canceled
  
  - measure: sum_net_revenue_ex_discount_ex_store_credit_gbp
    type: sum
    sql: (${item_total} - ${discount} - ${amount_refunded}  - ${store_credit_used} + ${store_credit_refunded} + ${shipping_total}) * ${exchange_rate}
    format: "£%0.2f"
    filters:
      state: -canceled
  
  
  - measure: sum_net_revenue_ex_discount_ex_store_credit_ex_vat
    type: sum
    sql: ((${item_total} - ${discount} - ${amount_refunded}  - ${store_credit_used} + ${store_credit_refunded})*5/6) + ${shipping_total}
    format: "%0.2f"
    filters:
      state: -canceled
  
  - measure: sum_net_revenue_ex_discount_ex_store_credit_gbp_ex_vat
    type: sum
    sql: (((${item_total} - ${discount} - ${amount_refunded}  - ${store_credit_used} + ${store_credit_refunded})*5/6) + ${shipping_total}) * ${exchange_rate}
    format: "£%0.2f"
    filters:
      state: -canceled


  
  
 