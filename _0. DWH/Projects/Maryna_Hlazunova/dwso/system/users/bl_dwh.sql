/**===============================================*\
Name...............:   User BL_DWH
Contents...........:   Create user description
Author.............:   Maryna Hlazunova
Date...............:   20-Nov-2017
\*=============================================== */
DROP USER bl_dwh CASCADE;
--**********************************************

CREATE USER bl_dwh IDENTIFIED BY bl_dwh
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