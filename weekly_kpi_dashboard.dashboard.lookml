- dashboard: weekly_kpi_dashboard
  title: Weekly Kpi Dashboard
  layout: tile
  tile_size: 100

#  filters:

  elements:

  - name: orders_wow
    title: Orders WoW
    type: table
    model: finery_data
    explore: spree_orders
    dimensions: [calendar_weeks.year_week_number]
    measures: [spree_orders.count_orders]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Week on Week
      expression: |
        (${spree_orders.count_orders} - offset(${spree_orders.count_orders},1))/offset(${spree_orders.count_orders},1)
      value_format: '#0.00%'
    filters:
      calendar_weeks.calendar_date_date: 2 weeks ago for 2 weeks
    sorts: [calendar_weeks.year_week_number desc]
    limit: 500
    column_limit: ''
    height: 2
    width: 3
    

  - name: basket_size_wow
    title: Basket Size Week on Week
    type: table
    model: finery_data
    explore: spree_orders
    dimensions: [calendar_weeks.year_week_number]
    measures: [spree_orders.avg_gross_revenue_ex_discount_in_gbp_ex_vat]
    dynamic_fields:
    - table_calculation: week_on_week
      label: Week on Week
      expression: |+
        (${spree_orders.avg_gross_revenue_ex_discount_in_gbp_ex_vat} - offset(${spree_orders.avg_gross_revenue_ex_discount_in_gbp_ex_vat},1))/(offset(${spree_orders.avg_gross_revenue_ex_discount_in_gbp_ex_vat},1))
  
      value_format: '#0.00%'
    filters:
      calendar_weeks.calendar_date_date: 2 weeks ago for 2 weeks
    sorts: [calendar_weeks.year_week_number desc]
    limit: 500
    column_limit: ''
    height: 2
    width: 3
