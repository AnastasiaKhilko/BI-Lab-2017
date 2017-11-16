/*from system - user
this package is executed with the grands  of the user, who executes it
*/

/*Put cursor and press F9*/
--exec example: grant_blat(grant_name, schema, object, User_name)
CREATE OR REPLACE PACKAGE grants_mgmt
AUTHID CURRENT_USER
AS
  PROCEDURE GRANT_BLAT (GRANT_NAME IN VARCHAR2,
						SCHEMA_NAME IN VARCHAR2,
						OBJECT_NAME IN VARCHAR2,
						USER_NAME IN VARCHAR2);
						
  PROCEDURE GRANT_BLAT (GRANT_NAME IN VARCHAR2,
						USER_NAME IN VARCHAR2,
						WAO IN BOOLEAN := FALSE);
END grants_mgmt;
/

/*Put cursor and press F9*/
--exec example: grant_blat(type_grant, User_name, [With admin option])
CREATE OR REPLACE PACKAGE BODY grants_mgmt AS
  /*GRANT_NAME: type of grant (select, create, alter, delete, etc. -  look at Sasha Chaika's presentation, p.20-21
  SCHEMA_NAME: name of the schema, which contains granting object
  OBJECT_NAME: granting object's name 
  USER_NAME: who is granted with the privileges
  */
  PROCEDURE GRANT_BLAT (GRANT_NAME IN VARCHAR2,
						SCHEMA_NAME IN VARCHAR2,
						OBJECT_NAME IN VARCHAR2,
						USER_NAME IN VARCHAR2 ) 
  IS
  BEGIN
	  EXECUTE IMMEDIATE ('GRANT ' || GRANT_NAME || ' ON ' || SCHEMA_NAME || '.' || OBJECT_NAME || ' TO ' || USER_NAME);
  END GRANT_BLAT;
  
 /*GRANT_NAME: one of the possible
            ANY TABLE,  ANY PROCEDURE, ANY SEQUENCE, ANY TABLE, ANY TRIGGER, ANY VIEW, ANY INDEX, DBA, ALL PRIVILEGES
  USER_NAME: who is granted with the privileges
  WAO : flag (false - dafault value)
            true - with admin option
            false - simple user (without granting possibility)
 */
 PROCEDURE GRANT_BLAT (GRANT_NAME VARCHAR2, USER_NAME VARCHAR2, WAO IN BOOLEAN := FALSE)   IS
  BEGIN
      IF WAO THEN
        EXECUTE IMMEDIATE ('GRANT ' || GRANT_NAME || ' TO ' || USER_NAME || ' WITH ADMIN OPTION');
      END IF;
      EXECUTE IMMEDIATE ('GRANT ' || GRANT_NAME || ' TO ' || USER_NAME);
  END;
END grants_mgmt;
/