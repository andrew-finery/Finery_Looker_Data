view: transactions {
  derived_table: {
    sql: select * from web.orders where reason_to_strip_out is null;;
  }

  ###########################################################################################################################################################
  #############################################################  DIMENSIONS  ################################################################################
  ###########################################################################################################################################################

  dimension: domain_userid {
    sql: ${TABLE}.domain_userid ;;
    hidden: yes
  }

  dimension: domain_sessionidx {
    type: number
    sql: ${TABLE}.domain_sessionidx ;;
    hidden: yes
  }

  dimension: conversion_channel {
    sql: case when ${domain_userid} is null then 'Untracked' else ${website_visits.channel_grouping_3} end ;;
  }

  dimension: conversion_device {
    sql: case when ${domain_userid} is null then 'Untracked' else ${website_visits.device_type} end ;;
  }

  dimension: conversion_country {
    sql: case when ${domain_userid} is null then 'Untracked' else ${website_visits.geography_country_uk_flag} end ;;
  }

  dimension: order_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension_group: completed {
    label: "Order"
    type: time
    timeframes: [
      time,
      date,
      hour_of_day,
      hour,
      time_of_day,
      day_of_week_index,
      day_of_week,
      week,
      week_of_year,
      day_of_month,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year
    ]
    sql: ${TABLE}.completed_at ;;
  }

  dimension: item_count {
    label: "Items in Order"
    type: number
    sql: ${TABLE}.item_count ;;
  }

  dimension: sale_item_count {
    type: number
    sql: ${TABLE}.on_sale_items ;;
  }

  dimension: order_contains_sale_items {
    type: yesno
    sql: ${sale_item_count} > 0 ;;
  }

  dimension: item_count_tier {
    label: "Items in Order Tier"
    sql: case
      when ${TABLE}.item_count = 1 then '1'
      when ${TABLE}.item_count = 2 then '2'
      when ${TABLE}.item_count = 3 then '3'
      when ${TABLE}.item_count = 4 then '4'
      else '5+' end
       ;;
  }

  dimension: order_code {
    label: "Order Code"
    sql: ${TABLE}.order_code ;;
  }

  dimension: primary_payment_method {
    label: "Primary Payment Method"
    sql: ${TABLE}.primary_payment_method ;;
  }

  dimension: state {
    sql: ${TABLE}.state ;;
  }

  dimension: customer_id {
    type: number
    sql: ${TABLE}.customer_id ;;
    hidden: yes
  }

  dimension: blended_email {
    sql: ${TABLE}.blended_email ;;
    hidden: yes
  }

  dimension: order_sequence_number {
    sql: cast(${TABLE}.order_sequence_number as integer) ;;
    hidden: yes
  }

  dimension: order_sequence_tier {
    type: string
    sql: case when ${TABLE}.order_sequence_number in (1,2,3,4) then cast(${order_sequence_number} as varchar) else '5+' end ;;
  }

  dimension: new_customer_flag {
    type: yesno
    sql: ${order_sequence_tier} = 1 ;;
  }

  dimension: discount_flag {
    type: yesno
    sql: ${TABLE}.adjustment_total <> 0 ;;
  }

  dimension: gift_card_only_orders {
    type: yesno
    sql: ${TABLE}.total_gift_card_items = ${TABLE}.item_count ;;
  }

  dimension: latest_order_flag {
    type: yesno
    sql: ${TABLE}.order_id = ${TABLE}.latest_order_id ;;
  }

  dimension: multiple_size_flag {
    type: yesno
    sql: ${TABLE}.number_of_skus != ${TABLE}.number_of_products ;;
  }

  dimension: order_email {
    label: "Email Address"
    sql: ${TABLE}.email ;;
  }

  dimension: in_store_flag {
    label: "In Store Flag"

    case: {
      when: {
        sql: ${TABLE}.in_store_flag = 1 ;;
        label: "In-Store"
      }

      else: "Online"
    }
  }

  # Shipping Dimensions

  dimension: ship_address_id {
    sql: ${TABLE}.ship_address_id ;;
    hidden: yes
  }

  ##################################### REVENUE DIMENSIONS ##########################################################

  dimension: currency {
    sql: ${TABLE}.currency ;;
  }

  dimension: exchange_rate {
    sql: ${TABLE}.exchange_rate ;;
    hidden: yes
  }

  dimension: tax_rate {
    sql: ${TABLE}.tax_rate ;;
    hidden: yes
  }

  dimension: payment_total {
    type: number
    value_format_name: decimal_2
    sql: ${TABLE}.order_total ;;
    hidden: yes
  }

  dimension: item_total {
    type: number
    value_format_name: decimal_2
    sql: ${TABLE}.item_total ;;
  }

  dimension: shipping_total {
    type: number
    value_format_name: decimal_2
    sql: ${TABLE}.shipment_total ;;
    hidden: yes
  }

  dimension: discount {
    type: number
    value_format_name: decimal_2
    sql: ${TABLE}.adjustment_total * (-1) ;;
    hidden: yes
  }

  dimension: store_credit_used {
    type: number
    sql: ${TABLE}.store_credit_used ;;
    value_format_name: decimal_2
    hidden: yes
  }

  dimension: gross_reveune_ex_discount_ex_vat_ex_shipping_gbp_tier {
    label: "Basket Size Tier ex. Shipping"
    type: tier
    tiers: [
      0,
      10,
      20,
      30,
      40,
      50,
      60,
      70,
      80,
      90,
      100,
      110,
      120,
      130,
      140,
      150,
      160,
      170,
      180,
      190,
      200
    ]
    sql: ((${TABLE}.item_total- (${TABLE}.adjustment_total * (-1)) )) / ${exchange_rate} ;;
  }

  dimension: primary_promotion {
    label: "Promotion"
    sql: ${TABLE}.promotion ;;
  }

  ####################### FLAGS ######################################################################################

  dimension: store_credit_used_boolean {
    type: yesno
    sql: ${store_credit_used} > 0 ;;
  }

  dimension: discount_used_boolean {
    type: yesno
    sql: ${discount} > 0 ;;
  }

  ####################### Returns Dimensions ##########################################################################

  dimension: items_returned {
    sql: ${TABLE}.items_returned ;;
    hidden: yes
  }

  dimension: returned_an_item_flag {
    sql: case when ${items_returned} > 0 then 'yes' else 'no' end ;;
  }

  dimension: all_items_returned_flag {
    sql: case when ${items_returned} = ${item_count} then 'yes' else 'no' end ;;
  }

  dimension: return_item_total {
    type: number
    value_format_name: decimal_2
    sql: ${TABLE}.return_item_total ;;
    hidden: yes
  }

  dimension: amount_refunded {
    type: number
    value_format_name: decimal_2
    sql: ${TABLE}.amount_refunded ;;
    hidden: yes
  }

  dimension: store_credit_refunded {
    type: number
    value_format_name: decimal_2
    sql: ${TABLE}.store_credit_refunded ;;
    hidden: yes
  }

  dimension: cash_refunded {
    type: number
    value_format_name: decimal_2
    sql: ${TABLE}.cash_refunded ;;
    hidden: yes
  }

  dimension: restocking_fee {
    type: number
    value_format_name: decimal_2
    sql: ${TABLE}.restocking_fee/${exchange_rate} ;;
  }

  dimension: vat_payable_gbp {
    type: number
    value_format_name: decimal_2
    sql: ((${item_total} - ${discount} - ${amount_refunded} + ${store_credit_refunded} - ${store_credit_used}) / ${exchange_rate}) * (${tax_rate}/(1+${tax_rate})) ;;
  }

  dimension: gross_cogs_gbp {
    type: number
    value_format_name: decimal_2
    sql: ${TABLE}.gross_cogs ;;
    hidden: yes
  }

  dimension: net_cogs_gbp {
    type: number
    value_format_name: decimal_2
    sql: ${TABLE}.net_cogs ;;
    hidden: yes
  }

  dimension: revenue_ex_voucher_and_vat {
    type: number
    sql: (((${TABLE}.item_total- (${TABLE}.adjustment_total * (-1)) )*(1/(1+${tax_rate})))  + ${TABLE}.shipment_total)  / ${exchange_rate} ;;
    value_format_name: decimal_2
  }

  #################################################################################################################################################################################
  ####################################################### MEASURES ################################################################################################################
  #################################################################################################################################################################################

  ################################################## BASIC ORDER MEASURES ################################################################

  measure: count_orders {
    label: "Orders"
    type: count_distinct
    sql: ${TABLE}.order_id ;;

    filters: {
      field: state
      value: "-canceled"
    }
  }

  measure: orders_perc_of_total {
    label: "Orders % Column"
    type: percent_of_total
    sql: ${count_orders} ;;
    direction: "column"
  }

  measure: orders_perc_of_total_row {
    label: "Orders % Row"
    type: percent_of_total
    sql: ${count_orders} ;;
    direction: "row"
  }

  measure: orders_running_total {
    label: "Orders Running Total"
    type: running_total
    sql: ${count_orders} ;;
    direction: "column"
  }

  measure: count_orders_inc_cancelled {
    label: "Orders (Including Cancelled)"
    type: count_distinct
    sql: ${TABLE}.order_id ;;
  }

  measure: cancellation_rate {
    label: "Cancellation Rate"
    type: number
    value_format_name: percent_2
    sql: 1 - (${count_orders})/${count_orders_inc_cancelled}::REAL ;;
  }

  measure: orders_with_returns {
    label: "Orders with Returns"
    type: count_distinct
    sql: ${TABLE}.order_id ;;

    filters: {
      field: items_returned
      value: "-0, -NULL"
    }
  }

  measure: orders_with_discount {
    label: "Orders with Discount"
    type: count_distinct
    sql: ${TABLE}.order_id ;;

    filters: {
      field: state
      value: "-canceled"
    }

    filters: {
      field: discount_flag
      value: "Yes"
    }
  }

  measure: new_customers_with_discount {
    label: "New Customers with Discount"
    type: count_distinct
    sql: ${TABLE}.order_id ;;

    filters: {
      field: state
      value: "-canceled"
    }

    filters: {
      field: discount_flag
      value: "Yes"
    }

    filters: {
      field: order_sequence_number
      value: "1"
    }
  }

  measure: count_customers {
    label: "Customers"
    type: count_distinct
    sql: ${blended_email} ;;

    filters: {
      field: state
      value: "-canceled"
    }
  }

  measure: count_new_customers {
    label: "New Customers"
    type: count_distinct
    sql: ${blended_email} ;;

    filters: {
      field: state
      value: "-canceled"
    }

    filters: {
      field: order_sequence_number
      value: "1"
    }
  }

  measure: total_items {
    label: "Items"
    type: sum
    sql: ${TABLE}.item_count ;;

    filters: {
      field: state
      value: "-canceled"
    }
  }

  measure: avg_items_in_basket {
    label: "Avg items in basket"
    type: number
    value_format_name: decimal_2
    sql: ${total_items}/${count_orders}::REAL ;;
  }

  measure: asp {
    label: "Avg Selling Price"
    type: number
    value_format_name: decimal_2
    sql: ${sum_gross_revenue_ex_discount_in_gbp_ex_vat_ex_shipping}/${total_items} ;;
  }

  measure: orders_per_customer {
    label: "Orders per customer"
    type: number
    value_format_name: decimal_2
    sql: cast(${count_orders} as decimal(8,2))/nullif(cast(${count_customers} as decimal(8,2)),0)::REAL ;;
  }

  measure: new_customer_percentage {
    label: "New Customer %"
    type: number
    value_format_name: percent_2
    sql: cast(${count_new_customers} as decimal(8,2))/nullif(cast(${count_orders} as decimal(8,2)),0)::REAL ;;
  }

  measure: orders_with_discount_percentage {
    label: "Orders with Discount (%)"
    type: number
    value_format_name: percent_2
    sql: ${orders_with_discount}/NULLIF(${count_orders},0)::REAL ;;
  }

  measure: new_customers_using_discount_percentage {
    label: "New Cust w/ Discount"
    type: number
    value_format_name: percent_2
    sql: ${new_customers_with_discount}/NULLIF(${count_new_customers},0)::REAL ;;
  }

  measure: sum_restocking_fee {
    type: sum
    sql: ${restocking_fee} ;;
    value_format_name: decimal_2
  }

  measure: sum_vat_payable_gbp {
    type: sum
    sql: ${vat_payable_gbp} ;;
    value_format_name: decimal_2
  }

  measure: sum_gross_cogs_gbp {
    type: sum
    value_format_name: decimal_2
    sql: ${gross_cogs_gbp} ;;
  }

  measure: sum_net_cogs_gbp {
    type: sum
    value_format_name: decimal_2
    sql: ${net_cogs_gbp} ;;
  }

  ################################################# GROSS REVENUE MEASURES ##############################################################

  measure: sum_gross_revenue {
    type: sum
    sql: ${TABLE}.item_total + ${TABLE}.shipment_total ;;

    filters: {
      field: state
      value: "-canceled"
    }

    hidden: yes
  }

  measure: sum_gross_revenue_in_gbp {
    label: "Gross Revenue (inc. VAT, Discount, Shipping)"
    type: sum
    sql: (${TABLE}.item_total + ${TABLE}.shipment_total) / ${exchange_rate} ;;
    value_format_name: decimal_2

    filters: {
      field: state
      value: "-canceled"
    }
  }

  measure: sum_gross_revenue_ex_vat {
    type: sum
    sql: (${TABLE}.item_total*(1/(1+${tax_rate}))) + ${TABLE}.shipment_total ;;
    value_format_name: decimal_2

    filters: {
      field: state
      value: "-canceled"
    }

    hidden: yes
  }

  measure: sum_gross_revenue_in_gbp_ex_vat {
    label: "Gross Revenue (ex. VAT, inc. Discount, Shipping)"
    type: sum
    sql: ((${TABLE}.item_total*(1/(1+${tax_rate}))) + ${TABLE}.shipment_total) / ${exchange_rate} ;;
    value_format_name: decimal_2

    filters: {
      field: state
      value: "-canceled"
    }
  }

  measure: sum_gross_revenue_inc_canceled {
    type: sum
    sql: ${TABLE}.item_total + ${TABLE}.shipment_total ;;
    value_format_name: decimal_2
    hidden: yes
  }

  measure: sum_gross_revenue_in_gbp_inc_canceled {
    label: "Gross Revenue (inc. Cancelled Orders, VAT, Discount, Shipping)"
    type: sum
    sql: (${TABLE}.item_total + ${TABLE}.shipment_total) / ${exchange_rate} ;;
    value_format_name: decimal_2
  }

  ################################################# DISCOUNT/STORE CREDIT MEASURES ##############################################################

  measure: sum_total_discount {
    type: sum
    sql: ${TABLE}.adjustment_total * (-1) ;;
    value_format_name: decimal_2

    filters: {
      field: state
      value: "-canceled"
    }

    hidden: yes
  }

  measure: sum_total_discount_gbp {
    label: "Total Voucher Discount"
    type: sum
    sql: ${TABLE}.adjustment_total * (-1) / ${exchange_rate} ;;
    value_format_name: decimal_2

    filters: {
      field: state
      value: "-canceled"
    }
  }

  measure: sum_store_credit_used {
    type: sum
    sql: ${TABLE}.store_credit_used ;;
    value_format_name: decimal_2

    filters: {
      field: state
      value: "-canceled"
    }

    hidden: yes
  }

  measure: sum_store_credit_used_gbp {
    label: "Total Store Credit"
    type: sum
    sql: ${TABLE}.store_credit_used / ${exchange_rate} ;;
    value_format_name: decimal_2

    filters: {
      field: state
      value: "-canceled"
    }
  }

  measure: sum_total_discount_ex_vat {
    type: sum
    sql: ${TABLE}.adjustment_total * (-1) * (1/(1+${tax_rate})) ;;
    value_format_name: decimal_2

    filters: {
      field: state
      value: "-canceled"
    }

    hidden: yes
  }

  measure: sum_total_discount_gbp_ex_vat {
    label: "Total Discount ex. VAT"
    type: sum
    sql: ${TABLE}.adjustment_total * (-1) * ${exchange_rate}  *(1/(1+${tax_rate})) ;;
    value_format_name: decimal_2

    filters: {
      field: state
      value: "-canceled"
    }
  }

  measure: sum_store_credit_used_ex_vat {
    type: sum
    sql: ${TABLE}.store_credit_used*(1/(1+${tax_rate})) ;;
    value_format_name: decimal_2

    filters: {
      field: state
      value: "-canceled"
    }

    hidden: yes
  }

  measure: sum_store_credit_used_gbp_ex_vat {
    label: "Total Store Credit ex. VAT"
    type: sum
    sql: ${TABLE}.store_credit_used / ${exchange_rate} * (1/(1+${tax_rate})) ;;
    value_format_name: decimal_2

    filters: {
      field: state
      value: "-canceled"
    }
  }

  ################################################ GROSS REVENUE EX DISCOUNT/STORE CREDIT MEASURES ##############################################################


  measure: sum_gross_revenue_ex_discount {
    type: sum
    sql: ${TABLE}.item_total + ${TABLE}.shipment_total - (${TABLE}.adjustment_total * (-1)) ;;
    value_format_name: decimal_2

    filters: {
      field: state
      value: "-canceled"
    }

    hidden: yes
  }

  measure: sum_gross_revenue_ex_discount_in_gbp {
    label: "Gross Revenue ex. Voucher"
    type: sum
    sql: (${TABLE}.item_total + ${TABLE}.shipment_total - (${TABLE}.adjustment_total * (-1)) ) / ${exchange_rate} ;;
    value_format_name: decimal_2

    filters: {
      field: state
      value: "-canceled"
    }
  }

  measure: sum_gross_revenue_ex_discount_and_shipping_in_gbp {
    label: "Gross Revenue ex. Voucher, Shipping"
    type: sum
    sql: (${TABLE}.item_total - (${TABLE}.adjustment_total * (-1)) ) / ${exchange_rate} ;;
    value_format_name: decimal_2

    filters: {
      field: state
      value: "-canceled"
    }
  }

  measure: sum_gross_revenue_ex_discount_ex_vat {
    type: sum
    sql: ((${TABLE}.item_total- (${TABLE}.adjustment_total * (-1)) )*(1/(1+${tax_rate})))  + ${TABLE}.shipment_total ;;
    value_format_name: decimal_2

    filters: {
      field: state
      value: "-canceled"
    }

    hidden: yes
  }

  measure: sum_gross_revenue_ex_discount_in_gbp_ex_vat {
    label: "Gross Revenue ex. Voucher, VAT"
    type: sum
    sql: (((${TABLE}.item_total- (${TABLE}.adjustment_total * (-1)) )*(1/(1+${tax_rate})))  + ${TABLE}.shipment_total)  / ${exchange_rate} ;;
    value_format_name: decimal_2

    filters: {
      field: state
      value: "-canceled"
    }
  }

  measure: sum_gross_revenue_ex_discount_in_gbp_ex_vat_in_k {
    label: "Gross Revenue ex. Voucher, VAT (K)"
    type: sum
    sql: (((${TABLE}.item_total- (${TABLE}.adjustment_total * (-1)) )*(1/(1+${tax_rate})))  + ${TABLE}.shipment_total) / ${exchange_rate} / 1000 ;;
    value_format: "\"£\"##0.0\"k\""

    filters: {
      field: state
      value: "-canceled"
    }
  }

  measure: sum_gross_revenue_ex_discount_and_store_credit {
    type: sum
    sql: ${TABLE}.item_total + ${TABLE}.shipment_total - (${TABLE}.adjustment_total * (-1)) - ${TABLE}.store_credit_used ;;
    value_format_name: decimal_2

    filters: {
      field: state
      value: "-canceled"
    }

    hidden: yes
  }

  measure: sum_gross_revenue_ex_discount_and_store_credit_in_gbp {
    label: "Gross Revenue ex. Voucher, Store Credit"
    type: sum
    sql: (${TABLE}.item_total + ${TABLE}.shipment_total - (${TABLE}.adjustment_total * (-1)) - ${TABLE}.store_credit_used)  / ${exchange_rate} ;;
    value_format_name: decimal_2

    filters: {
      field: state
      value: "-canceled"
    }
  }

  measure: sum_gross_revenue_ex_discount_and_store_credit_ex_vat {
    type: sum
    sql: ((${TABLE}.item_total - (${TABLE}.adjustment_total * (-1)) - ${TABLE}.store_credit_used)*(1/(1+${tax_rate}))) + ${TABLE}.shipment_total ;;
    value_format_name: decimal_2

    filters: {
      field: state
      value: "-canceled"
    }

    hidden: yes
  }

  measure: sum_gross_revenue_ex_discount_and_store_credit_in_gbp_ex_vat {
    label: "Gross Revenue ex. Voucher, Store Credit, VAT"
    type: sum
    sql: (((${TABLE}.item_total - (${TABLE}.adjustment_total * (-1)) - ${TABLE}.store_credit_used)*(1/(1+${tax_rate}))) + ${TABLE}.shipment_total)  / ${exchange_rate} ;;
    value_format_name: decimal_2

    filters: {
      field: state
      value: "-canceled"
    }
  }

  ################################################# GROSS REVENUE MEASURES EXCLUDING SHIPPING ############################################################

  measure: sum_gross_revenue_ex_discount_in_gbp_ex_vat_ex_shipping {
    label: "Gross Revenue (ex. VAT, Discount, Shipping)"
    type: sum
    sql: ((${TABLE}.item_total- (${TABLE}.adjustment_total * (-1)) )*(1/(1+${tax_rate})))  / ${exchange_rate} ;;
    value_format_name: decimal_2

    filters: {
      field: state
      value: "-canceled"
    }
  }

  measure: revenue_percent_of_total {
    type: percent_of_total
    sql: ${sum_gross_revenue_ex_discount_in_gbp_ex_vat_ex_shipping} ;;
    direction: "column"
  }

  measure: revenue_running_total {
    type: running_total
    sql: ${sum_gross_revenue_ex_discount_in_gbp_ex_vat_ex_shipping} ;;
    direction: "column"
  }

  measure: sum_gross_revenue_ex_discount_in_gbp_ex_vat_ex_shipping_in_k {
    type: sum
    label: "Gross Revenue (£k)"
    sql: ((${TABLE}.item_total- (${TABLE}.adjustment_total * (-1)) )*(1/(1+${tax_rate})))  / ${exchange_rate} / 1000 ;;
    value_format: "\"£\"##0.0\"k\""

    filters: {
      field: state
      value: "-canceled"
    }

    hidden: yes
  }

  measure: average_discount {
    label: "Avg Discount"
    type: number
    value_format_name: percent_1
    sql: ${sum_total_discount_gbp}/${sum_total_of_items_gbp}::REAL ;;
  }

  measure: avg_gross_revenue_ex_discount_in_gbp_ex_vat_ex_shipping {
    label: "Avg Basket Size"
    type: number
    value_format_name: percent_1
    sql: ${sum_gross_revenue_ex_discount_in_gbp_ex_vat_ex_shipping}/NULLIF(${count_orders},0)::REAL ;;
  }

  ################################################ COUNT DAYS AND MEASURES PER DAY #######################################################################

  measure: count_days {
    type: count_distinct
    sql: ${completed_date} ;;
    hidden: yes
  }

  measure: orders_per_day {
    label: "Orders per Day"
    type: number
    value_format_name: decimal_0
    sql: ${count_orders}/${count_days}::REAL ;;
  }

  measure: revenue_per_day {
    label: "Revenue per Day"
    type: number
    value_format_name: decimal_0
    sql: ${sum_gross_revenue_ex_discount_in_gbp_ex_vat_ex_shipping}/${count_days}::REAL ;;
  }

  ############################ OTHER GROSS REVENUE SUMS ###################################################################################################

  measure: sum_total_of_items {
    type: sum
    sql: ${TABLE}.item_total ;;
    value_format_name: decimal_2

    filters: {
      field: state
      value: "-canceled"
    }

    hidden: yes
  }

  measure: sum_total_of_items_gbp {
    label: "Gross Item Revenue"
    type: sum
    sql: ${TABLE}.item_total / ${exchange_rate} ;;
    value_format_name: decimal_2

    filters: {
      field: state
      value: "-canceled"
    }
  }

  measure: sum_shipping_total {
    type: sum
    sql: ${TABLE}.shipment_total ;;
    value_format_name: decimal_2

    filters: {
      field: state
      value: "-canceled"
    }

    hidden: yes
  }

  measure: sum_shipping_total_gbp {
    label: "Shipping Revenue"
    type: sum
    sql: ${TABLE}.shipment_total / ${exchange_rate} ;;
    value_format_name: decimal_2

    filters: {
      field: state
      value: "-canceled"
    }
  }

  ############################################################## REVENUE AVERAGES ##############################################################################

  measure: avg_gross_revenue_gbp {
    label: "Avg Basket Size"
    type: number
    value_format_name: decimal_2
    sql: ${sum_gross_revenue_in_gbp}/NULLIF(${count_orders},0)::REAL ;;
  }

  measure: avg_gross_revenue_ex_discount_in_gbp {
    label: "Avg Basket Size ex. Voucher"
    type: number
    value_format_name: decimal_2
    sql: ${sum_gross_revenue_ex_discount_in_gbp}/NULLIF(${count_orders},0)::REAL ;;
  }

  measure: avg_gross_revenue_ex_discount_and_shipping_in_gbp {
    label: "Avg Basket Size ex. Voucher, Shipping"
    type: number
    value_format_name: decimal_2
    sql: ${sum_gross_revenue_ex_discount_and_shipping_in_gbp}/NULLIF(${count_orders},0)::REAL ;;
  }

  measure: avg_shipping_in_gbp {
    label: "Shipping Revenue per Order"
    type: number
    value_format_name: decimal_2
    sql: ${sum_shipping_total_gbp}/NULLIF(${count_orders},0)::REAL ;;
  }

  measure: avg_gross_revenue_ex_discount_and_store_credit_in_gbp {
    label: "Avg Basket Size ex. Voucher, Store Credit"
    type: number
    value_format_name: decimal_2
    sql: ${sum_gross_revenue_ex_discount_and_store_credit_in_gbp}/NULLIF(${count_orders},0)::REAL ;;
  }

  measure: avg_gross_revenue_gbp_ex_vat {
    label: "Avg Basket Size ex. VAT"
    type: number
    value_format_name: decimal_2
    sql: ${sum_gross_revenue_in_gbp_ex_vat}/NULLIF(${count_orders},0)::REAL ;;
  }

  measure: avg_gross_revenue_ex_discount_in_gbp_ex_vat {
    label: "Avg Basket Size ex. Voucher, VAT"
    type: number
    value_format_name: decimal_2
    sql: ${sum_gross_revenue_ex_discount_in_gbp_ex_vat}/NULLIF(${count_orders},0)::REAL ;;
  }

  measure: avg_gross_revenue_ex_discount_and_store_credit_in_gbp_ex_vat {
    label: "Avg Basket Size ex. Voucher, Store Credit, VAT"
    type: number
    value_format_name: decimal_2
    sql: ${sum_gross_revenue_ex_discount_and_store_credit_in_gbp_ex_vat}/NULLIF(${count_orders},0)::REAL ;;
  }

  measure: avg_discount_in_gbp {
    label: "Avg Discount Value"
    type: number
    value_format_name: decimal_2
    sql: ${sum_total_discount_gbp}/NULLIF(${count_orders},0)::REAL ;;
  }

  measure: avg_discount_in_gbp_ex_vat {
    label: "Avg Discount Value ex. VAT"
    type: number
    value_format_name: decimal_2
    sql: ${sum_total_discount_gbp_ex_vat}/NULLIF(${count_orders},0)::REAL ;;
  }

  measure: avg_store_credit_used_gbp {
    label: "Avg Store Credit Used"
    type: number
    value_format_name: decimal_2
    sql: ${sum_store_credit_used_gbp}/NULLIF(${count_orders},0)::REAL ;;
  }

  measure: avg_store_credit_used_gbp_ex_vat {
    label: "Avg Store Credit Used ex. VAT"
    type: number
    value_format_name: decimal_2
    sql: ${sum_store_credit_used_gbp_ex_vat}/NULLIF(${count_orders},0)::REAL ;;
  }

  ############################################################## RETURNS MEASUERS #############################################################################################

  measure: sum_items_returned {
    label: "Items Returned"
    type: sum
    sql: ${items_returned} ;;

    filters: {
      field: state
      value: "-canceled"
    }
  }

  measure: return_rate {
    type: number
    sql: ${sum_items_returned}/NULLIF(${total_items},0)::REAL ;;
    value_format_name: percent_2
  }

  measure: sum_return_item_total {
    type: sum
    sql: ${return_item_total} ;;
    value_format_name: decimal_2

    filters: {
      field: state
      value: "-canceled"
    }

    hidden: yes
  }

  measure: sum_return_item_total_gbp {
    label: "Return Item Value"
    type: sum
    sql: ${return_item_total} / ${exchange_rate} ;;
    value_format_name: decimal_2

    filters: {
      field: state
      value: "-canceled"
    }
  }

  measure: sum_amount_refunded {
    type: sum
    sql: ${amount_refunded} ;;
    value_format_name: decimal_2

    filters: {
      field: state
      value: "-canceled"
    }

    hidden: yes
  }

  measure: sum_amount_refunded_gbp {
    label: "Total Amount Refunded"
    type: sum
    sql: ${amount_refunded} / ${exchange_rate} ;;
    value_format_name: decimal_2

    filters: {
      field: state
      value: "-canceled"
    }
  }

  measure: sum_cash_refunded {
    type: sum
    sql: ${cash_refunded} ;;
    value_format_name: decimal_2

    filters: {
      field: state
      value: "-canceled"
    }

    hidden: yes
  }

  measure: sum_cash_refunded_gbp {
    label: "Total Cash Refunded"
    type: sum
    sql: ${cash_refunded} / ${exchange_rate} ;;
    value_format_name: decimal_2

    filters: {
      field: state
      value: "-canceled"
    }
  }

  measure: sum_store_credit_refunded {
    type: sum
    sql: ${store_credit_refunded} ;;
    value_format_name: decimal_2

    filters: {
      field: state
      value: "-canceled"
    }

    hidden: yes
  }

  measure: sum_store_credit_refunded_gbp {
    label: "Total Store Credit Refunded"
    type: sum
    sql: ${store_credit_refunded} / ${exchange_rate} ;;
    value_format_name: decimal_2

    filters: {
      field: state
      value: "-canceled"
    }
  }

  measure: sum_net_store_credit_used_gbp {
    label: "Net Store Credit Used"
    type: number
    sql: ${sum_store_credit_used_gbp} - ${sum_store_credit_refunded_gbp} ;;
    value_format_name: decimal_2
  }

  ############################################################## NET REVENUE MEASURES (POST RETURNS) #############################################################################################

  measure: sum_net_revenue {
    type: sum
    sql: ${item_total} + ${shipping_total} - ${return_item_total} ;;
    value_format_name: decimal_2

    filters: {
      field: state
      value: "-canceled"
    }

    hidden: yes
  }

  measure: sum_net_revenue_gbp {
    label: "Net Revenue"
    type: sum
    sql: (${item_total} + ${shipping_total} - ${return_item_total}) / ${exchange_rate} ;;
    value_format_name: decimal_2

    filters: {
      field: state
      value: "-canceled"
    }
  }

  measure: sum_net_revenue_ex_vat {
    type: sum
    sql: ((${item_total} - ${return_item_total})*(1/(1+${tax_rate}))) + ${shipping_total} ;;
    value_format_name: decimal_2

    filters: {
      field: state
      value: "-canceled"
    }

    hidden: yes
  }

  measure: sum_net_revenue_gbp_ex_vat {
    label: "Net Revenue ex. VAT"
    type: sum
    sql: (((${item_total} - ${return_item_total})*(1/(1+${tax_rate}))) + ${shipping_total}) / ${exchange_rate} ;;
    value_format_name: decimal_2

    filters: {
      field: state
      value: "-canceled"
    }
  }

  measure: sum_net_revenue_ex_discount {
    type: sum
    sql: ${item_total} - ${discount} - ${amount_refunded} + ${shipping_total} ;;
    value_format_name: decimal_2

    filters: {
      field: state
      value: "-canceled"
    }

    hidden: yes
  }

  measure: sum_net_revenue_ex_discount_gbp {
    label: "Net Revenue ex. Discount"
    type: sum
    sql: (${item_total} - ${discount} - ${amount_refunded} + ${shipping_total}) / ${exchange_rate} ;;
    value_format_name: decimal_2

    filters: {
      field: state
      value: "-canceled"
    }
  }

  measure: sum_net_revenue_ex_discount_ex_vat {
    type: sum
    sql: ((${item_total} - ${discount} - ${amount_refunded})*(1/(1+${tax_rate}))) + ${shipping_total} ;;
    value_format_name: decimal_2

    filters: {
      field: state
      value: "-canceled"
    }

    hidden: yes
  }

  measure: sum_net_revenue_ex_discount_gbp_ex_vat {
    label: "Net. Revenue ex. Discount, VAT"
    type: sum
    sql: (((${item_total} - ${discount} - ${amount_refunded})*(1/(1+${tax_rate}))) + ${shipping_total}) / ${exchange_rate} ;;
    value_format_name: decimal_2

    filters: {
      field: state
      value: "-canceled"
    }
  }

  measure: sum_net_revenue_ex_discount_ex_store_credit {
    type: sum
    sql: ${item_total} - ${discount} - ${amount_refunded}  - ${store_credit_used} + ${store_credit_refunded} + ${shipping_total} ;;
    value_format_name: decimal_2

    filters: {
      field: state
      value: "-canceled"
    }

    hidden: yes
  }

  measure: sum_net_revenue_ex_discount_ex_store_credit_gbp {
    label: "Net Revenue ex. Voucher, Store Credit"
    type: sum
    sql: (${item_total} - ${discount} - ${amount_refunded}  - ${store_credit_used} + ${store_credit_refunded} + ${shipping_total}) / ${exchange_rate} ;;
    value_format_name: decimal_2

    filters: {
      field: state
      value: "-canceled"
    }
  }

  measure: sum_net_revenue_ex_discount_ex_store_credit_ex_vat {
    type: sum
    sql: ((${item_total} - ${discount} - ${amount_refunded}  - ${store_credit_used} + ${store_credit_refunded})*(1/(1+${tax_rate}))) + ${shipping_total} ;;
    value_format_name: decimal_2

    filters: {
      field: state
      value: "-canceled"
    }

    hidden: yes
  }

  measure: sum_net_revenue_ex_discount_ex_store_credit_gbp_ex_vat {
    label: "Net Revenue ex. Voucher, Store Credit, VAT"
    type: sum
    sql: (((${item_total} - ${discount} - ${amount_refunded}  - ${store_credit_used} + ${store_credit_refunded})*(1/(1+${tax_rate}))) + ${shipping_total}) / ${exchange_rate} ;;
    value_format_name: decimal_2

    filters: {
      field: state
      value: "-canceled"
    }
  }

  ############## UNIT ORDER ECONOMICS

  measure: gross_revenue_per_order {
    type: number
    value_format_name: decimal_2
    sql: ${sum_gross_revenue_ex_discount_in_gbp}/NULLIF(${count_orders},0)::REAL ;;
    group_label: "Unit Order Economics"
  }

  measure: shipping_revenue_per_order {
    type: number
    value_format_name: decimal_2
    sql: ${sum_shipping_total_gbp}/NULLIF(${count_orders},0)::REAL ;;
    group_label: "Unit Order Economics"
  }

  measure: amount_refunded_per_order {
    type: number
    value_format_name: decimal_2
    sql: ${sum_amount_refunded_gbp}/NULLIF(${count_orders},0)::REAL ;;
    group_label: "Unit Order Economics"
  }

  measure: net_store_credit_used_per_order {
    type: number
    value_format_name: decimal_2
    sql: ${sum_net_store_credit_used_gbp}/NULLIF(${count_orders},0)::REAL ;;
    group_label: "Unit Order Economics"
  }

  measure: vat_per_order {
    type: number
    value_format_name: decimal_2
    sql: ${sum_vat_payable_gbp}/NULLIF(${count_orders},0)::REAL ;;
    group_label: "Unit Order Economics"
  }

  measure: net_cogs_per_order {
    type: number
    value_format_name: decimal_2
    sql: ${sum_net_cogs_gbp}/NULLIF(${count_orders},0)::REAL ;;
    group_label: "Unit Order Economics"
  }

  measure: net_profit_pre_ops_and_marketing {
    type: number
    value_format_name: decimal_2
    sql: ${gross_revenue_per_order} - ${shipping_revenue_per_order} - ${amount_refunded_per_order} - ${net_store_credit_used_per_order} - ${vat_per_order} - ${net_cogs_per_order} ;;
    group_label: "Unit Order Economics"
  }

###### Meausres for time period reporting

  measure: revenue_yesterday {
    label: "Actual"
    type: number
    sql: sum(case when ${completed_date} = current_date - 1 then ((${TABLE}.item_total + ${TABLE}.shipment_total - (${TABLE}.adjustment_total * (-1)) - ${TABLE}.store_credit_used)  / ${exchange_rate}) else 0 end) ;;
    value_format_name: pounds_k
    group_label: "Revenue Reporting Measures"
  }

  measure: revenue_yesterday_last_week {
    label: "LW"
    type: number
    sql: sum(case when ${completed_date} = current_date - 8 then ((${TABLE}.item_total + ${TABLE}.shipment_total - (${TABLE}.adjustment_total * (-1)) - ${TABLE}.store_credit_used)  / ${exchange_rate}) else 0 end) ;;
    value_format_name: pounds_k
    group_label: "Revenue Reporting Measures"
  }

  measure: revenue_yesterday_week_on_week {
    label: "%"
    type: number
    value_format_name: percent_0
    group_label: "Revenue Reporting Measures"
    sql: (${revenue_yesterday} - ${revenue_yesterday_last_week})/NULLIF(${revenue_yesterday_last_week},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: revenue_yesterday_last_year {
    label: "LY"
    type: number
    sql: sum(case when (${completed_date} = (select calendar_date from finery.calendar where week_number = (select week_number from finery.calendar where calendar_date = current_date - 1) and dow = (select dow from finery.calendar where calendar_date = current_date - 1) and year = (select year - 1 from finery.calendar where calendar_date = current_date - 1))) then ((${TABLE}.item_total + ${TABLE}.shipment_total - (${TABLE}.adjustment_total * (-1)) - ${TABLE}.store_credit_used)  / ${exchange_rate}) else 0 end) ;;
    value_format_name: pounds_k
    group_label: "Revenue Reporting Measures"
  }

  measure: revenue_yesterday_year_on_year {
    label: "YoY"
    type: number
    value_format_name: percent_0
    group_label: "Revenue Reporting Measures"
    sql: (${revenue_yesterday} - ${revenue_yesterday_last_year})/NULLIF(${revenue_yesterday_last_year},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: revenue_week_to_date {
    label: "WTD"
    type: number
    sql: sum(case when ${completed_date} between date_trunc('week', current_date - 1) and current_date - 1 then ((${TABLE}.item_total + ${TABLE}.shipment_total - (${TABLE}.adjustment_total * (-1)) - ${TABLE}.store_credit_used)  / ${exchange_rate}) else 0 end) ;;
    value_format_name: pounds_k
    group_label: "Revenue Reporting Measures"
  }

  measure: revenue_week_to_date_lw {
    label: "WTD LW"
    type: number
    sql: sum(case when ${completed_date} between date_trunc('week', current_date - 8) and current_date - 8 then ((${TABLE}.item_total + ${TABLE}.shipment_total - (${TABLE}.adjustment_total * (-1)) - ${TABLE}.store_credit_used)  / ${exchange_rate}) else 0 end) ;;
    value_format_name: pounds_k
    group_label: "Revenue Reporting Measures"
  }

  measure: revenue_week_to_date_week_on_week {
    label: "WTD WoW"
    type: number
    value_format_name: percent_0
    group_label: "Revenue Reporting Measures"
    sql: (${revenue_week_to_date} - ${revenue_week_to_date_lw})/NULLIF(${revenue_week_to_date_lw},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: revenue_week_to_date_ly {
    label: "WTD LY"
    type: number
    sql: sum(case when ${completed_date} between date_trunc('week', (select calendar_date from finery.calendar where week_number = (select week_number from finery.calendar where calendar_date = current_date - 1) and dow = (select dow from finery.calendar where calendar_date = current_date - 1) and year = (select year - 1 from finery.calendar where calendar_date = current_date - 1))) and (select calendar_date from finery.calendar where week_number = (select week_number from finery.calendar where calendar_date = current_date - 1) and dow = (select dow from finery.calendar where calendar_date = current_date - 1) and year = (select year - 1 from finery.calendar where calendar_date = current_date - 1)) then ((${TABLE}.item_total + ${TABLE}.shipment_total - (${TABLE}.adjustment_total * (-1)) - ${TABLE}.store_credit_used)  / ${exchange_rate}) else 0 end) ;;
    value_format_name: pounds_k
    group_label: "Revenue Reporting Measures"
  }

  measure: revenue_week_to_date_year_on_year {
    label: "WTD YoY"
    type: number
    value_format_name: percent_0
    group_label: "Revenue Reporting Measures"
    sql: (${revenue_week_to_date} - ${revenue_week_to_date_ly})/NULLIF(${revenue_week_to_date_ly},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: revenue_month_to_date {
    label: "MTD"
    type: number
    sql: sum(case when ${completed_date} between date_trunc('month', current_date - 1) and current_date - 1 then ((${TABLE}.item_total + ${TABLE}.shipment_total - (${TABLE}.adjustment_total * (-1)) - ${TABLE}.store_credit_used)  / ${exchange_rate}) else 0 end) ;;
    value_format_name: pounds_k
    group_label: "Revenue Reporting Measures"
  }

  measure: revenue_month_to_date_last_month {
    label: "MTD LM"
    type: number
    sql: sum(case when ${completed_date} between date_trunc('month', add_months(current_date - 1, -1)) and add_months(current_date - 1, -1) then ((${TABLE}.item_total + ${TABLE}.shipment_total - (${TABLE}.adjustment_total * (-1)) - ${TABLE}.store_credit_used)  / ${exchange_rate}) else 0 end) ;;
    value_format_name: pounds_k
    group_label: "Revenue Reporting Measures"
  }

  measure: revenue_month_to_date_month_on_month {
    label: "MTD MoM"
    type: number
    value_format_name: percent_0
    group_label: "Revenue Reporting Measures"
    sql: (${revenue_month_to_date} - ${revenue_month_to_date_last_month})/NULLIF(${revenue_month_to_date_last_month},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: revenue_month_to_date_last_year {
    label: "MTD LY"
    type: number
    sql: sum(case when ${completed_date} between date_trunc('month', add_months(current_date - 1, -12)) and add_months(current_date - 1, -12) then ((${TABLE}.item_total + ${TABLE}.shipment_total - (${TABLE}.adjustment_total * (-1)) - ${TABLE}.store_credit_used)  / ${exchange_rate}) else 0 end) ;;
    value_format_name: pounds_k
    group_label: "Revenue Reporting Measures"
  }

  measure: revenue_month_to_date_year_on_year {
    label: "MTD YoY"
    type: number
    value_format_name: percent_0
    group_label: "Revenue Reporting Measures"
    sql: (${revenue_month_to_date} - ${revenue_month_to_date_last_year})/NULLIF(${revenue_month_to_date_last_year},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: revenue_year_to_date {
    label: "YTD"
    type: number
    sql: sum(case when ${completed_date} between date_trunc('year', current_date - 1) and current_date - 1 then ((${TABLE}.item_total + ${TABLE}.shipment_total - (${TABLE}.adjustment_total * (-1)) - ${TABLE}.store_credit_used)  / ${exchange_rate}) else 0 end) ;;
    value_format_name: pounds_k
    group_label: "Revenue Reporting Measures"
  }

  measure: revenue_year_to_date_last_year {
    label: "YTD LY"
    type: number
    sql: sum(case when ${completed_date} between date_trunc('year', add_months(current_date - 1, -12)) and add_months(current_date - 1, -12) then ((${TABLE}.item_total + ${TABLE}.shipment_total - (${TABLE}.adjustment_total * (-1)) - ${TABLE}.store_credit_used)  / ${exchange_rate}) else 0 end) ;;
    value_format_name: pounds_k
    group_label: "Revenue Reporting Measures"
  }

  measure: revenue_year_to_date_year_on_year {
    label: "YTD YoY"
    type: number
    value_format_name: percent_0
    group_label: "Revenue Reporting Measures"
    sql: (${revenue_year_to_date} - ${revenue_year_to_date_last_year})/NULLIF(${revenue_year_to_date_last_year},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: revenue_target_yesterday {
    label: "Target Yest"
    type: number
    sql: avg((select sum(Case when calendar_date = current_date - 1 then revenue else 0 end) from finery.targets_2017)) ;;
    value_format_name: pounds_k
    group_label: "Revenue Reporting Measures"
  }

  measure: revenue_yesterday_vs_target {
    label: "Yest vs Target"
    type: number
    value_format_name: percent_0
    group_label: "Revenue Reporting Measures"
    sql: (${revenue_yesterday} - ${revenue_target_yesterday})/NULLIF(${revenue_target_yesterday},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: revenue_target_week_to_date {
    label: "Target WTD"
    type: number
    sql: avg((select sum(Case when calendar_date between date_trunc('week', current_date - 1) and current_date - 1 then revenue else 0 end) from finery.targets_2017)) ;;
    value_format_name: pounds_k
    group_label: "Revenue Reporting Measures"
  }

  measure: revenue_week_to_date_vs_target {
    label: "WTD vs Target"
    type: number
    value_format_name: percent_0
    group_label: "Revenue Reporting Measures"
    sql: (${revenue_week_to_date} - ${revenue_target_week_to_date})/NULLIF(${revenue_target_week_to_date},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: revenue_target_month_to_date {
    label: "Target MTD"
    type: number
    sql: avg((select sum(Case when calendar_date between date_trunc('month', current_date - 1) and current_date - 1 then revenue else 0 end) from finery.targets_2017)) ;;
    value_format_name: pounds_k
    group_label: "Revenue Reporting Measures"
  }

  measure: revenue_month_to_date_vs_target {
    label: "MTD vs Target"
    type: number
    value_format_name: percent_0
    group_label: "Revenue Reporting Measures"
    sql: (${revenue_month_to_date} - ${revenue_target_month_to_date})/NULLIF(${revenue_target_month_to_date},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }


  measure: orders_yesterday {
    label: "Actual"
    type: number
    sql: count(distinct case when ${completed_date} = current_date - 1 then ${order_id} else 0 end) ;;
    group_label: "Order Reporting Measures"
  }

  measure: orders_yesterday_last_week {
    label: "LW"
    type: number
    sql: count(distinct case when ${completed_date} = current_date - 8 then ${order_id} else 0 end) ;;
    group_label: "Order Reporting Measures"
  }

  measure: orders_yesterday_last_year {
    label: "LY"
    type: number
    sql: count(distinct case when (${completed_date} = (select calendar_date from finery.calendar where week_number = (select week_number from finery.calendar where calendar_date = current_date - 1) and dow = (select dow from finery.calendar where calendar_date = current_date - 1) and year = (select year - 1 from finery.calendar where calendar_date = current_date - 1))) then ${order_id} else null end) ;;
    group_label: "Order Reporting Measures"
  }

  measure: orders_week_to_date {
    label: "WTD"
    type: number
    sql: count(distinct case when ${completed_date} between date_trunc('week', current_date - 1) and current_date - 1 then ${order_id} else 0 end) ;;
    group_label: "Order Reporting Measures"
  }

  measure: orders_week_to_date_last_week {
    label: "WTD LW"
    type: number
    sql: count(distinct case when ${completed_date} between date_trunc('week', current_date - 8) and current_date - 8 then ${order_id} else 0 end) ;;
    group_label: "Order Reporting Measures"
  }

  measure: orders_week_to_date_last_year {
    label: "WTD LY"
    type: number
    sql: count(distinct case when ${completed_date} between date_trunc('week', (select calendar_date from finery.calendar where week_number = (select week_number from finery.calendar where calendar_date = current_date - 1) and dow = (select dow from finery.calendar where calendar_date = current_date - 1) and year = (select year - 1 from finery.calendar where calendar_date = current_date - 1))) and (select calendar_date from finery.calendar where week_number = (select week_number from finery.calendar where calendar_date = current_date - 1) and dow = (select dow from finery.calendar where calendar_date = current_date - 1) and year = (select year - 1 from finery.calendar where calendar_date = current_date - 1)) then ${order_id} else 0 end) ;;
    group_label: "Order Reporting Measures"
  }

  measure: orders_month_to_date {
    label: "MTD"
    type: number
    sql: count(distinct case when ${completed_date} between date_trunc('month', current_date - 1) and current_date - 1 then ${order_id} else 0 end) ;;
    group_label: "Order Reporting Measures"
  }

  measure: orders_month_to_date_last_month {
    label: "MTD LM"
    type: number
    sql: count(distinct case when ${completed_date} between date_trunc('month', add_months(current_date - 1, -1)) and add_months(current_date - 1, -1) then ${order_id} else 0 end) ;;
    group_label: "Order Reporting Measures"
  }

  measure: orders_month_to_date_last_year {
    label: "MTD LY"
    type: number
    sql: count(distinct case when ${completed_date} between date_trunc('month', add_months(current_date - 1, -12)) and add_months(current_date - 1, -12) then ${order_id} else 0 end) ;;
    group_label: "Order Reporting Measures"
  }

  measure: orders_year_to_date {
    label: "YTD"
    type: number
    sql: count(distinct case when ${completed_date} between date_trunc('year', add_months(current_date - 1, -1)) and add_months(current_date - 1, -1) then ${order_id} else 0 end) ;;
    value_format_name: pounds_k
    group_label: "Order Reporting Measures"
  }

  measure: orders_year_to_date_last_year {
    label: "YTD LY"
    type: number
    sql: count(distinct case when ${completed_date} between date_trunc('year', add_months(current_date - 1, -12)) and add_months(current_date - 1, -12) then ${order_id} else 0 end) ;;
    group_label: "Order Reporting Measures"
  }

  measure: orders_target_yesterday {
    label: "Target Yest"
    type: number
    sql: avg((select sum(Case when calendar_date = current_date - 1 then orders else 0 end) from finery.targets_2017)) ;;
    value_format_name: pounds_k
    group_label: "Order Reporting Measures"
  }

  measure: orders_target_week_to_date {
    label: "Target WTD"
    type: number
    sql: avg((select sum(Case when calendar_date between date_trunc('week', current_date - 1) and current_date - 1 then orders else 0 end) from finery.targets_2017)) ;;
    value_format_name: pounds_k
    group_label: "Order Reporting Measures"
  }
  measure: orders_target_month_to_date {
    label: "Target MTD"
    type: number
    sql: avg((select sum(Case when calendar_date between date_trunc('month', current_date - 1) and current_date - 1 then orders else 0 end) from finery.targets_2017)) ;;
    value_format_name: pounds_k
    group_label: "Order Reporting Measures"
  }

  measure: basket_yesterday {
    label: "Actual"
    type: number
    sql: ${revenue_yesterday}/${orders_yesterday} ;;
    value_format_name: pounds
    group_label: "Basket Reporting Measures"
  }

  measure: basket_yesterday_last_week {
    label: "LW"
    type: number
    sql: ${revenue_yesterday_last_week}/${orders_yesterday_last_week} ;;
    value_format_name: pounds
    group_label: "Basket Reporting Measures"
  }

  measure: basket_yesterday_last_year {
    label: "LY"
    type: number
    sql: ${revenue_yesterday_last_year}/${orders_yesterday_last_year} ;;
    value_format_name: pounds
    group_label: "Basket Reporting Measures"
  }

  measure: basket_week_to_date {
    label: "WTD"
    type: number
    sql: ${revenue_week_to_date}/${orders_week_to_date} ;;
    value_format_name: pounds
    group_label: "Basket Reporting Measures"
  }

  measure: basket_week_to_date_last_week {
    label: "WTD LW"
    type: number
    sql: ${revenue_week_to_date_lw}/${orders_week_to_date_last_week} ;;
    value_format_name: pounds
    group_label: "Basket Reporting Measures"
  }

  measure: basket_week_to_date_last_year {
    label: "WTD LY"
    type: number
    sql: ${revenue_week_to_date_ly}/${orders_week_to_date_last_year} ;;
    value_format_name: pounds
    group_label: "Basket Reporting Measures"
  }

  measure: basket_month_to_date {
    label: "MTD"
    type: number
    sql: ${revenue_month_to_date}/${orders_month_to_date} ;;
    value_format_name: pounds
    group_label: "Basket Reporting Measures"
  }

  measure: basket_month_to_date_last_month {
    label: "MTD LM"
    type: number
    sql: ${revenue_month_to_date_last_month}/${orders_month_to_date_last_month} ;;
    value_format_name: pounds
    group_label: "Basket Reporting Measures"
  }

  measure: basket_month_to_date_last_year {
    label: "MTD LY"
    type: number
    sql: ${revenue_month_to_date_last_year}/${orders_month_to_date_last_year} ;;
    value_format_name: pounds
    group_label: "Basket Reporting Measures"
  }

  measure: basket_year_to_date {
    label: "YTD"
    type: number
    sql: ${revenue_year_to_date}/${orders_year_to_date} ;;
    value_format_name: pounds
    group_label: "Basket Reporting Measures"
  }

  measure: basket_year_to_date_last_year {
    label: "YTD LY"
    type: number
    sql: ${revenue_year_to_date_last_year}/${orders_year_to_date_last_year} ;;
    value_format_name: pounds
    group_label: "Basket Reporting Measures"
  }

  measure: basket_target_yesterday {
    label: "Target Yest"
    type: number
    sql: ${revenue_target_yesterday}/${orders_target_yesterday} ;;
    value_format_name: pounds
    group_label: "Basket Reporting Measures"
  }

  measure: basket_target_week_to_date {
    label: "Target WTD"
    type: number
    sql: ${revenue_target_week_to_date}/${orders_target_week_to_date} ;;
    value_format_name: pounds
    group_label: "Basket Reporting Measures"
  }

  measure: basket_target_month_to_date {
    label: "Target MTD"
    type: number
    sql: ${revenue_target_month_to_date}/${orders_target_month_to_date} ;;
    value_format_name: pounds
    group_label: "Basket Reporting Measures"
  }

  measure: basket_yesterday_wow {
    label: "%"
    type: number
    value_format_name: percent_0
    group_label: "Basket Reporting Measures"
    sql: (${basket_yesterday} - ${basket_yesterday_last_week})/NULLIF(${basket_yesterday_last_week},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: basket_yesterday_yoy {
    label: "YoY"
    type: number
    value_format_name: percent_0
    group_label: "Basket Reporting Measures"
    sql: (${basket_yesterday} - ${basket_yesterday_last_year})/NULLIF(${basket_yesterday_last_year},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: basket_week_to_date_wow {
    label: "WTD WoW"
    type: number
    value_format_name: percent_0
    group_label: "Basket Reporting Measures"
    sql: (${basket_week_to_date} - ${basket_week_to_date_last_week})/NULLIF(${basket_week_to_date_last_week},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: basket_week_to_date_yoy {
    label: "WTD YoY"
    type: number
    value_format_name: percent_0
    group_label: "Basket Reporting Measures"
    sql: (${basket_yesterday} - ${basket_week_to_date_last_year})/NULLIF(${basket_week_to_date_last_year},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: basket_month_to_date_mom {
    label: "MTD MoM"
    type: number
    value_format_name: percent_0
    group_label: "Basket Reporting Measures"
    sql: (${basket_month_to_date} - ${basket_month_to_date_last_month})/NULLIF(${basket_month_to_date_last_month},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: basket_month_to_date_yoy {
    label: "MTD YoY"
    type: number
    value_format_name: percent_0
    group_label: "Basket Reporting Measures"
    sql: (${basket_month_to_date} - ${basket_month_to_date_last_year})/NULLIF(${basket_month_to_date_last_year},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: basket_year_to_date_yoy {
    label: "YTD YoY"
    type: number
    value_format_name: percent_0
    group_label: "Basket Reporting Measures"
    sql: (${basket_year_to_date} - ${basket_year_to_date_last_year})/NULLIF(${basket_year_to_date_last_year},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: basket_yeaterday_vs_target {
    label: "Yest vs Target"
    type: number
    value_format_name: percent_0
    group_label: "Basket Reporting Measures"
    sql: (${basket_yesterday} - ${basket_target_yesterday})/NULLIF(${basket_target_yesterday},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: basket_week_to_date_vs_target {
    label: "WTD vs Target"
    type: number
    value_format_name: percent_0
    group_label: "Basket Reporting Measures"
    sql: (${basket_week_to_date} - ${basket_target_week_to_date})/NULLIF(${basket_target_week_to_date},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

  measure: basket_month_to_date_vs_target {
    label: "MTD vs Target"
    type: number
    value_format_name: percent_0
    group_label: "Basket Reporting Measures"
    sql: (${basket_month_to_date} - ${basket_target_month_to_date})/NULLIF(${basket_target_month_to_date},0)::REAL ;;
    html: {% if value < 0 %}
      <font color="#D77070"> {{ rendered_value }} </font>
      {% elsif value > 0 %}
      <font color="#3CB371"> {{ rendered_value }} </font>
      {% else %}
      <font color="#000000"> {{ rendered_value }} </font>
      {% endif %}
      ;;
  }

}
