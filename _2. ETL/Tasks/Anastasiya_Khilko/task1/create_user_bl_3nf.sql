create user BL_3NF 
identified by 54321
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
to BL_3NF;