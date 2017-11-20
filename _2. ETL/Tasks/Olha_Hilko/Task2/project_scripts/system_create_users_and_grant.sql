show user;
CREATE USER BL_CL2 
  IDENTIFIED BY 123456 
  DEFAULT TABLESPACE users 
  QUOTA UNLIMITED ON users 
  TEMPORARY TABLESPACE temp 
  PROFILE default; 

grant create session to BL_CL2;
grant create table to BL_CL2;
grant create procedure to BL_CL2;
grant create sequence  to BL_CL2;


CREATE USER BL_3NF2 
  IDENTIFIED BY 123456 
  DEFAULT TABLESPACE users 
  QUOTA UNLIMITED ON users 
  TEMPORARY TABLESPACE temp 
  PROFILE default; 

grant create session to BL_3NF2;
grant create table to BL_3NF2;
grant create sequence  to BL_3NF2;
--grant create procedure to BL_3NF2;
