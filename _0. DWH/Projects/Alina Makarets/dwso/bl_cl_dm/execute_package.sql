ALTER SESSION SET nls_date_format = 'DD-MON-YYYY';
ALTER SESSION SET NLS_DATE_LANGUAGE = 'RUSSIAN' ;

BEGIN
    pkg_etl_insert_customers.insert_table_customers;
    pkg_etl_insert_customers.merge_table_dim_customers;
    pkg_etl_insert_employees.insert_table_employees;
    pkg_etl_insert_employees.merge_table_dim_employees;
    pkg_etl_insert_products.insert_table_products;
    pkg_etl_insert_products.merge_table_dim_products;
    pkg_etl_insert_shops.insert_table_shops;
    pkg_etl_insert_shops.merge_table_dim_shops;
    pkg_etl_insert_time_day.insert_table_dim_time_day;
    pkg_etl_insert_fct_table.insert_table_dim_fct_table;
END;