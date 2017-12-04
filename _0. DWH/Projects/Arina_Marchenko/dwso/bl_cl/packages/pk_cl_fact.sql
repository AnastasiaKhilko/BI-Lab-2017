CREATE OR REPLACE PACKAGE pkg_etl_load_cl_fact AS
       PROCEDURE load_cl_fact;
END pkg_etl_load_cl_fact;
/

CREATE OR REPLACE PACKAGE BODY pkg_etl_load_cl_fact
AS
  PROCEDURE load_cl_fact
  IS
  BEGIN
    EXECUTE IMMEDIATE 'truncate table cl_fact';
   INSERT
INTO cl_fact
  (
    order_code,
    cost,
    minPrice,
    maxPrice,
    avgPrice,
    sdPrice,
    start_dt,
    end_dt
  )
SELECT DISTINCT order_code,
      cost,
      minPrice,
      maxPrice,
      avgPrice,
      sdPrice,
      start_dt,
      end_dt
FROM  wrk_fact 
  commit;
  EXCEPTION
  WHEN OTHERS THEN
    RAISE;
  END load_cl_fact;
  END pkg_etl_load_cl_fact;
/