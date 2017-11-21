--DROP PACKAGE pkg_etl_generic;

CREATE OR REPLACE PACKAGE pkg_etl_ce_geo
AS
  /**===============================================*\
  Name...............:   pkg_etl_geo
  Contents...........:   Package loads GEO tables
  Author.............:   Author name
  Date...............:   Date of last update
  \*=============================================== */
  PROCEDURE ce_load_worlds;
  PROCEDURE ce_load_continents;
  PROCEDURE ce_load_regions;
  PROCEDURE ce_load_countries;
END pkg_etl_ce_geo;
/