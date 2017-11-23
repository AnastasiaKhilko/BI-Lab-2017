SET DEFINE OFF
--CREATE OR REPLACE DIRECTORY ENTERNEWDIR AS 'F:\Lola\BI\Kondrutsuk';
--GRANT READ ON DIRECTORY ENTERNEWDIR TO USER;
--GRANT WRITE ON DIRECTORY ENTERNEWDIR TO USER;
drop table src_o;
CREATE TABLE src_o 
( no NUMBER(4),
  name VARCHAR2(256),
  tax NUMBER(11),
  tax_gov nVARCHAR2(128),
  date_enter varchar(10))
ORGANIZATION EXTERNAL
  (  TYPE ORACLE_LOADER
     DEFAULT DIRECTORY ENTERNEWDIR
     ACCESS PARAMETERS 
       (records delimited BY '\r\n' 
           NOBADFILE
           NODISCARDFILE
           NOLOGFILE
           skip 1 
           fields terminated BY ';'
           OPTIONALLY ENCLOSED BY '"' AND '"'
           lrtrim
           missing field VALUES are NULL
           ( no CHAR(4000),
             name CHAR(4000),
             tax CHAR(4000),
             tax_gov CHAR(4000),
             date_enter CHAR(4000) 
           )
       )
     LOCATION ('organizationsUTF.csv')
  )
  REJECT LIMIT UNLIMITED;

select * from src_o;


