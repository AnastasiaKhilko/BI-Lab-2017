CONNECT src/123456;
show user;
@D:\MIF\sa_scr\create_all_src.sql;

CONNECT BL_CL/123456;
show user;
@D:\MIF\bl_cl\tables\wrk_addresses;
@D:\MIF\bl_cl\tables\wrk_catalog_print;
@D:\MIF\bl_cl\tables\wrk_customers;
@D:\MIF\bl_cl\tables\wrk_departments;
@D:\MIF\bl_cl\tables\wrk_employees;
@D:\MIF\bl_cl\tables\wrk_geodata;
@D:\MIF\bl_cl\tables\wrk_payment;
@D:\MIF\bl_cl\tables\wrk_stores;

@D:\MIF\bl_cl\tables\cls_addr;
@D:\MIF\bl_cl\tables\cls_authors;
@D:\MIF\bl_cl\tables\cls_catalog;
@D:\MIF\bl_cl\tables\cls_category;
@D:\MIF\bl_cl\tables\cls_cities;
@D:\MIF\bl_cl\tables\cls_customers;
@D:\MIF\bl_cl\tables\cls_departments;
@D:\MIF\bl_cl\tables\cls_districts;
@D:\MIF\bl_cl\tables\cls_employees;
@D:\MIF\bl_cl\tables\cls_fct_sales;
@D:\MIF\bl_cl\tables\cls_genre;
@D:\MIF\bl_cl\tables\cls_regions;
@D:\MIF\bl_cl\tables\cls_stores;
@D:\MIF\bl_cl\create_seq;

CONNECT BL_3NF/123456;
show user;
@D:\MIF\bl_3nf\tables\ce_districts;
@D:\MIF\bl_3nf\tables\ce_regions;
@D:\MIF\bl_3nf\tables\ce_cities;
@D:\MIF\bl_3nf\tables\ce_addr;
@D:\MIF\bl_3nf\tables\ce_genres;
@D:\MIF\bl_3nf\tables\ce_authors;
@D:\MIF\bl_3nf\tables\ce_categories;
@D:\MIF\bl_3nf\tables\ce_catalog;
@D:\MIF\bl_3nf\tables\ce_customers;
@D:\MIF\bl_3nf\tables\ce_departments;
@D:\MIF\bl_3nf\tables\ce_employees;
@D:\MIF\bl_3nf\tables\ce_stores;
@D:\MIF\bl_3nf\tables\ce_payments;
@D:\MIF\bl_3nf\tables\ce_fct_sales;



CONNECT BL_CL/123456;
show user;

@D:\MIF\bl_cl\packages\pckg_insert_geodata;
@D:\MIF\bl_cl\packages\pckg_insert_districts;
@D:\MIF\bl_cl\packages\pckg_insert_regions;
@D:\MIF\bl_cl\packages\pckg_insert_cities;
@D:\MIF\bl_cl\packages\pckg_insert_genre;
@D:\MIF\bl_cl\packages\pckg_insert_auth;
@D:\MIF\bl_cl\packages\pckg_insert_category;
@D:\MIF\bl_cl\packages\pckg_insert_catalog_print;
@D:\MIF\bl_cl\packages\pckg_insert_cust;
@D:\MIF\bl_cl\packages\pckg_insert_employees;
@D:\MIF\bl_cl\packages\pckg_insert_departments;
@D:\MIF\bl_cl\packages\pckg_insert_payment;
@D:\MIF\bl_cl\packages\pckg_insert_stores;
@D:\MIF\bl_cl\packages\pckg_insert_addresses;
@D:\MIF\bl_cl\packages\pckg_insert_fct;

CONNECT BL_CL/123456;
show user;
@D:\MIF\bl_cl\create_seq;
@D:\MIF\exec_src_3nf;


CONNECT BL_3NF/123456;
show user;
@D:\MIF\bl_3nf\insert_default;
@D:\MIF\bl_3nf\tables\ce_emp_constr;


CONNECT BL_CL_DM/123456;
show user;
@D:\MIF\bl_cl_dm\tables\dim_cl_customers;
@D:\MIF\bl_cl_dm\tables\dim_cl_employees;
@D:\MIF\bl_cl_dm\tables\dim_cl_products;
@D:\MIF\bl_cl_dm\tables\dim_cl_stores_SCD;

@D:\MIF\bl_cl_dm\packages\pckg_insert_stores_dim;
@D:\MIF\bl_cl_dm\packages\pckg_insert_products_dim;
@D:\MIF\bl_cl_dm\packages\pckg_insert_employees_dim;
@D:\MIF\bl_cl_dm\packages\pckg_insert_customers_dim;
@D:\MIF\bl_cl_dm\packages\pckg_insert_payments_dim;
@D:\MIF\bl_cl_dm\packages\proc_DimDate;
@D:\MIF\bl_cl_dm\packages\pckg_insert_fct_dim;


CONNECT BL_DM/123456;
show user;
@D:\MIF\bl_dm\create_tbs;
@D:\MIF\bl_dm\tables\Dim_Customers\Dim_Customers;
@D:\MIF\bl_dm\tables\Dim_Employees\Dim_Employees;
@D:\MIF\bl_dm\tables\Dim_Payments\Dim_Payments;
@D:\MIF\bl_dm\tables\Dim_Products\Dim_Products;
@D:\MIF\bl_dm\tables\Dim_Stores_SCD\Dim_Stores_SCD;
@D:\MIF\bl_dm\tables\Dim_Time_Day\Dim_Time_Day;
@D:\MIF\bl_dm\tables\Fct_Sales\Fct_sales;
@D:\MIF\insert_default_dim;

CONNECT BL_CL_DM/123456;
show user;
@D:\MIF\bl_cl_dm\create_seq_dim;
@D:\MIF\execute_dim;