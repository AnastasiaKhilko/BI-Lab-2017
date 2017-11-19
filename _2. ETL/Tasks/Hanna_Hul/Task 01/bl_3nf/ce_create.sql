
drop table ce_continents;
CREATE
  TABLE ce_continents
  (
    continent_id   NUMBER (3) NOT NULL PRIMARY KEY,
    continent_name VARCHAR2 (200 CHAR) NOT NULL
  );

COMMENT ON TABLE ce_continents
IS
  'Table Content: the list of continrents
   Refresh Cycle/Window: shouldn not be refreshed';

drop table ce_regions;
CREATE TABLE ce_regions
  (
    region_id    NUMBER (3) NOT NULL PRIMARY KEY,
    region_name  VARCHAR2(200 CHAR),
    continent_id NUMBER (3) REFERENCES ce_continents (continent_id)

  );
  
  
drop table ce_countries;
CREATE
  TABLE ce_countries
  (
    country_id   NUMBER (3) not null primary key,
    country_name VARCHAR2 (200 CHAR),
    country_code VARCHAR2 (3),
    region_id    NUMBER (3) REFERENCES ce_regions (region_id)
  );
  
commit;