--PKG_INSERT_REGIONS.
CREATE OR REPLACE PACKAGE pkg_etl_insert_regions
AUTHID CURRENT_USER
AS
  PROCEDURE merge_ce_regions;
END pkg_etl_insert_regions;
/
CREATE OR REPLACE PACKAGE BODY pkg_etl_insert_regions
AS
PROCEDURE merge_ce_regions
IS
BEGIN
MERGE INTO bl_3nf.ce_regions t USING
    ( SELECT continent_id,
             region_id, 
             region_desc
      FROM   cls_regions
    MINUS
      SELECT continent_srcid,
             region_srcid AS region_id,
             region_desc          
      FROM   bl_3nf.ce_regions
    ) c ON ( c.region_id = t.region_srcid
       AND   c.continent_id = t.continent_srcid
       AND   c.region_desc = t.region_desc)
    WHEN NOT matched THEN
    INSERT
      (
        region_ID ,
        region_srcid ,
        continent_srcid,
        region_desc
      )
      VALUES
      (
        bl_3nf.ce_regions_seq.NEXTVAL,
        c.region_id,
        c.continent_id,
        c.region_desc
      ) ;
    COMMIT;
EXCEPTION
WHEN OTHERS THEN
    RAISE;
END merge_ce_regions;

END pkg_etl_insert_regions;
/