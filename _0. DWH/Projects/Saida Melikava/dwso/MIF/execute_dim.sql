execute sp_date_dimension(2005,2045);

execute  pckg_insert_customers_dim.insert_bl_cls;
execute pckg_insert_customers_dim.insert_bl_dim;

execute  pckg_insert_products_dim.insert_bl_cls;
execute pckg_insert_products_dim.insert_bl_dim;

execute pckg_insert_payments_dim.insert_bl_dim;

execute pckg_insert_employees_dim.insert_bl_cls;
execute pckg_insert_employees_dim.insert_bl_dim;

execute pckg_insert_stores_dim.insert_bl_cls;
execute pckg_insert_stores_dim.insert_bl_dim;

execute pckg_insert_fact_dim.insert_bl_dim;

