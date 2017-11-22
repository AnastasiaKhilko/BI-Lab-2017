/**===============================================*\
Name...............:   Users
Contents...........:   Create users and grants description
Author.............:   Maryna Hlazunova
Date...............:   21-Nov-2017
\*=============================================== */

--==============================================================
-- USER SA_SRC
--==============================================================
DROP USER SA_SRC;
--**********************************************
CREATE USER SA_SRC IDENTIFIED BY SA_SRC
    DEFAULT TABLESPACE users
    QUOTA UNLIMITED ON users
    TEMPORARY TABLESPACE temp
    PROFILE default;

-- GRANTS

GRANT connect TO sa_src;

GRANT resource TO sa_src;

/*GRANT
    CREATE MATERIALIZED VIEW
TO sa_src;

GRANT
    CREATE VIEW
TO sa_src;

GRANT
    CREATE SYNONYM
TO sa_src; 

GRANT
    CREATE ANY DIRECTORY
TO sa_src; */


--==============================================================
-- USER BL_CL
--==============================================================
DROP USER bl_cl;
--**********************************************
CREATE USER BL_CL IDENTIFIED BY BL_CL
    DEFAULT TABLESPACE users
    QUOTA UNLIMITED ON users
    TEMPORARY TABLESPACE temp
    PROFILE default;

-- GRANTS  

GRANT connect TO bl_cl;

GRANT resource TO bl_cl;

/*GRANT
    CREATE MATERIALIZED VIEW
TO bl_cl;

GRANT
    CREATE VIEW
TO bl_cl;

GRANT
    CREATE SYNONYM
TO bl_cl; */

--==============================================================
-- USER BL_3NF
--==============================================================
DROP USER bl_3nf;
--**********************************************
CREATE USER BL_3NF IDENTIFIED BY BL_3NF
    DEFAULT TABLESPACE users
    QUOTA UNLIMITED ON users
    TEMPORARY TABLESPACE temp
    PROFILE default;

-- GRANTS

GRANT connect TO bl_3nf;

GRANT resource TO bl_3nf;

/*GRANT
    CREATE MATERIALIZED VIEW
TO bl_3nf;

GRANT
    CREATE VIEW
TO bl_3nf;

GRANT
    CREATE SYNONYM
TO bl_3nf; */

--==============================================================
-- USER BL_DWH
--==============================================================
DROP USER bl_dwh;
--**********************************************
CREATE USER BL_DWH IDENTIFIED BY BL_DWH
    DEFAULT TABLESPACE users
    QUOTA UNLIMITED ON users
    TEMPORARY TABLESPACE temp
    PROFILE default;

-- GRANTS  

GRANT connect TO bl_dwh;

GRANT resource TO bl_dwh;

/*GRANT
    CREATE MATERIALIZED VIEW
TO bl_dwh;

GRANT
    CREATE VIEW
TO bl_dwh;

GRANT
    CREATE SYNONYM
TO bl_dwh; */