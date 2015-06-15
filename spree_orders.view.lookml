- view: spree_orders
  derived_table:
    sql: |
     SELECT  a.spree_timestamp,
             a.id AS order_id,
             case when in_store_orders.order_id is not null then 1 else 0 end as in_store_flag,
             a. "number" AS order_code,
             promo_codes.promotion,
             a.user_id AS customer_id,
             a.email as email,
             lower(coalesce(users.email_address, a.email)) as blended_email,
             order_sequence.order_sequence_number,
             order_sequence.latest_order_id,
             a.bill_address_id,
             a.ship_address_id,
             ship_add.country_id,
             a.item_total,
             a.total AS order_total,
             case when voids.order_id is not null then 'canceled' else a.state end as state,
             adjustment_total,
             shipment_total,
             shipments.shipment_number,
             shipments.name as shipping_method,
             shipments.shipped_at_date,
             shipments.tracking as tracking_number,
             shipments.consignee,
             shipments.name as delivery_type,
             exchange_rates.rate as exchange_rate,
             tax_rates.amount as tax_rate,
             a.included_tax_total,
             a.additional_tax_total,
             convert_timezone('UTC', 'Europe/London', a.completed_at) as completed_at,
             a.currency,
             a.item_count,
             COALESCE(b.store_credit,'0') AS store_credit_used,
             COALESCE(d.return_item_total,'0') AS return_item_total,
             COALESCE(d.items_returned,'0') AS items_returned,
             COALESCE(e.amount_refunded,'0') AS amount_refunded,
             COALESCE(e.store_credit_refunded,'0') AS store_credit_refunded,
             COALESCE(e.cash_refunded,'0') AS cash_refunded,
             
             CASE WHEN (b.store_credit = a.item_total + adjustment_total) then 'Store Credit'
                  WHEN credit_card_payments.order_id is not null then 'Credit Card'
                  ELSE 'Paypal' end as primary_payment_method,
            
             distinct_products.number_of_skus,
             distinct_products.number_of_products
             
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
                    AND   state in ('void', 'checkout')
                    GROUP BY 1) voids ON voids.order_id = a.id
        
        LEFT JOIN (SELECT aaa.order_id,
                          SUM(bbb.price) AS return_item_total,
                          COUNT(*) AS items_returned
                   FROM ${spree_returns.SQL_TABLE_NAME} aaa
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
                   
        LEFT JOIN
        (SELECT order_id
        FROM (SELECT *
              FROM daily_snapshot.spree_payments
              WHERE spree_timestamp = (SELECT MAX(spree_timestamp)
                                       FROM daily_snapshot.spree_payments))
        WHERE payment_method_id = 4
        GROUP BY 1) in_store_orders
        on in_store_orders.order_id = a.id
        
        LEFT JOIN
        (SELECT orders_promotions.order_id
        FROM (SELECT *
              FROM daily_snapshot.spree_orders_promotions
              WHERE spree_timestamp = (SELECT MAX(spree_timestamp)
                                       FROM daily_snapshot.spree_orders_promotions)) orders_promotions
          LEFT JOIN (SELECT *
                     FROM daily_snapshot.spree_promotions
                     WHERE spree_timestamp = (SELECT MAX(spree_timestamp)
                                              FROM daily_snapshot.spree_promotions)) promotions ON orders_promotions.promotion_id = promotions.id
        WHERE promotions.code IN ('finerymerch1!','finerycare1!','pressdiscount1!')
        GROUP BY 1) orders_to_strip_out
        on orders_to_strip_out.order_id = a.id
        
        LEFT JOIN (select id, last_value(id) over (partition by coalesce(cast(user_id as varchar), lower(email)) order by completed_at asc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as latest_order_id, rank() over (partition by coalesce(cast(user_id as varchar), lower(email)) order by completed_at asc) as order_sequence_number from daily_snapshot.spree_orders where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_orders) and state IN ('complete','returned') and created_at > date '2014-11-22') order_sequence
        on order_sequence.id = a.id
        
        LEFT JOIN (SELECT spree_shipments.order_id,
                          orders_to_shipments.shipment_number,
                           spree_shipments.tracking,
                           spree_shipments. "number",
                           spree_shipments.consignee,
                           date(spree_shipments.shipped_at) - 1 as shipped_at_date,
                           spree_shipping_methods.name,
                           spree_shipping_methods.admin_name,
                           spree_shipping_methods.carrier_description
                    FROM (select order_id, shipment_id, shipment_number from
                          (SELECT order_id, last_value(id) over (partition by order_id order by updated_at asc rows between unbounded preceding and unbounded following) as shipment_id, last_value("number") over (partition by order_id order by updated_at asc rows between unbounded preceding and unbounded following) as shipment_number
                          FROM daily_snapshot.spree_shipments WHERE spree_timestamp = (SELECT MAX(spree_timestamp) FROM daily_snapshot.spree_shipments)) group by 1,2,3) orders_to_shipments
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
      
      LEFT JOIN (select id, country_id from daily_snapshot.spree_addresses where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_addresses)) ship_add
      on ship_add.id = a.ship_address_id
      
      LEFT JOIN ${spree_exchange_rates.SQL_TABLE_NAME} exchange_rates
      on exchange_rates.calendar_date = date(a.completed_at)
      and exchange_rates.currency = a.currency
      
      LEFT JOIN ${spree_tax_rates.SQL_TABLE_NAME} tax_rates
      on tax_rates.calendar_date = date(a.completed_at)
      and tax_rates.country_id = ship_add.country_id
      
      LEFT JOIN ${spree_users.SQL_TABLE_NAME} users
      on users.user_id = a.user_id
      
      LEFT JOIN (select order_id, max(label) as promotion from daily_snapshot.spree_adjustments
                  where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_adjustments)
                  and source_type = 'Spree::PromotionAction'
                  and eligible = 1
                  group by 1) promo_codes
                  on promo_codes.order_id = a.id
                  
      
      LEFT JOIN (SELECT order_id FROM (SELECT * FROM daily_snapshot.spree_payments WHERE spree_timestamp = (SELECT MAX(spree_timestamp) FROM daily_snapshot.spree_payments))
                WHERE source_type = 'Spree::CreditCard' GROUP BY 1) credit_card_payments
                on credit_card_payments.order_id = a.id
      
      LEFT JOIN (select
                line_items.order_id,
                sum(line_items.quantity) as number_of_items,
                count(distinct line_items.variant_id) as number_of_skus,
                count(distinct variants.product_id) as number_of_products
                from
                (select * from daily_snapshot.spree_line_items where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_line_items)) line_items
                left join 
                (select * from daily_snapshot.spree_variants where spree_timestamp = (select max(spree_timestamp) from daily_snapshot.spree_variants)) variants
                on line_items.variant_id = variants.id
                group by 1) distinct_products
                on distinct_products.order_id = a.id
                            
      WHERE a.state IN ('complete','returned','canceled')
      AND   a.completed_at > DATE '2014-11-22'
      AND orders_to_strip_out.order_id is null
      AND a.email not like '%shaun+cml%'

    
    sql_trigger_value: SELECT max(spree_timestamp) FROM ${spree_tax_rates.SQL_TABLE_NAME}
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
    hidden: true

  - dimension_group: completed
    label: Order
    type: time
    timeframes: [time, date, hour_of_day, week, month, time_of_day, day_of_week_index, day_of_week, day_of_month]
    sql: ${TABLE}.completed_at

  - dimension: item_count
    label: ITEMS IN ORDER
    type: int
    sql: ${TABLE}.item_count

  - dimension: order_code
    label: ORDER CODE
    sql: ${TABLE}.order_code

  - dimension: primary_payment_method
    label: PRIMARY PAYMENT METHOD
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
    label: EMAIL
    sql: ${TABLE}.email
  
  - dimension: in_store_flag
    label: IN STORE FLAG
    sql_case:
      In-Store: ${TABLE}.in_store_flag = 1
      else: Online

