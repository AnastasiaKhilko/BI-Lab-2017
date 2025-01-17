
CREATE TABLESPACE TBS_DWH_TEST 
    DATAFILE 
        'DWH_TEST_001.DBF' SIZE 104857600 AUTOEXTEND ON NEXT 20971520 
    NOLOGGING 
    SEGMENT SPACE MANAGEMENT AUTO 
    EXTENT MANAGEMENT LOCAL AUTOALLOCATE;

CREATE USER DWH
    IDENTIFIED BY "Q1w2e3r4"
    default TABLESPACE TBS_DWH_TEST;

grant CREATE PROCEDURE to DWH; 	
grant CREATE SEQUENCE to DWH; 	
grant CREATE TABLE to DWH; 		
grant CREATE TRIGGER to DWH; 	
grant CREATE VIEW to DWH; 	
grant CREATE INDEX to DWH; 

grant DROP PROCEDURE to DWH; 	
grant DROP SEQUENCE to DWH; 	
grant DROP TABLE to DWH; 		
grant DROP TRIGGER to DWH; 	
grant DROP VIEW to DWH; 	
 

grant SELECT ANY TABLE to DWH;		
grant SELECT ANY SEQUENCE to DWH;