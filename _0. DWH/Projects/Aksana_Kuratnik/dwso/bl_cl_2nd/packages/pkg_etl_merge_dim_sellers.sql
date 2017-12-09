CREATE OR REPLACE PACKAGE pkg_etl_merge_sellers
AUTHID CURRENT_USER
AS
  PROCEDURE merge_dim_sellers;
END pkg_etl_merge_sellers;
/
CREATE OR REPLACE PACKAGE BODY pkg_etl_merge_sellers
AS
PROCEDURE merge_dim_sellers
IS
BEGIN
  MERGE INTO bl_dm.dim_sellers t USING
    ( SELECT seller_surr_id,
             first_name,
             last_name,
             age,
             email,
             phone,
             address,
             start_dt,
             end_dt,
             is_active
      FROM   cls_sellers
    MINUS
      SELECT seller_id,
             first_name,
             last_name,
             age,
             email,
             phone,
             address,
             start_dt,
             end_dt,
             is_active          
      FROM   bl_dm.dim_sellers
    ) c ON ( 
             t.first_name = c.first_name
       AND   t.last_name = c.last_name
       AND   t.age = c.age
       AND   t.email = c.email
       AND   t.phone = c.phone
       AND   t.address = c.address
       AND   t.start_dt = c.start_dt)
    WHEN matched THEN
    UPDATE SET 
               t.seller_id = c.seller_surr_id,
               t.end_dt = c.end_dt,
               t.is_active = c.is_active
    WHEN NOT matched THEN
    INSERT
      (
       seller_surr_id,
       seller_id,
       first_name,
       last_name,
       age,
       email,
       phone,
       address,
       start_dt,
       end_dt,
       is_active
      )
      VALUES
      (
       bl_dm.dim_sellers_seq.NEXTVAL,
       c.seller_surr_id,
       c.first_name,
       c.last_name,
       c.age,
       c.email,
       c.phone,
       c.address,
       c.start_dt,
       c.end_dt,
       c.is_active
      ) ;
    COMMIT;
EXCEPTION
  WHEN OTHERS THEN
  RAISE;
END merge_dim_sellers;
END pkg_etl_merge_sellers;
/