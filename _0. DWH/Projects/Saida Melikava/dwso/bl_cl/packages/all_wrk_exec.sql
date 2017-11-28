EXECUTE pckg_insert_geodata.insert_bl_wrk(source_table=>'src.ext_goroda', target_table_wrk=>'wrk_geodata');
EXECUTE pckg_insert_cat_print.insert_bl_wrk(source_table=>'src.ext_catalog', target_table_wrk=>'wrk_catalog_print');
EXECUTE pckg_insert_customers.insert_bl_wrk(source_table=>'src.ext_customers', target_table_wrk=>'wrk_customers');
EXECUTE pckg_insert_payment.insert_bl_wrk(source_table=>'src.ext_payment', target_table_wrk=>'wrk_payment');
EXECUTE pckg_insert_employees.insert_bl_wrk(source_table=>'src.ext_employee', target_table_wrk=>'wrk_employees');
EXECUTE pckg_insert_store.insert_bl_wrk(source_table=>'src.ext_shop_chit_gorod', target_table_wrk=>'wrk_stores');
EXECUTE pckg_insert_addr.insert_bl_wrk(source_table=>'wrk_stores', target_table_wrk=>'wrk_addr');
EXECUTE pckg_insert_dep.insert_bl_wrk(source_table=>'src.ext_departments', target_table_wrk=>'wrk_departments');