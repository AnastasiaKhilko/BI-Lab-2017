/*GRANT READ ON DIRECTORY EXT_TABLES_DWH TO USER;
exec FRAMEWORK.pkg_utl_grants_mgmt.proc_grant ('select', 'SRC','SRC_GEO','BL_CL');*/

SET DEFINE OFF
--Windows:
--CREATE OR REPLACE DIRECTORY EXT_TABLES_DWH AS 'D:\Olga_Hilko\DWH\src\project';
--Linux:
CREATE OR REPLACE DIRECTORY EXT_TABLES_DWH AS '/media/sf_DWH/SRC/project/';
CREATE OR REPLACE DIRECTORY EXT_TABLES_LOGS AS '/media/sf_DWH/SRC/project/logs/';


exec  FRAMEWORK.pkg_utl_drop.proc_drop_obj ('SRC_GEO', 'TABLE');
CREATE TABLE SRC_GEO 
( SOATO NUMBER(12) ,
  NAME VARCHAR2(100) ,
  OBL VARCHAR2(50),
  RAION VARCHAR2(50),
  SOVET VARCHAR2(128),
  TIP VARCHAR2(26),
  GNI NUMBER(5),
  DATAV DATE ,
  SOATON VARCHAR2(26),
  DATEL DATE ,
  MAL NUMBER(3))
ORGANIZATION EXTERNAL
  (  TYPE ORACLE_LOADER
     DEFAULT DIRECTORY EXT_TABLES_DWH
     ACCESS PARAMETERS 
       (records delimited BY '\r\n' 
           NOBADFILE
           NODISCARDFILE
           LOGFILE EXT_TABLES_LOGS:'CITY5UTF.log'
           skip 1 
           fields terminated BY ','
           OPTIONALLY ENCLOSED BY '"' AND '"'
           lrtrim
           missing field VALUES are NULL
           ( SOATO CHAR(4000),
             NAME CHAR(4000),
             OBL CHAR(4000),
             RAION CHAR(4000),
             SOVET CHAR(4000),
             TIP CHAR(4000),
             GNI CHAR(4000),
             DATAV CHAR(4000) date_format DATE mask "mm/dd/yyyy",
             SOATON CHAR(4000) ,
             DATEL CHAR(4000) date_format DATE mask "mm/dd/yyyy",
             MAL CHAR(4000)
           )
       )
     LOCATION ('CITY5UTF.csv')
  )
  REJECT LIMIT UNLIMITED;
  
--select count(*) from SRC_GEO;
