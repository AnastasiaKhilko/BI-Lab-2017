-- Create a new tablespace. 
CREATE TABLESPACE tbs_pdb_bl_dm DATAFILE
    'TBS_PDB_002.DBF' SIZE 104857600
        AUTOEXTEND ON NEXT 20971520
NOLOGGING SEGMENT SPACE MANAGEMENT AUTO EXTENT MANAGEMENT LOCAL AUTOALLOCATE;

-- Create a new user.
create user bl_dm identified by "123" default tablespace tbs_pdb_bl_dm;

-- Grant Connect Role and Resource Role.
grant connect to bl_dm;
grant resource to bl_dm;
grant dba to bl_dm;