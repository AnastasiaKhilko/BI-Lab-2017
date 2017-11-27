EXECUTE pckg_drop.drop_proc(object_name=>'src',object_type=>'user');

  CREATE USER SRC
  IDENTIFIED BY 123456
  DEFAULT TABLESPACE users
  QUOTA UNLIMITED ON users
  TEMPORARY TABLESPACE temp
  PROFILE default;
  
grant create session to SRC;
EXEC system.pckg_grant.grant_proc(grant_name=>'CREATE ANY TABLE', user_name=>'SRC');
EXEC system.pckg_grant.grant_proc(grant_name=>'SELECT ANY TABLE', user_name=>'SRC');
EXEC system.pckg_grant.grant_proc(grant_name=>'READ,WRITE ON DIRECTORY ETL', user_name=>'SRC');
EXEC system.pckg_grant.grant_proc(grant_name=>'CREATE ANY PROCEDURE', user_name=>'SRC');
EXEC system.pckg_grant.grant_proc(grant_name=>'CREATE ANY SYNONYM', user_name=>'SRC');
