create user SA_SRC 
identified by 123123
default tablespace USERS
temporary tablespace TEMP
quota unlimited on USERS
profile DEFAULT;

grant 
  create session ,
  create table,
  create view 
to SA_SRC;


