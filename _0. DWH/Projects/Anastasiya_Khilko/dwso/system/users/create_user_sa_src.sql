create user SA_SRC 
identified by 123123
default tablespace USERS
temporary tablespace TEMP
quota unlimited on USERS
profile DEFAULT;

grant connect to sa_src;
grant resource to sa_src;



