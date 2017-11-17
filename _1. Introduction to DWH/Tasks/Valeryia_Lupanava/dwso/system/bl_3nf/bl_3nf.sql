-- Create a new tablespace. 
CREATE TABLESPACE tbs_pdb_bl_3nf DATAFILE
    'TBS_PDB_001.DBF' SIZE 104857600
        AUTOEXTEND ON NEXT 20971520
NOLOGGING SEGMENT SPACE MANAGEMENT AUTO EXTENT MANAGEMENT LOCAL AUTOALLOCATE;

-- Create a new user.
create user bl_3nf identified by "123" default tablespace tbs_pdb_bl_3nf;

-- Grant Connect Role and Resource Role.
grant connect to bl_3nf;
grant resource to bl_3nf;
grant dba to bl_3nf;
