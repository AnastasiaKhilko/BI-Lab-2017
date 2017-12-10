create user sa_src_task identified by "12345" 
 default tablespace tbs_pdb_task
 QUOTA UNLIMITED ON tbs_pdb_task
 TEMPORARY TABLESPACE temp
 PROFILE default;
create user bl_cl_task identified by "12345" 
 default tablespace tbs_pdb_task
 QUOTA UNLIMITED ON tbs_pdb_task
 TEMPORARY TABLESPACE temp
 PROFILE default;
create user bl_3nf_task identified by "12345" 
 default tablespace tbs_pdb_task
 QUOTA UNLIMITED ON tbs_pdb_task
 TEMPORARY TABLESPACE temp
 PROFILE default;