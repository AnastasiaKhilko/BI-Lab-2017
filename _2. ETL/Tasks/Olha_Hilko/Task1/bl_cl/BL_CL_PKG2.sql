
CREATE OR REPLACE PACKAGE PKG_WKR_TO_CL AS
  PROCEDURE WRK_TO_CL_Continents;
  PROCEDURE WRK_TO_CL_Regions;
  PROCEDURE WRK_TO_CL_Countries;
END PKG_WKR_TO_CL;
/
CREATE OR REPLACE PACKAGE BODY PKG_WKR_TO_CL AS
  PROCEDURE WRK_TO_CL_Continents
    IS
      BEGIN
        execute immediate 'truncate table cl_Continents';
        INSERT INTO cl_Continents(continent_id, continent_name)
        SELECT  child_code, structure_desc
        FROM wrk_geo_structure_iso3166 
        WHERE structure_level = 'Continents';
    END WRK_TO_CL_Continents;
  PROCEDURE WRK_TO_CL_Regions 
     IS
       BEGIN
        execute immediate 'truncate table cl_Regions';
        INSERT INTO cl_Regions (Region_id, Region_name, Continent_id)
        SELECT child_code, structure_desc, parent_code
        FROM wrk_geo_structure_iso3166
        WHERE structure_level = 'Regions';
    END WRK_TO_CL_Regions;
   PROCEDURE WRK_TO_CL_Countries
    IS
      BEGIN
        execute immediate 'truncate table cl_Countries';
        INSERT INTO cl_Countries (Country_id, country_name, country_code, region_id)
        SELECT t1.country_id, t1.country_desc, t1.country_code, t2.structure_code
        FROM
          (SELECT * FROM wrk_geo_countries_iso3166) t1
        JOIN 
          (SELECT * FROM wrk_cntr2structure_iso3166) t2
        ON t1.country_id = t2.country_id;
    END WRK_TO_CL_Countries;
END PKG_WKR_TO_CL;
/
     -- ROLLBACK;

