-- Create a new tablespace. 
CREATE TABLESPACE tbs_pdb_lab DATAFILE
    'TBS_PDB_LAB.DBF' SIZE 104857600
        AUTOEXTEND ON NEXT 20971520
NOLOGGING SEGMENT SPACE MANAGEMENT AUTO EXTENT MANAGEMENT LOCAL AUTOALLOCATE;

-- SA SRC
-- Create a new user.
create user sa_src_lab identified by "123" default tablespace tbs_pdb_lab;

-- BL_CL
-- Create a new user.
create user bl_cl_lab identified by "123" default tablespace tbs_pdb_lab;

-- BL_3NF
-- Create a new user.
create user bl_3nf_lab identified by "123" default tablespace tbs_pdb_lab;