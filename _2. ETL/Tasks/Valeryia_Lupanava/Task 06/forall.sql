CREATE OR REPLACE PROCEDURE forall_cursor
IS
BEGIN
DECLARE
 CURSOR s_cur IS 
 SELECT    a.store_surr_id, 
           a.store_id, 
           a.store_desc, 
           a.phone, 
           a.address, 
           a.city, 
           a.country, 
           a.region, 
           a.insert_dt, 
           a.update_dt
    FROM cls_stores_scd a LEFT OUTER JOIN bl_dm.dim_stores_scd b 
                                       ON a.store_surr_id = b.store_surr_id
    WHERE b.store_desc IS NULL;

 TYPE fetch_array IS TABLE OF s_cur%ROWTYPE;
 s_array fetch_array;
BEGIN
  OPEN s_cur;
  LOOP
    FETCH s_cur BULK COLLECT INTO s_array;

    FORALL i IN 1..s_array.COUNT
    INSERT INTO bl_dm.dim_stores_scd
    VALUES s_array(i);
    EXIT WHEN s_cur%NOTFOUND;
  END LOOP;
  CLOSE s_cur;
  COMMIT;
END;
END;
/
BEGIN
   forall_cursor;
END;