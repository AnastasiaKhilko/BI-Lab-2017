CREATE USER BL_CL 
  IDENTIFIED BY 123456 
  DEFAULT TABLESPACE users 
  QUOTA UNLIMITED ON users 
  TEMPORARY TABLESPACE temp 
  PROFILE default; 
--  GRANT conn TO BL_CL;

grant create session to BL_CL;
grant DBA to BL_CL;
GRANT EXECUTE ON grants_mgmt TO BL_CL;

CREATE USER BL_3NF 
  IDENTIFIED BY 123456 
  DEFAULT TABLESPACE users 
  QUOTA UNLIMITED ON users 
  TEMPORARY TABLESPACE temp 
  PROFILE default; 
--  GRANT conn TO BL_3NF;
grant create session to BL_3NF;
--GRANT EXECUTE ON grants_mgmt TO BL_3NF;

CREATE USER BL_CL_DWH 
  IDENTIFIED BY 123456 
  DEFAULT TABLESPACE users 
  QUOTA UNLIMITED ON users 
  TEMPORARY TABLESPACE temp 
  PROFILE default; 
--  GRANT conn TO BL_CL_DWH;
  
grant create session to BL_CL_DWH;
grant DBA to BL_CL_DWH;
GRANT EXECUTE ON grants_mgmt TO BL_CL_DWH;
--revoke EXECUTE on grants_mgmt from BL_CL_DWH;

CREATE USER BL_DM
  IDENTIFIED BY 123456 
  DEFAULT TABLESPACE users 
  QUOTA UNLIMITED ON users 
  TEMPORARY TABLESPACE temp 
  PROFILE default; 
--  GRANT conn TO BL_DM;
  
grant create session to BL_DM;

/*
examples of procedure calling
EXEC system.grants_mgmt.grant_blat('CREATE ANY TABLE', 'BL_CL');
EXEC system.grants_mgmt.grant_blat('SELECT ANY TABLE', 'BL_CL', true);
exec system.grants_mgmt.grant_blat ('alter', 'scott','emp','BL_CL');
*/

/*drop user BL_CL;
drop user BL_3NF;
drop user BL_CL_DWH;
drop user BL_DM;*/