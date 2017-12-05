CREATE OR REPLACE PACKAGE pckg_drop AUTHID CURRENT_USER
AS
  PROCEDURE DROP_PROC(
      Object_Name IN VARCHAR2,
      Object_Type VARCHAR2);
END pckg_drop;
/
CREATE OR REPLACE PACKAGE BODY pckg_drop
AS
PROCEDURE DROP_PROC(
    Object_Name IN VARCHAR2,
    Object_Type VARCHAR2)
IS
  ex_grants         EXCEPTION;
  ex_inv_table_name EXCEPTION;
  ex_exist_syn_name EXCEPTION;
  ex_table          EXCEPTION;
  ex_public_synonym EXCEPTION;
  ex_synonym        EXCEPTION;
  ex_user           EXCEPTION;
  ex_seq            EXCEPTION;
  PRAGMA EXCEPTION_INIT( ex_seq,            -02289 );
  PRAGMA EXCEPTION_INIT( ex_grants,         -01031 );
  PRAGMA EXCEPTION_INIT( ex_inv_table_name, -00903 );
  PRAGMA EXCEPTION_INIT( ex_exist_syn_name, -00955 );
  PRAGMA EXCEPTION_INIT( ex_table,          -00942 );
  PRAGMA EXCEPTION_INIT( ex_public_synonym, -01432 );
  PRAGMA EXCEPTION_INIT( ex_synonym,        -01434 );
  PRAGMA EXCEPTION_INIT( ex_user,           -01918 );
BEGIN
  IF Object_Type = 'TABLE' THEN
    EXECUTE immediate 'drop ' || Object_Type || ' ' || Object_Name || ' cascade constraints';
  ELSE
    EXECUTE immediate 'drop ' || Object_Type || ' ' || Object_Name;
  END IF;
EXCEPTION
WHEN ex_table THEN
  dbms_output.put_line(Object_Type || ' ' || Object_Name ||' does not exist');
  -- insert into log_table (error_message, error_code);
WHEN ex_grants THEN
  dbms_output.put_line('User has no grants');
WHEN ex_inv_table_name THEN
  dbms_output.put_line('Invalid table name');
WHEN ex_exist_syn_name THEN
  dbms_output.put_line('Name is already used by an existing object');
WHEN ex_public_synonym THEN
  dbms_output.put_line(Object_Type || ' ' || Object_Name ||' does not exist');
WHEN ex_synonym THEN
  dbms_output.put_line(Object_Type || ' ' || Object_Name ||' does not exist');
WHEN ex_user THEN
  dbms_output.put_line(Object_Type || ' ' || Object_Name ||' does not exist');
WHEN ex_seq THEN
  dbms_output.put_line(Object_Type || ' ' || Object_Name ||' does not exist');
WHEN OTHERS THEN
  RAISE;
END;
END pckg_drop;
/
create or replace public synonym pckg_drop for system.pckg_drop;