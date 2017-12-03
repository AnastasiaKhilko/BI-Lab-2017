CREATE OR REPLACE PACKAGE pkg_etl_load_ce_orders AS
       PROCEDURE load_ce_orders;
END pkg_etl_load_ce_orders;
/

CREATE OR REPLACE PACKAGE BODY pkg_etl_load_ce_orders
AS
  PROCEDURE load_ce_orders
  IS
  BEGIN
    EXECUTE IMMEDIATE 'truncate table bl_3nf.ce_orders';
   INSERT
INTO bl_3nf.ce_orders(
	car_id,
	customer_id,
	shop_id,
	seller_id,
    order_code,
    cost,
    minPrice,
    maxPrice,
    avgPrice,
    sdPrice,
    start_dt,
    end_dt
  )
SELECT 
	  ROUND ( dbms_random.value (
  ( SELECT MIN ( car_id ) FROM bl_3nf.ce_cars ) ,
  (SELECT MAX ( car_id ) FROM bl_3nf.ce_cars) 
  )
  )  AS car_id,
  ROUND ( dbms_random.value ( 
  (SELECT MIN ( customer_id ) FROM bl_3nf.ce_customers ) ,
  (SELECT MAX ( customer_id ) FROM bl_3nf.ce_customers )
  )
  ) AS customer_id,
ROUND ( dbms_random.value ( 
  (SELECT MIN ( shop_id ) FROM bl_3nf.ce_shop ) ,
  (SELECT MAX ( shop_id ) FROM bl_3nf.ce_shop )
  )
  ) AS shop_id,
  ROUND ( dbms_random.value ( 
  (SELECT MIN ( seller_id ) FROM bl_3nf.ce_seller ) ,
  (SELECT MAX ( seller_id ) FROM bl_3nf.ce_seller)
  )
  ) AS seller_id,
  clf.order_code, clf.cost, clf.minPrice, clf.maxPrice,
      clf.avgPrice, clf.sdPrice, clf.start_dt, clf.end_dt
  FROM ( SELECT distinct order_code, cost, minPrice, maxPrice,
      avgPrice, sdPrice, start_dt, end_dt from cl_fact)clf,
  (select * from dual connect by level <= 1000);

  commit;
  EXCEPTION
  WHEN OTHERS THEN
    RAISE;
  END load_ce_orders;
  END pkg_etl_load_ce_orders;
/