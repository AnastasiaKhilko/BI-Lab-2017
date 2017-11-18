CREATE USER SRC
  IDENTIFIED BY 123456
  DEFAULT TABLESPACE users
  QUOTA UNLIMITED ON users
  TEMPORARY TABLESPACE temp
  PROFILE default;
  
grant create session to SRC;
EXEC system.grants_mgmt.grant_blat('CREATE ANY TABLE', 'SRC');
EXEC system.grants_mgmt.grant_blat('SELECT ANY TABLE', 'SRC');
EXEC system.grants_mgmt.grant_blat('READ,WRITE ON DIRECTORY ETL', 'SRC');


CREATE USER BL_CL
  IDENTIFIED BY 123456
  DEFAULT TABLESPACE users
  QUOTA UNLIMITED ON users
  TEMPORARY TABLESPACE temp
  PROFILE default;
  
grant create session to BL_CL;
EXEC system.grants_mgmt.grant_blat('CREATE ANY TABLE', 'BL_CL');
EXEC system.grants_mgmt.grant_blat('SELECT ANY TABLE', 'BL_CL');
EXEC system.grants_mgmt.grant_blat('READ,WRITE ON DIRECTORY ETL', 'BL_CL');

exec system.grants_mgmt.grant_blat ('SELECT', 'SRC','ext_geo_countries_iso3166','BL_CL');
exec system.grants_mgmt.grant_blat ('SELECT', 'SRC','ext_geo_structure_iso3166','BL_CL');
exec system.grants_mgmt.grant_blat ('SELECT', 'SRC','ext_cntr2structure_iso3166','BL_CL');
create table 3NF


CREATE USER BL_3NF
  IDENTIFIED BY 123456
  DEFAULT TABLESPACE users
  QUOTA UNLIMITED ON users
  TEMPORARY TABLESPACE temp
  PROFILE default;
  
grant create session to BL_3NF;
EXEC system.grants_mgmt.grant_blat('CREATE ANY TABLE', 'BL_3NF');
EXEC system.grants_mgmt.grant_blat('SELECT ANY TABLE', 'BL_3NF');

exec system.grants_mgmt.grant_blat ('SELECT', 'BL_CL','cl_continents','BL_3NF');
exec system.grants_mgmt.grant_blat ('SELECT', 'BL_CL','cl_countries','BL_3NF');
exec system.grants_mgmt.grant_blat ('SELECT', 'BL_CL','cl_global','BL_3NF');
exec system.grants_mgmt.grant_blat ('SELECT', 'BL_CL','cl_regions','BL_3NF');
