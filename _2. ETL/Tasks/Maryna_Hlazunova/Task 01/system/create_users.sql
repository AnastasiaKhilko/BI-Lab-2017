/**===============================================*\
Name...............:   Users
Contents...........:   Create users and grants description
Author.............:   Maryna Hlazunova
Date...............:   18-Nov-2017
\*=============================================== */
DROP USER sa_src_test;

DROP USER bl_cl_test;

DROP USER bl_3nf_test;

DROP USER bl_dwh_test;
--==============================================================
-- USER SA_SRC_TEST
--==============================================================

CREATE USER SA_SRC_TEST IDENTIFIED BY SA_SRC_TEST
    DEFAULT TABLESPACE users
    QUOTA UNLIMITED ON users
    TEMPORARY TABLESPACE temp
    PROFILE default;

-- GRANTS

GRANT connect TO sa_src_test;

GRANT resource TO sa_src_test;

GRANT
    CREATE MATERIALIZED VIEW
TO sa_src_test;

GRANT
    CREATE VIEW
TO sa_src_test;

GRANT
    CREATE SYNONYM
TO sa_src_test;

GRANT
    CREATE ANY DIRECTORY
TO sa_src_test;

--==============================================================
-- USER BL_CL_TEST
--==============================================================

CREATE USER Bl_Cl_Test IDENTIFIED BY BL_CL_TEST
    DEFAULT TABLESPACE users
    QUOTA UNLIMITED ON users
    TEMPORARY TABLESPACE temp
    PROFILE default;

-- GRANTS  

GRANT connect TO bl_cl_test;

GRANT resource TO bl_cl_test;

GRANT
    CREATE MATERIALIZED VIEW
TO bl_cl_test;

GRANT
    CREATE VIEW
TO bl_cl_test;

GRANT
    CREATE SYNONYM
TO bl_cl_test;

--==============================================================
-- USER BL_3NF_TEST
--==============================================================

CREATE USER BL_3NF_TEST IDENTIFIED BY BL_3NF_TEST
    DEFAULT TABLESPACE users
    QUOTA UNLIMITED ON users
    TEMPORARY TABLESPACE temp
    PROFILE default;

-- GRANTS

GRANT connect TO bl_3nf_test;

GRANT resource TO bl_3nf_test;

GRANT
    CREATE MATERIALIZED VIEW
TO bl_3nf_test;

GRANT
    CREATE VIEW
TO bl_3nf_test;

GRANT
    CREATE SYNONYM
TO bl_3nf_test;

--==============================================================
-- USER BL_DWH_TEST
--==============================================================

CREATE USER BL_DWH_TEST IDENTIFIED BY BL_DWH_TEST
    DEFAULT TABLESPACE users
    QUOTA UNLIMITED ON users
    TEMPORARY TABLESPACE temp
    PROFILE default;

-- GRANTS  

GRANT connect TO bl_dwh_test;

GRANT resource TO bl_dwh_test;

GRANT
    CREATE MATERIALIZED VIEW
TO bl_dwh_test;

GRANT
    CREATE VIEW
TO bl_dwh_test;

GRANT
    CREATE SYNONYM
TO bl_dwh_test;