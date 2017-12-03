create user bl_cl_dm 
identified by 123 
default tablespace tbs_pdb_test;

grant connect to bl_cl_dm;
grant resource to bl_cl_dm;
grant dba to bl_cl_dm;