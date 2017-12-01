SET DEFINE OFF
--CREATE OR REPLACE DIRECTORY EXT_TABLES_DWH AS 'C:\Olga_Hilko\DWH\src\project';
--GRANT READ ON DIRECTORY EXT_TABLES_DWH TO USER;
--GRANT WRITE ON DIRECTORY EXT_TABLES_DWH TO USER;
exec  FRAMEWORK.pkg_utl_drop.proc_drop_obj ('src_address', 'TABLE');
 
CREATE TABLE src_address
( longitude NUMBER(10, 6),
  latitude NUMBER(10, 6),
  country VARCHAR2(35),
  c1 VARCHAR2(100),
  c2 VARCHAR2(100),
  c3 VARCHAR2(255),
  c4 VARCHAR2(100),
  c5 VARCHAR2(50),
  c6 VARCHAR2(50))
ORGANIZATION EXTERNAL
  (  TYPE ORACLE_LOADER
     DEFAULT DIRECTORY EXT_TABLES_DWH
     ACCESS PARAMETERS 
       (records delimited BY '\r\n' 
           NOBADFILE
           NODISCARDFILE
           LOGFILE EXT_TABLES_LOGS:'ADDRESS.log'
           skip 1 
           fields terminated BY ','
           OPTIONALLY ENCLOSED BY '"' AND '"'
           lrtrim
           missing field VALUES are NULL
           ( longitude CHAR(4000),
             latitude CHAR(4000),
             country CHAR(4000),
             c1 CHAR(4000),
             c2 CHAR(4000),
             c3 CHAR(4000),
             c4 CHAR(4000),
             c5 CHAR(4000),
             c6 CHAR(4000)
           )
       )
     LOCATION ('ADDRESS.CSV')
  )
  REJECT LIMIT UNLIMITED;
  
select count(*) from src_address;-- WHERE ROWNUM <= 100;


