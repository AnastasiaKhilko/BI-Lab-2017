/**===============================================*\
Name...............:   User SA_SRC
Contents...........:   Create user description
Author.............:   Maryna Hlazunova
Date...............:   20-Nov-2017
\*=============================================== */
DROP USER sa_src CASCADE;
--**********************************************

CREATE USER sa_src IDENTIFIED BY sa_src
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
TO sa_src; */

GRANT
    CREATE SYNONYM
TO sa_src;

GRANT
    CREATE ANY DIRECTORY
TO sa_src;