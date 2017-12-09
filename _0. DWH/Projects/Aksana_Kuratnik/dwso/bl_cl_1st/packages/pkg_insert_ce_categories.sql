CREATE OR REPLACE PACKAGE pkg_etl_insert_categories
AUTHID CURRENT_USER
AS
  PROCEDURE merge_ce_categories;
END pkg_etl_insert_categories;
/
CREATE OR REPLACE PACKAGE BODY pkg_etl_insert_categories
AS
PROCEDURE merge_ce_categories
IS
BEGIN

MERGE INTO bl_3nf.ce_categories t USING
    ( SELECT category_id,
             category_name,
             start_dt AS update_dt
      FROM   cls_categories
    MINUS
      SELECT category_srcid AS category_id,
             category_name,
             update_dt
      FROM   bl_3nf.ce_categories
    ) c ON (c.category_name = t.category_name
        AND c.category_id = t.category_srcid
            )
    WHEN MATCHED THEN
    UPDATE SET
          t.update_dt  = SYSDATE
    WHEN NOT matched THEN
    INSERT
      (
        category_id,
        category_srcid,
        category_name,
        update_dt
      )
      VALUES
      (
        bl_3nf.ce_categories_seq.NEXTVAL,
        c.category_id,
        c.category_name,
        SYSDATE
      ) ;
    COMMIT;
EXCEPTION
WHEN OTHERS THEN
    RAISE;
END merge_ce_categories;
END pkg_etl_insert_categories;
/