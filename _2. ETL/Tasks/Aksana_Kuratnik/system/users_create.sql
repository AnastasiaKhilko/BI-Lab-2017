CREATE TABLESPACE tbs_etl_lab_1 DATAFILE
    'TBS_PDB_LAB.DBF' SIZE 104857600
        AUTOEXTEND ON NEXT 20971520
NOLOGGING SEGMENT SPACE MANAGEMENT AUTO EXTENT MANAGEMENT LOCAL AUTOALLOCATE;
create user sa_src_1 identified by "123456" default tablespace tbs_etl_lab_1;
create user bl_cl_1 identified by "123456" default tablespace tbs_etl_lab_1;
create user bl_3nf_1 identified by "123456" default tablespace tbs_etl_lab_1;