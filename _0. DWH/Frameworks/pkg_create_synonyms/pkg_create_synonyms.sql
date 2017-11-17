CREATE OR REPLACE PACKAGE pckg_synonyms  
  AUTHID CURRENT_USER as
  PROCEDURE Create_Syn_Priv (Schema_Name IN varchar2,
							Object_Name IN varchar2,
							Synonym_Name IN varchar2);
  Procedure Create_Syn_Pub  (Schema_Name IN varchar2,
							Object_Name IN varchar2,
							Synonym_Name IN varchar2);
END pckg_synonyms;


CREATE OR REPLACE PACKAGE BODY  pckg_synonyms AS 
  PROCEDURE Create_Syn_Priv (Schema_Name IN varchar2, Object_Name IN varchar2, Synonym_Name IN varchar2) is
  ex_grants EXCEPTION;
  ex_inv_table_name EXCEPTION;
  ex_exist_syn_name EXCEPTION;
  PRAGMA EXCEPTION_INIT( ex_grants, -01031 );
  PRAGMA EXCEPTION_INIT( ex_inv_table_name, -00903 );
  PRAGMA EXCEPTION_INIT( ex_exist_syn_name, -00955 );
  
BEGIN
  execute immediate 'CREATE or REPLACE SYNONYM '||Synonym_Name||' for '||Schema_Name||'.'||Object_Name;
  
  EXCEPTION
  WHEN ACCESS_INTO_NULL THEN
       dbms_output.put_line('Object is not exist');
  WHEN ex_grants  THEN
       dbms_output.put_line('User has no grants');
  WHEN ex_inv_table_name THEN
       dbms_output.put_line('Invalid table name');
  WHEN ex_exist_syn_name THEN
       dbms_output.put_line('Name is already used by an existing object');
  WHEN OTHERS THEN
       dbms_output.put_line('Undefinied mistake');
END;
  Procedure Create_Syn_Pub  (Schema_Name IN varchar2, Object_Name IN varchar2, Synonym_Name IN varchar2) is


  ex_grants EXCEPTION;
  ex_inv_table_name EXCEPTION;
  ex_exist_syn_name EXCEPTION;
  PRAGMA EXCEPTION_INIT( ex_grants, -01031 );
  PRAGMA EXCEPTION_INIT( ex_inv_table_name, -00903 );
  PRAGMA EXCEPTION_INIT( ex_exist_syn_name, -00955 );
  
BEGIN
  execute immediate 'CREATE or REPLACE PUBLIC SYNONYM '||Synonym_Name||' for '||Schema_Name||'.'||Object_Name;
  
  EXCEPTION
  WHEN ACCESS_INTO_NULL THEN
       dbms_output.put_line('Object is not exist');
  WHEN ex_grants  THEN
       dbms_output.put_line('User has no grants');
  WHEN ex_inv_table_name THEN
       dbms_output.put_line('Invalid table name');
  WHEN ex_exist_syn_name THEN
       dbms_output.put_line('Name is already used by an existing object');
  WHEN OTHERS THEN
       dbms_output.put_line('Undefinied mistake');
END;
END pckg_synonyms;


