CREATE TABLE cl_world
  (
    world_id   NUMBER(10,0),
    world_desc VARCHAR2 ( 200 CHAR )
  );

CREATE TABLE cl_continents
  (
    continent_id   NUMBER(10,0),
    continent_desc VARCHAR2 ( 200 CHAR ),
    global_id      NUMBER(10,0)
  );

CREATE TABLE cl_regions
  (
    region_id    NUMBER(10,0),
    region_desc  VARCHAR2 ( 200 CHAR ),
    continent_id NUMBER(10,0)
  );

CREATE TABLE cl_countries(
  country_id NUMBER(10,0),
  country_desc VARCHAR2 ( 200 CHAR ),
  country_code VARCHAR2 ( 200 CHAR ),
  region_id NUMBER(10,0)
  );
  
  CREATE OR REPLACE PACKAGE pkg_etl_geo
AS
  PROCEDURE load_worlds;
  PROCEDURE load_continents;
  PROCEDURE load_regions;
  PROCEDURE load_countries;
END pkg_etl_geo;
/

CREATE OR REPLACE PACKAGE body pkg_etl_geo as
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
                 global_id)        
    SELECT child_code,
           structure_desc,
           parent_code
    FROM sa_src.ext_geo_structure_iso3166
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
    FROM sa_src.ext_geo_structure_iso3166
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


EXEC PKG_ETL_GEO.load_worlds;
EXEC PKG_ETL_GEO.load_continents;
EXEC PKG_ETL_GEO.load_regions;
EXEC PKG_ETL_GEO.load_countries;

CREATE DIRECTORY ext_tables
as '/media/sf_DWH/src';

-------------------------------------------
drop table ce_worlds cascade constraints;
CREATE TABLE ce_worlds
  (
    world_id   NUMBER(10,0) PRIMARY KEY ,
    world_desc VARCHAR2 ( 200 CHAR ) NOT NULL
  );
drop table ce_regions cascade constraints;
CREATE TABLE ce_regions
  (
    region_id    NUMBER(10,0) PRIMARY KEY,
    region_desc  VARCHAR2 ( 200 CHAR ) NOT NULL,
    continent_id NUMBER(10,0) NOT NULL
  );
Alter table ce_regions ADD CONSTRAINT FK_continent_id FOREIGN KEY (continent_id) 
        REFERENCES ce_continents(continent_id);
        
drop table ce_countries cascade constraints;
CREATE TABLE ce_countries
  (
    country_id   NUMBER(10,0) PRIMARY KEY NOT NULL,
    country_desc VARCHAR2 ( 200 CHAR ) NOT NULL,
    country_code VARCHAR2 ( 3 ),
    region_id    NUMBER(10,0)NOT NULL);
Alter table ce_countries add CONSTRAINT FK_country_id FOREIGN KEY (region_id) 
        REFERENCES ce_regions(region_id);

drop table ce_continents cascade constraints;
CREATE TABLE ce_continents
  (
    continent_id   NUMBER(10,0) PRIMARY KEY ,
    continent_desc VARCHAR2 ( 200 CHAR ) NOT NULL,
    world_id NUMBER(10,0) NOT NULL);
    
Alter table ce_continents add CONSTRAINT FK_world_id FOREIGN KEY (world_id) 
        REFERENCES ce_worlds (world_id) ;

INSERT INTO ce_worlds
                (world_id,
                 world_desc)
    SELECT  world_id,
            world_desc
    FROM bl_cl.cl_world;
    
INSERT INTO ce_continents
                (continent_id,
                 continent_desc,
                 world_id)        
    SELECT continent_id,
           continent_desc,
           global_id
    FROM bl_cl.cl_continents;

INSERT INTO ce_regions
                (region_id,
                 region_desc,
                 continent_id)        
    SELECT region_id,
           region_desc,
           continent_id
    FROM bl_cl.cl_regions;
    
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