# Shipping Dimensions

  - dimension: shipping_method
    label: DELIVERY METHOD
    sql: ${TABLE}.shipping_method

  - dimension: shipment_number
    label: SHIPMENT NUMBER
    sql: ${TABLE}.shipment_number

  - dimension: tracking_number
    label: TRACKING NUMBER
    type: string
    sql: ${TABLE}.tracking_number || 'a'

  - dimension: tracking_link
    label: HERMES TRACKING LINK
    type: string
    sql: ${TABLE}.tracking_number
    html: |
        <a href="http://www.hermes-europe.co.uk/customerparceltrackingservice/trackingDetailsHermes.jsp?barcode={{value}}">{{value}}</a>

  - dimension_group: shipped_at
    label: SHIPPED
    type: time
    timeframes: [date, day_of_week_index]
    sql: ${TABLE}.shipped_at_date
  
  - dimension: delivery_company
    label: DELIVERY COMPANY
    sql: ${TABLE}.consignee
  
  - dimension: delivery_type
    label: DELIVERY TYPE
    sql: ${TABLE}.delivery_type
  
  - dimension: tracking_info_available
    label: TRACKING INFO AVAILABLE FLAG
    type: yesno
    sql: ${tracking_number} <> 'a'

  - dimension: delivered_flag
    label: DELIEVRED FLAG
    type: yesno
    sql: |
        ${hermes_delivery_tracking.delivery_confirmed_time_time} is not null
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
        
        when ${hermes_delivery_tracking.latest_event_time_date} is null and ${tracking_number} = 'a' then 'No Tracking Info - Warehouse'
        
        when (${expected_delivery_date} >= current_date or ${expected_delivery_date_hermes} >= current_date) and ${hermes_delivery_tracking.delivery_confirmed_time_time} is null then 'Parcel to be Delivered'
        
        when ${hermes_delivery_tracking.latest_event_time_date} is null then 'No Tracking Info - Hermes'
        
        when ${hermes_delivery_tracking.delivery_confirmed_time_time} is null and ${hermes_delivery_tracking.return_confirmed_time_time} is null and ${expected_delivery_date} < current_date - 14 then 'Parcel Lost by Hermes'
        
        when ${hermes_delivery_tracking.first_attempt_time_date} is null then 'Parcel Currently Late - Not Delivered'
        
        when ${hermes_delivery_tracking.first_attempt_time_date} > ${expected_delivery_date_hermes} and ${hermes_delivery_tracking.first_attempt_time_date} > ${expected_delivery_date} and ${hermes_delivery_tracking.first_attempt_time_date} is not null
        and ${hermes_delivery_tracking.misrouted_date} is not null then 'Misrouted to Incorrect Depot'
        
        when ${hermes_delivery_tracking.first_attempt_time_date} > ${expected_delivery_date_hermes} and ${hermes_delivery_tracking.first_attempt_time_date} > ${expected_delivery_date} and ${hermes_delivery_tracking.first_attempt_time_date} is not null
        and ${hermes_delivery_tracking.missort_date} is not null then 'Missort to Incorrect Courier'
        
        when ${hermes_delivery_tracking.first_attempt_time_date} > ${expected_delivery_date_hermes} and ${hermes_delivery_tracking.first_attempt_time_date} > ${expected_delivery_date} and ${hermes_delivery_tracking.first_attempt_time_date} is not null
        and ${hermes_delivery_tracking.more_info_required_date} is not null then 'More Info Required'
        
        when ${hermes_delivery_tracking.first_attempt_time_date} > ${expected_delivery_date_hermes} and ${hermes_delivery_tracking.first_attempt_time_date} > ${expected_delivery_date} and ${hermes_delivery_tracking.first_attempt_time_date} is not null
        and ${hermes_delivery_tracking.carried_forward_date} is not null then 'Carried Forward'
        
        when ${hermes_delivery_tracking.first_attempt_time_date} > ${expected_delivery_date_hermes} and ${hermes_delivery_tracking.first_attempt_time_date} > ${expected_delivery_date} and ${hermes_delivery_tracking.first_attempt_time_date} is not null
        and ${hermes_delivery_tracking.delay_date} is not null then 'Hermes Delay'
        
        when ${hermes_delivery_tracking.first_attempt_time_date} > ${expected_delivery_date_hermes} and ${hermes_delivery_tracking.first_attempt_time_date} > ${expected_delivery_date} and ${hermes_delivery_tracking.first_attempt_time_date} is not null
        and ${hermes_delivery_tracking.hub_received_date} > ${completed_date} + 1 then 'Late to Hub'
        
        when ${hermes_delivery_tracking.first_attempt_time_date} > ${expected_delivery_date_hermes} and ${hermes_delivery_tracking.first_attempt_time_date} > ${expected_delivery_date} and ${hermes_delivery_tracking.first_attempt_time_date} is not null
        and ${hermes_delivery_tracking.depot_received_date} > ${completed_date} + 2 then 'Late to Depot'
        
        when ${hermes_delivery_tracking.first_attempt_time_date} > ${expected_delivery_date_hermes} and ${hermes_delivery_tracking.first_attempt_time_date} > ${expected_delivery_date} and ${hermes_delivery_tracking.first_attempt_time_date} is not null
        and ${hermes_delivery_tracking.out_for_delivery_date} > ${expected_delivery_date_hermes} and ${hermes_delivery_tracking.out_for_delivery_date} > ${expected_delivery_date} then 'Delay at Depot'
        
        when ${hermes_delivery_tracking.first_attempt_time_date} > ${expected_delivery_date_hermes} and ${hermes_delivery_tracking.first_attempt_time_date} > ${expected_delivery_date} and ${hermes_delivery_tracking.first_attempt_time_date} is not null
        and ${hermes_delivery_tracking.courier_received_date} > ${expected_delivery_date_hermes} and ${hermes_delivery_tracking.courier_received_date} > ${expected_delivery_date} then 'Delay in Courier Receiving Package'
        
        when ${hermes_delivery_tracking.first_attempt_time_date} > ${expected_delivery_date_hermes} and ${hermes_delivery_tracking.first_attempt_time_date} > ${expected_delivery_date} and ${hermes_delivery_tracking.first_attempt_time_date} is not null
        and ${hermes_delivery_tracking.delay_date} is not null then 'Missing Pre-Advice'
        
        when ${hermes_delivery_tracking.first_attempt_time_date} > ${expected_delivery_date_hermes} and ${hermes_delivery_tracking.first_attempt_time_date} > ${expected_delivery_date} and ${hermes_delivery_tracking.first_attempt_time_date} is not null
        then 'Late - Other Reason'
        
        else 'Delivered On Time' end

  - dimension: returned_flag
    type: yesno
    sql: ${hermes_delivery_tracking.return_confirmed_time_time} is not null  
    
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
    label: EXPECTED DELIVERY
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

  - dimension: london_flag
    label: London Flag
    sql: ${spree_addresses.london_flag}

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
    value_format: '"£"##0.00'


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
    value_format: '"£"#,##0.00'
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
    value_format: '"£"#,##0.00'
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
    value_format: '"£"#,##0.00'

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
    label: SUM DISCOUNT
    type: sum
    sql: ${TABLE}.adjustment_total * (-1) / ${exchange_rate}
    decimals: 2
    value_format: '"£"#,##0.00'
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
    label: SUM STORE CREDIT
    type: sum
    sql: ${TABLE}.store_credit_used / ${exchange_rate}
    decimals: 2
    value_format: '"£"#,##0.00'
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
    label: SUM DISCOUNT EX. VAT
    type: sum
    sql: ${TABLE}.adjustment_total * (-1) * ${exchange_rate}  *(1/(1+${tax_rate}))
    decimals: 2
    value_format: '"£"#,##0.00'
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
    label: SUM STORE CREDIT EX. VAT
    type: sum
    sql: ${TABLE}.store_credit_used / ${exchange_rate} * (1/(1+${tax_rate}))
    decimals: 2
    value_format: '"£"#,##0.00'
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
    label: SUM GROSS REVENUE EX. DISCOUNT
    type: sum
    sql: (${TABLE}.item_total + ${TABLE}.shipment_total - (${TABLE}.adjustment_total * (-1)) ) / ${exchange_rate}
    decimals: 2
    value_format: '"£"#,##0.00'
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
    label: SUM GROSS REVENUE EX. DISCOUNT, VAT
    type: sum
    sql: (((${TABLE}.item_total- (${TABLE}.adjustment_total * (-1)) )*(1/(1+${tax_rate})))  + ${TABLE}.shipment_total)  / ${exchange_rate}
    decimals: 2
    value_format: '"£"#,##0.00'
    filters:
      state: -canceled

  - measure: sum_gross_revenue_ex_discount_in_gbp_ex_vat_in_k
    label: SUM GROSS REVENUE EX. DISCOUNT, VAT (K)
    type: sum
    sql: (((${TABLE}.item_total- (${TABLE}.adjustment_total * (-1)) )*(1/(1+${tax_rate})))  + ${TABLE}.shipment_total) / ${exchange_rate} / 1000
    decimals: 2
    format: "£%0.1fk"
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
    label: SUM GROSS REVENUE EX. DISCOUNT, STORE CREDIT
    type: sum
    sql: (${TABLE}.item_total + ${TABLE}.shipment_total - (${TABLE}.adjustment_total * (-1)) - ${TABLE}.store_credit_used)  / ${exchange_rate}
    decimals: 2
    value_format: '"£"#,##0.00'
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
    label: SUM GROSS REVENUE EX. DISCOUNT, STORE CREDIT, VAT
    type: sum
    sql: (((${TABLE}.item_total - (${TABLE}.adjustment_total * (-1)) - ${TABLE}.store_credit_used)*(1/(1+${tax_rate}))) + ${TABLE}.shipment_total)  / ${exchange_rate}
    decimals: 2
    value_format: '"£"#,##0.00'
    filters:
      state: -canceled

