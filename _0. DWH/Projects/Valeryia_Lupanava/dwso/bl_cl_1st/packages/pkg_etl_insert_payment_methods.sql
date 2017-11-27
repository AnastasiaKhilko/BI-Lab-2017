CREATE OR REPLACE PACKAGE pkg_etl_insert_payment_methods
AUTHID CURRENT_USER
AS
  PROCEDURE insert_table_payment_methods;
  PROCEDURE merge_table_ce_payment_methods;
						
END pkg_etl_insert_payment_methods;

CREATE OR REPLACE PACKAGE BODY pkg_etl_insert_payment_methods
AS
---------------------------------------------------  
PROCEDURE insert_table_payment_methods
IS
BEGIN
  EXECUTE IMMEDIATE ('TRUNCATE TABLE cls_payment_methods');
  INSERT INTO cls_payment_methods (
                                   payment_method_id,
                                   payment_method,
                                   bank,
                                   start_dt,
                                   is_active
                                   )
SELECT cls_payment_methods_seq.NEXTVAL AS payment_method_id,
       payment_method_name AS payment_method,
       bank,
       SYSDATE AS start_dt,
       'TRUE' AS is_active
  FROM wrk_payment_methods;

  COMMIT;
  
EXCEPTION
  WHEN OTHERS THEN
  RAISE;

END insert_table_payment_methods;
---------------------------------------------------  
---------------------------------------------------
PROCEDURE merge_table_ce_payment_methods
IS
BEGIN

MERGE INTO bl_3nf.ce_payment_methods t USING
    ( SELECT payment_method_id,
             payment_method,
             bank,
             start_dt,
             end_dt,
             is_active
      FROM   cls_payment_methods
    MINUS
      SELECT payment_method_srcid AS payment_method_id,
             payment_method_desc AS payment_method,
             bank_desc AS bank,
             start_dt,
             end_dt,
             is_active
      FROM   bl_3nf.ce_payment_methods
    ) c ON ( c.payment_method_id = t.payment_method_srcid )
    WHEN matched THEN
    UPDATE SET 
               t.payment_method_desc  = c.payment_method,
               t.bank_desc  = c.bank,
               t.start_dt  = c.start_dt,
               t.end_dt  = c.end_dt,
               t.is_active = c.is_active
    WHEN NOT matched THEN
    INSERT
      (
        payment_method_id,
        payment_method_srcid,
        payment_method_desc,
        bank_desc,
        start_dt,
        end_dt,
        is_active
      )
      VALUES
      (
        bl_3nf.ce_payment_methods_seq.NEXTVAL,
        c.payment_method_id,
        c.payment_method,
        c.bank,
        c.start_dt,
        c.end_dt,
        c.is_active
      ) ;
    COMMIT;
EXCEPTION
WHEN OTHERS THEN
    RAISE;
END merge_table_ce_payment_methods;
---------------------------------------------------
END pkg_etl_insert_payment_methods;