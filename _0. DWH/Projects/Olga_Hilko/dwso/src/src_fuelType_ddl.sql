show user;
SET DEFINE OFF
--CREATE OR REPLACE DIRECTORY EXT_TABLES_DWH AS 'C:\Olga_Hilko\DWH\src\project';
--GRANT READ ON DIRECTORY EXT_TABLES_DWH TO USER;
--GRANT WRITE ON DIRECTORY EXT_TABLES_DWH TO USER;

exec  FRAMEWORK.pkg_utl_drop.proc_drop_obj ('src_fuelType', 'TABLE'); 
CREATE TABLE src_fuelType 
( key NUMBER(3),
  EngType VARCHAR2(10) ,
  Type VARCHAR2(26) ,
  Description VARCHAR2(128),
  startDate VARCHAR2(10),
  endDate VARCHAR2(10))
ORGANIZATION EXTERNAL
  (  TYPE ORACLE_LOADER
     DEFAULT DIRECTORY EXT_TABLES_DWH
     ACCESS PARAMETERS 
       (records delimited BY '\r\n' 
           NOBADFILE
           NODISCARDFILE
           LOGFILE EXT_TABLES_LOGS:'fuelTypeUTF.log'
           skip 1 
           fields terminated BY ','
           OPTIONALLY ENCLOSED BY '"' AND '"'
           lrtrim
           missing field VALUES are NULL
           ( key CHAR(4000),
             EngType CHAR(4000),
             Type CHAR(4000),
             Description CHAR(4000),
             startDate CHAR(4000),
             endDate CHAR(4000)
           )
       )
     LOCATION ('fuelTypeUTFd.csv')
  )
  REJECT LIMIT UNLIMITED;
  
select * from src_fuelType WHERE ROWNUM <= 100;

--commit;
