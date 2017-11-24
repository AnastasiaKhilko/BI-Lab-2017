-- DROPPING synonyms
execute pkg_drop.DROP_Proc ('EXT_GEO_countries_ISO3166','synonym');
execute pkg_drop.DROP_Proc ('EXT_GEO_STRUCTURE_ISO3166','synonym');
execute pkg_drop.DROP_Proc ('EXT_GEO_cntr2structure_ISO3166','synonym');
execute pkg_drop.DROP_Proc ('EXT_PRODUCTS','synonym');
execute pkg_drop.DROP_Proc ('EXT_CONSUMERS','synonym');
execute pkg_drop.DROP_Proc ('EXT_DEPARTMENTS','synonym');
-- DROPPING tables
execute pkg_drop.DROP_Proc('cls_geo_countries','table');
execute pkg_drop.DROP_Proc('cls_geo_structure','table');
execute pkg_drop.DROP_Proc('cls_cntr2structure','table');
execute pkg_drop.DROP_Proc('cls_products','table');
execute pkg_drop.DROP_Proc('cls_consumers','table');
execute pkg_drop.DROP_Proc('cls_departments','table');

CREATE SYNONYM EXT_GEO_countries_ISO3166 FOR sa_src.ext_geo_countries_iso3166;
CREATE SYNONYM EXT_GEO_STRUCTURE_ISO3166 FOR sa_src.ext_geo_structure_iso3166;
CREATE SYNONYM EXT_GEO_cntr2structure_ISO3166 FOR sa_src.ext_cntr2structure_iso3166;
CREATE SYNONYM EXT_PRODUCTS FOR sa_src.ext_products;
CREATE SYNONYM EXT_CONSUMERS FOR sa_src.ext_consumers;
CREATE SYNONYM EXT_DEPARTMENTS FOR sa_src.ext_departments;

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

CREATE TABLE cls_products
    (
    product VARCHAR2(100),
    prod_category VARCHAR2(100),
    subcategory VARCHAR2(100),
    localization VARCHAR2(100),
    tobacco NUMBER(8,2),
    prod_size NUMBER(4),
    prod_price NUMBER(8,2)
    );

CREATE TABLE cls_consumers
    (
     cons_id NUMBER(5),
     gender VARCHAR2(10),
     FullName VARCHAR2(255),
     StreetAddress VARCHAR2(255),
     City	VARCHAR2(50),
     State VARCHAR2(50),
     StateFull VARCHAR(50),
     ZipCode VARCHAR(10),
     Country_CODE	VARCHAR2(2),
     Country	VARCHAR2(20),
     EmailAddress VARCHAR2(50),
     TelephoneNumber	VARCHAR2(50),
     TelephoneCountryCode	NUMBER(4),
     Birthday VARCHAR2(20),
     Age	NUMBER(3),
     CCType	VARCHAR2(20),
     CCExpires	VARCHAR2(20),
     WesternUnionMTCN	NUMBER(10),
     Color	VARCHAR2(10),
     Occupation	VARCHAR(20),
     Company	VARCHAR2(30)
     );

CREATE TABLE cls_departments
    (
     dep_id NUMBER(3),
     department VARCHAR(100),
     Country VARCHAR2(50),
     City VARCHAR2(50),
     StreetAddress VARCHAR2(255),
     StateFull	VARCHAR2(50),
     State_CODE VARCHAR2(2),
     Country_CODE	VARCHAR2(2),
     ZipCode	VARCHAR(20),
     UPS	VARCHAR(30),
     TelephoneNumber VARCHAR(40)
     );