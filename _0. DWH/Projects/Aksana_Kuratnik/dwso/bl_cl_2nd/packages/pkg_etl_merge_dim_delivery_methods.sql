CREATE OR REPLACE PACKAGE pkg_etl_merge_delivery_methods
AUTHID CURRENT_USER
AS
  PROCEDURE merge_dim_delivery_methods;					
END pkg_etl_merge_delivery_methods;
/
CREATE OR REPLACE PACKAGE BODY pkg_etl_merge_delivery_methods
AS
PROCEDURE merge_dim_delivery_methods
IS
BEGIN

MERGE INTO bl_dm.dim_delivery_methods t USING
    ( SELECT delivery_method_surr_id,
             delivery_method_name,
             start_dt,
             end_dt,
             is_active
      FROM   cls_delivery_methods
    MINUS
      SELECT delivery_method_id,
             delivery_method_name,
             start_dt,
             end_dt,
             is_active          
      FROM   bl_dm.dim_delivery_methods
    ) c ON ( t.delivery_method_name = c.delivery_method_name
        AND  t.start_dt = c.start_dt)
    WHEN matched THEN
    UPDATE SET 
               t.delivery_method_id = c.delivery_method_surr_id,
               t.end_dt = c.end_dt,
               t.is_active = c.is_active
    WHEN NOT matched THEN
    INSERT
      (
       delivery_method_surr_id,
       delivery_method_id,
       delivery_method_name,
       start_dt,
       end_dt,
       is_active
      )
      VALUES
      (
       bl_dm.dim_delivery_methods_seq.NEXTVAL,
       c.delivery_method_surr_id,
       c.delivery_method_name,
       c.start_dt,
       c.end_dt,
       c.is_active
      ) ;
    COMMIT;
EXCEPTION
WHEN OTHERS THEN
    RAISE;
END merge_dim_delivery_methods;
END pkg_etl_merge_delivery_methods;
/