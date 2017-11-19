/**===============================================*\
Name...............:   Tables CLS слоя
Contents...........:   Create tables and grants description
Author.............:   Maryna Hlazunova
Date...............:   18-Nov-2017
\*=============================================== */
DROP TABLE cls_geo_countries;

DROP TABLE cls_geo_structure;

DROP TABLE cls_cnt_structure;
--==============================================================
-- Table: cls_geo_countries
--==============================================================

CREATE TABLE cls_geo_countries (
    country_id     NUMBER(10),
    country_desc   VARCHAR2(200 CHAR),
    country_code   VARCHAR2(3)
);
                 
--==============================================================
-- Table: cls_geo_structure                           
--==============================================================

CREATE TABLE cls_geo_structure (
    child_code        NUMBER(10,0),
    parent_code       NUMBER(10,0),
    structure_desc    VARCHAR2(200 CHAR),
    structure_level   VARCHAR2(200 CHAR)
);
 
--==============================================================
-- Table: cls_cnt_structure
--==============================================================

CREATE TABLE cls_cnt_structure (
    country_id       NUMBER(10,0),
    county_desc      VARCHAR2(200 CHAR),
    structure_code   NUMBER(10,0),
    structure_desc   VARCHAR2(200 CHAR)
);
--==============================================================
-- Grants
--==============================================================

GRANT SELECT ON cls_geo_structure TO bl_3nf_test;

GRANT SELECT ON cls_geo_countries TO bl_3nf_test;

GRANT SELECT ON cls_cnt_structure TO bl_3nf_test;