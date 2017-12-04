/**===============================================*\
Name...............:   User BL_CL
Contents...........:   Create user description
Author.............:   Maryna Hlazunova
Date...............:   20-Nov-2017
\*=============================================== */
DROP USER bl_cl CASCADE;
--**********************************************

CREATE USER bl_cl IDENTIFIED BY bl_cl
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
TO bl_cl;*/

GRANT
    CREATE SYNONYM
TO bl_cl;