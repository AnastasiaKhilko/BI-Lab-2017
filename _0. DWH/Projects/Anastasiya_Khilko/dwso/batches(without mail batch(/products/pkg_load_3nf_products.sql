CREATE OR REPLACE PACKAGE BODY pkg_load_3nf_products AS

    PROCEDURE load_wrk_products1
        IS
    BEGIN
        EXECUTE IMMEDIATE 'truncate table WRK_PRODUCTS1';
        INSERT INTO wrk_products1 SELECT DISTINCT
            wrk.code, wrk.product, c2.subcategory_id
        FROM WRK_PRODUCTS wrk
        inner join BL_3NF.CE_PRODUCT_SUBCATEGORIES c2
            on wrk.subcategory_code = c2.subcategory_code;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_wrk_products1;
    
/****************************************************/

PROCEDURE load_cls_products
    IS
CURSOR c_prod
    IS
  SELECT src.product_code,src.product_desc, src.subcategory_id,
  NVL2(tgt.product_code, TRUNC(sysdate), TO_DATE('01/01/1900','DD/MM/YYYY')) start_dt, TO_DATE('31/12/9999','DD/MM/YYYY') end_dt, 'Y' isactive
  FROM WRK_PRODUCTS1 src left join BL_3NF.CE_PRODUCTS tgt
  ON (tgt.start_dt<= TRUNC(sysdate)
  and tgt.end_dt > TRUNC(sysdate)
  and tgt.product_code = src.product_code)
  WHERE (DECODE(src.product_code, tgt.product_code, 0,1)+ DECODE(src.product_desc, tgt.product_desc, 0,1) +
    DECODE(src.subcategory_id, tgt.subcategory_id, 0,1))>0
  union all
  SELECT tgt.product_code, tgt.product_desc, tgt.subcategory_id,
  tgt.start_dt, TRUNC(sysdate) end_dt, 'N' is_active
  FROM WRK_PRODUCTS1 src join BL_3NF.CE_PRODUCTS tgt
  ON (tgt.start_dt<= TRUNC(sysdate)
  and tgt.end_dt > TRUNC(sysdate)
  and tgt.product_code = src.product_code)
  WHERE (DECODE(src.product_code, tgt.product_code, 0,1)+ DECODE(src.product_desc, tgt.product_desc, 0,1) +
    DECODE(src.subcategory_id, tgt.subcategory_id, 0,1))>0;

rec_prod cls_products%rowtype;      
        
BEGIN
EXECUTE IMMEDIATE 'truncate table cls_products'; 
OPEN c_prod;
  LOOP
    FETCH c_prod INTO rec_prod;
   IF c_prod%found THEN
      INSERT INTO cls_products (product_code, product_desc, subcategory_id, start_dt, end_dt, isactive)
      values (rec_prod.product_code, rec_prod.product_desc, rec_prod.subcategory_id, 
      rec_prod.start_dt, rec_prod.end_dt, rec_prod.isactive);
    END IF;
    EXIT WHEN c_prod%notfound;
  END LOOP; 
  COMMIT;
  CLOSE c_prod;
        --dbms_output.put_line('The data in the table CLS_CUSTOMERS is loaded successfully!');
EXCEPTION
    WHEN OTHERS THEN
        RAISE;
END load_cls_products;

/****************************************************/

PROCEDURE load_ce_products
    IS
BEGIN
  MERGE INTO BL_3NF.CE_PRODUCTS tgt
  USING (SELECT product_code,
    product_desc,
    subcategory_id,
    start_dt,
    end_dt,
    isactive
    FROM cls_products) src
  ON (src.product_code = tgt.product_code 
  AND src.start_dt = tgt.start_dt)
  WHEN MATCHED THEN 
  UPDATE SET
    tgt.end_dt=src.end_dt,
    tgt.isactive=src.isactive
  WHEN NOT MATCHED THEN 
  INSERT (product_id, product_code, product_desc, subcategory_id, start_dt, end_dt, isactive)
  VALUES (bl_3nf.seq_products.nextval, src.product_code, src.product_desc, src.subcategory_id, src.start_dt, src.end_dt, src.isactive);
    COMMIT;
    --dbms_output.put_line('The data in the table CE_CUSTOMERS is loaded successfully!');
EXCEPTION
    WHEN OTHERS THEN
        RAISE;
END load_ce_products;

/****************************************************/

END pkg_load_3nf_products;
/