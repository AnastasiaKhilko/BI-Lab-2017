-- Create a new tablespace. 
CREATE TABLESPACE tbs_pdb_bl_cl DATAFILE
    'TBS_PDB_003.DBF' SIZE 104857600
        AUTOEXTEND ON NEXT 20971520
NOLOGGING SEGMENT SPACE MANAGEMENT AUTO EXTENT MANAGEMENT LOCAL AUTOALLOCATE;

-- Create a new user.
create user bl_cl identified by Q1w2e3r4 default tablespace tbs_pdb_bl_cl;

-- Grant Connect Role and Resource Role.
grant connect to bl_cl;
grant resource to bl_cl;
grant dba to bl_cl;