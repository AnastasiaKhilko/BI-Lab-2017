------------------------------------------------------------------------------
-- Author  : Melikava Saida
-- Created : 23/11/2017
-- Modified: 23/11/2017
-- Purpose : Insert data about payment methods from source to DWH.
------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE pckg_insert_payment
AS
  PROCEDURE insert_bl_wrk(
      source_table     IN VARCHAR2,
      target_table_wrk IN VARCHAR2);
  PROCEDURE insert_bl_cls(
      source_table_wrk IN VARCHAR2,
      target_table_cls IN VARCHAR2);
  PROCEDURE insert_bl_3NF;
END pckg_insert_payment;
/
CREATE OR REPLACE PACKAGE BODY pckg_insert_payment
AS
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
  dbms_output.put_line('Table '||target_table_wrk||'is successfully truncated');
  EXECUTE immediate sql_stmt_insert;
  dbms_output.put_line('Data in the table '||target_table_wrk||' is successfully loaded: '||SQL%ROWCOUNT|| ' rows were inserted.');
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END;
PROCEDURE insert_bl_cls(
    source_table_wrk IN VARCHAR2,
    target_table_cls IN VARCHAR2)
IS
  sql_stmt_trunc  VARCHAR2(250);
  sql_stmt_insert VARCHAR2(250);
BEGIN
  sql_stmt_trunc :='TRUNCATE TABLE '|| target_table_cls;
  sql_stmt_insert:='INSERT INTO '|| target_table_cls||' SELECT * FROM '|| source_table_wrk;
  EXECUTE immediate sql_stmt_trunc;
  dbms_output.put_line('Table '||target_table_cls||'is successfully truncated');
  EXECUTE immediate sql_stmt_insert;
  dbms_output.put_line('Data in the table '||target_table_cls||' is successfully loaded: '||SQL%ROWCOUNT|| ' rows were inserted.');
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END;
/********CLS->3NF*************/
/*****************************/
PROCEDURE insert_bl_3NF
IS
BEGIN
  MERGE INTO bl_3nf.ce_payments ce USING
  ( SELECT code, type, descr, prepayment FROM cls_payments
  MINUS
  SELECT payment_code AS code,
    payment_type_group,
    payment_type_description,
    prepayment
  FROM bl_3nf.ce_payments
  ) cls ON ( cls.code= ce.payment_code )
WHEN MATCHED THEN
  UPDATE
  SET ce.payment_type_group     = cls.type,
    ce.payment_type_description = cls.descr,
    ce.prepayment               = cls.prepayment,
    ce.update_dt                =sysdate WHEN NOT MATCHED THEN
  INSERT
    (
      payment_id,
      payment_code,
      payment_type_group,
      payment_type_description,
      prepayment
    )
    VALUES
    (
      seq_pay_3nf.nextval ,
      cls.code,
      cls.type ,
      cls.descr,
      cls.prepayment
    ) ;
  COMMIT;
END;
END pckg_insert_payment;
/
EXECUTE pckg_insert_payment.insert_bl_wrk(source_table=>'src.ext_payment', target_table_wrk=>'wrk_payment');
EXECUTE pckg_insert_payment.insert_bl_cls(source_table_wrk=>'wrk_payment', target_table_cls=>'cls_payments');
EXECUTE pckg_insert_payment.insert_bl_3nf;
SELECT * FROM bl_3nf.ce_payments;
ROLLBACK;
CREATE SEQUENCE SEQ_PAY_3NF INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
