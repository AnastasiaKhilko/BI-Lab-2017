GRANT INSERT,UPDATE,SELECT ON dim_customers TO bl_cl_dm;
GRANT INSERT,UPDATE,SELECT ON dim_employees TO bl_cl_dm;
GRANT INSERT,UPDATE,SELECT ON dim_products TO bl_cl_dm;
GRANT INSERT,UPDATE,SELECT ON dim_shops TO bl_cl_dm;
GRANT INSERT,UPDATE,SELECT ON dim_time_day TO bl_cl_dm;
GRANT INSERT,UPDATE,SELECT ON fct_sales TO bl_cl_dm;


GRANT SELECT ON dim_customers_seq  TO bl_cl_dm;
GRANT SELECT ON dim_employees_seq  TO bl_cl_dm;
GRANT SELECT ON dim_products_seq   TO bl_cl_dm;
GRANT SELECT ON dim_shops_seq      TO bl_cl_dm;