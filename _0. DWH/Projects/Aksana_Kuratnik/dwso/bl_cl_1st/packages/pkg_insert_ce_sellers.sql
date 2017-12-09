CREATE OR REPLACE PACKAGE pkg_etl_insert_sellers
AUTHID CURRENT_USER
AS
 PROCEDURE merge_ce_sellers;
END pkg_etl_insert_sellers;
/
CREATE OR REPLACE PACKAGE BODY pkg_etl_insert_sellers
AS
PROCEDURE merge_ce_sellers
IS
BEGIN

MERGE INTO bl_3nf.ce_sellers t USING
    ( SELECT seller_id,
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
      SELECT 
             seller_srcid AS seller_id,
             first_name,
             last_name,
             age,
             email,
             phone,
             address,
             start_dt,
             end_dt,
             is_active
      FROM   bl_3nf.ce_sellers
    ) c ON ( c.seller_id = t.seller_srcid
       AND   c.first_name = t.first_name
       AND   c.last_name = t.last_name
       AND   t.age = c.age
       AND   c.email = t.email
       AND   c.phone = t.phone
       )
    WHEN MATCHED THEN
    UPDATE SET 
               t.end_dt  = c.end_dt,
               t.is_active = c.is_active
    WHEN NOT matched THEN
    INSERT
      (
        seller_id,
        seller_srcid,
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
        bl_3nf.ce_sellers_seq.NEXTVAL,
        c.seller_id,
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
END merge_ce_sellers;
END pkg_etl_insert_sellers;
/