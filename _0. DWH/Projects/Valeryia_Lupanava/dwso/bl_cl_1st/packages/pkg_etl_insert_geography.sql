CREATE OR REPLACE PACKAGE pkg_etl_insert_geography
AUTHID CURRENT_USER
AS
  PROCEDURE insert_table_continents;
  PROCEDURE insert_table_regions;
  PROCEDURE insert_table_countries;
  PROCEDURE insert_table_cities;
  PROCEDURE merge_table_ce_continents;
  PROCEDURE merge_table_ce_regions;
  PROCEDURE merge_table_ce_countries;
  PROCEDURE merge_table_ce_cities;
  
END pkg_etl_insert_geography;

CREATE OR REPLACE PACKAGE BODY pkg_etl_insert_geography
AS
---------------------------------------------------  
PROCEDURE insert_table_continents
IS
BEGIN
  EXECUTE IMMEDIATE ('TRUNCATE TABLE cls_continents');
  INSERT INTO cls_continents (
                              continent_id,
                              continent_desc
                            )
  SELECT child_code, 
         structure_desc
  FROM   wrk_structures
  WHERE  
         structure_level LIKE 'Continents';

  COMMIT;
  
EXCEPTION
  WHEN OTHERS THEN
  RAISE;

END insert_table_continents;
---------------------------------------------------  
PROCEDURE insert_table_regions
IS
BEGIN
  EXECUTE IMMEDIATE ('TRUNCATE TABLE cls_regions');
  INSERT INTO cls_regions (
                              region_id,
                              region_desc,
                              continent_id
                            )
  SELECT 
         child_code, 
         structure_desc,
         parent_code
  FROM   wrk_structures
  WHERE 
         structure_level LIKE 'Regions';

  COMMIT;
  
EXCEPTION
  WHEN OTHERS THEN
  RAISE;
  
END insert_table_regions;
---------------------------------------------------  
PROCEDURE insert_table_countries
IS
BEGIN
  EXECUTE IMMEDIATE ('TRUNCATE TABLE cls_countries');
  INSERT INTO cls_countries (
                              country_id,
                              country_desc,
                              country_code,
                              region_id
                            )
  SELECT DISTINCT
                  wcs.country_id, 
                  wcs.county_desc,
                  wc.country_code,
                  wcs.structure_code
  FROM            wrk_full_data wcs LEFT JOIN 
                  wrk_countries wc  ON wcs.country_id = wc.country_id;

  COMMIT;
  
EXCEPTION
  WHEN OTHERS THEN
  RAISE;
  
END insert_table_countries;
--------------------------------------------------- 
PROCEDURE insert_table_cities
IS
BEGIN
  EXECUTE IMMEDIATE ('TRUNCATE TABLE cls_cities');
  INSERT INTO cls_cities (
                              city_id,
                              city_desc,
                              country_id
                            )
  SELECT 
        city_id,
        city_desc,
        country_id
  FROM  wrk_cities;

  COMMIT;
  
EXCEPTION
  WHEN OTHERS THEN
  RAISE;
  
END insert_table_cities;
---------------------------------------------------
---------------------------------------------------
PROCEDURE merge_table_ce_continents
IS
BEGIN

MERGE INTO bl_3nf.ce_continents t USING
    ( SELECT continent_id, 
             continent_desc
      FROM   cls_continents
    MINUS
      SELECT continent_srcid AS continent_id,
             continent_desc          
      FROM   bl_3nf.ce_continents
    ) c ON ( c.continent_id = t.continent_srcid )
    WHEN matched THEN
    UPDATE SET t.continent_desc = c.continent_desc 
    WHEN NOT matched THEN
    INSERT
      (
        continent_ID ,
        continent_SRCID ,
        continent_desc
      )
      VALUES
      (
        bl_3nf.ce_continents_seq.NEXTVAL,
        c.continent_ID ,
        c.continent_desc
      ) ;
    COMMIT;
EXCEPTION
WHEN OTHERS THEN
    RAISE;
END merge_table_ce_continents;
---------------------------------------------------
PROCEDURE merge_table_ce_regions
IS
BEGIN

MERGE INTO bl_3nf.ce_regions t USING
    ( SELECT continent_id,
             region_id, 
             region_desc
      FROM   cls_regions
    MINUS
      SELECT continent_srcid,
             region_srcid AS region_id,
             region_desc          
      FROM   bl_3nf.ce_regions
    ) c ON ( c.region_id = t.region_srcid )
    WHEN matched THEN
    UPDATE SET t.region_desc = c.region_desc 
    WHEN NOT matched THEN
    INSERT
      (
        region_ID ,
        region_SRCID ,
        continent_srcid,
        region_desc
      )
      VALUES
      (
        bl_3nf.ce_regions_seq.NEXTVAL,
        c.region_ID ,
        c.continent_id,
        c.region_desc
      ) ;
    COMMIT;
EXCEPTION
WHEN OTHERS THEN
    RAISE;
END merge_table_ce_regions;
---------------------------------------------------
PROCEDURE merge_table_ce_countries
IS
BEGIN

MERGE INTO bl_3nf.ce_countries t USING
    ( SELECT region_id,
             country_id, 
             country_desc
      FROM   cls_countries
    MINUS
      SELECT region_srcid,
             country_srcid AS country_id,
             country_desc          
      FROM   bl_3nf.ce_countries
    ) c ON ( c.country_id = t.country_srcid )
    WHEN matched THEN
    UPDATE SET t.country_desc = c.country_desc 
    WHEN NOT matched THEN
    INSERT
      (
        country_ID ,
        country_SRCID ,
        region_srcid,
        country_desc
      )
      VALUES
      (
        bl_3nf.ce_countries_seq.NEXTVAL,
        c.country_ID ,
        c.region_id,
        c.country_desc
      ) ;
    COMMIT;
EXCEPTION
WHEN OTHERS THEN
    RAISE;
END merge_table_ce_countries;
---------------------------------------------------
PROCEDURE merge_table_ce_cities
IS
BEGIN

MERGE INTO bl_3nf.ce_cities t USING
    ( SELECT country_id,
             city_id, 
             city_desc
      FROM   cls_cities
    MINUS
      SELECT country_srcid,
             city_srcid AS city_id,
             city_desc          
      FROM   bl_3nf.ce_cities
    ) c ON ( c.city_id = t.city_srcid )
    WHEN matched THEN
    UPDATE SET t.city_desc = c.city_desc 
    WHEN NOT matched THEN
    INSERT
      (
        city_ID ,
        city_SRCID ,
        country_srcid,
        city_desc
      )
      VALUES
      (
        bl_3nf.ce_cities_seq.NEXTVAL,
        c.city_ID ,
        c.country_id,
        c.city_desc
      ) ;
    COMMIT;
EXCEPTION
WHEN OTHERS THEN
    RAISE;
END merge_table_ce_cities;
---------------------------------------------------
END pkg_etl_insert_geography;