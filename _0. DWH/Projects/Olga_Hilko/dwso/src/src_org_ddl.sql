SET DEFINE OFF
--CREATE OR REPLACE DIRECTORY EXT_TABLES_DWH AS 'D:\Olga_Hilko\DWH\src\project';
exec  FRAMEWORK.pkg_utl_drop.proc_drop_obj ('src_org', 'TABLE');
CREATE TABLE src_org 
( nomer NUMBER(4) ,
  name NVARCHAR2(256) ,
  tax NUMBER(11) ,
  tax_gov VARCHAR2(128) ,
  start_date DATE,
  end_date DATE)
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
             start_date CHAR(4000) date_format DATE mask "dd.mm.yyyy",
             end_date CHAR(4000) date_format DATE mask "dd.mm.yyyy"
           )
       )
     LOCATION ('organizationsUTFd.csv')
  )
  REJECT LIMIT UNLIMITED;
exec FRAMEWORK.pkg_utl_grants_mgmt.proc_grant ('select', 'SRC','src_org','BL_CL');    
select * from src_org;


