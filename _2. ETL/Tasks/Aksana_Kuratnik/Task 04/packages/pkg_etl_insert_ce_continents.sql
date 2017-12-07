--PKG_INSERT_CONTINENTS.
CREATE OR REPLACE PACKAGE pkg_etl_insert_continents
AUTHID CURRENT_USER
AS
  PROCEDURE merge_ce_continents;
END pkg_etl_insert_continents;
/
CREATE OR REPLACE PACKAGE BODY pkg_etl_insert_continents
AS
PROCEDURE merge_ce_continents
IS
BEGIN

MERGE INTO bl_3nf.ce_continents t USING
    ( SELECT continent_id, 
             continent_name
      FROM   cls_continents
    MINUS
      SELECT continent_srcid AS continent_id,
             continent_name          
      FROM   bl_3nf.ce_continents
    ) c ON ( c.continent_id = t.continent_srcid
        AND  c.continent_name = t.continent_name)
    WHEN NOT matched THEN
    INSERT
      (
        continent_id,
        continent_srcid,
        continent_name
      )
      VALUES
      (
        bl_3nf.ce_continents_seq.NEXTVAL,
        c.continent_id,
        c.continent_name
      ) ;
    COMMIT;
EXCEPTION
WHEN OTHERS THEN
    RAISE;
END merge_ce_continents;
END pkg_etl_insert_continents;
/