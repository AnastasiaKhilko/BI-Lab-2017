------------------------------------------------------------------------------
-- Author  : Melikava Saida
-- Created : 23/11/2017
-- Modified: 24/11/2017
-- Purpose : Insert address data from source to DWH.
------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE pckg_insert_addr
AS
  PROCEDURE insert_bl_wrk(
      source_table     IN VARCHAR2,
      target_table_wrk IN VARCHAR2);
  PROCEDURE insert_bl_cls(
      source_table_wrk IN VARCHAR2,
      target_table_cls IN VARCHAR2);
  PROCEDURE insert_bl_3NF;
END pckg_insert_addr;
/
CREATE OR REPLACE PACKAGE BODY pckg_insert_addr
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
  sql_stmt_insert:='INSERT INTO '|| target_table_wrk||' SELECT street, number_house, city FROM '|| source_table;
  EXECUTE immediate sql_stmt_trunc;
  dbms_output.put_line('Table '|| target_table_wrk||' is successfully truncated.');
  EXECUTE immediate sql_stmt_insert;
  dbms_output.put_line('Data in the table '||target_table_wrk||' is successfully loaded: '||SQL%ROWCOUNT|| ' rows were inserted.');
  COMMIT;
  dbms_output.put_line('Transaction is commited.');
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END insert_bl_wrk;
/********WRK->CLS*************/
/*****************************/
PROCEDURE insert_bl_cls(
    source_table_wrk IN VARCHAR2,
    target_table_cls IN VARCHAR2)
IS
  sql_stmt_trunc  VARCHAR2(250);
  sql_stmt_insert VARCHAR2(1050);
  sql_stmt_select VARCHAR2(1050);
  acc             NUMBER(8);
  acc_err         NUMBER(8);
  CURSOR c_data
  IS
    SELECT addr_street, addr_number_house, addr_city FROM wrk_addr ;
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
  EXECUTE IMMEDIATE 'DROP SEQUENCE SEQ_ADDR';
  EXECUTE IMMEDIATE 'CREATE SEQUENCE SEQ_ADDR INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE';
  dbms_output.put_line('New sequence is created.');
  OPEN c_data;
  LOOP
    FETCH c_data bulk collect INTO t_data limit 10000;
    EXIT
  WHEN t_data.count = 0;
    FOR i IN t_data.first .. t_data.last
    LOOP
      IF t_data(i).addr_street IS NULL OR t_data(i).addr_number_house IS NULL THEN
        INSERT
        INTO cls_addr_error VALUES
          (
            t_data(i).addr_street,
            t_data(i).addr_number_house,
            t_data(i).addr_city
          );
        acc_err := acc_err+ SQL%ROWCOUNT;
      ELSE
        INSERT INTO cls_addr
        SELECT seq_addr.nextval,
          str,
          num,
          ct
        FROM
          ( SELECT DISTINCT RTRIM(t_data(i).addr_street) str,
            t_data(i).addr_number_house num,
            city_id ct
          FROM wrk_addr wrk
          INNER JOIN cls_cities cls
          ON t_data(i).addr_city=cls.city_desc
          INNER JOIN bl_3nf.ce_cities ce
          ON cls.city_code=ce.city_code
          );
        acc := acc + SQL%ROWCOUNT;
      END IF;
    END LOOP;
  END LOOP;
  dbms_output.put_line('Data is successfully loaded in the table '||target_table_cls||' : '||acc|| ' rows were inserted.');
  dbms_output.put_line('Corrupted data is successfully loaded in the table '||target_table_cls||'_error : '||acc_err|| ' rows were inserted.');
  CLOSE c_data;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END insert_bl_cls;
/********CLS->3NF*************/
/*****************************/
PROCEDURE insert_bl_3NF
IS
BEGIN
  MERGE INTO bl_3nf.ce_addr ce USING
  ( SELECT addr_code, addr_street, addr_number_house, addr_city FROM cls_addr
  MINUS
  SELECT addr_code,
    addr_street,
    addr_number_house,
    addr_city_id
  FROM bl_3nf.ce_addr
  ) cls ON ( cls.addr_code = ce.addr_code )
WHEN MATCHED THEN
  UPDATE
  SET ce.addr_street     = cls.addr_street,
    ce.addr_number_house = cls.addr_number_house,
    ce.addr_city_id      = cls.addr_city,
    ce.update_dt         =sysdate WHEN NOT MATCHED THEN
  INSERT
    (
      addr_id ,
      addr_code,
      addr_street,
      addr_number_house,
      addr_city_id
    )
    VALUES
    (
      seq_addr_3nf.nextval ,
      cls.addr_code,
      cls.addr_street ,
      cls.addr_number_house,
      cls.addr_city
    ) ;
  COMMIT;
END;
END pckg_insert_addr;
/

  

