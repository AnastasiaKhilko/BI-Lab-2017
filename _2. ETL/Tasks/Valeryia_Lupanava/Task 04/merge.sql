---------------------------------------------------
PROCEDURE merge_table_ce_continents
IS
BEGIN

MERGE INTO bl_3nf.ce_continents t USING
    ( SELECT continent_id, 
             continent_desc
      FROM   cls_continents
    MINUS
      SELECT continent_srcid AS continent_id,
             continent_desc          
      FROM   bl_3nf.ce_continents
    ) c ON ( c.continent_id = t.continent_srcid )
    WHEN matched THEN
    UPDATE SET t.continent_desc = c.continent_desc 
    WHEN NOT matched THEN
    INSERT
      (
        continent_ID ,
        continent_SRCID ,
        continent_desc
      )
      VALUES
      (
        bl_3nf.ce_continents_seq.NEXTVAL,
        c.continent_ID ,
        c.continent_desc
      ) ;
    COMMIT;
EXCEPTION
WHEN OTHERS THEN
    RAISE;
END merge_table_ce_continents;
---------------------------------------------------