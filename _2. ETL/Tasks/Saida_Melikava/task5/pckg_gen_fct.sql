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
    ROUND(dbms_random.value(a,b))
  WHEN i>10 AND i<=16 THEN
    ROUND(dbms_random.value(b,c))
  WHEN i>16 AND i<=19 THEN
    ROUND(dbms_random.value(c,d))
  WHEN i<20 THEN
    ROUND(dbms_random.value(d,e))
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
    ROUND(dbms_random.value(0,(v_max*0.45))) --40%
  WHEN i>7 AND i<=9 THEN
    ROUND(dbms_random.value((v_max*0.45),(v_max*0.97))) --55%
  WHEN i<10 THEN
    ROUND(dbms_random.value((v_max*0.97),(v_max*1))) --5%
  END ;
  RETURN(result);
END;
/*********GENERATE CLS*************/
--*****************************/
PROCEDURE insert_bl_cls(
    target_table_cls IN VARCHAR2)
IS
  sql_stmt_trunc  VARCHAR2(250);
  sql_stmt_insert VARCHAR2(250);
  sql_stmt_select VARCHAR2(1000);
BEGIN
  sql_stmt_trunc :='TRUNCATE TABLE '|| target_table_cls;
  sql_stmt_select:=q'< SELECT TO_DATE( TRUNC( DBMS_RANDOM.value( TO_CHAR(DATE '2005-01-01','J') ,TO_CHAR(SYSDATE,'J') ) +dbms_random.value(-100,100)),'J') AS event_dt ,
randomize_max('cls_customers', 'cust_src_id') AS customer_id,
randomize_max('cls_catalog', 'cat_src_id') AS product_id,
randomize_max('cls_employees', 'emp_src_id') AS employee_id,
randomize_max('cls_stores', 'store_src_id') AS store_id,
randomize_max('cls_catalog', 'cat_src_id') AS prod_id,
randomize_max('cls_payments', 'code') AS paym_id ,
randomize(1,4,10,20,50)  as quantity,
ROUND((randomize(0,10,25,35,50))/100,2)  as disc,
randomize(5,20,35,45,100) as price,
ROUND((randomize(160,175,180,190,200))/100,2) as byn_usd

FROM  
( SELECT level n FROM dual CONNECT BY level <= 10  
)
>';
  EXECUTE immediate sql_stmt_trunc;
  dbms_output.put_line('Table '|| target_table_cls||' is successfully truncated.');
  EXECUTE IMMEDIATE
  --dbms_output.put_line(
  'INSERT INTO '|| target_table_cls||'(event_dt,fct_customer_id,  
fct_employee_id,fct_store_id, fct_product_id,  
fct_payment_id, fct_check_id, fct_quantity,  
fct_discount, fct_unit_price_byn,  
fct_byn_usd)'||sql_stmt_select;
  --dbms_output.put_line('Data in the table '||target_table_cls||' is successfully loaded: '||SQL%ROWCOUNT|| ' rows were inserted.');
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END;
END pckg_insert_fact;
/
EXECUTE pckg_insert_fact.insert_bl_cls(target_table_cls=>'cls_fct_sales');
SELECT * FROM cls_fct_sales;
