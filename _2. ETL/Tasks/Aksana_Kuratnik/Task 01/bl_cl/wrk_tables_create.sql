CREATE OR REPLACE package pkg_insert_to_wrk
AUTHID CURRENT_USER as
PROCEDURE insert_table_to_wrk(distanation_table   IN varchar2,
                               source_table IN varchar2);
END pkg_insert_to_wrk;


CREATE OR REPLACE PACKAGE BODY  pkg_insert_to_wrk AS 
PROCEDURE insert_table_to_wrk (distanation_table   IN varchar2,
                               source_table IN varchar2)
IS                             
BEGIN
  EXECUTE IMMEDIATE ('TRUNCATE TABLE ' || distanation_table);
  EXECUTE IMMEDIATE ('INSERT INTO ' || distanation_table  || ' SELECT * FROM ' || source_table);
  
END insert_table_to_wrk;
END pkg_insert_to_wrk;