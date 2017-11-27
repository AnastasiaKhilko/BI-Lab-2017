EXECUTE pckg_drop.drop_proc(object_name=>'bl_3NF',object_type=>'user');

  CREATE USER BL_3NF
  IDENTIFIED BY 123456
  DEFAULT TABLESPACE users
  QUOTA UNLIMITED ON users
  TEMPORARY TABLESPACE temp
  PROFILE default;
  
grant create session to BL_3NF;

  
grant create session to BL_CL;
EXEC system.pckg_grant.grant_proc(grant_name=>'CREATE ANY TABLE', user_name=>'bl_3NF');
EXEC system.pckg_grant.grant_proc(grant_name=>'SELECT ANY TABLE', user_name=>'bl_3NF');
EXEC system.pckg_grant.grant_proc(grant_name=>'CREATE ANY PROCEDURE', user_name=>'bl_3NF');
EXEC system.pckg_grant.grant_proc(grant_name=>'CREATE ANY SEQUENCE', user_name=>'bl_3NF');