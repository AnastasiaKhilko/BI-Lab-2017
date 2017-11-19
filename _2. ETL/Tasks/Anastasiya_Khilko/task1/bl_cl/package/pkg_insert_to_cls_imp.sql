CREATE OR REPLACE PACKAGE BODY  pkg_insert_to_cls AS 
PROCEDURE insert_table_to_cls (distanation_table   IN varchar2,
                               source_table IN varchar2)
IS                             
BEGIN
  EXECUTE IMMEDIATE ('TRUNCATE TABLE ' || distination_table);
  EXECUTE IMMEDIATE ('INSERT INTO ' || distination_table  || ' SELECT * FROM ' || source_table);
  
END insert_table_to_cls;
END pkg_insert_to_cls;