create user sa_src
identified by 123 
default tablespace tbs_pdb_test;

grant connect to sa_src;
grant resource to sa_src;
grant dba to sa_rsc;