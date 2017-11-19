-- DROP object
-- SO as to execute procedure use:
-- execute pckg_drop.drop_proc('table', 't10');

CREATE OR REPLACE PACKAGE pkg_utl_drop 
  AUTHID CURRENT_USER as
  PROCEDURE proc_drop_obj ( Object_Name IN varchar2, Object_Type varchar2);
END pkg_utl_drop;
/

CREATE OR REPLACE PACKAGE BODY  pkg_utl_drop AS 
  PROCEDURE proc_drop_obj (Object_Name IN varchar2, Object_Type varchar2) is
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
	  else
		execute immediate 'drop ' || Object_Type || ' ' || Object_Name;
	  end if;
	  
	  EXCEPTION
	  WHEN ex_table THEN
		   dbms_output.put_line(Object_Type || ' ' || Object_Name ||' does not exist');
		   -- insert into log_table (error_message, error_code);
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
		   RAISE;
	END;
END pkg_utl_drop;
/






/*from system - user
this package is executed with the grands  of the user, who executes it
*/

/*Put cursor and press F9*/
--exec example: grant_blat(grant_name, schema, object, User_name)
CREATE OR REPLACE PACKAGE pkg_utl_grants_mgmt
AUTHID CURRENT_USER
AS
  PROCEDURE proc_grant (GRANT_NAME IN VARCHAR2, SCHEMA_NAME IN VARCHAR2, OBJECT_NAME IN VARCHAR2, USER_NAME IN VARCHAR2);
  PROCEDURE proc_grant (GRANT_NAME IN VARCHAR2, USER_NAME IN VARCHAR2, WAO IN BOOLEAN := FALSE);
END pkg_utl_grants_mgmt;
/

/*Put cursor and press F9*/
--exec example: grant_blat(type_grant, User_name, [With admin option])
CREATE OR REPLACE PACKAGE BODY pkg_utl_grants_mgmt AS
  /*GRANT_NAME: type of grant (select, create, alter, delete, etc. -  look at Sasha Chaika's presentation, p.20-21
  SCHEMA_NAME: name of the schema, which contains granting object
  OBJECT_NAME: granting object's name 
  USER_NAME: who is granted with the privileges
  */
  PROCEDURE proc_grant (GRANT_NAME IN VARCHAR2, SCHEMA_NAME IN VARCHAR2, OBJECT_NAME IN VARCHAR2, USER_NAME IN VARCHAR2 ) 
  IS
  BEGIN
  
  EXECUTE IMMEDIATE ('GRANT ' || GRANT_NAME || ' ON ' || SCHEMA_NAME || '.' || OBJECT_NAME || ' TO ' || USER_NAME);
  END proc_grant;
  
 /*GRANT_NAME: one of the possible
            ANY TABLE,  ANY PROCEDURE, ANY SEQUENCE, ANY TABLE, ANY TRIGGER, ANY VIEW, ANY INDEX, DBA, ALL PRIVILEGES
  USER_NAME: who is granted with the privileges
  WAO : flag (false - dafault value)
            true - with admin option
            false - simple user (without granting possibility)
 */
 PROCEDURE proc_grant (GRANT_NAME VARCHAR2, USER_NAME VARCHAR2, WAO IN BOOLEAN := FALSE)   IS
  BEGIN
      IF WAO THEN
        EXECUTE IMMEDIATE ('GRANT ' || GRANT_NAME || ' TO ' || USER_NAME || ' WITH ADMIN OPTION');
      END IF;
      EXECUTE IMMEDIATE ('GRANT ' || GRANT_NAME || ' TO ' || USER_NAME);
  END;
END pkg_utl_grants_mgmt;
/