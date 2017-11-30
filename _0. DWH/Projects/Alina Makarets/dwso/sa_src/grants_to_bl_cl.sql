--EXT_CUSTOMERS
GRANT READ ON DIRECTORY external_customers_tables TO bl_cl;
GRANT WRITE ON DIRECTORY external_customers_tables TO bl_cl;
GRANT SELECT ON ext_customers to bl_cl;

--EXT_SHOPS
GRANT READ ON DIRECTORY external_shops_tables TO bl_cl;
GRANT WRITE ON DIRECTORY external_shops_tables TO bl_cl;
GRANT SELECT ON ext_shops to bl_cl;

--EXT_CUSTOMERS
GRANT READ ON DIRECTORY external_employees_tables TO bl_cl;
GRANT WRITE ON DIRECTORY external_employees_tables TO bl_cl;
GRANT SELECT ON ext_employees to bl_cl;

--EXT_CUSTOMERS
GRANT READ ON DIRECTORY external_products_tables TO bl_cl;
GRANT WRITE ON DIRECTORY external_products_tables TO bl_cl;
GRANT SELECT ON ext_products to bl_cl;