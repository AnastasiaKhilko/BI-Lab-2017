create user bl_cl
identified by 123 
default tablespace tbs_pdb_test;

grant connect to bl_cl;
grant resource to bl_cl;
grant dba to bl_cl;