create user bl_dm
identified by 123 
default tablespace tbs_pdb_test;

grant connect to bl_dm;
grant resource to bl_dm;
grant dba to bl_dm;