################################################# GROSS REVENUE MEASURES EXCLUDING SHIPPING ############################################################

  - measure: sum_gross_revenue_ex_discount_in_gbp_ex_vat_ex_shipping
    label: Gross Revenue (ex. VAT, Discount, Shipping)
    type: sum
    sql: ((${TABLE}.item_total- (${TABLE}.adjustment_total * (-1)) )*(1/(1+${tax_rate})))  / ${exchange_rate}
    decimals: 2
    value_format: '"£"#,##0.00'
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
    format: "£%0.1fk"
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
    value_format: '"£"#,##0.00'
  
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
    value_format: '"£"#,##0'

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
    label: SUM TOTAL ITEM VALUE
    type: sum
    sql: ${TABLE}.item_total / ${exchange_rate}
    decimals: 2
    value_format: '"£"#,##0.00'
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
    label: SUM SHIPPING REVENUE
    type: sum
    sql: ${TABLE}.shipment_total / ${exchange_rate}
    decimals: 2
    value_format: '"£"#,##0.00'
    filters:
      state: -canceled

  ############################################################## REVENUE AVERAGES ##############################################################################

  - measure: avg_gross_revenue_gbp
    label: AVERAGE BASKET SIZE
    type: number
    decimals: 2
    sql: ${sum_gross_revenue_in_gbp}/NULLIF(${count_orders},0)::REAL
    value_format: '"£"#,##0.00'
      
  - measure: avg_gross_revenue_ex_discount_in_gbp
    label: AVERAGE BASKET SIZE EX. DISCOUNT
    type: number
    decimals: 2
    sql: ${sum_gross_revenue_ex_discount_in_gbp}/NULLIF(${count_orders},0)::REAL
    value_format: '"£"#,##0.00'
    
  - measure: avg_gross_revenue_ex_discount_and_store_credit_in_gbp
    label: AVERAGE BASKET SIZE EX. DISCOUNT, STORE CREDIT
    type: number
    decimals: 2
    sql: ${sum_gross_revenue_ex_discount_and_store_credit_in_gbp}/NULLIF(${count_orders},0)::REAL
    value_format: '"£"#,##0.00'
    
  - measure: avg_gross_revenue_gbp_ex_vat
    label: AVERAGE BASKET SIZE EX. VAT
    type: number
    decimals: 2
    sql: ${sum_gross_revenue_in_gbp_ex_vat}/NULLIF(${count_orders},0)::REAL
    value_format: '"£"#,##0.00'
      
  - measure: avg_gross_revenue_ex_discount_in_gbp_ex_vat
    label: AVERAGE BASKET SIZE EX. DISCOUNT, VAT
    type: number
    decimals: 2
    sql: ${sum_gross_revenue_ex_discount_in_gbp_ex_vat}/NULLIF(${count_orders},0)::REAL
    value_format: '"£"#,##0.00'
    
  - measure: avg_gross_revenue_ex_discount_and_store_credit_in_gbp_ex_vat
    label: AVERAGE BASKET SIZE EX. DISCOUNT, STORE CREDIT, VAT
    type: number
    decimals: 2
    sql: ${sum_gross_revenue_ex_discount_and_store_credit_in_gbp_ex_vat}/NULLIF(${count_orders},0)::REAL
    value_format: '"£"#,##0.00'

  - measure: avg_discount_in_gbp
    label: AVERAGE DISCOUNT VALUE
    type: number
    decimals: 2
    sql: ${sum_total_discount_gbp}/NULLIF(${count_orders},0)::REAL
    value_format: '"£"#,##0.00'

  - measure: avg_discount_in_gbp_ex_vat
    label: AVERAGE DISCOUNT EX. VAT
    type: number
    decimals: 2
    sql: ${sum_total_discount_gbp_ex_vat}/NULLIF(${count_orders},0)::REAL
    value_format: '"£"#,##0.00'

  - measure: avg_store_credit_used_gbp
    label: AVERAGE STORE CREDIT USED
    type: number
    decimals: 2
    sql: ${sum_store_credit_used_gbp}/NULLIF(${count_orders},0)::REAL
    value_format: '"£"#,##0.00'
    
  - measure: avg_store_credit_used_gbp_ex_vat
    label: AVERAGE STORE CREDIT USED EX. VAT
    type: number
    decimals: 2
    sql: ${sum_store_credit_used_gbp_ex_vat}/NULLIF(${count_orders},0)::REAL
    value_format: '"£"#,##0.00'

