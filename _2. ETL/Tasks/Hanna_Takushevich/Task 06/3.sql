CREATE OR REPLACE PACKAGE pkg_drop_object AUTHID CURRENT_USER
AS
  /**===============================================*\
  Name...............:   pkg_drop_object
  Contents...........:   This package is useful for dropping objects
  Author.............:   Hanna Takushevich
  Date...............:   25-11-2017
  \*=============================================== */
  /**
  * The procedure drops object with specified type and name
  */
  PROCEDURE drop_proc(
      Object_Name IN VARCHAR2,
      Object_Type VARCHAR2);
END pkg_drop_object;
/
CREATE OR REPLACE PACKAGE BODY pkg_drop_object
AS
PROCEDURE drop_proc(
    Object_Name IN VARCHAR2,
    Object_Type VARCHAR2)
IS
  ex_table          EXCEPTION;
  ex_public_synonym EXCEPTION;
  ex_synonym        EXCEPTION;
  ex_user           EXCEPTION;
  ex_seq           EXCEPTION;
  PRAGMA EXCEPTION_INIT( ex_table,          -00942 );
  PRAGMA EXCEPTION_INIT( ex_public_synonym, -01432 );
  PRAGMA EXCEPTION_INIT( ex_synonym,        -01434 );
  PRAGMA EXCEPTION_INIT( ex_user,           -01918 );
  PRAGMA EXCEPTION_INIT( ex_seq,            -02289 );
BEGIN
  IF Object_Type = 'TABLE' THEN
    EXECUTE immediate 'drop ' || Object_Type || ' ' || Object_Name || ' cascade constraints';
  elsif Object_Type = 'USER' THEN
    EXECUTE immediate 'drop ' || Object_Type || ' ' || Object_Name || ' cascade';
  ELSE
    EXECUTE immediate 'drop ' || Object_Type || ' ' || Object_Name;
  END IF;
EXCEPTION
WHEN ex_table THEN
  dbms_output.put_line(Object_Type || ' ' || Object_Name ||' does not exist');
  -- insert into log_table (error_message, error_code);
WHEN ex_seq THEN
  dbms_output.put_line(Object_Type || ' ' || Object_Name ||' does not exist');
WHEN ex_public_synonym THEN
  dbms_output.put_line(Object_Type || ' ' || Object_Name ||' does not exist');
WHEN ex_synonym THEN
  dbms_output.put_line(Object_Type || ' ' || Object_Name ||' does not exist');
WHEN ex_user THEN
  dbms_output.put_line(Object_Type || ' ' || Object_Name ||' does not exist');
WHEN OTHERS THEN
  RAISE;
END;
END pkg_drop_object;
/