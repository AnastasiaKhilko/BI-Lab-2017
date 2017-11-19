CREATE OR REPLACE PACKAGE body pkg_etl_geo
AS
  /**===============================================*\
  Name...............:   pkg_etl_generic
  Contents...........:   Package description
  Author.............:   Author name
  Date...............:   Date of last update
  \*=============================================== */
  /****************************************************/
PROCEDURE load_worlds
IS
BEGIN
    EXECUTE immediate 'truncate table cl_world';
    INSERT INTO cl_world
                (world_id,
                 world_desc)
    SELECT  child_code,
            structure_desc
    FROM sa_src.ext_geo_structure_iso3166
    WHERE structure_level='World';
  COMMIT;

EXCEPTION

WHEN OTHERS THEN
  RAISE;

END load_worlds;

PROCEDURE load_continents
IS
BEGIN
    EXECUTE immediate 'truncate table cl_continents';
    INSERT INTO cl_continents
                (continent_id,
                 continent_desc,
                 world_id)        
    SELECT child_code,
           structure_desc,
           parent_code
    FROM src.ext_geo_structure_iso3166
    WHERE structure_level='Continents';
COMMIT;

EXCEPTION

WHEN OTHERS THEN
  RAISE;

END load_continents;

PROCEDURE load_regions
IS
BEGIN
    EXECUTE immediate 'truncate table cl_regions';
    INSERT INTO cl_regions
                (region_id,
                 region_desc,
                 continent_id)        
    SELECT child_code,
           structure_desc,
           parent_code
    FROM src.ext_geo_structure_iso3166
    WHERE structure_level='Regions';

COMMIT;

EXCEPTION

WHEN OTHERS THEN
  RAISE;

END load_regions;

PROCEDURE load_countries
IS
BEGIN
    EXECUTE immediate 'truncate table cl_countries';
    INSERT INTO cl_countries
                (country_id,
                 country_desc,
                 country_code,
                 region_id)        
    SELECT  country.country_id,
            country.country_desc,
            country.country_code,
            region.STRUCTURE_CODE           
    FROM SA_SRC.EXT_GEO_COUNTRIES_ISO3166 country 
        JOIN  SA_SRC.EXT_CNTR2STRUCTURE_ISO3166 region 
            ON country.COUNTRY_ID=region.COUNTRY_ID;

COMMIT;

EXCEPTION

WHEN OTHERS THEN
  RAISE;

END load_countries;

END pkg_etl_geo;
/ 