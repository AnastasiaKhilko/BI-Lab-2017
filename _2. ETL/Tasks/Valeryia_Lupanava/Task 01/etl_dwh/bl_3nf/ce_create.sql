--Creating CE tables.

CREATE TABLE ce_continents
  (
    continent_id   NUMBER ( 10 ),
    continent_desc VARCHAR2 ( 200 CHAR )
  );
  
CREATE TABLE ce_regions
  (
    region_id    NUMBER ( 10 ),
    region_desc  VARCHAR2(200 CHAR),
    continent_id NUMBER ( 10 )
  );
  
CREATE TABLE ce_countries
  (
    country_id   NUMBER ( 10 ),
    country_desc VARCHAR2 ( 200 CHAR ),
    country_code VARCHAR2 ( 3 ),
    region_id    NUMBER ( 10 )
  );
  
-- Adding constraints.

ALTER TABLE ce_continents
ADD CONSTRAINT continent_id_pk PRIMARY KEY (continent_id);

ALTER TABLE ce_regions
ADD CONSTRAINT region_id_pk PRIMARY KEY (region_id);

ALTER TABLE ce_regions
ADD CONSTRAINT region_id_fk FOREIGN KEY (continent_id)
    REFERENCES ce_continents (continent_id)
        ON DELETE CASCADE;
    
ALTER TABLE ce_countries
ADD CONSTRAINT country_id_pk PRIMARY KEY (country_id);

ALTER TABLE ce_countries
ADD CONSTRAINT cn_region_id_fk FOREIGN KEY (region_id)
    REFERENCES ce_regions (region_id)
        ON DELETE CASCADE;