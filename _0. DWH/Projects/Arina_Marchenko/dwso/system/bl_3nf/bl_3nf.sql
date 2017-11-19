create user my_user 
identified by 123 
default tablespace tbs_pdb_test;

grant connect to my_user;
grant resource to my_user;
grant dba to my_user;

