CREATE OR REPLACE PACKAGE pkg_drop 
  AUTHID CURRENT_USER AS
  PROCEDURE drop_proc ( object_name IN VARCHAR2, object_type VARCHAR2);
END pkg_drop;
/
CREATE OR REPLACE PACKAGE BODY  pkg_drop AS 
  PROCEDURE drop_proc (object_name IN VARCHAR2, object_type VARCHAR2) IS
  ex_grants exception;
  ex_inv_table_name exception;
  ex_exist_syn_name exception;
  ex_table exception;
  ex_public_synonym exception;
  ex_synonym exception;
  pragma exception_init( ex_grants, -01031 );
  pragma exception_init( ex_inv_table_name, -00903 );
  pragma exception_init( ex_exist_syn_name, -00955 );
  pragma exception_init( ex_table, -00942 );
  pragma exception_init( ex_public_synonym, -01432 );
  pragma exception_init( ex_synonym, -01434 );
	BEGIN
	  IF object_type = 'TABLE' THEN
		EXECUTE IMMEDIATE 'drop ' || object_type || ' ' || object_name || ' cascade constraints';
	  ELSE
		EXECUTE IMMEDIATE 'drop ' || object_type || ' ' || object_name;
	  END IF;
	  
	  exception
	  WHEN ex_table THEN
		   dbms_output.put_line(object_type || ' ' || object_name ||' does not exist');
		   -- insert into log_table (error_message, error_code);
	  WHEN ex_grants  THEN
		   dbms_output.put_line('User has no grants');
	  WHEN ex_inv_table_name THEN
		   dbms_output.put_line('Invalid table name');
	  WHEN ex_exist_syn_name THEN
		   dbms_output.put_line('Name is already used by an existing object');
	  WHEN ex_public_synonym THEN
		   dbms_output.put_line(object_type || ' ' || object_name ||' does not exist');
	  WHEN ex_synonym THEN
		  dbms_output.put_line(object_type || ' ' || object_name ||' does not exist');
	  WHEN others THEN
		   raise;
	END;
END pkg_drop;
/