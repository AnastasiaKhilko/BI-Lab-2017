CREATE TABLESPACE TBS_PDB_TEST
  DATAFILE 
  'PDB_TEST_001.DBF' SIZE 104857600 AUTOEXTEND ON NEXT 20971520
  NOLOGGING
  SEGMENT SPACE MANAGEMENT AUTO
  EXTENT MANAGEMENT LOCAL AUTOALLOCATE;
  
create user user1 identified by TBS_PDB_TEST default tablespace tbs_pdb_test;
grant all on bl_3nf.ce_sources to bl_cl;
grant all on bl_3nf.ce_customers to bl_cl;
grant all on bl_3nf.ce_banks to bl_cl;
grant all on bl_3nf.ce_cards to bl_cl;
grant all on bl_3nf.ce_card_types to bl_cl;
grant all on bl_3nf.ce_hotels to bl_cl;


grant connect to user1;
grant resource to user1;
grant dba to user1;
grant select on scott.dept to user1;
grant select on scott.emp to user1;
set serveroutput on;
grant create sequence to bl_cl;
grant insert on bl_3nf.ce_sources to bl_cl;
grant create table to bl_3nf;
select * from bl_cl.cls_sources;
select * from bl_3nf.ce_sources;

create user bl_cl_2 identified by 123456;
grant connect to bl_cl_2;
grant resource to bl_cl_2;
grant all on bl_3nf.ce_sources to bl_cl;