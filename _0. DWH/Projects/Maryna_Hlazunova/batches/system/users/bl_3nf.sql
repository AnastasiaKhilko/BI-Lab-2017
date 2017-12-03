/**===============================================*\
Name...............:   User BL_3NF
Contents...........:   Create user description
Author.............:   Maryna Hlazunova
Date...............:   20-Nov-2017
\*=============================================== */
DROP USER bl_3nf CASCADE;
--**********************************************

CREATE USER bl_3nf IDENTIFIED BY bl_3nf
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
TO bl_3nf; */

GRANT
    CREATE SYNONYM
TO bl_3nf;