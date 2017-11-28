create user BL_CL 
identified by 123456
default tablespace USERS
temporary tablespace TEMP
quota unlimited on USERS
profile DEFAULT;

grant connect to bl_cl;
grant resource to bl_cl;
