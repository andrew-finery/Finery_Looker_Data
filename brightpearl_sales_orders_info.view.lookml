- view: brightpearl_sales_orders_info
  sql_table_name: brightpearl.sales_orders_info
  fields:

  - dimension: id
    primary_key: true
    type: number
    sql: ${TABLE}.id

  - dimension: assignment_channel_id
    type: number
    sql: ${TABLE}.assignment_channel_id

  - dimension: assignment_lead_source_id
    type: number
    sql: ${TABLE}.assignment_lead_source_id

  - dimension: assignment_project_id
    type: number
    sql: ${TABLE}.assignment_project_id

  - dimension: assignment_staff_owner_contact_id
    type: number
    sql: ${TABLE}.assignment_staff_owner_contact_id

  - dimension: assignment_team_id
    type: number
    sql: ${TABLE}.assignment_team_id

  - dimension: billing_address_fullname
    type: string
    sql: ${TABLE}.billing_address_fullname

  - dimension: billing_addressline1
    type: string
    sql: ${TABLE}.billing_addressline1

  - dimension: billing_addressline2
    type: string
    sql: ${TABLE}.billing_addressline2

  - dimension: billing_addressline3
    type: string
    sql: ${TABLE}.billing_addressline3

  - dimension: billing_addressline4
    type: string
    sql: ${TABLE}.billing_addressline4

  - dimension: billing_company_name
    type: string
    sql: ${TABLE}.billing_company_name

  - dimension: billing_contact_id
    type: number
    sql: ${TABLE}.billing_contact_id

  - dimension: billing_country
    type: string
    sql: ${TABLE}.billing_country

  - dimension: billing_countryisocode
    type: string
    sql: ${TABLE}.billing_countryisocode

  - dimension: billing_countryisocode3
    type: string
    sql: ${TABLE}.billing_countryisocode3

  - dimension: billing_email
    type: string
    sql: ${TABLE}.billing_email

  - dimension: billing_mobile_telephone
    type: string
    sql: ${TABLE}.billing_mobile_telephone

  - dimension: billing_postalcode
    type: string
    sql: ${TABLE}.billing_postalcode

  - dimension: billing_telephone
    type: string
    sql: ${TABLE}.billing_telephone

  - dimension: created_by_id
    type: number
    sql: ${TABLE}.created_by_id

  - dimension: created_on
    type: string
    sql: ${TABLE}.created_on

  - dimension: currency_accounting_currency_code
    type: string
    sql: ${TABLE}.currency_accounting_currency_code

  - dimension: currency_exchange_rate
    type: number
    sql: ${TABLE}.currency_exchange_rate

  - dimension: currency_order_currency_code
    type: string
    sql: ${TABLE}.currency_order_currency_code

  - dimension: customer__company_name
    type: string
    sql: ${TABLE}.customer__company_name

  - dimension: customer_address_full_name
    type: string
    sql: ${TABLE}.customer_address_full_name

  - dimension: customer_addressline1
    type: string
    sql: ${TABLE}.customer_addressline1

  - dimension: customer_addressline2
    type: string
    sql: ${TABLE}.customer_addressline2

  - dimension: customer_addressline3
    type: string
    sql: ${TABLE}.customer_addressline3

  - dimension: customer_addressline4
    type: string
    sql: ${TABLE}.customer_addressline4

  - dimension: customer_contact_id
    type: number
    sql: ${TABLE}.customer_contact_id

  - dimension: customer_country
    type: string
    sql: ${TABLE}.customer_country

  - dimension: customer_country_isocode
    type: string
    sql: ${TABLE}.customer_country_isocode

  - dimension: customer_country_isocode3
    type: string
    sql: ${TABLE}.customer_country_isocode3

  - dimension: customer_email
    type: string
    sql: ${TABLE}.customer_email

  - dimension: customer_mobile_telephone
    type: string
    sql: ${TABLE}.customer_mobile_telephone

  - dimension: customer_postal_code
    type: string
    sql: ${TABLE}.customer_postal_code

  - dimension: customer_telephone
    type: string
    sql: ${TABLE}.customer_telephone

  - dimension: delivery_address_full_name
    type: string
    sql: ${TABLE}.delivery_address_full_name

  - dimension: delivery_addressline1
    type: string
    sql: ${TABLE}.delivery_addressline1

  - dimension: delivery_addressline2
    type: string
    sql: ${TABLE}.delivery_addressline2

  - dimension: delivery_addressline3
    type: string
    sql: ${TABLE}.delivery_addressline3

  - dimension: delivery_addressline4
    type: string
    sql: ${TABLE}.delivery_addressline4

  - dimension: delivery_company_name
    type: string
    sql: ${TABLE}.delivery_company_name

  - dimension: delivery_country
    type: string
    sql: ${TABLE}.delivery_country

  - dimension: delivery_country_isocode
    type: string
    sql: ${TABLE}.delivery_country_isocode

  - dimension: delivery_country_isocode3
    type: string
    sql: ${TABLE}.delivery_country_isocode3

  - dimension: delivery_email
    type: string
    sql: ${TABLE}.delivery_email

  - dimension: delivery_mobile_telephone
    type: string
    sql: ${TABLE}.delivery_mobile_telephone

  - dimension: delivery_postalcode
    type: string
    sql: ${TABLE}.delivery_postalcode

  - dimension: delivery_telephone
    type: string
    sql: ${TABLE}.delivery_telephone

  - dimension: invoice_due_date
    type: string
    sql: ${TABLE}.invoice_due_date

  - dimension: invoice_reference
    type: string
    sql: ${TABLE}.invoice_reference

  - dimension: invoice_tax_date
    type: string
    sql: ${TABLE}.invoice_tax_date

  - dimension: order_status_name
    type: string
    sql: ${TABLE}.order_status_name

  - dimension: order_type_code
    type: string
    sql: ${TABLE}.order_type_code

  - dimension: orders_tatus_id
    type: number
    sql: ${TABLE}.orders_tatus_id

  - dimension: placed_on
    type: string
    sql: ${TABLE}.placed_on

  - dimension: price_list_id
    type: number
    sql: ${TABLE}.price_list_id

  - dimension: price_mode_code
    type: string
    sql: ${TABLE}.price_mode_code

  - dimension: shipping_method_id
    type: number
    sql: ${TABLE}.shipping_method_id

  - dimension: shipping_status_code
    type: string
    sql: ${TABLE}.shipping_status_code

  - dimension: stock_status_code
    type: string
    sql: ${TABLE}.stock_status_code

  - dimension: total__value_base_tax_amount
    type: number
    sql: ${TABLE}.total__value_base_tax_amount

  - dimension: total_value_base_net
    type: number
    sql: ${TABLE}.total_value_base_net

  - dimension: total_value_base_total
    type: number
    sql: ${TABLE}.total_value_base_total

  - dimension: total_value_net
    type: number
    sql: ${TABLE}.total_value_net

  - dimension: total_value_tax_amount
    type: number
    sql: ${TABLE}.total_value_tax_amount

  - dimension: total_value_total
    type: number
    sql: ${TABLE}.total_value_total



  # ----- Sets of fields for drilling ------


