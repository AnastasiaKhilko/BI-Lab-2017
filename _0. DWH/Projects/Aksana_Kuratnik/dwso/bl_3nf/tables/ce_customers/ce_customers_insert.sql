--CE_CUSTOMERS_INSERT.
BEGIN
  pkg_etl_insert_customers.merge_ce_customers;
END; 
/