CREATE OR REPLACE PACKAGE pkg_etl_load_cl_city AS
       PROCEDURE load_cl_city;
END pkg_etl_load_cl_city;
/

CREATE OR REPLACE PACKAGE BODY pkg_etl_load_cl_city
AS
  PROCEDURE load_cl_city
  IS
  BEGIN
    EXECUTE IMMEDIATE 'truncate table cl_city';
   INSERT
INTO cl_city
  (
    city_name,
    country_id
  )
SELECT c.city as city_name,
       ce.country_id as country_id
FROM  wrk_seller c
	  left join bl_3nf.ce_country ce on c.country = ce.country_name
    union
    select distinct ca.city, cea.country_id from wrk_shops ca
	  left join bl_3nf.ce_country cea on ca.country = cea.country_name;
commit;
  EXCEPTION
  WHEN OTHERS THEN
    RAISE;
  END load_cl_city;
  END pkg_etl_load_cl_city;
/