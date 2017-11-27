SET DEFINE OFF
--CREATE OR REPLACE DIRECTORY EXT_TABLES_DWH AS '/media/sf_DWH/SRC/project/';
--GRANT READ ON DIRECTORY ENTERNEWDIR TO BL_CL;
--GRANT WRITE ON DIRECTORY ENTERNEWDIR TO BL_CL;

exec  FRAMEWORK.pkg_utl_drop.proc_drop_obj ('src_individuals', 'TABLE');
CREATE TABLE src_individuals 
( NameSet VARCHAR2(30),
  Gender VARCHAR2(10),
  Title VARCHAR2(4),
  GivenName nVARCHAR2(20),
  MiddleInitial VARCHAR2(2),
  Surname VARCHAR2(12),
  StreetAddress VARCHAR2(22),
  City VARCHAR2(22),
  State VARCHAR2(3),
  StateFull VARCHAR2(50),
  ZipCode VARCHAR2(8),
  Country VARCHAR2(3),
  EmailAddress VARCHAR2(25),
  TelephoneNumber VARCHAR2(13),
  Birthday VARCHAR2(10),
  Age NUMBER(3),
  CCType VARCHAR2(10),
  CCNumber NUMBER(16),
  CCExpires VARCHAR2(7),
  NationalID VARCHAR2(13),
  Vehicle VARCHAR2(34))
ORGANIZATION EXTERNAL
  (  TYPE ORACLE_LOADER
     DEFAULT DIRECTORY EXT_TABLES_DWH
     ACCESS PARAMETERS 
       (records delimited BY '\r\n' 
           NOBADFILE
           NODISCARDFILE
           LOGFILE EXT_TABLES_DWH:'FakeName.log'
           skip 1 
           fields terminated BY ','
           OPTIONALLY ENCLOSED BY '"' AND '"'
           lrtrim
           missing field VALUES are NULL
           ( NameSet CHAR(4000),
             Gender CHAR(4000),
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
             Vehicle CHAR(4000)
           )
       )
     LOCATION ('FakeName.csv')
  )
  REJECT LIMIT UNLIMITED;

select * from SRC_INDIVIDUALS ;


