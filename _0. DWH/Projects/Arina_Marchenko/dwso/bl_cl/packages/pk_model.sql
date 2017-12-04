CREATE OR REPLACE PACKAGE pkg_etl_load_cl_model AS
       PROCEDURE load_cl_model;
END pkg_etl_load_cl_model;
/

CREATE OR REPLACE PACKAGE BODY pkg_etl_load_cl_model
AS
  PROCEDURE load_cl_model
  IS
  BEGIN
    EXECUTE IMMEDIATE 'truncate table cl_model';
   INSERT
INTO cl_model
  (
    model_name,
    brand_id
  )
SELECT DISTINCT
       c.model as model_name,
       ce.brand_id as brand_id
FROM wrk_cars c
	  left join bl_3nf.ce_brand ce on c.brand = ce.brand_name;
commit;
  EXCEPTION
  WHEN OTHERS THEN
    RAISE;
  END load_cl_model;
  END pkg_etl_load_cl_model;
/
