--grant  read  any directory to dwh;
--CREATE OR REPLACE DIRECTORY EnterNewDir AS 'F:\Lola\BI\Kondrutsuk';
--grant dba to dwh;
/*SET DEFINE OFF
CREATE OR REPLACE DIRECTORY EXT_TABLES_DWH AS '/media/sf_DWH/SRC/project/';
GRANT READ ON DIRECTORY EXT_TABLES_DWH TO BL_CL;
GRANT write ON DIRECTORY EXT_TABLES_DWH TO BL_CL;
*/

--GRANT WRITE ON DIRECTORY Enter New Dir TO USER;
exec  FRAMEWORK.pkg_utl_drop.proc_drop_obj ('SRC_AZS', 'TABLE');
CREATE TABLE SRC_AZS 
( N NUMBER(4),
  Country VARCHAR2(3),
  Location VARCHAR2(256),
  Latitude NUMBER(10, 6),
  Longitude VARCHAR2(26),
  ROAD1 VARCHAR2(26),
  ROAD2 VARCHAR2(5),
  DT NUMBER(1),
  DT2 NUMBER(1),
  AI92 NUMBER(1),
  BN92 NUMBER(1),
  AI95 NUMBER(1),
  LPG NUMBER(1),
  AI98 NUMBER(1))
ORGANIZATION EXTERNAL
  (  TYPE ORACLE_LOADER
     DEFAULT DIRECTORY EXT_TABLES_DWH
     ACCESS PARAMETERS 
       (records delimited BY '\n' 
           NOBADFILE
           NODISCARDFILE
           LOGFILE EXT_TABLES_DWH:'azsUTF.log'
           skip 1 
           fields terminated BY ';'
           OPTIONALLY ENCLOSED BY '"' AND '"'
           lrtrim
           missing field VALUES are NULL
           ( N CHAR(4000),
             Country CHAR(4000),
             Location CHAR(4000),
             Latitude CHAR(4000),
             Longitude CHAR(4000),
             ROAD1 CHAR(4000),
             ROAD2 CHAR(4000),
             DT CHAR(4000),
             DT2 CHAR(4000),
             AI92 CHAR(4000),
             BN92 CHAR(4000),
             AI95 CHAR(4000),
             LPG CHAR(4000),
             AI98 CHAR(4000)
           )
       )
     LOCATION ('azsUTF.csv')
  )
  REJECT LIMIT UNLIMITED;

select * from SRC_AZS ;
--commit;
exec FRAMEWORK.pkg_utl_grants_mgmt.proc_grant ('select', 'SRC','SRC_AZS','BL_CL2');
grant select on SRC.SRC_AZS to BL_CL;
grant RESOURCE to BL_CL2;
