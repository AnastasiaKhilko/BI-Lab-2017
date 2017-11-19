/**===============================================*\
The order dropping and creating tables is VERY IMPORTANT!!!
/**===============================================*\
Name...............:   Tables 3NF layer
Contents...........:   Create tables and grants description
Author.............:   Maryna Hlazunova
Date...............:   18-Nov-2017
\*=============================================== */
DROP TABLE ce_countries;

DROP TABLE ce_regions;

DROP TABLE ce_continents;

DROP TABLE ce_worlds;
--==============================================================
-- Table: ce_worlds
--==============================================================

CREATE TABLE ce_worlds (
    world_id            NUMBER(5) PRIMARY KEY,
    world_code          NUMBER(10,0),-- child_code
    world_description   VARCHAR2(200 CHAR) -- structure_description
);  
--==============================================================
-- Table: ce_continents
--==============================================================

CREATE TABLE ce_continents (
    continent_id            NUMBER(5) PRIMARY KEY,
    continent_code          NUMBER(10,0),-- child_code
    continent_description   VARCHAR2(200 CHAR),-- structure_description
    world_id                NUMBER(5),
    CONSTRAINT world_id_fk FOREIGN KEY ( world_id )
        REFERENCES ce_worlds ( world_id )
);      
--==============================================================
-- Table: ce_regions
--==============================================================

CREATE TABLE ce_regions (
    region_id            NUMBER(5) PRIMARY KEY,
    region_code          NUMBER(10,0),-- child_code
    region_description   VARCHAR2(200 CHAR),-- structure_description
    continent_id         NUMBER(5),
    CONSTRAINT continent_id_fk FOREIGN KEY ( continent_id )
        REFERENCES ce_continents ( continent_id )
);  
--==============================================================
-- Table: ce_countries
--==============================================================

CREATE TABLE ce_countries (
    country_id            NUMBER(5) PRIMARY KEY,
    country_code          NUMBER(10),
    country_description   VARCHAR2(200 CHAR),
    country_code_iso      VARCHAR2(3),
    region_id             NUMBER(5),
    CONSTRAINT cn_region_id_fk FOREIGN KEY ( region_id )
        REFERENCES ce_regions ( region_id )
);