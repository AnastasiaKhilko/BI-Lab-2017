------------------------------------------------------------------------------
-- Author  : Melikava Saida
-- Created : 23/11/2017
-- Modified: 24/11/2017
-- Purpose : Insert customers data from source to DWH.
------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE pckg_insert_customers
AS
  PROCEDURE insert_bl_wrk(
      source_table     IN VARCHAR2,
      target_table_wrk IN VARCHAR2);
  PROCEDURE insert_bl_cls(
      source_table_wrk IN VARCHAR2,
      target_table_cls IN VARCHAR2);
  PROCEDURE insert_bl_3NF;
END pckg_insert_customers;
/
CREATE OR REPLACE PACKAGE BODY pckg_insert_customers
AS
  /*************SRC->WRK****************/
  /*************************************/
PROCEDURE insert_bl_wrk(
    source_table     IN VARCHAR2,
    target_table_wrk IN VARCHAR2)
IS
  sql_stmt_trunc  VARCHAR2(250);
  sql_stmt_insert VARCHAR2(250);
BEGIN
  sql_stmt_trunc :='TRUNCATE TABLE '|| target_table_wrk;
  sql_stmt_insert:='INSERT INTO '|| target_table_wrk||' SELECT * FROM '|| source_table;
  EXECUTE immediate sql_stmt_trunc;
  dbms_output.put_line('Table '|| target_table_wrk||' is successfully truncated.');
  EXECUTE immediate sql_stmt_insert;
  dbms_output.put_line('Data in the table '||target_table_wrk||' is successfully loaded: '||SQL%ROWCOUNT|| ' rows were inserted.');
  COMMIT;
  dbms_output.put_line('Transaction is commited.');
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END;
/*************WRK->CLS****************/
/*************************************/
PROCEDURE insert_bl_cls(
    source_table_wrk IN VARCHAR2,
    target_table_cls IN VARCHAR2)
IS
  sql_stmt_trunc  VARCHAR2(250);

BEGIN
  sql_stmt_trunc :='TRUNCATE TABLE '|| target_table_cls;
  EXECUTE immediate sql_stmt_trunc;
  dbms_output.put_line('Table '|| target_table_cls||' is successfully truncated.');
  INSERT
  INTO cls_customers
    (
      cust_code,
      cust_name,
      cust_surname,
      cust_email,
      cust_phone,
      cust_city_id,
      cust_card_num
    )

  SELECT  distinct code||SUBSTR(card_num,1,3) code,
    INITCAP(name) n,
    INITCAP(REPLACE(sur,'?','')) sur,
    NVL(LOWER(email),'N/D') email,
    NVL(phone,'N/D') phone,
    city_id cit,
    card_num card
  FROM wrk_customers wrk
  INNER JOIN cls_cities cls
  ON city=cls.city_desc
  INNER JOIN bl_3nf.ce_cities ce
  ON cls.city_code=ce.city_code
  where code IS NOT NULL OR (name IS NOT NULL AND sur IS NOT NULL) OR LENGTH(wrk.mid_name)<3;


  COMMIT;
END;
/********CLS->3NF*************/
/*****************************/
PROCEDURE insert_bl_3NF
IS
BEGIN
  MERGE INTO bl_3nf.ce_customers ce USING
  (SELECT cust_code,
    cust_name,
    cust_surname,
    cust_email,
    cust_phone,
    cust_city_id,
    cust_card_num
  FROM cls_customers
  MINUS
  SELECT customer_code,
    customer_name,
    customer_surname,
    customer_email,
    customer_phone,
    customer_city_id,
    customer_card
  FROM bl_3nf.ce_customers
  ) cls ON ( cls.cust_code = ce.customer_code )
WHEN MATCHED THEN
  UPDATE
  SET ce.customer_name  = cls.cust_name,
    ce.customer_surname = cls.cust_surname,
    ce.customer_email   = cls.cust_email,
    ce.customer_phone   = cls.cust_phone,
    ce.customer_city_id = cls.cust_city_id,
    ce.customer_card    = cls.cust_card_num,
    ce.update_dt        =TRUNC(sysdate) 
    WHEN NOT MATCHED THEN
  INSERT
    (
      Customer_id ,
      Customer_code ,
      Customer_name ,
      Customer_surname ,
      Customer_email ,
      Customer_phone ,
      Customer_card ,
      Customer_city_id
    )
    VALUES
    (
      seq_cust_3nf.nextval,
      cls.cust_code,
      cls.cust_name,
      cls.cust_surname,
      cls.cust_email,
      cls.cust_phone,
      cls.cust_card_num,
      cls.cust_city_id
    ) ;
  COMMIT;
END;
END pckg_insert_customers;
/


