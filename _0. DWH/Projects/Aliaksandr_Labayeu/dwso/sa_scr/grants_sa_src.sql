-- Grants to sa_src
GRANT CREATE ANY DIRECTORY TO sa_src;
GRANT CONNECT TO sa_src;
GRANT CREATE TABLE TO sa_src;
GRANT READ ON DIRECTORY ext_tables TO sa_src;
GRANT WRITE ON DIRECTORY ext_tables TO sa_src;
GRANT CREATE ANY SYNONYM TO sa_src;
ALTER USER tester1 QUOTA UNLIMITED ON USERS;

-- Grants to bl_cl
GRANT CREATE ANY SYNONYM TO bl_cl;
GRANT CREATE ANY PROCEDURE TO bl_cl;
GRANT SELECT ON sa_src.ext_products TO bl_cl;
GRANT SELECT ON sa_src.ext_consumers TO bl_cl;
GRANT SELECT ON sa_src.ext_departments TO bl_cl;
GRANT SELECT ON sa_src.ext_geo_countries_iso3166 TO bl_cl;
GRANT SELECT ON sa_src.ext_geo_structure_iso3166 TO bl_cl;
GRANT SELECT ON sa_src.ext_cntr2structure_iso3166 TO bl_cl;
