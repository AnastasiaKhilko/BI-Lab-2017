--PKG_INSERT_MANUFACTURERS
CREATE OR REPLACE PACKAGE pkg_etl_insert_manufacturers
AUTHID CURRENT_USER
AS
  PROCEDURE merge_ce_manufacturers;
 
END pkg_etl_insert_manufacturers;
/
CREATE OR REPLACE PACKAGE BODY pkg_etl_insert_manufacturers
AS

PROCEDURE merge_ce_manufacturers
IS
BEGIN

MERGE INTO bl_3nf.ce_manufacturers t USING
    ( SELECT manufacturer_id,
             manufacturer_code,
             manufacturer_name,
             phone,
             address,
             city AS city_srcid,
             insert_dt,
             update_dt
      FROM   cls_manufacturers
    MINUS
      SELECT manufacturer_srcid AS manufacturer_id,
             manufacturer_code,
             manufacturer_name,
             phone,
             address,
             city_srcid,
             insert_dt,
             update_dt
      FROM   bl_3nf.ce_manufacturers
    ) c ON ( c.manufacturer_id = t.manufacturer_srcid
       AND   t.manufacturer_name  = c.manufacturer_name
       AND   t.manufacturer_code  = c.manufacturer_code
       AND   t.phone  = c.phone
       AND   t.address = c.address
       AND   t.city_srcid  = c.city_srcid
       AND   c.insert_dt = t.insert_dt )
    WHEN matched THEN
    UPDATE SET
              t.update_dt  = c.update_dt
    WHEN NOT matched THEN
    INSERT
      (
        manufacturer_id,
        manufacturer_srcid,
        manufacturer_code,
        manufacturer_name,
        phone,
        address,
        city_srcid,
        insert_dt,
        update_dt
      )
      VALUES
      (
        bl_3nf.ce_manufacturers_seq.NEXTVAL,
        c.manufacturer_id,
        c.manufacturer_code,
        c.manufacturer_name,
        c.phone,
        c.address,
        c.city_srcid,
        c.insert_dt,
        SYSDATE
      ) ;
    COMMIT;
EXCEPTION
WHEN OTHERS THEN
    RAISE;
END merge_ce_manufacturers;
END pkg_etl_insert_manufacturers;
/