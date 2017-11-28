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
  sql_stmt_select VARCHAR2(1050);
  acc             NUMBER(8);
  acc_err         NUMBER(8);
  CURSOR c_data
  IS
    SELECT code,
      name,
      mid_name,
      sur,
      email,
      phone,
      birth,
      city,
      card_num
    FROM wrk_customers ;
type t__data
IS
  TABLE OF c_data%rowtype;
  t_data t__data;
BEGIN
  acc            :=0;
  acc_err        :=0;
  sql_stmt_trunc :='TRUNCATE TABLE '|| target_table_cls;
  EXECUTE immediate sql_stmt_trunc;
  dbms_output.put_line('Table '|| target_table_cls||' is successfully truncated.');
  EXECUTE immediate sql_stmt_trunc||'_error';
  dbms_output.put_line('Table '|| target_table_cls||'_error'||' is successfully truncated.');
  drop_seq('seq_cust');
  EXECUTE IMMEDIATE 'CREATE SEQUENCE SEQ_CUST INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE';
  dbms_output.put_line('New sequence is created.');
  OPEN c_data;
  LOOP
    FETCH c_data bulk collect INTO t_data limit 10000;
    EXIT
  WHEN t_data.count = 0;
    FOR i IN t_data.first .. t_data.last
    LOOP
      IF t_data(i).code IS NULL OR (t_data(i).name IS NULL AND t_data(i).sur IS NULL) OR LENGTH(t_data(i).mid_name)>3 THEN
        INSERT
        INTO cls_customers_error VALUES
          (
            t_data(i).code,
            t_data(i).sur,
            t_data(i).name,
            t_data(i).phone,
            t_data(i).email
          );
        acc_err := acc_err+ SQL%ROWCOUNT;
      ELSE
        INSERT
        INTO cls_customers
          (
            cust_code,
            cust_name,
            cust_surname,
            cust_email,
            cust_phone,
            cust_age,
            cust_city_id,
            cust_card_num
          )
        SELECT DISTINCT 
            t_data(i).code code,
            INITCAP(t_data(i).name) n,
            INITCAP(REPLACE(t_data(i).sur,'?','')) sur,
            NVL(LOWER(t_data(i).email),'N/D') email,
            NVL(t_data(i).phone,'N/D') phone,
            t_data(i).birth b,
            city_id cit,
            t_data(i).card_num card
            FROM wrk_customers wrk
            INNER JOIN cls_cities cls
            ON t_data(i).city=cls.city_desc
            INNER JOIN bl_3nf.ce_cities ce
           ON cls.city_code=ce.city_code;
        acc := acc + SQL%ROWCOUNT;
      END IF;
    END LOOP;
  END LOOP;
  dbms_output.put_line('Data is successfully loaded in the table '||target_table_cls||' : '||acc|| ' rows were inserted.');
  dbms_output.put_line('Corrupted data is successfully loaded in the table '||target_table_cls||'_error : '||acc_err|| ' rows were inserted.');
  CLOSE c_data;
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
    ce.update_dt        =TRUNC(sysdate) WHEN NOT MATCHED THEN
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
EXECUTE pckg_insert_customers.insert_bl_wrk(source_table=>'src.ext_customers', target_table_wrk=>'wrk_customers');
SELECT * FROM wrk_customers;
EXECUTE pckg_insert_customers.insert_bl_cls(source_table_wrk=>'wrk_customers', target_table_cls=>'cls_customers');
SELECT * FROM cls_customers;
EXECUTE pckg_insert_customers.insert_bl_3nf;
select * from bl_3nf.ce_customers;
CREATE SEQUENCE SEQ_CUST_3NF INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
