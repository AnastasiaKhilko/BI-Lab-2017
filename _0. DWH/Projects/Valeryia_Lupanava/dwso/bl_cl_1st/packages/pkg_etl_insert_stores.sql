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
  EXECUTE IMMEDIATE ('TRUNCATE TABLE cls_stores');
  INSERT INTO cls_stores (
                              store_id,
                              store_number,
                              store_name,
                              manager_id,
                              phone,
                              address,
                              city_id,
                              start_dt,
                              is_active
                            )
  SELECT cls_stores_seq.NEXTVAL AS store_id,
         store_code AS store_number,
         store_name,
         manager_id,
         phone,
         address,
         wct.city_id,
         SYSDATE AS start_dt,
         (CASE WHEN round(dbms_random.value (1,2)) = 1 THEN 'true'
               WHEN round(dbms_random.value (1,2)) = 2 THEN 'false'
               ELSE 'true'
               END) AS is_active
  FROM   wrk_stores wst left join wrk_cities wct on wst.city = wct.city_desc;

  COMMIT;
  
EXCEPTION
  WHEN OTHERS THEN
  RAISE;

END insert_table_stores;
---------------------------------------------------  
---------------------------------------------------
PROCEDURE merge_table_ce_stores
IS
BEGIN

MERGE INTO bl_3nf.ce_stores t USING
    ( SELECT store_id,
             store_number,
             store_name,
             manager_id,
             phone,
             address,
             city_id,
             start_dt,
             end_dt,
             is_active
      FROM   cls_stores
    MINUS
      SELECT store_srcid AS store_id,
             store_number,
             store_desc AS store_name,
             manager_number AS manager_id,
             phone,
             address,
             city_srcid AS city_id,
             start_dt,
             end_dt,
             is_active
      FROM   bl_3nf.ce_stores
    ) c ON ( c.store_id = t.store_srcid )
    WHEN matched THEN
    UPDATE SET t.end_dt  = c.end_dt,
               t.is_active = c.is_active
    WHEN NOT matched THEN
    INSERT
      (
        store_id,
        store_srcid,
        store_number,
        store_desc,
        manager_number,
        phone,
        address,
        city_srcid,
        start_dt,
        end_dt,
        is_active
      )
      VALUES
      (
        bl_3nf.ce_stores_seq.NEXTVAL,
        c.store_id,
        c.store_number,
        c.store_name,
        c.manager_id,
        c.phone,
        c.address,
        c.city_id,
        c.start_dt,
        c.end_dt,
        c.is_active
      ) ;
    COMMIT;
EXCEPTION
WHEN OTHERS THEN
    RAISE;
END merge_table_ce_stores;
---------------------------------------------------
END pkg_etl_insert_stores;