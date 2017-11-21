drop table cls_continents;
CREATE
  TABLE cls_continents
  (
    continent_id   NUMBER (3),
    continent_name VARCHAR2 (200 CHAR)
  );
drop table cls_continents;
drop table cls_regions;
drop table cls_countries;

drop table cls_regions;
CREATE
  TABLE cls_regions
  (
    region_id    NUMBER (3),
    region_name  VARCHAR2(200 CHAR),
    continent_id NUMBER (3)
  );
  
drop table cls_countries;
CREATE
  TABLE cls_countries
  (
    country_id   NUMBER (3),
    country_name VARCHAR2 (200 CHAR),
    country_code VARCHAR2 (3),
    region_id    NUMBER (3)
  );