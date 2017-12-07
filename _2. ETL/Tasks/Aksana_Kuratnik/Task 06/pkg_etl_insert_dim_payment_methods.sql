CREATE OR REPLACE PACKAGE pkg_etl_insert_payment_methods
AUTHID CURRENT_USER
AS
  PROCEDURE merge_dim_payment_methods;				
END pkg_etl_insert_payment_methods;
/
CREATE OR REPLACE PACKAGE BODY pkg_etl_insert_payment_methods
AS 
PROCEDURE merge_dimpayment_methods
IS
BEGIN
MERGE INTO bl_dm.dim_payment_methods_scd t USING
    ( SELECT payment_method_surr_id,
             payment_method_desc,
             start_dt,
             end_dt,
             is_active
      FROM   cls_payment_methods_scd
    MINUS
      SELECT payment_method_id,
             payment_method_desc,
             start_dt,
             end_dt,
             is_active          
      FROM   bl_dm.dim_payment_methods_scd
    ) c ON ( t.payment_method_desc = c.payment_method_desc
        AND  t.start_dt = c.start_dt)
    WHEN matched THEN
    UPDATE SET 
               t.payment_method_id = c.payment_method_surr_id,
               t.end_dt = c.end_dt,
               t.is_active = c.is_active
    WHEN NOT matched THEN
    INSERT
      (
       payment_method_surr_id,
       payment_method_id,
       payment_method_desc,
       start_dt,
       end_dt,
       is_active
      )
      VALUES
      (
       bl_dm.dim_payment_methods_seq.NEXTVAL,
       c.payment_method_surr_id,
       c.payment_method_desc,
       c.start_dt,
       c.end_dt,
       c.is_active
      ) ;
    COMMIT;
EXCEPTION
WHEN OTHERS THEN
    RAISE;
END merge_dim_payment_methods;
END pkg_etl_insert_payment_methods;
/