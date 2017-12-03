------------------------------------------------------------------------------
-- Author  : Melikava Saida
-- Created : 23/11/2017
-- Modified: 23/11/2017
-- Purpose : Generate fact table.
------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE pckg_insert_fact
AS
  FUNCTION randomize(
      a IN NUMBER,
      b IN NUMBER,
      c IN NUMBER,
      d IN NUMBER,
      e IN NUMBER)
    RETURN NUMBER;
  FUNCTION randomize_max(
      table_name IN VARCHAR2,
      col_name   IN VARCHAR2)
    RETURN NUMBER;
  PROCEDURE insert_bl_cls(
      target_table_cls IN VARCHAR2);
  PROCEDURE insert_bl_3NF(
  target_table_3nf IN VARCHAR2);
END pckg_insert_fact;
/
CREATE OR REPLACE PACKAGE BODY pckg_insert_fact
AS
FUNCTION randomize(
    a IN NUMBER,
    b IN NUMBER,
    c IN NUMBER,
    d IN NUMBER,
    e IN NUMBER)
  RETURN NUMBER
IS
  i      NUMBER(11,2);
  result NUMBER (8,2);
BEGIN
  i     :=dbms_random.value(1,20);
  result:=
  CASE
  WHEN i<=10 THEN
    CEIL(dbms_random.value(a,b))
  WHEN i>10 AND i<=16 THEN
    CEIL(dbms_random.value(b,c))
  WHEN i>16 AND i<=19 THEN
    CEIL(dbms_random.value(c,d))
  WHEN i<20 THEN
    CEIL(dbms_random.value(d,e))
  ELSE
    '1'
  END ;
  RETURN(result);
END;
FUNCTION randomize_max(
    table_name IN VARCHAR2,
    col_name   IN VARCHAR2)
  RETURN NUMBER
IS
  v_max  NUMBER(8,2);
  i      NUMBER(11,2);
  result NUMBER (8,2);
  stmt   VARCHAR2(250);
BEGIN
  result:=0;
  EXECUTE IMMEDIATE 'SELECT MAX('||col_name||') FROM '||table_name INTO v_max;
  i     :=dbms_random.value(1,10);
  result:=
  CASE
  WHEN i<=7 THEN
    CEIL(dbms_random.value(1,(v_max*0.45))) --40%
  WHEN i>7 AND i<=9 THEN
    CEIL(dbms_random.value((v_max*0.45),(v_max*0.97))) --55%
  WHEN i<10 THEN
    CEIL(dbms_random.value((v_max*0.97),(v_max*1))) --5%
  ELSE
    '1'
  END ;
  RETURN(result);
END;
/*********GENERATE 3NF*************/
--*****************************/
PROCEDURE insert_bl_cls(
    target_table_cls IN VARCHAR2)
IS
  sql_stmt_insert VARCHAR2(250);
  sql_stmt_select VARCHAR2(1000);
BEGIN
  sql_stmt_select:=q'< 
SELECT 
to_date('01/01/2005','dd-MM-yyyy')+dbms_random.value(1,4380) AS event_dt,
randomize_max('bl_3nf.ce_customers', 'customer_id') AS customer_id,
randomize_max('bl_3nf.ce_employees', 'employee_id') AS employee_id,
randomize_max('bl_3nf.ce_stores', 'store_id')  AS store_id,
randomize_max('bl_3nf.ce_catalog', 'prod_id') AS product_id,
abs(round(dbms_random.normal()*400000)) as check_id,
randomize(1,5,8,11,12) AS paym_id ,
randomize(1,4,10,20,50)  as quantity,
ROUND((randomize(1,10,25,35,50))/100,2)  as disc,
randomize(5,20,35,45,100) as price,
ROUND((randomize(160,175,180,190,200))/100,2) as byn_usd
FROM  
( SELECT level n FROM dual CONNECT BY level <= 1000000
)

>';
  EXECUTE IMMEDIATE 'INSERT INTO '|| target_table_cls||'(event_dt,fct_customer_id,  
fct_employee_id,
fct_store_id, fct_product_id,  
 fct_check_id, fct_payment_id,fct_quantity,  
fct_discount, fct_unit_price_byn,  
fct_byn_usd)'||sql_stmt_select;
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END;
PROCEDURE insert_bl_3nf(
    target_table_3nf IN VARCHAR2)
IS
BEGIN
  INSERT
  INTO bl_3nf.ce_fct_sales
    (
      event_dt,
      fct_customer_id,
      fct_employee_id,
      fct_store_id,
      Fct_store_dist_id,
      fct_product_id,
      fct_check_id,
      fct_payment_id,
      fct_quantity,
      fct_discount,
      fct_unit_price_byn,
      fct_byn_usd
    )
  SELECT EVENT_DT,
    FCT_CUSTOMER_ID,
    FCT_EMPLOYEE_ID,
    FCT_STORE_ID,
    dis.district_id,
    FCT_PRODUCT_ID,
    FCT_CHECK_ID,
    FCT_PAYMENT_ID,
    FCT_QUANTITY,
    FCT_DISCOUNT,
    FCT_UNIT_PRICE_BYN,
    fct_byn_usd
  FROM CLS_FCT_SALES fct
  INNER JOIN bl_3nf.ce_stores st
  ON st.store_id=fct.fct_store_id
  INNER JOIN bl_3nf.ce_addr ad
  ON ad.addr_id=st.store_address_id
  INNER JOIN bl_3nf.ce_cities cit
  ON ad.addr_city_id=cit.city_id
  INNER JOIN bl_3nf.ce_regions reg
  ON cit.region_id=reg.region_id
  INNER JOIN bl_3nf.ce_districts dis
  ON dis.district_id=reg.district_id;
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END;
END pckg_insert_fact;
/