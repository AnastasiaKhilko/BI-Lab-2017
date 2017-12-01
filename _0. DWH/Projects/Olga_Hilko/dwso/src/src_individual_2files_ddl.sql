SET DEFINE OFF
--CREATE OR REPLACE DIRECTORY EXT_TABLES_DWH AS 'C:\Olga_Hilko\DWH\src\project';
--GRANT READ ON DIRECTORY EXT_TABLES_DWH TO USER;
--GRANT WRITE ON DIRECTORY EXT_TABLES_DWH TO USER;
exec  FRAMEWORK.pkg_utl_drop.proc_drop_obj ('SRC_INDIVIDUAL', 'TABLE');
CREATE TABLE SRC_INDIVIDUAL 
( Gender VARCHAR2(10),
  Title VARCHAR2(10),
  GivenName VARCHAR2(50),
  MiddleInitial VARCHAR2(5),
  Surname VARCHAR2(50),
  StreetAddress VARCHAR2(50),
  City VARCHAR2(50),
  State VARCHAR2(50),
  StateFull VARCHAR2(100),
  ZipCode VARCHAR2(20),
  Country VARCHAR2(26),
  EmailAddress VARCHAR2(128),
  TelephoneNumber VARCHAR2(50),
  Birthday VARCHAR2(10),
  Age NUMBER(4),
  CCType VARCHAR2(26),
  CCNumber NUMBER(16),
  CCExpires VARCHAR2(7),
  NationalID VARCHAR2(20),
  Vehicle VARCHAR2(50),
  StartDate  VARCHAR2(10),
  EndDate  VARCHAR2(10)
  )
ORGANIZATION EXTERNAL
  (  TYPE ORACLE_LOADER
     DEFAULT DIRECTORY EXT_TABLES_DWH
     ACCESS PARAMETERS 
       (records delimited BY '\n' 
           NOBADFILE
           NODISCARDFILE
           LOGFILE EXT_TABLES_LOGS:'FakeName.log'
           skip 1 
           fields terminated BY ','
           OPTIONALLY ENCLOSED BY '"' AND '"'
           lrtrim
           missing field VALUES are NULL
           ( Gender CHAR(4000),
             Title CHAR(4000),
             GivenName CHAR(4000),
             MiddleInitial CHAR(4000),
             Surname CHAR(4000),
             StreetAddress CHAR(4000),
             City CHAR(4000),
             State CHAR(4000),
             StateFull CHAR(4000),
             ZipCode CHAR(4000),
             Country CHAR(4000),
             EmailAddress CHAR(4000),
             TelephoneNumber CHAR(4000),
             Birthday CHAR(4000),
             Age CHAR(4000),
             CCType CHAR(4000),
             CCNumber CHAR(4000),
             CCExpires CHAR(4000),
             NationalID CHAR(4000),
             Vehicle CHAR(4000),
             StartDate CHAR(4000),
             EndDate CHAR(4000)
           )
       )
     LOCATION ('FakeName3d.csv') --'FakeName1.csv','FakeName2.csv' ,'FakeName2d.csv'
  )
  REJECT LIMIT UNLIMITED;
exec FRAMEWORK.pkg_utl_grants_mgmt.proc_grant ('select', 'SRC','src_individual','BL_CL');  
select-- *
count(*) 
from SRC_INDIVIDUAL ;


