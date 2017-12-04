EXECUTE pckg_insert_geodata.insert_bl_wrk(source_table=>'src.ext_goroda', target_table_wrk=>'wrk_geodata');
EXECUTE pckg_insert_districts.insert_bl_cls(source_table_wrk=>'wrk_geodata', target_table_cls=>'cls_districts');
EXECUTE pckg_insert_districts.insert_bl_3nf;
EXECUTE pckg_insert_regions.insert_bl_cls(source_table_wrk=>'wrk_geodata', target_table_cls=>'cls_regions');
EXECUTE pckg_insert_regions.insert_bl_3nf;
EXECUTE pckg_insert_cities.insert_bl_cls(source_table_wrk=>'wrk_geodata', target_table_cls=>'cls_cities');
EXECUTE pckg_insert_cities.insert_bl_3nf;
EXECUTE pckg_insert_genre.insert_bl_cls(source_table=>'src.ext_catalog', target_table_cls=>'cls_genre');
EXECUTE pckg_insert_genre.insert_bl_3nf;
EXECUTE pckg_insert_auth.insert_bl_cls(source_table=>'src.ext_catalog', target_table_cls=>'cls_authors');
EXECUTE pckg_insert_auth.insert_bl_3nf;
EXECUTE pckg_insert_category.insert_bl_cls;
EXECUTE pckg_insert_category.insert_bl_3nf;
EXECUTE pckg_insert_cat_print.insert_bl_wrk(source_table=>'src.ext_catalog',target_table_wrk=>'wrk_catalog_print');
EXECUTE pckg_insert_cat_print.insert_bl_cls(source_table_wrk=>'wrk_catalog_print', target_table_cls=>'cls_catalog');
EXECUTE pckg_insert_cat_print.insert_bl_3nf;
EXECUTE pckg_insert_customers.insert_bl_wrk(source_table=>'src.ext_customers', target_table_wrk=>'wrk_customers');
EXECUTE pckg_insert_customers.insert_bl_cls(source_table_wrk=>'wrk_customers', target_table_cls=>'cls_customers');
EXECUTE pckg_insert_customers.insert_bl_3nf;
EXECUTE pckg_insert_dep.insert_bl_wrk(source_table=>'src.ext_departments', target_table_wrk=>'wrk_departments');
EXECUTE pckg_insert_dep.insert_bl_cls(source_table_wrk=>'wrk_departments', target_table_cls=>'cls_departments');
EXECUTE pckg_insert_dep.insert_bl_3nf;
EXECUTE pckg_insert_employees.insert_bl_wrk(source_table=>'src.ext_employee', target_table_wrk=>'wrk_employees');
EXECUTE pckg_insert_employees.insert_bl_cls(source_table_wrk=>'wrk_employees', target_table_cls=>'cls_employees');
EXECUTE pckg_insert_employees.insert_bl_3nf;

EXECUTE pckg_insert_store.insert_bl_wrk(source_table=>'src.ext_shop_chit_gorod', target_table_wrk=>'wrk_stores');

EXECUTE pckg_insert_addr.insert_bl_wrk(source_table=>'wrk_stores', target_table_wrk=>'wrk_addr');
EXECUTE pckg_insert_addr.insert_bl_cls(source_table_wrk=>'wrk_addr', target_table_cls=>'cls_addr');
EXECUTE pckg_insert_addr.insert_bl_3nf;

EXECUTE pckg_insert_store.insert_bl_cls(source_table_wrk=>'wrk_stores', target_table_cls=>'cls_stores');
EXECUTE pckg_insert_store.insert_bl_3nf;
EXECUTE pckg_insert_payment.insert_bl_wrk(source_table=>'src.ext_payment', target_table_wrk=>'wrk_payment');
EXECUTE pckg_insert_payment.insert_bl_3nf;


EXECUTE pckg_insert_fact.insert_bl_cls(target_table_cls=>'cls_fct_sales');
EXECUTE pckg_insert_fact.insert_bl_3nf(target_table_3nf=>'bl_3nf.ce_fct_sales');