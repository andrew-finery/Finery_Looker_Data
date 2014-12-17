- dashboard: returns_dashboard
  title: Returns Dashboard
  layout: tile
  tile_size: 100

#  filters:

  elements:

- name: add_a_unique_name_289
  title: Untitled Table
  type: table
  model: finery_data
  explore: spree_order_items
  dimensions: [online_products.online_department]
  measures: [spree_order_items.total_items_sold, spree_order_items.total_items_returned,
    spree_order_items.return_rate]
  filters:
    spree_orders.completed_date: before 3 days ago
  sorts: [spree_order_items.return_rate desc]
  limit: 500

