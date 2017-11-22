CREATE OR REPLACE PACKAGE pkg_synonyms  
  AUTHID CURRENT_USER AS
  PROCEDURE create_syn_priv (schema_name IN VARCHAR2,
                             object_name IN VARCHAR2,
                             synonym_name IN VARCHAR2);
  PROCEDURE create_syn_pub  (schema_name IN VARCHAR2,
                             object_name IN VARCHAR2,
                             synonym_name IN VARCHAR2);
END pkg_synonyms;


CREATE OR REPLACE PACKAGE BODY  pkg_synonyms AS 
  PROCEDURE create_syn_priv (schema_name IN VARCHAR2, 
                             object_name IN VARCHAR2, 
                             synonym_name IN VARCHAR2) 
IS
BEGIN
  EXECUTE IMMEDIATE 'CREATE or REPLACE SYNONYM '||synonym_name||' for '||schema_name||'.'||object_name;
  
  exception
  WHEN others THEN raise;
END;
  PROCEDURE create_syn_pub  (schema_name IN VARCHAR2, 
                             object_name IN VARCHAR2, 
                             synonym_name IN VARCHAR2) 
IS
BEGIN
  EXECUTE IMMEDIATE 'CREATE or REPLACE PUBLIC SYNONYM '||synonym_name||' for '||schema_name||'.'||object_name;
  
  exception
  WHEN others THEN raise;
END;
END pkg_synonyms;


