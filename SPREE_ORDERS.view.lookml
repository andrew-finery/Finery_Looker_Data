- view: spree_orders
  derived_table:
    sql: |
     SELECT  a.spree_timestamp,
             a.id AS order_id,
             a. "number" AS order_code,
             a.user_id AS customer_id,
             a.bill_address_id,
             a.ship_address_id,
             a.item_total,
             a.total AS order_total,
             a.state,
             adjustment_total,
             shipment_total,
             shipments.name as shipping_method,
             shipments.tracking as tracking_number,
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
    timeframes: [time, date, week, month]
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

  - dimension: shipping_method
    sql: ${TABLE}.shipping_method

  - dimension: tracking_number
    type: string
    sql: ${TABLE}.tracking_number || 'a'

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


  
  
 