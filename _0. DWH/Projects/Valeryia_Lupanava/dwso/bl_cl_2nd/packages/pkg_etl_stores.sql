CREATE OR REPLACE PACKAGE pkg_etl_insert_stores
AUTHID CURRENT_USER
AS
  PROCEDURE insert_table_stores;
  PROCEDURE merge_table_ce_stores;
  
END pkg_etl_insert_stores;

CREATE OR REPLACE PACKAGE BODY pkg_etl_insert_stores
AS
---------------------------------------------------  
PROCEDURE insert_table_stores
IS
BEGIN
  EXECUTE IMMEDIATE ('TRUNCATE TABLE cls_stores_scd');
INSERT INTO cls_stores_scd
SELECT DISTINCT
        store_srcid AS store_id,
        store_desc,
        phone,
        address,
        cs.city_desc AS city,
        cn.country_desc AS country,
        cr.region_desc AS region,
        insert_dt,
        SYSDATE AS update_dt
FROM    bl_3nf.ce_stores   cc left join bl_3nf.ce_cities cs
                                     on cc.city_srcid = cs.city_srcid
                              left join bl_3nf.ce_countries cn
                                     on cs.country_srcid = cn.country_srcid
                              left join bl_3nf.ce_regions cr
                                     on cn.region_srcid = cr.region_srcid;
  COMMIT;
  
EXCEPTION
  WHEN OTHERS THEN
  RAISE;

END insert_table_stores;
---------------------------------------------------  
PROCEDURE merge_table_ce_stores
IS
BEGIN

MERGE INTO bl_dm.dim_stores_scd t USING
    ( SELECT store_id,
             store_desc,
             phone,
             address,
             city,
             country,
             region,
             insert_dt,
             update_dt
      FROM   cls_stores_scd
    MINUS
      SELECT store_id,
             store_desc,
             phone,
             address,
             city,
             country,
             region,
             insert_dt,
             update_dt          
      FROM   bl_dm.dim_stores_scd
    ) c ON (t.store_id = c.store_id
        AND t.store_desc = c.store_desc
        AND t.phone = c.phone
        AND t.address = c.address
        AND t.city = c.city
        AND t.country = c.country
        AND t.region = c.region)
    WHEN matched THEN
    UPDATE SET 
            t.update_dt = c.update_dt
    WHEN NOT matched THEN
    INSERT
      (
        store_surr_id,
        store_id,
        store_desc,
        phone,
        address,
        city,
        country,
        region,
        insert_dt,
        update_dt 
      )
      VALUES
      (
        bl_dm.dim_stores_seq.NEXTVAL,
        c.store_id,
        c.store_desc,
        c.phone,
        c.address,
        c.city,
        c.country,
        c.region,
        c.insert_dt,
        c.update_dt 
      ) ;
    COMMIT;
EXCEPTION
WHEN OTHERS THEN
    RAISE;
END merge_table_ce_stores;
---------------------------------------------------
END pkg_etl_insert_stores;