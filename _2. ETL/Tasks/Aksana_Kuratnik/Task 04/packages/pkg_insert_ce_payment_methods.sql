CREATE OR REPLACE PACKAGE pkg_etl_insert_payment_methods
AUTHID CURRENT_USER
AS
  PROCEDURE merge_ce_payment_methods;
						
END pkg_etl_insert_payment_methods;
/
CREATE OR REPLACE PACKAGE BODY pkg_etl_insert_payment_methods
AS
PROCEDURE merge_ce_payment_methods
IS
BEGIN

MERGE INTO bl_3nf.ce_payment_methods t USING
    ( SELECT payment_method_id,
             payment_method,
             start_dt,
             end_dt,
             is_active
      FROM   cls_payment_methods
    MINUS
      SELECT payment_method_srcid AS payment_method_id,
             payment_method_desc AS payment_method,
             start_dt,
             end_dt,
             is_active
      FROM   bl_3nf.ce_payment_methods
    ) c ON ( c.payment_method = t.payment_method_desc
       AND   c.payment_method_id = t.payment_method_srcid
       AND   c.start_dt = t.start_dt
            )
    WHEN matched THEN
    UPDATE SET 
               t.end_dt  = c.end_dt,
               t.is_active = c.is_active
    WHEN NOT matched THEN
    INSERT
      (
        payment_method_id,
        payment_method_srcid,
        payment_method_desc,
        start_dt,
        end_dt,
        is_active
      )
      VALUES
      (
        bl_3nf.ce_payment_methods_seq.NEXTVAL,
        c.payment_method_id,
        c.payment_method,
        c.start_dt,
        c.end_dt,
        c.is_active
      ) ;
    COMMIT;
EXCEPTION
WHEN OTHERS THEN
    RAISE;
END merge_ce_payment_methods;
END pkg_etl_insert_payment_methods;
/