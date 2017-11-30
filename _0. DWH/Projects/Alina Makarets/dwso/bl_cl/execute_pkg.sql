ALTER SESSION SET nls_date_format = 'DD-MON-YYYY';
ALTER SESSION SET NLS_DATE_LANGUAGE = 'RUSSIAN' ;

BEGIN
    pkg_etl_insert_geo.insert_table_regions;
    pkg_etl_insert_geo.merge_table_ce_regions;
    pkg_etl_insert_geo.insert_table_cities;
    pkg_etl_insert_geo.merge_table_ce_cities;
    pkg_etl_insert_customers.insert_table_customers;
    pkg_etl_insert_customers.merge_table_ce_customers;
    pkg_etl_insert_employees.insert_table_employees;
    pkg_etl_insert_employees.merge_table_ce_employees;
    pkg_etl_insert_shops.insert_table_shops;
    pkg_etl_insert_shops.merge_table_ce_shops;
    pkg_etl_insert_products.insert_table_colors;
    pkg_etl_insert_products.merge_table_ce_colors;
    pkg_etl_insert_products.insert_table_collections;
    pkg_etl_insert_products.merge_table_ce_collections;
    pkg_etl_insert_products.insert_table_categories;
    pkg_etl_insert_products.merge_table_ce_categories;
    pkg_etl_insert_products.insert_table_subcategoris;
    pkg_etl_insert_products.merge_table_ce_subcategories;
    pkg_etl_insert_products.insert_table_products;
    pkg_etl_insert_products.merge_table_ce_products;
    pkg_etl_insert_time_day.insert_table_data;
    pkg_etl_insert_time_day.insert_table_ce_date;
    pkg_etl_insert_sales.insert_table_sales;
    pkg_etl_insert_sales.insert_table_ce_sales;
END;