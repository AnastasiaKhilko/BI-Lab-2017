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
  create sequence,
  select on bl_cl.cls_countries,
  select on bl_cl.cls_geo_structure,
  select on bl_cl.cls_structure
to BL_3NF;

