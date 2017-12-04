/**===============================================*\
Name...............:   User BL_CL_DWH
Contents...........:   Create user description
Author.............:   Maryna Hlazunova
Date...............:   01-Dec-2017
\*=============================================== */
DROP USER bl_cl_dwh CASCADE;
--**********************************************

CREATE USER bl_cl_dwh IDENTIFIED BY bl_cl_dwh
    DEFAULT TABLESPACE users
    QUOTA UNLIMITED ON users
    TEMPORARY TABLESPACE temp
    PROFILE default;

-- GRANTS  

GRANT connect TO bl_cl_dwh;

GRANT resource TO bl_cl_dwh;

/*GRANT
    CREATE MATERIALIZED VIEW
TO BL_CL_DWH;

GRANT
    CREATE VIEW
TO BL_CL_DWH;*/

GRANT
    CREATE SYNONYM
TO bl_cl_dwh;