create user BL_CL 
identified by 123456
default tablespace USERS
temporary tablespace TEMP
quota unlimited on USERS
profile DEFAULT;

grant 
  create session ,
  create table,
  create view,
  create synonym,
  create procedure,
  create sequence
to BL_CL;