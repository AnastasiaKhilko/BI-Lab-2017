create user BL_DM
identified by bldm
default tablespace USERS
temporary tablespace TEMP
quota unlimited on USERS
profile DEFAULT;

grant connect to BL_DM;
grant resource to BL_DM;