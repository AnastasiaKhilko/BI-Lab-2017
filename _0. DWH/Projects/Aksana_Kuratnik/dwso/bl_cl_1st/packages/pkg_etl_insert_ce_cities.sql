--PKG_INSERT_CITIES.
CREATE OR REPLACE PACKAGE pkg_etl_insert_cities
AUTHID CURRENT_USER
AS
  PROCEDURE merge_ce_cities;
END pkg_etl_insert_cities;
/
CREATE OR REPLACE PACKAGE BODY pkg_etl_insert_cities
AS
PROCEDURE merge_ce_cities
IS
BEGIN

MERGE INTO bl_3nf.ce_cities t USING
    ( SELECT country_id,
             city_id, 
             city_desc
      FROM   cls_cities
    MINUS
      SELECT country_srcid,
             city_srcid AS city_id,
             city_desc      
      FROM   bl_3nf.ce_cities
    ) c ON ( c.city_id = t.city_srcid)
    WHEN NOT matched THEN
    INSERT
      (
        city_id,
        city_srcid,
        country_srcid,
        city_desc
      )
      VALUES
      (
        bl_3nf.ce_cities_seq.NEXTVAL,
        c.city_id,
        c.country_id,
        c.city_desc
      ) ;
    COMMIT;
EXCEPTION
WHEN OTHERS THEN
    RAISE;
END merge_ce_cities;

END pkg_etl_insert_cities;
/