CREATE OR REPLACE PACKAGE body pkg_etl_ce_geo
AS
  /**===============================================*\
  Name...............:   pkg_etl_generic
  Contents...........:   Package description
  Author.............:   Author name
  Date...............:   Date of last update
  \*=============================================== */
  /****************************************************/
PROCEDURE ce_load_worlds
IS
BEGIN
    EXECUTE immediate 'truncate table ce_worlds';
    INSERT INTO ce_worlds
                (world_id,
                 world_desc)
    SELECT  world_id,
            world_desc
    FROM bl_cl.cl_world;
  COMMIT;

EXCEPTION

WHEN OTHERS THEN
  RAISE;

END ce_load_worlds;

PROCEDURE ce_load_continents
IS
BEGIN
    EXECUTE immediate 'truncate table ce_continents';
    INSERT INTO ce_continents
                (continent_id,
                 continent_desc,
                 world_id)        
    SELECT continent_id,
           continent_desc,
           world_id
    FROM bl_cl.cl_continents;
COMMIT;

EXCEPTION

WHEN OTHERS THEN
  RAISE;

END ce_load_continents;

PROCEDURE ce_load_regions
IS
BEGIN
    EXECUTE immediate 'truncate table ce_regions';
    INSERT INTO ce_regions
                (region_id,
                 region_desc,
                 continent_id)        
    SELECT region_id,
           region_desc,
           continent_id
    FROM bl_cl.cl_regions;

COMMIT;

EXCEPTION

WHEN OTHERS THEN
  RAISE;

END ce_load_regions;

PROCEDURE ce_load_countries
IS
BEGIN
    EXECUTE immediate 'truncate table ce_countries';
    INSERT INTO ce_countries
                (country_id,
                 country_desc,
                 country_code,
                 region_id)        
    SELECT  country_id,
            country_desc,
            country_code,
            region_id          
    FROM bl_cl.cl_countries;

COMMIT;

EXCEPTION

WHEN OTHERS THEN
  RAISE;

END ce_load_countries;

END pkg_etl_ce_geo;
/ 