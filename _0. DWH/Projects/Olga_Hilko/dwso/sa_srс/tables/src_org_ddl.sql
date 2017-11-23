SET DEFINE OFF
--CREATE OR REPLACE DIRECTORY EXT_TABLES_DWH AS 'D:\Olga_Hilko\DWH\src\project';
exec  FRAMEWORK.pkg_utl_drop.proc_drop_obj ('src_org', 'TABLE');
CREATE TABLE src_org 
( nomer NUMBER(4) ,
  name NVARCHAR2(256) ,
  tax NUMBER(11) ,
  tax_gov VARCHAR2(128) ,
  date_enter DATE )
ORGANIZATION EXTERNAL
  (  TYPE ORACLE_LOADER
     DEFAULT DIRECTORY EXT_TABLES_DWH
     ACCESS PARAMETERS 
       (records delimited BY '\r\n' 
           NOBADFILE
           NODISCARDFILE
           LOGFILE EXT_TABLES_DWH:'organizationsUTF.log'
           skip 1 
           fields terminated BY ','
           OPTIONALLY ENCLOSED BY '"' AND '"'
           lrtrim
           missing field VALUES are NULL
           ( nomer CHAR(4000),
             name CHAR(4000),
             tax CHAR(4000),
             tax_gov CHAR(4000),
             date_enter CHAR(4000) date_format DATE mask "dd.mm.yyyy"
           )
       )
     LOCATION ('organizationsUTF.csv')
  )
  REJECT LIMIT UNLIMITED;
  
select * from src_org;


