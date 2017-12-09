--PKG_INSERT_COUNTRIES.
CREATE OR REPLACE PACKAGE pkg_etl_insert_countries
AUTHID CURRENT_USER
AS
  PROCEDURE merge_ce_countries;
END pkg_etl_insert_countries;
/
CREATE OR REPLACE PACKAGE BODY pkg_etl_insert_countries
AS
PROCEDURE merge_ce_countries
IS
BEGIN

MERGE INTO bl_3nf.ce_countries t USING
    ( SELECT region_id,
             country_id, 
             country_desc  
      FROM   cls_countries
    MINUS
      SELECT region_srcid,
             country_srcid AS country_id,
             country_desc    
      FROM   bl_3nf.ce_countries
    ) c ON ( c.country_id = t.country_srcid
        AND  c.region_id = t.region_srcid 
        AND  c.country_desc = t.country_desc)
    WHEN NOT matched THEN
    INSERT
      (
        country_ID ,
        country_SRCID ,
        region_srcid,
        country_desc
      )
      VALUES
      (
        bl_3nf.ce_countries_seq.NEXTVAL,
        c.country_id,
        c.region_id,
        c.country_desc 
      ) ;
    COMMIT;
EXCEPTION
WHEN OTHERS THEN
    RAISE;
END merge_ce_countries;

END pkg_etl_insert_countries;
/