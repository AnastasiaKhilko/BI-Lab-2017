DROP USER BL_CL_DM CASCADE;

  CREATE USER BL_CL_DM
  IDENTIFIED BY 123456
  DEFAULT TABLESPACE users
  QUOTA UNLIMITED ON users
  TEMPORARY TABLESPACE temp
  PROFILE default;
  
grant connect to BL_CL_DM;
grant create session to BL_CL_DM;
EXEC system.pckg_grant.grant_proc(grant_name=>'CREATE ANY TABLE', user_name=>'BL_CL_DM');
EXEC system.pckg_grant.grant_proc(grant_name=>'CREATE ANY PROCEDURE', user_name=>'BL_CL_DM');
EXEC system.pckg_grant.grant_proc(grant_name=>'SELECT ANY TABLE', user_name=>'BL_CL_DM');
EXEC system.pckg_grant.grant_proc(grant_name=>'CREATE ANY SEQUENCE', user_name=>'BL_CL_DM');
EXEC system.pckg_grant.grant_proc(grant_name=>'INSERT ANY TABLE', user_name=>'BL_CL_DM');
EXEC system.pckg_grant.grant_proc(grant_name=>'UPDATE ANY TABLE', user_name=>'BL_CL_DM');
EXEC system.pckg_grant.grant_proc(grant_name=>'DELETE ANY TABLE', user_name=>'BL_CL_DM');