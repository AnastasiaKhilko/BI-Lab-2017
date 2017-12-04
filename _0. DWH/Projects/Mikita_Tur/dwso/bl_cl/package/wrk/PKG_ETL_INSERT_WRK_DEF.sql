CREATE OR REPLACE PACKAGE pkg_etl_insert_wrk
  AS
     PROCEDURE insert_wrk_countries;
     PROCEDURE insert_wrk_cities;
      PROCEDURE insert_wrk_customers;
     PROCEDURE insert_wrk_products;
	 PROCEDURE insert_wrk_suppliers;
END pkg_etl_insert_wrk;
/    
