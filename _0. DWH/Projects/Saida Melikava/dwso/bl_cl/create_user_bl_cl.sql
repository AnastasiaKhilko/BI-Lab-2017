DROP USER BL_CL CASCADE;

  CREATE USER BL_CL
  IDENTIFIED BY 123456
  DEFAULT TABLESPACE users
  QUOTA UNLIMITED ON users
  TEMPORARY TABLESPACE temp
  PROFILE default;
  
grant create session to BL_CL;
EXEC system.pckg_grant.grant_proc(grant_name=>'CREATE ANY TABLE', user_name=>'BL_CL');
EXEC system.pckg_grant.grant_proc(grant_name=>'SELECT ANY TABLE', user_name=>'BL_CL');
EXEC system.pckg_grant.grant_proc(grant_name=>'READ,WRITE ON DIRECTORY ETL', user_name=>'BL_CL');
EXEC system.pckg_grant.grant_proc(grant_name=>'CREATE ANY PROCEDURE', user_name=>'BL_CL');
EXEC system.pckg_grant.grant_proc(grant_name=>'CREATE ANY SEQUENCE', user_name=>'BL_CL');
EXEC system.pckg_grant.grant_proc(grant_name=>'CREATE ANY TYPE', user_name=>'BL_CL');
EXEC system.pckg_grant.grant_proc(grant_name=>'INSERT ANY TABLE', user_name=>'BL_CL');
EXEC system.pckg_grant.grant_proc(grant_name=>'UPDATE ANY TABLE', user_name=>'BL_CL');
EXEC system.pckg_grant.grant_proc(grant_name=>'CREATE ANY SYNONYM', user_name=>'BL_CL');