--DROP PACKAGE pkg_etl_generic;

CREATE OR REPLACE PACKAGE pkg_etl_geo
AS
  /**===============================================*\
  Name...............:   pkg_etl_geo
  Contents...........:   Package loads GEO tables
  Author.............:   Author name
  Date...............:   Date of last update
  \*=============================================== */
  PROCEDURE load_worlds;
  PROCEDURE load_continents;
  PROCEDURE load_regions;
  PROCEDURE load_countries;
END pkg_etl_geo;
/