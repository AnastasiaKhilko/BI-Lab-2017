create user BL_CL_DM 
identified by blcldm
default tablespace USERS
temporary tablespace TEMP
quota unlimited on USERS
profile DEFAULT;

grant 
  connect ,
  resource
to BL_CL_DM;
