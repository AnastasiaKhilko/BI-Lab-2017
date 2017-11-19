
CREATE OR REPLACE PACKAGE PKG_SRC_TO_WRK AS
  PROCEDURE SRC_TO_WRK;
 
END PKG_SRC_TO_WRK;
/
CREATE OR REPLACE PACKAGE BODY PKG_SRC_TO_WRK AS
  PROCEDURE SRC_TO_WRK
    IS
      BEGIN
        execute immediate 'TRUNCATE TABLE wrk_geo_countries_iso3166';
        INSERT INTO  wrk_geo_countries_iso3166 SELECT * FROM SRC.ext_geo_countries_iso3166;
        execute immediate 'TRUNCATE TABLE wrk_geo_structure_iso3166';
        INSERT INTO  wrk_geo_structure_iso3166 SELECT * FROM SRC.ext_geo_structure_iso3166;
        execute immediate 'TRUNCATE TABLE wrk_cntr2structure_iso3166';
        INSERT INTO  wrk_cntr2structure_iso3166 SELECT * FROM SRC.ext_cntr2structure_iso3166;
   END SRC_TO_WRK;
END PKG_SRC_TO_WRK;