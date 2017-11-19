execute pkg_drop.DROP_Proc ('cls_geo_structure','synonym');
execute pkg_drop.DROP_Proc ('cls_geo_countries','synonym');
execute pkg_drop.DROP_Proc ('cls_cntr2structure','synonym');

execute pkg_drop.drop_proc('nf_world', 'table');
execute pkg_drop.drop_proc('nf_continents', 'table');
execute pkg_drop.drop_proc('nf_regions', 'table');
execute pkg_drop.drop_proc('nf_countries', 'table');

execute pkg_drop.drop_proc('seq_world', 'sequence');
execute pkg_drop.drop_proc('seq_continent', 'sequence');
execute pkg_drop.drop_proc('seq_region', 'sequence');

-------------- Synonyms
CREATE SYNONYM cls_geo_structure FOR bl_cl.cls_geo_structure;
CREATE SYNONYM cls_geo_countries FOR bl_cl.cls_geo_countries;
CREATE SYNONYM cls_cntr2structure FOR bl_cl.cls_cntr2structure;

-------------- Tables
-- World
CREATE TABLE nf_world (
  world_id NUMBER(1) PRIMARY KEY,
  world_code NUMBER(4),
  world_child_code NUMBER(4),
  world_desc VARCHAR(255)
  );

CREATE SEQUENCE seq_world
      INCREMENT BY 1 
          START WITH 1 
       MINVALUE 1 
        NOCYCLE;  
-------------------------------
-- Continents
CREATE TABLE nf_continents (
  continent_id NUMBER(4) PRIMARY KEY,
  continent_code NUMBER(4),
  continent_child_code NUMBER(4),
  continent_desc VARCHAR(255),
  world_id NUMBER(1)
  );

CREATE SEQUENCE seq_continent
      INCREMENT BY 1 
          START WITH 1 
       MINVALUE 1 
        NOCYCLE;   

ALTER TABLE nf_continents 
ADD FOREIGN KEY (world_id) REFERENCES nf_world (world_id) ON DELETE CASCADE;
----------------------------------------------------------------------------------------------------------
-- REGIONS
CREATE TABLE nf_regions (
  region_id NUMBER(4) PRIMARY KEY,
  region_code NUMBER(4),
  region_child_code NUMBER(4),
  region_desc VARCHAR(255),
  continent_id NUMBER(4)
  );

CREATE SEQUENCE seq_region
      INCREMENT BY 1 
          START WITH 1 
       MINVALUE 1 
        NOCYCLE;   

ALTER TABLE nf_regions
ADD FOREIGN KEY (continent_id) REFERENCES nf_continents(continent_id) ON DELETE CASCADE;
----------------------------------------------------------------------------------------------------------   
-- Countries
CREATE TABLE nf_countries (
  country_id NUMBER(4) PRIMARY KEY,
  country_desc VARCHAR2(255),
  country_code VARCHAR(3),
  
  region_id NUMBER(4)
  );

ALTER TABLE nf_countries 
ADD FOREIGN KEY (region_id) REFERENCES nf_regions (region_id) ON DELETE CASCADE;