############################################################## RETURNS MEASUERS #############################################################################################

  - measure: sum_items_returned
    label: SUM ITEMS RETURNED
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
    label: SUM RETURN ITEM TOTAL
    type: sum
    sql: ${return_item_total} / ${exchange_rate}
    decimals: 2
    value_format: '"£"#,##0.00'
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
    label: SUM TOTAL AMOUNT REFUNDED
    type: sum
    sql: ${amount_refunded} / ${exchange_rate}
    decimals: 2
    value_format: '"£"#,##0.00'
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
    label: SUM CASH REFUNDED
    type: sum
    sql: ${cash_refunded} / ${exchange_rate}
    decimals: 2
    value_format: '"£"#,##0.00'
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
    label: SUM STORE CERDIT REFUNDED
    type: sum
    sql: ${store_credit_refunded} / ${exchange_rate}
    decimals: 2
    value_format: '"£"#,##0.00'
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
    label: SUM NET REVENUE
    type: sum
    sql: (${item_total} + ${shipping_total} - ${return_item_total}) / ${exchange_rate}
    decimals: 2
    value_format: '"£"#,##0.00'
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
    label: SUM NET REVENUE EX. VAT
    type: sum
    sql: (((${item_total} - ${return_item_total})*(1/(1+${tax_rate}))) + ${shipping_total}) / ${exchange_rate}
    decimals: 2
    value_format: '"£"#,##0.00'
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
    label: SUM NET REVENUE EX. DISCOUNT
    type: sum
    sql: (${item_total} - ${discount} - ${amount_refunded} + ${shipping_total}) / ${exchange_rate}
    decimals: 2
    value_format: '"£"#,##0.00'
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
    label: SUM NET REVENUE EX. DISCOUNT, VAT
    type: sum
    sql: (((${item_total} - ${discount} - ${amount_refunded})*(1/(1+${tax_rate}))) + ${shipping_total}) / ${exchange_rate}
    decimals: 2
    value_format: '"£"#,##0.00'
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
    label: SUM NET REVENUE EX. DISCOUNT, STORE CREDIT
    type: sum
    sql: (${item_total} - ${discount} - ${amount_refunded}  - ${store_credit_used} + ${store_credit_refunded} + ${shipping_total}) / ${exchange_rate}
    decimals: 2
    value_format: '"£"#,##0.00'
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
    label: SUM NET REVENUE EX. DISCOUNT, STORE CREDIT, VAT
    type: sum
    sql: (((${item_total} - ${discount} - ${amount_refunded}  - ${store_credit_used} + ${store_credit_refunded})*(1/(1+${tax_rate}))) + ${shipping_total}) / ${exchange_rate}
    decimals: 2
    value_format: '"£"#,##0.00'
    filters:
      state: -canceled


