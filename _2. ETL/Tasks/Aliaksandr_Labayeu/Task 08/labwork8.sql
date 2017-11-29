SELECT * FROM dba_tablespaces;

CREATE USER tester1 IDENTIFIED BY 123456;
GRANT EXP_FULL_DATABASE TO tester1;
GRANT CONNECT TO tester1;
GRANT CREATE TABLE TO tester1;
GRANT ALL ON tester1.table_tester1 TO tester1;
ALTER USER tester1 QUOTA 10 ON tbl_t1;

CREATE USER tester2 IDENTIFIED BY 123456;
GRANT EXP_FULL_DATABASE TO tester2;
GRANT CONNECT TO tester2;
GRANT CREATE TABLE TO tester2;
ALTER USER tester2 QUOTA 10 ON tbl_t2;
GRANT CREATE TYPE TO tester2;
GRANT CREATE PROCEDURE TO tester2;

GRANT CREATE DATABASE link TO tester2;

CREATE PUBLIC DATABASE LINK tester3_link
CONNECT TO tester2 IDENTIFIED BY "123456"
USING '//localhost:1521/orcl';

DROP TABLESPACE tbl_t2;
CREATE TABLESPACE tbl_t1
  DATAFILE '/media/sf_shared/tbl1.dat' 
  SIZE 100M 
  REUSE AUTOEXTEND ON NEXT 2M MAXSIZE 200M
/

CREATE TABLESPACE tbl_t2
  DATAFILE '/media/sf_shared/tbl2.dat' 
  SIZE 100M 
  REUSE AUTOEXTEND ON NEXT 2M MAXSIZE 200M
/

SELECT * FROM SYS.TRANSPORT_SET_VIOLATIONS; 
ALTER TABLESPACE tbl_t1 READ ONLY;
CREATE directory export AS '/media/sf_shared';

expdp system dumpfile=expdat.dmp directory=data_pump_dir 
        transport_tablespaces=sales_1,sales_2 logfile=tts_export.log;

