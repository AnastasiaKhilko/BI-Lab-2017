CREATE OR REPLACE PACKAGE pkg_etl_insert_deliv_methods
AUTHID CURRENT_USER
AS
  PROCEDURE merge_ce_deliv_methods;
						
END pkg_etl_insert_deliv_methods;
/
CREATE OR REPLACE PACKAGE BODY pkg_etl_insert_deliv_methods
AS
PROCEDURE merge_ce_deliv_methods
IS
BEGIN

MERGE INTO bl_3nf.ce_delivery_methods t USING
    ( SELECT delivery_method_id,
             delivery_method,
             start_dt,
             end_dt,
             is_active
      FROM   cls_delivery_methods
    MINUS
      SELECT delivery_method_srcid AS delivery_method_id,
             delivery_method_desc AS delivery_method,
             start_dt,
             end_dt,
             is_active
      FROM   bl_3nf.ce_delivery_methods
    ) c ON ( c.delivery_method = t.delivery_method_desc
       AND   c.delivery_method_id = t.delivery_method_srcid
       AND   c.start_dt = t.start_dt
            )
    WHEN matched THEN
    UPDATE SET 
               t.end_dt  = c.end_dt,
               t.is_active = c.is_active
    WHEN NOT matched THEN
    INSERT
      (
        delivery_method_id,
        delivery_method_srcid,
        delivery_method_desc,
        start_dt,
        end_dt,
        is_active
      )
      VALUES
      (
        bl_3nf.ce_delivery_methods_seq.NEXTVAL,
        c.delivery_method_id,
        c.delivery_method,
        c.start_dt,
        c.end_dt,
        c.is_active
      ) ;
    COMMIT;
EXCEPTION
WHEN OTHERS THEN
    RAISE;
END merge_ce_deliv_methods;
END pkg_etl_insert_deliv_methods;
/