################################### DELIVERY MEASURES ################################################################################

  - measure: count_hermes_completed_orders
    label: COUNT ORDERS SHIPPED WITH HERMES
    type: count_distinct
    sql: ${TABLE}.order_id
    filters:
      state: -canceled
      delivery_company: HERM
      late_delivery_reason: -Parcel to be Delivered, -Parcel Currently Late - Not Delivered
      
  - measure: count_hermes_late_orders
    label: COUNT HERMES LATE DELIVERIES
    type: count_distinct
    sql: ${TABLE}.order_id
    filters:
      state: -canceled
      delivery_company: HERM
      late_delivery_reason: Parcel Lost by Hermes, Late to Hub, Delay at Depot, Misrouted to Incorrect Depot, Carried Forward, Late - Other Reason, Late to Depot, Delay in Courier Receiving Package, Hermes Delay, Missort to Incorrect Courier

  - measure: count_hermes_no_tracking_info
    label: COUNT HERMES ORDER - NO TRACKING
    type: count_distinct
    sql: ${TABLE}.order_id
    filters:
      state: -canceled
      delivery_company: HERM
      late_delivery_reason: No Tracking Info - Hermes

  - measure: more_info_required_orders
    label: COUNT HERMES ORDERS - MORE INFO REQUIRED
    type: count_distinct
    sql: ${TABLE}.order_id
    filters:
      state: -canceled
      delivery_company: HERM
      late_delivery_reason: More Info Required

  - measure: hermes_on_time_percentage
    label: HERMES ON TIME %
    type: number
    decimals: 4
    sql: 1 - ${count_hermes_late_orders}/nullif(${count_hermes_completed_orders},0)::REAL
    value_format: '#0.00%'

  - measure: hermes_no_tracking_info_percentage
    label: HERMES NO TRACKING INFO %
    type: number
    decimals: 4
    sql: 1 - ${count_hermes_no_tracking_info}/nullif(${count_hermes_completed_orders},0)::REAL
    value_format: '#0.00%'

  - measure: more_info_required_percentage
    label: HERMES MORE INFO REQUIRED %
    type: number
    decimals: 4
    sql: 1 - ${more_info_required_orders}/nullif(${count_hermes_completed_orders},0)::REAL
    value_format: '#0.00%'
  
  
 