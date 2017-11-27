CREATE OR REPLACE PROCEDURE bulk_collect
IS
BEGIN
DECLARE
   CURSOR c_data IS
    SELECT A.store_surr_id, 
           A.store_id, 
           b.store_desc AS store_desc
    FROM cls_stores_scd A LEFT OUTER JOIN bl_dm.dim_stores_scd b 
                                       ON A.store_surr_id = b.store_surr_id;
   TYPE t__data IS TABLE OF c_data%rowtype INDEX BY binary_integer;
   t_data t__data;
   
BEGIN
   OPEN c_data;
   loop
      fetch c_data BULK COLLECT INTO t_data;
      exit WHEN t_data.count = 0;
      FOR idx IN t_data.FIRST .. t_data.LAST loop
         IF t_data(idx).store_desc IS NULL THEN
      INSERT INTO bl_dm.dim_stores_scd
      SELECT store_surr_id, 
             store_id, 
             store_desc, 
             phone, 
             address, 
             city, 
             country, 
             region, 
             insert_dt, 
             update_dt 
      FROM (
           (SELECT store_surr_id, 
                   store_id, 
                   store_desc, 
                   phone, 
                   address, 
                   city, 
                   country, 
                   region, 
                   insert_dt, 
                   update_dt 
            FROM cls_stores_scd
               MINUS
            SELECT A.store_surr_id, 
                   A.store_id, 
                   A.store_desc, 
                   A.phone, 
                   A.address, 
                   A.city, 
                   A.country, 
                   A.region, 
                   A.insert_dt, 
                   A.update_dt 
            FROM cls_stores_scd A, bl_dm.dim_stores_scd b 
      WHERE A.store_surr_id = b.store_surr_id));
      ELSE
      UPDATE bl_dm.dim_stores_scd
      SET store_desc = t_data(idx).store_desc;
      END IF;
   END loop;
  END loop;
 CLOSE c_data;
END;
END; 
/
BEGIN
bulk_collect;
END;