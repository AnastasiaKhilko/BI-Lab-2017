CREATE OR REPLACE PACKAGE pckg_drop 
  AUTHID CURRENT_USER as
  PROCEDURE DROP_Proc ( Object_Name IN varchar2, Object_Type varchar2);
END pckg_drop;
/
CREATE OR REPLACE PACKAGE BODY  pckg_drop AS 
  PROCEDURE DROP_Proc (Object_Name IN varchar2, Object_Type varchar2) is
  ex_grants EXCEPTION;
  ex_inv_table_name EXCEPTION;
  ex_exist_syn_name EXCEPTION;
  ex_table EXCEPTION;
  ex_public_synonym EXCEPTION;
  ex_synonym EXCEPTION;
  PRAGMA EXCEPTION_INIT( ex_grants, -01031 );
  PRAGMA EXCEPTION_INIT( ex_inv_table_name, -00903 );
  PRAGMA EXCEPTION_INIT( ex_exist_syn_name, -00955 );
  PRAGMA EXCEPTION_INIT( ex_table, -00942 );
  PRAGMA EXCEPTION_INIT( ex_public_synonym, -01432 );
  PRAGMA EXCEPTION_INIT( ex_synonym, -01434 );
BEGIN
  if Object_Type = 'TABLE' THEN
    execute immediate 'drop ' || Object_Type || ' ' || Object_Name || ' cascade constraints';
    else  execute immediate 'drop ' || Object_Type || ' ' || Object_Name;
  end if;
  EXCEPTION
  WHEN ex_table THEN
       dbms_output.put_line(Object_Type || ' ' || Object_Name ||' does not exist');
  WHEN ex_grants  THEN
       dbms_output.put_line('User has no grants');
  WHEN ex_inv_table_name THEN
       dbms_output.put_line('Invalid table name');
  WHEN ex_exist_syn_name THEN
       dbms_output.put_line('Name is already used by an existing object');
  WHEN ex_public_synonym THEN
       dbms_output.put_line(Object_Type || ' ' || Object_Name ||' does not exist');
  WHEN ex_synonym THEN
      dbms_output.put_line(Object_Type || ' ' || Object_Name ||' does not exist');
  WHEN OTHERS THEN
       dbms_output.put_line('Undefinied mistake');
END;
END pckg_drop;
/