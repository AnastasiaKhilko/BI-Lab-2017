------------------------------------------------------------------------------
-- Author  : Melikava Saida
-- Created : 23/11/2017
-- Modified: 23/11/2017
-- Purpose : Insert data about payment methods from source to DWH.
------------------------------------------------------------------------------
CREATE TYPE Paym_type
AS
  OBJECT
  (
    code     NUMBER(8),
  type       VARCHAR2 ( 200 CHAR ),
  descr      VARCHAR2 ( 200 CHAR ),
  prepayment VARCHAR2 ( 200 CHAR ));
CREATE TYPE Paym_func
IS
  TABLE OF Paym_type;
  /
CREATE OR REPLACE PACKAGE pckg_insert_payment
IS
  FUNCTION tab_func
    RETURN Paym_func PIPELINED;
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
FUNCTION tab_func
  RETURN Paym_func PIPELINED
IS
  CURSOR p
  IS
    SELECT * FROM wrk_payment ;
  out_rec Paym_type := Paym_type(NULL,NULL,NULL,NULL);
  in_rec p%ROWTYPE;
BEGIN
  OPEN p;
  LOOP
    FETCH p
    INTO in_rec;
    EXIT
  WHEN p%NOTFOUND;
    out_rec.code       := in_rec.code;
    out_rec.type       :=in_rec.type;
    out_rec.descr      := in_rec.descr;
    out_rec.prepayment := in_rec.prepayment;
    PIPE ROW(out_rec);
  END LOOP;
  CLOSE p;
  RETURN;
END;
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
  sql_stmt_insert:='INSERT INTO '|| target_table_cls||' SELECT * FROM  '|| source_table_wrk;
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
SELECT * FROM wrk_payment;
SELECT * FROM TABLE(tab_func());
EXECUTE pckg_insert_payment.insert_bl_cls(source_table_wrk=>'TABLE(tab_func())', target_table_cls=>'cls_payments');
SELECT * FROM cls_payments;
EXECUTE pckg_insert_payment.insert_bl_3nf;
SELECT * FROM bl_3nf.ce_payments;
ROLLBACK;
CREATE SEQUENCE SEQ_PAY_3NF INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
