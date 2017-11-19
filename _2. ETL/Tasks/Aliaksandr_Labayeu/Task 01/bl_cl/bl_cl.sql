-- DROPPING synonyms
execute pkg_drop.DROP_Proc ('EXT_GEO_countries_ISO3166','synonym');
execute pkg_drop.DROP_Proc ('EXT_GEO_STRUCTURE_ISO3166','synonym');
execute pkg_drop.DROP_Proc ('EXT_GEO_cntr2structure_ISO3166','synonym');
-- DROPPING tables
execute pkg_drop.DROP_Proc('cls_geo_countries','table');
execute pkg_drop.DROP_Proc('cls_geo_structure','table');
execute pkg_drop.DROP_Proc('cls_cntr2structure','table');

CREATE SYNONYM EXT_GEO_countries_ISO3166 FOR sa_src.ext_geo_countries_iso3166;
CREATE SYNONYM EXT_GEO_STRUCTURE_ISO3166 FOR sa_src.ext_geo_structure_iso3166;
CREATE SYNONYM EXT_GEO_cntr2structure_ISO3166 FOR sa_src.ext_cntr2structure_iso3166;

CREATE TABLE cls_geo_countries (
  country_id number(4),
  country_desc char(200),
  country_code char(3) 
  );

CREATE TABLE cls_geo_structure (
  Achild_code number (4),
  parent_code number,
  structure_desc char(200),
  structure_level char(200) 
  );
  
CREATE TABLE cls_cntr2structure (
  country_id number(4),
  county_desc char(200),
  structure_code number,
  structure_desc char(200) 
  );
