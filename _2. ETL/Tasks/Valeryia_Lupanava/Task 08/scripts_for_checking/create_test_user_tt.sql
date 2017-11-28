CREATE TABLESPACE test_data_tt
  DATAFILE 'test_data_tt.dbf'
  SIZE 1M AUTOEXTEND ON NEXT 1M;

CREATE USER test_user_tt IDENTIFIED BY test_user_tt
DEFAULT TABLESPACE test_data_tt TEMPORARY TABLESPACE temp 
QUOTA UNLIMITED ON test_data_tt;

GRANT CONNECT TO test_user_tt;
GRANT RESOURCE TO test_user_tt;
GRANT DBA TO test_user_tt;


