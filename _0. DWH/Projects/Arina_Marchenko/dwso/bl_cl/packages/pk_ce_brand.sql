CREATE OR REPLACE PACKAGE pkg_etl_load_ce_brand
AS
  PROCEDURE load_ce_brand;
  
END pkg_etl_load_ce_brand;
/
CREATE OR REPLACE PACKAGE BODY pkg_etl_load_ce_brand
AS
PROCEDURE load_ce_brand
IS
  CURSOR c_data
  IS
    SELECT DISTINCT cebr.rowid AS rid,
      clbr.brand_name,
      trunc(sysdate) update_dt
    FROM cl_brand clbr
    LEFT OUTER JOIN bl_3nf.ce_brand cebr
    ON clbr.brand_name <> cebr.brand_name;
type t__data
IS
  TABLE OF c_data%rowtype INDEX BY binary_integer;
  t_data t__data;
BEGIN
  EXECUTE IMMEDIATE 'truncate table bl_3nf.ce_brand';
  OPEN c_data;
  LOOP
    FETCH c_data bulk collect INTO t_data ;
    EXIT
  WHEN t_data.count = 0;
    FOR idx IN t_data.first .. t_data.last
    LOOP
      IF t_data(idx).rid IS NULL THEN
        INSERT
        INTO bl_3nf.ce_brand
          (
            brand_id,
            brand_name,
            update_dt
          )
          VALUES
          (
            bl_3nf.seq_brand.nextval,
            t_data(idx).brand_name,
            sysdate
          );
      ELSE
        UPDATE bl_3nf.ce_brand
        SET update_dt = sysdate
        WHERE rowid    = t_data(idx).rid ;
      END IF;
    END LOOP;
  END LOOP;
  CLOSE c_data;
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END load_ce_brand;
END pkg_etl_load_ce_brand;
/